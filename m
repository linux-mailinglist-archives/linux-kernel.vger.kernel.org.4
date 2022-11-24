Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8849563737F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiKXINM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiKXIMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:12:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B291ED702;
        Thu, 24 Nov 2022 00:12:05 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:12:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669277524;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbBDHp716dY21xd9DiuURl9WaCsgFsDzFg6Q+0Js6R0=;
        b=1cMgBrYF4P7xlQ02f7r+UvgIaeVtf3cNdR7tVM8tTPiSXAnV0/6wbr5K2UQY/b3gFb60DK
        f3Zs8LJDLBUeDk2Lq8PvLOIR01aEXV+jkqusiUGyEbCjEkd+fqaBbp5ofvdO28yFLzEVCJ
        qmJd0dTp/rzwP2fN7MkH+O9Ut7SHRMO9WZydgyopBZZJX834QR4MozLXGRYuTfKZiYaEus
        gNQA+NNFWS5tfxm58+InH5zuGpaW1LEfBdRscuUzRX+phgIl1Zx/KqSSaC7rPDKmc5niDy
        bc6rMEFGx6F6RxC/lE4C5z/EY7XEpz+2c0RjNXccLiF9LUXzwc3zaAg3cqS9KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669277524;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbBDHp716dY21xd9DiuURl9WaCsgFsDzFg6Q+0Js6R0=;
        b=4LUui1I53SCRnV+CQh14OOlKK04j1sIOaTTn1+w0fz+CDsVaqmtgl7cuasJLRuHhThKeb5
        SGv7erhw3b8mkECw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Move startup32_check_sev_cbit()
 into .text
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221122161017.2426828-14-ardb@kernel.org>
References: <20221122161017.2426828-14-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <166927752269.4906.18330426815751455059.tip-bot2@tip-bot2>
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

Commit-ID:     b5d854cd4b6a314edd6c15dabc4233b84a0f8e5e
Gitweb:        https://git.kernel.org/tip/b5d854cd4b6a314edd6c15dabc4233b84a0f8e5e
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 22 Nov 2022 17:10:13 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 24 Nov 2022 08:57:41 +01:00

x86/boot/compressed: Move startup32_check_sev_cbit() into .text

Move startup32_check_sev_cbit() into the .text section and turn it into
an ordinary function using the ordinary 32-bit calling convention,
instead of saving/restoring the registers that are known to be live at
the only call site. This improves maintainability, and makes it possible
to move this function out of head_64.S and into a separate compilation
unit that is specific to memory encryption.

Note that this requires the call site to be moved before the mixed mode
check, as %eax will be live otherwise.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221122161017.2426828-14-ardb@kernel.org
---
 arch/x86/boot/compressed/head_64.S | 35 +++++++++++++++--------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 16cccc2..30ba541 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -251,6 +251,11 @@ SYM_FUNC_START(startup_32)
 	movl    $__BOOT_TSS, %eax
 	ltr	%ax
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/* Check if the C-bit position is correct when SEV is active */
+	call	startup32_check_sev_cbit
+#endif
+
 	/*
 	 * Setup for the jump to 64bit mode
 	 *
@@ -268,8 +273,6 @@ SYM_FUNC_START(startup_32)
 	leal	rva(startup_64_mixed_mode)(%ebp), %eax
 1:
 #endif
-	/* Check if the C-bit position is correct when SEV is active */
-	call	startup32_check_sev_cbit
 
 	pushl	$__KERNEL_CS
 	pushl	%eax
@@ -724,16 +727,17 @@ SYM_DATA_END_LABEL(boot_idt, SYM_L_GLOBAL, boot_idt_end)
  * succeed. An incorrect C-bit position will map all memory unencrypted, so that
  * the compare will use the encrypted random data and fail.
  */
-	__HEAD
-SYM_FUNC_START(startup32_check_sev_cbit)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-	pushl	%eax
+	.text
+SYM_FUNC_START(startup32_check_sev_cbit)
 	pushl	%ebx
-	pushl	%ecx
-	pushl	%edx
+	pushl	%ebp
+
+	call	0f
+0:	popl	%ebp
 
 	/* Check for non-zero sev_status */
-	movl	rva(sev_status)(%ebp), %eax
+	movl	(sev_status - 0b)(%ebp), %eax
 	testl	%eax, %eax
 	jz	4f
 
@@ -748,17 +752,18 @@ SYM_FUNC_START(startup32_check_sev_cbit)
 	jnc	2b
 
 	/* Store to memory and keep it in the registers */
-	movl	%eax, rva(sev_check_data)(%ebp)
-	movl	%ebx, rva(sev_check_data+4)(%ebp)
+	leal	(sev_check_data - 0b)(%ebp), %ebp
+	movl	%eax, 0(%ebp)
+	movl	%ebx, 4(%ebp)
 
 	/* Enable paging to see if encryption is active */
 	movl	%cr0, %edx			 /* Backup %cr0 in %edx */
 	movl	$(X86_CR0_PG | X86_CR0_PE), %ecx /* Enable Paging and Protected mode */
 	movl	%ecx, %cr0
 
-	cmpl	%eax, rva(sev_check_data)(%ebp)
+	cmpl	%eax, 0(%ebp)
 	jne	3f
-	cmpl	%ebx, rva(sev_check_data+4)(%ebp)
+	cmpl	%ebx, 4(%ebp)
 	jne	3f
 
 	movl	%edx, %cr0	/* Restore previous %cr0 */
@@ -770,13 +775,11 @@ SYM_FUNC_START(startup32_check_sev_cbit)
 	jmp	3b
 
 4:
-	popl	%edx
-	popl	%ecx
+	popl	%ebp
 	popl	%ebx
-	popl	%eax
-#endif
 	RET
 SYM_FUNC_END(startup32_check_sev_cbit)
+#endif
 
 /*
  * Stack and heap for uncompression
