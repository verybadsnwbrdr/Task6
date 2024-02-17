import UIKit

final class ViewController: UIViewController {
	private let squareView = UIView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}
	
	override func viewWillLayoutSubviews() {
		super.viewDidLayoutSubviews()
		if squareView.transform == .identity {
			squareView.center = view.center
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else {
			return
		}
		let point = touch.location(in: view)
		moveSquare(to: point)
	}
	
	private func setup() {
		view.backgroundColor = .white
		view.addSubview(squareView)
		squareView.backgroundColor = .systemBlue
		squareView.layer.cornerRadius = 10
		squareView.frame.size = CGSize(width: 100, height: 100)
	}
	
	private func moveSquare(to point: CGPoint) {
		let newX = point.x - squareView.center.x
		let newY = point.y - squareView.center.y
		
		let deltaX = newX - (squareView.frame.midX - squareView.center.x)
		let deltaY = newY - (squareView.frame.midY - squareView.center.y)
		
		let newXWithAdditional = newX + deltaX / 10
		let newYWithAdditional = newY + deltaY / 10
		
		let rotationAngle = (deltaX / view.bounds.width + deltaY / view.bounds.height) * CGFloat.pi / 18
		
		UIView.animate(
			withDuration: 0.3,
			delay: 0,
			animations: { [self] in
				squareView.transform = .init(translationX: newXWithAdditional, y: newYWithAdditional)
					.rotated(by: rotationAngle)
			},
			completion: { [self] _ in completionAnimation(x: newX, y: newY) }
		)
	}
	
	private func completionAnimation(x: CGFloat, y: CGFloat) {
		UIView.animate(withDuration: 0.2) { [self] in
			squareView.transform = .init(translationX: x, y: y)
				.rotated(by: 0)
		}
	}
}
