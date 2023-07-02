Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F257450C9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjGBTm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjGBTmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:42:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D720210F6;
        Sun,  2 Jul 2023 12:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FAA060C7B;
        Sun,  2 Jul 2023 19:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29184C433C8;
        Sun,  2 Jul 2023 19:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326831;
        bh=3iXXwz18XmJ55Y24fpA8NtloRhCzr6C0INgKQZiuYYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gT1MZAe5sttUj6vkrLWeG1KzuOFtxKmOAzaFT+z5XLhAmBLo3UMekivs3IJZMj6EJ
         A5+A8nVwQweo1st6nP8aneU6P675W30CdsidLXyt3ljHRE0tCAoG4XC7AE3GdUsn69
         J3jkkULqliFxJ7WqJSLYHSg+xvwu7DzPl3rOAJdFbNttuLuG362O9DAuXSbbyOQQ1/
         LCKClDgUAoP7trPLpbfIcHtvna2YsJdYAPZPI68151W5X1sbxaupOOgLNe9fMo/rED
         Jyy3E0/AlByv2LvdLhac2bzVH1vl7YtHCjMPOqjKrfWZvflaJhal5sBFOeQhEIRnuL
         0/hefElajAJmg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sasha Levin <sashal@kernel.org>, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        usama.arif@bytedance.com, brgerst@gmail.com, jgross@suse.com,
        jpoimboe@kernel.org, thomas.lendacky@amd.com
Subject: [PATCH AUTOSEL 6.4 02/15] x86/smpboot: Implement a bit spinlock to protect the realmode stack
Date:   Sun,  2 Jul 2023 15:40:07 -0400
Message-Id: <20230702194020.1776895-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194020.1776895-1-sashal@kernel.org>
References: <20230702194020.1776895-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit f6f1ae9128d2a080ecdd55f85e8a0ca3ed1d58eb ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/realmode.h      |  3 +++
 arch/x86/kernel/head_64.S            | 12 ++++++++++++
 arch/x86/realmode/init.c             |  3 +++
 arch/x86/realmode/rm/trampoline_64.S | 23 ++++++++++++++++++-----
 4 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index f6a1737c77be2..87e5482acd0dc 100644
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
index 113c13376e512..6acf013c3a2c8 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -251,6 +251,16 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movq	pcpu_hot + X86_current_task(%rdx), %rax
 	movq	TASK_threadsp(%rax), %rsp
 
+	/*
+	 * Now that this CPU is running on its own stack, drop the realmode
+	 * protection. For the boot CPU the pointer is NULL!
+	 */
+	movq	trampoline_lock(%rip), %rax
+	testq	%rax, %rax
+	jz	.Lsetup_gdt
+	movl	$0, (%rax)
+
+.Lsetup_gdt:
 	/*
 	 * We must switch to a new descriptor in kernel space for the GDT
 	 * because soon the kernel won't have access anymore to the userspace
@@ -433,6 +443,8 @@ SYM_DATA(initial_code,	.quad x86_64_start_kernel)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
 #endif
+
+SYM_DATA(trampoline_lock, .quad 0);
 	__FINITDATA
 
 	__INIT
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index af565816d2ba6..788e5559549f3 100644
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
index e38d61d6562e4..4822ad2a5e898 100644
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
-- 
2.39.2

