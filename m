Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48FE74B9BC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjGGW5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjGGW44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:56:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17611992
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688770615; x=1720306615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FpAHkI8xLSWqEP7PVVGD4WuKrAVFt/AYDCvhVA2Njec=;
  b=YNpKETcjCbhcRR9uwK34ZQCicxfZrrR9/UvFNZs3uChyx4vqqf9V7qbC
   kijiWvwgWePN/eWnw+aN0aVmufoVccOR8eEZN/gt1s5Y+GhTPfiMUabLZ
   2hGvnMsbJUfoB7ONab8LU/TIjnd+qo+E0xDL8r1g2wC5jSummbgk4aNFT
   MpQealJrJwZCQkyEhx79wBmZQv9CMoNoMmOL4qALAbgTM+79hP9moD/li
   EX0RasOpts7MDtTkjZW0kkwCMih4vyyPLsDEnAvaN5leDtk3w/K5gQMPB
   NOwYW1i7DLccCfWa9Oa0sN+gsyVNZ9zDobNhKIgpQjvEEdFERMrk5gwl0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="427683479"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="427683479"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 15:56:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="714176670"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="714176670"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orsmga007.jf.intel.com with ESMTP; 07 Jul 2023 15:56:55 -0700
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
Subject: [Patch v3 3/6] sched/fair: Implement prefer sibling imbalance calculation between asymmetric groups
Date:   Fri,  7 Jul 2023 15:57:02 -0700
Message-Id: <4eacbaa236e680687dae2958378a6173654113df.1688770494.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1688770494.git.tim.c.chen@linux.intel.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Adjust the sibling imbalance computation to take into account of the
above considerations.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f636d6c09dc6..f491b94908bf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9372,6 +9372,41 @@ static inline bool smt_balance(struct lb_env *env, struct sg_lb_stats *sgs,
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
+	if (env->idle == CPU_NOT_IDLE || !busiest->sum_nr_running)
+		return 0;
+
+	ncores_busiest = sds->busiest->cores;
+	ncores_local = sds->local->cores;
+
+	if (ncores_busiest == ncores_local) {
+		imbalance = busiest->sum_nr_running;
+		lsub_positive(&imbalance, local->sum_nr_running);
+		return imbalance;
+	}
+
+	/* Balance such that nr_running/ncores ratio are same on both groups */
+	imbalance = ncores_local * busiest->sum_nr_running;
+	lsub_positive(&imbalance, ncores_busiest * local->sum_nr_running);
+	/* Normalize imbalance and do rounding on normalization */
+	imbalance = 2 * imbalance + ncores_local + ncores_busiest;
+	imbalance /= ncores_local + ncores_busiest;
+
+	/* Take advantage of resource in an empty sched group */
+	if (imbalance == 0 && local->sum_nr_running == 0 &&
+	    busiest->sum_nr_running > 1)
+		imbalance = 2;
+
+	return imbalance;
+}
+
 static inline bool
 sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 {
@@ -10230,14 +10265,12 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
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
@@ -10424,7 +10457,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	 * group's child domain.
 	 */
 	if (sds.prefer_sibling && local->group_type == group_has_spare &&
-	    busiest->sum_nr_running > local->sum_nr_running + 1)
+	    sibling_imbalance(env, &sds, busiest, local) > 1)
 		goto force_balance;
 
 	if (busiest->group_type != group_overloaded) {
-- 
2.32.0

