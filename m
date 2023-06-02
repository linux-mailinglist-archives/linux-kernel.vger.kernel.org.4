Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D62771FF83
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbjFBKit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbjFBKi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:38:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37990E41
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=huZfoHHG3cp4Nm17RjoMlhrTlqRkwWxH2aF6LllRQqU=; b=JTw7f0JezMgvZ5YXLW/XbYxsct
        HGX9HWYoDWdXOUga2zAkfkASQ1jumYYatsU8o1MKAqjnQLvPGWGMZEJyRGbCV0XyREtnX4zvU1d0n
        kqQZcMyDfV3UihcgYyTC8GwDPqOoSCfHvIf8NL7JF+taxBjGhNw078lFYXGG+/CD343n7RrBrfv5/
        j5fS/dYyUUnvGe6SPJo3jQcaUpziOSOULKY8WWTUQZQ27IRPXDJB6elpNQKH2bLTXPTaQU5Cmvok4
        SGSuzwOYM6CSJaigt8Lfobndt+e+uk9NorPKabf79OrtkRRJKr9IHwsNvYOhoAk3NHRfUrSCR56NW
        0Lw13XNA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q52A2-0098Sn-G7; Fri, 02 Jun 2023 10:37:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1A6943002F0;
        Fri,  2 Jun 2023 12:37:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E1869241F9E4E; Fri,  2 Jun 2023 12:37:31 +0200 (CEST)
Date:   Fri, 2 Jun 2023 12:37:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: Consider task_struct::saved_state in
 wait_task_inactive().
Message-ID: <20230602103731.GA630648@hirez.programming.kicks-ass.net>
References: <Y++UzubyNavLKFDP@linutronix.de>
 <20230525165244.GV83892@hirez.programming.kicks-ass.net>
 <20230526080543.GF38236@hirez.programming.kicks-ass.net>
 <20230526151335.oPeFiIdq@linutronix.de>
 <20230601091234.GW83892@hirez.programming.kicks-ass.net>
 <20230602082503.GA624418@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602082503.GA624418@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 10:25:03AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 01, 2023 at 11:12:34AM +0200, Peter Zijlstra wrote:
> > On Fri, May 26, 2023 at 05:13:35PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2023-05-26 10:05:43 [+0200], Peter Zijlstra wrote:
> > > > New day, new chances... How's this? Code-gen doesn't look totally
> > > > insane, but then, making sense of an optimizing compiler's output is
> > > > always a wee challenge.
> > > 
> > > Noticed it too late but looks good. Tested, works.
> > 
> > Excellent; full patch below. Will go stick in tip/sched/core soonish.
> 
> Urgh, so robot kicked me for breaking !SMP. And that made me realize
> that UP wait_task_inactive() is broken on PREEMPT_RT.
> 
> Let me figure out what best to do about that..

I'll stick this in front -- see what happens ;-)

---
Subject: sched: Unconditionally use full-fat wait_task_inactive()
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Jun  2 10:42:53 CEST 2023

While modifying wait_task_inactive() for PREEMPT_RT; the build robot
noted that UP got broken. This led to audit and consideration of the
UP implementation of wait_task_inactive().

It looks like the UP implementation is also broken for PREEMPT;
consider task_current_syscall() getting preempted between the two
calls to wait_task_inactive().

Therefore move the wait_task_inactive() implementation out of
CONFIG_SMP and unconditionally use it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |    7 -
 kernel/sched/core.c   |  216 +++++++++++++++++++++++++-------------------------
 2 files changed, 110 insertions(+), 113 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2006,15 +2006,12 @@ static __always_inline void scheduler_ip
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
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2213,6 +2213,114 @@ void check_preempt_curr(struct rq *rq, s
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
@@ -3341,114 +3449,6 @@ int migrate_swap(struct task_struct *cur
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
