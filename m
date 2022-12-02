Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5871640A77
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiLBQSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiLBQR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:17:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52ABE346E;
        Fri,  2 Dec 2022 08:16:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 062AF62325;
        Fri,  2 Dec 2022 16:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5FEC433D6;
        Fri,  2 Dec 2022 16:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669997801;
        bh=qf1L1f1lloAHjax2Q2sSNkOySbNmdgvi1HaQZKetkYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WjzCHS3ANJYDqZrQ1IviFl1Ud5lXAOhenxU8ghqXN/mYT6AI55VhO4q9g1G9mrL1F
         ZQ4jDtc6AffEVqiRMiy5kJLphb/244aEflV/t9SWPY2+aTKo7//vojphYskIh3VU8i
         VYxhqMWJbNHgYGbWVFWDVq/him1fQMyTfd6ifXX0nwh6hnFJ7YqPZK8x7Tq4JmaM4M
         +cEPAQdrv5m1FC8xIASmAiiDdrILsj4e9kPRm29RW33nxwlYwCnFPb11XIAl/31qp2
         LTjUJ9iYrUJOs+Yq6LKCdtNiRMdk8IXxZoVjSJfH3EHbXJwreyUxQFj0X9NVr3BKe9
         uTBASa7Q6VrdA==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v2 26/28] rust: build_assert: add `build_{error,assert}!` macros
Date:   Fri,  2 Dec 2022 17:14:57 +0100
Message-Id: <20221202161502.385525-27-ojeda@kernel.org>
In-Reply-To: <20221202161502.385525-1-ojeda@kernel.org>
References: <20221202161502.385525-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gary Guo <gary@garyguo.net>

Add the `build_error!` and `build_assert!` macros which leverage
the previously introduced `build_error` crate. Do so in a new
module, called `build_assert`.

The former fails the build if the code path calling it can possibly
be executed. The latter asserts that a boolean expression is `true`
at compile time.

In particular, `build_assert!` can be used in some contexts where
`static_assert!` cannot:

    fn f1<const N: usize>() {
        static_assert!(N > 1);` // Error.
        build_assert!(N > 1);   // Build-time check.
        assert!(N > 1);         // Run-time check.
    }

    #[inline]
    fn f2(n: usize) {
        static_assert!(n > 1);  // Error.
        build_assert!(n > 1);   // Build-time check.
        assert!(n > 1);         // Run-time check.
    }

Signed-off-by: Gary Guo <gary@garyguo.net>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/build_assert.rs | 82 +++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs          |  4 ++
 rust/kernel/prelude.rs      |  2 +
 3 files changed, 88 insertions(+)
 create mode 100644 rust/kernel/build_assert.rs

diff --git a/rust/kernel/build_assert.rs b/rust/kernel/build_assert.rs
new file mode 100644
index 000000000000..659542393c09
--- /dev/null
+++ b/rust/kernel/build_assert.rs
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Build-time assert.
+
+/// Fails the build if the code path calling `build_error!` can possibly be executed.
+///
+/// If the macro is executed in const context, `build_error!` will panic.
+/// If the compiler or optimizer cannot guarantee that `build_error!` can never
+/// be called, a build error will be triggered.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::build_error;
+/// #[inline]
+/// fn foo(a: usize) -> usize {
+///     a.checked_add(1).unwrap_or_else(|| build_error!("overflow"))
+/// }
+///
+/// assert_eq!(foo(usize::MAX - 1), usize::MAX); // OK.
+/// // foo(usize::MAX); // Fails to compile.
+/// ```
+#[macro_export]
+macro_rules! build_error {
+    () => {{
+        $crate::build_error("")
+    }};
+    ($msg:expr) => {{
+        $crate::build_error($msg)
+    }};
+}
+
+/// Asserts that a boolean expression is `true` at compile time.
+///
+/// If the condition is evaluated to `false` in const context, `build_assert!`
+/// will panic. If the compiler or optimizer cannot guarantee the condition will
+/// be evaluated to `true`, a build error will be triggered.
+///
+/// [`static_assert!`] should be preferred to `build_assert!` whenever possible.
+///
+/// # Examples
+///
+/// These examples show that different types of [`assert!`] will trigger errors
+/// at different stage of compilation. It is preferred to err as early as
+/// possible, so [`static_assert!`] should be used whenever possible.
+/// ```ignore
+/// fn foo() {
+///     static_assert!(1 > 1); // Compile-time error
+///     build_assert!(1 > 1); // Build-time error
+///     assert!(1 > 1); // Run-time error
+/// }
+/// ```
+///
+/// When the condition refers to generic parameters or parameters of an inline function,
+/// [`static_assert!`] cannot be used. Use `build_assert!` in this scenario.
+/// ```
+/// fn foo<const N: usize>() {
+///     // `static_assert!(N > 1);` is not allowed
+///     build_assert!(N > 1); // Build-time check
+///     assert!(N > 1); // Run-time check
+/// }
+///
+/// #[inline]
+/// fn bar(n: usize) {
+///     // `static_assert!(n > 1);` is not allowed
+///     build_assert!(n > 1); // Build-time check
+///     assert!(n > 1); // Run-time check
+/// }
+/// ```
+#[macro_export]
+macro_rules! build_assert {
+    ($cond:expr $(,)?) => {{
+        if !$cond {
+            $crate::build_error(concat!("assertion failed: ", stringify!($cond)));
+        }
+    }};
+    ($cond:expr, $msg:expr) => {{
+        if !$cond {
+            $crate::build_error($msg);
+        }
+    }};
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 9b83ef736298..a3abc110ff97 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -23,6 +23,7 @@ compile_error!("Missing kernel configuration for conditional compilation");
 #[cfg(not(test))]
 #[cfg(not(testlib))]
 mod allocator;
+mod build_assert;
 pub mod error;
 pub mod prelude;
 pub mod print;
@@ -35,6 +36,9 @@ pub mod str;
 pub use bindings;
 pub use macros;
 
+#[doc(hidden)]
+pub use build_error::build_error;
+
 /// Prefix to appear before log messages printed from within the `kernel` crate.
 const __LOG_PREFIX: &[u8] = b"rust_kernel\0";
 
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 178fe8e6cb6d..7a90249ee9b9 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -17,6 +17,8 @@ pub use alloc::{boxed::Box, vec::Vec};
 
 pub use macros::{module, vtable};
 
+pub use super::build_assert;
+
 pub use super::{dbg, pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
 
 pub use super::static_assert;
-- 
2.38.1

