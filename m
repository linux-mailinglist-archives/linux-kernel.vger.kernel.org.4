Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77ED663739A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiKXINy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiKXIMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:12:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BA5E8728;
        Thu, 24 Nov 2022 00:12:17 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:12:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669277535;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cBmPkFd20Au8OG8UFls+h9LtmUUoiGqql7QhEiFSf8o=;
        b=p95dAzSHghUmPbjB5DFozN8USFk/hvzyXKRaueNrx2fLmCJ4WxQ3dOeI6GOiiWDVpGwG9s
        fgglhG3MUwfeAJ/SXQnDuIKxyhJfydPUkbNhKmpZ9HT5xrjVKyyVaMHEfx4U6ZJs05jS7S
        okF5zN5sWLi1/rBKxlm0ifA9foFFR8LXxXaydfbAfOG3u5u/2mwPRu/QRzGu5tftGG2U07
        ZUnZKG1db55MFt7a1lTKiIj2MXY7yD6zSz+6R8IeZKLHUdUo5wvNsz1u/Xz7Fg1lQlR4Eo
        qyvi9JH77EMFN4QZmY+a+mW6xAhIMVaOEhrQQknkkV8li8LnWovtV4rrE45dKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669277535;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cBmPkFd20Au8OG8UFls+h9LtmUUoiGqql7QhEiFSf8o=;
        b=6NJvUdwCxf/V10Lea3aFKLxm+T2hZWX2VKeqnGe4JuLHMvW/k4j5OEA+sYFDwjZ+zG6b67
        zKdxb0ncSlv1ZjDQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Move 32-bit entrypoint code into
 .text section
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221122161017.2426828-3-ardb@kernel.org>
References: <20221122161017.2426828-3-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <166927753466.4906.15998812490802967207.tip-bot2@tip-bot2>
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

Commit-ID:     e2ab9eab324cdf240de89741e4a1aa79919f0196
Gitweb:        https://git.kernel.org/tip/e2ab9eab324cdf240de89741e4a1aa79919f0196
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 22 Nov 2022 17:10:02 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 22 Nov 2022 19:03:56 +01:00

x86/boot/compressed: Move 32-bit entrypoint code into .text section

Move the code that stores the arguments passed to the EFI entrypoint
into the .text section, so that it can be moved into a separate
compilation unit in a subsequent patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221122161017.2426828-3-ardb@kernel.org
---
 arch/x86/boot/compressed/head_64.S | 48 ++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index d33f060..5d07ef7 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -303,24 +303,41 @@ SYM_FUNC_START(efi32_stub_entry)
 	popl	%ecx
 	popl	%edx
 	popl	%esi
+	jmp	efi32_entry
+SYM_FUNC_END(efi32_stub_entry)
 
+	.text
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
+SYM_FUNC_START_LOCAL(efi32_entry)
 	call	1f
-1:	pop	%ebp
-	subl	$ rva(1b), %ebp
-
-	movl	%esi, rva(efi32_boot_args+8)(%ebp)
-SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
-	movl	%ecx, rva(efi32_boot_args)(%ebp)
-	movl	%edx, rva(efi32_boot_args+4)(%ebp)
-	movb	$0, rva(efi_is64)(%ebp)
+1:	pop	%ebx
 
 	/* Save firmware GDTR and code/data selectors */
-	sgdtl	rva(efi32_boot_gdt)(%ebp)
-	movw	%cs, rva(efi32_boot_cs)(%ebp)
-	movw	%ds, rva(efi32_boot_ds)(%ebp)
+	sgdtl	(efi32_boot_gdt - 1b)(%ebx)
+	movw	%cs, (efi32_boot_cs - 1b)(%ebx)
+	movw	%ds, (efi32_boot_ds - 1b)(%ebx)
 
 	/* Store firmware IDT descriptor */
-	sidtl	rva(efi32_boot_idt)(%ebp)
+	sidtl	(efi32_boot_idt - 1b)(%ebx)
+
+	/* Store boot arguments */
+	leal	(efi32_boot_args - 1b)(%ebx), %ebx
+	movl	%ecx, 0(%ebx)
+	movl	%edx, 4(%ebx)
+	movl	%esi, 8(%ebx)
+	movb	$0x0, 12(%ebx)          // efi_is64
 
 	/* Disable paging */
 	movl	%cr0, %eax
@@ -328,7 +345,8 @@ SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
 	movl	%eax, %cr0
 
 	jmp	startup_32
-SYM_FUNC_END(efi32_stub_entry)
+SYM_FUNC_END(efi32_entry)
+	__HEAD
 #endif
 
 	.code64
@@ -831,7 +849,9 @@ SYM_FUNC_START(efi32_pe_entry)
 	 */
 	subl	%esi, %ebx
 	movl	%ebx, rva(image_offset)(%ebp)	// save image_offset
-	jmp	efi32_pe_stub_entry
+	xorl	%esi, %esi
+	jmp	efi32_entry			// pass %ecx, %edx, %esi
+						// no other registers remain live
 
 2:	popl	%edi				// restore callee-save registers
 	popl	%ebx
