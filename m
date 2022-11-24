Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5846637386
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiKXIN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiKXIMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:12:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C09E6740;
        Thu, 24 Nov 2022 00:12:09 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:12:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669277528;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N6HscZAVCY8KRoZ6LIF2oha+45Vzc6klE8SeCIiiTso=;
        b=ATQ+0A8vW6zNEWv/ZQgkiZqdCZGp6lLxbomoWEaU/0kJI43vUAx2eJp72v6vfAasO49BYl
        4WupwJxz1QYREDvjHpHL0NPsvEyDZXGOT4H9q9mrH3FYzHT2YkclKpvSb/Qa35ljENuZvJ
        4/uTY3yCrK85fmwRbdg7Nd4corpjF0Q4yWmZ3yMrQz2MKAEfAmyB0NoSn3gtB6AiAFMtgo
        ibaC3X5lrrtCVtzkbC9BYA70/6na90qjQUViTp2SbKkmU0hMs0G3XMeJBm8nzzJvW5WNZH
        67kZe+X68vyCRZeFRGy4i8QV8k5J7OJPbPr5kTuroj6rXtpFM3zXc9Qogyq2HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669277528;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N6HscZAVCY8KRoZ6LIF2oha+45Vzc6klE8SeCIiiTso=;
        b=BKqJLw2/1MoGTCjrRMULp92NtiPhMF5moLVSS+zdo2C3nNv3Z0+LrJJdH1OYj4d8fQpljv
        CJRd9YAMZqdQSQAw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Avoid touching ECX in
 startup32_set_idt_entry()
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221122161017.2426828-10-ardb@kernel.org>
References: <20221122161017.2426828-10-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <166927752707.4906.15976854475607977987.tip-bot2@tip-bot2>
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

Commit-ID:     6aac80a8da46d70f2ae7ff97c9f45a15c7c9b3ef
Gitweb:        https://git.kernel.org/tip/6aac80a8da46d70f2ae7ff97c9f45a15c7c9b3ef
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 22 Nov 2022 17:10:09 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 24 Nov 2022 08:57:41 +01:00

x86/boot/compressed: Avoid touching ECX in startup32_set_idt_entry()

Avoid touching register %ecx in startup32_set_idt_entry(), by folding
the MOV, SHL and ORL instructions into a single ORL which no longer
requires a temp register.

This permits ECX to be used as a function argument in a subsequent
patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221122161017.2426828-10-ardb@kernel.org
---
 arch/x86/boot/compressed/head_64.S | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 34d0395..a2d1c03 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -733,7 +733,6 @@ SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
  */
 SYM_FUNC_START(startup32_set_idt_entry)
 	push    %ebx
-	push    %ecx
 
 	/* IDT entry address to %ebx */
 	leal    rva(boot32_idt)(%ebp), %ebx
@@ -742,10 +741,8 @@ SYM_FUNC_START(startup32_set_idt_entry)
 
 	/* Build IDT entry, lower 4 bytes */
 	movl    %eax, %edx
-	andl    $0x0000ffff, %edx	# Target code segment offset [15:0]
-	movl    $__KERNEL32_CS, %ecx	# Target code segment selector
-	shl     $16, %ecx
-	orl     %ecx, %edx
+	andl    $0x0000ffff, %edx		# Target code segment offset [15:0]
+	orl	$(__KERNEL32_CS << 16), %edx	# Target code segment selector
 
 	/* Store lower 4 bytes to IDT */
 	movl    %edx, (%ebx)
@@ -758,7 +755,6 @@ SYM_FUNC_START(startup32_set_idt_entry)
 	/* Store upper 4 bytes to IDT */
 	movl    %edx, 4(%ebx)
 
-	pop     %ecx
 	pop     %ebx
 	RET
 SYM_FUNC_END(startup32_set_idt_entry)
