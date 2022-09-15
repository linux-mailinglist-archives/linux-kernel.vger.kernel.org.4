Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EE05B99C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiIOLkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiIOLkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898BE422E4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=GP9RQ5R7xsKdkjMYemE/9mRCoebu4tK80lw9bb9cJCs=; b=LK4EKfYtkKPpnggPAvwPyhSnfN
        G74vExjiNB7mVcBJhW6SDABP2NwNyGAcjoMjkCg8+wiZL9y4Q1Y+O4f9Ofhx8A8ko9dmYeeZaA4dH
        1Jxz3Kdv/xMeSH+z83PrVuJCKxwHsC9cGHEP8mNyl0Bu4wfJ/DMtaSt02QzqWSDfzIPjVLjHxb/K6
        lBB8cBtrbztJYk+LJCeF3AFxIXmowO6xCfGsGSTfZlDm2vc7StD+FP6PQ/6mGOdGFhVK1otM3WqYQ
        24syf8XA2MBa10CTOuXyAur5vp+DjsLEz6bIaWchMqTedOM1XQyhXxqXlk1Ol6wyV8jBh7Q0U6ODp
        4fER/Nmw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDc-0012NG-VZ; Thu, 15 Sep 2022 11:39:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD596302A1D;
        Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5F2B529AADBFD; Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Message-ID: <20220915111145.179707194@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:11:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 22/59] x86: Put hot per CPU variables into a struct
References: <20220915111039.092790446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The layout of per-cpu variables is at the mercy of the compiler. This
can lead to random performance fluctuations from build to build.

Create a structure to hold some of the hottest per-cpu variables,
starting with current_task.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/current.h |   19 ++++++++++++++++---
 arch/x86/kernel/cpu/common.c   |   14 +++++---------
 arch/x86/kernel/process_32.c   |    2 +-
 arch/x86/kernel/process_64.c   |    2 +-
 arch/x86/kernel/smpboot.c      |    2 +-
 5 files changed, 24 insertions(+), 15 deletions(-)

--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -3,16 +3,29 @@
 #define _ASM_X86_CURRENT_H
 
 #include <linux/compiler.h>
-#include <asm/percpu.h>
 
 #ifndef __ASSEMBLY__
+
+#include <linux/cache.h>
+#include <asm/percpu.h>
+
 struct task_struct;
 
-DECLARE_PER_CPU(struct task_struct *, current_task);
+struct pcpu_hot {
+	union {
+		struct {
+			struct task_struct	*current_task;
+		};
+		u8	pad[64];
+	};
+};
+static_assert(sizeof(struct pcpu_hot) == 64);
+
+DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
 
 static __always_inline struct task_struct *get_current(void)
 {
-	return this_cpu_read_stable(current_task);
+	return this_cpu_read_stable(pcpu_hot.current_task);
 }
 
 #define current get_current()
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2000,18 +2000,16 @@ static __init int setup_clearcpuid(char
 }
 __setup("clearcpuid=", setup_clearcpuid);
 
+DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
+	.current_task	= &init_task,
+};
+EXPORT_PER_CPU_SYMBOL(pcpu_hot);
+
 #ifdef CONFIG_X86_64
 DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
 		     fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
 EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
 
-/*
- * The following percpu variables are hot.  Align current_task to
- * cacheline size such that they fall in the same cacheline.
- */
-DEFINE_PER_CPU(struct task_struct *, current_task) ____cacheline_aligned =
-	&init_task;
-EXPORT_PER_CPU_SYMBOL(current_task);
 
 DEFINE_PER_CPU(void *, hardirq_stack_ptr);
 DEFINE_PER_CPU(bool, hardirq_stack_inuse);
@@ -2071,8 +2069,6 @@ void syscall_init(void)
 
 #else	/* CONFIG_X86_64 */
 
-DEFINE_PER_CPU(struct task_struct *, current_task) = &init_task;
-EXPORT_PER_CPU_SYMBOL(current_task);
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -207,7 +207,7 @@ EXPORT_SYMBOL_GPL(start_thread);
 	if (prev->gs | next->gs)
 		loadsegment(gs, next->gs);
 
-	this_cpu_write(current_task, next_p);
+	raw_cpu_write(pcpu_hot.current_task, next_p);
 
 	switch_fpu_finish();
 
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -616,7 +616,7 @@ void compat_start_thread(struct pt_regs
 	/*
 	 * Switch the PDA and FPU contexts.
 	 */
-	this_cpu_write(current_task, next_p);
+	raw_cpu_write(pcpu_hot.current_task, next_p);
 	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
 
 	switch_fpu_finish();
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1046,7 +1046,7 @@ int common_cpu_up(unsigned int cpu, stru
 	/* Just in case we booted with a single CPU. */
 	alternatives_enable_smp();
 
-	per_cpu(current_task, cpu) = idle;
+	per_cpu(pcpu_hot.current_task, cpu) = idle;
 	cpu_init_stack_canary(cpu, idle);
 
 	/* Initialize the interrupt stack(s) */


