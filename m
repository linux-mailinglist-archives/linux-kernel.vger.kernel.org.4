Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6942D62DC68
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbiKQNOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239679AbiKQNOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:14:04 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5305EF9B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:13:57 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NCgJk02R5zJnj5;
        Thu, 17 Nov 2022 21:10:46 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 21:13:55 +0800
Received: from huawei.com (7.220.126.23) by dggpemm500014.china.huawei.com
 (7.185.36.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 21:13:55 +0800
From:   Song Zhang <zhangsong34@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        Song Zhang <zhangsong34@huawei.com>
Subject: [PATCH v5] sched/fair: Introduce priority load balance for CFS
Date:   Thu, 17 Nov 2022 21:12:46 +0800
Message-ID: <20221117131246.202545-1-zhangsong34@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [7.220.126.23]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Consider a simple scenario. Assume that CPU0 has two non-idle tasks 
whose weight is 2*1024=2048, also CPU0 has 3000 idle tasks whose 
weight is 3000*3 = 9000. Now CPU1 is idle and IDLE load balance is 
triggered. CPU1 needs to pull a certain number of tasks from CPU0.

If we do not considerate task priorities and interference between tasks, 
more than 1800 idle tasks on CPU0 maybe migrated to CPU1. As a result, 
two non-idle tasks still compete on CPU0. However CPU1 is running with
a lot of idle but not non-idle tasks.

On the other hand, if we consider the interference between different 
task priorities, first migrate one non-idle to CPU1, the non-idle 
task may execute quickly on CPU1, then CPU1 is got to idle and pulls 
more idle tasks from CPU0, so that the non-idle task on CPU 0 can 
also be completed more quickly.

Although this change will cause some idle tasks imbalance between
different CPUs, but the latency of non-idle tasks can be significantly
reduced.

Signed-off-by: Song Zhang <zhangsong34@huawei.com>
---
v4->v5:
 - Deleted meaningless load/utility imbalance judgment.
 - Add restrictions on idle task migration.

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
 kernel/sched/core.c     |  1 +
 kernel/sched/fair.c     | 76 ++++++++++++++++++++++++++++++++++++++---
 kernel/sched/features.h |  1 +
 kernel/sched/sched.h    |  1 +
 4 files changed, 75 insertions(+), 4 deletions(-)

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
index e4a0b8bd941c..e677bf6487b8 100644
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
@@ -8147,6 +8161,20 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
 	set_task_cpu(p, env->dst_cpu);
 }
 
+/*
+ * cfs_nr_tasks_imbalance() -- calculate cfs non-idle tasks imbalance between
+ * env->src_rq and env->dst_rq.
+ */
+static int cfs_nr_tasks_imbalance(struct lb_env *env)
+{
+	int nr_src_tasks = &env->src_rq->cfs.h_nr_running -
+		&env->src_rq->cfs.idle_h_nr_running;
+	int nr_dst_tasks = &env->dst_rq->cfs.h_nr_running -
+		&env->dst_rq->cfs.idle_h_nr_running;
+
+	return max_t(int, 0, (nr_src_tasks - nr_dst_tasks) >> 1);
+}
+
 /*
  * detach_one_task() -- tries to dequeue exactly one task from env->src_rq, as
  * part of active balancing operations within "domain".
@@ -8156,11 +8184,15 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
 static struct task_struct *detach_one_task(struct lb_env *env)
 {
 	struct task_struct *p;
+	struct list_head *tasks = &env->src_rq->cfs_tasks;
 
 	lockdep_assert_rq_held(env->src_rq);
 
+	if (sched_feat(LB_PRIO) && cfs_nr_tasks_imbalance(env) < 1)
+		tasks = &env->src_rq->cfs_idle_tasks;
+
 	list_for_each_entry_reverse(p,
-			&env->src_rq->cfs_tasks, se.group_node) {
+			tasks, se.group_node) {
 		if (!can_migrate_task(p, env))
 			continue;
 
@@ -8190,6 +8222,8 @@ static int detach_tasks(struct lb_env *env)
 	unsigned long util, load;
 	struct task_struct *p;
 	int detached = 0;
+	int nr_imbalance = 0;
+	bool detach_idle = false;
 
 	lockdep_assert_rq_held(env->src_rq);
 
@@ -8205,6 +8239,9 @@ static int detach_tasks(struct lb_env *env)
 	if (env->imbalance <= 0)
 		return 0;
 
+	nr_imbalance = cfs_nr_tasks_imbalance(env);
+
+again:
 	while (!list_empty(tasks)) {
 		/*
 		 * We don't want to steal all, otherwise we may be treated likewise,
@@ -8234,6 +8271,10 @@ static int detach_tasks(struct lb_env *env)
 		if (!can_migrate_task(p, env))
 			goto next;
 
+		if (sched_feat(LB_PRIO) &&
+			!detach_idle && nr_imbalance < 1)
+			break;
+
 		switch (env->migration_type) {
 		case migrate_load:
 			/*
@@ -8286,6 +8327,9 @@ static int detach_tasks(struct lb_env *env)
 		detach_task(p, env);
 		list_add(&p->se.group_node, &env->tasks);
 
+		if (sched_feat(LB_PRIO) && !detach_idle)
+			nr_imbalance--;
+
 		detached++;
 
 #ifdef CONFIG_PREEMPTION
@@ -8310,6 +8354,30 @@ static int detach_tasks(struct lb_env *env)
 		list_move(&p->se.group_node, tasks);
 	}
 
+	if (sched_feat(LB_PRIO) && !detach_idle && env->imbalance > 0) {
+		/*
+		 * Try to migrate SCHED_IDLE tasks from src_rq->cfs_idle_tasks
+		 * to dst_rq if dst_rq is idle or sched idle. If dst_rq is
+		 * running with non-idle tasks, do not migrate SCHED_IDLE tasks.
+		 */
+		if (env->dst_rq->cfs.h_nr_running -
+			env->dst_rq->cfs.idle_h_nr_running == 0) {
+			detach_idle = true;
+			tasks = &env->src_rq->cfs_idle_tasks;
+			goto again;
+		}
+
+		/*
+		 * Finish load balancing if all src rq tasks have been
+		 * test and one more tasks migrated to dst CPU.
+		 * Clear LBF_ALL_PINNED flag as we will not test any task.
+		 */
+		if (detached && !(env->flags & LBF_NEED_BREAK)) {
+			env->imbalance = 0;
+			env->flags &= ~LBF_ALL_PINNED;
+		}
+	}
+
 	/*
 	 * Right now, this is one of only two places we collect this stat
 	 * so we can safely collect detach_one_task() stats here rather
@@ -11814,7 +11882,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
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

