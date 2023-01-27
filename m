Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCA767ED8B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjA0S3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbjA0S3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:29:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1031E8661D;
        Fri, 27 Jan 2023 10:29:11 -0800 (PST)
Date:   Fri, 27 Jan 2023 18:26:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674844017;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7jgNMHq14Xe7rRTeyNKhv1BS2HLRk4TqMnnGO7FHEqM=;
        b=isTLEb4O/nivlakQQC4lZqa91cfKpYkr1V9Gqx3ToLsKhT4MVmDjvob2465CitPrL8O7Hs
        IWKwlYLtiKjLRgePCJHD4Bl0D0aG7qV6pu2Ia0dEkCgvcldRgiRYYFd1PH5//8TXuJfc5R
        +JFNg57xe7u2eOTVmWm4MdAnpMDoLNBq11NlUEbC6EmqfON0+BtE6tabuwoToBwMSBPDc3
        mLgHo53B8J6snEQbgjwLoVaASNlBHRCSFolCHZ211Ku+1NCVXttc2oqXE+xqLnp+1GBQKu
        fd7gFk3rZfpKX690QfttyYLAk3Me30YAYn68f7MmnJaYZ3L379LSTSnKLr/tCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674844017;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7jgNMHq14Xe7rRTeyNKhv1BS2HLRk4TqMnnGO7FHEqM=;
        b=KyRbaeFDrt8DUNJmbKUZm5cnr2OTMQbRdO/2yBPdae54MIGl+g09BP67FmUFholeHOJbMw
        YcsU4F8YOOtxPgBA==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Add more registers to struct tdx_hypercall_args
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167484401713.4906.10547453863607764127.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     0da908c291070d89482f6211dbe81d4d43c3f7cb
Gitweb:        https://git.kernel.org/tip/0da908c291070d89482f6211dbe81d4d43c3f7cb
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 27 Jan 2023 01:11:54 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 27 Jan 2023 09:42:09 -08:00

x86/tdx: Add more registers to struct tdx_hypercall_args

struct tdx_hypercall_args is used to pass down hypercall arguments to
__tdx_hypercall() assembly routine.

Currently __tdx_hypercall() handles up to 6 arguments. In preparation to
changes in __tdx_hypercall(), expand the structure to 6 more registers
and generate asm offsets for them.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230126221159.8635-3-kirill.shutemov%40linux.intel.com
---
 arch/x86/include/asm/shared/tdx.h | 6 ++++++
 arch/x86/kernel/asm-offsets.c     | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index e53f262..8068faa 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -22,12 +22,18 @@
  * This is a software only structure and not part of the TDX module/VMM ABI.
  */
 struct tdx_hypercall_args {
+	u64 r8;
+	u64 r9;
 	u64 r10;
 	u64 r11;
 	u64 r12;
 	u64 r13;
 	u64 r14;
 	u64 r15;
+	u64 rdi;
+	u64 rsi;
+	u64 rbx;
+	u64 rdx;
 };
 
 /* Used to request services from the VMM */
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 82c783d..8650f29 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -75,12 +75,18 @@ static void __used common(void)
 	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
 
 	BLANK();
+	OFFSET(TDX_HYPERCALL_r8,  tdx_hypercall_args, r8);
+	OFFSET(TDX_HYPERCALL_r9,  tdx_hypercall_args, r9);
 	OFFSET(TDX_HYPERCALL_r10, tdx_hypercall_args, r10);
 	OFFSET(TDX_HYPERCALL_r11, tdx_hypercall_args, r11);
 	OFFSET(TDX_HYPERCALL_r12, tdx_hypercall_args, r12);
 	OFFSET(TDX_HYPERCALL_r13, tdx_hypercall_args, r13);
 	OFFSET(TDX_HYPERCALL_r14, tdx_hypercall_args, r14);
 	OFFSET(TDX_HYPERCALL_r15, tdx_hypercall_args, r15);
+	OFFSET(TDX_HYPERCALL_rdi, tdx_hypercall_args, rdi);
+	OFFSET(TDX_HYPERCALL_rsi, tdx_hypercall_args, rsi);
+	OFFSET(TDX_HYPERCALL_rbx, tdx_hypercall_args, rbx);
+	OFFSET(TDX_HYPERCALL_rdx, tdx_hypercall_args, rdx);
 
 	BLANK();
 	OFFSET(BP_scratch, boot_params, scratch);
