Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5417B6D4D2B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjDCQGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjDCQF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:05:57 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41361FC6
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:05:55 -0700 (PDT)
Date:   Mon, 03 Apr 2023 16:05:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680537953; x=1680797153;
        bh=yfXd5D8BxAfgdr5rvbjqK+tp79cUPO+/3tQLSPK3UIg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=TCVLk2yubXDKuQlr3pe5wZyiIV9qDsFS1iwqzHpJfktLn8TfIvPkX1U7vQW7s8eJ0
         L652DT+NIWHREzxkRYZc2dhoYadI1BFb5yRx8zTR0JW0kdSnyIi6A+lTTkwgZ5smhe
         cUH2ZWbsnSg0SDz9c2LmoASMukzxddVPi9XKuWaaXh4sgY1KIcl88DrIdBwRlST/5x
         xbu2cmHykV1BYcbsJpUVDKRy9oluuB+eIX6ONwA8jW5J/VKuNnapEEVVXd+0Pb43vH
         mcdSNvd4C6Bfg0hl4EXKMw/YTr3GGOXShO74ey++rWY6GbjdXEHIHFx3zFupWilDtO
         QPyJWBWInyPQw==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <y86-dev@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH v5 13/15] rust: types: add common init-helper functions for `Opaque`
Message-ID: <20230403160511.174894-6-y86-dev@protonmail.com>
In-Reply-To: <20230403154422.168633-1-y86-dev@protonmail.com>
References: <20230403154422.168633-1-y86-dev@protonmail.com>
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
index 09bba4e86ace..b4947e8cf731 100644
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


