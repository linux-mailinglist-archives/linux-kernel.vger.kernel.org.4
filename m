Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE174637398
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiKXINr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiKXIMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:12:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31605E8703;
        Thu, 24 Nov 2022 00:12:15 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:12:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669277533;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oWRWF85M+SfA0MipawGR7I4145ArwGZMy5HP1Q2cy7c=;
        b=eM4vKEN6OcPGru4fPEtHQn1aUrsizkZJ+MXGUVCmQo5l1xH6JzpDwly2DE723oRKZpO+RU
        Lkn13vOKf7LpC2N5sYsxre7q9A1ZxEg6k+ggVD8clph7vcE74YbE6MkowOcd1mEsdhJ2ty
        4VJbnoK3Dpl0drL8m128WvhdMg7/7DJUHs9WmSHDDh7pN+KfuXByRxmwI6sIoyVsTekMqC
        jN8HXJDFQEEgDVkD9/ymokvlLGWG5a3SlpSVbMjk6TkTgpgLPi4nOubCcGrUAU9f6Kfv0p
        5IqTPV/0aaGbvyJRJ7IYGWUpaSjuyAMvXD0VdU/MFA3Q2sSUzj8M4YOM15QguQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669277533;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oWRWF85M+SfA0MipawGR7I4145ArwGZMy5HP1Q2cy7c=;
        b=wYmD6+h490AyCCg3Zdedgd8fFjrA5yfhJIDnN0ZfauvEoS6yUOpLe2RCZ59hEGokUCuG6V
        1B3gbN3LmvjnrxCw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Move efi32_pe_entry into .text section
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221122161017.2426828-5-ardb@kernel.org>
References: <20221122161017.2426828-5-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <166927753244.4906.1655337476937933729.tip-bot2@tip-bot2>
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

Commit-ID:     91592b5c0c2f076ff9d8cc0c14aa563448ac9fc4
Gitweb:        https://git.kernel.org/tip/91592b5c0c2f076ff9d8cc0c14aa563448ac9fc4
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 22 Nov 2022 17:10:04 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 22 Nov 2022 19:23:01 +01:00

x86/boot/compressed: Move efi32_pe_entry into .text section

Move efi32_pe_entry() into the .text section, so that it can be moved
out of head_64.S and into a separate compilation unit in a subsequent
patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221122161017.2426828-5-ardb@kernel.org
---
 arch/x86/boot/compressed/head_64.S | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index f3d7de5..9dd9010 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -770,7 +770,7 @@ SYM_DATA(efi_is64, .byte 1)
 #define BS32_handle_protocol	88 // offsetof(efi_boot_services_32_t, handle_protocol)
 #define LI32_image_base		32 // offsetof(efi_loaded_image_32_t, image_base)
 
-	__HEAD
+	.text
 	.code32
 SYM_FUNC_START(efi32_pe_entry)
 /*
@@ -792,12 +792,11 @@ SYM_FUNC_START(efi32_pe_entry)
 
 	call	1f
 1:	pop	%ebx
-	subl	$ rva(1b), %ebx
 
 	/* Get the loaded image protocol pointer from the image handle */
 	leal	-4(%ebp), %eax
 	pushl	%eax				// &loaded_image
-	leal	rva(loaded_image_proto)(%ebx), %eax
+	leal	(loaded_image_proto - 1b)(%ebx), %eax
 	pushl	%eax				// pass the GUID address
 	pushl	8(%ebp)				// pass the image handle
 
@@ -826,13 +825,13 @@ SYM_FUNC_START(efi32_pe_entry)
 	movl	12(%ebp), %edx			// sys_table
 	movl	-4(%ebp), %esi			// loaded_image
 	movl	LI32_image_base(%esi), %esi	// loaded_image->image_base
-	movl	%ebx, %ebp			// startup_32 for efi32_pe_stub_entry
+	leal	(startup_32 - 1b)(%ebx), %ebp	// runtime address of startup_32
 	/*
 	 * We need to set the image_offset variable here since startup_32() will
 	 * use it before we get to the 64-bit efi_pe_entry() in C code.
 	 */
-	subl	%esi, %ebx
-	movl	%ebx, rva(image_offset)(%ebp)	// save image_offset
+	subl	%esi, %ebp			// calculate image_offset
+	movl	%ebp, (image_offset - 1b)(%ebx)	// save image_offset
 	xorl	%esi, %esi
 	jmp	efi32_entry			// pass %ecx, %edx, %esi
 						// no other registers remain live
