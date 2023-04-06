Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851FA6DA283
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbjDFUVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238914AbjDFUVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:21:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A7D7290
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680812460; x=1712348460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=T7YcPvoqJl/ysW/iYHGXA37dyyCN2NzIcKZ5yP9G8sU=;
  b=Pwwu+MM57QSWnnkKuzR7wqcvhgM1pSQnPweIv3w0PiD+rlmYmnQKnX2R
   O9mOAEpSzKQRQEsUiA6lDlXMde2KXQIrYx/JIQjuN3zr6XLBaj8Q10iqz
   1yomnnF0AQdFRzxNuRiEyZqE0xifMuO3EN5prc5KYI2/qvvgCpol8zep/
   mdJVUB056L+FN/pL9iSZR7IIGe4bR/vqjo6iqe1vOOsdKBzP1JDbptsn0
   F/X4Ir0Mtxv2RufhkqZolAUFb04T++QBoc7nzIlIUJHCJiurCCnpTJ5xp
   lEeObK5iKiTf4b/+baCBg0RLkzu3BbijgiOm/y2O4kGn32BvvHTH5IFQY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="407957718"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="407957718"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 13:20:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="861529872"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="861529872"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2023 13:20:58 -0700
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
Subject: [PATCH v4 03/12] sched/fair: Simplify asym_packing logic for SMT cores
Date:   Thu,  6 Apr 2023 13:31:39 -0700
Message-Id: <20230406203148.19182-4-ricardo.neri-calderon@linux.intel.com>
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

Callers of asym_smt_can_pull_tasks() check the idle state of the
destination CPU and its SMT siblings, if any. No extra checks are needed
in such function.

Since SMT cores divide capacity among its siblings, priorities only really
make sense if only one sibling is active. This is true for SMT2, SMT4,
SMT8, etc. Do not use asym_packing load balance for this case. Instead,
let find_busiest_group() handle imbalances.

When balancing non-SMT cores or at higher scheduling domains (e.g.,
between MC scheduling groups), continue using priorities.

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
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * Dropped checks for a destination SMT core.
 * Limited the check of a single busy CPU to SMT cores. This fixes a bug
   when balancing between MC scheduling groups of different priority.

Changes since v2:
 * Updated documentation of the function to reflect the new behavior.
   (Dietmar)

Changes since v1:
 * Reworded commit message and inline comments for clarity.
 * Stated that this changeset does not impact SMT4 or SMT8.
---
 kernel/sched/fair.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ec7ddbfd1136..b6bbe0300635 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9313,12 +9313,9 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
  * the SMT siblings of @sg are busy. If only one CPU in @sg is busy, pull tasks
  * only if @dst_cpu has higher priority.
  *
- * If both @dst_cpu and @sg have SMT siblings, and @sg has exactly one more
- * busy CPU than @sds::local, let @dst_cpu pull tasks if it has higher priority.
- * Bigger imbalances in the number of busy CPUs will be dealt with in
- * update_sd_pick_busiest().
- *
- * If @sg does not have SMT siblings, only pull tasks if @sg has lower priority.
+ * When dealing with SMT cores, only use priorities if the SMT core has exactly
+ * one busy sibling. find_busiest_group() will handle bigger imbalances in the
+ * number of busy CPUs.
  *
  * Return: true if @dst_cpu can pull tasks, false otherwise.
  */
@@ -9327,12 +9324,10 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
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
@@ -9353,21 +9348,17 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
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
+	/*
+	 * If we are here @dst_cpu has SMT siblings and are also idle.
+	 *
+	 * CPU priorities does not make sense for SMT cores with more than one
+	 * busy sibling.
+	 */
+	if (group->flags & SD_SHARE_CPUCAPACITY && sg_busy_cpus != 1)
 		return false;
-	}
 
-	/* If we are here @dst_cpu has SMT siblings and are also idle. */
 	return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
+
 #else
 	/* Always return false so that callers deal with non-SMT cases. */
 	return false;
-- 
2.25.1

