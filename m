Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAADD74CFAF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjGJIPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjGJIOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:14:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDD7EB;
        Mon, 10 Jul 2023 01:13:59 -0700 (PDT)
Date:   Mon, 10 Jul 2023 08:13:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688976838;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MAG37qGGr89k2BFEqvKK2pP+ysq9/blpIRKXNezQDpM=;
        b=YNegB55Q8trvUS38HZRYSvqMvSXKrFhEG4PHFl8JQ0NgY0VTqXDSkcLAWLkKb9CPa+xhLt
        tSmuxE/ghtPc+SkR35LMdrm0DKkHNz+WYgw1A98dzGD9Of5M+Is99tPqojL/rDzqXqcD3A
        hi/o8ArTdqpv9M5sQJdFi65kLqEDCtmCii1+lgQDwVFGh7geIIm3kvmVhJaJyq2R15P4Er
        li7ikxcDj5JSjW1fURi63PS8M8Gr/NNgCvXmpA1bWkBbhy0ZRe9vQ1uG2yk6FgFST4Mhy3
        KNfPZm65rq5Qq+TTtmgkZRQ2i6Dn/wFnlIfBbdRXvAsezbM592R3+3lzR63tyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688976838;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MAG37qGGr89k2BFEqvKK2pP+ysq9/blpIRKXNezQDpM=;
        b=e5z/H/Bhv0y1UXvQf3ylLo14qnwFwhuP7KD3INIQYOVt5LLjSwzKnAavHNpBIrEAVengz+
        0ZhamlCiz+4/bZDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cfi: Extend ENDBR sealing to kCFI
Cc:     Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168897683742.404.15642618384381262204.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9831c6253ace48051189f6d18a15f658f94babc2
Gitweb:        https://git.kernel.org/tip/9831c6253ace48051189f6d18a15f658f94babc2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 21 Jun 2023 22:17:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 10 Jul 2023 09:52:24 +02:00

x86/cfi: Extend ENDBR sealing to kCFI

Kees noted that IBT sealing could be extended to kCFI.

Fundamentally it is the list of functions that do not have their
address taken and are thus never called indirectly. It doesn't matter
that objtool uses IBT infrastructure to determine this list, once we
have it it can also be used to clobber kCFI hashes and avoid kCFI
indirect calls.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lkml.kernel.org/r/20230622144321.494426891%40infradead.org
---
 arch/x86/kernel/alternative.c | 44 +++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 27e0cb4..04b25a2 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -778,6 +778,8 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
+static void poison_cfi(void *addr);
+
 static void __init_or_module poison_endbr(void *addr, bool warn)
 {
 	u32 endbr, poison = gen_endbr_poison();
@@ -802,6 +804,9 @@ static void __init_or_module poison_endbr(void *addr, bool warn)
 
 /*
  * Generated by: objtool --ibt
+ *
+ * Seal the functions for indirect calls by clobbering the ENDBR instructions
+ * and the kCFI hash value.
  */
 void __init_or_module noinline apply_seal_endbr(s32 *start, s32 *end)
 {
@@ -812,7 +817,7 @@ void __init_or_module noinline apply_seal_endbr(s32 *start, s32 *end)
 
 		poison_endbr(addr, true);
 		if (IS_ENABLED(CONFIG_FINEIBT))
-			poison_endbr(addr - 16, false);
+			poison_cfi(addr - 16);
 	}
 }
 
@@ -1177,6 +1182,41 @@ err:
 	pr_err("Something went horribly wrong trying to rewrite the CFI implementation.\n");
 }
 
+static inline void poison_hash(void *addr)
+{
+	*(u32 *)addr = 0;
+}
+
+static void poison_cfi(void *addr)
+{
+	switch (cfi_mode) {
+	case CFI_FINEIBT:
+		/*
+		 * __cfi_\func:
+		 *	osp nopl (%rax)
+		 *	subl	$0, %r10d
+		 *	jz	1f
+		 *	ud2
+		 * 1:	nop
+		 */
+		poison_endbr(addr, false);
+		poison_hash(addr + fineibt_preamble_hash);
+		break;
+
+	case CFI_KCFI:
+		/*
+		 * __cfi_\func:
+		 *	movl	$0, %eax
+		 *	.skip	11, 0x90
+		 */
+		poison_hash(addr + 1);
+		break;
+
+	default:
+		break;
+	}
+}
+
 #else
 
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
@@ -1184,6 +1224,8 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 {
 }
 
+static void poison_cfi(void *addr) { }
+
 #endif
 
 void apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
