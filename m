Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745CF640A5D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiLBQPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbiLBQPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:15:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D09AD304;
        Fri,  2 Dec 2022 08:15:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5FB8622E3;
        Fri,  2 Dec 2022 16:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2A7C433D6;
        Fri,  2 Dec 2022 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669997734;
        bh=7z0Z9/aBWDg8zSLO+3RcUCw+p+zedYDCyRSDGcvfevk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dE1pDe6w8AxHp1/+K2aWGBuvWfYhIil3ojm6M3ha2cTGjROUHYhV5MZv5ZQ62D8aa
         2k3udFmoViSaLrQ9t0zCAtQrLMc9maUZmei9Ek1ii4txa8cJjXziDFObCk6WGKItpK
         8tyiTKgbDMyFdavl2aXHURArQb2jpnYnT8DlEGzcEQN981dGDO9QInXsAkgDhjgmQ/
         iz7DJ8/gFMoQ/e19ii1gxoYR38d081jfG/nXpiJO5x83AIefLAsy0Qulh0ftPLWzdd
         OYZJPvj/hpwTCjiZV2rdqQSUMYuWEwHtJ+hYg6BD0uQRl7ehBBF9Ma6D99+rDkePl9
         P8tWFwmLCkMsw==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wei Liu <wei.liu@kernel.org>,
        Sergio Gonzalez Collado <sergio.collado@gmail.com>
Subject: [PATCH v2 02/28] rust: print: add more `pr_*!` levels
Date:   Fri,  2 Dec 2022 17:14:33 +0100
Message-Id: <20221202161502.385525-3-ojeda@kernel.org>
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

From: Miguel Ojeda <ojeda@kernel.org>

Currently, only `pr_info!` (for the minimal sample) and
`pr_emerg!` (for the panic handler) are there.

Add the other levels as new macros, i.e. `pr_alert!`, `pr_crit!`,
`pr_err!`, `pr_warn!`, `pr_notice!` and `pr_debug!`.

Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Sergio Gonzalez Collado <sergio.collado@gmail.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/prelude.rs |   2 +-
 rust/kernel/print.rs   | 154 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index f8219285d8c0..6a1c6b38327f 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -17,7 +17,7 @@ pub use alloc::{boxed::Box, vec::Vec};
 
 pub use macros::module;
 
-pub use super::{pr_emerg, pr_info};
+pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
 
 pub use super::error::{Error, Result};
 
diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index 55db5a1ba752..694f51c6da5c 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -74,7 +74,13 @@ pub mod format_strings {
     // Furthermore, `static` instead of `const` is used to share the strings
     // for all the kernel.
     pub static EMERG: [u8; LENGTH] = generate(false, bindings::KERN_EMERG);
+    pub static ALERT: [u8; LENGTH] = generate(false, bindings::KERN_ALERT);
+    pub static CRIT: [u8; LENGTH] = generate(false, bindings::KERN_CRIT);
+    pub static ERR: [u8; LENGTH] = generate(false, bindings::KERN_ERR);
+    pub static WARNING: [u8; LENGTH] = generate(false, bindings::KERN_WARNING);
+    pub static NOTICE: [u8; LENGTH] = generate(false, bindings::KERN_NOTICE);
     pub static INFO: [u8; LENGTH] = generate(false, bindings::KERN_INFO);
+    pub static DEBUG: [u8; LENGTH] = generate(false, bindings::KERN_DEBUG);
 }
 
 /// Prints a message via the kernel's [`_printk`].
@@ -172,6 +178,126 @@ macro_rules! pr_emerg (
     )
 );
 
+/// Prints an alert-level message (level 1).
+///
+/// Use this level if action must be taken immediately.
+///
+/// Equivalent to the kernel's [`pr_alert`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// `alloc::format!` for information about the formatting syntax.
+///
+/// [`pr_alert`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_alert
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// pr_alert!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_alert (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::ALERT, $($arg)*)
+    )
+);
+
+/// Prints a critical-level message (level 2).
+///
+/// Use this level for critical conditions.
+///
+/// Equivalent to the kernel's [`pr_crit`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// `alloc::format!` for information about the formatting syntax.
+///
+/// [`pr_crit`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_crit
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// pr_crit!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_crit (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::CRIT, $($arg)*)
+    )
+);
+
+/// Prints an error-level message (level 3).
+///
+/// Use this level for error conditions.
+///
+/// Equivalent to the kernel's [`pr_err`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// `alloc::format!` for information about the formatting syntax.
+///
+/// [`pr_err`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_err
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// pr_err!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_err (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::ERR, $($arg)*)
+    )
+);
+
+/// Prints a warning-level message (level 4).
+///
+/// Use this level for warning conditions.
+///
+/// Equivalent to the kernel's [`pr_warn`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// `alloc::format!` for information about the formatting syntax.
+///
+/// [`pr_warn`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_warn
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// pr_warn!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_warn (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::WARNING, $($arg)*)
+    )
+);
+
+/// Prints a notice-level message (level 5).
+///
+/// Use this level for normal but significant conditions.
+///
+/// Equivalent to the kernel's [`pr_notice`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// `alloc::format!` for information about the formatting syntax.
+///
+/// [`pr_notice`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_notice
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// pr_notice!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_notice (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::NOTICE, $($arg)*)
+    )
+);
+
 /// Prints an info-level message (level 6).
 ///
 /// Use this level for informational messages.
@@ -196,3 +322,31 @@ macro_rules! pr_info (
         $crate::print_macro!($crate::print::format_strings::INFO, $($arg)*)
     )
 );
+
+/// Prints a debug-level message (level 7).
+///
+/// Use this level for debug messages.
+///
+/// Equivalent to the kernel's [`pr_debug`] macro, except that it doesn't support dynamic debug
+/// yet.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// `alloc::format!` for information about the formatting syntax.
+///
+/// [`pr_debug`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_debug
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// pr_debug!("hello {}\n", "there");
+/// ```
+#[macro_export]
+#[doc(alias = "print")]
+macro_rules! pr_debug (
+    ($($arg:tt)*) => (
+        if cfg!(debug_assertions) {
+            $crate::print_macro!($crate::print::format_strings::DEBUG, $($arg)*)
+        }
+    )
+);
-- 
2.38.1

