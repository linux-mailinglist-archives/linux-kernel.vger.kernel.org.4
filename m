Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D3062A024
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbiKORUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiKORT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:19:29 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9842E9F3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:19:16 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso13622607wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vie2+W+a1jhqsNpaojKa5uLWE1X0hNQL14mrtfOMQow=;
        b=WJJlA3dtITTK/3i1Sxjtl9yU0qemCZstwlD9Kq+G/0PVSTS7I02LqXD7qytAYySKC1
         5YGb9nMkKkDk2zv9Xv362ugY6V3ytd90a5W0igyqEVwuxDEM33z9qdpBi788UaTryHbn
         uzJkC8LjCMZoLQjL1Qo8kpM40stHxM+OU6nHAlLa7VXYASbqtDLayYCF5XPUwmcBJVVR
         Apm7yUw+kByTeIEGs5HuKJqP9ax6CtAqX/FsPzCzokoEb2IYuxXmqlhg6acFJnOVhlEE
         G4GGzl7s7+kbJcxzHKIVutSHSlT2TChFT16v84OiVdDodShK5zC3toGDCxmIbcJ9zLoA
         KABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vie2+W+a1jhqsNpaojKa5uLWE1X0hNQL14mrtfOMQow=;
        b=k2pcvz1eSOAhjLLb7ZjU//+Gtg1zssKbSlCDcuMM2tRNnkbqQ14Fso+8FqM31eSu5T
         VZyLmh+lEtZtOoZBLFNIrHA62osU2VtZHwDKMWu2vwF9L0e4kcqKvaLB6Thq3zwra9f1
         WBxavCBVAu+RX4jgqoTaupEac1HyF4/radNyQD3tYovXDoh6151JF+atpTPEGiIjF+fl
         ne2ZxVSHaSTZVNxZR0+XRLVKALqShHQoIvZMTbcAmo1cv5wlL3k+qRT6/SL9pIoYka6K
         af8ORFnaX8Tkr7APRfnRiIpiNaVsHk9PqbvmFL8SGNdJsqL1zLOD1E58OXqoAMo9nQ9o
         fQbQ==
X-Gm-Message-State: ANoB5ploAK3lCqyI9r4517e28eI3SjBJVGG/siSRj+1+jYNZpgjatFUp
        RT8fJEr0SdC0ZHJCZSn8yi1bRA==
X-Google-Smtp-Source: AA0mqf5g6JGskhWjfO6tZLoJG0/0C9vcXH5b5lSyiG/osK2+FE0R3GPyF/D+GQJVFjZni85qi7k/9w==
X-Received: by 2002:a05:600c:22c9:b0:3cf:ac8a:d43e with SMTP id 9-20020a05600c22c900b003cfac8ad43emr2294551wmg.65.1668532755732;
        Tue, 15 Nov 2022 09:19:15 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:91c8:7496:8b73:811f])
        by smtp.gmail.com with ESMTPSA id bg40-20020a05600c3ca800b003cf78aafdd7sm16846461wmb.39.2022.11.15.09.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 09:19:14 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v9 8/9] sched/fair: Add latency list
Date:   Tue, 15 Nov 2022 18:18:50 +0100
Message-Id: <20221115171851.835-9-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221115171851.835-1-vincent.guittot@linaro.org>
References: <20221115171851.835-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a rb tree for latency sensitive entities so we can schedule the most
sensitive one first even when it failed to preempt current at wakeup or
when it got quickly preempted by another entity of higher priority.

In order to keep fairness, the latency is used once at wakeup to get a
minimum slice and not during the following scheduling slice to prevent
long running entity to got more running time than allocated to his nice
priority.

The rb tree enables to cover the last corner case where latency
sensitive entity can't got schedule quickly after the wakeup.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   |  1 +
 kernel/sched/fair.c   | 95 +++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h  |  1 +
 4 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2f33326adb8d..5187114a9920 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -548,6 +548,7 @@ struct sched_entity {
 	/* For load-balancing: */
 	struct load_weight		load;
 	struct rb_node			run_node;
+	struct rb_node			latency_node;
 	struct list_head		group_node;
 	unsigned int			on_rq;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9f6700f812ea..eaca0e34ab58 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4361,6 +4361,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
 	INIT_LIST_HEAD(&p->se.group_node);
+	RB_CLEAR_NODE(&p->se.latency_node);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			= NULL;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index be446dc58be7..76da7c7a13ab 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -665,7 +665,76 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 
 	return __node_2_se(last);
 }
+#endif
 
+/**************************************************************
+ * Scheduling class tree data structure manipulation methods:
+ * for latency
+ */
+
+static inline bool latency_before(struct sched_entity *a,
+				struct sched_entity *b)
+{
+	return (s64)(a->vruntime + a->latency_offset - b->vruntime - b->latency_offset) < 0;
+}
+
+#define __latency_node_2_se(node) \
+	rb_entry((node), struct sched_entity, latency_node)
+
+static inline bool __latency_less(struct rb_node *a, const struct rb_node *b)
+{
+	return latency_before(__latency_node_2_se(a), __latency_node_2_se(b));
+}
+
+/*
+ * Enqueue an entity into the latency rb-tree:
+ */
+static void __enqueue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+{
+
+	/* Only latency sensitive entity can be added to the list */
+	if (se->latency_offset >= 0)
+		return;
+
+	if (!RB_EMPTY_NODE(&se->latency_node))
+		return;
+
+	/*
+	 * An execution time less than sysctl_sched_min_granularity means that
+	 * the entity has been preempted by a higher sched class or an entity
+	 * with higher latency constraint.
+	 * Put it back in the list so it gets a chance to run 1st during the
+	 * next slice.
+	 */
+	if (!(flags & ENQUEUE_WAKEUP)) {
+		u64 delta_exec = se->sum_exec_runtime - se->prev_sum_exec_runtime;
+
+		if (delta_exec >= sysctl_sched_min_granularity)
+			return;
+	}
+
+	rb_add_cached(&se->latency_node, &cfs_rq->latency_timeline, __latency_less);
+}
+
+static void __dequeue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	if (!RB_EMPTY_NODE(&se->latency_node)) {
+		rb_erase_cached(&se->latency_node, &cfs_rq->latency_timeline);
+		RB_CLEAR_NODE(&se->latency_node);
+	}
+}
+
+static struct sched_entity *__pick_first_latency(struct cfs_rq *cfs_rq)
+{
+	struct rb_node *left = rb_first_cached(&cfs_rq->latency_timeline);
+
+	if (!left)
+		return NULL;
+
+	return __latency_node_2_se(left);
+}
+
+#ifdef CONFIG_SCHED_DEBUG
 /**************************************************************
  * Scheduling class statistics methods:
  */
@@ -4739,8 +4808,10 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	check_schedstat_required();
 	update_stats_enqueue_fair(cfs_rq, se, flags);
 	check_spread(cfs_rq, se);
-	if (!curr)
+	if (!curr) {
 		__enqueue_entity(cfs_rq, se);
+		__enqueue_latency(cfs_rq, se, flags);
+	}
 	se->on_rq = 1;
 
 	if (cfs_rq->nr_running == 1) {
@@ -4826,8 +4897,10 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	clear_buddies(cfs_rq, se);
 
-	if (se != cfs_rq->curr)
+	if (se != cfs_rq->curr) {
 		__dequeue_entity(cfs_rq, se);
+		__dequeue_latency(cfs_rq, se);
+	}
 	se->on_rq = 0;
 	account_entity_dequeue(cfs_rq, se);
 
@@ -4916,6 +4989,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		 */
 		update_stats_wait_end_fair(cfs_rq, se);
 		__dequeue_entity(cfs_rq, se);
+		__dequeue_latency(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 	}
 
@@ -4954,7 +5028,7 @@ static struct sched_entity *
 pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
 	struct sched_entity *left = __pick_first_entity(cfs_rq);
-	struct sched_entity *se;
+	struct sched_entity *latency, *se;
 
 	/*
 	 * If curr is set we have to see if its left of the leftmost entity
@@ -4996,6 +5070,12 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 		se = cfs_rq->last;
 	}
 
+	/* Check for latency sensitive entity waiting for running */
+	latency = __pick_first_latency(cfs_rq);
+	if (latency && (latency != se) &&
+	    wakeup_preempt_entity(latency, se) < 1)
+		se = latency;
+
 	return se;
 }
 
@@ -5019,6 +5099,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 		update_stats_wait_start_fair(cfs_rq, prev);
 		/* Put 'current' back into the tree. */
 		__enqueue_entity(cfs_rq, prev);
+		__enqueue_latency(cfs_rq, prev, 0);
 		/* in !on_rq case, update occurred at dequeue */
 		update_load_avg(cfs_rq, prev, 0);
 	}
@@ -12106,6 +12187,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
+	cfs_rq->latency_timeline = RB_ROOT_CACHED;
 	u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
@@ -12414,8 +12496,15 @@ int sched_group_set_latency(struct task_group *tg, s64 latency)
 
 	for_each_possible_cpu(i) {
 		struct sched_entity *se = tg->se[i];
+		struct rq *rq = cpu_rq(i);
+		struct rq_flags rf;
+
+		rq_lock_irqsave(rq, &rf);
 
+		__dequeue_latency(se->cfs_rq, se);
 		WRITE_ONCE(se->latency_offset, latency);
+
+		rq_unlock_irqrestore(rq, &rf);
 	}
 
 	mutex_unlock(&shares_mutex);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c3735a34d394..b81179c512e6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -575,6 +575,7 @@ struct cfs_rq {
 #endif
 
 	struct rb_root_cached	tasks_timeline;
+	struct rb_root_cached	latency_timeline;
 
 	/*
 	 * 'curr' points to currently running entity on this cfs_rq.
-- 
2.17.1

