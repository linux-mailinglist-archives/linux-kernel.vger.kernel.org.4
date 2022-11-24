Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8DA63737D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiKXINJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiKXIMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:12:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16EEE2B5E;
        Thu, 24 Nov 2022 00:12:02 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:12:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669277521;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sXG1WiaHSdDH9/dXCMjF+OGQtyZOdzl8X9IRE8OLDaw=;
        b=EbFBsiSkXkRnoSblrxUeKTMkYlrsbRoWId6pjVAmZT39FKAUMmbw7XLFbflUgAs/O1b5m6
        Y6P9rRuYglZCt0BMmVHfJ5hGeBm+LSb4mNdld3qcPUcFAdqrPXFxQh28SYd5iZuitRfLvB
        g5B8/XeETwIswBFecZV/ghXIo5m1VoiqVyyM7kcM7u18zsyP88O3oEL6I//N8b5mSvUFlb
        HrpfPBlbJG5vOcZvQzXR3tlQJaZANuaaGqfTxbuhz8x3W9Nx4vU0ZmRTJTM9aLiMI/OMr0
        b/imeYXpTtnga6NVZPmi0Trb8rgo9+rSyBuZZpAkIur/RCVUUoyOIfZEv9TKqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669277521;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sXG1WiaHSdDH9/dXCMjF+OGQtyZOdzl8X9IRE8OLDaw=;
        b=tdZgBhkIfS4KeNA2TmajMjpNvZNEuIrLXabD1CKXxj7l1Tw6dhvwnpVmAf2JOd/PYEsnv3
        +8TqiQ6pzT/LwFDA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Adhere to calling convention in
 get_sev_encryption_bit()
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221122161017.2426828-16-ardb@kernel.org>
References: <20221122161017.2426828-16-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <166927752026.4906.18301917171535332713.tip-bot2@tip-bot2>
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

Commit-ID:     30c9ca16a5271ba6f8ad9c86507ff1c789c94677
Gitweb:        https://git.kernel.org/tip/30c9ca16a5271ba6f8ad9c86507ff1c789c94677
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 22 Nov 2022 17:10:15 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 24 Nov 2022 08:57:41 +01:00

x86/boot/compressed: Adhere to calling convention in get_sev_encryption_bit()

Make get_sev_encryption_bit() follow the ordinary i386 calling
convention, and only call it if CONFIG_AMD_MEM_ENCRYPT is actually
enabled. This clarifies the calling code, and makes it more
maintainable.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221122161017.2426828-16-ardb@kernel.org
---
 arch/x86/boot/compressed/head_64.S     |  5 +++--
 arch/x86/boot/compressed/mem_encrypt.S | 10 ----------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index db577fb..6ba2c21 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -180,12 +180,13 @@ SYM_FUNC_START(startup_32)
   */
 	/*
 	 * If SEV is active then set the encryption mask in the page tables.
-	 * This will insure that when the kernel is copied and decompressed
+	 * This will ensure that when the kernel is copied and decompressed
 	 * it will be done so encrypted.
 	 */
-	call	get_sev_encryption_bit
 	xorl	%edx, %edx
 #ifdef	CONFIG_AMD_MEM_ENCRYPT
+	call	get_sev_encryption_bit
+	xorl	%edx, %edx
 	testl	%eax, %eax
 	jz	1f
 	subl	$32, %eax	/* Encryption bit is always above bit 31 */
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index 14cf04a..e696745 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -18,12 +18,7 @@
 	.text
 	.code32
 SYM_FUNC_START(get_sev_encryption_bit)
-	xor	%eax, %eax
-
-#ifdef CONFIG_AMD_MEM_ENCRYPT
 	push	%ebx
-	push	%ecx
-	push	%edx
 
 	movl	$0x80000000, %eax	/* CPUID to check the highest leaf */
 	cpuid
@@ -54,12 +49,7 @@ SYM_FUNC_START(get_sev_encryption_bit)
 	xor	%eax, %eax
 
 .Lsev_exit:
-	pop	%edx
-	pop	%ecx
 	pop	%ebx
-
-#endif	/* CONFIG_AMD_MEM_ENCRYPT */
-
 	RET
 SYM_FUNC_END(get_sev_encryption_bit)
 
