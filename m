Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A32A722F98
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjFETRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbjFETQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BADA7;
        Mon,  5 Jun 2023 12:16:23 -0700 (PDT)
Date:   Mon, 05 Jun 2023 19:16:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685992581;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uhzLkj49YJUuRG22jBOVFdrVFrIngllWs7LukgCiquo=;
        b=kgvE/2EOBrYEDRHP7LonBAIZK65ngOnxOB3eepYMTrkllw9H4XHh8fgRPMv77TbV/4GfnF
        v6qMGl/X/4FtWNX2PA7g1MkmJAc9Fcpdwfy55Ce5kWYJ2/e5exAyMJWsi07J1AikyiD0ma
        30JPn6TcoeWwUJZR+pXnazlfs12/AcH84u9LR3PgUD7o2lYwo1gOB2n5lgGRXeM7MlWq5F
        Mmg4uU7cKkxQcQTKd0EmJ1rFx6QNqThvtwd91HNRrYaOlnkmY//nJ8tmy9YA8ktyz/+dqk
        eF534TqtiGYRMUbH2uUmM3YmwK4Pexqc6FXRlkWq1JIFYUjGoo0fXMev7KjiCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685992581;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uhzLkj49YJUuRG22jBOVFdrVFrIngllWs7LukgCiquo=;
        b=ziVHrQCO95Yz/4pq/VeT1KwPnCfL/i3NgqQ14f4Ye8pYM9+sqtHT8KYjGTVIFXMX5jqnhj
        U2Sk8Tyt1djGp5BQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Unconditionally use full-fat wait_task_inactive()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168599258108.404.12910966685801669273.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d5e1586617be7093ea3419e3fa9387ed833cdbb1
Gitweb:        https://git.kernel.org/tip/d5e1586617be7093ea3419e3fa9387ed833cdbb1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 02 Jun 2023 10:42:53 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:11:02 +02:00

sched: Unconditionally use full-fat wait_task_inactive()

While modifying wait_task_inactive() for PREEMPT_RT; the build robot
noted that UP got broken. This led to audit and consideration of the
UP implementation of wait_task_inactive().

It looks like the UP implementation is also broken for PREEMPT;
consider task_current_syscall() getting preempted between the two
calls to wait_task_inactive().

Therefore move the wait_task_inactive() implementation out of
CONFIG_SMP and unconditionally use it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230602103731.GA630648%40hirez.programming.kicks-ass.net
---
 include/linux/sched.h |   7 +-
 kernel/sched/core.c   | 216 ++++++++++++++++++++---------------------
 2 files changed, 110 insertions(+), 113 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index eed5d65..1292d38 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2006,15 +2006,12 @@ static __always_inline void scheduler_ipi(void)
 	 */
 	preempt_fold_need_resched();
 }
-extern unsigned long wait_task_inactive(struct task_struct *, unsigned int match_state);
 #else
 static inline void scheduler_ipi(void) { }
-static inline unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state)
-{
-	return 1;
-}
 #endif
 
+extern unsigned long wait_task_inactive(struct task_struct *, unsigned int match_state);
+
 /*
  * Set thread flags in other task's structures.
  * See asm/thread_info.h for TIF_xxxx flags available:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 944c3ae..810cf7d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2213,6 +2213,114 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 		rq_clock_skip_update(rq);
 }
 
+/*
+ * wait_task_inactive - wait for a thread to unschedule.
+ *
+ * Wait for the thread to block in any of the states set in @match_state.
+ * If it changes, i.e. @p might have woken up, then return zero.  When we
+ * succeed in waiting for @p to be off its CPU, we return a positive number
+ * (its total switch count).  If a second call a short while later returns the
+ * same number, the caller can be sure that @p has remained unscheduled the
+ * whole time.
+ *
+ * The caller must ensure that the task *will* unschedule sometime soon,
+ * else this function might spin for a *long* time. This function can't
+ * be called with interrupts off, or it may introduce deadlock with
+ * smp_call_function() if an IPI is sent by the same process we are
+ * waiting to become inactive.
+ */
+unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state)
+{
+	int running, queued;
+	struct rq_flags rf;
+	unsigned long ncsw;
+	struct rq *rq;
+
+	for (;;) {
+		/*
+		 * We do the initial early heuristics without holding
+		 * any task-queue locks at all. We'll only try to get
+		 * the runqueue lock when things look like they will
+		 * work out!
+		 */
+		rq = task_rq(p);
+
+		/*
+		 * If the task is actively running on another CPU
+		 * still, just relax and busy-wait without holding
+		 * any locks.
+		 *
+		 * NOTE! Since we don't hold any locks, it's not
+		 * even sure that "rq" stays as the right runqueue!
+		 * But we don't care, since "task_on_cpu()" will
+		 * return false if the runqueue has changed and p
+		 * is actually now running somewhere else!
+		 */
+		while (task_on_cpu(rq, p)) {
+			if (!(READ_ONCE(p->__state) & match_state))
+				return 0;
+			cpu_relax();
+		}
+
+		/*
+		 * Ok, time to look more closely! We need the rq
+		 * lock now, to be *sure*. If we're wrong, we'll
+		 * just go back and repeat.
+		 */
+		rq = task_rq_lock(p, &rf);
+		trace_sched_wait_task(p);
+		running = task_on_cpu(rq, p);
+		queued = task_on_rq_queued(p);
+		ncsw = 0;
+		if (READ_ONCE(p->__state) & match_state)
+			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
+		task_rq_unlock(rq, p, &rf);
+
+		/*
+		 * If it changed from the expected state, bail out now.
+		 */
+		if (unlikely(!ncsw))
+			break;
+
+		/*
+		 * Was it really running after all now that we
+		 * checked with the proper locks actually held?
+		 *
+		 * Oops. Go back and try again..
+		 */
+		if (unlikely(running)) {
+			cpu_relax();
+			continue;
+		}
+
+		/*
+		 * It's not enough that it's not actively running,
+		 * it must be off the runqueue _entirely_, and not
+		 * preempted!
+		 *
+		 * So if it was still runnable (but just not actively
+		 * running right now), it's preempted, and we should
+		 * yield - it could be a while.
+		 */
+		if (unlikely(queued)) {
+			ktime_t to = NSEC_PER_SEC / HZ;
+
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_hrtimeout(&to, HRTIMER_MODE_REL_HARD);
+			continue;
+		}
+
+		/*
+		 * Ahh, all good. It wasn't running, and it wasn't
+		 * runnable, which means that it will never become
+		 * running in the future either. We're all done!
+		 */
+		break;
+	}
+
+	return ncsw;
+}
+
 #ifdef CONFIG_SMP
 
 static void
@@ -3341,114 +3449,6 @@ out:
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
-/*
- * wait_task_inactive - wait for a thread to unschedule.
- *
- * Wait for the thread to block in any of the states set in @match_state.
- * If it changes, i.e. @p might have woken up, then return zero.  When we
- * succeed in waiting for @p to be off its CPU, we return a positive number
- * (its total switch count).  If a second call a short while later returns the
- * same number, the caller can be sure that @p has remained unscheduled the
- * whole time.
- *
- * The caller must ensure that the task *will* unschedule sometime soon,
- * else this function might spin for a *long* time. This function can't
- * be called with interrupts off, or it may introduce deadlock with
- * smp_call_function() if an IPI is sent by the same process we are
- * waiting to become inactive.
- */
-unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state)
-{
-	int running, queued;
-	struct rq_flags rf;
-	unsigned long ncsw;
-	struct rq *rq;
-
-	for (;;) {
-		/*
-		 * We do the initial early heuristics without holding
-		 * any task-queue locks at all. We'll only try to get
-		 * the runqueue lock when things look like they will
-		 * work out!
-		 */
-		rq = task_rq(p);
-
-		/*
-		 * If the task is actively running on another CPU
-		 * still, just relax and busy-wait without holding
-		 * any locks.
-		 *
-		 * NOTE! Since we don't hold any locks, it's not
-		 * even sure that "rq" stays as the right runqueue!
-		 * But we don't care, since "task_on_cpu()" will
-		 * return false if the runqueue has changed and p
-		 * is actually now running somewhere else!
-		 */
-		while (task_on_cpu(rq, p)) {
-			if (!(READ_ONCE(p->__state) & match_state))
-				return 0;
-			cpu_relax();
-		}
-
-		/*
-		 * Ok, time to look more closely! We need the rq
-		 * lock now, to be *sure*. If we're wrong, we'll
-		 * just go back and repeat.
-		 */
-		rq = task_rq_lock(p, &rf);
-		trace_sched_wait_task(p);
-		running = task_on_cpu(rq, p);
-		queued = task_on_rq_queued(p);
-		ncsw = 0;
-		if (READ_ONCE(p->__state) & match_state)
-			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
-		task_rq_unlock(rq, p, &rf);
-
-		/*
-		 * If it changed from the expected state, bail out now.
-		 */
-		if (unlikely(!ncsw))
-			break;
-
-		/*
-		 * Was it really running after all now that we
-		 * checked with the proper locks actually held?
-		 *
-		 * Oops. Go back and try again..
-		 */
-		if (unlikely(running)) {
-			cpu_relax();
-			continue;
-		}
-
-		/*
-		 * It's not enough that it's not actively running,
-		 * it must be off the runqueue _entirely_, and not
-		 * preempted!
-		 *
-		 * So if it was still runnable (but just not actively
-		 * running right now), it's preempted, and we should
-		 * yield - it could be a while.
-		 */
-		if (unlikely(queued)) {
-			ktime_t to = NSEC_PER_SEC / HZ;
-
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_hrtimeout(&to, HRTIMER_MODE_REL_HARD);
-			continue;
-		}
-
-		/*
-		 * Ahh, all good. It wasn't running, and it wasn't
-		 * runnable, which means that it will never become
-		 * running in the future either. We're all done!
-		 */
-		break;
-	}
-
-	return ncsw;
-}
-
 /***
  * kick_process - kick a running thread to enter/exit the kernel
  * @p: the to-be-kicked thread
