Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEF8621373
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbiKHNuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbiKHNuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:50:21 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A8963F0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 05:50:18 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N68c0476wzHvdG;
        Tue,  8 Nov 2022 21:49:52 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 21:50:16 +0800
Received: from huawei.com (7.220.126.23) by dggpemm500014.china.huawei.com
 (7.185.36.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 21:50:16 +0800
From:   Song Zhang <zhangsong34@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        Song Zhang <zhangsong34@huawei.com>
Subject: [PATCH v2] sched/fair: Introduce priority load balance for CFS
Date:   Tue, 8 Nov 2022 21:49:15 +0800
Message-ID: <20221108134915.75213-1-zhangsong34@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [7.220.126.23]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Let's deal with the following cases.

case migrate_load:
	load_diff = sum_load(non-idle cfs tasks of env->src_rq) -
				sum_load(non-idle cfs tasks of env->dst_rq);
	if (load_diff < env->imbalance)
		goto migrate_cfs_idle_tasks;

case migrate_util:
	util_diff = sum_util(non-idle cfs tasks of env->src_rq) -
				sum_util(non-idle cfs tasks of env->dst_rq);
	if (util_diff < env->imbalance)
		goto migrate_cfs_idle_tasks;

case migrate_task:
	nr_diff = sum_nr(non-idle cfs tasks of env->src_rq) -
			  sum_nr(non-idle cfs tasks of env->dst_rq);
	if (nr_diff < 1)
		goto migrate_cfs_idle_tasks;


Signed-off-by: Song Zhang <zhangsong34@huawei.com>
---
v1->v2:
 - Remove sysctl knob and add LB_PRIO sched feature.
 - Migrating tasks consider non-idle migrate_{load|util|task} difference
   between env->src_rq and env->dst_rq, and if the difference smaller than
   env->imbalance, change to migrate idle tasks instead.
---
 kernel/sched/core.c     |   1 +
 kernel/sched/fair.c     | 132 ++++++++++++++++++++++++++++++++++++++--
 kernel/sched/features.h |   1 +
 kernel/sched/sched.h    |   1 +
 4 files changed, 131 insertions(+), 4 deletions(-)

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
index e4a0b8bd941c..c9dde94f905e 100644
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
@@ -8147,6 +8161,63 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
 	set_task_cpu(p, env->dst_cpu);
 }
 
+/*
+ * update_cfs_tasks_diff() -- update migrate_{load|util|task} diff
+ * between src_rq->cfs and dst_rq->cfs.
+ */
+static void update_cfs_tasks_diff(struct lb_env *env,
+				  long *load_diff,
+				  long *util_diff,
+				  int *nr_diff)
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
+	*load_diff = src_load - dst_load;
+	*util_diff = src_util - dst_util;
+	*nr_diff = nr_src_tasks - nr_dst_tasks;
+}
+
+/*
+ * can_migrate_cfs_tasks() -- compare migrate_{load|util|task} diff
+ * with env->imbalance.
+ *
+ * Returns true if rq->cfs_tasks can be migrated.
+ */
+static bool can_migrate_cfs_tasks(struct lb_env *env,
+				  long load_diff,
+				  long util_diff,
+				  int nr_diff)
+{
+	return (env->migration_type == migrate_load &&
+		load_diff < env->imbalance) ||
+		(env->migration_type == migrate_util &&
+		util_diff < env->imbalance) ||
+		(env->migration_type == migrate_task &&
+		nr_diff < 1);
+}
+
 /*
  * detach_one_task() -- tries to dequeue exactly one task from env->src_rq, as
  * part of active balancing operations within "domain".
@@ -8156,11 +8227,24 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
 static struct task_struct *detach_one_task(struct lb_env *env)
 {
 	struct task_struct *p;
+	struct list_head *tasks = &env->src_rq->cfs_tasks;
+	bool has_detach_idle_tasks = false;
+	long load_diff = 0, util_diff = 0;
+	int nr_diff = 0;
 
 	lockdep_assert_rq_held(env->src_rq);
 
+	if (sched_feat(LB_PRIO)) {
+		update_cfs_tasks_diff(env, &load_diff, &util_diff, &nr_diff);
+		if (!can_migrate_cfs_tasks(env, load_diff, util_diff, nr_diff)) {
+			has_detach_idle_tasks = true;
+			tasks = &env->src_rq->cfs_idle_tasks;
+		}
+	}
+
+again:
 	list_for_each_entry_reverse(p,
-			&env->src_rq->cfs_tasks, se.group_node) {
+			tasks, se.group_node) {
 		if (!can_migrate_task(p, env))
 			continue;
 
@@ -8175,6 +8259,13 @@ static struct task_struct *detach_one_task(struct lb_env *env)
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
 
@@ -8190,6 +8281,9 @@ static int detach_tasks(struct lb_env *env)
 	unsigned long util, load;
 	struct task_struct *p;
 	int detached = 0;
+	bool has_detach_idle_tasks = false;
+	long load_diff = 0, util_diff = 0;
+	int nr_diff = 0;
 
 	lockdep_assert_rq_held(env->src_rq);
 
@@ -8205,6 +8299,10 @@ static int detach_tasks(struct lb_env *env)
 	if (env->imbalance <= 0)
 		return 0;
 
+	if (sched_feat(LB_PRIO))
+		update_cfs_tasks_diff(env, &load_diff, &util_diff, &nr_diff);
+
+again:
 	while (!list_empty(tasks)) {
 		/*
 		 * We don't want to steal all, otherwise we may be treated likewise,
@@ -8258,6 +8356,12 @@ static int detach_tasks(struct lb_env *env)
 			if (shr_bound(load, env->sd->nr_balance_failed) > env->imbalance)
 				goto next;
 
+			if (sched_feat(LB_PRIO) && !has_detach_idle_tasks) {
+				if (load_diff < env->imbalance)
+					goto detach_idle;
+				load_diff -= load;
+			}
+
 			env->imbalance -= load;
 			break;
 
@@ -8267,10 +8371,22 @@ static int detach_tasks(struct lb_env *env)
 			if (util > env->imbalance)
 				goto next;
 
+			if (sched_feat(LB_PRIO) && !has_detach_idle_tasks) {
+				if (util_diff < env->imbalance)
+					goto detach_idle;
+				util_diff -= util;
+			}
+
 			env->imbalance -= util;
 			break;
 
 		case migrate_task:
+			if (sched_feat(LB_PRIO) && !has_detach_idle_tasks) {
+				if (nr_diff < 1)
+					goto detach_idle;
+				nr_diff--;
+			}
+
 			env->imbalance--;
 			break;
 
@@ -8310,6 +8426,14 @@ static int detach_tasks(struct lb_env *env)
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
@@ -11814,7 +11938,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
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

