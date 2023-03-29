Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1E36CF66F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjC2Wel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjC2Wec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:34:32 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C5165A6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 15:33:58 -0700 (PDT)
Date:   Wed, 29 Mar 2023 22:33:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680129209; x=1680388409;
        bh=+Jgo8YMLidWi9F/tttnsA/dAW+fcatX0DCsuPc2iOP8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=WxNvUDrX3yHHzIhQch5hrDo1Gpugmjzl3wEk73FYRTDYV5m+BvQjawfkqaKrHbaNf
         Iu+GcCh5ef1qF0WveOxPzTGSoSdhb+ah8UNPXjB38Ig6/pB2vPdEkMpFk1b+DFwS9F
         Cw6y3Sozfy9u905yezyC2HLQGmBBjIc1BBIWRRpxHOfp408PxCFiE1KuUsZKrWVnYj
         bYBcAAMT+8gMkvleDq0/0XVXiAuhhDEO84x5mCJktsephHh+/pQWLOkNxtnV/4l+yL
         AvqSQIzZ6pbEfvHYQ8zFTCx3UUy7Xq6B6A+lbu289IavnjwZ3HH0anVWnRsUa2pLIA
         SW43lBEoskCDQ==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>
From:   y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v3 06/13] rust: init/sync: add `InPlaceInit` trait to pin-initialize smart pointers
Message-ID: <20230329223239.138757-7-y86-dev@protonmail.com>
In-Reply-To: <20230329223239.138757-1-y86-dev@protonmail.com>
References: <20230329223239.138757-1-y86-dev@protonmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benno Lossin <y86-dev@protonmail.com>

The `InPlaceInit` trait that provides two functions, for initializing
using `PinInit<T, E>` and `Init<T>`. It is implemented by `Arc<T>`,
`UniqueArc<T>` and `Box<T>`.

Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
---
 rust/kernel/init.rs     | 97 +++++++++++++++++++++++++++++++++++------
 rust/kernel/sync/arc.rs | 25 ++++++++++-
 2 files changed, 108 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 85e8d5f41b60..3d89c7e3bdb5 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -114,10 +114,13 @@
 //! [`impl Init<T, E>`]: Init
 //! [`Opaque`]: kernel::types::Opaque
 //! [`pin_data`]: ::macros::pin_data
-//! [`UniqueArc<T>`]: kernel::sync::UniqueArc

+use crate::{
+    error::{self, Error},
+    sync::UniqueArc,
+};
 use alloc::boxed::Box;
-use core::{cell::Cell, convert::Infallible, marker::PhantomData, mem::Mayb=
eUninit, ptr};
+use core::{cell::Cell, convert::Infallible, marker::PhantomData, mem::Mayb=
eUninit, pin::Pin, ptr};

 #[doc(hidden)]
 pub mod __internal;
@@ -309,7 +312,6 @@ pub mod macros;
 ///
 /// [`try_pin_init!`]: kernel::try_pin_init
 /// [`NonNull<Self>`]: core::ptr::NonNull
-/// [`Error`]: kernel::error::Error
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
 // module `__internal` inside of `init/__internal.rs`.
 #[macro_export]
@@ -366,8 +368,6 @@ macro_rules! pin_init {
 ///     }
 /// }
 /// ```
-///
-/// [`Error`]: kernel::error::Error
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
 // module `__internal` inside of `init/__internal.rs`.
 #[macro_export]
@@ -589,8 +589,6 @@ macro_rules! try_pin_init {
 ///
 /// This initializer is for initializing data in-place that might later be=
 moved. If you want to
 /// pin-initialize, use [`pin_init!`].
-///
-/// [`Error`]: kernel::error::Error
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
 // module `__internal` inside of `init/__internal.rs`.
 #[macro_export]
@@ -641,8 +639,6 @@ macro_rules! init {
 ///     }
 /// }
 /// ```
-///
-/// [`Error`]: kernel::error::Error
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
 // module `__internal` inside of `init/__internal.rs`.
 #[macro_export]
@@ -848,7 +844,8 @@ macro_rules! try_init {
 /// A pinned initializer for `T`.
 ///
 /// To use this initializer, you will need a suitable memory location that=
 can hold a `T`. This can
-/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`].
+/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::pi=
n_init`] function of a
+/// smart pointer like [`Arc<T>`] on this.
 ///
 /// Also see the [module description](self).
 ///
@@ -867,7 +864,6 @@ macro_rules! try_init {
 ///
 /// [`Arc<T>`]: crate::sync::Arc
 /// [`Arc::pin_init`]: crate::sync::Arc::pin_init
-/// [`UniqueArc<T>`]: kernel::sync::UniqueArc
 #[must_use =3D "An initializer must be used in order to create its value."=
]
 pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>: Sized {
     /// Initializes `slot`.
@@ -884,7 +880,8 @@ pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>: =
Sized {
 /// An initializer for `T`.
 ///
 /// To use this initializer, you will need a suitable memory location that=
 can hold a `T`. This can
-/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Because [`PinInit<T, E>`]=
 is a super trait, you can
+/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::in=
it`] function of a smart
+/// pointer like [`Arc<T>`] on this. Because [`PinInit<T, E>`] is a super =
trait, you can
 /// use every function that takes it as well.
 ///
 /// Also see the [module description](self).
@@ -909,7 +906,6 @@ pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>: =
Sized {
 /// move the pointee after initialization.
 ///
 /// [`Arc<T>`]: crate::sync::Arc
-/// [`UniqueArc<T>`]: kernel::sync::UniqueArc
 #[must_use =3D "An initializer must be used in order to create its value."=
]
 pub unsafe trait Init<T: ?Sized, E =3D Infallible>: PinInit<T, E> {
     /// Initializes `slot`.
@@ -1014,3 +1010,78 @@ unsafe impl<T> Init<T> for T {
         Ok(())
     }
 }
+
+/// Smart pointer that can initialize memory in-place.
+pub trait InPlaceInit<T>: Sized {
+    /// Use the given initializer to in-place initialize a `T`.
+    ///
+    /// If `T: !Unpin` it will not be able to move afterwards.
+    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
+    where
+        Error: From<E>;
+
+    /// Use the given initializer to in-place initialize a `T`.
+    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
+    where
+        Error: From<E>;
+}
+
+impl<T> InPlaceInit<T> for Box<T> {
+    #[inline]
+    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
+    where
+        Error: From<E>,
+    {
+        let mut this =3D Box::try_new_uninit()?;
+        let slot =3D this.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid and will not be moved because of the `Pin::new_un=
checked`
+        unsafe { init.__pinned_init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { Pin::new_unchecked(this.assume_init()) })
+    }
+
+    #[inline]
+    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
+    where
+        Error: From<E>,
+    {
+        let mut this =3D Box::try_new_uninit()?;
+        let slot =3D this.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid
+        unsafe { init.__init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { this.assume_init() })
+    }
+}
+
+impl<T> InPlaceInit<T> for UniqueArc<T> {
+    #[inline]
+    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
+    where
+        Error: From<E>,
+    {
+        let mut this =3D UniqueArc::try_new_uninit()?;
+        let slot =3D this.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid and will not be moved because of the `Pin::new_un=
checked`.
+        unsafe { init.__pinned_init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { Pin::new_unchecked(this.assume_init()) })
+    }
+
+    #[inline]
+    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
+    where
+        Error: From<E>,
+    {
+        let mut this =3D UniqueArc::try_new_uninit()?;
+        let slot =3D this.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid.
+        unsafe { init.__init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { this.assume_init() })
+    }
+}
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 16ec174637b2..77a3833cc265 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -17,7 +17,8 @@

 use crate::{
     bindings,
-    error::Result,
+    error::{Error, Result},
+    init::{InPlaceInit, Init, PinInit},
     types::{ForeignOwnable, Opaque},
 };
 use alloc::boxed::Box;
@@ -163,6 +164,28 @@ impl<T> Arc<T> {
         // `Arc` object.
         Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
     }
+
+    /// Use the given initializer to in-place initialize a `T`.
+    ///
+    /// If `T: !Unpin` it will not be able to move afterwards.
+    #[inline]
+    pub fn pin_init<E>(init: impl PinInit<T, E>) -> Result<Self>
+    where
+        Error: From<E>,
+    {
+        UniqueArc::pin_init(init).map(|u| u.into())
+    }
+
+    /// Use the given initializer to in-place initialize a `T`.
+    ///
+    /// This is equivalent to [`pin_init`], since an [`Arc`] is always pin=
ned.
+    #[inline]
+    pub fn init<E>(init: impl Init<T, E>) -> Result<Self>
+    where
+        Error: From<E>,
+    {
+        UniqueArc::init(init).map(|u| u.into())
+    }
 }

 impl<T: ?Sized> Arc<T> {
--
2.39.2


