Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265B86DA282
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbjDFUVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbjDFUVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:21:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1BB7EFA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680812459; x=1712348459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=DdFRQkiOjc9Y6S0ceyG8yplXHl7TzxjliO+zita68pM=;
  b=V1xkXA1D4qHei/wsZmBn1jP+GEvLeuA8DwI4wM+baonF34R+2KGzWFEx
   Onk/nEgOIkFsM6CanCWyRw/Y7Qv+/2feuaeeDvfoWD3KuBrYTYw+08Y96
   I97uKpwDkAxd1pz3t+ryItKU7g+x0vAXey8ESPASnUMyG7drzBc/AMfyI
   l3lfxARz6oyIk4ompYrCuPz6P9DZ27F19o+cbhD5blOxwIo1Dg6nyovkC
   AUrnUAD5nBFG8M191pLyZ4BVjYc8ODfo9pm1K9XjxxbAqjrUq4U+kNrqS
   pSoO3ml1FPrmb2w1jZayiyV2EJgi2BgxT4W0petDl7tbZ07t+HUnG0/jf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="407957706"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="407957706"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 13:20:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="861529869"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="861529869"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2023 13:20:57 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v4 02/12] sched/fair: Only do asym_packing load balancing from fully idle SMT cores
Date:   Thu,  6 Apr 2023 13:31:38 -0700
Message-Id: <20230406203148.19182-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
References: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When balancing load between cores, all the SMT siblings of the destination
CPU, if any, must be idle. Otherwise, pulling new tasks degrades the
throughput of the busy SMT siblings. The overall throughput of the system
remains the same.

When balancing load within an SMT core this consideration is not relevant.
Follow the priorities that hardware indicates.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Tested-by: Zhang Rui <rui.zhang@intel.com>
Suggested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * Improved the logic to determine whether CPU priority should be followed.
   Also, wrapped this logic in a helper function. (Vincent G./ Peter)
 * Used sched_smt_active() to avoid pointless calls of is_core_idle().
   (Dietmar)
 * Ensure that the core is idle in asym_active_balance(). (Tim)
 * Used sched_use_asym_prio() to check for fully idle SMT cores in
   sched_asym().
 * Removed check for fully idle core inside asym_smt_can_pull_tasks().
   Now such condition is verified outside the function.

Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 kernel/sched/fair.c | 60 +++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 57c106fa721d..ec7ddbfd1136 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9273,6 +9273,29 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
 
+/**
+ * sched_use_asym_prio - Check whether asym_packing priority must be used
+ * @sd:		The scheduling domain of the load balancing
+ * @cpu:	A CPU
+ *
+ * Always use CPU priority when balancing load between SMT siblings. When
+ * balancing load between cores, it is not sufficient that @cpu is idle. Only
+ * use CPU priority if the whole core is idle.
+ *
+ * Returns: True if the priority of @cpu must be followed. False otherwise.
+ */
+static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
+{
+#ifdef CONFIG_SCHED_SMT
+	if (!sched_smt_active())
+		return true;
+
+	return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
+#else
+	return true;
+#endif
+}
+
 /**
  * asym_smt_can_pull_tasks - Check whether the load balancing CPU can pull tasks
  * @dst_cpu:	Destination CPU of the load balancing
@@ -9283,6 +9306,9 @@ group_type group_classify(unsigned int imbalance_pct,
  * Check the state of the SMT siblings of both @sds::local and @sg and decide
  * if @dst_cpu can pull tasks.
  *
+ * This function must be called only if all the SMT siblings of @dst_cpu are
+ * idle, if any.
+ *
  * If @dst_cpu does not have SMT siblings, it can pull tasks if two or more of
  * the SMT siblings of @sg are busy. If only one CPU in @sg is busy, pull tasks
  * only if @dst_cpu has higher priority.
@@ -9292,8 +9318,7 @@ group_type group_classify(unsigned int imbalance_pct,
  * Bigger imbalances in the number of busy CPUs will be dealt with in
  * update_sd_pick_busiest().
  *
- * If @sg does not have SMT siblings, only pull tasks if all of the SMT siblings
- * of @dst_cpu are idle and @sg has lower priority.
+ * If @sg does not have SMT siblings, only pull tasks if @sg has lower priority.
  *
  * Return: true if @dst_cpu can pull tasks, false otherwise.
  */
@@ -9341,15 +9366,8 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
 		return false;
 	}
 
-	/*
-	 * @sg does not have SMT siblings. Ensure that @sds::local does not end
-	 * up with more than one busy SMT sibling and only pull tasks if there
-	 * are not busy CPUs (i.e., no CPU has running tasks).
-	 */
-	if (!sds->local_stat.sum_nr_running)
-		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
-
-	return false;
+	/* If we are here @dst_cpu has SMT siblings and are also idle. */
+	return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
 #else
 	/* Always return false so that callers deal with non-SMT cases. */
 	return false;
@@ -9360,7 +9378,11 @@ static inline bool
 sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
 	   struct sched_group *group)
 {
-	/* Only do SMT checks if either local or candidate have SMT siblings */
+	/* Ensure that the whole local core is idle, if applicable. */
+	if (!sched_use_asym_prio(env->sd, env->dst_cpu))
+		return false;
+
+	/* Only do SMT checks if either local or candidate have SMT siblings. */
 	if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
 	    (group->flags & SD_SHARE_CPUCAPACITY))
 		return asym_smt_can_pull_tasks(env->dst_cpu, sds, sgs, group);
@@ -10565,11 +10587,13 @@ static inline bool
 asym_active_balance(struct lb_env *env)
 {
 	/*
-	 * ASYM_PACKING needs to force migrate tasks from busy but
-	 * lower priority CPUs in order to pack all tasks in the
-	 * highest priority CPUs.
+	 * ASYM_PACKING needs to force migrate tasks from busy but lower
+	 * priority CPUs in order to pack all tasks in the highest priority
+	 * CPUs. When done between cores, do it only if the whole core if the
+	 * whole core is idle.
 	 */
 	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
+	       sched_use_asym_prio(env->sd, env->dst_cpu) &&
 	       sched_asym_prefer(env->dst_cpu, env->src_cpu);
 }
 
@@ -11304,9 +11328,13 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * When ASYM_PACKING; see if there's a more preferred CPU
 		 * currently idle; in which case, kick the ILB to move tasks
 		 * around.
+		 *
+		 * When balancing betwen cores, all the SMT siblings of the
+		 * preferred CPU must be idle.
 		 */
 		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
-			if (sched_asym_prefer(i, cpu)) {
+			if (sched_use_asym_prio(sd, i) &&
+			    sched_asym_prefer(i, cpu)) {
 				flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 				goto unlock;
 			}
-- 
2.25.1

