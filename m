Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320C4637383
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiKXINU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiKXIMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:12:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847ECE637D;
        Thu, 24 Nov 2022 00:12:07 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:12:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669277526;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xexxDX5KT6kwgcfQmlhhDfhA0srurYDiiE+SuI0gAwY=;
        b=j29pzDSylapwZ2JotiEgJIzoZt0i4dhKqoWfwF9PHxZ5qVawDSu0RBg90dKqIl818gZRXr
        HLdMihppJlW9cB0cAYuas5TkbnJ6I37jqMuDqA0AZyLnb5GyXdOLQRGS42lynC9aeAVvnp
        tRdBfDG+6JMgmia8Cio9xolxx1vAJFwvLaaOdg3XUNSiHsMbOlnYzf2WvjxuHTO7JehI5f
        fyNVIj+AyqVDAvBIg+tYT1w9KJy75ofVeVRUes40M9DEv1fN7UTMKayGEVNyvlzyCUjdPS
        u+DDOfniXnBkNUJTaHPjKWZ3iZsI3u7hNdsNqkin0F7l7kxkehvgI8b5xl5XFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669277526;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xexxDX5KT6kwgcfQmlhhDfhA0srurYDiiE+SuI0gAwY=;
        b=kQcEYSZmMylzPWe8pHRr7mvHQTtCKw6EvIWwxt/j6xa3S9zVyY0+cLMtE2KoIp6kOfSsG0
        gyqUN+9mQ/e1X+AQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Move startup32_load_idt() into
 .text section
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221122161017.2426828-12-ardb@kernel.org>
References: <20221122161017.2426828-12-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <166927752495.4906.13742704492696736732.tip-bot2@tip-bot2>
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

Commit-ID:     c6355995ba471d7ad574174e593192ce805c7e1a
Gitweb:        https://git.kernel.org/tip/c6355995ba471d7ad574174e593192ce805c7e1a
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 22 Nov 2022 17:10:11 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 24 Nov 2022 08:57:41 +01:00

x86/boot/compressed: Move startup32_load_idt() into .text section

Convert startup32_load_idt() into an ordinary function and move it into
the .text section. This involves turning the rva() immediates into ones
derived from a local label, and preserving/restoring the %ebp and %ebx
as per the calling convention.

Also move the #ifdef to the only existing call site. This makes it clear
that the function call does nothing if support for memory encryption is
not compiled in.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221122161017.2426828-12-ardb@kernel.org
---
 arch/x86/boot/compressed/head_64.S | 31 ++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index f9926b3..7aa147f 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -118,7 +118,9 @@ SYM_FUNC_START(startup_32)
 1:
 
 	/* Setup Exception handling for SEV-ES */
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 	call	startup32_load_idt
+#endif
 
 	/* Make sure cpu supports long mode. */
 	call	verify_cpu
@@ -716,10 +718,8 @@ SYM_DATA_START(boot32_idt)
 	.quad 0
 	.endr
 SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
-#endif
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	__HEAD
+	.text
 	.code32
 /*
  * Write an IDT entry into boot32_idt
@@ -752,24 +752,32 @@ SYM_FUNC_START_LOCAL(startup32_set_idt_entry)
 
 	RET
 SYM_FUNC_END(startup32_set_idt_entry)
-#endif
 
 SYM_FUNC_START(startup32_load_idt)
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	leal    rva(boot32_idt)(%ebp), %ecx
+	push	%ebp
+	push	%ebx
+
+	call	1f
+1:	pop	%ebp
+
+	leal    (boot32_idt - 1b)(%ebp), %ebx
 
 	/* #VC handler */
-	leal    rva(startup32_vc_handler)(%ebp), %eax
+	leal    (startup32_vc_handler - 1b)(%ebp), %eax
 	movl    $X86_TRAP_VC, %edx
+	movl	%ebx, %ecx
 	call    startup32_set_idt_entry
 
 	/* Load IDT */
-	leal	rva(boot32_idt)(%ebp), %eax
-	movl	%eax, rva(boot32_idt_desc+2)(%ebp)
-	lidt    rva(boot32_idt_desc)(%ebp)
-#endif
+	leal	(boot32_idt_desc - 1b)(%ebp), %ecx
+	movl	%ebx, 2(%ecx)
+	lidt    (%ecx)
+
+	pop	%ebx
+	pop	%ebp
 	RET
 SYM_FUNC_END(startup32_load_idt)
+#endif
 
 /*
  * Check for the correct C-bit position when the startup_32 boot-path is used.
@@ -788,6 +796,7 @@ SYM_FUNC_END(startup32_load_idt)
  * succeed. An incorrect C-bit position will map all memory unencrypted, so that
  * the compare will use the encrypted random data and fail.
  */
+	__HEAD
 SYM_FUNC_START(startup32_check_sev_cbit)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	pushl	%eax
