Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2776C33D6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjCUOOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjCUOOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:14:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90A5CDCE;
        Tue, 21 Mar 2023 07:14:17 -0700 (PDT)
Date:   Tue, 21 Mar 2023 14:14:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679408056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDFBuL+ArkZbpEX4EMClKwVJX664IbD0077HPC9cuhM=;
        b=P7IUTjb85pl6CiODtSR8vcyDL5TcMgE7rzzjPTEFN4TToz1IuCLIn5cy91Y9h4zoh5IaFF
        Lyp9qgrVqQYYteZ2n3u3SU4C/NLEWJp/iCFOuAPe+FDABotB3sHlfLVYW3IEVZw6HPZv+e
        FfoCZzz+kvWw4/8OcHX79rlDPreafStupiuol7Mr/LktECRcXVjgYZE/uV0dK2hPy2ut9a
        nn3wlvNq7Mg6CvyO0nAXysg4kRww0lqfKdJzBG1VvqF+Kj6FulPXBsagb1bSNuMPwYLAzk
        vYu4uUfW6df955nq2lB+QyDWIXh8eCIZQreguf2I58zUjpPOemeS/WWbl9vLAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679408056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDFBuL+ArkZbpEX4EMClKwVJX664IbD0077HPC9cuhM=;
        b=lpRgimnQRy+hrErkIocyGEn/ylU/9Km9fdwxpWv0akI+IGy5vmarklo2LlZItbRyQpbGKd
        MxyeBes13juUhRBw==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/smpboot: Remove initial_stack on 64-bit
Cc:     Brian Gerst <brgerst@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230316222109.1940300-7-usama.arif@bytedance.com>
References: <20230316222109.1940300-7-usama.arif@bytedance.com>
MIME-Version: 1.0
Message-ID: <167940805609.5837.18322982901845059576.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     3adee777ad0d328e76ca9015cb7924134a992e81
Gitweb:        https://git.kernel.org/tip/3adee777ad0d328e76ca9015cb7924134a992e81
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 16 Mar 2023 22:21:03 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 21 Mar 2023 13:35:53 +01:00

x86/smpboot: Remove initial_stack on 64-bit

In order to facilitate parallel startup, start to eliminate some of the
global variables passing information to CPUs in the startup path.

However, start by introducing one more: smpboot_control. For now this
merely holds the CPU# of the CPU which is coming up. Each CPU can then
find its own per-cpu data, and everything else it needs can be found
from there, allowing the other global variables to be removed.

First to be removed is initial_stack. Each CPU can load %rsp from its
current_task->thread.sp instead. That is already set up with the correct
idle thread for APs. Set up the .sp field in INIT_THREAD on x86 so that
the BSP also finds a suitable stack pointer in the static per-cpu data
when coming up on first boot.

On resume from S3, the CPU needs a temporary stack because its idle task
is already active. Instead of setting initial_stack, the sleep code can
simply set its own current->thread.sp to point to the temporary stack.
Nobody else cares about ->thread.sp for a thread which is currently on
a CPU, because the true value is actually in the %rsp register. Which
is restored with the rest of the CPU context in do_suspend_lowlevel().

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Usama Arif <usama.arif@bytedance.com>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lore.kernel.org/r/20230316222109.1940300-7-usama.arif@bytedance.com

---
 arch/x86/include/asm/processor.h |  6 +++-
 arch/x86/include/asm/smp.h       |  5 +++-
 arch/x86/kernel/acpi/sleep.c     | 20 ++++++++++++--
 arch/x86/kernel/asm-offsets.c    |  1 +-
 arch/x86/kernel/head_64.S        | 43 ++++++++++++++++++++-----------
 arch/x86/kernel/smpboot.c        |  7 ++++-
 arch/x86/xen/xen-head.S          |  2 +-
 7 files changed, 63 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 8d73004..a1e4fa5 100644
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
 
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index b4dbb20..bf2c51d 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -199,5 +199,8 @@ extern void nmi_selftest(void);
 #define nmi_selftest() do { } while (0)
 #endif
 
-#endif /* __ASSEMBLY__ */
+extern unsigned int smpboot_control;
+
+#endif /* !__ASSEMBLY__ */
+
 #endif /* _ASM_X86_SMP_H */
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 3b7f4cd..1b4c43d 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -111,13 +111,29 @@ int x86_acpi_suspend_lowlevel(void)
 	saved_magic = 0x12345678;
 #else /* CONFIG_64BIT */
 #ifdef CONFIG_SMP
-	initial_stack = (unsigned long)temp_stack + sizeof(temp_stack);
+	/*
+	 * As each CPU starts up, it will find its own stack pointer
+	 * from its current_task->thread.sp. Typically that will be
+	 * the idle thread for a newly-started AP, or even the boot
+	 * CPU which will find it set to &init_task in the static
+	 * per-cpu data.
+	 *
+	 * Make the resuming CPU use the temporary stack at startup
+	 * by setting current->thread.sp to point to that. The true
+	 * %rsp will be restored with the rest of the CPU context,
+	 * by do_suspend_lowlevel(). And unwinders don't care about
+	 * the abuse of ->thread.sp because it's a dead variable
+	 * while the thread is running on the CPU anyway; the true
+	 * value is in the actual %rsp register.
+	 */
+	current->thread.sp = (unsigned long)temp_stack + sizeof(temp_stack);
 	early_gdt_descr.address =
 			(unsigned long)get_cpu_gdt_rw(smp_processor_id());
 	initial_gs = per_cpu_offset(smp_processor_id());
+	smpboot_control = smp_processor_id();
 #endif
 	initial_code = (unsigned long)wakeup_long64;
-       saved_magic = 0x123456789abcdef0L;
+	saved_magic = 0x123456789abcdef0L;
 #endif /* CONFIG_64BIT */
 
 	/*
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 283dcd2..dc35763 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -115,6 +115,7 @@ static void __used common(void)
 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
 	OFFSET(X86_top_of_stack, pcpu_hot, top_of_stack);
+	OFFSET(X86_current_task, pcpu_hot, current_task);
 #ifdef CONFIG_CALL_DEPTH_TRACKING
 	OFFSET(X86_call_depth, pcpu_hot, call_depth);
 #endif
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 222efd4..cc1b145 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -61,8 +61,8 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * tables and then reload them.
 	 */
 
-	/* Set up the stack for verify_cpu(), similar to initial_stack below */
-	leaq	(__end_init_task - FRAME_SIZE)(%rip), %rsp
+	/* Set up the stack for verify_cpu() */
+	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
 
 	leaq	_text(%rip), %rdi
 
@@ -241,6 +241,24 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	UNWIND_HINT_EMPTY
 	ANNOTATE_NOENDBR // above
 
+#ifdef CONFIG_SMP
+	movl	smpboot_control(%rip), %ecx
+
+	/* Get the per cpu offset for the given CPU# which is in ECX */
+	movq	__per_cpu_offset(,%rcx,8), %rdx
+#else
+	xorl	%edx, %edx /* zero-extended to clear all of RDX */
+#endif /* CONFIG_SMP */
+
+	/*
+	 * Setup a boot time stack - Any secondary CPU will have lost its stack
+	 * by now because the cr3-switch above unmaps the real-mode stack.
+	 *
+	 * RDX contains the per-cpu offset
+	 */
+	movq	pcpu_hot + X86_current_task(%rdx), %rax
+	movq	TASK_threadsp(%rax), %rsp
+
 	/*
 	 * We must switch to a new descriptor in kernel space for the GDT
 	 * because soon the kernel won't have access anymore to the userspace
@@ -275,12 +293,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movl	initial_gs+4(%rip),%edx
 	wrmsr
 
-	/*
-	 * Setup a boot time stack - Any secondary CPU will have lost its stack
-	 * by now because the cr3-switch above unmaps the real-mode stack
-	 */
-	movq initial_stack(%rip), %rsp
-
 	/* Setup and Load IDT */
 	pushq	%rsi
 	call	early_setup_idt
@@ -372,7 +384,11 @@ SYM_CODE_END(secondary_startup_64)
 SYM_CODE_START(start_cpu0)
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_EMPTY
-	movq	initial_stack(%rip), %rsp
+
+	/* Find the idle task stack */
+	movq	PER_CPU_VAR(pcpu_hot) + X86_current_task, %rcx
+	movq	TASK_threadsp(%rcx), %rsp
+
 	jmp	.Ljump_to_C_code
 SYM_CODE_END(start_cpu0)
 #endif
@@ -420,12 +436,6 @@ SYM_DATA(initial_gs,	.quad INIT_PER_CPU_VAR(fixed_percpu_data))
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
 #endif
-
-/*
- * The FRAME_SIZE gap is a convention which helps the in-kernel unwinder
- * reliably detect the end of the stack.
- */
-SYM_DATA(initial_stack, .quad init_thread_union + THREAD_SIZE - FRAME_SIZE)
 	__FINITDATA
 
 	__INIT
@@ -661,6 +671,9 @@ SYM_DATA(early_gdt_descr,		.word GDT_ENTRIES*8-1)
 SYM_DATA_LOCAL(early_gdt_descr_base,	.quad INIT_PER_CPU_VAR(gdt_page))
 
 	.align 16
+SYM_DATA(smpboot_control,		.long 0)
+
+	.align 16
 /* This must match the first entry in level2_kernel_pgt */
 SYM_DATA(phys_base, .quad 0x0)
 EXPORT_SYMBOL(phys_base)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 9013bb2..a1531cc 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1088,7 +1088,12 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 	idle->thread.sp = (unsigned long)task_pt_regs(idle);
 	early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
 	initial_code = (unsigned long)start_secondary;
-	initial_stack  = idle->thread.sp;
+
+	if (IS_ENABLED(CONFIG_X86_32)) {
+		initial_stack  = idle->thread.sp;
+	} else {
+		smpboot_control = cpu;
+	}
 
 	/* Enable the espfix hack for this CPU */
 	init_espfix_ap(cpu);
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index e36ea42..91f7a53 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -49,7 +49,7 @@ SYM_CODE_START(startup_xen)
 	ANNOTATE_NOENDBR
 	cld
 
-	mov initial_stack(%rip), %rsp
+	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
 
 	/* Set up %gs.
 	 *
