Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560CC624740
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiKJQmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiKJQma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:42:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AEF42F77;
        Thu, 10 Nov 2022 08:42:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1016EB82248;
        Thu, 10 Nov 2022 16:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5ECC433D7;
        Thu, 10 Nov 2022 16:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668098546;
        bh=cjfwm/dXZDtpPVV3XayAZky4PejRTuNQmN9tC2oXScc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/hIsu7eDFQZTGjIfhDw5l3TF9VIwHNr2Q6T1YCb0aacp6+nyTgNDM5KKbqHkb1ub
         Y0bjGjL+6TmWY9djH4F8AQ0EXw28chJgkIo27ooUIf1NA9P8mxht0f6yZmTj9RwX7N
         QfFx8RAcFzip9FEN4jmiuqaJM9DdfcG2jZVCIDmOGAyiBFfXB8mAQrIU+hSHC5WzQd
         fruKavWcmD2TRAr3Zw4RZId5zaC3MiLPVW9pxxNKNdhf426JNE/lTPBMsyXHRJkTPK
         ktLOW+3/N4UiDnnSigIj5l20WHq3z8Li2GTWl63hT05c9rhFLB7tEUHB/u7EYOcguE
         mvle2s5YdcMYg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: [PATCH v1 03/28] rust: print: add `pr_cont!` macro
Date:   Thu, 10 Nov 2022 17:41:15 +0100
Message-Id: <20221110164152.26136-4-ojeda@kernel.org>
In-Reply-To: <20221110164152.26136-1-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
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

This level is a bit different from the rest since it does not
pass the module name to the `_printk()` call.

Thus add a new parameter to the general `print_macro!` to
handle it differently.

Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/print.rs | 72 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index 694f51c6da5c..29bf9c2e8aee 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -81,6 +81,7 @@ pub mod format_strings {
     pub static NOTICE: [u8; LENGTH] = generate(false, bindings::KERN_NOTICE);
     pub static INFO: [u8; LENGTH] = generate(false, bindings::KERN_INFO);
     pub static DEBUG: [u8; LENGTH] = generate(false, bindings::KERN_DEBUG);
+    pub static CONT: [u8; LENGTH] = generate(true, bindings::KERN_CONT);
 }
 
 /// Prints a message via the kernel's [`_printk`].
@@ -111,6 +112,26 @@ pub unsafe fn call_printk(
     }
 }
 
+/// Prints a message via the kernel's [`_printk`] for the `CONT` level.
+///
+/// Public but hidden since it should only be used from public macros.
+///
+/// [`_printk`]: ../../../../include/linux/printk.h
+#[doc(hidden)]
+#[cfg_attr(not(CONFIG_PRINTK), allow(unused_variables))]
+pub fn call_printk_cont(args: fmt::Arguments<'_>) {
+    // `_printk` does not seem to fail in any path.
+    //
+    // SAFETY: The format string is fixed.
+    #[cfg(CONFIG_PRINTK)]
+    unsafe {
+        bindings::_printk(
+            format_strings::CONT.as_ptr() as _,
+            &args as *const _ as *const c_void,
+        );
+    }
+}
+
 /// Performs formatting and forwards the string to [`call_printk`].
 ///
 /// Public but hidden since it should only be used from public macros.
@@ -120,7 +141,7 @@ pub unsafe fn call_printk(
 #[allow(clippy::crate_in_macro_def)]
 macro_rules! print_macro (
     // The non-continuation cases (most of them, e.g. `INFO`).
-    ($format_string:path, $($arg:tt)+) => (
+    ($format_string:path, false, $($arg:tt)+) => (
         // SAFETY: This hidden macro should only be called by the documented
         // printing macros which ensure the format string is one of the fixed
         // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
@@ -134,6 +155,13 @@ macro_rules! print_macro (
             );
         }
     );
+
+    // The `CONT` case.
+    ($format_string:path, true, $($arg:tt)+) => (
+        $crate::print::call_printk_cont(
+            format_args!($($arg)+),
+        );
+    );
 );
 
 /// Stub for doctests
@@ -174,7 +202,7 @@ macro_rules! print_macro (
 #[macro_export]
 macro_rules! pr_emerg (
     ($($arg:tt)*) => (
-        $crate::print_macro!($crate::print::format_strings::EMERG, $($arg)*)
+        $crate::print_macro!($crate::print::format_strings::EMERG, false, $($arg)*)
     )
 );
 
@@ -198,7 +226,7 @@ macro_rules! pr_emerg (
 #[macro_export]
 macro_rules! pr_alert (
     ($($arg:tt)*) => (
-        $crate::print_macro!($crate::print::format_strings::ALERT, $($arg)*)
+        $crate::print_macro!($crate::print::format_strings::ALERT, false, $($arg)*)
     )
 );
 
@@ -222,7 +250,7 @@ macro_rules! pr_alert (
 #[macro_export]
 macro_rules! pr_crit (
     ($($arg:tt)*) => (
-        $crate::print_macro!($crate::print::format_strings::CRIT, $($arg)*)
+        $crate::print_macro!($crate::print::format_strings::CRIT, false, $($arg)*)
     )
 );
 
@@ -246,7 +274,7 @@ macro_rules! pr_crit (
 #[macro_export]
 macro_rules! pr_err (
     ($($arg:tt)*) => (
-        $crate::print_macro!($crate::print::format_strings::ERR, $($arg)*)
+        $crate::print_macro!($crate::print::format_strings::ERR, false, $($arg)*)
     )
 );
 
@@ -270,7 +298,7 @@ macro_rules! pr_err (
 #[macro_export]
 macro_rules! pr_warn (
     ($($arg:tt)*) => (
-        $crate::print_macro!($crate::print::format_strings::WARNING, $($arg)*)
+        $crate::print_macro!($crate::print::format_strings::WARNING, false, $($arg)*)
     )
 );
 
@@ -294,7 +322,7 @@ macro_rules! pr_warn (
 #[macro_export]
 macro_rules! pr_notice (
     ($($arg:tt)*) => (
-        $crate::print_macro!($crate::print::format_strings::NOTICE, $($arg)*)
+        $crate::print_macro!($crate::print::format_strings::NOTICE, false, $($arg)*)
     )
 );
 
@@ -319,7 +347,7 @@ macro_rules! pr_notice (
 #[doc(alias = "print")]
 macro_rules! pr_info (
     ($($arg:tt)*) => (
-        $crate::print_macro!($crate::print::format_strings::INFO, $($arg)*)
+        $crate::print_macro!($crate::print::format_strings::INFO, false, $($arg)*)
     )
 );
 
@@ -346,7 +374,33 @@ macro_rules! pr_info (
 macro_rules! pr_debug (
     ($($arg:tt)*) => (
         if cfg!(debug_assertions) {
-            $crate::print_macro!($crate::print::format_strings::DEBUG, $($arg)*)
+            $crate::print_macro!($crate::print::format_strings::DEBUG, false, $($arg)*)
         }
     )
 );
+
+/// Continues a previous log message in the same line.
+///
+/// Use only when continuing a previous `pr_*!` macro (e.g. [`pr_info!`]).
+///
+/// Equivalent to the kernel's [`pr_cont`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// `alloc::format!` for information about the formatting syntax.
+///
+/// [`pr_cont`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_cont
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::pr_cont;
+/// pr_info!("hello");
+/// pr_cont!(" {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_cont (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::CONT, true, $($arg)*)
+    )
+);
-- 
2.38.1

