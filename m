Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7E66226CF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiKIJYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKIJX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:23:58 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE99F11159
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:23:54 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N6ffD3mbvzmVhs;
        Wed,  9 Nov 2022 17:23:32 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 17:23:45 +0800
Received: from huawei.com (7.220.126.23) by dggpemm500014.china.huawei.com
 (7.185.36.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 17:23:45 +0800
From:   Song Zhang <zhangsong34@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        Song Zhang <zhangsong34@huawei.com>
Subject: [PATCH v4] sched/fair: Introduce priority load balance for CFS
Date:   Wed, 9 Nov 2022 17:22:43 +0800
Message-ID: <20221109092243.37724-1-zhangsong34@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [7.220.126.23]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For co-location with idle and non-idle tasks, when CFS do load balance,
it is reasonable to prefer migrating non-idle tasks and migrating idle
tasks lastly to improve QoS of non-idle(Latency Sensitive) tasks.

However, the migrate_{load|util|task} difference between env->src_rq
and env->dst_rq should also be considered. So we should add some
restrictions before migrating non-idle tasks.

Let's deal with the following cases by env->migration_type for
detach_tasks().

If {load|util|nr}_imb is the non-idle cfs tasks {load|util|nr} imbalance
between env->src_rq and env->dst_rq.

case migrate_load:
	load = task_h_load(p);
	if (load_imb < load)
		goto next;
	load_imb -= load;

case migrate_util:
	util = task_util(p);
	if (util_imb < util)
		goto next;
	util_imb -= util;

case migrate_task:
	if (nr_imb < 1)
		break loop;

Signed-off-by: Song Zhang <zhangsong34@huawei.com>
---
v3->v4:
 - Remove can_migrate_cfs_tasks().
 - Fix calculate migration {load|util|task} imbalance for env->src_rq
   and env->dst_rq for non-idle cfs tasks.

v2->v3:
 - Fix can_migrate_cfs_tasks() for detach_one_task.

v1->v2:
 - Remove sysctl knob and add LB_PRIO sched feature.
 - Migrating tasks consider non-idle migrate_{load|util|task} difference
   between env->src_rq and env->dst_rq, and if the difference smaller than
   env->imbalance, change to migrate idle tasks instead.
---
 kernel/sched/core.c     |   1 +
 kernel/sched/fair.c     | 104 ++++++++++++++++++++++++++++++++++++++--
 kernel/sched/features.h |   1 +
 kernel/sched/sched.h    |   1 +
 4 files changed, 103 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5800b0623ff3..fa4174ecd111 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9731,6 +9731,7 @@ void __init sched_init(void)
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
 
 		INIT_LIST_HEAD(&rq->cfs_tasks);
+		INIT_LIST_HEAD(&rq->cfs_idle_tasks);
 
 		rq_attach_root(rq, &def_root_domain);
 #ifdef CONFIG_NO_HZ_COMMON
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..6185861ef1f0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3199,6 +3199,20 @@ static inline void update_scan_period(struct task_struct *p, int new_cpu)
 
 #endif /* CONFIG_NUMA_BALANCING */
 
+#ifdef CONFIG_SMP
+static void
+adjust_rq_cfs_tasks(
+	void (*list_op)(struct list_head *, struct list_head *),
+	struct rq *rq,
+	struct sched_entity *se)
+{
+	if (sched_feat(LB_PRIO) && task_has_idle_policy(task_of(se)))
+		(*list_op)(&se->group_node, &rq->cfs_idle_tasks);
+	else
+		(*list_op)(&se->group_node, &rq->cfs_tasks);
+}
+#endif
+
 static void
 account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
@@ -3208,7 +3222,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		struct rq *rq = rq_of(cfs_rq);
 
 		account_numa_enqueue(rq, task_of(se));
-		list_add(&se->group_node, &rq->cfs_tasks);
+		adjust_rq_cfs_tasks(list_add, rq, se);
 	}
 #endif
 	cfs_rq->nr_running++;
@@ -7631,7 +7645,7 @@ done: __maybe_unused;
 	 * the list, so our cfs_tasks list becomes MRU
 	 * one.
 	 */
-	list_move(&p->se.group_node, &rq->cfs_tasks);
+	adjust_rq_cfs_tasks(list_move, rq, &p->se);
 #endif
 
 	if (hrtick_enabled_fair(rq))
@@ -8147,6 +8161,45 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
 	set_task_cpu(p, env->dst_cpu);
 }
 
+/*
+ * update_cfs_tasks_imb() -- update migrate_{load|util|task} imbalance
+ * between src_rq->cfs and dst_rq->cfs.
+ */
+static void update_cfs_tasks_imb(struct lb_env *env,
+				  long *load_imb,
+				  long *util_imb,
+				  int *nr_imb)
+{
+	unsigned long src_load = 0, src_util = 0,
+		dst_load = 0, dst_util = 0;
+
+	struct list_head *src_tasks = &env->src_rq->cfs_tasks;
+	struct list_head *dst_tasks = &env->dst_rq->cfs_tasks;
+
+	int nr_src_tasks = &env->src_rq->cfs.h_nr_running -
+		&env->src_rq->cfs.idle_h_nr_running;
+
+	int nr_dst_tasks = &env->dst_rq->cfs.h_nr_running -
+		&env->dst_rq->cfs.idle_h_nr_running;
+
+	struct task_struct *p;
+
+	list_for_each_entry(p, src_tasks, se.group_node) {
+		src_util += task_util_est(p);
+		src_load += max_t(unsigned long, task_h_load(p), 1);
+	}
+
+	list_for_each_entry(p, dst_tasks, se.group_node) {
+		dst_util += task_util_est(p);
+		dst_load += max_t(unsigned long, task_h_load(p), 1);
+	}
+
+	*util_imb = max_t(long, 0, (src_util - dst_util) >> 1);
+	*nr_imb = max_t(int, 0, (nr_src_tasks - nr_dst_tasks) >> 1);
+	*load_imb = max_t(long, 0, (src_load * capacity_of(env->dst_cpu) -
+		dst_load * capacity_of(env->src_cpu)) >> 1);
+}
+
 /*
  * detach_one_task() -- tries to dequeue exactly one task from env->src_rq, as
  * part of active balancing operations within "domain".
@@ -8156,11 +8209,14 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
 static struct task_struct *detach_one_task(struct lb_env *env)
 {
 	struct task_struct *p;
+	struct list_head *tasks = &env->src_rq->cfs_tasks;
+	bool has_detach_idle_tasks = false;
 
 	lockdep_assert_rq_held(env->src_rq);
 
+again:
 	list_for_each_entry_reverse(p,
-			&env->src_rq->cfs_tasks, se.group_node) {
+			tasks, se.group_node) {
 		if (!can_migrate_task(p, env))
 			continue;
 
@@ -8175,6 +8231,13 @@ static struct task_struct *detach_one_task(struct lb_env *env)
 		schedstat_inc(env->sd->lb_gained[env->idle]);
 		return p;
 	}
+
+	if (sched_feat(LB_PRIO) && !has_detach_idle_tasks) {
+		has_detach_idle_tasks = true;
+		tasks = &env->src_rq->cfs_idle_tasks;
+		goto again;
+	}
+
 	return NULL;
 }
 
@@ -8190,6 +8253,9 @@ static int detach_tasks(struct lb_env *env)
 	unsigned long util, load;
 	struct task_struct *p;
 	int detached = 0;
+	bool has_detach_idle_tasks = false;
+	long load_imb = 0, util_imb = 0;
+	int nr_imb = 0;
 
 	lockdep_assert_rq_held(env->src_rq);
 
@@ -8205,6 +8271,10 @@ static int detach_tasks(struct lb_env *env)
 	if (env->imbalance <= 0)
 		return 0;
 
+	if (sched_feat(LB_PRIO))
+		update_cfs_tasks_imb(env, &load_imb, &util_imb, &nr_imb);
+
+again:
 	while (!list_empty(tasks)) {
 		/*
 		 * We don't want to steal all, otherwise we may be treated likewise,
@@ -8258,6 +8328,12 @@ static int detach_tasks(struct lb_env *env)
 			if (shr_bound(load, env->sd->nr_balance_failed) > env->imbalance)
 				goto next;
 
+			if (sched_feat(LB_PRIO) && !has_detach_idle_tasks) {
+				if (load_imb < load)
+					goto next;
+				load_imb -= load;
+			}
+
 			env->imbalance -= load;
 			break;
 
@@ -8267,10 +8343,22 @@ static int detach_tasks(struct lb_env *env)
 			if (util > env->imbalance)
 				goto next;
 
+			if (sched_feat(LB_PRIO) && !has_detach_idle_tasks) {
+				if (util_imb < util)
+					goto next;
+				util_imb -= util;
+			}
+
 			env->imbalance -= util;
 			break;
 
 		case migrate_task:
+			if (sched_feat(LB_PRIO) && !has_detach_idle_tasks) {
+				if (nr_imb < 1)
+					goto detach_idle;
+				nr_imb--;
+			}
+
 			env->imbalance--;
 			break;
 
@@ -8310,6 +8398,14 @@ static int detach_tasks(struct lb_env *env)
 		list_move(&p->se.group_node, tasks);
 	}
 
+detach_idle:
+	if (sched_feat(LB_PRIO) &&
+		!has_detach_idle_tasks && env->imbalance > 0) {
+		has_detach_idle_tasks = true;
+		tasks = &env->src_rq->cfs_idle_tasks;
+		goto again;
+	}
+
 	/*
 	 * Right now, this is one of only two places we collect this stat
 	 * so we can safely collect detach_one_task() stats here rather
@@ -11814,7 +11910,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 		 * Move the next running task to the front of the list, so our
 		 * cfs_tasks list becomes MRU one.
 		 */
-		list_move(&se->group_node, &rq->cfs_tasks);
+		adjust_rq_cfs_tasks(list_move, rq, se);
 	}
 #endif
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..bc4a85f839b4 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -85,6 +85,7 @@ SCHED_FEAT(RT_PUSH_IPI, true)
 
 SCHED_FEAT(RT_RUNTIME_SHARE, false)
 SCHED_FEAT(LB_MIN, false)
+SCHED_FEAT(LB_PRIO, false)
 SCHED_FEAT(ATTACH_AGE_LOAD, true)
 
 SCHED_FEAT(WA_IDLE, true)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1644242ecd11..bf6c2a3eea6c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1053,6 +1053,7 @@ struct rq {
 	int			online;
 
 	struct list_head cfs_tasks;
+	struct list_head cfs_idle_tasks;
 
 	struct sched_avg	avg_rt;
 	struct sched_avg	avg_dl;
-- 
2.33.0

