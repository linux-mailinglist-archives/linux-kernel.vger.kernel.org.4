Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62150637382
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiKXINR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiKXIMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:12:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71890ED703;
        Thu, 24 Nov 2022 00:12:06 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:12:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669277525;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W16cV/kWP+fIThZjFFj2xjte2SU0THI5eEfHMeThfPU=;
        b=UJg/W4Ri/pQ71LlFOhxIROpYq27QSB9gGSCrI1CmoZpCSJEBN6ksFWfMtEZkTKf5r8HZ89
        3XmMgEqw3BfbxFG+OnuBhGRBAr+TN6pZ+RL1cu4Kw0ZOj7WM/t7pqv0QoljYjMuc7Vil5f
        q+ChGGTd4ReI2dE6DC+pyTpjqENnzPM1ZxKBggZOKEZmljF97qo4WsLHIlsysuPxoB5CCc
        mp1A18ePFv6gYqnqsjWOEKPeNPqkqhpIoQLik/k46vnnIwVdnmRpHZwbPCR1b184ZCtn7L
        64PqFMwEPjkoCepoO9X1ex9MUPLvZB67w+zf5TlGa/qLE512idYR1q/7inm1NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669277525;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W16cV/kWP+fIThZjFFj2xjte2SU0THI5eEfHMeThfPU=;
        b=6vfxFs+I9tMy6rsWZxVFRYbo7uxwNBL/9FFXyeisYOG8FAoHtj7PSwHx9/yxffu7xIcnxR
        EtL7wMCx1hQUnOCw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Move startup32_load_idt() out of
 head_64.S
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221122161017.2426828-13-ardb@kernel.org>
References: <20221122161017.2426828-13-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <166927752388.4906.4488084064477649114.tip-bot2@tip-bot2>
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

Commit-ID:     9ea813be3d345dfb8ac5bf6fbb29e6a63647a39d
Gitweb:        https://git.kernel.org/tip/9ea813be3d345dfb8ac5bf6fbb29e6a63647a39d
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 22 Nov 2022 17:10:12 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 24 Nov 2022 08:57:41 +01:00

x86/boot/compressed: Move startup32_load_idt() out of head_64.S

Now that startup32_load_idt() has been refactored into an ordinary
callable function, move it into mem-encrypt.S where it belongs.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221122161017.2426828-13-ardb@kernel.org
---
 arch/x86/boot/compressed/head_64.S     | 72 +-------------------------
 arch/x86/boot/compressed/mem_encrypt.S | 72 ++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 73 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 7aa147f..16cccc2 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -707,78 +707,6 @@ SYM_DATA_START(boot_idt)
 	.endr
 SYM_DATA_END_LABEL(boot_idt, SYM_L_GLOBAL, boot_idt_end)
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-SYM_DATA_START(boot32_idt_desc)
-	.word   boot32_idt_end - boot32_idt - 1
-	.long   0
-SYM_DATA_END(boot32_idt_desc)
-	.balign 8
-SYM_DATA_START(boot32_idt)
-	.rept 32
-	.quad 0
-	.endr
-SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
-
-	.text
-	.code32
-/*
- * Write an IDT entry into boot32_idt
- *
- * Parameters:
- *
- * %eax:	Handler address
- * %edx:	Vector number
- * %ecx:	IDT address
- */
-SYM_FUNC_START_LOCAL(startup32_set_idt_entry)
-	/* IDT entry address to %ecx */
-	leal	(%ecx, %edx, 8), %ecx
-
-	/* Build IDT entry, lower 4 bytes */
-	movl    %eax, %edx
-	andl    $0x0000ffff, %edx		# Target code segment offset [15:0]
-	orl	$(__KERNEL32_CS << 16), %edx	# Target code segment selector
-
-	/* Store lower 4 bytes to IDT */
-	movl    %edx, (%ecx)
-
-	/* Build IDT entry, upper 4 bytes */
-	movl    %eax, %edx
-	andl    $0xffff0000, %edx	# Target code segment offset [31:16]
-	orl     $0x00008e00, %edx	# Present, Type 32-bit Interrupt Gate
-
-	/* Store upper 4 bytes to IDT */
-	movl    %edx, 4(%ecx)
-
-	RET
-SYM_FUNC_END(startup32_set_idt_entry)
-
-SYM_FUNC_START(startup32_load_idt)
-	push	%ebp
-	push	%ebx
-
-	call	1f
-1:	pop	%ebp
-
-	leal    (boot32_idt - 1b)(%ebp), %ebx
-
-	/* #VC handler */
-	leal    (startup32_vc_handler - 1b)(%ebp), %eax
-	movl    $X86_TRAP_VC, %edx
-	movl	%ebx, %ecx
-	call    startup32_set_idt_entry
-
-	/* Load IDT */
-	leal	(boot32_idt_desc - 1b)(%ebp), %ecx
-	movl	%ebx, 2(%ecx)
-	lidt    (%ecx)
-
-	pop	%ebx
-	pop	%ebp
-	RET
-SYM_FUNC_END(startup32_load_idt)
-#endif
-
 /*
  * Check for the correct C-bit position when the startup_32 boot-path is used.
  *
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index a73e4d7..6747e5e 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -12,6 +12,8 @@
 #include <asm/processor-flags.h>
 #include <asm/msr.h>
 #include <asm/asm-offsets.h>
+#include <asm/segment.h>
+#include <asm/trapnr.h>
 
 	.text
 	.code32
@@ -98,7 +100,7 @@ SYM_CODE_START_LOCAL(sev_es_req_cpuid)
 	jmp	1b
 SYM_CODE_END(sev_es_req_cpuid)
 
-SYM_CODE_START(startup32_vc_handler)
+SYM_CODE_START_LOCAL(startup32_vc_handler)
 	pushl	%eax
 	pushl	%ebx
 	pushl	%ecx
@@ -184,6 +186,63 @@ SYM_CODE_START(startup32_vc_handler)
 	jmp .Lfail
 SYM_CODE_END(startup32_vc_handler)
 
+/*
+ * Write an IDT entry into boot32_idt
+ *
+ * Parameters:
+ *
+ * %eax:	Handler address
+ * %edx:	Vector number
+ * %ecx:	IDT address
+ */
+SYM_FUNC_START_LOCAL(startup32_set_idt_entry)
+	/* IDT entry address to %ecx */
+	leal	(%ecx, %edx, 8), %ecx
+
+	/* Build IDT entry, lower 4 bytes */
+	movl    %eax, %edx
+	andl    $0x0000ffff, %edx		# Target code segment offset [15:0]
+	orl	$(__KERNEL32_CS << 16), %edx	# Target code segment selector
+
+	/* Store lower 4 bytes to IDT */
+	movl    %edx, (%ecx)
+
+	/* Build IDT entry, upper 4 bytes */
+	movl    %eax, %edx
+	andl    $0xffff0000, %edx	# Target code segment offset [31:16]
+	orl     $0x00008e00, %edx	# Present, Type 32-bit Interrupt Gate
+
+	/* Store upper 4 bytes to IDT */
+	movl    %edx, 4(%ecx)
+
+	RET
+SYM_FUNC_END(startup32_set_idt_entry)
+
+SYM_FUNC_START(startup32_load_idt)
+	push	%ebp
+	push	%ebx
+
+	call	1f
+1:	pop	%ebp
+
+	leal    (boot32_idt - 1b)(%ebp), %ebx
+
+	/* #VC handler */
+	leal    (startup32_vc_handler - 1b)(%ebp), %eax
+	movl    $X86_TRAP_VC, %edx
+	movl	%ebx, %ecx
+	call    startup32_set_idt_entry
+
+	/* Load IDT */
+	leal	(boot32_idt_desc - 1b)(%ebp), %ecx
+	movl	%ebx, 2(%ecx)
+	lidt    (%ecx)
+
+	pop	%ebx
+	pop	%ebp
+	RET
+SYM_FUNC_END(startup32_load_idt)
+
 	.code64
 
 #include "../../kernel/sev_verify_cbit.S"
@@ -195,4 +254,15 @@ SYM_CODE_END(startup32_vc_handler)
 SYM_DATA(sme_me_mask,		.quad 0)
 SYM_DATA(sev_status,		.quad 0)
 SYM_DATA(sev_check_data,	.quad 0)
+
+SYM_DATA_START_LOCAL(boot32_idt)
+	.rept	32
+	.quad	0
+	.endr
+SYM_DATA_END(boot32_idt)
+
+SYM_DATA_START_LOCAL(boot32_idt_desc)
+	.word	. - boot32_idt - 1
+	.long	0
+SYM_DATA_END(boot32_idt_desc)
 #endif
