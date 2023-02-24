Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD846A1EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBXPmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBXPmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:42:44 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC2D66964
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:42:41 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id op8so14281726qvb.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cjo72C8shTrqkNA3EEnWKBaKFGEmPRo9WbjcR9+Jn9I=;
        b=PhDTwowMUme0dsqcW825Cf4np4FW0FiS5vbXxSrx+YZNPz3MXCudsjHjKWL0YjU9/F
         Ipbsr9GtgGke2dc2SncWt2JIz/NUn+Z83xxc3xRJ6RM1XIRxh6wtXOW/pF1ke5+pJqx2
         0fzqVauj83hdKIj/kf1MksgZTkmhwMhgw2z0LdQo5QMHTQiLMmlZPpKPHxL4vAbcx50L
         nC4/BulCV9mkMWOGMwMt4KAPzD8lEBOSHNrexEQnBIB76wySSbxRtqvZtmbSGZSnGlws
         FQ+Jjee35knKdZDnhNYS0pZ2RfDduTq0QVILiINwIyQwtkOOcW97jS10Abp+xHjTrQ1Q
         jz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cjo72C8shTrqkNA3EEnWKBaKFGEmPRo9WbjcR9+Jn9I=;
        b=ea4TzvK98l9sfeum1phi13dxSBPSVz6sK+o3JvFya0OPr1ws81d3ggUNcSVgF94lP4
         TCLrAZ2lO+1T1azTyub2OjGMCow9oy9SnitePj2bJl+o3PQ7AJORQHIFyDG7nR4IxOqt
         lWjkCaWhwXd6oAJJMdR4MxyOFI32Cixg/omLkdkko4zZwz8Ec4P5QR//j8FBQ6xLLUIn
         GLehNzbOaXzv7Tqa7BEU2ITJ8hxiHoKBqpnffAdVzY2UY3bKM1JnHC6LoZL6PPXnPO8A
         9BfvZ3lVUP0tlQzKp/mfVebjc6oBcxKeBP/cMB200S5zwJvXOHd4o5fgt3BKM/cfdG6i
         mWWg==
X-Gm-Message-State: AO0yUKXl08Sl9mY15Y+fnpfOJ6djR7UhzLbUsiL4bd3WEmL2POACHPmX
        YBBooqGC7OXlCYos5ErDYj0IQ/MD7g==
X-Google-Smtp-Source: AK7set+sR8BGy70rkPlCi7+YiiY/OtXUKSyOcmJw2pOENpHzLDkwVJhu5FOH2OvOJCIEZO+CLLbo5g==
X-Received: by 2002:ad4:5bef:0:b0:56e:b7a7:40e7 with SMTP id k15-20020ad45bef000000b0056eb7a740e7mr22310066qvc.24.1677253360467;
        Fri, 24 Feb 2023 07:42:40 -0800 (PST)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id e26-20020a05620a015a00b0073b399700adsm1276131qkn.3.2023.02.24.07.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 07:42:39 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Usama Arif <usama.arif@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v2 1/5] x86/smpboot: Remove initial_stack on 64-bit
Date:   Fri, 24 Feb 2023 10:42:31 -0500
Message-Id: <20230224154235.277350-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224154235.277350-1-brgerst@gmail.com>
References: <20230224154235.277350-1-brgerst@gmail.com>
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
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Usama Arif <usama.arif@bytedance.com>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 arch/x86/include/asm/processor.h |  6 +++++-
 arch/x86/kernel/acpi/sleep.c     |  2 +-
 arch/x86/kernel/head_64.S        | 35 ++++++++++++++++++--------------
 arch/x86/xen/xen-head.S          |  2 +-
 4 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 8d73004e4cac..a1e4fa58b357 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -647,7 +647,11 @@ static inline void spin_lock_prefetch(const void *x)
 #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
 
 #else
-#define INIT_THREAD { }
+extern unsigned long __end_init_task[];
+
+#define INIT_THREAD {							    \
+	.sp	= (unsigned long)&__end_init_task - sizeof(struct pt_regs), \
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

