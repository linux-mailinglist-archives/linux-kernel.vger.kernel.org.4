Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC63D6FA072
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjEHHED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjEHHDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:03:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C734C19D64;
        Mon,  8 May 2023 00:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4312B61F85;
        Mon,  8 May 2023 07:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1456C433A4;
        Mon,  8 May 2023 07:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683529428;
        bh=4E1YJRld28apgAdM8nPpbwbWdnTo7VrUtFu79939OCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OC7T2hmD4SUQJNpGLRKFJBTqnKj5rSfg3QDg5/J2QH9xMXddP8M7Z32tCnLfimKwi
         +DjrOxfVKTNTyCv6sxHCo/dDXd/YznpsfaAjg4Rpn803lZXmOH2s+mpZte2crJjlzz
         qeYo92gLnYySd4YkcMSXutGtfoaeoPE89M0y1n0CPqvlPxd2eHlCWTWi4wCpW/38il
         3F3S81nfSnvEgmrxwzFYb4K4HpW0YmMBlonuxs8Vb77lfCOuGSJK1SJAwEP/1FluxL
         o4mwf6wBzLS8mntwNf6WzNEO+slC0LMPN6v7YA6JZWUeSBh2LzCzr480E5+6Oc9DO3
         Ksi+ntgRPRaHg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 02/20] x86: decompressor: Store boot_params pointer in callee save register
Date:   Mon,  8 May 2023 09:03:12 +0200
Message-Id: <20230508070330.582131-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508070330.582131-1-ardb@kernel.org>
References: <20230508070330.582131-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3624; i=ardb@kernel.org; h=from:subject; bh=4E1YJRld28apgAdM8nPpbwbWdnTo7VrUtFu79939OCI=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVi3uorpjprWVU+T3hw/XlLROxeqbsLJJ29rs+7/OOnw 012Tb91HaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiS5IZ/umrP+i8OFH9zZoU RcmtNnYbXuaduOvewFCr8fnsna2mF1cw/E+7+eeO4NMKp0M2enocN/nF63wOzWBjTjjiu37G4eo 9OxgA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of pushing and popping %RSI umpteen times to preserve the struct
boot_params pointer across the execution of the startup code, just move
it into a callee save register before the first call into C, and copy it
back when needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 34 +++++++-------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 03c4328a88cbd5d0..59340e533dff8369 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -416,10 +416,14 @@ SYM_CODE_START(startup_64)
 	lretq
 
 .Lon_kernel_cs:
+	/*
+	 * RSI holds a pointer to a boot_params structure provided by the
+	 * loader, and this needs to be preserved across C function calls. So
+	 * move it into a callee saved register.
+	 */
+	movq	%rsi, %r15
 
-	pushq	%rsi
 	call	load_stage1_idt
-	popq	%rsi
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	/*
@@ -432,10 +436,8 @@ SYM_CODE_START(startup_64)
 	 * detection/setup to ensure that has been done in advance of any dependent
 	 * code.
 	 */
-	pushq	%rsi
-	movq	%rsi, %rdi		/* real mode address */
+	movq	%r15, %rdi		/* pass struct boot_params pointer */
 	call	sev_enable
-	popq	%rsi
 #endif
 
 	/*
@@ -448,13 +450,9 @@ SYM_CODE_START(startup_64)
 	 *   - Non zero RDX means trampoline needs to enable 5-level
 	 *     paging.
 	 *
-	 * RSI holds real mode data and needs to be preserved across
-	 * this function call.
 	 */
-	pushq	%rsi
-	movq	%rsi, %rdi		/* real mode address */
+	movq	%r15, %rdi		/* pass struct boot_params pointer */
 	call	paging_prepare
-	popq	%rsi
 
 	/* Save the trampoline address in RCX */
 	movq	%rax, %rcx
@@ -479,14 +477,9 @@ trampoline_return:
 	 *
 	 * RDI is address of the page table to use instead of page table
 	 * in trampoline memory (if required).
-	 *
-	 * RSI holds real mode data and needs to be preserved across
-	 * this function call.
 	 */
-	pushq	%rsi
 	leaq	rva(top_pgtable)(%rbx), %rdi
 	call	cleanup_trampoline
-	popq	%rsi
 
 	/* Zero EFLAGS */
 	pushq	$0
@@ -496,7 +489,6 @@ trampoline_return:
  * Copy the compressed kernel to the end of our buffer
  * where decompression in place becomes safe.
  */
-	pushq	%rsi
 	leaq	(_bss-8)(%rip), %rsi
 	leaq	rva(_bss-8)(%rbx), %rdi
 	movl	$(_bss - startup_32), %ecx
@@ -504,7 +496,6 @@ trampoline_return:
 	std
 	rep	movsq
 	cld
-	popq	%rsi
 
 	/*
 	 * The GDT may get overwritten either during the copy we just did or
@@ -551,30 +542,27 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	shrq	$3, %rcx
 	rep	stosq
 
-	pushq	%rsi
 	call	load_stage2_idt
 
 	/* Pass boot_params to initialize_identity_maps() */
-	movq	(%rsp), %rdi
+	movq	%r15, %rdi		/* pass struct boot_params pointer */
 	call	initialize_identity_maps
-	popq	%rsi
 
 /*
  * Do the extraction, and jump to the new kernel..
  */
-	pushq	%rsi			/* Save the real mode argument */
-	movq	%rsi, %rdi		/* real mode address */
+	movq	%r15, %rdi		/* pass struct boot_params pointer */
 	leaq	boot_heap(%rip), %rsi	/* malloc area for uncompression */
 	leaq	input_data(%rip), %rdx  /* input_data */
 	movl	input_len(%rip), %ecx	/* input_len */
 	movq	%rbp, %r8		/* output target address */
 	movl	output_len(%rip), %r9d	/* decompressed length, end of relocs */
 	call	extract_kernel		/* returns kernel entry point in %rax */
-	popq	%rsi
 
 /*
  * Jump to the decompressed kernel.
  */
+	movq	%r15, %rsi
 	jmp	*%rax
 SYM_FUNC_END(.Lrelocated)
 
-- 
2.39.2

