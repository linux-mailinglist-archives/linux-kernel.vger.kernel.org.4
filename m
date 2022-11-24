Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258FA63739D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiKXIOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKXIMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:12:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58186E8713;
        Thu, 24 Nov 2022 00:12:18 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:12:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669277537;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QuZJEFG7Ww+6Mo+BVn5skwtHEdiK58HLCi18osea894=;
        b=sDftUxOHmyU+XEMSh8jSnqCop6QS7ZOUcrUsPSQb3sh9Larh5thcVEY0zB2sVNRh1XoXc1
        9bwG6RBANjLt6/BnNn7PwKUaa8lpnGA3jkpVZHmuN3iIlQ/PJ4DyevQieIsg8bmk+JQlhl
        sGGzNrk98vRuSAN2kpKXCUlI9Nj8lr/PjEyOqW5Jh+Dt1lHx1GiUF4v8udNDxwKIyjpyk2
        9BA0+SUY7FPTVbk6BRcTe3b3jkiuMxML76Vf7XdW4a3x3Ri7wczoL3s5Kc+ORXJ1QQPY65
        36H4U5GURT51UNiK757YUKovmfSfs54YUfD18DPbaAYE6Dpl3jw+wMoin3unug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669277537;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QuZJEFG7Ww+6Mo+BVn5skwtHEdiK58HLCi18osea894=;
        b=e7E7i03yAqIe4uQ/BxXkYCMe+RChWr107xWMIYdcrTSpBUhGGjucge9ELB688pNTwhk1Qh
        cxjVRNqzO5Pe6lCg==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Rename efi_thunk_64.S to efi-mixed.S
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221122161017.2426828-2-ardb@kernel.org>
References: <20221122161017.2426828-2-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <166927753572.4906.4552841925383648744.tip-bot2@tip-bot2>
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

Commit-ID:     cb8bda8ad4438b4bcfcf89697fc84803fb210017
Gitweb:        https://git.kernel.org/tip/cb8bda8ad4438b4bcfcf89697fc84803fb210017
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 22 Nov 2022 17:10:01 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 22 Nov 2022 18:54:44 +01:00

x86/boot/compressed: Rename efi_thunk_64.S to efi-mixed.S

In preparation for moving the mixed mode specific code out of head_64.S,
rename the existing file to clarify that it contains more than just the
mixed mode thunk.

While at it, clean up the Makefile rules that add it to the build.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221122161017.2426828-2-ardb@kernel.org
---
 arch/x86/boot/compressed/Makefile       |   6 +-
 arch/x86/boot/compressed/efi_mixed.S    | 195 +++++++++++++++++++++++-
 arch/x86/boot/compressed/efi_thunk_64.S | 195 +-----------------------
 3 files changed, 198 insertions(+), 198 deletions(-)
 create mode 100644 arch/x86/boot/compressed/efi_mixed.S
 delete mode 100644 arch/x86/boot/compressed/efi_thunk_64.S

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 3a261ab..cd1a629 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -108,11 +108,11 @@ endif
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
 
-vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
-efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
+vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
+vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
-$(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
+$(obj)/vmlinux: $(vmlinux-objs-y) FORCE
 	$(call if_changed,ld)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
new file mode 100644
index 0000000..67e7edc
--- /dev/null
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -0,0 +1,195 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2014, 2015 Intel Corporation; author Matt Fleming
+ *
+ * Early support for invoking 32-bit EFI services from a 64-bit kernel.
+ *
+ * Because this thunking occurs before ExitBootServices() we have to
+ * restore the firmware's 32-bit GDT and IDT before we make EFI service
+ * calls.
+ *
+ * On the plus side, we don't have to worry about mangling 64-bit
+ * addresses into 32-bits because we're executing with an identity
+ * mapped pagetable and haven't transitioned to 64-bit virtual addresses
+ * yet.
+ */
+
+#include <linux/linkage.h>
+#include <asm/msr.h>
+#include <asm/page_types.h>
+#include <asm/processor-flags.h>
+#include <asm/segment.h>
+
+	.code64
+	.text
+SYM_FUNC_START(__efi64_thunk)
+	push	%rbp
+	push	%rbx
+
+	movl	%ds, %eax
+	push	%rax
+	movl	%es, %eax
+	push	%rax
+	movl	%ss, %eax
+	push	%rax
+
+	/* Copy args passed on stack */
+	movq	0x30(%rsp), %rbp
+	movq	0x38(%rsp), %rbx
+	movq	0x40(%rsp), %rax
+
+	/*
+	 * Convert x86-64 ABI params to i386 ABI
+	 */
+	subq	$64, %rsp
+	movl	%esi, 0x0(%rsp)
+	movl	%edx, 0x4(%rsp)
+	movl	%ecx, 0x8(%rsp)
+	movl	%r8d, 0xc(%rsp)
+	movl	%r9d, 0x10(%rsp)
+	movl	%ebp, 0x14(%rsp)
+	movl	%ebx, 0x18(%rsp)
+	movl	%eax, 0x1c(%rsp)
+
+	leaq	0x20(%rsp), %rbx
+	sgdt	(%rbx)
+
+	addq	$16, %rbx
+	sidt	(%rbx)
+
+	leaq	1f(%rip), %rbp
+
+	/*
+	 * Switch to IDT and GDT with 32-bit segments. This is the firmware GDT
+	 * and IDT that was installed when the kernel started executing. The
+	 * pointers were saved at the EFI stub entry point in head_64.S.
+	 *
+	 * Pass the saved DS selector to the 32-bit code, and use far return to
+	 * restore the saved CS selector.
+	 */
+	leaq	efi32_boot_idt(%rip), %rax
+	lidt	(%rax)
+	leaq	efi32_boot_gdt(%rip), %rax
+	lgdt	(%rax)
+
+	movzwl	efi32_boot_ds(%rip), %edx
+	movzwq	efi32_boot_cs(%rip), %rax
+	pushq	%rax
+	leaq	efi_enter32(%rip), %rax
+	pushq	%rax
+	lretq
+
+1:	addq	$64, %rsp
+	movq	%rdi, %rax
+
+	pop	%rbx
+	movl	%ebx, %ss
+	pop	%rbx
+	movl	%ebx, %es
+	pop	%rbx
+	movl	%ebx, %ds
+	/* Clear out 32-bit selector from FS and GS */
+	xorl	%ebx, %ebx
+	movl	%ebx, %fs
+	movl	%ebx, %gs
+
+	/*
+	 * Convert 32-bit status code into 64-bit.
+	 */
+	roll	$1, %eax
+	rorq	$1, %rax
+
+	pop	%rbx
+	pop	%rbp
+	RET
+SYM_FUNC_END(__efi64_thunk)
+
+	.code32
+/*
+ * EFI service pointer must be in %edi.
+ *
+ * The stack should represent the 32-bit calling convention.
+ */
+SYM_FUNC_START_LOCAL(efi_enter32)
+	/* Load firmware selector into data and stack segment registers */
+	movl	%edx, %ds
+	movl	%edx, %es
+	movl	%edx, %fs
+	movl	%edx, %gs
+	movl	%edx, %ss
+
+	/* Reload pgtables */
+	movl	%cr3, %eax
+	movl	%eax, %cr3
+
+	/* Disable paging */
+	movl	%cr0, %eax
+	btrl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+
+	/* Disable long mode via EFER */
+	movl	$MSR_EFER, %ecx
+	rdmsr
+	btrl	$_EFER_LME, %eax
+	wrmsr
+
+	call	*%edi
+
+	/* We must preserve return value */
+	movl	%eax, %edi
+
+	/*
+	 * Some firmware will return with interrupts enabled. Be sure to
+	 * disable them before we switch GDTs and IDTs.
+	 */
+	cli
+
+	lidtl	(%ebx)
+	subl	$16, %ebx
+
+	lgdtl	(%ebx)
+
+	movl	%cr4, %eax
+	btsl	$(X86_CR4_PAE_BIT), %eax
+	movl	%eax, %cr4
+
+	movl	%cr3, %eax
+	movl	%eax, %cr3
+
+	movl	$MSR_EFER, %ecx
+	rdmsr
+	btsl	$_EFER_LME, %eax
+	wrmsr
+
+	xorl	%eax, %eax
+	lldt	%ax
+
+	pushl	$__KERNEL_CS
+	pushl	%ebp
+
+	/* Enable paging */
+	movl	%cr0, %eax
+	btsl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+	lret
+SYM_FUNC_END(efi_enter32)
+
+	.data
+	.balign	8
+SYM_DATA_START(efi32_boot_gdt)
+	.word	0
+	.quad	0
+SYM_DATA_END(efi32_boot_gdt)
+
+SYM_DATA_START(efi32_boot_idt)
+	.word	0
+	.quad	0
+SYM_DATA_END(efi32_boot_idt)
+
+SYM_DATA_START(efi32_boot_cs)
+	.word	0
+SYM_DATA_END(efi32_boot_cs)
+
+SYM_DATA_START(efi32_boot_ds)
+	.word	0
+SYM_DATA_END(efi32_boot_ds)
diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
deleted file mode 100644
index 67e7edc..0000000
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ /dev/null
@@ -1,195 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2014, 2015 Intel Corporation; author Matt Fleming
- *
- * Early support for invoking 32-bit EFI services from a 64-bit kernel.
- *
- * Because this thunking occurs before ExitBootServices() we have to
- * restore the firmware's 32-bit GDT and IDT before we make EFI service
- * calls.
- *
- * On the plus side, we don't have to worry about mangling 64-bit
- * addresses into 32-bits because we're executing with an identity
- * mapped pagetable and haven't transitioned to 64-bit virtual addresses
- * yet.
- */
-
-#include <linux/linkage.h>
-#include <asm/msr.h>
-#include <asm/page_types.h>
-#include <asm/processor-flags.h>
-#include <asm/segment.h>
-
-	.code64
-	.text
-SYM_FUNC_START(__efi64_thunk)
-	push	%rbp
-	push	%rbx
-
-	movl	%ds, %eax
-	push	%rax
-	movl	%es, %eax
-	push	%rax
-	movl	%ss, %eax
-	push	%rax
-
-	/* Copy args passed on stack */
-	movq	0x30(%rsp), %rbp
-	movq	0x38(%rsp), %rbx
-	movq	0x40(%rsp), %rax
-
-	/*
-	 * Convert x86-64 ABI params to i386 ABI
-	 */
-	subq	$64, %rsp
-	movl	%esi, 0x0(%rsp)
-	movl	%edx, 0x4(%rsp)
-	movl	%ecx, 0x8(%rsp)
-	movl	%r8d, 0xc(%rsp)
-	movl	%r9d, 0x10(%rsp)
-	movl	%ebp, 0x14(%rsp)
-	movl	%ebx, 0x18(%rsp)
-	movl	%eax, 0x1c(%rsp)
-
-	leaq	0x20(%rsp), %rbx
-	sgdt	(%rbx)
-
-	addq	$16, %rbx
-	sidt	(%rbx)
-
-	leaq	1f(%rip), %rbp
-
-	/*
-	 * Switch to IDT and GDT with 32-bit segments. This is the firmware GDT
-	 * and IDT that was installed when the kernel started executing. The
-	 * pointers were saved at the EFI stub entry point in head_64.S.
-	 *
-	 * Pass the saved DS selector to the 32-bit code, and use far return to
-	 * restore the saved CS selector.
-	 */
-	leaq	efi32_boot_idt(%rip), %rax
-	lidt	(%rax)
-	leaq	efi32_boot_gdt(%rip), %rax
-	lgdt	(%rax)
-
-	movzwl	efi32_boot_ds(%rip), %edx
-	movzwq	efi32_boot_cs(%rip), %rax
-	pushq	%rax
-	leaq	efi_enter32(%rip), %rax
-	pushq	%rax
-	lretq
-
-1:	addq	$64, %rsp
-	movq	%rdi, %rax
-
-	pop	%rbx
-	movl	%ebx, %ss
-	pop	%rbx
-	movl	%ebx, %es
-	pop	%rbx
-	movl	%ebx, %ds
-	/* Clear out 32-bit selector from FS and GS */
-	xorl	%ebx, %ebx
-	movl	%ebx, %fs
-	movl	%ebx, %gs
-
-	/*
-	 * Convert 32-bit status code into 64-bit.
-	 */
-	roll	$1, %eax
-	rorq	$1, %rax
-
-	pop	%rbx
-	pop	%rbp
-	RET
-SYM_FUNC_END(__efi64_thunk)
-
-	.code32
-/*
- * EFI service pointer must be in %edi.
- *
- * The stack should represent the 32-bit calling convention.
- */
-SYM_FUNC_START_LOCAL(efi_enter32)
-	/* Load firmware selector into data and stack segment registers */
-	movl	%edx, %ds
-	movl	%edx, %es
-	movl	%edx, %fs
-	movl	%edx, %gs
-	movl	%edx, %ss
-
-	/* Reload pgtables */
-	movl	%cr3, %eax
-	movl	%eax, %cr3
-
-	/* Disable paging */
-	movl	%cr0, %eax
-	btrl	$X86_CR0_PG_BIT, %eax
-	movl	%eax, %cr0
-
-	/* Disable long mode via EFER */
-	movl	$MSR_EFER, %ecx
-	rdmsr
-	btrl	$_EFER_LME, %eax
-	wrmsr
-
-	call	*%edi
-
-	/* We must preserve return value */
-	movl	%eax, %edi
-
-	/*
-	 * Some firmware will return with interrupts enabled. Be sure to
-	 * disable them before we switch GDTs and IDTs.
-	 */
-	cli
-
-	lidtl	(%ebx)
-	subl	$16, %ebx
-
-	lgdtl	(%ebx)
-
-	movl	%cr4, %eax
-	btsl	$(X86_CR4_PAE_BIT), %eax
-	movl	%eax, %cr4
-
-	movl	%cr3, %eax
-	movl	%eax, %cr3
-
-	movl	$MSR_EFER, %ecx
-	rdmsr
-	btsl	$_EFER_LME, %eax
-	wrmsr
-
-	xorl	%eax, %eax
-	lldt	%ax
-
-	pushl	$__KERNEL_CS
-	pushl	%ebp
-
-	/* Enable paging */
-	movl	%cr0, %eax
-	btsl	$X86_CR0_PG_BIT, %eax
-	movl	%eax, %cr0
-	lret
-SYM_FUNC_END(efi_enter32)
-
-	.data
-	.balign	8
-SYM_DATA_START(efi32_boot_gdt)
-	.word	0
-	.quad	0
-SYM_DATA_END(efi32_boot_gdt)
-
-SYM_DATA_START(efi32_boot_idt)
-	.word	0
-	.quad	0
-SYM_DATA_END(efi32_boot_idt)
-
-SYM_DATA_START(efi32_boot_cs)
-	.word	0
-SYM_DATA_END(efi32_boot_cs)
-
-SYM_DATA_START(efi32_boot_ds)
-	.word	0
-SYM_DATA_END(efi32_boot_ds)
