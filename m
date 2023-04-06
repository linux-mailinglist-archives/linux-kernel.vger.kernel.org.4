Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8286DA287
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbjDFUVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbjDFUVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:21:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EDA8A5B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680812461; x=1712348461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8nxyT2jlCl4Hj6IKaR894UFCgRcVs1nGWqarnXJY6mw=;
  b=AGf/ZrJ8a6md1wWoZe15gKZyxUhMf2tDg+x+r0hyOtL+hEh1bWHPGzqf
   cZztssQISNypBR/E8cYltO35CnW4FF1ScO9IYRvdR8HL08roxdtmkcDOo
   oYxNYe7EF/hysef7J7PXfuO0N22jhGH9ioEMY0YQl9zP46JQfSVzMMTLg
   SLnA4cQ4/owXbGrDdp6ZCogKSDJAk23dh/1vpgi1nvWsSWjQAXNLkmtv7
   jgPOWdJU0irn2NloAZpO1EM8kTYYNU33ByO7H9RKnqDSD9rFYAIEh3aoq
   p6woon2LVdv7RBtumi0gO05DeI8RRCnQfDO6LaV50FXQflU+ZlyH/G7cW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="407957772"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="407957772"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 13:21:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="861529886"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="861529886"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2023 13:21:00 -0700
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
Subject: [PATCH v4 07/12] sched/fair: Do not even the number of busy CPUs via asym_packing
Date:   Thu,  6 Apr 2023 13:31:43 -0700
Message-Id: <20230406203148.19182-8-ricardo.neri-calderon@linux.intel.com>
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

Now that find_busiest_group() triggers load balancing between a fully_
busy SMT2 core and an idle non-SMT core, it is no longer needed to force
balancing via asym_packing. Use asym_packing only as intended: when there
is high-priority CPU that is idle.

After this change, the same logic apply to SMT and non-SMT local groups.
It makes less sense having a separate function to deal specifically with
SMT. Fold the logic in asym_smt_can_pull_tasks() into sched_asym().

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
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * Removed unnecessary local variable sg_busy_cpus.
 * Folded asym_smt_can_pull_tasks() into sched_asym() and simplify
   further. (Dietmar)

Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 kernel/sched/fair.c | 86 +++++++++++----------------------------------
 1 file changed, 21 insertions(+), 65 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 477cb5777036..145ca52f9629 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9297,74 +9297,26 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 }
 
 /**
- * asym_smt_can_pull_tasks - Check whether the load balancing CPU can pull tasks
- * @dst_cpu:	Destination CPU of the load balancing
+ * sched_asym - Check if the destination CPU can do asym_packing load balance
+ * @env:	The load balancing environment
  * @sds:	Load-balancing data with statistics of the local group
  * @sgs:	Load-balancing statistics of the candidate busiest group
- * @sg:		The candidate busiest group
+ * @group:	The candidate busiest group
  *
- * Check the state of the SMT siblings of both @sds::local and @sg and decide
- * if @dst_cpu can pull tasks.
+ * @env::dst_cpu can do asym_packing if it has higher priority than the
+ * preferred CPU of @group.
  *
- * This function must be called only if all the SMT siblings of @dst_cpu are
- * idle, if any.
+ * SMT is a special case. If we are balancing load between cores, @env::dst_cpu
+ * can do asym_packing balance only if all its SMT siblings are idle. Also, it
+ * can only do it if @group is an SMT group and has exactly on busy CPU. Larger
+ * imbalances in the number of CPUS are dealt with in find_busiest_group().
  *
- * If @dst_cpu does not have SMT siblings, it can pull tasks if two or more of
- * the SMT siblings of @sg are busy. If only one CPU in @sg is busy, pull tasks
- * only if @dst_cpu has higher priority.
+ * If we are balancing load within an SMT core, or at DIE domain level, always
+ * proceed.
  *
- * When dealing with SMT cores, only use priorities if the SMT core has exactly
- * one busy sibling. find_busiest_group() will handle bigger imbalances in the
- * number of busy CPUs.
- *
- * Return: true if @dst_cpu can pull tasks, false otherwise.
+ * Return: true if @env::dst_cpu can do with asym_packing load balance. False
+ * otherwise.
  */
-static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
-				    struct sg_lb_stats *sgs,
-				    struct sched_group *sg)
-{
-#ifdef CONFIG_SCHED_SMT
-	bool local_is_smt;
-	int sg_busy_cpus;
-
-	local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
-	sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
-
-	if (!local_is_smt) {
-		/*
-		 * If we are here, @dst_cpu is idle and does not have SMT
-		 * siblings. Pull tasks if candidate group has two or more
-		 * busy CPUs.
-		 */
-		if (sg_busy_cpus >= 2) /* implies sg_is_smt */
-			return true;
-
-		/*
-		 * @dst_cpu does not have SMT siblings. @sg may have SMT
-		 * siblings and only one is busy. In such case, @dst_cpu
-		 * can help if it has higher priority and is idle (i.e.,
-		 * it has no running tasks).
-		 */
-		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
-	}
-
-	/*
-	 * If we are here @dst_cpu has SMT siblings and are also idle.
-	 *
-	 * CPU priorities does not make sense for SMT cores with more than one
-	 * busy sibling.
-	 */
-	if (group->flags & SD_SHARE_CPUCAPACITY && sg_busy_cpus != 1)
-		return false;
-
-	return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
-
-#else
-	/* Always return false so that callers deal with non-SMT cases. */
-	return false;
-#endif
-}
-
 static inline bool
 sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
 	   struct sched_group *group)
@@ -9373,10 +9325,14 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
 	if (!sched_use_asym_prio(env->sd, env->dst_cpu))
 		return false;
 
-	/* Only do SMT checks if either local or candidate have SMT siblings. */
-	if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
-	    (group->flags & SD_SHARE_CPUCAPACITY))
-		return asym_smt_can_pull_tasks(env->dst_cpu, sds, sgs, group);
+	/*
+	 * CPU priorities does not make sense for SMT cores with more than one
+	 * busy sibling.
+	 */
+	if (group->flags & SD_SHARE_CPUCAPACITY) {
+		if (sgs->group_weight - sgs->idle_cpus != 1)
+			return false;
+	}
 
 	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
 }
-- 
2.25.1

