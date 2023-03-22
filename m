Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0976C5999
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjCVWtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjCVWsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:48:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D8119B1;
        Wed, 22 Mar 2023 15:48:52 -0700 (PDT)
Date:   Wed, 22 Mar 2023 22:48:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679525331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ftSE4ACv1m+h8AgBdUt1/2/dGiUZrzhZ6vSaUI7qBk=;
        b=zdZj05sy7YW5ONe0bLYJW64P4fOwH6Tlr285zfXjn6aWxmr3YyGDTd7SpViIDUshkOAd3F
        v/RRE04VSWcdrCfITDNVpQ+K9n80BJGHaPOlmPxWT3rgldemu8AE+U3UX2bdfTGbmUhzDE
        Uy9ey5P5QPomlAX0NY5+1DmuLCB8b7uCC7pCqUqIQnYyvYG5g6YHRptxJQ0ZuKs3cpy3au
        DqwFaFF5q9KvhojNOsKC7y/BEA/gkrGsW0Jrfy0bWZxdCGVrPtaV58EpOxG6P3mmpm97Qa
        ysl8RX5Tuy/JxAqbUYa1JJ4LqHgWLMRwTZhewgN19EgxQ5f6z/QxvN7BvgMk2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679525331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ftSE4ACv1m+h8AgBdUt1/2/dGiUZrzhZ6vSaUI7qBk=;
        b=NF0uaVnL2F5XYfzw1mhC29Z7wEoFkaZSDpeHw+PEPmFokw5H3Bb2V1ui1MpJiDVZ43LEvT
        yPd0Sr4VAin1vFAA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] livepatch,sched: Add livepatch task switching to
 cond_resched()
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <4ae981466b7814ec221014fc2554b2f86f3fb70b.1677257135.git.jpoimboe@kernel.org>
References: <4ae981466b7814ec221014fc2554b2f86f3fb70b.1677257135.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167952533065.5837.1909032457634948334.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e3ff7c609f39671d1aaff4fb4a8594e14f3e03f8
Gitweb:        https://git.kernel.org/tip/e3ff7c609f39671d1aaff4fb4a8594e14f3e03f8
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 24 Feb 2023 08:50:00 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Mar 2023 17:09:28 +01:00

livepatch,sched: Add livepatch task switching to cond_resched()

There have been reports [1][2] of live patches failing to complete
within a reasonable amount of time due to CPU-bound kthreads.

Fix it by patching tasks in cond_resched().

There are four different flavors of cond_resched(), depending on the
kernel configuration.  Hook into all of them.

A more elegant solution might be to use a preempt notifier.  However,
non-ORC unwinders can't unwind a preempted task reliably.

[1] https://lore.kernel.org/lkml/20220507174628.2086373-1-song@kernel.org/
[2] https://lkml.kernel.org/lkml/20230120-vhost-klp-switching-v1-0-7c2b65519c43@kernel.org

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
Link: https://lore.kernel.org/r/4ae981466b7814ec221014fc2554b2f86f3fb70b.1677257135.git.jpoimboe@kernel.org
---
 include/linux/livepatch.h       |   1 +-
 include/linux/livepatch_sched.h |  29 ++++++++-
 include/linux/sched.h           |  20 ++++--
 kernel/livepatch/core.c         |   1 +-
 kernel/livepatch/transition.c   | 107 ++++++++++++++++++++++++++-----
 kernel/sched/core.c             |  64 ++++++++++++++++---
 6 files changed, 194 insertions(+), 28 deletions(-)
 create mode 100644 include/linux/livepatch_sched.h

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 293e299..9b9b38e 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -13,6 +13,7 @@
 #include <linux/ftrace.h>
 #include <linux/completion.h>
 #include <linux/list.h>
+#include <linux/livepatch_sched.h>
 
 #if IS_ENABLED(CONFIG_LIVEPATCH)
 
diff --git a/include/linux/livepatch_sched.h b/include/linux/livepatch_sched.h
new file mode 100644
index 0000000..013794f
--- /dev/null
+++ b/include/linux/livepatch_sched.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _LINUX_LIVEPATCH_SCHED_H_
+#define _LINUX_LIVEPATCH_SCHED_H_
+
+#include <linux/jump_label.h>
+#include <linux/static_call_types.h>
+
+#ifdef CONFIG_LIVEPATCH
+
+void __klp_sched_try_switch(void);
+
+#if !defined(CONFIG_PREEMPT_DYNAMIC) || !defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
+
+DECLARE_STATIC_KEY_FALSE(klp_sched_try_switch_key);
+
+static __always_inline void klp_sched_try_switch(void)
+{
+	if (static_branch_unlikely(&klp_sched_try_switch_key))
+		__klp_sched_try_switch();
+}
+
+#endif /* !CONFIG_PREEMPT_DYNAMIC || !CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
+
+#else /* !CONFIG_LIVEPATCH */
+static inline void klp_sched_try_switch(void) {}
+static inline void __klp_sched_try_switch(void) {}
+#endif /* CONFIG_LIVEPATCH */
+
+#endif /* _LINUX_LIVEPATCH_SCHED_H_ */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 63d2421..6d654eb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -36,6 +36,7 @@
 #include <linux/seqlock.h>
 #include <linux/kcsan.h>
 #include <linux/rv.h>
+#include <linux/livepatch_sched.h>
 #include <asm/kmap_size.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
@@ -2070,6 +2071,9 @@ extern int __cond_resched(void);
 
 #if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 
+void sched_dynamic_klp_enable(void);
+void sched_dynamic_klp_disable(void);
+
 DECLARE_STATIC_CALL(cond_resched, __cond_resched);
 
 static __always_inline int _cond_resched(void)
@@ -2078,6 +2082,7 @@ static __always_inline int _cond_resched(void)
 }
 
 #elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+
 extern int dynamic_cond_resched(void);
 
 static __always_inline int _cond_resched(void)
@@ -2085,20 +2090,25 @@ static __always_inline int _cond_resched(void)
 	return dynamic_cond_resched();
 }
 
-#else
+#else /* !CONFIG_PREEMPTION */
 
 static inline int _cond_resched(void)
 {
+	klp_sched_try_switch();
 	return __cond_resched();
 }
 
-#endif /* CONFIG_PREEMPT_DYNAMIC */
+#endif /* PREEMPT_DYNAMIC && CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
 
-#else
+#else /* CONFIG_PREEMPTION && !CONFIG_PREEMPT_DYNAMIC */
 
-static inline int _cond_resched(void) { return 0; }
+static inline int _cond_resched(void)
+{
+	klp_sched_try_switch();
+	return 0;
+}
 
-#endif /* !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC) */
+#endif /* !CONFIG_PREEMPTION || CONFIG_PREEMPT_DYNAMIC */
 
 #define cond_resched() ({			\
 	__might_resched(__FILE__, __LINE__, 0);	\
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 4bd2d5e..eea7c8e 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -33,6 +33,7 @@
  *
  * - klp_ftrace_handler()
  * - klp_update_patch_state()
+ * - __klp_sched_try_switch()
  */
 DEFINE_MUTEX(klp_mutex);
 
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 824e2e3..e9fd83a 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -9,6 +9,7 @@
 
 #include <linux/cpu.h>
 #include <linux/stacktrace.h>
+#include <linux/static_call.h>
 #include "core.h"
 #include "patch.h"
 #include "transition.h"
@@ -27,6 +28,25 @@ static int klp_target_state = KLP_UNDEFINED;
 static unsigned int klp_signals_cnt;
 
 /*
+ * When a livepatch is in progress, enable klp stack checking in
+ * cond_resched().  This helps CPU-bound kthreads get patched.
+ */
+#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
+
+#define klp_cond_resched_enable() sched_dynamic_klp_enable()
+#define klp_cond_resched_disable() sched_dynamic_klp_disable()
+
+#else /* !CONFIG_PREEMPT_DYNAMIC || !CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
+
+DEFINE_STATIC_KEY_FALSE(klp_sched_try_switch_key);
+EXPORT_SYMBOL(klp_sched_try_switch_key);
+
+#define klp_cond_resched_enable() static_branch_enable(&klp_sched_try_switch_key)
+#define klp_cond_resched_disable() static_branch_disable(&klp_sched_try_switch_key)
+
+#endif /* CONFIG_PREEMPT_DYNAMIC && CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
+
+/*
  * This work can be performed periodically to finish patching or unpatching any
  * "straggler" tasks which failed to transition in the first attempt.
  */
@@ -174,8 +194,8 @@ void klp_update_patch_state(struct task_struct *task)
 	 * barrier (smp_rmb) for two cases:
 	 *
 	 * 1) Enforce the order of the TIF_PATCH_PENDING read and the
-	 *    klp_target_state read.  The corresponding write barrier is in
-	 *    klp_init_transition().
+	 *    klp_target_state read.  The corresponding write barriers are in
+	 *    klp_init_transition() and klp_reverse_transition().
 	 *
 	 * 2) Enforce the order of the TIF_PATCH_PENDING read and a future read
 	 *    of func->transition, if klp_ftrace_handler() is called later on
@@ -343,6 +363,44 @@ static bool klp_try_switch_task(struct task_struct *task)
 	return !ret;
 }
 
+void __klp_sched_try_switch(void)
+{
+	if (likely(!klp_patch_pending(current)))
+		return;
+
+	/*
+	 * This function is called from cond_resched() which is called in many
+	 * places throughout the kernel.  Using the klp_mutex here might
+	 * deadlock.
+	 *
+	 * Instead, disable preemption to prevent racing with other callers of
+	 * klp_try_switch_task().  Thanks to task_call_func() they won't be
+	 * able to switch this task while it's running.
+	 */
+	preempt_disable();
+
+	/*
+	 * Make sure current didn't get patched between the above check and
+	 * preempt_disable().
+	 */
+	if (unlikely(!klp_patch_pending(current)))
+		goto out;
+
+	/*
+	 * Enforce the order of the TIF_PATCH_PENDING read above and the
+	 * klp_target_state read in klp_try_switch_task().  The corresponding
+	 * write barriers are in klp_init_transition() and
+	 * klp_reverse_transition().
+	 */
+	smp_rmb();
+
+	klp_try_switch_task(current);
+
+out:
+	preempt_enable();
+}
+EXPORT_SYMBOL(__klp_sched_try_switch);
+
 /*
  * Sends a fake signal to all non-kthread tasks with TIF_PATCH_PENDING set.
  * Kthreads with TIF_PATCH_PENDING set are woken up.
@@ -449,7 +507,8 @@ void klp_try_complete_transition(void)
 		return;
 	}
 
-	/* we're done, now cleanup the data structures */
+	/* Done!  Now cleanup the data structures. */
+	klp_cond_resched_disable();
 	patch = klp_transition_patch;
 	klp_complete_transition();
 
@@ -501,6 +560,8 @@ void klp_start_transition(void)
 			set_tsk_thread_flag(task, TIF_PATCH_PENDING);
 	}
 
+	klp_cond_resched_enable();
+
 	klp_signals_cnt = 0;
 }
 
@@ -556,8 +617,9 @@ void klp_init_transition(struct klp_patch *patch, int state)
 	 * see a func in transition with a task->patch_state of KLP_UNDEFINED.
 	 *
 	 * Also enforce the order of the klp_target_state write and future
-	 * TIF_PATCH_PENDING writes to ensure klp_update_patch_state() doesn't
-	 * set a task->patch_state to KLP_UNDEFINED.
+	 * TIF_PATCH_PENDING writes to ensure klp_update_patch_state() and
+	 * __klp_sched_try_switch() don't set a task->patch_state to
+	 * KLP_UNDEFINED.
 	 */
 	smp_wmb();
 
@@ -593,14 +655,10 @@ void klp_reverse_transition(void)
 		 klp_target_state == KLP_PATCHED ? "patching to unpatching" :
 						   "unpatching to patching");
 
-	klp_transition_patch->enabled = !klp_transition_patch->enabled;
-
-	klp_target_state = !klp_target_state;
-
 	/*
 	 * Clear all TIF_PATCH_PENDING flags to prevent races caused by
-	 * klp_update_patch_state() running in parallel with
-	 * klp_start_transition().
+	 * klp_update_patch_state() or __klp_sched_try_switch() running in
+	 * parallel with the reverse transition.
 	 */
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, task)
@@ -610,9 +668,28 @@ void klp_reverse_transition(void)
 	for_each_possible_cpu(cpu)
 		clear_tsk_thread_flag(idle_task(cpu), TIF_PATCH_PENDING);
 
-	/* Let any remaining calls to klp_update_patch_state() complete */
+	/*
+	 * Make sure all existing invocations of klp_update_patch_state() and
+	 * __klp_sched_try_switch() see the cleared TIF_PATCH_PENDING before
+	 * starting the reverse transition.
+	 */
 	klp_synchronize_transition();
 
+	/*
+	 * All patching has stopped, now re-initialize the global variables to
+	 * prepare for the reverse transition.
+	 */
+	klp_transition_patch->enabled = !klp_transition_patch->enabled;
+	klp_target_state = !klp_target_state;
+
+	/*
+	 * Enforce the order of the klp_target_state write and the
+	 * TIF_PATCH_PENDING writes in klp_start_transition() to ensure
+	 * klp_update_patch_state() and __klp_sched_try_switch() don't set
+	 * task->patch_state to the wrong value.
+	 */
+	smp_wmb();
+
 	klp_start_transition();
 }
 
@@ -626,9 +703,9 @@ void klp_copy_process(struct task_struct *child)
 	 * the task flag up to date with the parent here.
 	 *
 	 * The operation is serialized against all klp_*_transition()
-	 * operations by the tasklist_lock. The only exception is
-	 * klp_update_patch_state(current), but we cannot race with
-	 * that because we are current.
+	 * operations by the tasklist_lock. The only exceptions are
+	 * klp_update_patch_state(current) and __klp_sched_try_switch(), but we
+	 * cannot race with them because we are current.
 	 */
 	if (test_tsk_thread_flag(current, TIF_PATCH_PENDING))
 		set_tsk_thread_flag(child, TIF_PATCH_PENDING);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5ddd961..b9616f1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8525,6 +8525,7 @@ EXPORT_STATIC_CALL_TRAMP(might_resched);
 static DEFINE_STATIC_KEY_FALSE(sk_dynamic_cond_resched);
 int __sched dynamic_cond_resched(void)
 {
+	klp_sched_try_switch();
 	if (!static_branch_unlikely(&sk_dynamic_cond_resched))
 		return 0;
 	return __cond_resched();
@@ -8673,13 +8674,17 @@ int sched_dynamic_mode(const char *str)
 #error "Unsupported PREEMPT_DYNAMIC mechanism"
 #endif
 
-void sched_dynamic_update(int mode)
+DEFINE_MUTEX(sched_dynamic_mutex);
+static bool klp_override;
+
+static void __sched_dynamic_update(int mode)
 {
 	/*
 	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
 	 * the ZERO state, which is invalid.
 	 */
-	preempt_dynamic_enable(cond_resched);
+	if (!klp_override)
+		preempt_dynamic_enable(cond_resched);
 	preempt_dynamic_enable(might_resched);
 	preempt_dynamic_enable(preempt_schedule);
 	preempt_dynamic_enable(preempt_schedule_notrace);
@@ -8687,36 +8692,79 @@ void sched_dynamic_update(int mode)
 
 	switch (mode) {
 	case preempt_dynamic_none:
-		preempt_dynamic_enable(cond_resched);
+		if (!klp_override)
+			preempt_dynamic_enable(cond_resched);
 		preempt_dynamic_disable(might_resched);
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
-		pr_info("Dynamic Preempt: none\n");
+		if (mode != preempt_dynamic_mode)
+			pr_info("Dynamic Preempt: none\n");
 		break;
 
 	case preempt_dynamic_voluntary:
-		preempt_dynamic_enable(cond_resched);
+		if (!klp_override)
+			preempt_dynamic_enable(cond_resched);
 		preempt_dynamic_enable(might_resched);
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
-		pr_info("Dynamic Preempt: voluntary\n");
+		if (mode != preempt_dynamic_mode)
+			pr_info("Dynamic Preempt: voluntary\n");
 		break;
 
 	case preempt_dynamic_full:
-		preempt_dynamic_disable(cond_resched);
+		if (!klp_override)
+			preempt_dynamic_disable(cond_resched);
 		preempt_dynamic_disable(might_resched);
 		preempt_dynamic_enable(preempt_schedule);
 		preempt_dynamic_enable(preempt_schedule_notrace);
 		preempt_dynamic_enable(irqentry_exit_cond_resched);
-		pr_info("Dynamic Preempt: full\n");
+		if (mode != preempt_dynamic_mode)
+			pr_info("Dynamic Preempt: full\n");
 		break;
 	}
 
 	preempt_dynamic_mode = mode;
 }
 
+void sched_dynamic_update(int mode)
+{
+	mutex_lock(&sched_dynamic_mutex);
+	__sched_dynamic_update(mode);
+	mutex_unlock(&sched_dynamic_mutex);
+}
+
+#ifdef CONFIG_HAVE_PREEMPT_DYNAMIC_CALL
+
+static int klp_cond_resched(void)
+{
+	__klp_sched_try_switch();
+	return __cond_resched();
+}
+
+void sched_dynamic_klp_enable(void)
+{
+	mutex_lock(&sched_dynamic_mutex);
+
+	klp_override = true;
+	static_call_update(cond_resched, klp_cond_resched);
+
+	mutex_unlock(&sched_dynamic_mutex);
+}
+
+void sched_dynamic_klp_disable(void)
+{
+	mutex_lock(&sched_dynamic_mutex);
+
+	klp_override = false;
+	__sched_dynamic_update(preempt_dynamic_mode);
+
+	mutex_unlock(&sched_dynamic_mutex);
+}
+
+#endif /* CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
+
 static int __init setup_preempt_mode(char *str)
 {
 	int mode = sched_dynamic_mode(str);
