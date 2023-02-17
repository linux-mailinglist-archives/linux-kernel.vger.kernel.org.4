Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC2869AE70
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjBQOxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjBQOxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:53:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB583B0D7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 06:53:15 -0800 (PST)
Date:   Fri, 17 Feb 2023 15:53:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676645593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=eBITpJvFAgJDlrvkIZ8qiH8cZafnQorRAJ90UsZZfh8=;
        b=DEAEl9roZus/CNCAm5+6poOLk9HQXmUVToZJmyysfvdx0XhtspkSxOZX0ReGtGqU/hxxAm
        MNyl7TgMNRZh8QjVd/ywNPw/nXxWT7iMQFEGQfdqVG4tVprovvtO0bEp6tBIiWr5dgRsw5
        pa17jLPT2TqU5npTsXmTQdhrUoVbGNaNlyZJ2m9tz2uKNFrjMlqmsj62ePTRQqv/ommd+I
        R7ZPLpzpREfztW3scv7VEsipGzU9X+LEBLOfUuyzkCEepkJFA5WAUeKHorwVckAUC475RX
        FlwFI88g9aEnX6GSObvFNwvLlHp+Ru0UCBuHnp7eI8nMLXfdfvYgtxUTBqv4FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676645593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=eBITpJvFAgJDlrvkIZ8qiH8cZafnQorRAJ90UsZZfh8=;
        b=8Kv/gmXsSjVXxQ9/NI0Wdr+MXMkGPlc67msI8eJuJ9o2FICMtJfX/otamCA+Edc6xotfRO
        /RRz0glgXysZWUCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched: Consider task_struct::saved_state in
 wait_task_inactive().
Message-ID: <Y++UzubyNavLKFDP@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_task_inactive() waits for thread to unschedule in a certain task state.
On PREEMPT_RT that state may be stored in task_struct::saved_state while the
thread, that is being waited for, blocks on a sleeping lock and
task_struct::__state is set to TASK_RTLOCK_WAIT.
It is not possible to check only for TASK_RTLOCK_WAIT to be sure that the task
is blocked on a sleeping lock because during wake up (after the sleeping lock
has been acquired) the task state is set TASK_RUNNING. After the task in on CPU
and acquired the pi_lock it will reset the state accordingly but until then
TASK_RUNNING will be observed (with the desired state is saved in saved_state).

Check also for task_struct::saved_state if the desired match was not found in
task_struct::__state on PREEMPT_RT. If the state was found in saved_state, wait
until the task is idle and state is visible in task_struct::__state.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
---
Repost of https://lore.kernel.org/Yt%2FpQAFQ1xKNK0RY@linutronix.de

 kernel/sched/core.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 5 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3266,6 +3266,76 @@ int migrate_swap(struct task_struct *cur
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
+#ifdef CONFIG_PREEMPT_RT
+
+/*
+ * Consider:
+ *
+ *  set_special_state(X);
+ *
+ *  do_things()
+ *    // Somewhere in there is an rtlock that can be contended:
+ *    current_save_and_set_rtlock_wait_state();
+ *    [...]
+ *    schedule_rtlock(); (A)
+ *    [...]
+ *    current_restore_rtlock_saved_state();
+ *
+ *  schedule(); (B)
+ *
+ * If p->saved_state is anything else than TASK_RUNNING, then p blocked on an
+ * rtlock (A) *before* voluntarily calling into schedule() (B) after setting its
+ * state to X. For things like ptrace (X=TASK_TRACED), the task could have more
+ * work to do upon acquiring the lock in do_things() before whoever called
+ * wait_task_inactive() should return. IOW, we have to wait for:
+ *
+ *   p.saved_state = TASK_RUNNING
+ *   p.__state     = X
+ *
+ * which implies the task isn't blocked on an RT lock and got to schedule() (B).
+ *
+ * Also see comments in ttwu_state_match().
+ */
+
+static __always_inline bool state_mismatch(struct task_struct *p, unsigned int match_state)
+{
+	unsigned long flags;
+	bool mismatch;
+
+	raw_spin_lock_irqsave(&p->pi_lock, flags);
+	if (READ_ONCE(p->__state) & match_state)
+		mismatch = false;
+	else if (READ_ONCE(p->saved_state) & match_state)
+		mismatch = false;
+	else
+		mismatch = true;
+
+	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+	return mismatch;
+}
+static __always_inline bool state_match(struct task_struct *p, unsigned int match_state,
+					bool *wait)
+{
+	if (READ_ONCE(p->__state) & match_state)
+		return true;
+	if (READ_ONCE(p->saved_state) & match_state) {
+		*wait = true;
+		return true;
+	}
+	return false;
+}
+#else
+static __always_inline bool state_mismatch(struct task_struct *p, unsigned int match_state)
+{
+	return !(READ_ONCE(p->__state) & match_state);
+}
+static __always_inline bool state_match(struct task_struct *p, unsigned int match_state,
+					bool *wait)
+{
+	return (READ_ONCE(p->__state) & match_state);
+}
+#endif
+
 /*
  * wait_task_inactive - wait for a thread to unschedule.
  *
@@ -3284,7 +3354,7 @@ int migrate_swap(struct task_struct *cur
  */
 unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state)
 {
-	int running, queued;
+	bool running, wait;
 	struct rq_flags rf;
 	unsigned long ncsw;
 	struct rq *rq;
@@ -3310,7 +3380,7 @@ unsigned long wait_task_inactive(struct
 		 * is actually now running somewhere else!
 		 */
 		while (task_on_cpu(rq, p)) {
-			if (!(READ_ONCE(p->__state) & match_state))
+			if (state_mismatch(p, match_state))
 				return 0;
 			cpu_relax();
 		}
@@ -3323,9 +3393,10 @@ unsigned long wait_task_inactive(struct
 		rq = task_rq_lock(p, &rf);
 		trace_sched_wait_task(p);
 		running = task_on_cpu(rq, p);
-		queued = task_on_rq_queued(p);
+		wait = task_on_rq_queued(p);
 		ncsw = 0;
-		if (READ_ONCE(p->__state) & match_state)
+
+		if (state_match(p, match_state, &wait))
 			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
 		task_rq_unlock(rq, p, &rf);
 
@@ -3355,7 +3426,7 @@ unsigned long wait_task_inactive(struct
 		 * running right now), it's preempted, and we should
 		 * yield - it could be a while.
 		 */
-		if (unlikely(queued)) {
+		if (unlikely(wait)) {
 			ktime_t to = NSEC_PER_SEC / HZ;
 
 			set_current_state(TASK_UNINTERRUPTIBLE);
