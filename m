Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF7B640A73
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiLBQRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbiLBQQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:16:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B0EE0777;
        Fri,  2 Dec 2022 08:16:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1C3662333;
        Fri,  2 Dec 2022 16:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BAEC433D7;
        Fri,  2 Dec 2022 16:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669997793;
        bh=Uz7KZaflvYhbQVM6K8z3z1Og+VT76a4o8l7UhNbcRqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piZC5fI+mMK9laO2CWFrUa+F8m2JRcPS4V7dY75UeuRgbk7H4QaB/aOhc5Hcr4/qB
         Ku67P0FBoLgFKBRq9mQWeyW6WJ5OsYjURCwOK1y7jLanx6t+kCaBNb3qzmqGLPu/In
         aDWWapfkMwKu9toC8dBTD4CUwngE5qaQzNbUXaonA1rlYm/o4EyKe4vyZLUoIYwBJG
         cBYC5UldxMV7lZ8xJduAvgL0ohayvLPz+vics0YV0QrJPR72p9swWPRxm6/5Mznb2s
         ChLm0lVMMMWGARguWgjUeQ9HYx0TgAFrI0jSnzlwroAjUBpxllJ4cHOO4ZUE67LOA7
         eYno+WKdAB6AQ==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Niklas Mohrin <dev@niklasmohrin.de>
Subject: [PATCH v2 23/28] rust: std_vendor: add `dbg!` macro based on `std`'s one
Date:   Fri,  2 Dec 2022 17:14:54 +0100
Message-Id: <20221202161502.385525-24-ojeda@kernel.org>
In-Reply-To: <20221202161502.385525-1-ojeda@kernel.org>
References: <20221202161502.385525-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Mohrin <dev@niklasmohrin.de>

The Rust standard library has a really handy macro, `dbg!` [1,2].
It prints the source location (filename and line) along with the raw
source code that is invoked with and the `Debug` representation
of the given expression, e.g.:

    let a = 2;
    let b = dbg!(a * 2) + 1;
    //      ^-- prints: [src/main.rs:2] a * 2 = 4
    assert_eq!(b, 5);

Port the macro over to the `kernel` crate inside a new module
called `std_vendor`, using `pr_info!` instead of `eprintln!` and
make the rules about committing uses of `dbg!` into version control
more concrete (i.e. tailored for the kernel).

Since the source code for the macro is taken from the standard
library source (with only minor adjustments), the new file is
licensed under `Apache 2.0 OR MIT`, just like the original [3,4].

Link: https://doc.rust-lang.org/std/macro.dbg.html [1]
Link: https://github.com/rust-lang/rust/blob/master/library/std/src/macros.rs#L212 [2]
Link: https://github.com/rust-lang/rust/blob/master/library/std/Cargo.toml [3]
Link: https://github.com/rust-lang/rust/blob/master/COPYRIGHT [4]
Signed-off-by: Niklas Mohrin <dev@niklasmohrin.de>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/lib.rs        |   2 +
 rust/kernel/prelude.rs    |   2 +-
 rust/kernel/std_vendor.rs | 163 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/std_vendor.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ffc6626a6d29..d6371c9c8453 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -26,6 +26,8 @@ mod allocator;
 pub mod error;
 pub mod prelude;
 pub mod print;
+#[doc(hidden)]
+pub mod std_vendor;
 pub mod str;
 
 #[doc(hidden)]
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 89c2c9f4e7a7..345fc9075d1f 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -17,7 +17,7 @@ pub use alloc::{boxed::Box, vec::Vec};
 
 pub use macros::{module, vtable};
 
-pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
+pub use super::{dbg, pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
 
 pub use super::error::{code::*, Error, Result};
 
diff --git a/rust/kernel/std_vendor.rs b/rust/kernel/std_vendor.rs
new file mode 100644
index 000000000000..b3e68b24a8c6
--- /dev/null
+++ b/rust/kernel/std_vendor.rs
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+//! The contents of this file come from the Rust standard library, hosted in
+//! the <https://github.com/rust-lang/rust> repository, licensed under
+//! "Apache-2.0 OR MIT" and adapted for kernel use. For copyright details,
+//! see <https://github.com/rust-lang/rust/blob/master/COPYRIGHT>.
+
+/// [`std::dbg`], but using [`pr_info`] instead of [`eprintln`].
+///
+/// Prints and returns the value of a given expression for quick and dirty
+/// debugging.
+///
+/// An example:
+///
+/// ```rust
+/// let a = 2;
+/// # #[allow(clippy::dbg_macro)]
+/// let b = dbg!(a * 2) + 1;
+/// //      ^-- prints: [src/main.rs:2] a * 2 = 4
+/// assert_eq!(b, 5);
+/// ```
+///
+/// The macro works by using the `Debug` implementation of the type of
+/// the given expression to print the value with [`printk`] along with the
+/// source location of the macro invocation as well as the source code
+/// of the expression.
+///
+/// Invoking the macro on an expression moves and takes ownership of it
+/// before returning the evaluated expression unchanged. If the type
+/// of the expression does not implement `Copy` and you don't want
+/// to give up ownership, you can instead borrow with `dbg!(&expr)`
+/// for some expression `expr`.
+///
+/// The `dbg!` macro works exactly the same in release builds.
+/// This is useful when debugging issues that only occur in release
+/// builds or when debugging in release mode is significantly faster.
+///
+/// Note that the macro is intended as a temporary debugging tool to be
+/// used during development. Therefore, avoid committing `dbg!` macro
+/// invocations into the kernel tree.
+///
+/// For debug output that is intended to be kept in the kernel tree,
+/// use [`pr_debug`] and similar facilities instead.
+///
+/// # Stability
+///
+/// The exact output printed by this macro should not be relied upon
+/// and is subject to future changes.
+///
+/// # Further examples
+///
+/// With a method call:
+///
+/// ```rust
+/// # #[allow(clippy::dbg_macro)]
+/// fn foo(n: usize) {
+///     if dbg!(n.checked_sub(4)).is_some() {
+///         // ...
+///     }
+/// }
+///
+/// foo(3)
+/// ```
+///
+/// This prints to the kernel log:
+///
+/// ```text,ignore
+/// [src/main.rs:4] n.checked_sub(4) = None
+/// ```
+///
+/// Naive factorial implementation:
+///
+/// ```rust
+/// # #[allow(clippy::dbg_macro)]
+/// # {
+/// fn factorial(n: u32) -> u32 {
+///     if dbg!(n <= 1) {
+///         dbg!(1)
+///     } else {
+///         dbg!(n * factorial(n - 1))
+///     }
+/// }
+///
+/// dbg!(factorial(4));
+/// # }
+/// ```
+///
+/// This prints to the kernel log:
+///
+/// ```text,ignore
+/// [src/main.rs:3] n <= 1 = false
+/// [src/main.rs:3] n <= 1 = false
+/// [src/main.rs:3] n <= 1 = false
+/// [src/main.rs:3] n <= 1 = true
+/// [src/main.rs:4] 1 = 1
+/// [src/main.rs:5] n * factorial(n - 1) = 2
+/// [src/main.rs:5] n * factorial(n - 1) = 6
+/// [src/main.rs:5] n * factorial(n - 1) = 24
+/// [src/main.rs:11] factorial(4) = 24
+/// ```
+///
+/// The `dbg!(..)` macro moves the input:
+///
+/// ```ignore
+/// /// A wrapper around `usize` which importantly is not Copyable.
+/// #[derive(Debug)]
+/// struct NoCopy(usize);
+///
+/// let a = NoCopy(42);
+/// let _ = dbg!(a); // <-- `a` is moved here.
+/// let _ = dbg!(a); // <-- `a` is moved again; error!
+/// ```
+///
+/// You can also use `dbg!()` without a value to just print the
+/// file and line whenever it's reached.
+///
+/// Finally, if you want to `dbg!(..)` multiple values, it will treat them as
+/// a tuple (and return it, too):
+///
+/// ```
+/// # #[allow(clippy::dbg_macro)]
+/// assert_eq!(dbg!(1usize, 2u32), (1, 2));
+/// ```
+///
+/// However, a single argument with a trailing comma will still not be treated
+/// as a tuple, following the convention of ignoring trailing commas in macro
+/// invocations. You can use a 1-tuple directly if you need one:
+///
+/// ```
+/// # #[allow(clippy::dbg_macro)]
+/// # {
+/// assert_eq!(1, dbg!(1u32,)); // trailing comma ignored
+/// assert_eq!((1,), dbg!((1u32,))); // 1-tuple
+/// # }
+/// ```
+///
+/// [`std::dbg`]: https://doc.rust-lang.org/std/macro.dbg.html
+/// [`eprintln`]: https://doc.rust-lang.org/std/macro.eprintln.html
+/// [`printk`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html
+#[macro_export]
+macro_rules! dbg {
+    // NOTE: We cannot use `concat!` to make a static string as a format argument
+    // of `pr_info!` because `file!` could contain a `{` or
+    // `$val` expression could be a block (`{ .. }`), in which case the `pr_info!`
+    // will be malformed.
+    () => {
+        $crate::pr_info!("[{}:{}]\n", ::core::file!(), ::core::line!())
+    };
+    ($val:expr $(,)?) => {
+        // Use of `match` here is intentional because it affects the lifetimes
+        // of temporaries - https://stackoverflow.com/a/48732525/1063961
+        match $val {
+            tmp => {
+                $crate::pr_info!("[{}:{}] {} = {:#?}\n",
+                    ::core::file!(), ::core::line!(), ::core::stringify!($val), &tmp);
+                tmp
+            }
+        }
+    };
+    ($($val:expr),+ $(,)?) => {
+        ($($crate::dbg!($val)),+,)
+    };
+}
-- 
2.38.1

