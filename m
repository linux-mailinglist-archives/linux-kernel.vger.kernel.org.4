Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B67C722F95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbjFETRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbjFETQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FBB106;
        Mon,  5 Jun 2023 12:16:22 -0700 (PDT)
Date:   Mon, 05 Jun 2023 19:16:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685992581;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=64qXtPcj4Jdo/8zlj4PIoNJS9+khEW9797U80Cy1DQ0=;
        b=XjHir3xp5/LyIymyml3Q7/UR5Y+nm+wlxC8buXG2Us4KgN5n2/U7jVXvkQWk7+V/9xghCt
        SE3Senq9lC5dQ5fKiyBl7x5Ba23iP5TO8li99XW3Ek2gHsEKAj5fMmclTPQ1P+0YLkVH+J
        y1NpwANVVzsheqJCcPNtMDl+m4/gn11AEQs2dr76RrspL89gXpnbbbCvMat0EKzH5wdLtA
        mf6jLEOUWmz+hcu2rmWoL0kBD5dPMXIIDoiG2y6EtwKBmLvlvBm5HO4OUXQ/PmVQfcCuPg
        J/i5hgFSBpC2OgWHsC4+PCQsbAE16a6lithllPAoXi5zD5Li4cGfXzMJAxMv+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685992581;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=64qXtPcj4Jdo/8zlj4PIoNJS9+khEW9797U80Cy1DQ0=;
        b=WAJ+Dl2nRlgF03dEEhslF7WuHwk1z9Xel99Lr5m5kNzbkj4r9oH7Z9+q9YHe9yKsf1gy9t
        39iAg3bRaTXqIGAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Consider task_struct::saved_state in
 wait_task_inactive()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230601091234.GW83892@hirez.programming.kicks-ass.net>
References: <20230601091234.GW83892@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <168599258059.404.17087833652728912462.tip-bot2@tip-bot2>
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

Commit-ID:     1c06918788e8ae6e69e4381a2806617312922524
Gitweb:        https://git.kernel.org/tip/1c06918788e8ae6e69e4381a2806617312922524
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 May 2023 16:39:07 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:11:03 +02:00

sched: Consider task_struct::saved_state in wait_task_inactive()

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
Link: https://lkml.kernel.org/r/20230601091234.GW83892@hirez.programming.kicks-ass.net
---
 kernel/sched/core.c | 59 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 810cf7d..ac38225 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2213,6 +2213,39 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 		rq_clock_skip_update(rq);
 }
 
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
@@ -2231,7 +2264,7 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
  */
 unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state)
 {
-	int running, queued;
+	int running, queued, match;
 	struct rq_flags rf;
 	unsigned long ncsw;
 	struct rq *rq;
@@ -2257,7 +2290,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * is actually now running somewhere else!
 		 */
 		while (task_on_cpu(rq, p)) {
-			if (!(READ_ONCE(p->__state) & match_state))
+			if (!task_state_match(p, match_state))
 				return 0;
 			cpu_relax();
 		}
@@ -2272,8 +2305,15 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
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
@@ -4003,15 +4043,14 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
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
@@ -4027,12 +4066,10 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
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
