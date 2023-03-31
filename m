Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40BE6D2AE1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 00:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjCaWGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 18:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjCaWGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 18:06:04 -0400
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch [185.70.41.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC6B1FD3E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 15:06:03 -0700 (PDT)
Date:   Fri, 31 Mar 2023 21:54:29 +0000
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="rpl7HOJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680299680; x=1680558880;
        bh=5Fn50wx9SjwjEk+7PFvrVXZ6Yt0uZEDngF0z84FHnKc=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=rpl7HOJlJTDiEG+BmuTzQHlWSHu2+U/blhvLlzXyQhzz6HEl0LLvfR+RJZaLdgU5x
         wy4YjiDBPq3QrCgHdYLrpaBKuPgSDp/UTF02H07Gg7s/hWGahPBI7C2UfhhalDMH9z
         V9j0Bh5KZWdTTXkuugNCdeNGj8ZDa0RcrXmURX4W09gfCCoYeS7bfkX3d7KaFF5xsx
         u7bQhmnHgWTudRL9qRHFvo+d1crdrVx6Q1cllbsnYOPztVMm5F2VuUT4oIgUMBl8r0
         5yU9XftQvtDwWeqZbdSBDlv6WzRTwN1k2Ps8T03vZdkqNOXQusNPMkirvlJp59ylG0
         xeYIRQ7xpT97g==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>
From:   y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <y86-dev@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH v4 13/15] rust: types: add common init-helper functions for `Opaque`
Message-ID: <20230331215053.585759-14-y86-dev@protonmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benno Lossin <y86-dev@protonmail.com>

Add helper functions to more easily initialize `Opaque<T>` via FFI and
rust raw initializer functions.
These functions take a function pointer to the FFI/raw initialization
function and take between 0-4 other arguments. It then returns an
initializer that uses the FFI/raw initialization function along with the
given arguments to initialize an `Opaque<T>`.

Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
Cc: Gary Guo <gary@garyguo.net>
---
 rust/kernel/init.rs  |  9 +++++++++
 rust/kernel/types.rs | 47 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index fef14c3c0642..7b452e458391 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -177,6 +177,14 @@
 //! }
 //! ```
 //!
+//! For the special case where initializing a field is a single FFI-functi=
on call that cannot fail,
+//! there exist helper functions [`Opaque::ffi_init`]. These functions ini=
tialize a single
+//! [`Opaque`] field by just delegating to the FFI-function. You can use t=
hese in combination with
+//! [`pin_init!`].
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
index ff2b2fac951d..dbfae9bb97ce 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -2,6 +2,7 @@

 //! Kernel types.

+use crate::init::{self, PinInit};
 use alloc::boxed::Box;
 use core::{
     cell::UnsafeCell,
@@ -248,6 +249,52 @@ impl<T> Opaque<T> {
     }
 }

+macro_rules! opaque_init_funcs {
+    ($($abi:literal $name:ident($($arg_name:ident: $arg_typ:ident),*);)*) =
=3D> {
+        impl<T> Opaque<T> {
+            $(
+                /// Create an initializer using the given initializer func=
tion.
+                ///
+                /// # Safety
+                ///
+                /// The given function **must** under all circumstances in=
itialize the memory
+                /// location to a valid `T`. If it fails to do so it resul=
ts in UB.
+                ///
+                /// If any parameters are given, those need to be valid fo=
r the function. Valid
+                /// means that calling the function with those parameters =
complies with the above
+                /// requirement **and** every other requirement on the fun=
ction itself.
+                pub unsafe fn $name<$($arg_typ),*>(
+                    init_func: unsafe extern $abi fn(*mut T $(, $arg_typ)*=
),
+                    $($arg_name: $arg_typ,)*
+                ) -> impl PinInit<Self> {
+                    // SAFETY: The safety contract of this function ensure=
s that `init_func` fully
+                    // initializes `slot`.
+                    unsafe {
+                        init::pin_init_from_closure(move |slot| {
+                            init_func(Self::raw_get(slot) $(, $arg_name)*)=
;
+                            Ok(())
+                        })
+                    }
+                }
+            )*
+        }
+    }
+}
+
+opaque_init_funcs! {
+    "C" ffi_init();
+    "C" ffi_init1(arg1: A1);
+    "C" ffi_init2(arg1: A1, arg2: A2);
+    "C" ffi_init3(arg1: A1, arg2: A2, arg3: A3);
+    "C" ffi_init4(arg1: A1, arg2: A2, arg3: A3, arg4: A4);
+
+    "Rust" manual_init();
+    "Rust" manual_init1(arg1: A1);
+    "Rust" manual_init2(arg1: A1, arg2: A2);
+    "Rust" manual_init3(arg1: A1, arg2: A2, arg3: A3);
+    "Rust" manual_init4(arg1: A1, arg2: A2, arg3: A3, arg4: A4);
+}
+
 /// A sum type that always holds either a value of type `L` or `R`.
 pub enum Either<L, R> {
     /// Constructs an instance of [`Either`] containing a value of type `L=
`.
--
2.39.2


