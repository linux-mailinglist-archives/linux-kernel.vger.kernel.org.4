Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC806011F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiJQO5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiJQOzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:55:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF26C60E3;
        Mon, 17 Oct 2022 07:54:23 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018451;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VHt6WIN5l1+g9uNKnG5U8VqdETtJwp7QIi+CwkiAhUU=;
        b=koW6SmRLSpsI0rpqcOZ8kT91ZZxgUP+Pk1mLbVZLv8/2GrpAfgZRPdS8Yen4IWjRPrURDj
        KjFo62D+qrYk0f8EDV3oKrlrKF6RawZjVbyqNapXvkWTzWfhhEsBDsAVQP0ixHNnxOixtj
        1hPuUQYHm3sPNdpzog5j9+cN3H4qnLP15NVKtTKRSTM9uXnRXNnBuDQ3bvZXD4j52vu9m7
        8O9UkqwcnXggfANhMYUtsWoPz/NVy2u4QTTkACsImxp1czk0JFxok3SiW/dwuwqVGb8uPu
        K+wpeyHywD3zfzrXD/mXb5/1Yf+E9PY2JdQOhoe9YTvQDGlOLh3TMwTHWm8dfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018451;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VHt6WIN5l1+g9uNKnG5U8VqdETtJwp7QIi+CwkiAhUU=;
        b=tvSJnXogiVTZ2TQ3cClIXP6CrER7q2D9EMARcP+OZo2w/NXsKOPa61NDIHdAMTFQJmDeCY
        8lEf3WpK3xh2idCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Put hot per CPU variables into a struct
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111145.179707194@infradead.org>
References: <20220915111145.179707194@infradead.org>
MIME-Version: 1.0
Message-ID: <166601844974.401.6529951474144185456.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     e57ef2ed97c1d078973298658a8096644a1e9e09
Gitweb:        https://git.kernel.org/tip/e57ef2ed97c1d078973298658a8096644a1e9e09
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:03 +02:00

x86: Put hot per CPU variables into a struct

The layout of per-cpu variables is at the mercy of the compiler. This
can lead to random performance fluctuations from build to build.

Create a structure to hold some of the hottest per-cpu variables,
starting with current_task.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111145.179707194@infradead.org
---
 arch/x86/include/asm/current.h | 19 ++++++++++++++++---
 arch/x86/kernel/cpu/common.c   | 14 +++++---------
 arch/x86/kernel/process_32.c   |  2 +-
 arch/x86/kernel/process_64.c   |  2 +-
 arch/x86/kernel/smpboot.c      |  2 +-
 5 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 3e204e6..63c42ac 100644
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
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8e87318..5207153 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2012,18 +2012,16 @@ static __init int setup_clearcpuid(char *arg)
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
@@ -2083,8 +2081,6 @@ void syscall_init(void)
 
 #else	/* CONFIG_X86_64 */
 
-DEFINE_PER_CPU(struct task_struct *, current_task) = &init_task;
-EXPORT_PER_CPU_SYMBOL(current_task);
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 2f314b1..807da45 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -207,7 +207,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	if (prev->gs | next->gs)
 		loadsegment(gs, next->gs);
 
-	this_cpu_write(current_task, next_p);
+	raw_cpu_write(pcpu_hot.current_task, next_p);
 
 	switch_fpu_finish();
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 6b3418b..c4f6cac 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -617,7 +617,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/*
 	 * Switch the PDA and FPU contexts.
 	 */
-	this_cpu_write(current_task, next_p);
+	raw_cpu_write(pcpu_hot.current_task, next_p);
 	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
 
 	switch_fpu_finish();
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ce8728d..05f3157 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1046,7 +1046,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 	/* Just in case we booted with a single CPU. */
 	alternatives_enable_smp();
 
-	per_cpu(current_task, cpu) = idle;
+	per_cpu(pcpu_hot.current_task, cpu) = idle;
 	cpu_init_stack_canary(cpu, idle);
 
 	/* Initialize the interrupt stack(s) */
