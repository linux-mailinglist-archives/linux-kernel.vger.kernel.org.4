Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A07637392
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiKXINn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiKXIMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:12:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B114EE6EC1;
        Thu, 24 Nov 2022 00:12:10 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:12:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669277529;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZA3r4xX60909xKbjniykBa/ValZx1V4CxaWSuQe6NA=;
        b=lzKqu+fPG5fMbNSmyQ/8uwfE0wlt6ki3fWCLhIJ5Vi0TTU+kWAD2hOYVHq7BSeHlGTYZ1e
        HmePinx19HfxoziRxg6FHJl5vzfglH2kQrtflhttMo/Hn3JmQa2CfOcuwx1Bcwo15nvrKB
        Xv4MBVB35UV340qH1PGMk3w6QhKQsaKY4XFRGllAEd+MWIedetfLjTuTxvWzq8pss3ZbVZ
        3vi4i/p14Djjrm0Zex5gZdIZ1jCkA86M/N/cmqmrEaHE907W8o6trPrpiHRijhdVMK7XtH
        7xhJ01IsMGstB/Ysm14MmDgeyvnPleHQ7uwYri3Smaa0SVjZYp0+IicB23JGRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669277529;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZA3r4xX60909xKbjniykBa/ValZx1V4CxaWSuQe6NA=;
        b=HaF7m81BrBn7AIr2Txj5CLPN1gM5A4u0qOdyWyJnzhQ9QtDDVqqSrjIIbR1na83np1Th4i
        PpSJxp6ai1LVcxAw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Simplify IDT/GDT
 preserve/restore in the EFI thunk
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221122161017.2426828-9-ardb@kernel.org>
References: <20221122161017.2426828-9-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <166927752814.4906.11164193821370869607.tip-bot2@tip-bot2>
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

Commit-ID:     630f337f0c4fd80390e8600adcab31550aea33df
Gitweb:        https://git.kernel.org/tip/630f337f0c4fd80390e8600adcab31550aea33df
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 22 Nov 2022 17:10:08 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 24 Nov 2022 08:57:41 +01:00

x86/boot/compressed: Simplify IDT/GDT preserve/restore in the EFI thunk

Tweak the asm and remove some redundant instructions. While at it,
fix the associated comment for style and correctness.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221122161017.2426828-9-ardb@kernel.org
---
 arch/x86/boot/compressed/efi_mixed.S | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 8844d8e..8b02e50 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -96,24 +96,20 @@ SYM_FUNC_START(__efi64_thunk)
 
 	leaq	0x20(%rsp), %rbx
 	sgdt	(%rbx)
-
-	addq	$16, %rbx
-	sidt	(%rbx)
+	sidt	16(%rbx)
 
 	leaq	1f(%rip), %rbp
 
 	/*
-	 * Switch to IDT and GDT with 32-bit segments. This is the firmware GDT
-	 * and IDT that was installed when the kernel started executing. The
-	 * pointers were saved by the efi32_entry() routine below.
+	 * Switch to IDT and GDT with 32-bit segments. These are the firmware
+	 * GDT and IDT that were installed when the kernel started executing.
+	 * The pointers were saved by the efi32_entry() routine below.
 	 *
 	 * Pass the saved DS selector to the 32-bit code, and use far return to
 	 * restore the saved CS selector.
 	 */
-	leaq	efi32_boot_idt(%rip), %rax
-	lidt	(%rax)
-	leaq	efi32_boot_gdt(%rip), %rax
-	lgdt	(%rax)
+	lidt	efi32_boot_idt(%rip)
+	lgdt	efi32_boot_gdt(%rip)
 
 	movzwl	efi32_boot_ds(%rip), %edx
 	movzwq	efi32_boot_cs(%rip), %rax
@@ -187,9 +183,7 @@ SYM_FUNC_START_LOCAL(efi_enter32)
 	 */
 	cli
 
-	lidtl	(%ebx)
-	subl	$16, %ebx
-
+	lidtl	16(%ebx)
 	lgdtl	(%ebx)
 
 	movl	%cr4, %eax
