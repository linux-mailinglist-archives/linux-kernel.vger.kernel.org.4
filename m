Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC7A637399
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKXINu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiKXIMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:12:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED0BD9BBD;
        Thu, 24 Nov 2022 00:12:16 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:12:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669277534;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fPpimrJIQAMCF4lmI39uXhb9L9z/d6NKQTTeNn4maz4=;
        b=qH1yk0LQ1Mo/Oma7w7BMP19PtI/U96N61VxxCepYFupN3v4HEmm3/tcqNLaNDRCAfjDkN7
        0D0ScK6NVGxe1GLspwlt1yzimp9hoNeQh5/qM0NVMHRl16ihrF7SV7Jd2F8/hL2s7BjAnJ
        VXty8vc8LtrMtkdlUXlnthczCjHhrxxpqsLv3g2JKAcnUwry384P5h6RnS7879UCSzSwob
        5QvVYFAVn5dXrdplEv10wy+buceiRUA91OZmE1Dn6mrcHfgpzb7Zv868XOLSmvJUHnnc9H
        0gN9VaB9AKdJeG6D6jHlUrGbSrGxo/BIBLEsLxs6YHW8lMc+yyAD8hO1pix+oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669277534;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fPpimrJIQAMCF4lmI39uXhb9L9z/d6NKQTTeNn4maz4=;
        b=zs7RhUL+PRCNXwRVLumyAmMfKOr1LPTd2b4BJnKtL41JkIR7GVCqTgYN7E+6eavJLck6k9
        1uJxYkqOEDUki4AA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Move bootargs parsing out of
 32-bit startup code
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221122161017.2426828-4-ardb@kernel.org>
References: <20221122161017.2426828-4-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <166927753357.4906.8620289754967434462.tip-bot2@tip-bot2>
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

Commit-ID:     5c3a85f35b583259cf5ca0344cd79c8899ba1bb7
Gitweb:        https://git.kernel.org/tip/5c3a85f35b583259cf5ca0344cd79c8899ba1bb7
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 22 Nov 2022 17:10:03 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 22 Nov 2022 19:21:26 +01:00

x86/boot/compressed: Move bootargs parsing out of 32-bit startup code

Move the logic that chooses between the different EFI entrypoints out of
the 32-bit boot path, and into a 64-bit helper that can perform the same
task much more cleanly. While at it, document the mixed mode boot flow
in a code comment.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221122161017.2426828-4-ardb@kernel.org
---
 arch/x86/boot/compressed/efi_mixed.S | 43 +++++++++++++++++++++++++++-
 arch/x86/boot/compressed/head_64.S   | 24 ++-------------
 2 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 67e7edc..58ab2e1 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -22,6 +22,49 @@
 
 	.code64
 	.text
+/*
+ * When booting in 64-bit mode on 32-bit EFI firmware, startup_64_mixed_mode()
+ * is the first thing that runs after switching to long mode. Depending on
+ * whether the EFI handover protocol or the compat entry point was used to
+ * enter the kernel, it will either branch to the 64-bit EFI handover
+ * entrypoint at offset 0x390 in the image, or to the 64-bit EFI PE/COFF
+ * entrypoint efi_pe_entry(). In the former case, the bootloader must provide a
+ * struct bootparams pointer as the third argument, so the presence of such a
+ * pointer is used to disambiguate.
+ *
+ *                                                             +--------------+
+ *  +------------------+     +------------+            +------>| efi_pe_entry |
+ *  | efi32_pe_entry   |---->|            |            |       +-----------+--+
+ *  +------------------+     |            |     +------+----------------+  |
+ *                           | startup_32 |---->| startup_64_mixed_mode |  |
+ *  +------------------+     |            |     +------+----------------+  V
+ *  | efi32_stub_entry |---->|            |            |     +------------------+
+ *  +------------------+     +------------+            +---->| efi64_stub_entry |
+ *                                                           +-------------+----+
+ *                           +------------+     +----------+               |
+ *                           | startup_64 |<----| efi_main |<--------------+
+ *                           +------------+     +----------+
+ */
+SYM_FUNC_START(startup_64_mixed_mode)
+	lea	efi32_boot_args(%rip), %rdx
+	mov	0(%rdx), %edi
+	mov	4(%rdx), %esi
+	mov	8(%rdx), %edx		// saved bootparams pointer
+	test	%edx, %edx
+	jnz	efi64_stub_entry
+	/*
+	 * efi_pe_entry uses MS calling convention, which requires 32 bytes of
+	 * shadow space on the stack even if all arguments are passed in
+	 * registers. We also need an additional 8 bytes for the space that
+	 * would be occupied by the return address, and this also results in
+	 * the correct stack alignment for entry.
+	 */
+	sub	$40, %rsp
+	mov	%rdi, %rcx		// MS calling convention
+	mov	%rsi, %rdx
+	jmp	efi_pe_entry
+SYM_FUNC_END(startup_64_mixed_mode)
+
 SYM_FUNC_START(__efi64_thunk)
 	push	%rbp
 	push	%rbx
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 5d07ef7..f3d7de5 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -261,25 +261,9 @@ SYM_FUNC_START(startup_32)
 	 */
 	leal	rva(startup_64)(%ebp), %eax
 #ifdef CONFIG_EFI_MIXED
-	movl	rva(efi32_boot_args)(%ebp), %edi
-	testl	%edi, %edi
-	jz	1f
-	leal	rva(efi64_stub_entry)(%ebp), %eax
-	movl	rva(efi32_boot_args+4)(%ebp), %esi
-	movl	rva(efi32_boot_args+8)(%ebp), %edx	// saved bootparams pointer
-	testl	%edx, %edx
-	jnz	1f
-	/*
-	 * efi_pe_entry uses MS calling convention, which requires 32 bytes of
-	 * shadow space on the stack even if all arguments are passed in
-	 * registers. We also need an additional 8 bytes for the space that
-	 * would be occupied by the return address, and this also results in
-	 * the correct stack alignment for entry.
-	 */
-	subl	$40, %esp
-	leal	rva(efi_pe_entry)(%ebp), %eax
-	movl	%edi, %ecx			// MS calling convention
-	movl	%esi, %edx
+	cmpb	$1, rva(efi_is64)(%ebp)
+	je	1f
+	leal	rva(startup_64_mixed_mode)(%ebp), %eax
 1:
 #endif
 	/* Check if the C-bit position is correct when SEV is active */
@@ -779,7 +763,7 @@ SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
 SYM_DATA(image_offset, .long 0)
 #endif
 #ifdef CONFIG_EFI_MIXED
-SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
+SYM_DATA(efi32_boot_args, .long 0, 0, 0)
 SYM_DATA(efi_is64, .byte 1)
 
 #define ST32_boottime		60 // offsetof(efi_system_table_32_t, boottime)
