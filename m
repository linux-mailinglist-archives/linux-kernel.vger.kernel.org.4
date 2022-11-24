Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C875637387
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiKXINc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiKXIMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:12:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0138E6EDE;
        Thu, 24 Nov 2022 00:12:13 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:12:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669277532;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+NgHwDXz9S4bWYO9YdP86Q7XXC3KD51F5/ITpGepsr4=;
        b=ri8IAbupofTWHkoCYIBU3eIsLM7OTTYpbUhd3qEC6hbSdFmaC3F3p6ZIZdW5e6hnPigVsZ
        zPjamGN19Su5K/p0/EONek+6zMKlDHO5CjjjIqCQpqUGYwq8AOOxevVVrNWswExIllUE4z
        pu838AHvajE7JbdRIAPGk6dIFn6ai2+wTJc7wgzNr4jQQwW4hbtfST72XMhD71REPVscI2
        q5T+rBnp4w/ExwVTGbykzJ9lxK+zQcVq4bglWZLZnATfKdiIGOHGe5nDu7q+mdvwzCN1zS
        TPp5QmUh1la7AeVYhQziaUEkgcLrPoS34uhLUBTZa2N4KN49HgJipLdtaxaSug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669277532;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+NgHwDXz9S4bWYO9YdP86Q7XXC3KD51F5/ITpGepsr4=;
        b=mLvfNRT1g+44y67D0lPpjWvWvx4eyZ/KMJZgx+rIbCEwGnx83/60cQI5lcW3gPiTXhv8Qf
        /nI0gTk7MYC+2pBA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Move efi32_entry out of head_64.S
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221122161017.2426828-6-ardb@kernel.org>
References: <20221122161017.2426828-6-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <166927753136.4906.15970187480921733252.tip-bot2@tip-bot2>
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

Commit-ID:     73a6dec80e2acedaef3ca603d4b5799049f6e9f8
Gitweb:        https://git.kernel.org/tip/73a6dec80e2acedaef3ca603d4b5799049f6e9f8
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 22 Nov 2022 17:10:05 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 22 Nov 2022 19:24:09 +01:00

x86/boot/compressed: Move efi32_entry out of head_64.S

Move the efi32_entry() routine out of head_64.S and into efi-mixed.S,
which reduces clutter in the complicated startup routines. It also
permits linkage of some symbols used by code to be made local.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221122161017.2426828-6-ardb@kernel.org
---
 arch/x86/boot/compressed/efi_mixed.S | 57 ++++++++++++++++++++++-----
 arch/x86/boot/compressed/head_64.S   | 45 +---------------------
 2 files changed, 47 insertions(+), 55 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 58ab2e1..3487484 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -105,7 +105,7 @@ SYM_FUNC_START(__efi64_thunk)
 	/*
 	 * Switch to IDT and GDT with 32-bit segments. This is the firmware GDT
 	 * and IDT that was installed when the kernel started executing. The
-	 * pointers were saved at the EFI stub entry point in head_64.S.
+	 * pointers were saved by the efi32_entry() routine below.
 	 *
 	 * Pass the saved DS selector to the 32-bit code, and use far return to
 	 * restore the saved CS selector.
@@ -217,22 +217,59 @@ SYM_FUNC_START_LOCAL(efi_enter32)
 	lret
 SYM_FUNC_END(efi_enter32)
 
+/*
+ * This is the common EFI stub entry point for mixed mode.
+ *
+ * Arguments:	%ecx	image handle
+ * 		%edx	EFI system table pointer
+ *		%esi	struct bootparams pointer (or NULL when not using
+ *			the EFI handover protocol)
+ *
+ * Since this is the point of no return for ordinary execution, no registers
+ * are considered live except for the function parameters. [Note that the EFI
+ * stub may still exit and return to the firmware using the Exit() EFI boot
+ * service.]
+ */
+SYM_FUNC_START(efi32_entry)
+	call	1f
+1:	pop	%ebx
+
+	/* Save firmware GDTR and code/data selectors */
+	sgdtl	(efi32_boot_gdt - 1b)(%ebx)
+	movw	%cs, (efi32_boot_cs - 1b)(%ebx)
+	movw	%ds, (efi32_boot_ds - 1b)(%ebx)
+
+	/* Store firmware IDT descriptor */
+	sidtl	(efi32_boot_idt - 1b)(%ebx)
+
+	/* Store boot arguments */
+	leal	(efi32_boot_args - 1b)(%ebx), %ebx
+	movl	%ecx, 0(%ebx)
+	movl	%edx, 4(%ebx)
+	movl	%esi, 8(%ebx)
+	movb	$0x0, 12(%ebx)          // efi_is64
+
+	/* Disable paging */
+	movl	%cr0, %eax
+	btrl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+
+	jmp	startup_32
+SYM_FUNC_END(efi32_entry)
+
 	.data
 	.balign	8
-SYM_DATA_START(efi32_boot_gdt)
+SYM_DATA_START_LOCAL(efi32_boot_gdt)
 	.word	0
 	.quad	0
 SYM_DATA_END(efi32_boot_gdt)
 
-SYM_DATA_START(efi32_boot_idt)
+SYM_DATA_START_LOCAL(efi32_boot_idt)
 	.word	0
 	.quad	0
 SYM_DATA_END(efi32_boot_idt)
 
-SYM_DATA_START(efi32_boot_cs)
-	.word	0
-SYM_DATA_END(efi32_boot_cs)
-
-SYM_DATA_START(efi32_boot_ds)
-	.word	0
-SYM_DATA_END(efi32_boot_ds)
+SYM_DATA_LOCAL(efi32_boot_cs, .word 0)
+SYM_DATA_LOCAL(efi32_boot_ds, .word 0)
+SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
+SYM_DATA(efi_is64, .byte 1)
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 9dd9010..9cd2a28 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -289,48 +289,6 @@ SYM_FUNC_START(efi32_stub_entry)
 	popl	%esi
 	jmp	efi32_entry
 SYM_FUNC_END(efi32_stub_entry)
-
-	.text
-/*
- * This is the common EFI stub entry point for mixed mode.
- *
- * Arguments:	%ecx	image handle
- * 		%edx	EFI system table pointer
- *		%esi	struct bootparams pointer (or NULL when not using
- *			the EFI handover protocol)
- *
- * Since this is the point of no return for ordinary execution, no registers
- * are considered live except for the function parameters. [Note that the EFI
- * stub may still exit and return to the firmware using the Exit() EFI boot
- * service.]
- */
-SYM_FUNC_START_LOCAL(efi32_entry)
-	call	1f
-1:	pop	%ebx
-
-	/* Save firmware GDTR and code/data selectors */
-	sgdtl	(efi32_boot_gdt - 1b)(%ebx)
-	movw	%cs, (efi32_boot_cs - 1b)(%ebx)
-	movw	%ds, (efi32_boot_ds - 1b)(%ebx)
-
-	/* Store firmware IDT descriptor */
-	sidtl	(efi32_boot_idt - 1b)(%ebx)
-
-	/* Store boot arguments */
-	leal	(efi32_boot_args - 1b)(%ebx), %ebx
-	movl	%ecx, 0(%ebx)
-	movl	%edx, 4(%ebx)
-	movl	%esi, 8(%ebx)
-	movb	$0x0, 12(%ebx)          // efi_is64
-
-	/* Disable paging */
-	movl	%cr0, %eax
-	btrl	$X86_CR0_PG_BIT, %eax
-	movl	%eax, %cr0
-
-	jmp	startup_32
-SYM_FUNC_END(efi32_entry)
-	__HEAD
 #endif
 
 	.code64
@@ -763,9 +721,6 @@ SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
 SYM_DATA(image_offset, .long 0)
 #endif
 #ifdef CONFIG_EFI_MIXED
-SYM_DATA(efi32_boot_args, .long 0, 0, 0)
-SYM_DATA(efi_is64, .byte 1)
-
 #define ST32_boottime		60 // offsetof(efi_system_table_32_t, boottime)
 #define BS32_handle_protocol	88 // offsetof(efi_boot_services_32_t, handle_protocol)
 #define LI32_image_base		32 // offsetof(efi_loaded_image_32_t, image_base)
