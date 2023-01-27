Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4317F67ED86
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbjA0S2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjA0S2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:28:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8428307E;
        Fri, 27 Jan 2023 10:27:31 -0800 (PST)
Date:   Fri, 27 Jan 2023 18:26:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674844016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vZz46/zKEqjuMdOjPGVkBu/Ab+eqSCP/7KJ1e+eGqYY=;
        b=J5WZFRntb/WmCv+UvlchWVmzi9i+Cx591gLmBXtvF07i/QhtLsSlVVVvgmglM9KoBbqryr
        DfuaVxrm3118Qm/8D7yP8zir/hQqK64kNePNyL8f0PkDZwraUsJlW3j3BQnemd54RM+vos
        auZIVSMuqdnNUWyzFyH+le5S6b1f9wLmfqRJTeN5vfGw6v5jTPYBPKeIrfQpkqhZ0voyyJ
        Fmov2xGs3V35S1XBjcF4qf66UgdnohZeq0XDJNQOVaGxR3xQMDrYGRTYqWBAI3zgU17jbS
        OmQt9wX0Q5G1zrro1eTLLUgebQIbp9/aU/7EYnjRRFdnPHRhru7v7Y34WGVSIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674844016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vZz46/zKEqjuMdOjPGVkBu/Ab+eqSCP/7KJ1e+eGqYY=;
        b=RGZYMDtgd/UiBCD4abmvfKIDjsmM8s2d2hPoIuOn1SojMIrlEjZ3sYWPjbyvwjISWH9l6B
        AURveOSkwl88axBg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Expand __tdx_hypercall() to handle more arguments
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167484401655.4906.15408746079052714467.tip-bot2@tip-bot2>
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

Commit-ID:     752d13305c78b2f0f0d783132f94acc9ce93d38e
Gitweb:        https://git.kernel.org/tip/752d13305c78b2f0f0d783132f94acc9ce93d38e
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 27 Jan 2023 01:11:56 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 27 Jan 2023 09:42:09 -08:00

x86/tdx: Expand __tdx_hypercall() to handle more arguments

So far __tdx_hypercall() only handles six arguments for VMCALL.
Expanding it to six more register would allow to cover more use-cases
like ReportFatalError() and Hyper-V hypercalls.

With all preparations in place, the expansion is pretty straight
forward.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230126221159.8635-5-kirill.shutemov%40linux.intel.com
---
 arch/x86/coco/tdx/tdcall.S | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index a9bb4cb..5da06d1 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -13,6 +13,12 @@
 /*
  * Bitmasks of exposed registers (with VMM).
  */
+#define TDX_RDX		BIT(2)
+#define TDX_RBX		BIT(3)
+#define TDX_RSI		BIT(6)
+#define TDX_RDI		BIT(7)
+#define TDX_R8		BIT(8)
+#define TDX_R9		BIT(9)
 #define TDX_R10		BIT(10)
 #define TDX_R11		BIT(11)
 #define TDX_R12		BIT(12)
@@ -27,9 +33,9 @@
  * details can be found in TDX GHCI specification, section
  * titled "TDCALL [TDG.VP.VMCALL] leaf".
  */
-#define TDVMCALL_EXPOSE_REGS_MASK	( TDX_R10 | TDX_R11 | \
-					  TDX_R12 | TDX_R13 | \
-					  TDX_R14 | TDX_R15 )
+#define TDVMCALL_EXPOSE_REGS_MASK	\
+	( TDX_RDX | TDX_RBX | TDX_RSI | TDX_RDI | TDX_R8  | TDX_R9  | \
+	  TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13 | TDX_R14 | TDX_R15 )
 
 /*
  * __tdx_module_call()  - Used by TDX guests to request services from
@@ -124,6 +130,7 @@ SYM_FUNC_START(__tdx_hypercall)
 	push %r14
 	push %r13
 	push %r12
+	push %rbx
 	push %rbp
 
 	/* Free RDI and RSI to be used as TDVMCALL arguments */
@@ -131,12 +138,18 @@ SYM_FUNC_START(__tdx_hypercall)
 	movq %rsi, %rbp
 
 	/* Copy hypercall registers from arg struct: */
+	movq TDX_HYPERCALL_r8(%rax),  %r8
+	movq TDX_HYPERCALL_r9(%rax),  %r9
 	movq TDX_HYPERCALL_r10(%rax), %r10
 	movq TDX_HYPERCALL_r11(%rax), %r11
 	movq TDX_HYPERCALL_r12(%rax), %r12
 	movq TDX_HYPERCALL_r13(%rax), %r13
 	movq TDX_HYPERCALL_r14(%rax), %r14
 	movq TDX_HYPERCALL_r15(%rax), %r15
+	movq TDX_HYPERCALL_rdi(%rax), %rdi
+	movq TDX_HYPERCALL_rsi(%rax), %rsi
+	movq TDX_HYPERCALL_rbx(%rax), %rbx
+	movq TDX_HYPERCALL_rdx(%rax), %rdx
 
 	push %rax
 
@@ -178,12 +191,18 @@ SYM_FUNC_START(__tdx_hypercall)
 	testq $TDX_HCALL_HAS_OUTPUT, %rbp
 	jz .Lout
 
+	movq %r8,  TDX_HYPERCALL_r8(%rax)
+	movq %r9,  TDX_HYPERCALL_r9(%rax)
 	movq %r10, TDX_HYPERCALL_r10(%rax)
 	movq %r11, TDX_HYPERCALL_r11(%rax)
 	movq %r12, TDX_HYPERCALL_r12(%rax)
 	movq %r13, TDX_HYPERCALL_r13(%rax)
 	movq %r14, TDX_HYPERCALL_r14(%rax)
 	movq %r15, TDX_HYPERCALL_r15(%rax)
+	movq %rdi, TDX_HYPERCALL_rdi(%rax)
+	movq %rsi, TDX_HYPERCALL_rsi(%rax)
+	movq %rbx, TDX_HYPERCALL_rbx(%rax)
+	movq %rdx, TDX_HYPERCALL_rdx(%rax)
 .Lout:
 	/* TDVMCALL leaf return code is in R10 */
 	movq %r10, %rax
@@ -191,14 +210,20 @@ SYM_FUNC_START(__tdx_hypercall)
 	/*
 	 * Zero out registers exposed to the VMM to avoid speculative execution
 	 * with VMM-controlled values. This needs to include all registers
-	 * present in TDVMCALL_EXPOSE_REGS_MASK (except R12-R15). R12-R15
-	 * context will be restored.
+	 * present in TDVMCALL_EXPOSE_REGS_MASK, except RBX, and R12-R15 which
+	 * will be restored.
 	 */
+	xor %r8d,  %r8d
+	xor %r9d,  %r9d
 	xor %r10d, %r10d
 	xor %r11d, %r11d
+	xor %rdi,  %rdi
+	xor %rsi,  %rsi
+	xor %rdx,  %rdx
 
 	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
 	pop %rbp
+	pop %rbx
 	pop %r12
 	pop %r13
 	pop %r14
