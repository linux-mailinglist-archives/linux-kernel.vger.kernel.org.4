Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4901672BB77
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjFLJB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjFLI7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:59:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99D94C2B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686560203; x=1718096203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1S7CEreYkujbhd8UXLiXtrj03LtBXe5debd6HtwHXho=;
  b=GcEZPIrRGacI3I17W2rC7nj3mQBvwWh+LQAcVmCusTO87SikRhKXCehv
   xxLKy8ZTZVx6yvRb8BTvkBloPnsVfW6VZDLPvbX2EndKBNXu9e2/3O7OT
   6m8B7Dm5XunbQyAYA9fNYVruQyRID+tcL06ESC47o20N+uTOFPWAFO8ni
   3m8gvos1gru4Yldf6Z//l6BQf7opYAB8H5Ca0mKqX3Suz2WC9ivjL6t/k
   4espuzwSAsYsL48rn8GoGW4UI/RilH6tWNNQ60o4vIT/JlQg9G5GknRac
   rkjVTh8u/k9MXuEiyQmJRfEB0NShff2PUyZ/pe2F8dXKSKIAAK0rI4z1u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="361339562"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="361339562"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 01:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="705297150"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="705297150"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orsmga007.jf.intel.com with ESMTP; 12 Jun 2023 01:23:28 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH 3/4] sched/fair: Calculate the scan depth for idle balance based on system utilization
Date:   Tue, 13 Jun 2023 00:18:57 +0800
Message-Id: <bc96b53efb712337a645e2c2a340975545ed5a28.1686554037.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686554037.git.yu.c.chen@intel.com>
References: <cover.1686554037.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU is about to enter idle, it invokes newidle_balance() to pull
some tasks from other runqueues. Although there is per domain
max_newidle_lb_cost to throttle the newidle_balance(), it would be
good to further limit the scan based on overall system utilization.
The reason is that there is no limitation for newidle_balance() to
launch this balance simultaneously on multiple CPUs. Since each
newidle_balance() has to traverse all the CPUs to calculate the
statistics one by one, this total time cost on newidle_balance()
could be O(n^2). This is not good for performance or power saving.

For example, sqlite has spent quite some time on newidle balance()
on Intel Sapphire Rapids, which has 2 x 56C/112T = 224 CPUs:
6.69%    0.09%  sqlite3     [kernel.kallsyms]   [k] newidle_balance
5.39%    4.71%  sqlite3     [kernel.kallsyms]   [k] update_sd_lb_stats

Based on this observation, limit the scan depth of newidle_balance()
by considering the utilization of the LLC domain. Let the number of
scanned groups be a linear function of the utilization ratio:

nr_groups_to_scan = nr_groups * (1 - util_ratio)

Besides, save the total_load, total_capacity of the current
sched domain in each periodic load balance. This statistic
can be reused later by CPU_NEWLY_IDLE load balance if it quits
the scan earlier. Introduce a sched feature ILB_UTIL to
control this.

Suggested-by: Tim Chen <tim.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched/topology.h |  4 ++++
 kernel/sched/fair.c            | 34 ++++++++++++++++++++++++++++++++++
 kernel/sched/features.h        |  1 +
 3 files changed, 39 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 1faececd5694..d7b2bac9bdf3 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -82,6 +82,10 @@ struct sched_domain_shared {
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
 	int		nr_idle_scan;
+	/* ilb scan depth and load balance statistic snapshot */
+	int		ilb_nr_scan;
+	unsigned long ilb_total_load;
+	unsigned long ilb_total_capacity;
 };
 
 struct sched_domain {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b3a24aead848..f999e838114e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10122,6 +10122,39 @@ static void update_idle_cpu_scan(struct lb_env *env,
 		WRITE_ONCE(sd_share->nr_idle_scan, (int)y);
 }
 
+static void update_ilb_group_scan(struct lb_env *env,
+				  unsigned long sum_util,
+				  struct sched_domain_shared *sd_share,
+				  struct sd_lb_stats *sds)
+{
+	u64 tmp, nr_scan;
+
+	if (!sched_feat(ILB_UTIL) || env->idle == CPU_NEWLY_IDLE)
+		return;
+
+	if (!sd_share)
+		return;
+	/*
+	 * Limit the newidle balance scan depth based on overall system
+	 * utilization:
+	 * nr_groups_scan = nr_groups * (1 - util_ratio)
+	 * and util_ratio = sum_util / (sd_weight * SCHED_CAPACITY_SCALE)
+	 */
+	nr_scan = env->sd->nr_groups * sum_util;
+	tmp = env->sd->span_weight * SCHED_CAPACITY_SCALE;
+	do_div(nr_scan, tmp);
+	nr_scan = env->sd->nr_groups - nr_scan;
+	if ((int)nr_scan != sd_share->ilb_nr_scan)
+		WRITE_ONCE(sd_share->ilb_nr_scan, (int)nr_scan);
+
+	/* Also save the statistic snapshot of the periodic load balance */
+	if (sds->total_load != sd_share->ilb_total_load)
+		WRITE_ONCE(sd_share->ilb_total_load, sds->total_load);
+
+	if (sds->total_capacity != sd_share->ilb_total_capacity)
+		WRITE_ONCE(sd_share->ilb_total_capacity, sds->total_capacity);
+}
+
 /**
  * update_sd_lb_stats - Update sched_domain's statistics for load balancing.
  * @env: The load balancing environment.
@@ -10200,6 +10233,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	}
 
 	update_idle_cpu_scan(env, sum_util, sd_share);
+	update_ilb_group_scan(env, sum_util, sd_share, sds);
 }
 
 /**
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..8f6e5b08408d 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -85,6 +85,7 @@ SCHED_FEAT(RT_PUSH_IPI, true)
 
 SCHED_FEAT(RT_RUNTIME_SHARE, false)
 SCHED_FEAT(LB_MIN, false)
+SCHED_FEAT(ILB_UTIL, true)
 SCHED_FEAT(ATTACH_AGE_LOAD, true)
 
 SCHED_FEAT(WA_IDLE, true)
-- 
2.25.1

