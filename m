Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC70C666F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbjALKPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239859AbjALKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:14:58 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503562BC1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673518460; x=1705054460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u1+Us1v7vAIWg661NR3lzpiichhOwsbWY0acStIamJs=;
  b=FWQmKBvNSLZnyUAVl9tWid+tP9CLFfS/BtEpnTkrKcMMQa6iiodpNxLl
   flrOYTFq877izKMkXnoga2Tdrp0CV7f2yOje5YN6Wn3wrtiKsp6qA6keq
   KbysaM9Me/3msOYcONSla+ezajNZhpazBJ/djMXWFjfaOqXAXjlAzt6Jz
   bf1ajXe6th6Dh2eG2JYxM0BzJau+RGY+ltTkn7qqfvQOZIXDVu7dwhuof
   gj4OEGgPj6IakCfWBHMUeSdKti+ncF1CAtbg6ONdg74/2iqC5jBuD7tdT
   pEJgg6+hC4ks7+fxP8m/EPMDL89NAdhRL4ELVuRQV7SSiH81bIA2f+Xap
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350892159"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="350892159"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:14:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659722890"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="659722890"
Received: from glieseu-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.52.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:14:16 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9B74E109AF4; Thu, 12 Jan 2023 13:14:13 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 4/7] x86/tdx: Expand __tdx_hypercall() to handle more arguments
Date:   Thu, 12 Jan 2023 13:14:04 +0300
Message-Id: <20230112101407.24327-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230112101407.24327-1-kirill.shutemov@linux.intel.com>
References: <20230112101407.24327-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far __tdx_hypercall() only handles six arguments for VMCALL.
Expanding it to six more register would allow to cover more use-cases
like ReportFatalError() and Hyper-V hypercalls.

With all preparations in place, the expansion is pretty straight
forward.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdcall.S | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index a9bb4cbb8197..5da06d1a9ba3 100644
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
-- 
2.38.2

