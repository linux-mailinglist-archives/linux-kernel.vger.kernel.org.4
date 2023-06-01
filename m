Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F211719683
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjFAJMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjFAJMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:12:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DB4E7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gkO+dl/AZRLZgWZ9qHEpZ9xFjgZWd7tx5jT/0Ia3DOo=; b=MZNgX7nW3EKm2F4fRiTR1OvzJP
        pYJ8I1tcmu1j7he4PWFn6CnB+d2hVTNKy4FWYGOBYaIKDYkp7i0ZsqvMI9L4IvD/LPZELP1hsf9Eq
        5eLj0t76HKoamCNgGTz8THKy8CwDxAJB22OItk38vmEZCv8523/AumHoA3kJc1pECkpYvyhI/cs2J
        q/kBAYtEwmB5B4CrWqcxJf0FGEvL1Y/XViC693ai7fBEzW5shenh8qAJZiCWEQRqSsBzcRXBQrFhg
        gQNRLmW/YHaXXiiQCGKY8qS/GLXtSJyhhdxxRB0ElMeZkhjRS8XiWnoKnXP1a2O/2p05a5GU6oiy4
        1dAd5Kqw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4eMG-008Cw6-Ke; Thu, 01 Jun 2023 09:12:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E26830031F;
        Thu,  1 Jun 2023 11:12:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67F4621AA6F85; Thu,  1 Jun 2023 11:12:34 +0200 (CEST)
Date:   Thu, 1 Jun 2023 11:12:34 +0200
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
Message-ID: <20230601091234.GW83892@hirez.programming.kicks-ass.net>
References: <Y++UzubyNavLKFDP@linutronix.de>
 <20230525165244.GV83892@hirez.programming.kicks-ass.net>
 <20230526080543.GF38236@hirez.programming.kicks-ass.net>
 <20230526151335.oPeFiIdq@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526151335.oPeFiIdq@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 05:13:35PM +0200, Sebastian Andrzej Siewior wrote:
> On 2023-05-26 10:05:43 [+0200], Peter Zijlstra wrote:
> > New day, new chances... How's this? Code-gen doesn't look totally
> > insane, but then, making sense of an optimizing compiler's output is
> > always a wee challenge.
> 
> Noticed it too late but looks good. Tested, works.

Excellent; full patch below. Will go stick in tip/sched/core soonish.

---
Subject: sched: Consider task_struct::saved_state in wait_task_inactive()
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed May 31 16:39:07 CEST 2023

With the introduction of task_struct::saved_state in commit
5f220be21418 ("sched/wakeup: Prepare for RT sleeping spin/rwlocks")
matching the task state has gotten more complicated. That same commit
changed try_to_wake_up() to consider both states, but
wait_task_inactive() has been neglected.

Sebastian noted that the wait_task_inactive() usage in
ptrace_check_attach() can misbehave when ptrace_stop() is blocked on
the tasklist_lock after it sets TASK_TRACED.

Therefore extract a common helper from ttwu_state_match() and use that
to teach wait_task_inactive() about the PREEMPT_RT locks.

Originally-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c |   59 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 11 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3341,6 +3341,39 @@ int migrate_swap(struct task_struct *cur
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
+static __always_inline
+int __task_state_match(struct task_struct *p, unsigned int state)
+{
+	if (READ_ONCE(p->__state) & state)
+		return 1;
+
+#ifdef CONFIG_PREEMPT_RT
+	if (READ_ONCE(p->saved_state) & state)
+		return -1;
+#endif
+	return 0;
+}
+
+static __always_inline
+int task_state_match(struct task_struct *p, unsigned int state)
+{
+#ifdef CONFIG_PREEMPT_RT
+	int match;
+
+	/*
+	 * Serialize against current_save_and_set_rtlock_wait_state() and
+	 * current_restore_rtlock_saved_state().
+	 */
+	raw_spin_lock_irq(&p->pi_lock);
+	match = __task_state_match(p, state);
+	raw_spin_unlock_irq(&p->pi_lock);
+
+	return match;
+#else
+	return __task_state_match(p, state);
+#endif
+}
+
 /*
  * wait_task_inactive - wait for a thread to unschedule.
  *
@@ -3359,7 +3392,7 @@ int migrate_swap(struct task_struct *cur
  */
 unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state)
 {
-	int running, queued;
+	int running, queued, match;
 	struct rq_flags rf;
 	unsigned long ncsw;
 	struct rq *rq;
@@ -3385,7 +3418,7 @@ unsigned long wait_task_inactive(struct
 		 * is actually now running somewhere else!
 		 */
 		while (task_on_cpu(rq, p)) {
-			if (!(READ_ONCE(p->__state) & match_state))
+			if (!task_state_match(p, match_state))
 				return 0;
 			cpu_relax();
 		}
@@ -3400,8 +3433,15 @@ unsigned long wait_task_inactive(struct
 		running = task_on_cpu(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
-		if (READ_ONCE(p->__state) & match_state)
+		if ((match = __task_state_match(p, match_state))) {
+			/*
+			 * When matching on p->saved_state, consider this task
+			 * still queued so it will wait.
+			 */
+			if (match < 0)
+				queued = 1;
 			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
+		}
 		task_rq_unlock(rq, p, &rf);
 
 		/*
@@ -4003,15 +4043,14 @@ static void ttwu_queue(struct task_struc
 static __always_inline
 bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 {
+	int match;
+
 	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT)) {
 		WARN_ON_ONCE((state & TASK_RTLOCK_WAIT) &&
 			     state != TASK_RTLOCK_WAIT);
 	}
 
-	if (READ_ONCE(p->__state) & state) {
-		*success = 1;
-		return true;
-	}
+	*success = !!(match = __task_state_match(p, state));
 
 #ifdef CONFIG_PREEMPT_RT
 	/*
@@ -4027,12 +4066,10 @@ bool ttwu_state_match(struct task_struct
 	 * p::saved_state to TASK_RUNNING so any further tests will
 	 * not result in false positives vs. @success
 	 */
-	if (p->saved_state & state) {
+	if (match < 0)
 		p->saved_state = TASK_RUNNING;
-		*success = 1;
-	}
 #endif
-	return false;
+	return match > 0;
 }
 
 /*
