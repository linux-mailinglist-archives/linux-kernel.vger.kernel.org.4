Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A7F63739B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiKXIN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiKXIMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:12:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44F9E6EDD;
        Thu, 24 Nov 2022 00:12:12 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:12:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669277531;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C7JVWqqXUwCrOm3FrmKnsLLfMEZxRW7XJINoak1nVEg=;
        b=OnV6h+axAYJlYX+T+mbA6UbL9/qMO2WdDVJiTqcH4ZaNejX55DMJnMWATZ9QW1QN8aVy7A
        crs91OFopnqn6Kfkfygr/EsR3MRPVO9VUyVtxWSnLFkIvd/XpuETW5XZH/y0wkrv3gKn1P
        1D6v7/evxqBcLP29nNu7iqsHSZ0EY8N+z53DfXjb+1vaqeU007fn3mDNy5wf55oXHGvvP7
        urw12yRNM844DYAgdDIkSbC5YDiEhjxQHzRTweQ+ZxSNaOSCsSF7cakihvOJrOyhJ0vqPl
        ZmuO+uVRz6VKmHCswIWHt0tEiLBF4IaiuuBVMaIXynuM8IErGefOyo3kmSKB6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669277531;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C7JVWqqXUwCrOm3FrmKnsLLfMEZxRW7XJINoak1nVEg=;
        b=uB2KPxWvvV/DprR5fUvcxxGK5+t+uqdAD3B8maEC8edHARq9g2VGMbFvdNu/BgRgQHK6VS
        V1htcK0wo0oAkABA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Move efi32_pe_entry() out of head_64.S
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221122161017.2426828-7-ardb@kernel.org>
References: <20221122161017.2426828-7-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <166927753028.4906.3204484958892190469.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     7f22ca396778fea9332d83ec2359dbe8396e9a06
Gitweb:        https://git.kernel.org/tip/7f22ca396778fea9332d83ec2359dbe8396e9a06
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 22 Nov 2022 17:10:06 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 22 Nov 2022 19:24:57 +01:00

x86/boot/compressed: Move efi32_pe_entry() out of head_64.S

Move the implementation of efi32_pe_entry() into efi-mixed.S, which is a
more suitable location that only gets built if EFI mixed mode is
actually enabled.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221122161017.2426828-7-ardb@kernel.org
---
 arch/x86/boot/compressed/efi_mixed.S | 82 +++++++++++++++++++++++++-
 arch/x86/boot/compressed/head_64.S   | 87 +---------------------------
 2 files changed, 83 insertions(+), 86 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 3487484..8844d8e 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -257,6 +257,88 @@ SYM_FUNC_START(efi32_entry)
 	jmp	startup_32
 SYM_FUNC_END(efi32_entry)
 
+#define ST32_boottime		60 // offsetof(efi_system_table_32_t, boottime)
+#define BS32_handle_protocol	88 // offsetof(efi_boot_services_32_t, handle_protocol)
+#define LI32_image_base		32 // offsetof(efi_loaded_image_32_t, image_base)
+
+/*
+ * efi_status_t efi32_pe_entry(efi_handle_t image_handle,
+ *			       efi_system_table_32_t *sys_table)
+ */
+SYM_FUNC_START(efi32_pe_entry)
+	pushl	%ebp
+	movl	%esp, %ebp
+	pushl	%eax				// dummy push to allocate loaded_image
+
+	pushl	%ebx				// save callee-save registers
+	pushl	%edi
+
+	call	verify_cpu			// check for long mode support
+	testl	%eax, %eax
+	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
+	jnz	2f
+
+	call	1f
+1:	pop	%ebx
+
+	/* Get the loaded image protocol pointer from the image handle */
+	leal	-4(%ebp), %eax
+	pushl	%eax				// &loaded_image
+	leal	(loaded_image_proto - 1b)(%ebx), %eax
+	pushl	%eax				// pass the GUID address
+	pushl	8(%ebp)				// pass the image handle
+
+	/*
+	 * Note the alignment of the stack frame.
+	 *   sys_table
+	 *   handle             <-- 16-byte aligned on entry by ABI
+	 *   return address
+	 *   frame pointer
+	 *   loaded_image       <-- local variable
+	 *   saved %ebx		<-- 16-byte aligned here
+	 *   saved %edi
+	 *   &loaded_image
+	 *   &loaded_image_proto
+	 *   handle             <-- 16-byte aligned for call to handle_protocol
+	 */
+
+	movl	12(%ebp), %eax			// sys_table
+	movl	ST32_boottime(%eax), %eax	// sys_table->boottime
+	call	*BS32_handle_protocol(%eax)	// sys_table->boottime->handle_protocol
+	addl	$12, %esp			// restore argument space
+	testl	%eax, %eax
+	jnz	2f
+
+	movl	8(%ebp), %ecx			// image_handle
+	movl	12(%ebp), %edx			// sys_table
+	movl	-4(%ebp), %esi			// loaded_image
+	movl	LI32_image_base(%esi), %esi	// loaded_image->image_base
+	leal	(startup_32 - 1b)(%ebx), %ebp	// runtime address of startup_32
+	/*
+	 * We need to set the image_offset variable here since startup_32() will
+	 * use it before we get to the 64-bit efi_pe_entry() in C code.
+	 */
+	subl	%esi, %ebp			// calculate image_offset
+	movl	%ebp, (image_offset - 1b)(%ebx)	// save image_offset
+	xorl	%esi, %esi
+	jmp	efi32_entry			// pass %ecx, %edx, %esi
+						// no other registers remain live
+
+2:	popl	%edi				// restore callee-save registers
+	popl	%ebx
+	leave
+	RET
+SYM_FUNC_END(efi32_pe_entry)
+
+	.section ".rodata"
+	/* EFI loaded image protocol GUID */
+	.balign 4
+SYM_DATA_START_LOCAL(loaded_image_proto)
+	.long	0x5b1b31a1
+	.word	0x9562, 0x11d2
+	.byte	0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b
+SYM_DATA_END(loaded_image_proto)
+
 	.data
 	.balign	8
 SYM_DATA_START_LOCAL(efi32_boot_gdt)
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 9cd2a28..36f37f9 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -673,6 +673,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
 	jmp     1b
 SYM_FUNC_END(.Lno_longmode)
 
+	.globl	verify_cpu
 #include "../../kernel/verify_cpu.S"
 
 	.data
@@ -720,92 +721,6 @@ SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
 #ifdef CONFIG_EFI_STUB
 SYM_DATA(image_offset, .long 0)
 #endif
-#ifdef CONFIG_EFI_MIXED
-#define ST32_boottime		60 // offsetof(efi_system_table_32_t, boottime)
-#define BS32_handle_protocol	88 // offsetof(efi_boot_services_32_t, handle_protocol)
-#define LI32_image_base		32 // offsetof(efi_loaded_image_32_t, image_base)
-
-	.text
-	.code32
-SYM_FUNC_START(efi32_pe_entry)
-/*
- * efi_status_t efi32_pe_entry(efi_handle_t image_handle,
- *			       efi_system_table_32_t *sys_table)
- */
-
-	pushl	%ebp
-	movl	%esp, %ebp
-	pushl	%eax				// dummy push to allocate loaded_image
-
-	pushl	%ebx				// save callee-save registers
-	pushl	%edi
-
-	call	verify_cpu			// check for long mode support
-	testl	%eax, %eax
-	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
-	jnz	2f
-
-	call	1f
-1:	pop	%ebx
-
-	/* Get the loaded image protocol pointer from the image handle */
-	leal	-4(%ebp), %eax
-	pushl	%eax				// &loaded_image
-	leal	(loaded_image_proto - 1b)(%ebx), %eax
-	pushl	%eax				// pass the GUID address
-	pushl	8(%ebp)				// pass the image handle
-
-	/*
-	 * Note the alignment of the stack frame.
-	 *   sys_table
-	 *   handle             <-- 16-byte aligned on entry by ABI
-	 *   return address
-	 *   frame pointer
-	 *   loaded_image       <-- local variable
-	 *   saved %ebx		<-- 16-byte aligned here
-	 *   saved %edi
-	 *   &loaded_image
-	 *   &loaded_image_proto
-	 *   handle             <-- 16-byte aligned for call to handle_protocol
-	 */
-
-	movl	12(%ebp), %eax			// sys_table
-	movl	ST32_boottime(%eax), %eax	// sys_table->boottime
-	call	*BS32_handle_protocol(%eax)	// sys_table->boottime->handle_protocol
-	addl	$12, %esp			// restore argument space
-	testl	%eax, %eax
-	jnz	2f
-
-	movl	8(%ebp), %ecx			// image_handle
-	movl	12(%ebp), %edx			// sys_table
-	movl	-4(%ebp), %esi			// loaded_image
-	movl	LI32_image_base(%esi), %esi	// loaded_image->image_base
-	leal	(startup_32 - 1b)(%ebx), %ebp	// runtime address of startup_32
-	/*
-	 * We need to set the image_offset variable here since startup_32() will
-	 * use it before we get to the 64-bit efi_pe_entry() in C code.
-	 */
-	subl	%esi, %ebp			// calculate image_offset
-	movl	%ebp, (image_offset - 1b)(%ebx)	// save image_offset
-	xorl	%esi, %esi
-	jmp	efi32_entry			// pass %ecx, %edx, %esi
-						// no other registers remain live
-
-2:	popl	%edi				// restore callee-save registers
-	popl	%ebx
-	leave
-	RET
-SYM_FUNC_END(efi32_pe_entry)
-
-	.section ".rodata"
-	/* EFI loaded image protocol GUID */
-	.balign 4
-SYM_DATA_START_LOCAL(loaded_image_proto)
-	.long	0x5b1b31a1
-	.word	0x9562, 0x11d2
-	.byte	0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b
-SYM_DATA_END(loaded_image_proto)
-#endif
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	__HEAD
