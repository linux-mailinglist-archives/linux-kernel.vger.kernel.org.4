Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D93637385
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKXINZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiKXIMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:12:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89208ED738;
        Thu, 24 Nov 2022 00:12:08 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:12:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669277527;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Hctjbwsd0uBSMqUV8yljvfkYsL5QCM1MfC9VCsHYa8=;
        b=x620PPjqof6ZOEWpPmGKXwl5XRfzK2nFOCJ2/rKvj7kJSx3TougSLeIUO4plDl2pd1O5g6
        eaQVism2RV0hHrES5hR5RYenqxZL3S7IUghOAwe/GQ9dDp2pX0f0UqH04pUeZEj7CMWYT3
        zPP2A3bEm1QbEAJ8UV1p8yp7GrCaUBJi5slI9NKU4HkfQ/D+fPzb39dF2MHouIVxz6TcOo
        nnPsU/1eIgeRjAGNbm5Htpr7QpWGpwQAuSGXrWRuF5npYYDqLr9DHe/JNbBuSz5rt3owfU
        WRjWLob4FCrupuVgFKjqYv43WMIWA4c/VxCciNAaOI77cdMjmziWPKQiRcfa1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669277527;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Hctjbwsd0uBSMqUV8yljvfkYsL5QCM1MfC9VCsHYa8=;
        b=tTDucwqd530QlJ6Rqfi/1VMxqy6u0urXXasU49ZxMk4ZGW+shLbqEJ0QcZG1K7z8oVY2xG
        lC9l8unxWnL38xCQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Pull global variable reference
 into startup32_load_idt()
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221122161017.2426828-11-ardb@kernel.org>
References: <20221122161017.2426828-11-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <166927752601.4906.14123818251261144320.tip-bot2@tip-bot2>
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

Commit-ID:     d73a257f7f86871c3aac24dc20538e3983096647
Gitweb:        https://git.kernel.org/tip/d73a257f7f86871c3aac24dc20538e3983096647
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 22 Nov 2022 17:10:10 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 24 Nov 2022 08:57:41 +01:00

x86/boot/compressed: Pull global variable reference into startup32_load_idt()

In preparation for moving startup32_load_idt() out of head_64.S and
turning it into an ordinary function using the ordinary 32-bit calling
convention, pull the global variable reference to boot32_idt up into
startup32_load_idt() so that startup32_set_idt_entry() does not need to
discover its own runtime physical address, which will no longer be
correlated with startup_32 once this code is moved into .text.

While at it, give startup32_set_idt_entry() static linkage.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221122161017.2426828-11-ardb@kernel.org
---
 arch/x86/boot/compressed/head_64.S | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index a2d1c03..f9926b3 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -728,16 +728,11 @@ SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
  *
  * %eax:	Handler address
  * %edx:	Vector number
- *
- * Physical offset is expected in %ebp
+ * %ecx:	IDT address
  */
-SYM_FUNC_START(startup32_set_idt_entry)
-	push    %ebx
-
-	/* IDT entry address to %ebx */
-	leal    rva(boot32_idt)(%ebp), %ebx
-	shl	$3, %edx
-	addl    %edx, %ebx
+SYM_FUNC_START_LOCAL(startup32_set_idt_entry)
+	/* IDT entry address to %ecx */
+	leal	(%ecx, %edx, 8), %ecx
 
 	/* Build IDT entry, lower 4 bytes */
 	movl    %eax, %edx
@@ -745,7 +740,7 @@ SYM_FUNC_START(startup32_set_idt_entry)
 	orl	$(__KERNEL32_CS << 16), %edx	# Target code segment selector
 
 	/* Store lower 4 bytes to IDT */
-	movl    %edx, (%ebx)
+	movl    %edx, (%ecx)
 
 	/* Build IDT entry, upper 4 bytes */
 	movl    %eax, %edx
@@ -753,15 +748,16 @@ SYM_FUNC_START(startup32_set_idt_entry)
 	orl     $0x00008e00, %edx	# Present, Type 32-bit Interrupt Gate
 
 	/* Store upper 4 bytes to IDT */
-	movl    %edx, 4(%ebx)
+	movl    %edx, 4(%ecx)
 
-	pop     %ebx
 	RET
 SYM_FUNC_END(startup32_set_idt_entry)
 #endif
 
 SYM_FUNC_START(startup32_load_idt)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
+	leal    rva(boot32_idt)(%ebp), %ecx
+
 	/* #VC handler */
 	leal    rva(startup32_vc_handler)(%ebp), %eax
 	movl    $X86_TRAP_VC, %edx
