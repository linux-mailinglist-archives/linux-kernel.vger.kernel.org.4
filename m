Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781AA5B32A1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiIIJBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiIIJAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:00:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD3A32AA5;
        Fri,  9 Sep 2022 02:00:30 -0700 (PDT)
Date:   Fri, 09 Sep 2022 09:00:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662714027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KlweZF8EmTyFXxz3TxTAu6ZmbjaWJAOjflJYfKtIW1c=;
        b=OuyIU9xfvTyO/F8RkUz05bgnUvmI2B9zEUbGJphEWyX0u6pLkbgK4XqW+0lB4UIeUnTyzb
        J/5cEzLPNVLPFYqBS+ZxARJCa9gNi8czm8ol2M/5adIpKVyQe/I7wRnUIxXZjP0Go/da1f
        aa8QnYtPShD17Rlep4nS2dheyfJL6lXtxQO20sGGmj+fFuw7VB+H/2UObzOYiszGaRndKt
        tQWAEWLtBIAvaieqR4ghvUOn2N/kPwEi7nN3cs85JrE5oOPVXi6QFtWnsVBCjSBWpcjrAp
        bpQzEVv1KlvpV9O22fXFHnZSOc0j35q6ISiBX3SBJCj2xmajqSUOxurtOPyxRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662714027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KlweZF8EmTyFXxz3TxTAu6ZmbjaWJAOjflJYfKtIW1c=;
        b=mccZhGUDjiTmM8pucXPfJAhRH+DeTh/b0ND62nnPTEQSqtwFpZyRt0qz7MdWehE+pUcRnO
        cLsAwRS7SaF2W1CQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Rename task_running() to task_on_cpu()
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Yxhkhn55uHZx+NGl@hirez.programming.kicks-ass.net>
References: <Yxhkhn55uHZx+NGl@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <166271402603.401.5726393155491707442.tip-bot2@tip-bot2>
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

Commit-ID:     0b9d46fc5ef7a457cc635b30b010081228cb81ac
Gitweb:        https://git.kernel.org/tip/0b9d46fc5ef7a457cc635b30b010081228cb81ac
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 06 Sep 2022 12:33:04 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:53:47 +02:00

sched: Rename task_running() to task_on_cpu()

There is some ambiguity about task_running() in that it is unrelated
to TASK_RUNNING but instead tests ->on_cpu. As such, rename the thing
task_on_cpu().

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Yxhkhn55uHZx+NGl@hirez.programming.kicks-ass.net
---
 kernel/sched/core.c       | 10 +++++-----
 kernel/sched/core_sched.c |  2 +-
 kernel/sched/deadline.c   |  6 +++---
 kernel/sched/fair.c       |  2 +-
 kernel/sched/rt.c         |  6 +++---
 kernel/sched/sched.h      |  2 +-
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7d289d8..1630181 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2777,7 +2777,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		return -EINVAL;
 	}
 
-	if (task_running(rq, p) || READ_ONCE(p->__state) == TASK_WAKING) {
+	if (task_on_cpu(rq, p) || READ_ONCE(p->__state) == TASK_WAKING) {
 		/*
 		 * MIGRATE_ENABLE gets here because 'p == current', but for
 		 * anything else we cannot do is_migration_disabled(), punt
@@ -3289,11 +3289,11 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 *
 		 * NOTE! Since we don't hold any locks, it's not
 		 * even sure that "rq" stays as the right runqueue!
-		 * But we don't care, since "task_running()" will
+		 * But we don't care, since "task_on_cpu()" will
 		 * return false if the runqueue has changed and p
 		 * is actually now running somewhere else!
 		 */
-		while (task_running(rq, p)) {
+		while (task_on_cpu(rq, p)) {
 			if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
 				return 0;
 			cpu_relax();
@@ -3306,7 +3306,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 */
 		rq = task_rq_lock(p, &rf);
 		trace_sched_wait_task(p);
-		running = task_running(rq, p);
+		running = task_on_cpu(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
 		if (!match_state || READ_ONCE(p->__state) == match_state)
@@ -8648,7 +8648,7 @@ again:
 	if (curr->sched_class != p->sched_class)
 		goto out_unlock;
 
-	if (task_running(p_rq, p) || !task_is_running(p))
+	if (task_on_cpu(p_rq, p) || !task_is_running(p))
 		goto out_unlock;
 
 	yielded = curr->sched_class->yield_to_task(rq, p);
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 1ec807f..a57fd8f 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -88,7 +88,7 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
 	 * core has now entered/left forced idle state. Defer accounting to the
 	 * next scheduling edge, rather than always forcing a reschedule here.
 	 */
-	if (task_running(rq, p))
+	if (task_on_cpu(rq, p))
 		resched_curr(rq);
 
 	task_rq_unlock(rq, p, &rf);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d0fe6a2..86dea6a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2092,7 +2092,7 @@ static void task_fork_dl(struct task_struct *p)
 
 static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
 {
-	if (!task_running(rq, p) &&
+	if (!task_on_cpu(rq, p) &&
 	    cpumask_test_cpu(cpu, &p->cpus_mask))
 		return 1;
 	return 0;
@@ -2244,7 +2244,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 		if (double_lock_balance(rq, later_rq)) {
 			if (unlikely(task_rq(task) != rq ||
 				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
-				     task_running(rq, task) ||
+				     task_on_cpu(rq, task) ||
 				     !dl_task(task) ||
 				     !task_on_rq_queued(task))) {
 				double_unlock_balance(rq, later_rq);
@@ -2474,7 +2474,7 @@ skip:
  */
 static void task_woken_dl(struct rq *rq, struct task_struct *p)
 {
-	if (!task_running(rq, p) &&
+	if (!task_on_cpu(rq, p) &&
 	    !test_tsk_need_resched(rq->curr) &&
 	    p->nr_cpus_allowed > 1 &&
 	    dl_task(rq->curr) &&
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7bad641..4e5b171 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7935,7 +7935,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	/* Record that we found at least one task that could run on dst_cpu */
 	env->flags &= ~LBF_ALL_PINNED;
 
-	if (task_running(env->src_rq, p)) {
+	if (task_on_cpu(env->src_rq, p)) {
 		schedstat_inc(p->stats.nr_failed_migrations_running);
 		return 0;
 	}
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 27e694c..d869bcf 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1845,7 +1845,7 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 
 static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
 {
-	if (!task_running(rq, p) &&
+	if (!task_on_cpu(rq, p) &&
 	    cpumask_test_cpu(cpu, &p->cpus_mask))
 		return 1;
 
@@ -2000,7 +2000,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 */
 			if (unlikely(task_rq(task) != rq ||
 				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
-				     task_running(rq, task) ||
+				     task_on_cpu(rq, task) ||
 				     !rt_task(task) ||
 				     !task_on_rq_queued(task))) {
 
@@ -2458,7 +2458,7 @@ skip:
  */
 static void task_woken_rt(struct rq *rq, struct task_struct *p)
 {
-	bool need_to_push = !task_running(rq, p) &&
+	bool need_to_push = !task_on_cpu(rq, p) &&
 			    !test_tsk_need_resched(rq->curr) &&
 			    p->nr_cpus_allowed > 1 &&
 			    (dl_task(rq->curr) || rt_task(rq->curr)) &&
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b75ac74..91b2c7e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2051,7 +2051,7 @@ static inline int task_current(struct rq *rq, struct task_struct *p)
 	return rq->curr == p;
 }
 
-static inline int task_running(struct rq *rq, struct task_struct *p)
+static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 #ifdef CONFIG_SMP
 	return p->on_cpu;
