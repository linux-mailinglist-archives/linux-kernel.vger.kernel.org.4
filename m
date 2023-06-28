Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC244741C16
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 01:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjF1XA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 19:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjF1XA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:00:26 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703379F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:00:25 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1b00b0ab0daso69528fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687993224; x=1690585224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vap9ObRGKKthG6hrVHvlAX1DOFBnrRGZlJowcTyVXG0=;
        b=qarjeECAX0plaOmUJA+QFapscYWPU8QwikjKi8VpqnySU01CcTtdQOLgtgD96D6cwS
         pZekHdjYMpUSfO4vhlvPOsfaoCJheAO0uRnAhPfmTclZeK+C92qbYPvuneVD2s7tgCZ/
         XOicFXujE2e06WfJTpUZWsyjZKtX4jva/eUzQR2tnLV6UrDgVaBe8YTxmQx7r5CrrdJR
         ZwzPCFz4ji4HcUpRIuCbNtUlTRVWBj3w2FMOJmZ05NZ0m04ZPDK+zjz9UNRNP7C3mPmH
         5t1cCGYsxbYg5jJO0PPHAQJOLf7t08awenvE7/yGyzcbdNC8s/JJ1/imikMMApHqkHvi
         bMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687993224; x=1690585224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vap9ObRGKKthG6hrVHvlAX1DOFBnrRGZlJowcTyVXG0=;
        b=TVx8AImvZlgSHkWBTRPx4uUrgbkEmevHsyIwut3jMhZex1f2k8pdtFfoCZCbDVaS7b
         3c96WK3Y0YCUfFMsv85EDfIX/oNItu2aWrpddsn+FZc1/2WeQ8O1mtyvKv3hriWJXuIt
         GldRu/qeR61hL9xo/frbTqHPGLYninqpp0jd4oLIbztTE8DobLDI4obVbkGRPHBVpjie
         Ep2BGKJ8HRfOI82nedBAf48YTTjLnqkRUNafjWf9vocN38T3Ka28+lIiSmI65hAKzenF
         EMrf2iE5iFqRin2mCu45nv4Xx31juxV3dZZ5UPeqeY1RjmghOcxcCR3DTC0w+v7CCg2o
         d72Q==
X-Gm-Message-State: AC+VfDxz/PgS8f+xhL1p2DUlRb8843qUIQNxUXUfslT1xinFobcCw1Hp
        juS/LJxE1uQmpklGGmNDbBFhS81WFA==
X-Google-Smtp-Source: ACHHUZ7/VPxqIV/+k5pjTff0m/aZJKLmqduuc8GgySskqpbGSePtYE4DdKR3mde/UyokjdVheKNh9A==
X-Received: by 2002:a05:6870:988c:b0:1b0:1087:4475 with SMTP id eg12-20020a056870988c00b001b010874475mr9640390oab.26.1687993223856;
        Wed, 28 Jun 2023 16:00:23 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id cm9-20020a056870b60900b0019f188355a8sm6956331oab.17.2023.06.28.16.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 16:00:22 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH] x86/32: Use a thread flag to track SYSENTER status
Date:   Wed, 28 Jun 2023 19:00:15 -0400
Message-ID: <20230628230015.105355-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a task is in VM86 mode, the SYSENTER instruction must be disabled
to prevent kernel stack corruption.  Use a thread flag to track when a
task needs SYSENTER disabled instead of abusing the ss1 field of the
TSS.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/processor.h   | 26 ++------------------------
 arch/x86/include/asm/switch_to.h   | 12 ------------
 arch/x86/include/asm/thread_info.h |  5 ++++-
 arch/x86/include/asm/vm86.h        |  8 ++++++++
 arch/x86/kernel/cpu/common.c       | 10 +---------
 arch/x86/kernel/process.c          |  4 +++-
 arch/x86/kernel/process_32.c       |  1 -
 arch/x86/kernel/vm86_32.c          |  8 ++++----
 8 files changed, 22 insertions(+), 52 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index b216ac80ebcc..96a5e3e5bb7b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -226,23 +226,7 @@ struct x86_hw_tss {
 	unsigned long		sp0;
 	unsigned short		ss0, __ss0h;
 	unsigned long		sp1;
-
-	/*
-	 * We don't use ring 1, so ss1 is a convenient scratch space in
-	 * the same cacheline as sp0.  We use ss1 to cache the value in
-	 * MSR_IA32_SYSENTER_CS.  When we context switch
-	 * MSR_IA32_SYSENTER_CS, we first check if the new value being
-	 * written matches ss1, and, if it's not, then we wrmsr the new
-	 * value and update ss1.
-	 *
-	 * The only reason we context switch MSR_IA32_SYSENTER_CS is
-	 * that we set it to zero in vm86 tasks to avoid corrupting the
-	 * stack if we were to go through the sysenter path from vm86
-	 * mode.
-	 */
-	unsigned short		ss1;	/* MSR_IA32_SYSENTER_CS */
-
-	unsigned short		__ss1h;
+	unsigned short		ss1, __ss1h;
 	unsigned long		sp2;
 	unsigned short		ss2, __ss2h;
 	unsigned long		__cr3;
@@ -419,16 +403,11 @@ struct thread_struct {
 	unsigned long		sp0;
 #endif
 	unsigned long		sp;
-#ifdef CONFIG_X86_32
-	unsigned long		sysenter_cs;
-#else
+#ifdef CONFIG_X86_64
 	unsigned short		es;
 	unsigned short		ds;
 	unsigned short		fsindex;
 	unsigned short		gsindex;
-#endif
-
-#ifdef CONFIG_X86_64
 	unsigned long		fsbase;
 	unsigned long		gsbase;
 #else
@@ -648,7 +627,6 @@ static inline void spin_lock_prefetch(const void *x)
 #ifdef CONFIG_X86_32
 #define INIT_THREAD  {							  \
 	.sp0			= TOP_OF_INIT_STACK,			  \
-	.sysenter_cs		= __KERNEL_CS,				  \
 }
 
 #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index 5c91305d09d2..53d34c6fb581 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -49,18 +49,6 @@ do {									\
 	((last) = __switch_to_asm((prev), (next)));			\
 } while (0)
 
-#ifdef CONFIG_X86_32
-static inline void refresh_sysenter_cs(struct thread_struct *thread)
-{
-	/* Only happens when SEP is enabled, no need to test "SEP"arately: */
-	if (unlikely(this_cpu_read(cpu_tss_rw.x86_tss.ss1) == thread->sysenter_cs))
-		return;
-
-	this_cpu_write(cpu_tss_rw.x86_tss.ss1, thread->sysenter_cs);
-	wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
-}
-#endif
-
 /* This is used when switching tasks or entering/exiting vm86 mode. */
 static inline void update_task_stack(struct task_struct *task)
 {
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index f1cccba52eb9..7f7332290ee1 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -78,6 +78,7 @@ struct thread_info {
  * - these are process state flags that various assembly files
  *   may need to access
  */
+#define TIF_DISABLE_SYSENTER	0	/* disable SYSENTER for VM86 mode */
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
@@ -101,6 +102,7 @@ struct thread_info {
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
 
+#define _TIF_DISABLE_SYSENTER	(1 << TIF_DISABLE_SYSENTER)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
@@ -126,7 +128,8 @@ struct thread_info {
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
 	(_TIF_NOCPUID | _TIF_NOTSC | _TIF_BLOCKSTEP |		\
-	 _TIF_SSBD | _TIF_SPEC_FORCE_UPDATE)
+	 _TIF_SSBD | _TIF_SPEC_FORCE_UPDATE | 			\
+	 _TIF_DISABLE_SYSENTER)
 
 /*
  * Avoid calls to __switch_to_xtra() on UP as STIBP is not evaluated.
diff --git a/arch/x86/include/asm/vm86.h b/arch/x86/include/asm/vm86.h
index 9e8ac5073ecb..9e3cdbfe6e45 100644
--- a/arch/x86/include/asm/vm86.h
+++ b/arch/x86/include/asm/vm86.h
@@ -72,6 +72,12 @@ static inline int invalid_vm86_irq(int irq)
 
 void release_vm86_irqs(struct task_struct *);
 
+static inline void refresh_sysenter_cs(bool disable_sysenter)
+{
+	/* Only happens when SEP is enabled, no need to test "SEP"arately: */
+	wrmsr(MSR_IA32_SYSENTER_CS, disable_sysenter ? 0 : __KERNEL_CS , 0);
+}
+
 #else
 
 #define handle_vm86_fault(a, b)
@@ -86,6 +92,8 @@ static inline void save_v86_state(struct kernel_vm86_regs *a, int b) { }
 
 #define free_vm86(t) do { } while(0)
 
+static inline void refresh_sysenter_cs(bool disable_sysenter) { }
+
 #endif /* CONFIG_VM86 */
 
 #endif /* _ASM_X86_VM86_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index cf5275a67f39..aaf636e4d1de 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1933,22 +1933,14 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_32
 void enable_sep_cpu(void)
 {
-	struct tss_struct *tss;
 	int cpu;
 
 	if (!boot_cpu_has(X86_FEATURE_SEP))
 		return;
 
 	cpu = get_cpu();
-	tss = &per_cpu(cpu_tss_rw, cpu);
 
-	/*
-	 * We cache MSR_IA32_SYSENTER_CS's value in the TSS's ss1 field --
-	 * see the big comment in struct x86_hw_tss's definition.
-	 */
-
-	tss->x86_tss.ss1 = __KERNEL_CS;
-	wrmsr(MSR_IA32_SYSENTER_CS, tss->x86_tss.ss1, 0);
+	wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
 	wrmsr(MSR_IA32_SYSENTER_ESP, (unsigned long)(cpu_entry_stack(cpu) + 1), 0);
 	wrmsr(MSR_IA32_SYSENTER_EIP, (unsigned long)entry_SYSENTER_32, 0);
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index cc7a642f8c9d..cd2c483b91c1 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -75,7 +75,6 @@ __visible DEFINE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw) = {
 		.sp1 = TOP_OF_INIT_STACK,
 
 		.ss0 = __KERNEL_DS,
-		.ss1 = __KERNEL_CS,
 #endif
 		.io_bitmap_base	= IO_BITMAP_OFFSET_INVALID,
 	 },
@@ -713,6 +712,9 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 		/* Enforce MSR update to ensure consistent state */
 		__speculation_ctrl_update(~tifn, tifn);
 	}
+
+	if (unlikely((tifp ^ tifn) & _TIF_DISABLE_SYSENTER))
+		refresh_sysenter_cs((tifn & _TIF_DISABLE_SYSENTER) != 0);
 }
 
 /*
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 708c87b88cc1..c609faa3e50e 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -196,7 +196,6 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	 * case prev or next is vm86.
 	 */
 	update_task_stack(next_p);
-	refresh_sysenter_cs(next);
 	this_cpu_write(pcpu_hot.top_of_stack,
 		       (unsigned long)task_stack_page(next_p) +
 		       THREAD_SIZE);
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index e9e803a4d44c..9d25793ba999 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -143,10 +143,10 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
 exit_vm86:
 	preempt_disable();
 	tsk->thread.sp0 = vm86->saved_sp0;
-	tsk->thread.sysenter_cs = __KERNEL_CS;
 	update_task_stack(tsk);
-	refresh_sysenter_cs(&tsk->thread);
 	vm86->saved_sp0 = 0;
+	if (test_and_clear_thread_flag(TIF_DISABLE_SYSENTER))
+		refresh_sysenter_cs(false);
 	preempt_enable();
 
 	memcpy(&regs->pt, &vm86->regs32, sizeof(struct pt_regs));
@@ -332,8 +332,8 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 	tsk->thread.sp0 += 16;
 
 	if (boot_cpu_has(X86_FEATURE_SEP)) {
-		tsk->thread.sysenter_cs = 0;
-		refresh_sysenter_cs(&tsk->thread);
+		set_thread_flag(TIF_DISABLE_SYSENTER);
+		refresh_sysenter_cs(true);
 	}
 
 	update_task_stack(tsk);
-- 
2.41.0

