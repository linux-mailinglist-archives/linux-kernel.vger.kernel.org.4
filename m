Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A188C6F1491
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345662AbjD1Jwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345792AbjD1Jwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:52:35 -0400
Received: from out0-218.mail.aliyun.com (out0-218.mail.aliyun.com [140.205.0.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E6B59EB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 02:52:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047188;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---.STDfrvL_1682675522;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STDfrvL_1682675522)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:52:03 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Brian Gerst" <brgerst@gmail.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>
Subject: [PATCH RFC 08/43] x86/boot/64: Adapt assembly for PIE support
Date:   Fri, 28 Apr 2023 17:50:48 +0800
Message-Id: <d9ece0ed2c023fdc52e2d0bc301262ae7cdb13c1.1682673543.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Garnier <thgarnie@chromium.org>

From: Thomas Garnier <thgarnie@chromium.org>

Change the assembly code to use absolute reference for transition
between address spaces and relative references when referencing global
variables in the same address space. Ensure the kernel built with PIE
references the correct addresses based on context.

[Hou Wenlong: Adapt new assembly code and remove change for
initial_code(%rip)]

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Co-developed-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/head_64.S | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index a5df3e994f04..21f0556d3ac0 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -114,7 +114,8 @@ SYM_CODE_START_NOALIGN(startup_64)
 	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(early_top_pgt - __START_KERNEL_map), %rax
+	movabs  $(early_top_pgt - __START_KERNEL_map), %rcx
+	addq    %rcx, %rax
 	jmp 1f
 SYM_CODE_END(startup_64)
 
@@ -156,13 +157,14 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * added to the initial pgdir entry that will be programmed into CR3.
 	 */
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-	movq	sme_me_mask, %rax
+	movq	sme_me_mask(%rip), %rax
 #else
 	xorq	%rax, %rax
 #endif
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(init_top_pgt - __START_KERNEL_map), %rax
+	movabs	$(init_top_pgt - __START_KERNEL_map), %rcx
+	addq    %rcx, %rax
 1:
 
 #ifdef CONFIG_X86_MCE
@@ -226,7 +228,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movq	%rax, %cr4
 
 	/* Ensure I am executing from virtual addresses */
-	movq	$1f, %rax
+	movabs  $1f, %rax
 	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 1:
@@ -237,7 +239,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movl	smpboot_control(%rip), %ecx
 
 	/* Get the per cpu offset for the given CPU# which is in ECX */
-	movq	__per_cpu_offset(,%rcx,8), %rdx
+	leaq	__per_cpu_offset(%rip), %rdx
+	movq	(%rdx,%rcx,8), %rdx
 #else
 	xorl	%edx, %edx /* zero-extended to clear all of RDX */
 #endif /* CONFIG_SMP */
@@ -248,7 +251,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 *
 	 * RDX contains the per-cpu offset
 	 */
-	movq	pcpu_hot + X86_current_task(%rdx), %rax
+	leaq	(pcpu_hot + X86_current_task)(%rip), %rax
+	movq	(%rdx,%rax,1), %rax
 	movq	TASK_threadsp(%rax), %rsp
 
 	/*
@@ -259,7 +263,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 */
 	subq	$16, %rsp
 	movw	$(GDT_SIZE-1), (%rsp)
-	leaq	gdt_page(%rdx), %rax
+	leaq	gdt_page(%rip), %rax
+	addq	%rdx, %rax
 	movq	%rax, 2(%rsp)
 	lgdt	(%rsp)
 	addq	$16, %rsp
@@ -362,7 +367,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 *	REX.W + FF /5 JMP m16:64 Jump far, absolute indirect,
 	 *		address given in m16:64.
 	 */
-	pushq	$.Lafter_lret	# put return address on stack for unwinder
+	movabs  $.Lafter_lret, %rax
+	pushq	%rax		# put return address on stack for unwinder
 	xorl	%ebp, %ebp	# clear frame pointer
 	movq	initial_code(%rip), %rax
 	pushq	$__KERNEL_CS	# set correct cs
-- 
2.31.1

