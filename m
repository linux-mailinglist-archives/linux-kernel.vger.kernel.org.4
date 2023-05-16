Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77748704886
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjEPJKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjEPJJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:09:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8722D55;
        Tue, 16 May 2023 02:09:56 -0700 (PDT)
Date:   Tue, 16 May 2023 09:09:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228194;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmb7GmwcHkt8LlypsC9tX9bRJEK96DDA+0p2OMOgRGo=;
        b=LY4aWGcoc7RTEbArVVANGoM0EgN0rxrRdwynspt5eVn+dPrx5gpYlqfTUZDROkqmiZ5vwh
        tyopAw8O0IGpYEivvcCL6iBKrBzw77YIoNiYAWJ9yMsXI5zX4zaTblvn3OzqLwOwWMe97r
        nEowt7baksVZlILmVwvLrMCsgaUQbEpP6r5ZJSbUnDRpKX8xCqUoRGhwcjBgae73OrOo8k
        6J11VpWtlv/wUSHKUqK5GDMdB3FEw505kMga46OUh2kg/ibyxyWhbduguo64o4LGgfVJxn
        rginyLKyecRTXVAv7jGE5wzgL/XwkUSWhsYOO7LTm8SqrBFTsl/FwjF4j8znhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228194;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmb7GmwcHkt8LlypsC9tX9bRJEK96DDA+0p2OMOgRGo=;
        b=X+avK+pgRfomuhvc1BDXsqohLxWBaOih9sxTTrxaJTnWUXlqUu/5Ugk2X5IyGkJBhPAJ+g
        u6ZJzBlfpEyifjCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/smpboot: Implement a bit spinlock to protect the
 realmode stack
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205257.355425551@linutronix.de>
References: <20230512205257.355425551@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422819410.404.5810226958076562803.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     f6f1ae9128d2a080ecdd55f85e8a0ca3ed1d58eb
Gitweb:        https://git.kernel.org/tip/f6f1ae9128d2a080ecdd55f85e8a0ca3ed1d58eb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:53 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:45:03 +02:00

x86/smpboot: Implement a bit spinlock to protect the realmode stack

Parallel AP bringup requires that the APs can run fully parallel through
the early startup code including the real mode trampoline.

To prepare for this implement a bit-spinlock to serialize access to the
real mode stack so that parallel upcoming APs are not going to corrupt each
others stack while going through the real mode startup code.

Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205257.355425551@linutronix.de
---
 arch/x86/include/asm/realmode.h      |  3 +++
 arch/x86/kernel/head_64.S            | 12 ++++++++++++
 arch/x86/realmode/init.c             |  3 +++
 arch/x86/realmode/rm/trampoline_64.S | 23 ++++++++++++++++++-----
 4 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index f6a1737..87e5482 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -52,6 +52,7 @@ struct trampoline_header {
 	u64 efer;
 	u32 cr4;
 	u32 flags;
+	u32 lock;
 #endif
 };
 
@@ -64,6 +65,8 @@ extern unsigned long initial_stack;
 extern unsigned long initial_vc_handler;
 #endif
 
+extern u32 *trampoline_lock;
+
 extern unsigned char real_mode_blob[];
 extern unsigned char real_mode_relocs[];
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 8458033..f99e9ab 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -252,6 +252,16 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movq	TASK_threadsp(%rax), %rsp
 
 	/*
+	 * Now that this CPU is running on its own stack, drop the realmode
+	 * protection. For the boot CPU the pointer is NULL!
+	 */
+	movq	trampoline_lock(%rip), %rax
+	testq	%rax, %rax
+	jz	.Lsetup_gdt
+	movl	$0, (%rax)
+
+.Lsetup_gdt:
+	/*
 	 * We must switch to a new descriptor in kernel space for the GDT
 	 * because soon the kernel won't have access anymore to the userspace
 	 * addresses where we're currently running on. We have to do that here
@@ -433,6 +443,8 @@ SYM_DATA(initial_code,	.quad x86_64_start_kernel)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
 #endif
+
+SYM_DATA(trampoline_lock, .quad 0);
 	__FINITDATA
 
 	__INIT
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index af56581..788e555 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -154,6 +154,9 @@ static void __init setup_real_mode(void)
 
 	trampoline_header->flags = 0;
 
+	trampoline_lock = &trampoline_header->lock;
+	*trampoline_lock = 0;
+
 	trampoline_pgd = (u64 *) __va(real_mode_header->trampoline_pgd);
 
 	/* Map the real mode stub as virtual == physical */
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index e38d61d..4822ad2 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -37,6 +37,20 @@
 	.text
 	.code16
 
+.macro LOAD_REALMODE_ESP
+	/*
+	 * Make sure only one CPU fiddles with the realmode stack
+	 */
+.Llock_rm\@:
+        lock btsl       $0, tr_lock
+        jnc             2f
+        pause
+        jmp             .Llock_rm\@
+2:
+	# Setup stack
+	movl	$rm_stack_end, %esp
+.endm
+
 	.balign	PAGE_SIZE
 SYM_CODE_START(trampoline_start)
 	cli			# We should be safe anyway
@@ -49,8 +63,7 @@ SYM_CODE_START(trampoline_start)
 	mov	%ax, %es
 	mov	%ax, %ss
 
-	# Setup stack
-	movl	$rm_stack_end, %esp
+	LOAD_REALMODE_ESP
 
 	call	verify_cpu		# Verify the cpu supports long mode
 	testl   %eax, %eax		# Check for return code
@@ -93,8 +106,7 @@ SYM_CODE_START(sev_es_trampoline_start)
 	mov	%ax, %es
 	mov	%ax, %ss
 
-	# Setup stack
-	movl	$rm_stack_end, %esp
+	LOAD_REALMODE_ESP
 
 	jmp	.Lswitch_to_protected
 SYM_CODE_END(sev_es_trampoline_start)
@@ -177,7 +189,7 @@ SYM_CODE_START(pa_trampoline_compat)
 	 * In compatibility mode.  Prep ESP and DX for startup_32, then disable
 	 * paging and complete the switch to legacy 32-bit mode.
 	 */
-	movl	$rm_stack_end, %esp
+	LOAD_REALMODE_ESP
 	movw	$__KERNEL_DS, %dx
 
 	movl	$(CR0_STATE & ~X86_CR0_PG), %eax
@@ -241,6 +253,7 @@ SYM_DATA_START(trampoline_header)
 	SYM_DATA(tr_efer,		.space 8)
 	SYM_DATA(tr_cr4,		.space 4)
 	SYM_DATA(tr_flags,		.space 4)
+	SYM_DATA(tr_lock,		.space 4)
 SYM_DATA_END(trampoline_header)
 
 #include "trampoline_common.S"
