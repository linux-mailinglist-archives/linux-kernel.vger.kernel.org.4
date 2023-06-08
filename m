Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D119A728B21
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbjFHWcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbjFHWcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:32:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A270E270B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686263533; x=1717799533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7eAAP7991uNBWg+O6GUgE2Ns9rNRI5BuolcHSrUaCvY=;
  b=XiLXPZpf4BdoEgFSUagrK8lrF8PvKm2TRpbUkyYENXVDfKmb8UnGF5dm
   gjU/KeplQd0t3GnCI6bDmVa5FTEfk/zMeywPIMAe36EUKwtszskegGg2n
   VKOfVao8gUzOmBZEL/XGSwBpmO3jS32Xtk+tMvG1f5mXko5D9L3xUZ2gH
   Xx+ccwgKKVN6XUanDh8RDwNHtVVUQKnwwpFdWkPQNvVS+cIwhCwL0Ldih
   dnK9QV0JzACx+1eUAWJSPB8+w8TuZVsqjpewstaDaa5ZUFN9epzXuyqjG
   vdtJlpJfBuj/SaSKEhRIiwTc7efbCotLQntOPl1t89vLuXC5+QBc5gz4d
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="347094700"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="347094700"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 15:32:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="956906439"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="956906439"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2023 15:32:11 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tim C Chen <tim.c.chen@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Subject: [Patch v2 1/6] sched/fair: Determine active load balance for SMT sched groups
Date:   Thu,  8 Jun 2023 15:32:27 -0700
Message-Id: <253f5272200d3cec3f24427262bb4e95244f681c.1686263351.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1686263351.git.tim.c.chen@linux.intel.com>
References: <cover.1686263351.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim C Chen <tim.c.chen@linux.intel.com>

On hybrid CPUs with scheduling cluster enabled, we will need to
consider balancing between SMT CPU cluster, and Atom core cluster.

Below shows such a hybrid x86 CPU with 4 big cores and 8 atom cores.
Each scheduling cluster span a L2 cache.

          --L2-- --L2-- --L2-- --L2-- ----L2---- -----L2------
          [0, 1] [2, 3] [4, 5] [5, 6] [7 8 9 10] [11 12 13 14]
          Big    Big    Big    Big    Atom       Atom
          core   core   core   core   Module     Module

If the busiest group is a big core with both SMT CPUs busy, we should
active load balance if destination group has idle CPU cores.  Such
condition is considered by asym_active_balance() in load balancing but not
considered when looking for busiest group and computing load imbalance.
Add this consideration in find_busiest_group() and calculate_imbalance().

In addition, update the logic determining the busier group when one group
is SMT and the other group is non SMT but both groups are partially busy
with idle CPU. The busier group should be the group with idle cores rather
than the group with one busy SMT CPU.  We do not want to make the SMT group
the busiest one to pull the only task off SMT CPU and causing the whole core to
go empty.

Otherwise suppose in the search for the busiest group, we first encounter
an SMT group with 1 task and set it as the busiest.  The desitination
group is an atom cluster with 1 task and we next encounter an atom
cluster group with 3 tasks, we will not pick this atom cluster over the
SMT group, even though we should.  As a result, we do not load balance
the busier Atom cluster (with 3 tasks) towards the local atom cluster
(with 1 task).  And it doesn't make sense to pick the 1 task SMT group
as the busier group as we also should not pull task off the SMT towards
the 1 task atom cluster and make the SMT core completely empty.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 70 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 87317634fab2..03573362274f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8279,6 +8279,11 @@ enum group_type {
 	 * more powerful CPU.
 	 */
 	group_misfit_task,
+	/*
+	 * Balance SMT group that's fully busy. Can benefit from migration
+	 * a task on SMT with busy sibling to another CPU on idle core.
+	 */
+	group_smt_balance,
 	/*
 	 * SD_ASYM_PACKING only: One local CPU with higher capacity is available,
 	 * and the task should be migrated to it instead of running on the
@@ -8987,6 +8992,7 @@ struct sg_lb_stats {
 	unsigned int group_weight;
 	enum group_type group_type;
 	unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
+	unsigned int group_smt_balance;  /* Task on busy SMT be moved */
 	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
@@ -9260,6 +9266,9 @@ group_type group_classify(unsigned int imbalance_pct,
 	if (sgs->group_asym_packing)
 		return group_asym_packing;
 
+	if (sgs->group_smt_balance)
+		return group_smt_balance;
+
 	if (sgs->group_misfit_task_load)
 		return group_misfit_task;
 
@@ -9333,6 +9342,36 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
 	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
 }
 
+/* One group has more than one SMT CPU while the other group does not */
+static inline bool smt_vs_nonsmt_groups(struct sched_group *sg1,
+				    struct sched_group *sg2)
+{
+	if (!sg1 || !sg2)
+		return false;
+
+	return (sg1->flags & SD_SHARE_CPUCAPACITY) !=
+		(sg2->flags & SD_SHARE_CPUCAPACITY);
+}
+
+static inline bool smt_balance(struct lb_env *env, struct sg_lb_stats *sgs,
+			       struct sched_group *group)
+{
+	if (env->idle == CPU_NOT_IDLE)
+		return false;
+
+	/*
+	 * For SMT source group, it is better to move a task
+	 * to a CPU that doesn't have multiple tasks sharing its CPU capacity.
+	 * Note that if a group has a single SMT, SD_SHARE_CPUCAPCITY
+	 * will not be on.
+	 */
+	if (group->flags & SD_SHARE_CPUCAPACITY &&
+	    sgs->sum_h_nr_running > 1)
+		return true;
+
+	return false;
+}
+
 static inline bool
 sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 {
@@ -9425,6 +9464,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->group_asym_packing = 1;
 	}
 
+	/* Check for loaded SMT group to be balanced to dst CPU */
+	if (!local_group && smt_balance(env, sgs, group))
+		sgs->group_smt_balance = 1;
+
 	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
 
 	/* Computing avg_load makes sense only when group is overloaded */
@@ -9509,6 +9552,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 			return false;
 		break;
 
+	case group_smt_balance:
 	case group_fully_busy:
 		/*
 		 * Select the fully busy group with highest avg_load. In
@@ -9537,6 +9581,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 		break;
 
 	case group_has_spare:
+		/*
+		 * Do not pick sg with SMT CPUs over sg with pure CPUs,
+		 * as we do not want to pull task off half empty SMT core
+		 * and make the core idle.
+		 */
+		if (smt_vs_nonsmt_groups(sds->busiest, sg)) {
+			if (sg->flags & SD_SHARE_CPUCAPACITY)
+				return false;
+			else
+				return true;
+		}
+
 		/*
 		 * Select not overloaded group with lowest number of idle cpus
 		 * and highest number of running tasks. We could also compare
@@ -9733,6 +9789,7 @@ static bool update_pick_idlest(struct sched_group *idlest,
 
 	case group_imbalanced:
 	case group_asym_packing:
+	case group_smt_balance:
 		/* Those types are not used in the slow wakeup path */
 		return false;
 
@@ -9864,6 +9921,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 
 	case group_imbalanced:
 	case group_asym_packing:
+	case group_smt_balance:
 		/* Those type are not used in the slow wakeup path */
 		return NULL;
 
@@ -10118,6 +10176,13 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		return;
 	}
 
+	if (busiest->group_type == group_smt_balance) {
+		/* Reduce number of tasks sharing CPU capacity */
+		env->migration_type = migrate_task;
+		env->imbalance = 1;
+		return;
+	}
+
 	if (busiest->group_type == group_imbalanced) {
 		/*
 		 * In the group_imb case we cannot rely on group-wide averages
@@ -10371,6 +10436,11 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 			 */
 			goto out_balanced;
 
+		if (busiest->group_type == group_smt_balance &&
+		    smt_vs_nonsmt_groups(sds.local, sds.busiest))
+			/* Let non SMT CPU pull from SMT CPU sharing with sibling */
+			goto force_balance;
+
 		if (busiest->group_weight > 1 &&
 		    local->idle_cpus <= (busiest->idle_cpus + 1))
 			/*
-- 
2.32.0

