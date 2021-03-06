//
//  TableViewController.swift
//  Chapter2IndexedTableView
//
//  Created by Yohannes Wijaya on 1/25/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    // MARK: - Stored Properties
    
    let tableViewCellIdentifier = "TableViewCellIdentifier"
    
    let animals = ["Bear", "Black Swan", "Buffalo", "Camel", "Cockatoo", "Dog", "Donkey", "Emu", "Giraffe", "Greater Rhea", "Hippopotamus", "Horse", "Koala", "Lion", "Llama", "Manatus", "Meerkat", "Panda", "Peacock", "Pig", "Platypus", "Polar Bear", "Rhinoceros", "Seagull", "Tasmania Devil", "Whale", "Whale Shark", "Wombat"]
    let animalIndexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var animalsDictionary = Dictionary<String, Array<String>>()
    var animalSectionTitles: [String] = []
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.tableViewCellIdentifier)
        
        self.title = "Animals"
        
        self.createAnimalsDictionary()
        
        self.tableView.sectionIndexColor = UIColor.orangeColor()
    }

    // MARK: - UITableViewDataSource Methods

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.animalSectionTitles.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let animalNamePrefixAsKey = self.animalSectionTitles[section]
        guard let validAnimalArrayForKey = self.animalsDictionary[animalNamePrefixAsKey] else { return 0 }
        return validAnimalArrayForKey.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.tableViewCellIdentifier, forIndexPath: indexPath)
        let animalNamePrefixAsKey = self.animalSectionTitles[indexPath.section]
        guard let validAnimalArrayForKey = self.animalsDictionary[animalNamePrefixAsKey] else { return cell }
        cell.textLabel?.text = validAnimalArrayForKey[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 18.0)
        cell.textLabel?.textColor = UIColor.orangeColor()
        
        
        let filePathToAnimalImage = validAnimalArrayForKey[indexPath.row].lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "_")
        cell.imageView?.image = UIImage(named: filePathToAnimalImage)
        
        return cell
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return self.animalIndexTitles
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        guard let validIndex = self.animalSectionTitles.indexOf(title) else { return -1 }
        return validIndex
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.animalSectionTitles[section]
    }
    
    // MARK: UITableViewDelegate Methods
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.textColor = UIColor.orangeColor()
        headerView.textLabel?.font = UIFont(name: "Avenir Next", size: 25.0)
    }

    // MARK: - Helper Methods
    
    private func createAnimalsDictionary() {
        guard self.animals.count > 0 else { return }
        
        for animal in self.animals {
            let animalNamePrefixAsDictionaryKey = animal.substringToIndex(animal.startIndex.advancedBy(1))
            
            if var validAnimalsArrayForKey = self.animalsDictionary[animalNamePrefixAsDictionaryKey] {
                validAnimalsArrayForKey.append(animal)
                self.animalsDictionary[animalNamePrefixAsDictionaryKey] = validAnimalsArrayForKey
            }
            else {
                self.animalsDictionary[animalNamePrefixAsDictionaryKey] = [animal]
            }
        }
//        self.animalSectionTitles = [String](self.animalsDictionary.keys)
        self.animalSectionTitles.insertContentsOf(self.animalsDictionary.keys, at: 0)
        self.animalSectionTitles.sortInPlace { (s1: String, s2: String) -> Bool in
            return s1 < s2
        }
    }
}
