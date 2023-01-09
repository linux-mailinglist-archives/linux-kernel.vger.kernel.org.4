Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546A66631D7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbjAIUtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbjAIUta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:49:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2008071FD4;
        Mon,  9 Jan 2023 12:49:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF5C861378;
        Mon,  9 Jan 2023 20:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6196C433EF;
        Mon,  9 Jan 2023 20:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673297367;
        bh=ZCpIfx/6UP52Vxj4R4wUhX+SXLNpHxh2VEnEZXQEJdM=;
        h=From:To:Cc:Subject:Date:From;
        b=tcY6SHNYWtmLB7FfBUj4VIUl8tjXhVpGGlMeqPQf0JkAo0Kz4SNiRNCFi1xgl8muN
         EC9vmwUiEY2A5JYQEJfBeVvfVpePlc7bSmmSqMsMYNDbTfMwZAhO8oL5saDewrCc40
         jdIwxVYtEA2W+7RSdmMVl5xfL92AWlbBhVgV7tdaFdt/qcwlJsqLimQCyhh4vnOqga
         DiE3NfjcmTDjajypQXosYv9zXvkrou0I5DG1DB/ubeYXRTZg4m6fC0io6ompOMzdMe
         KjymdCJ2KpPz/bolKYNvvTobcxp3L6tUK1JD4rGiGK3EVAeuGfNdg1RMHKTcrBqjkH
         KCniDREGSE6FQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Domen Puncer Kugler <domen.puncerkugler@nccgroup.com>
Subject: [PATCH] rust: print: avoid evaluating arguments in `pr_*` macros in `unsafe` blocks
Date:   Mon,  9 Jan 2023 21:49:12 +0100
Message-Id: <20230109204912.539790-1-ojeda@kernel.org>
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

At the moment it is possible to perform unsafe operations in
the arguments of `pr_*` macros since they are evaluated inside
an `unsafe` block:

    let x = &10u32 as *const u32;
    pr_info!("{}", *x);

In other words, this is a soundness issue.

Fix it so that it requires an explicit `unsafe` block.

Reported-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reported-by: Domen Puncer Kugler <domen.puncerkugler@nccgroup.com>
Link: https://github.com/Rust-for-Linux/linux/issues/479
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/print.rs | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index 29bf9c2e8aee..30103325696d 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -142,17 +142,24 @@ pub fn call_printk_cont(args: fmt::Arguments<'_>) {
 macro_rules! print_macro (
     // The non-continuation cases (most of them, e.g. `INFO`).
     ($format_string:path, false, $($arg:tt)+) => (
-        // SAFETY: This hidden macro should only be called by the documented
-        // printing macros which ensure the format string is one of the fixed
-        // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
-        // by the `module!` proc macro or fixed values defined in a kernel
-        // crate.
-        unsafe {
-            $crate::print::call_printk(
-                &$format_string,
-                crate::__LOG_PREFIX,
-                format_args!($($arg)+),
-            );
+        // To remain sound, `arg`s must be expanded outside the `unsafe` block.
+        // Typically one would use a `let` binding for that; however, `format_args!`
+        // takes borrows on the arguments, but does not extend the scope of temporaries.
+        // Therefore, a `match` expression is used to keep them around, since
+        // the scrutinee is kept until the end of the `match`.
+        match format_args!($($arg)+) {
+            // SAFETY: This hidden macro should only be called by the documented
+            // printing macros which ensure the format string is one of the fixed
+            // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
+            // by the `module!` proc macro or fixed values defined in a kernel
+            // crate.
+            args => unsafe {
+                $crate::print::call_printk(
+                    &$format_string,
+                    crate::__LOG_PREFIX,
+                    args,
+                );
+            }
         }
     );
 

base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
-- 
2.39.0

