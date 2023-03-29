Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA786CF66E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjC2Weg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjC2We3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:34:29 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994EF61B1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 15:33:53 -0700 (PDT)
Date:   Wed, 29 Mar 2023 22:33:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680129214; x=1680388414;
        bh=Scrd8f8EDEvabnhRamoSHtqijjSxy4jp1Z9S+dx9Byo=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=d0qQmAswlFDeibO7yaTXVFAid60RtqEpL2h34keMorDev0IH/5MhVWtuEwDdkMeg+
         DqNg2wNRRaQAEeBvtGHI1nSWtcnqep6TOlTIZKu39ZWRTpKp4s6KiKl74dmJvs+ziV
         kMiV9NnjuXlP9LCl7H94jbvHDeweSMqU70QbwU7YEQCYJ55iB1YJlpcTmo3llugp/Z
         7YqvTm3Pf9OI/gkgi1Qtq5XVsfhcNpal+1A1NM9iApvT+YwbGvkJ68s8YL46Zqp3HB
         AeMaDOi087H2m4/aRIx04dTmiMpSQjZKs4uLzTdr3kXOAUEVzCI2oCu1dpq0o887R4
         6ul82DZPIGH8w==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>
From:   y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v3 08/13] rust: init: add `stack_pin_init!` macro
Message-ID: <20230329223239.138757-9-y86-dev@protonmail.com>
In-Reply-To: <20230329223239.138757-1-y86-dev@protonmail.com>
References: <20230329223239.138757-1-y86-dev@protonmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benno Lossin <y86-dev@protonmail.com>

The `stack_pin_init!` macro allows pin-initializing a value on the
stack. It accepts a `impl PinInit<T, E>` to initialize a `T`. It allows
propagating any errors via `?` or handling it normally via `match`.

Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
---
 rust/kernel/init.rs            | 70 +++++++++++++++++++++++++++++++---
 rust/kernel/init/__internal.rs | 46 ++++++++++++++++++++++
 2 files changed, 110 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 428b5c2ac516..3358f14beffb 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -12,7 +12,8 @@
 //!
 //! To initialize a `struct` with an in-place constructor you will need tw=
o things:
 //! - an in-place constructor,
-//! - a memory location that can hold your `struct`.
+//! - a memory location that can hold your `struct` (this can be the [stac=
k], an [`Arc<T>`],
+//!   [`UniqueArc<T>`], [`Box<T>`] or any other smart pointer that impleme=
nts [`InPlaceInit`]).
 //!
 //! To get an in-place constructor there are generally three options:
 //! - directly creating an in-place constructor using the [`pin_init!`] ma=
cro,
@@ -180,6 +181,7 @@
 //! [pinning]: https://doc.rust-lang.org/std/pin/index.html
 //! [structurally pinned fields]:
 //!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-structural=
-for-field
+//! [stack]: crate::stack_pin_init
 //! [`Arc<T>`]: crate::sync::Arc
 //! [`impl PinInit<Foo>`]: PinInit
 //! [`impl PinInit<T, E>`]: PinInit
@@ -199,6 +201,62 @@ pub mod __internal;
 #[doc(hidden)]
 pub mod macros;

+/// Initialize and pin a type directly on the stack.
+///
+/// # Examples
+///
+/// ```rust
+/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+/// # use kernel::{init, pin_init, stack_pin_init, init::*, sync::Mutex, n=
ew_mutex};
+/// # use macros::pin_data;
+/// # use core::pin::Pin;
+/// #[pin_data]
+/// struct Foo {
+///     #[pin]
+///     a: Mutex<usize>,
+///     b: Bar,
+/// }
+///
+/// #[pin_data]
+/// struct Bar {
+///     x: u32,
+/// }
+///
+/// let a =3D new_mutex!(42, "Foo::a");
+///
+/// stack_pin_init!(let foo =3D? pin_init!(Foo {
+///     a,
+///     b: Bar {
+///         x: 64,
+///     },
+/// }));
+/// let foo: Pin<&mut Foo> =3D foo;
+/// # Ok::<(), core::convert::Infallible>(())
+/// ```
+///
+/// # Syntax
+///
+/// A normal `let` binding with optional type annotation. The expression i=
s expected to implement
+/// [`PinInit`]. Additionally a `?` can be put after the `=3D`, this will =
assign `Pin<&mut T>` to the
+/// variable instead of `Result<Pin<&mut T>, E>`.
+#[macro_export]
+macro_rules! stack_pin_init {
+    (let $var:ident $(: $t:ty)? =3D $val:expr) =3D> {
+        let mut $var =3D $crate::init::__internal::StackInit$(::<$t>)?::un=
init();
+        let mut $var =3D {
+            let val =3D $val;
+            unsafe { $crate::init::__internal::StackInit::init(&mut $var, =
val) }
+        };
+    };
+    (let $var:ident $(: $t:ty)? =3D? $val:expr) =3D> {
+        let mut $var =3D $crate::init::__internal::StackInit$(::<$t>)?::un=
init();
+        let mut $var =3D {
+            let val =3D $val;
+            unsafe { $crate::init::__internal::StackInit::init(&mut $var, =
val)? }
+        };
+    };
+}
+
 /// Construct an in-place, pinned initializer for `struct`s.
 ///
 /// This macro defaults the error to [`Infallible`]. If you need [`Error`]=
, then use
@@ -916,8 +974,8 @@ macro_rules! try_init {
 /// A pinned initializer for `T`.
 ///
 /// To use this initializer, you will need a suitable memory location that=
 can hold a `T`. This can
-/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::pi=
n_init`] function of a
-/// smart pointer like [`Arc<T>`] on this.
+/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`s=
tack_pin_init!`]). Use the
+/// [`InPlaceInit::pin_init`] function of a smart pointer like [`Arc<T>`] =
on this.
 ///
 /// Also see the [module description](self).
 ///
@@ -952,9 +1010,9 @@ pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>:=
 Sized {
 /// An initializer for `T`.
 ///
 /// To use this initializer, you will need a suitable memory location that=
 can hold a `T`. This can
-/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::in=
it`] function of a smart
-/// pointer like [`Arc<T>`] on this. Because [`PinInit<T, E>`] is a super =
trait, you can
-/// use every function that takes it as well.
+/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`s=
tack_pin_init!`]). Use the
+/// [`InPlaceInit::init`] function of a smart pointer like [`Arc<T>`] on t=
his. Because
+/// [`PinInit<T, E>`] is a super trait, you can use every function that ta=
kes it as well.
 ///
 /// Also see the [module description](self).
 ///
diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.r=
s
index 4a3c7bf27a06..bf33c8e96e6d 100644
--- a/rust/kernel/init/__internal.rs
+++ b/rust/kernel/init/__internal.rs
@@ -89,6 +89,52 @@ unsafe impl<T: ?Sized> HasInitData for T {
     }
 }

+/// Stack initializer helper type. Use [`stack_pin_init`] instead of this =
primitive.
+///
+/// # Invariants
+///
+/// If `self.1` is true, then `self.0` is initialized.
+///
+/// [`stack_pin_init`]: kernel::stack_pin_init
+pub struct StackInit<T>(MaybeUninit<T>, bool);
+
+impl<T> Drop for StackInit<T> {
+    #[inline]
+    fn drop(&mut self) {
+        if self.1 {
+            // SAFETY: As we are being dropped, we only call this once. An=
d since `self.1 =3D=3D true`,
+            // `self.0` has to be initialized.
+            unsafe { self.0.assume_init_drop() };
+        }
+    }
+}
+
+impl<T> StackInit<T> {
+    /// Creates a new [`StackInit<T>`] that is uninitialized. Use [`stack_=
pin_init`] instead of this
+    /// primitive.
+    ///
+    /// [`stack_pin_init`]: kernel::stack_pin_init
+    #[inline]
+    pub fn uninit() -> Self {
+        Self(MaybeUninit::uninit(), false)
+    }
+
+    /// Initializes the contents and returns the result.
+    ///
+    /// # Safety
+    ///
+    /// The caller ensures that `self` is on the stack and not accessible =
in any other way, if this
+    /// function returns `Ok`.
+    #[inline]
+    pub unsafe fn init<E>(&mut self, init: impl PinInit<T, E>) -> Result<P=
in<&mut T>, E> {
+        // SAFETY: The memory slot is valid and this type ensures that it =
will stay pinned.
+        unsafe { init.__pinned_init(self.0.as_mut_ptr())? };
+        self.1 =3D true;
+        // SAFETY: The slot is now pinned, since we will never give access=
 to `&mut T`.
+        Ok(unsafe { Pin::new_unchecked(self.0.assume_init_mut()) })
+    }
+}
+
 /// When a value of this type is dropped, it drops a `T`.
 ///
 /// Can be forgotton to prevent the drop.
--
2.39.2


