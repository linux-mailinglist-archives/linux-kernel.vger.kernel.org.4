Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D2A6EC7B3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjDXIMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjDXIMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:12:05 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173BF1737;
        Mon, 24 Apr 2023 01:11:58 -0700 (PDT)
Date:   Mon, 24 Apr 2023 08:11:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1682323916; x=1682583116;
        bh=jlSr6JF5Fnj5YiX5jFHLOW1OnwcKWvvXtJXoTFNi8uY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Hd+UjMji73bffnr1Vd7qGnI0gYyHhvDR3/n45+Gfw58wgqIOFOcGSMuwpRKgQeth/
         DmKuJXL0rbWpKlI5BZh+Wmc9HGvIEBHiPhkGeMZ6hSJ/P4RYnhZyEhpdjObeOmSuP2
         rUTZQ3wDumN7rDJU02zlQQ4HbPIhyufzCQXn3IsbtPml+McirbW83ClpdrVN67CZYw
         RfrnQZzA56YgWDuArvzsrIyen+m7u4/utiV7flzHkux9KJWX24TdoUUgoCKggFMEyv
         7ayrFBpY0kNbTPx50ai59tgOXcfUZteWa/v5Y4GXzsMt9l0J/+5N+kJd8cVk6kU8qg
         aHiIK774RJgBw==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <benno.lossin@proton.me>
Subject: [PATCH 4/4] rust: init: update macro expansion example in docs
Message-ID: <20230424081112.99890-4-benno.lossin@proton.me>
In-Reply-To: <20230424081112.99890-1-benno.lossin@proton.me>
References: <20230424081112.99890-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also improve the explaining comments.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/init/macros.rs | 85 +++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 37 deletions(-)

diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index 541cfad1d8be..00aa4e956c0a 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -16,8 +16,9 @@
 //!
 //! We will look at the following example:
 //!
-//! ```rust
+//! ```rust,ignore
 //! # use kernel::init::*;
+//! # use core::pin::Pin;
 //! #[pin_data]
 //! #[repr(C)]
 //! struct Bar<T> {
@@ -71,11 +72,12 @@
 //!
 //! Here is the definition of `Bar` from our example:
 //!
-//! ```rust
+//! ```rust,ignore
 //! # use kernel::init::*;
 //! #[pin_data]
 //! #[repr(C)]
 //! struct Bar<T> {
+//!     #[pin]
 //!     t: T,
 //!     pub x: usize,
 //! }
@@ -83,7 +85,7 @@
 //!
 //! This expands to the following code:
 //!
-//! ```rust
+//! ```rust,ignore
 //! // Firstly the normal definition of the struct, attributes are preserv=
ed:
 //! #[repr(C)]
 //! struct Bar<T> {
@@ -116,20 +118,22 @@
 //!         unsafe fn t<E>(
 //!             self,
 //!             slot: *mut T,
-//!             init: impl ::kernel::init::Init<T, E>,
+//!             // Since `t` is `#[pin]`, this is `PinInit`.
+//!             init: impl ::kernel::init::PinInit<T, E>,
 //!         ) -> ::core::result::Result<(), E> {
-//!             unsafe { ::kernel::init::Init::__init(init, slot) }
+//!             unsafe { ::kernel::init::PinInit::__pinned_init(init, slot=
) }
 //!         }
 //!         pub unsafe fn x<E>(
 //!             self,
 //!             slot: *mut usize,
+//!             // Since `x` is not `#[pin]`, this is `Init`.
 //!             init: impl ::kernel::init::Init<usize, E>,
 //!         ) -> ::core::result::Result<(), E> {
 //!             unsafe { ::kernel::init::Init::__init(init, slot) }
 //!         }
 //!     }
 //!     // Implement the internal `HasPinData` trait that associates `Bar`=
 with the pin-data struct
-//!     // that we constructed beforehand.
+//!     // that we constructed above.
 //!     unsafe impl<T> ::kernel::init::__internal::HasPinData for Bar<T> {
 //!         type PinData =3D __ThePinData<T>;
 //!         unsafe fn __pin_data() -> Self::PinData {
@@ -160,6 +164,8 @@
 //!     struct __Unpin<'__pin, T> {
 //!         __phantom_pin: ::core::marker::PhantomData<fn(&'__pin ()) -> &=
'__pin ()>,
 //!         __phantom: ::core::marker::PhantomData<fn(Bar<T>) -> Bar<T>>,
+//!         // Our only `#[pin]` field is `t`.
+//!         t: T,
 //!     }
 //!     #[doc(hidden)]
 //!     impl<'__pin, T>
@@ -193,7 +199,7 @@
 //!
 //! Here is the impl on `Bar` defining the new function:
 //!
-//! ```rust
+//! ```rust,ignore
 //! impl<T> Bar<T> {
 //!     fn new(t: T) -> impl PinInit<Self> {
 //!         pin_init!(Self { t, x: 0 })
@@ -203,7 +209,7 @@
 //!
 //! This expands to the following code:
 //!
-//! ```rust
+//! ```rust,ignore
 //! impl<T> Bar<T> {
 //!     fn new(t: T) -> impl PinInit<Self> {
 //!         {
@@ -232,25 +238,31 @@
 //!                     // that will refer to this struct instead of the o=
ne defined above.
 //!                     struct __InitOk;
 //!                     // This is the expansion of `t,`, which is syntact=
ic sugar for `t: t,`.
-//!                     unsafe { ::core::ptr::write(&raw mut (*slot).t, t)=
 };
+//!                     unsafe { ::core::ptr::write(::core::addr_of_mut!((=
*slot).t), t) };
 //!                     // Since initialization could fail later (not in t=
his case, since the error
-//!                     // type is `Infallible`) we will need to drop this=
 field if it fails. This
-//!                     // `DropGuard` will drop the field when it gets dr=
opped and has not yet
-//!                     // been forgotten. We make a reference to it, so u=
sers cannot `mem::forget`
-//!                     // it from the initializer, since the name is the =
same as the field.
+//!                     // type is `Infallible`) we will need to drop this=
 field if there is an
+//!                     // error later. This `DropGuard` will drop the fie=
ld when it gets dropped
+//!                     // and has not yet been forgotten. We make a refer=
ence to it, so users
+//!                     // cannot `mem::forget` it from the initializer, s=
ince the name is the same
+//!                     // as the field (including hygiene).
 //!                     let t =3D &unsafe {
-//!                         ::kernel::init::__internal::DropGuard::new(&ra=
w mut (*slot).t)
+//!                         ::kernel::init::__internal::DropGuard::new(
+//!                             ::core::addr_of_mut!((*slot).t),
+//!                         )
 //!                     };
 //!                     // Expansion of `x: 0,`:
 //!                     // Since this can be an arbitrary expression we ca=
nnot place it inside of
 //!                     // the `unsafe` block, so we bind it here.
 //!                     let x =3D 0;
-//!                     unsafe { ::core::ptr::write(&raw mut (*slot).x, x)=
 };
+//!                     unsafe { ::core::ptr::write(::core::addr_of_mut!((=
*slot).x), x) };
+//!                     // We again create a `DropGuard`.
 //!                     let x =3D &unsafe {
-//!                         ::kernel::init::__internal::DropGuard::new(&ra=
w mut (*slot).x)
+//!                         ::kernel::init::__internal::DropGuard::new(
+//!                             ::core::addr_of_mut!((*slot).x),
+//!                         )
 //!                     };
 //!
-//!                     // Here we use the type checker to ensuer that eve=
ry field has been
+//!                     // Here we use the type checker to ensure that eve=
ry field has been
 //!                     // initialized exactly once, since this is `if fal=
se` it will never get
 //!                     // executed, but still type-checked.
 //!                     // Additionally we abuse `slot` to automatically i=
nfer the correct type for
@@ -272,7 +284,7 @@
 //!                         };
 //!                     }
 //!                     // Since initialization has successfully completed=
, we can now forget the
-//!                     // guards.
+//!                     // guards. This is not `mem::forget`, since we onl=
y have `&DropGuard`.
 //!                     unsafe { ::kernel::init::__internal::DropGuard::fo=
rget(t) };
 //!                     unsafe { ::kernel::init::__internal::DropGuard::fo=
rget(x) };
 //!                 }
@@ -280,7 +292,7 @@
 //!                 // `__InitOk` that we need to return.
 //!                 Ok(__InitOk)
 //!             });
-//!             // Change the return type of the closure.
+//!             // Change the return type from `__InitOk` to `()`.
 //!             let init =3D move |slot| -> ::core::result::Result<(), ::c=
ore::convert::Infallible> {
 //!                 init(slot).map(|__InitOk| ())
 //!             };
@@ -299,7 +311,7 @@
 //! Since we already took a look at `#[pin_data]` on `Bar`, this section w=
ill only explain the
 //! differences/new things in the expansion of the `Foo` definition:
 //!
-//! ```rust
+//! ```rust,ignore
 //! #[pin_data(PinnedDrop)]
 //! struct Foo {
 //!     a: usize,
@@ -310,7 +322,7 @@
 //!
 //! This expands to the following code:
 //!
-//! ```rust
+//! ```rust,ignore
 //! struct Foo {
 //!     a: usize,
 //!     b: Bar<u32>,
@@ -330,8 +342,6 @@
 //!         unsafe fn b<E>(
 //!             self,
 //!             slot: *mut Bar<u32>,
-//!             // Note that this is `PinInit` instead of `Init`, this is =
because `b` is
-//!             // structurally pinned, as marked by the `#[pin]` attribut=
e.
 //!             init: impl ::kernel::init::PinInit<Bar<u32>, E>,
 //!         ) -> ::core::result::Result<(), E> {
 //!             unsafe { ::kernel::init::PinInit::__pinned_init(init, slot=
) }
@@ -359,14 +369,13 @@
 //!     struct __Unpin<'__pin> {
 //!         __phantom_pin: ::core::marker::PhantomData<fn(&'__pin ()) -> &=
'__pin ()>,
 //!         __phantom: ::core::marker::PhantomData<fn(Foo) -> Foo>,
-//!         // Since this field is `#[pin]`, it is listed here.
 //!         b: Bar<u32>,
 //!     }
 //!     #[doc(hidden)]
 //!     impl<'__pin> ::core::marker::Unpin for Foo where __Unpin<'__pin>: =
::core::marker::Unpin {}
 //!     // Since we specified `PinnedDrop` as the argument to `#[pin_data]=
`, we expect `Foo` to
 //!     // implement `PinnedDrop`. Thus we do not need to prevent `Drop` i=
mplementations like
-//!     // before, instead we implement it here and delegate to `PinnedDro=
p`.
+//!     // before, instead we implement `Drop` here and delegate to `Pinne=
dDrop`.
 //!     impl ::core::ops::Drop for Foo {
 //!         fn drop(&mut self) {
 //!             // Since we are getting dropped, no one else has a referen=
ce to `self` and thus we
@@ -388,7 +397,7 @@
 //!
 //! Here is the `PinnedDrop` impl for `Foo`:
 //!
-//! ```rust
+//! ```rust,ignore
 //! #[pinned_drop]
 //! impl PinnedDrop for Foo {
 //!     fn drop(self: Pin<&mut Self>) {
@@ -399,7 +408,7 @@
 //!
 //! This expands to the following code:
 //!
-//! ```rust
+//! ```rust,ignore
 //! // `unsafe`, full path and the token parameter are added, everything e=
lse stays the same.
 //! unsafe impl ::kernel::init::PinnedDrop for Foo {
 //!     fn drop(self: Pin<&mut Self>, _: ::kernel::init::__internal::OnlyC=
allFromDrop) {
@@ -410,10 +419,10 @@
 //!
 //! ## `pin_init!` on `Foo`
 //!
-//! Since we already took a look at `pin_init!` on `Bar`, this section wil=
l only explain the
-//! differences/new things in the expansion of `pin_init!` on `Foo`:
+//! Since we already took a look at `pin_init!` on `Bar`, this section wil=
l only show the expansion
+//! of `pin_init!` on `Foo`:
 //!
-//! ```rust
+//! ```rust,ignore
 //! let a =3D 42;
 //! let initializer =3D pin_init!(Foo {
 //!     a,
@@ -423,7 +432,7 @@
 //!
 //! This expands to the following code:
 //!
-//! ```rust
+//! ```rust,ignore
 //! let a =3D 42;
 //! let initializer =3D {
 //!     struct __InitOk;
@@ -438,13 +447,15 @@
 //!     >(data, move |slot| {
 //!         {
 //!             struct __InitOk;
-//!             unsafe { ::core::ptr::write(&raw mut (*slot).a, a) };
-//!             let a =3D &unsafe { ::kernel::init::__internal::DropGuard:=
:new(&raw mut (*slot).a) };
+//!             unsafe { ::core::ptr::write(::core::addr_of_mut!((*slot).a=
), a) };
+//!             let a =3D &unsafe {
+//!                 ::kernel::init::__internal::DropGuard::new(::core::add=
r_of_mut!((*slot).a))
+//!             };
 //!             let b =3D Bar::new(36);
-//!             // Here we use `data` to access the correct field and requ=
ire that `b` is of type
-//!             // `PinInit<Bar<u32>, Infallible>`.
-//!             unsafe { data.b(&raw mut (*slot).b, b)? };
-//!             let b =3D &unsafe { ::kernel::init::__internal::DropGuard:=
:new(&raw mut (*slot).b) };
+//!             unsafe { data.b(::core::addr_of_mut!((*slot).b), b)? };
+//!             let b =3D &unsafe {
+//!                 ::kernel::init::__internal::DropGuard::new(::core::add=
r_of_mut!((*slot).b))
+//!             };
 //!
 //!             #[allow(unreachable_code, clippy::diverging_sub_expression=
)]
 //!             if false {
--
2.40.0


