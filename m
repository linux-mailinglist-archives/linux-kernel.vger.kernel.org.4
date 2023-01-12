Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA09A666F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbjALKPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239856AbjALKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:14:58 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9C82AFF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673518460; x=1705054460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uEzt+A3j9HcgIhKrHTIUtM43bVQXT7Fp7K0io/erJyk=;
  b=czBG3TwkJX61TZ9Orgb6OgD/a4vmKG0zSVi1/bCxHE9BaLDgY8/hXq04
   hk8r6jb3/WiDEJfdVE2rUJydPizRSKOVyQATx/pCMno4KSlLj48GE1P0d
   U7fgd/3H+LJMchD0W2J6tBt6I0GfC2JT5nk6wsWHi5UH7T6NzayGw76s2
   XTp92KykZXWLeirRTPJmJdLn628td0+sZ8uXCMdMirB1mYpTRMy+bKV/W
   fW8BiBUK1k0bCSKRxpCs7N7wp9L4npGGyoq171Ee1tBf/D0OV2zD9krOQ
   CT96nkDiYRfFzEl2xVnOxW+PXz2aN+iQCq11UYTuWfGef99HtVeWbMb3P
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350892164"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="350892164"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:14:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659722889"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="659722889"
Received: from glieseu-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.52.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:14:16 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 918C7109AF3; Thu, 12 Jan 2023 13:14:13 +0300 (+03)
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
Subject: [PATCHv2 3/7] x86/tdx: Refactor __tdx_hypercall() to allow pass down more arguments
Date:   Thu, 12 Jan 2023 13:14:03 +0300
Message-Id: <20230112101407.24327-4-kirill.shutemov@linux.intel.com>
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

RDI is the first argument to __tdx_hypercall() that used to pass pointer
to struct tdx_hypercall_args. RSI is the second argument that contains
flags, such as TDX_HCALL_HAS_OUTPUT and TDX_HCALL_ISSUE_STI.

RDI and RSI can also be used as arguments to TDVMCALL leafs. Move RDI to
RAX and RSI to RBP to free up them for the hypercall arguments.

RAX saved on stack during TDCALL as it returns status code in the
register.

RBP value has to be restored before returning from __tdx_hypercall() as
it is callee-saved register.

This is preparatory patch. No functional change.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdcall.S | 46 +++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 74b108e94a0d..a9bb4cbb8197 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -124,19 +124,26 @@ SYM_FUNC_START(__tdx_hypercall)
 	push %r14
 	push %r13
 	push %r12
+	push %rbp
+
+	/* Free RDI and RSI to be used as TDVMCALL arguments */
+	movq %rdi, %rax
+	movq %rsi, %rbp
+
+	/* Copy hypercall registers from arg struct: */
+	movq TDX_HYPERCALL_r10(%rax), %r10
+	movq TDX_HYPERCALL_r11(%rax), %r11
+	movq TDX_HYPERCALL_r12(%rax), %r12
+	movq TDX_HYPERCALL_r13(%rax), %r13
+	movq TDX_HYPERCALL_r14(%rax), %r14
+	movq TDX_HYPERCALL_r15(%rax), %r15
+
+	push %rax
 
 	/* Mangle function call ABI into TDCALL ABI: */
 	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
 	xor %eax, %eax
 
-	/* Copy hypercall registers from arg struct: */
-	movq TDX_HYPERCALL_r10(%rdi), %r10
-	movq TDX_HYPERCALL_r11(%rdi), %r11
-	movq TDX_HYPERCALL_r12(%rdi), %r12
-	movq TDX_HYPERCALL_r13(%rdi), %r13
-	movq TDX_HYPERCALL_r14(%rdi), %r14
-	movq TDX_HYPERCALL_r15(%rdi), %r15
-
 	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
 
 	/*
@@ -148,7 +155,7 @@ SYM_FUNC_START(__tdx_hypercall)
 	 * HLT operation indefinitely. Since this is the not the desired
 	 * result, conditionally call STI before TDCALL.
 	 */
-	testq $TDX_HCALL_ISSUE_STI, %rsi
+	testq $TDX_HCALL_ISSUE_STI, %rbp
 	jz .Lskip_sti
 	sti
 .Lskip_sti:
@@ -165,20 +172,22 @@ SYM_FUNC_START(__tdx_hypercall)
 	testq %rax, %rax
 	jne .Lpanic
 
-	/* TDVMCALL leaf return code is in R10 */
-	movq %r10, %rax
+	pop %rax
 
 	/* Copy hypercall result registers to arg struct if needed */
-	testq $TDX_HCALL_HAS_OUTPUT, %rsi
+	testq $TDX_HCALL_HAS_OUTPUT, %rbp
 	jz .Lout
 
-	movq %r10, TDX_HYPERCALL_r10(%rdi)
-	movq %r11, TDX_HYPERCALL_r11(%rdi)
-	movq %r12, TDX_HYPERCALL_r12(%rdi)
-	movq %r13, TDX_HYPERCALL_r13(%rdi)
-	movq %r14, TDX_HYPERCALL_r14(%rdi)
-	movq %r15, TDX_HYPERCALL_r15(%rdi)
+	movq %r10, TDX_HYPERCALL_r10(%rax)
+	movq %r11, TDX_HYPERCALL_r11(%rax)
+	movq %r12, TDX_HYPERCALL_r12(%rax)
+	movq %r13, TDX_HYPERCALL_r13(%rax)
+	movq %r14, TDX_HYPERCALL_r14(%rax)
+	movq %r15, TDX_HYPERCALL_r15(%rax)
 .Lout:
+	/* TDVMCALL leaf return code is in R10 */
+	movq %r10, %rax
+
 	/*
 	 * Zero out registers exposed to the VMM to avoid speculative execution
 	 * with VMM-controlled values. This needs to include all registers
@@ -189,6 +198,7 @@ SYM_FUNC_START(__tdx_hypercall)
 	xor %r11d, %r11d
 
 	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
+	pop %rbp
 	pop %r12
 	pop %r13
 	pop %r14
-- 
2.38.2

