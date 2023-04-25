Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2916D6EE130
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjDYLpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbjDYLpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:45:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42166A45
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682423049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIn6jOD/NeIKj2oP7nKtWE4+cRY7zlmSfjRegYEWY78=;
        b=O5fSBrrjWFAFn4BhQ+kU29pmHIAZa8A5HHq21XBHpAVfxj0HnBObkB9r8va9SdsgQGQ9F5
        pyqQ9BAyNlNaPygMl7487x4Fc80sLVV0sav3fu1R/z7w8GIAD+rQHliKzF0P/KIi4eo4Q0
        N/CYP3PyofaZhFjGtbbFYY0Dj5rN9S0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-k5AQPd14OvSQiUNg_thmAA-1; Tue, 25 Apr 2023 07:44:04 -0400
X-MC-Unique: k5AQPd14OvSQiUNg_thmAA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85060884EC0;
        Tue, 25 Apr 2023 11:44:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3A30C15BA0;
        Tue, 25 Apr 2023 11:43:56 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM)
Subject: [PATCH v7 3/3] treewide: replace put_task_struct() with the atomic safe version
Date:   Tue, 25 Apr 2023 08:43:03 -0300
Message-Id: <20230425114307.36889-4-wander@redhat.com>
In-Reply-To: <20230425114307.36889-1-wander@redhat.com>
References: <20230425114307.36889-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In places where put_task_struct() is called in a non-sleepable context,
we replace those calls by put_task_struct_atomic_safe().

These call sites were found by running internal regression tests and
looking for warnings generated by put_task_might_resched().

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/events/core.c     |  6 +++---
 kernel/locking/rtmutex.c | 10 +++++-----
 kernel/sched/core.c      |  6 +++---
 kernel/sched/deadline.c  | 16 ++++++++--------
 kernel/sched/rt.c        |  4 ++--
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 435815d3be3f..8f823da02324 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1181,7 +1181,7 @@ static void put_ctx(struct perf_event_context *ctx)
 		if (ctx->parent_ctx)
 			put_ctx(ctx->parent_ctx);
 		if (ctx->task && ctx->task != TASK_TOMBSTONE)
-			put_task_struct(ctx->task);
+			put_task_struct_atomic_safe(ctx->task);
 		call_rcu(&ctx->rcu_head, free_ctx);
 	}
 }
@@ -13019,7 +13019,7 @@ static void perf_event_exit_task_context(struct task_struct *child)
 	RCU_INIT_POINTER(child->perf_event_ctxp, NULL);
 	put_ctx(child_ctx); /* cannot be last */
 	WRITE_ONCE(child_ctx->task, TASK_TOMBSTONE);
-	put_task_struct(current); /* cannot be last */
+	put_task_struct_atomic_safe(current); /* cannot be last */
 
 	clone_ctx = unclone_ctx(child_ctx);
 	raw_spin_unlock_irq(&child_ctx->lock);
@@ -13124,7 +13124,7 @@ void perf_event_free_task(struct task_struct *task)
 	 */
 	RCU_INIT_POINTER(task->perf_event_ctxp, NULL);
 	WRITE_ONCE(ctx->task, TASK_TOMBSTONE);
-	put_task_struct(task); /* cannot be last */
+	put_task_struct_atomic_safe(task); /* cannot be last */
 	raw_spin_unlock_irq(&ctx->lock);
 
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 728f434de2bb..3ecb8d6ae039 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -509,7 +509,7 @@ static __always_inline void rt_mutex_wake_up_q(struct rt_wake_q_head *wqh)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && wqh->rtlock_task) {
 		wake_up_state(wqh->rtlock_task, TASK_RTLOCK_WAIT);
-		put_task_struct(wqh->rtlock_task);
+		put_task_struct_atomic_safe(wqh->rtlock_task);
 		wqh->rtlock_task = NULL;
 	}
 
@@ -649,7 +649,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 			       "task: %s (%d)\n", max_lock_depth,
 			       top_task->comm, task_pid_nr(top_task));
 		}
-		put_task_struct(task);
+		put_task_struct_atomic_safe(task);
 
 		return -EDEADLK;
 	}
@@ -817,7 +817,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 * No requeue[7] here. Just release @task [8]
 		 */
 		raw_spin_unlock(&task->pi_lock);
-		put_task_struct(task);
+		put_task_struct_atomic_safe(task);
 
 		/*
 		 * [9] check_exit_conditions_3 protected by lock->wait_lock.
@@ -886,7 +886,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 
 	/* [8] Release the task */
 	raw_spin_unlock(&task->pi_lock);
-	put_task_struct(task);
+	put_task_struct_atomic_safe(task);
 
 	/*
 	 * [9] check_exit_conditions_3 protected by lock->wait_lock.
@@ -990,7 +990,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
  out_unlock_pi:
 	raw_spin_unlock_irq(&task->pi_lock);
  out_put_task:
-	put_task_struct(task);
+	put_task_struct_atomic_safe(task);
 
 	return ret;
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0d18c3969f90..a4783f0c9f01 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1007,7 +1007,7 @@ void wake_up_q(struct wake_q_head *head)
 		 * the queueing in wake_q_add() so as not to miss wakeups.
 		 */
 		wake_up_process(task);
-		put_task_struct(task);
+		put_task_struct_atomic_safe(task);
 	}
 }
 
@@ -2528,7 +2528,7 @@ int push_cpu_stop(void *arg)
 	raw_spin_rq_unlock(rq);
 	raw_spin_unlock_irq(&p->pi_lock);
 
-	put_task_struct(p);
+	put_task_struct_atomic_safe(p);
 	return 0;
 }
 
@@ -9316,7 +9316,7 @@ static int __balance_push_cpu_stop(void *arg)
 	rq_unlock(rq, &rf);
 	raw_spin_unlock_irq(&p->pi_lock);
 
-	put_task_struct(p);
+	put_task_struct_atomic_safe(p);
 
 	return 0;
 }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 71b24371a6f7..0f8b8a490dc0 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -327,7 +327,7 @@ static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 		 * so we are still safe.
 		 */
 		if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
-			put_task_struct(p);
+			put_task_struct_atomic_safe(p);
 	}
 	__sub_rq_bw(p->dl.dl_bw, &rq->dl);
 	__add_rq_bw(new_bw, &rq->dl);
@@ -467,7 +467,7 @@ static void task_contending(struct sched_dl_entity *dl_se, int flags)
 		 * so we are still safe.
 		 */
 		if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == 1)
-			put_task_struct(dl_task_of(dl_se));
+			put_task_struct_atomic_safe(dl_task_of(dl_se));
 	} else {
 		/*
 		 * Since "dl_non_contending" is not set, the
@@ -1207,7 +1207,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 	 * This can free the task_struct, including this hrtimer, do not touch
 	 * anything related to that after this.
 	 */
-	put_task_struct(p);
+	put_task_struct_atomic_safe(p);
 
 	return HRTIMER_NORESTART;
 }
@@ -1442,7 +1442,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	dl_se->dl_non_contending = 0;
 unlock:
 	task_rq_unlock(rq, p, &rf);
-	put_task_struct(p);
+	put_task_struct_atomic_safe(p);
 
 	return HRTIMER_NORESTART;
 }
@@ -1899,7 +1899,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 		 * so we are still safe.
 		 */
 		if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
-			put_task_struct(p);
+			put_task_struct_atomic_safe(p);
 	}
 	sub_rq_bw(&p->dl, &rq->dl);
 	rq_unlock(rq, &rf);
@@ -2351,7 +2351,7 @@ static int push_dl_task(struct rq *rq)
 			/* No more tasks */
 			goto out;
 
-		put_task_struct(next_task);
+		put_task_struct_atomic_safe(next_task);
 		next_task = task;
 		goto retry;
 	}
@@ -2366,7 +2366,7 @@ static int push_dl_task(struct rq *rq)
 	double_unlock_balance(rq, later_rq);
 
 out:
-	put_task_struct(next_task);
+	put_task_struct_atomic_safe(next_task);
 
 	return ret;
 }
@@ -2633,7 +2633,7 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 static void switched_to_dl(struct rq *rq, struct task_struct *p)
 {
 	if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
-		put_task_struct(p);
+		put_task_struct_atomic_safe(p);
 
 	/* If p is not queued we will update its parameters at next wakeup. */
 	if (!task_on_rq_queued(p)) {
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0a11f44adee5..e58a84535f61 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2150,7 +2150,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		/*
 		 * Something has shifted, try again.
 		 */
-		put_task_struct(next_task);
+		put_task_struct_atomic_safe(next_task);
 		next_task = task;
 		goto retry;
 	}
@@ -2163,7 +2163,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 
 	double_unlock_balance(rq, lowest_rq);
 out:
-	put_task_struct(next_task);
+	put_task_struct_atomic_safe(next_task);
 
 	return ret;
 }
-- 
2.40.0

