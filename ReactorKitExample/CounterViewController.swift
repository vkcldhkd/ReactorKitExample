//
//  ViewController.swift
//  ReactorKitExample
//
//  Created by BV on 2018. 5. 30..
//  Copyright © 2018년 Sung9. All rights reserved.
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift

final class CounterViewController: UIViewController{

    @IBOutlet var decreaseButton: UIButton!
    @IBOutlet var increaseButton: UIButton!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicatorView.layer.cornerRadius = 4
        self.reactor = CounterViewReactor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension CounterViewController : StoryboardView{
    func bind(reactor: CounterViewReactor) {
        // Action
        
        
        self.increaseButton.rx.tap               // Tap event
            .map { Reactor.Action.increase }  // Convert to Action.increase
            .bind(to: reactor.action)         // Bind to reactor.action
            .disposed(by: self.disposeBag)
        
        self.decreaseButton.rx.tap
            .map { Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // State
        reactor.state.map { $0.value }   // 10
            .distinctUntilChanged()
            .map { "\($0)" }               // "10"
            .bind(to: self.valueLabel.rx.text)  // Bind to valueLabel
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: self.activityIndicatorView.rx.isAnimating)
            .disposed(by: self.disposeBag)
    }
}
