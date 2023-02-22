Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE89969FE3E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjBVWN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjBVWNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:13:39 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F4291
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:13:22 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id b6so2958961qtb.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTZtaHujjzboIBxRswwzZg+kJeIkZN07DRxgFsYXLxo=;
        b=V/Mk3ffQteBbNJV3TTjZlY2uoV9u5vqGBg9SrvRB6qP0XE7IgPIyqTNImL2lw0q8in
         XP/vGzUzZ85JuLFSxAn7McTz/vGaXDDngNLCuQuBhMxyuHSM37z3ZhoSvbXN9VeZDK6x
         hAg2Z6OO59lv0p62k/SFHfl2CPu4i0h8ZWdfawP8Hun75JcYhxyy8kzdKJIXWypMc44s
         CwRDhmExAcAvYqkQGqcJlBhnLcEJLtlxx7z934iZh18VKVjq68eSyONDcS+faioD8RjO
         gA5mpFeDIVzVTGsLWSYjrp9W+jsJ4UF6NKYTxMbeWxvu5uxaTdLhn5nfiyLlT910nNJL
         oRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTZtaHujjzboIBxRswwzZg+kJeIkZN07DRxgFsYXLxo=;
        b=Fw2lRzBM71tLwRSRns2AjS82PQlROHUo1TpiotLohaEzamx+mBn2eldhaqh2zZ8OIc
         x+AnOye69mkKPrz2YlnASHsDv+l2z0cnsKD//F5kiccISBSTOY2Xn9Pkl8Tqp47Gr7lp
         BmFMA49F6JogTE4NKfuD5xBf02SnHnvKcmCf0a0G7mupzSwDaV+lWedof4AXOvrmQKh8
         hz4sWHs30eIgKOICcyXmeotylVun9EF9h4gTkrwttK6ReXiqmovIJJp5+AKbJYTQrAkC
         HmVPDA4Nf7zPQGjGJ/kxC1qtZmr1i/H3p6Npx7EfHCJpWCOYolUlhWzWtEJrPMMen6i0
         hbyw==
X-Gm-Message-State: AO0yUKW7MlAXs+bGsm9iTY+LW9vNlKB4bxtgPHdX1sV78p0BHAgwxNJS
        6flZ9kKTFb1n3GYAIoYzuWEV80wsKQ==
X-Google-Smtp-Source: AK7set8lNvS9WvOjXR8PkYKgn+VaKLp8tEnXjAgPLtOybsWh1FUKc8plyT/GBKsPLEl2HFn4pnhJFg==
X-Received: by 2002:a05:622a:118a:b0:3b2:1003:37e5 with SMTP id m10-20020a05622a118a00b003b2100337e5mr18518163qtk.55.1677104001194;
        Wed, 22 Feb 2023 14:13:21 -0800 (PST)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id ey17-20020a05622a4c1100b003b86b088755sm4902460qtb.15.2023.02.22.14.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 14:13:20 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Usama Arif <usama.arif@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 3/6] x86/smpboot: Remove initial_stack on 64-bit
Date:   Wed, 22 Feb 2023 17:12:58 -0500
Message-Id: <20230222221301.245890-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222221301.245890-1-brgerst@gmail.com>
References: <20230222221301.245890-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Load RSP from current_task->thread.sp instead.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/processor.h |  6 +++++-
 arch/x86/kernel/acpi/sleep.c     |  2 +-
 arch/x86/kernel/head_64.S        | 35 ++++++++++++++++++--------------
 arch/x86/xen/xen-head.S          |  2 +-
 4 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 8d73004e4cac..7f64b69c2b0e 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -647,7 +647,11 @@ static inline void spin_lock_prefetch(const void *x)
 #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
 
 #else
-#define INIT_THREAD { }
+extern unsigned long __end_init_task[];
+
+#define INIT_THREAD {							\
+	.sp	= (unsigned long)&__end_init_task - PTREGS_SIZE,	\
+}
 
 extern unsigned long KSTK_ESP(struct task_struct *task);
 
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 47e75c056cb5..008fda8b1982 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -113,7 +113,7 @@ int x86_acpi_suspend_lowlevel(void)
 	saved_magic = 0x12345678;
 #else /* CONFIG_64BIT */
 #ifdef CONFIG_SMP
-	initial_stack = (unsigned long)temp_stack + sizeof(temp_stack);
+	current->thread.sp = (unsigned long)temp_stack + sizeof(temp_stack);
 	early_gdt_descr.address =
 			(unsigned long)get_cpu_gdt_rw(smp_processor_id());
 	initial_gs = per_cpu_offset(smp_processor_id());
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index c32e5b06a9ce..f7905ba4b992 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -62,8 +62,8 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * tables and then reload them.
 	 */
 
-	/* Set up the stack for verify_cpu(), similar to initial_stack below */
-	leaq	(__end_init_task - FRAME_SIZE)(%rip), %rsp
+	/* Set up the stack for verify_cpu() */
+	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
 
 	leaq	_text(%rip), %rdi
 
@@ -245,11 +245,11 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 #ifdef CONFIG_SMP
 	/*
 	 * Is this the boot CPU coming up? If so everything is available
-	 * in initial_gs, initial_stack and early_gdt_descr.
+	 * in initial_gs and early_gdt_descr.
 	 */
 	movl	smpboot_control(%rip), %edx
 	testl	$STARTUP_SECONDARY, %edx
-	jz	.Lsetup_cpu
+	jz	.Linit_cpu0_data
 
 	/*
 	 * For parallel boot, the APIC ID is retrieved from CPUID, and then
@@ -302,6 +302,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	hlt
 	jmp	1b
 
+.Linit_cpu0_data:
+	movq	__per_cpu_offset(%rip), %rdx
+	jmp	.Lsetup_cpu
+
 .Linit_cpu_data:
 	/* Get the per cpu offset for the given CPU# which is in ECX */
 	leaq	__per_cpu_offset(%rip), %rbx
@@ -314,13 +318,21 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	addq	%rbx, %rcx
 	movq	%rcx, early_gdt_descr_base(%rip)
 
-	/* Find the idle task stack */
-	movq	pcpu_hot + X86_current_task(%rbx), %rcx
-	movq	TASK_threadsp(%rcx), %rcx
-	movq	%rcx, initial_stack(%rip)
+	movq	%rbx, %rdx
+#else
+	xorl	%edx, %edx
 #endif /* CONFIG_SMP */
 
 .Lsetup_cpu:
+	/*
+	 * Setup a boot time stack - Any secondary CPU will have lost its stack
+	 * by now because the cr3-switch above unmaps the real-mode stack
+	 *
+	 * RDX contains the per-cpu offset
+	 */
+	movq	pcpu_hot + X86_current_task(%rdx), %rax
+	movq	TASK_threadsp(%rax), %rsp
+
 	/*
 	 * We must switch to a new descriptor in kernel space for the GDT
 	 * because soon the kernel won't have access anymore to the userspace
@@ -355,12 +367,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movl	initial_gs+4(%rip),%edx
 	wrmsr
 
-	/*
-	 * Setup a boot time stack - Any secondary CPU will have lost its stack
-	 * by now because the cr3-switch above unmaps the real-mode stack
-	 */
-	movq initial_stack(%rip), %rsp
-
 	/* Drop the realmode protection. For the boot CPU the pointer is NULL! */
 	movq	trampoline_lock(%rip), %rax
 	testq	%rax, %rax
@@ -517,7 +523,6 @@ SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
  * The FRAME_SIZE gap is a convention which helps the in-kernel unwinder
  * reliably detect the end of the stack.
  */
-SYM_DATA(initial_stack, .quad init_thread_union + THREAD_SIZE - FRAME_SIZE)
 SYM_DATA(trampoline_lock, .quad 0);
 	__FINITDATA
 
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index e36ea4268bd2..91f7a53519a7 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -49,7 +49,7 @@ SYM_CODE_START(startup_xen)
 	ANNOTATE_NOENDBR
 	cld
 
-	mov initial_stack(%rip), %rsp
+	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
 
 	/* Set up %gs.
 	 *
-- 
2.39.2

