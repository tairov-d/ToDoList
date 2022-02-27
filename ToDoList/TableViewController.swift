//
//  TableViewController.swift
//  ToDoList
//
//  Created by Daniel on 24/2/22.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBAction func pushEditAction(_ sender: Any) {
        
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    @IBAction func pushAddAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Create new item", message: nil, preferredStyle: .alert)
        alertController.addTextField { UITextField in
            UITextField.placeholder = "New Item Name"
        }
        
        let alertAction1 = UIAlertAction(title: "Cancel", style: .default) { (alert) in
            
        }
        
        let alertAction2 = UIAlertAction(title: "Create", style: .cancel) { (alert) in
            
            let newItem = alertController.textFields![0].text
            addItem(nameItem: newItem!)
            self.tableView.reloadData()
        }
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let currentItem = ToDoItems[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String
        
        if (currentItem["isCompleted"] as? Bool) == true {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { action, indexPath in
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        let edit = UITableViewRowAction(style: .default, title: "Edit") { action, indexPath in
            let alertController = UIAlertController(title: "Change item", message: "Edit", preferredStyle: .alert)
            alertController.addTextField { textfield in
                textfield.text = ToDoItems[indexPath.row]["Name"] as? String
            }
            
            let alertAction1 = UIAlertAction(title: "Cancel", style: .default) { (alert) in
                
            }
            
            let alertAction2 = UIAlertAction(title: "Change", style: .cancel) { (alert) in
                
                let newItem = alertController.textFields![0].text
                ToDoItems[indexPath.row]["Name"] = newItem
                self.tableView.reloadData()
            }
            
            alertController.addAction(alertAction1)
            alertController.addAction(alertAction2)
            
            self.present(alertController, animated: true, completion: nil)
        }
        edit.backgroundColor = .black
        return [delete, edit]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        tableView.reloadData()
    }
    
}
