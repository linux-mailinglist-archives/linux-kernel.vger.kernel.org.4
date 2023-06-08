Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB748728B23
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbjFHWc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237142AbjFHWcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:32:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC03C2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686263537; x=1717799537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bxF4ml+2B8CLxSOfFJcQMgzgf08hlb1xTj0M9Ps/3+U=;
  b=e3EB2gwQfBe0ZP648wLyitcM+HJdh5obYl70+wPOlAt0M+xn25/YBE8z
   Adi7lEj/ooIFUCJseHlVmVgZq8EgGHCeQLksPqLWm6YWn20UmsysFvx4J
   pt8dveoY3OQ1eK6rCCPwrFs7IPFajVsk4xDi+r/w00ahMMyV/86yKz0++
   jFmaIKuQIXsi/oaX5OkLT2Hka0L6JbwPrcKa/rSSL/6pHrfNSzom/g454
   wabDbYCicYWkUC96JJqxfVZKnUC+041e4w7m1SOYB5Hfht7gctkjuL8uq
   +WPE6ND795WEqX+y0x9qmi8yCHgMqA4Tqiycvk07Ac5b+t+BeEl8gfSXH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="347094742"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="347094742"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 15:32:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="956906448"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="956906448"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2023 15:32:15 -0700
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
Subject: [Patch v2 3/6] sched/fair: Implement prefer sibling imbalance calculation between asymmetric groups
Date:   Thu,  8 Jun 2023 15:32:29 -0700
Message-Id: <ef2400ea29f0e00aed1e2d75c1a352e63349059e.1686263351.git.tim.c.chen@linux.intel.com>
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

In the current prefer sibling load balancing code, there is an implicit
assumption that the busiest sched group and local sched group are
equivalent, hence the tasks to be moved is simply the difference in
number of tasks between the two groups (i.e. imbalance) divided by two.

However, we may have different number of cores between the cluster groups,
say when we take CPU offline or we have hybrid groups.  In that case,
we should balance between the two groups such that #tasks/#cores ratio
is the same between the same between both groups.  Hence the imbalance
computed will need to reflect this.

Additionally when we have asymmetric packing, we will need to bias the
balancing according to whether the busiest group is favored or the local
group if favored.  If the destination group is favored and has idle
cores, we should move at least one task from the busiest group to avoid
leaving favored idle core unused.  But if the busiest group is favored,
we should limit the number of tasks we move so we will not create idle
cores in busiest group, leaving favored cores unused.

Adjust the sibling imbalance computation to take into account of the
above considerations.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c  | 65 +++++++++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h |  5 ++++
 2 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03573362274f..0b0904263d51 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9372,6 +9372,65 @@ static inline bool smt_balance(struct lb_env *env, struct sg_lb_stats *sgs,
 	return false;
 }
 
+static inline long sibling_imbalance(struct lb_env *env,
+				    struct sd_lb_stats *sds,
+				    struct sg_lb_stats *busiest,
+				    struct sg_lb_stats *local)
+{
+	int ncores_busiest, ncores_local;
+	long imbalance;
+
+	if (env->idle == CPU_NOT_IDLE)
+		return 0;
+
+	ncores_busiest = sds->busiest->cores;
+	ncores_local = sds->local->cores;
+
+	if (ncores_busiest == ncores_local &&
+	    (!(env->sd->flags & SD_ASYM_PACKING) ||
+	      sched_asym_equal(env->dst_cpu,
+			      sds->busiest->asym_prefer_cpu))) {
+		imbalance = busiest->sum_nr_running;
+		lsub_positive(&imbalance, local->sum_nr_running);
+		return imbalance;
+	}
+
+	/* Balance such that nr_running/ncores ratio are same on both groups */
+	imbalance = ncores_local * busiest->sum_nr_running;
+	lsub_positive(&imbalance, ncores_busiest * local->sum_nr_running);
+	/* Normalize imbalance to become tasks to be moved to restore balance */
+	imbalance /= ncores_local + ncores_busiest;
+
+	if (env->sd->flags & SD_ASYM_PACKING) {
+		int limit;
+
+		if (!busiest->sum_nr_running)
+			goto out;
+
+		if (sched_asym_prefer(env->dst_cpu, sds->busiest->asym_prefer_cpu)) {
+			/* Don't leave preferred core idle */
+			if (imbalance == 0 && local->sum_nr_running < ncores_local)
+				imbalance = 1;
+			goto out;
+		}
+
+		/* Limit tasks moved from preferred group, don't leave cores idle */
+		limit = busiest->sum_nr_running;
+		lsub_positive(&limit, ncores_busiest);
+		if (imbalance > limit)
+			imbalance = limit;
+
+		goto out;
+	}
+
+	/* Take advantage of resource in an empty sched group */
+	if (imbalance == 0 && local->sum_nr_running == 0 &&
+	    busiest->sum_nr_running > 1)
+		imbalance = 1;
+out:
+	return imbalance << 1;
+}
+
 static inline bool
 sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 {
@@ -10230,14 +10289,12 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		}
 
 		if (busiest->group_weight == 1 || sds->prefer_sibling) {
-			unsigned int nr_diff = busiest->sum_nr_running;
 			/*
 			 * When prefer sibling, evenly spread running tasks on
 			 * groups.
 			 */
 			env->migration_type = migrate_task;
-			lsub_positive(&nr_diff, local->sum_nr_running);
-			env->imbalance = nr_diff;
+			env->imbalance = sibling_imbalance(env, sds, busiest, local);
 		} else {
 
 			/*
@@ -10424,7 +10481,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	 * group's child domain.
 	 */
 	if (sds.prefer_sibling && local->group_type == group_has_spare &&
-	    busiest->sum_nr_running > local->sum_nr_running + 1)
+	    sibling_imbalance(env, &sds, busiest, local) > 1)
 		goto force_balance;
 
 	if (busiest->group_type != group_overloaded) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5f7f36e45b87..adffe0894cdb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -804,6 +804,11 @@ static inline bool sched_asym_prefer(int a, int b)
 	return arch_asym_cpu_priority(a) > arch_asym_cpu_priority(b);
 }
 
+static inline bool sched_asym_equal(int a, int b)
+{
+	return arch_asym_cpu_priority(a) == arch_asym_cpu_priority(b);
+}
+
 struct perf_domain {
 	struct em_perf_domain *em_pd;
 	struct perf_domain *next;
-- 
2.32.0

