Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA7368CE61
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjBGEvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBGEuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:50:50 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784574236
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675745449; x=1707281449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=fNzFE8GHMV6lK6aBMJxB809+PnuCf6ZrTheiPPiWiEE=;
  b=Addoqy/WC6wa3n4JwXifYlMPFB/MmaXzJTJtb0yCk84Kj0cRFkcFazm3
   aXO6LUMxUKGY7yARJUDwVOXMFkgfqRPN4cKo7MlJnOqeq2jTnx/xsuBsO
   qMKjo2izp3EyTXVVHOzD3JkVLEK50TjdXaeNmmWZo7hWXD+9wngNjmRpl
   NmCwSPCdpz9zWE6Ee35qVNxJRtPR0auGsa+EBJW3zO5+rF/X2twrH4vgm
   oQ25dcqFhx69CZHi8X2zUumCXs7pjwoZIu0Nqiafi/A3JhXiwrNTx6b01
   EzE4PDD3RUYBMZ5ZUrQWTaRczij6TqkTkWYj1U3Fljc6Me5mGYE6h1Y4S
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415624032"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415624032"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 20:50:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668653799"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668653799"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 20:50:47 -0800
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
Subject: [PATCH v3 07/10] sched/fair: Do not even the number of busy CPUs via asym_packing
Date:   Mon,  6 Feb 2023 20:58:35 -0800
Message-Id: <20230207045838.11243-8-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Simplify asym_smt_can_pull_tasks() accordingly.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 kernel/sched/fair.c | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a37ad59f20ea..0ada2d18b934 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9247,20 +9247,15 @@ group_type group_classify(unsigned int imbalance_pct,
  * @sgs:	Load-balancing statistics of the candidate busiest group
  * @sg:		The candidate busiest group
  *
- * Check the state of the SMT siblings of both @sds::local and @sg and decide
- * if @dst_cpu can pull tasks.
+ * Check the state of the SMT siblings of @sg and decide if @dst_cpu can pull
+ * tasks.
  *
  * This function must be called only if all the SMT siblings of @dst_cpu are
  * idle, if any.
  *
- * If @dst_cpu does not have SMT siblings, it can pull tasks if two or more of
- * the SMT siblings of @sg are busy. If only one CPU in @sg is busy, pull tasks
- * only if @dst_cpu has higher priority.
- *
- * If @dst_cpu has SMT siblings, decide based on the priority of @sg. Do it only
- * if @sg has exactly one busy CPU (i.e., one more than @sds::local). Bigger
- * imbalances in the number of busy CPUs will be dealt with in
- * find_busiest_group().
+ * @dst_cpu can pull tasks if @sg has exactly one busy CPU (i.e., one more than
+ * @sds::local) and has lower group priority than @sds::local. Bigger imbalances
+ * in the number of busy CPUs will be dealt with in find_busiest_group().
  *
  * Return: true if @dst_cpu can pull tasks, false otherwise.
  */
@@ -9269,33 +9264,11 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
 				    struct sched_group *sg)
 {
 #ifdef CONFIG_SCHED_SMT
-	bool local_is_smt;
 	int sg_busy_cpus;
 
-	local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
 	sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
 
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
 	/*
-	 * @dst_cpu has SMT siblings and are also idle.
-	 *
 	 * If the difference in the number of busy CPUs is two or more, let
 	 * find_busiest_group() take care of it. We only care if @sg has
 	 * exactly one busy CPU. This covers SMT and non-SMT sched groups.
-- 
2.25.1

