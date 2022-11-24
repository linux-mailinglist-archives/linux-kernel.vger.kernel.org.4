Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F41637381
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiKXINP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiKXIMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:12:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34805ECCF8;
        Thu, 24 Nov 2022 00:12:04 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:12:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669277522;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4AUUIgELc/8f64Y6NlAUQy2yAq4EBAXXDe6jsRvwdmU=;
        b=mus2ZsKlDclZ47SSZq6RJ7TMIdhJD76U9S4SjQ1j2hpJFse8EHdoNIDViQ1qEpXllFHuc9
        pwKCkOyie7twhxfuSW8xS0i7qJGAc0diTuLEMMe6LoPSDCnE+GsD+coXJssR+x1GBCro4p
        Loi9yc1VnfY1GhO0VMDX3sgksvS4OIXl1cpmnUZJjt1koWZupe69GCITyHqGvG+dKzJwFe
        d0S5bJEfUmuofiUXGsQ0JRRTnLBnpAmcDCLeSW5CRf3copbtesJwMUjQqmDwQa5o1s4DQB
        9x1Qzkv7avJn9Tpgd7qQE/Few7lKKEAyzQ4kV+MacvbNQInRog7avZOjf8M6kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669277522;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4AUUIgELc/8f64Y6NlAUQy2yAq4EBAXXDe6jsRvwdmU=;
        b=phhn7DLzMruvp6QC7X3Shc7ZAMQyv5ff4EECVSOBN/XtA1SJJ39NZYGJRXFcBJhXttbpQt
        dRjS2OHlM4/RjaCg==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Move startup32_check_sev_cbit()
 out of head_64.S
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221122161017.2426828-15-ardb@kernel.org>
References: <20221122161017.2426828-15-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <166927752150.4906.4076564626502028600.tip-bot2@tip-bot2>
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

Commit-ID:     9d7eaae6a071ff1f718e0aa5e610bb712f8cc632
Gitweb:        https://git.kernel.org/tip/9d7eaae6a071ff1f718e0aa5e610bb712f8cc632
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 22 Nov 2022 17:10:14 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 24 Nov 2022 08:57:41 +01:00

x86/boot/compressed: Move startup32_check_sev_cbit() out of head_64.S

Now that the startup32_check_sev_cbit() routine can execute from
anywhere and behaves like an ordinary function, it can be moved where it
belongs.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221122161017.2426828-15-ardb@kernel.org
---
 arch/x86/boot/compressed/head_64.S     | 71 +-------------------------
 arch/x86/boot/compressed/mem_encrypt.S | 68 ++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 71 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 30ba541..db577fb 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -711,77 +711,6 @@ SYM_DATA_START(boot_idt)
 SYM_DATA_END_LABEL(boot_idt, SYM_L_GLOBAL, boot_idt_end)
 
 /*
- * Check for the correct C-bit position when the startup_32 boot-path is used.
- *
- * The check makes use of the fact that all memory is encrypted when paging is
- * disabled. The function creates 64 bits of random data using the RDRAND
- * instruction. RDRAND is mandatory for SEV guests, so always available. If the
- * hypervisor violates that the kernel will crash right here.
- *
- * The 64 bits of random data are stored to a memory location and at the same
- * time kept in the %eax and %ebx registers. Since encryption is always active
- * when paging is off the random data will be stored encrypted in main memory.
- *
- * Then paging is enabled. When the C-bit position is correct all memory is
- * still mapped encrypted and comparing the register values with memory will
- * succeed. An incorrect C-bit position will map all memory unencrypted, so that
- * the compare will use the encrypted random data and fail.
- */
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	.text
-SYM_FUNC_START(startup32_check_sev_cbit)
-	pushl	%ebx
-	pushl	%ebp
-
-	call	0f
-0:	popl	%ebp
-
-	/* Check for non-zero sev_status */
-	movl	(sev_status - 0b)(%ebp), %eax
-	testl	%eax, %eax
-	jz	4f
-
-	/*
-	 * Get two 32-bit random values - Don't bail out if RDRAND fails
-	 * because it is better to prevent forward progress if no random value
-	 * can be gathered.
-	 */
-1:	rdrand	%eax
-	jnc	1b
-2:	rdrand	%ebx
-	jnc	2b
-
-	/* Store to memory and keep it in the registers */
-	leal	(sev_check_data - 0b)(%ebp), %ebp
-	movl	%eax, 0(%ebp)
-	movl	%ebx, 4(%ebp)
-
-	/* Enable paging to see if encryption is active */
-	movl	%cr0, %edx			 /* Backup %cr0 in %edx */
-	movl	$(X86_CR0_PG | X86_CR0_PE), %ecx /* Enable Paging and Protected mode */
-	movl	%ecx, %cr0
-
-	cmpl	%eax, 0(%ebp)
-	jne	3f
-	cmpl	%ebx, 4(%ebp)
-	jne	3f
-
-	movl	%edx, %cr0	/* Restore previous %cr0 */
-
-	jmp	4f
-
-3:	/* Check failed - hlt the machine */
-	hlt
-	jmp	3b
-
-4:
-	popl	%ebp
-	popl	%ebx
-	RET
-SYM_FUNC_END(startup32_check_sev_cbit)
-#endif
-
-/*
  * Stack and heap for uncompression
  */
 	.bss
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index 6747e5e..14cf04a 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -243,6 +243,74 @@ SYM_FUNC_START(startup32_load_idt)
 	RET
 SYM_FUNC_END(startup32_load_idt)
 
+/*
+ * Check for the correct C-bit position when the startup_32 boot-path is used.
+ *
+ * The check makes use of the fact that all memory is encrypted when paging is
+ * disabled. The function creates 64 bits of random data using the RDRAND
+ * instruction. RDRAND is mandatory for SEV guests, so always available. If the
+ * hypervisor violates that the kernel will crash right here.
+ *
+ * The 64 bits of random data are stored to a memory location and at the same
+ * time kept in the %eax and %ebx registers. Since encryption is always active
+ * when paging is off the random data will be stored encrypted in main memory.
+ *
+ * Then paging is enabled. When the C-bit position is correct all memory is
+ * still mapped encrypted and comparing the register values with memory will
+ * succeed. An incorrect C-bit position will map all memory unencrypted, so that
+ * the compare will use the encrypted random data and fail.
+ */
+SYM_FUNC_START(startup32_check_sev_cbit)
+	pushl	%ebx
+	pushl	%ebp
+
+	call	0f
+0:	popl	%ebp
+
+	/* Check for non-zero sev_status */
+	movl	(sev_status - 0b)(%ebp), %eax
+	testl	%eax, %eax
+	jz	4f
+
+	/*
+	 * Get two 32-bit random values - Don't bail out if RDRAND fails
+	 * because it is better to prevent forward progress if no random value
+	 * can be gathered.
+	 */
+1:	rdrand	%eax
+	jnc	1b
+2:	rdrand	%ebx
+	jnc	2b
+
+	/* Store to memory and keep it in the registers */
+	leal	(sev_check_data - 0b)(%ebp), %ebp
+	movl	%eax, 0(%ebp)
+	movl	%ebx, 4(%ebp)
+
+	/* Enable paging to see if encryption is active */
+	movl	%cr0, %edx			 /* Backup %cr0 in %edx */
+	movl	$(X86_CR0_PG | X86_CR0_PE), %ecx /* Enable Paging and Protected mode */
+	movl	%ecx, %cr0
+
+	cmpl	%eax, 0(%ebp)
+	jne	3f
+	cmpl	%ebx, 4(%ebp)
+	jne	3f
+
+	movl	%edx, %cr0	/* Restore previous %cr0 */
+
+	jmp	4f
+
+3:	/* Check failed - hlt the machine */
+	hlt
+	jmp	3b
+
+4:
+	popl	%ebp
+	popl	%ebx
+	RET
+SYM_FUNC_END(startup32_check_sev_cbit)
+
 	.code64
 
 #include "../../kernel/sev_verify_cbit.S"
