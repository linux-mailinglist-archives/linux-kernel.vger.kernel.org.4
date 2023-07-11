Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B8474EA22
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGKJSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjGKJRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:17:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30783173C;
        Tue, 11 Jul 2023 02:16:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA15661411;
        Tue, 11 Jul 2023 09:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ECAC433CA;
        Tue, 11 Jul 2023 09:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689066976;
        bh=hr5aWcq9mlaKqlfSJMfM00IvPLb1Ugo03NuCFd8pve4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sxDR7JBXPHZ7aaSoLTq6gGkI9nxCKCL6JIbi2yUt0AWE0sUXFRcJtd/DPUWYCwHJp
         8zcJo5uegOqZk0h6xR9DHb+MaLSSuRbxFQsgtvUt/9H0hqtfaHFI/kCzGW3zktg3GO
         MGirhFVriBySQlemsGX0Wmbi0GSrS3R/sC/9eUp8e2S6S6KUfyv7fbOHmzadfu4kN5
         S2TElPzKNs8HGg+BHm0uo6PkS+eGQVQVhHrUQf93zniVP4hyifS4BxVVH1tXqPJGDa
         CAshQKbc2K2GxrIOXqcDzz7X6k3ntE6B5XZc/tfTvTsLDGtUBjyJUceECs0/in2VJa
         RcDGzHBLZgBKA==
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v6 17/21] x86/decompressor: Move global symbol references to C code
Date:   Tue, 11 Jul 2023 11:14:49 +0200
Message-Id: <20230711091453.2543622-18-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230711091453.2543622-1-ardb@kernel.org>
References: <20230711091453.2543622-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5080; i=ardb@kernel.org; h=from:subject; bh=hr5aWcq9mlaKqlfSJMfM00IvPLb1Ugo03NuCFd8pve4=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWWtbMch8dkPNi06r+aZvuMIwzWpvFy3Ozya7a2TFu94V OKorufaUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZi7c3wz1Kb58H3aX+/Sgvv nLz6d5GeX/F0k5lT7n9e6fPjiKPfz8eMDNsPPtynMnP5Mr3f5xn1Figz8kQeLC3qvTovjE/4wPK X79kB
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is no longer necessary to be cautious when referring to global
variables in the position independent decompressor code, now that it is
built using PIE codegen and makes an assertion in the linker script that
no GOT entries exist (which would require adjustment for the actual
runtime load address of the decompressor binary).

This means global variables can be referenced directly from C code,
instead of having to pass their runtime addresses into C routines from
asm code, which needs to happen at each call site. Do so for the code
that will be called directly from the EFI stub after a subsequent patch,
and avoid the need to duplicate this logic a third time.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_32.S |  8 --------
 arch/x86/boot/compressed/head_64.S |  8 +-------
 arch/x86/boot/compressed/misc.c    | 16 +++++++++-------
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 3530465b5b85ccf3..beee858058df4403 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -168,13 +168,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
  */
 	/* push arguments for extract_kernel: */
 
-	pushl	output_len@GOTOFF(%ebx)	/* decompressed length, end of relocs */
 	pushl	%ebp			/* output address */
-	pushl	input_len@GOTOFF(%ebx)	/* input_len */
-	leal	input_data@GOTOFF(%ebx), %eax
-	pushl	%eax			/* input_data */
-	leal	boot_heap@GOTOFF(%ebx), %eax
-	pushl	%eax			/* heap area */
 	pushl	%esi			/* real mode pointer */
 	call	extract_kernel		/* returns kernel entry point in %eax */
 	addl	$24, %esp
@@ -202,8 +196,6 @@ SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
  */
 	.bss
 	.balign 4
-boot_heap:
-	.fill BOOT_HEAP_SIZE, 1, 0
 boot_stack:
 	.fill BOOT_STACK_SIZE, 1, 0
 boot_stack_end:
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 408c7824b647ff51..556ee504325ae50e 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -493,11 +493,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
  * Do the extraction, and jump to the new kernel..
  */
 	movq	%r15, %rdi		/* pass struct boot_params pointer */
-	leaq	boot_heap(%rip), %rsi	/* malloc area for uncompression */
-	leaq	input_data(%rip), %rdx  /* input_data */
-	movl	input_len(%rip), %ecx	/* input_len */
-	movq	%rbp, %r8		/* output target address */
-	movl	output_len(%rip), %r9d	/* decompressed length, end of relocs */
+	movq	%rbp, %rsi		/* output target address */
 	call	extract_kernel		/* returns kernel entry point in %rax */
 
 /*
@@ -639,8 +635,6 @@ SYM_DATA_END_LABEL(boot_idt, SYM_L_GLOBAL, boot_idt_end)
  */
 	.bss
 	.balign 4
-SYM_DATA_LOCAL(boot_heap,	.fill BOOT_HEAP_SIZE, 1, 0)
-
 SYM_DATA_START_LOCAL(boot_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
 	.balign 16
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 94b7abcf624b3b55..2d91d56b59e1af93 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -330,6 +330,11 @@ static size_t parse_elf(void *output)
 	return ehdr.e_entry - LOAD_PHYSICAL_ADDR;
 }
 
+static u8 boot_heap[BOOT_HEAP_SIZE] __aligned(4);
+
+extern unsigned char input_data[];
+extern unsigned int input_len, output_len;
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -347,14 +352,11 @@ static size_t parse_elf(void *output)
  *             |-------uncompressed kernel image---------|
  *
  */
-asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
-				  unsigned char *input_data,
-				  unsigned long input_len,
-				  unsigned char *output,
-				  unsigned long output_len)
+asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 {
 	const unsigned long kernel_total_size = VO__end - VO__text;
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
+	memptr heap = (memptr)boot_heap;
 	unsigned long needed_size;
 	size_t entry_offset;
 
@@ -412,7 +414,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	 * entries. This ensures the full mapped area is usable RAM
 	 * and doesn't include any reserved areas.
 	 */
-	needed_size = max(output_len, kernel_total_size);
+	needed_size = max_t(unsigned long, output_len, kernel_total_size);
 #ifdef CONFIG_X86_64
 	needed_size = ALIGN(needed_size, MIN_KERNEL_ALIGN);
 #endif
@@ -443,7 +445,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 #ifdef CONFIG_X86_64
 	if (heap > 0x3fffffffffffUL)
 		error("Destination address too large");
-	if (virt_addr + max(output_len, kernel_total_size) > KERNEL_IMAGE_SIZE)
+	if (virt_addr + needed_size > KERNEL_IMAGE_SIZE)
 		error("Destination virtual address is beyond the kernel mapping area");
 #else
 	if (heap > ((-__PAGE_OFFSET-(128<<20)-1) & 0x7fffffff))
-- 
2.39.2

