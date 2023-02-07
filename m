Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F282768CE5A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjBGEux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBGEus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:50:48 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C793E4224
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675745446; x=1707281446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=NHwRQom2Hnt0ENynqej3UWEaK2X2qGGXakLIKRH9HWo=;
  b=YHminuoJPXwQ006sZy5NSdn0kTaGQqHBJjCzInTDnixDyFOXIY4jurnE
   Y4hNRN7xYCRpigLCpuNTWbpyrFnggAf5nXVsHzpKvs9O4RV3kIeSoCmL7
   tK9RHlD9zhUpvSFj5WuvWahdlK1VIW2zTPqBEZN9c8o/SnLWOdoxZ1mPq
   US4O5kxrtcgDUKcr+NgSPMiuMEtCMtyW5z8hIAS5DZ+PEzhVdZF7ABuNT
   6liUYq3SoDosbkQfHTIfEXcFa5EZK4tp6CJIwtDQp2TR1dHqrGPXdJ/If
   KfEWQ0dx2KhOm73KrgkNXtLmtGp3rbloa1RG4Gep/oLjYJpT0d54xrR+R
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415623976"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415623976"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 20:50:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668653779"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668653779"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 20:50:45 -0800
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
Subject: [PATCH v3 01/10] sched/fair: Generalize asym_packing logic for SMT cores
Date:   Mon,  6 Feb 2023 20:58:29 -0800
Message-Id: <20230207045838.11243-2-ricardo.neri-calderon@linux.intel.com>
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

When doing asym_packing load balancing between cores, all we care is that
the destination core is fully idle (including SMT siblings, if any) and
that the busiest candidate scheduling group has exactly one busy CPU. It is
irrelevant whether the candidate busiest core is non-SMT, SMT2, SMT4, SMT8,
etc.

Do not handle the candidate busiest non-SMT vs SMT cases separately. Simply
do the two checks described above. Let find_busiest_group() handle bigger
imbalances in the number of idle CPUs.

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
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 * Updated documentation of the function to reflect the new behavior.
   (Dietmar)

Changes since v1:
 * Reworded commit message and inline comments for clarity.
 * Stated that this changeset does not impact SMT4 or SMT8.
---
 kernel/sched/fair.c | 41 ++++++++++++++---------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7c46485d65d7..df46e06c9a3e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9254,13 +9254,11 @@ group_type group_classify(unsigned int imbalance_pct,
  * the SMT siblings of @sg are busy. If only one CPU in @sg is busy, pull tasks
  * only if @dst_cpu has higher priority.
  *
- * If both @dst_cpu and @sg have SMT siblings, and @sg has exactly one more
- * busy CPU than @sds::local, let @dst_cpu pull tasks if it has higher priority.
- * Bigger imbalances in the number of busy CPUs will be dealt with in
- * update_sd_pick_busiest().
- *
- * If @sg does not have SMT siblings, only pull tasks if all of the SMT siblings
- * of @dst_cpu are idle and @sg has lower priority.
+ * If @dst_cpu has SMT siblings, check if there are no running tasks in
+ * @sds::local. In such case, decide based on the priority of @sg. Do it only
+ * if @sg has exactly one busy CPU (i.e., one more than @sds::local). Bigger
+ * imbalances in the number of busy CPUs will be dealt with in
+ * find_busiest_group().
  *
  * Return: true if @dst_cpu can pull tasks, false otherwise.
  */
@@ -9269,12 +9267,10 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
 				    struct sched_group *sg)
 {
 #ifdef CONFIG_SCHED_SMT
-	bool local_is_smt, sg_is_smt;
+	bool local_is_smt;
 	int sg_busy_cpus;
 
 	local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
-	sg_is_smt = sg->flags & SD_SHARE_CPUCAPACITY;
-
 	sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
 
 	if (!local_is_smt) {
@@ -9295,25 +9291,16 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
 		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
 	}
 
-	/* @dst_cpu has SMT siblings. */
-
-	if (sg_is_smt) {
-		int local_busy_cpus = sds->local->group_weight -
-				      sds->local_stat.idle_cpus;
-		int busy_cpus_delta = sg_busy_cpus - local_busy_cpus;
-
-		if (busy_cpus_delta == 1)
-			return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
-
-		return false;
-	}
-
 	/*
-	 * @sg does not have SMT siblings. Ensure that @sds::local does not end
-	 * up with more than one busy SMT sibling and only pull tasks if there
-	 * are not busy CPUs (i.e., no CPU has running tasks).
+	 * @dst_cpu has SMT siblings. Do asym_packing load balancing only if
+	 * all its siblings are idle (moving tasks between physical cores in
+	 * which some SMT siblings are busy results in the same throughput).
+	 *
+	 * If the difference in the number of busy CPUs is two or more, let
+	 * find_busiest_group() take care of it. We only care if @sg has
+	 * exactly one busy CPU. This covers SMT and non-SMT sched groups.
 	 */
-	if (!sds->local_stat.sum_nr_running)
+	if (sg_busy_cpus == 1 && !sds->local_stat.sum_nr_running)
 		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
 
 	return false;
-- 
2.25.1

