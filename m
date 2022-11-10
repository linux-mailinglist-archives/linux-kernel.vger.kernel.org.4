Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F39624741
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiKJQmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiKJQmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:42:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923BD419BA;
        Thu, 10 Nov 2022 08:42:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E06EB82248;
        Thu, 10 Nov 2022 16:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61E9C433D6;
        Thu, 10 Nov 2022 16:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668098550;
        bh=QKUPnCuSt4qJQagjKlcEHWgf/R6XA/d08OIKtNrfC4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kFHRJ3LLht4uHqTvA2yMYuD/T2ka6ewc6LmTvqWp/68elWBdnjquvKyqAxmYBXycR
         JyriAUY2Fen5o1iJDBbRbKP3Gh/RwSX5mD/geMGKy5yU936R9Jfif7tnxrHPIwXXZi
         /Nrvl41iIzXpoTwzDxD7UpP6SpynDlu2ttxQzbpJ8r9tMGEO2zIQGAysutNJ5qpalX
         HiURkpjwPpoALI/3J8kEr8nggzmSlt8QAOW7jc4BKbV5MuMVqAqj2W44PU2eBH7jFn
         TGii7XSktwWnUtD+PnjNYXPrxGMzDYfrZv+KXdjsKOGnr3N5N8XBdhBbh/C5JXm1Pp
         GoZG9rfnKihnA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v1 04/28] rust: samples: add `rust_print` example
Date:   Thu, 10 Nov 2022 17:41:16 +0100
Message-Id: <20221110164152.26136-5-ojeda@kernel.org>
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

Add example to exercise the printing macros (`pr_*!`) introduced
in the previous patches.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 samples/rust/Kconfig       | 10 +++++++
 samples/rust/Makefile      |  1 +
 samples/rust/rust_print.rs | 54 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 samples/rust/rust_print.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 841e0906e943..b0f74a81c8f9 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -20,6 +20,16 @@ config SAMPLE_RUST_MINIMAL
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_PRINT
+	tristate "Printing macros"
+	help
+	  This option builds the Rust printing macros sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_print.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_HOSTPROGS
 	bool "Host programs"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 1daba5f8658a..03086dabbea4 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
+obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
 
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
new file mode 100644
index 000000000000..09f737790f3f
--- /dev/null
+++ b/samples/rust/rust_print.rs
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust printing macros sample.
+
+use kernel::pr_cont;
+use kernel::prelude::*;
+
+module! {
+    type: RustPrint,
+    name: b"rust_print",
+    author: b"Rust for Linux Contributors",
+    description: b"Rust printing macros sample",
+    license: b"GPL",
+}
+
+struct RustPrint;
+
+impl kernel::Module for RustPrint {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust printing macros sample (init)\n");
+
+        pr_emerg!("Emergency message (level 0) without args\n");
+        pr_alert!("Alert message (level 1) without args\n");
+        pr_crit!("Critical message (level 2) without args\n");
+        pr_err!("Error message (level 3) without args\n");
+        pr_warn!("Warning message (level 4) without args\n");
+        pr_notice!("Notice message (level 5) without args\n");
+        pr_info!("Info message (level 6) without args\n");
+
+        pr_info!("A line that");
+        pr_cont!(" is continued");
+        pr_cont!(" without args\n");
+
+        pr_emerg!("{} message (level {}) with args\n", "Emergency", 0);
+        pr_alert!("{} message (level {}) with args\n", "Alert", 1);
+        pr_crit!("{} message (level {}) with args\n", "Critical", 2);
+        pr_err!("{} message (level {}) with args\n", "Error", 3);
+        pr_warn!("{} message (level {}) with args\n", "Warning", 4);
+        pr_notice!("{} message (level {}) with args\n", "Notice", 5);
+        pr_info!("{} message (level {}) with args\n", "Info", 6);
+
+        pr_info!("A {} that", "line");
+        pr_cont!(" is {}", "continued");
+        pr_cont!(" with {}\n", "args");
+
+        Ok(RustPrint)
+    }
+}
+
+impl Drop for RustPrint {
+    fn drop(&mut self) {
+        pr_info!("Rust printing macros sample (exit)\n");
+    }
+}
-- 
2.38.1

