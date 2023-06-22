Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD1473A8F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjFVTZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFVTZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:25:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D8B1A3;
        Thu, 22 Jun 2023 12:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2A7A618CA;
        Thu, 22 Jun 2023 19:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43D05C433C0;
        Thu, 22 Jun 2023 19:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687461923;
        bh=DpV1m3VEHFOes2TUjDBtDPABaVhpRNU+dlU1LJCoRtM=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=fX6kG/ogkrN4lylzbfksV9G6PagfGjGR/PgOqXmNGI/wjKhp541ST0Jtt/v2c85zo
         kbzu+9aap0O5bQ7WEEeC9uo7zzMSOnoZpbMjUFkLdGj0rVY6LsVZJHeQo8PjrW6YDu
         mXCHk5ghmDkBJgitaGjnkcR7MJh2bry8FNvFCiTZn9jgCFgFYk+Bbf/qImhxggrtWB
         HsR5LoNC5hYjJMYc8pK6oTnFGI0PAvlPildX6Xia0X4yCCcfIY0jm0x7rJF0gDygAV
         gXJCR6vKTgiQqYvSP0vHk9jOtHOAMQBFRtCNBIrMPE+5UNnkeQA+RnWQ9yl+OuAK2g
         74W/ATqeCEOrQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 249BDEB64DA;
        Thu, 22 Jun 2023 19:25:23 +0000 (UTC)
From:   =?utf-8?q?Bj=C3=B6rn?= Roy Baron via B4 Relay 
        <devnull+bjorn3_gh.protonmail.com@kernel.org>
Date:   Thu, 22 Jun 2023 21:24:40 +0200
Subject: [PATCH] rust: alloc: Add realloc and alloc_zeroed to the
 GlobalAlloc impl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230622-global_alloc_methods-v1-1-3d3561593e23@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAPeflGQC/x2N0QqDMAwAf0XyvICrOMZ+ZQxJ2mgLXTuaOgTx3
 1f3eBzH7aBSgig8uh2KfIOGnBpcLx1YT2kRDK4xmN4M/c0YXGJmihPFmO30luqzUySeRx5luDs
 maCmTCnKhZP0Zl1UrJtnq6T5F5rD9l8/XcfwAwBIEP4IAAAA=
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687461921; l=1764;
 i=bjorn3_gh@protonmail.com; s=20230622; h=from:subject:message-id;
 bh=M9xHvSYYCEDVh9+hr5YwUYJxj2f5jgjrI/bZdGQDX+8=;
 b=Uc+YPwcRyWhLPWVXHVbl9sDKW/vsIauXT/uasYNYN/UJvZyOEGqrkYHZeuUTIFQQr3HioDaU7
 z60y8bv6qypAXeUx+ukjus+tQp2WW0xph9OU58grNqnqpQtUCukuqDY
X-Developer-Key: i=bjorn3_gh@protonmail.com; a=ed25519;
 pk=tXjaafs1PnnuO6sr/Z6Wl6BuT7c22k9Rf9fpX863CJs=
X-Endpoint-Received: by B4 Relay for bjorn3_gh@protonmail.com/20230622 with auth_id=55
X-Original-From: =?utf-8?q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Reply-To: <bjorn3_gh@protonmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Roy Baron <bjorn3_gh@protonmail.com>

While there are default impls for these methods, using the respective C
api's is faster. Currently neither the existing nor these new
GlobalAlloc method implementations are actually called. Instead the
__rust_* function defined below the GlobalAlloc impl are used. With
rustc 1.71 these functions will be gone and all allocation calls will go
through the GlobalAlloc implementation.

Link: https://github.com/Rust-for-Linux/linux/issues/68
Signed-off-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
---
 rust/kernel/allocator.rs | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
index 397a3dd57a9b..e0a27b1326b5 100644
--- a/rust/kernel/allocator.rs
+++ b/rust/kernel/allocator.rs
@@ -21,6 +21,26 @@ unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
             bindings::kfree(ptr as *const core::ffi::c_void);
         }
     }
+
+    unsafe fn realloc(&self, ptr: *mut u8, _layout: Layout, new_size: usize) -> *mut u8 {
+        unsafe {
+            bindings::krealloc(
+                ptr as *const core::ffi::c_void,
+                new_size,
+                bindings::GFP_KERNEL,
+            ) as *mut u8
+        }
+    }
+
+    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
+        unsafe {
+            bindings::krealloc(
+                core::ptr::null(),
+                layout.size(),
+                bindings::GFP_KERNEL | bindings::__GFP_ZERO,
+            ) as *mut u8
+        }
+    }
 }
 
 #[global_allocator]

---
base-commit: d2e3115d717197cb2bc020dd1f06b06538474ac3
change-id: 20230622-global_alloc_methods-abf5b5e38dba

Best regards,
-- 
Björn Roy Baron <bjorn3_gh@protonmail.com>

