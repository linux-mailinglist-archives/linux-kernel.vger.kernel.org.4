Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2649767D87A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjAZWdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjAZWct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:32:49 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F30A70D4B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674772342; x=1706308342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=66VIdz3muarY0vcrRz9QFa3oQoVQgiIWs1OHx/vAl/Q=;
  b=Lltb7r98nIKjkHWZwTuFs+zZernVlv+d+VMiDP/BAhRnSHKRL6xnCy6F
   9OEQ5KoGE9KDXMncoC6zeDxx5z2xUdKbI7dQQ9oot1zZ/ooHQNG95txIH
   wh/fvIX0isyqh3s7YV3Tcknft+vnb91+ATG/Exdmlyu8fQNxJVTReArX5
   2YpKkd5WqiocP79syEQVZi7bAyfMZGE2JsjbBMh5HZzjmKJFy6/wu4Pcc
   tFGRUN7HbKk6fJcYGpt3fDuz89KES2hTAqA6jh+QNY0X5JEuFYFjb+8H4
   LNJRfx88Yx/XZLIKJMQVYE8NRxcGU2xz2RDoxGoMKxbniqZCKpjgUZK31
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="391516413"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="391516413"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:12:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="908411176"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="908411176"
Received: from smadjatx-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.210.179])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:12:06 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5D04010DBE2; Fri, 27 Jan 2023 01:12:03 +0300 (+03)
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
Subject: [PATCHv2, RESEND 3/7] x86/tdx: Refactor __tdx_hypercall() to allow pass down more arguments
Date:   Fri, 27 Jan 2023 01:11:55 +0300
Message-Id: <20230126221159.8635-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126221159.8635-1-kirill.shutemov@linux.intel.com>
References: <20230126221159.8635-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
2.39.1

