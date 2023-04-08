Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0799F6DBAE3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 14:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjDHM1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 08:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjDHM1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 08:27:07 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B961024E;
        Sat,  8 Apr 2023 05:26:44 -0700 (PDT)
Date:   Sat, 08 Apr 2023 12:26:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680956799; x=1681215999;
        bh=urI1ZTtOSmU+vvBI5jLuXdUyX7F1fydhihApnsXkfuk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ZTwQwHt1PVXtCb1HW9Zvd04Z1teTcHsADLp4vudwGRIZkQKxZsedjCCbm7TQog6kE
         8Mkdcc3E9RtHlWOgyl0NMb15Vfppir4DYJrxPYeN2JKrCnTyVeESFpQungF7Bx3PvZ
         ioHU3csjoMbQFcNhvx8FHRP3I5EDALOOQO2qeWnl8WMZXhioRLppeWtWZG7zzL41df
         mHOzOQbZ5HkE0VeXR4jxJ6lghjJ1N2WUq9UAloiSxAnhW3e+tIAousLOlb6ZxP20WU
         9V+/Zbuf5B/mJGS+gdxdNlhi1LZVD+aSFMgCVId33Q2vrviiZMJQxBTNcXRvNgsCoE
         2p12dCL4o+AyA==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, Andreas Hindborg <nmi@metaspace.dk>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <y86-dev@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH v7 13/15] rust: types: add `Opaque::ffi_init`
Message-ID: <20230408122429.1103522-14-y86-dev@protonmail.com>
In-Reply-To: <20230408122429.1103522-1-y86-dev@protonmail.com>
References: <20230408122429.1103522-1-y86-dev@protonmail.com>
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

This function allows to easily initialize `Opaque` with the pin-init
API. `Opaque::ffi_init` takes a closure and returns a pin-initializer.
This pin-initiailizer calls the given closure with a pointer to the
inner `T`.

Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/init.rs  |  9 +++++++++
 rust/kernel/types.rs | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index ffd539e2f5ef..a1298c8bbda0 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -177,6 +177,14 @@
 //! }
 //! ```
 //!
+//! For the special case where initializing a field is a single FFI-functi=
on call that cannot fail,
+//! there exist the helper function [`Opaque::ffi_init`]. This function in=
itialize a single
+//! [`Opaque`] field by just delegating to the supplied closure. You can u=
se these in combination
+//! with [`pin_init!`].
+//!
+//! For more information on how to use [`pin_init_from_closure()`], take a=
 look at the uses inside
+//! the `kernel` crate. The [`sync`] module is a good starting point.
+//!
 //! [`sync`]: kernel::sync
 //! [pinning]: https://doc.rust-lang.org/std/pin/index.html
 //! [structurally pinned fields]:
@@ -187,6 +195,7 @@
 //! [`impl PinInit<T, E>`]: PinInit
 //! [`impl Init<T, E>`]: Init
 //! [`Opaque`]: kernel::types::Opaque
+//! [`Opaque::ffi_init`]: kernel::types::Opaque::ffi_init
 //! [`pin_data`]: ::macros::pin_data

 use crate::{
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index ff2b2fac951d..3a46ec1a00cd 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -2,6 +2,7 @@

 //! Kernel types.

+use crate::init::{self, PinInit};
 use alloc::boxed::Box;
 use core::{
     cell::UnsafeCell,
@@ -234,6 +235,25 @@ impl<T> Opaque<T> {
         Self(MaybeUninit::uninit())
     }

+    /// Creates a pin-initializer from the given initializer closure.
+    ///
+    /// The returned initializer calls the given closure with the pointer =
to the inner `T` of this
+    /// `Opaque`. Since this memory is uninitialized, the closure is not a=
llowed to read from it.
+    ///
+    /// This function is safe, because the `T` inside of an `Opaque` is al=
lowed to be
+    /// uninitialized. Additionally, access to the inner `T` requires `uns=
afe`, so the caller needs
+    /// to verify at that point that the inner value is valid.
+    pub fn ffi_init(init_func: impl FnOnce(*mut T)) -> impl PinInit<Self> =
{
+        // SAFETY: We contain a `MaybeUninit`, so it is OK for the `init_f=
unc` to not fully
+        // initiailize the `T`.
+        unsafe {
+            init::pin_init_from_closure::<_, ::core::convert::Infallible>(=
move |slot| {
+                init_func(Self::raw_get(slot));
+                Ok(())
+            })
+        }
+    }
+
     /// Returns a raw pointer to the opaque data.
     pub fn get(&self) -> *mut T {
         UnsafeCell::raw_get(self.0.as_ptr())
--
2.39.2


