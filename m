Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B0A72D871
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjFMEW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbjFMEVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:21:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D411C10EB;
        Mon, 12 Jun 2023 21:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630105; x=1718166105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=A62nET/Lf8LbzlAZNd4yBxD9o9MCsRJYPyzWWZ16rDc=;
  b=GI0HxolQlR8+6FwbiiYa2ntvcEhxe8p7lSSlXgmYva3ALuvoQsvj1hMp
   CKr4QbSz1XAE+YaXvVPh8EHCEoPbA1IP7dxfz+1IdWBsZKK3Ztgj8phC5
   rnhSewZKTTUrZHo/VLeyheDvUgYosNiHG0KowgP2oucfSKgCZ4HK/iADQ
   fUNJnHl+CK2NlaVzVrM8XTjMdqfeCEmpTcQoUtCYgHK/3MyBPxexyVmw4
   W1OnRr6XJhpAWQH0rTQ8Zy1Guh9kMW1LiQa+dOI7vaGUyqaD8SZqmkVDf
   heB55PUo/avw2RY62bIJTw7XfuBuyInDpWf5OdzpPCYYbJGKjUGErOQyJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222119"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222119"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:21:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661854956"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661854956"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:21:44 -0700
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
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Zhao Liu <zhao1.liu@linux.intel.com>
Subject: [PATCH v4 08/24] sched/fair: Use IPCC stats to break ties between asym_packing sched groups
Date:   Mon, 12 Jun 2023 21:24:06 -0700
Message-Id: <20230613042422.5344-9-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_sd_pick_busiest() selects as busiest the candidate group passed to
it as argument if it has the same priority as the current busiest. Either
group is a good choice. IPCC statistics reflect the class of work on a
scheduling group. Use this data to break the priority tie between the
candidate and current busiest groups.

Pick as busiest the scheduling group that yields a higher IPCC score
after load balancing.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Perry Yuan <Perry.Yuan@amd.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * None

Changes since v2:
 * None

Changes since v1:
 * Added a comment to clarify why sched_asym_prefer() needs a tie breaker
   only in update_sd_pick_busiest(). (PeterZ)
 * Renamed functions for accuracy:
   sched_asym_class_prefer() >> sched_asym_ipcc_prefer()
   sched_asym_class_pick() >> sched_asym_ipcc_pick()
 * Reworded commit message for clarity.
---
 kernel/sched/fair.c | 72 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a51c65c9335f..fb3d793fe9ad 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9510,6 +9510,60 @@ static void update_sg_lb_stats_scores(struct sg_lb_stats *sgs,
 	sgs->ipcc_score_before = before;
 }
 
+/**
+ * sched_asym_ipcc_prefer - Select a sched group based on its IPCC score
+ * @a:	Load balancing statistics of a sched group
+ * @b:	Load balancing statistics of a second sched group
+ *
+ * Returns: true if @a has a higher IPCC score than @b after load balance.
+ * False otherwise.
+ */
+static bool sched_asym_ipcc_prefer(struct sg_lb_stats *a,
+				   struct sg_lb_stats *b)
+{
+	if (!sched_ipcc_enabled())
+		return false;
+
+	/* @a increases overall throughput after load balance. */
+	if (a->ipcc_score_after > b->ipcc_score_after)
+		return true;
+
+	/*
+	 * If @a and @b yield the same overall throughput, pick @a if
+	 * its current throughput is lower than that of @b.
+	 */
+	if (a->ipcc_score_after == b->ipcc_score_after)
+		return a->ipcc_score_before < b->ipcc_score_before;
+
+	return false;
+}
+
+/**
+ * sched_asym_ipcc_pick - Select a sched group based on its IPCC score
+ * @a:		A scheduling group
+ * @b:		A second scheduling group
+ * @a_stats:	Load balancing statistics of @a
+ * @b_stats:	Load balancing statistics of @b
+ *
+ * Returns: true if @a has the same priority and @a has tasks with IPC classes
+ * that yield higher overall throughput after load balance. False otherwise.
+ */
+static bool sched_asym_ipcc_pick(struct sched_group *a,
+				 struct sched_group *b,
+				 struct sg_lb_stats *a_stats,
+				 struct sg_lb_stats *b_stats)
+{
+	/*
+	 * Only use the class-specific preference selection if both sched
+	 * groups have the same priority.
+	 */
+	if (arch_asym_cpu_priority(a->asym_prefer_cpu) !=
+	    arch_asym_cpu_priority(b->asym_prefer_cpu))
+		return false;
+
+	return sched_asym_ipcc_prefer(a_stats, b_stats);
+}
+
 #else /* CONFIG_IPC_CLASSES */
 static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
 				    struct rq *rq)
@@ -9526,6 +9580,14 @@ static void update_sg_lb_stats_scores(struct sg_lb_stats *sgs,
 {
 }
 
+static bool sched_asym_ipcc_pick(struct sched_group *a,
+				 struct sched_group *b,
+				 struct sg_lb_stats *a_stats,
+				 struct sg_lb_stats *b_stats)
+{
+	return false;
+}
+
 #endif /* CONFIG_IPC_CLASSES */
 
 /**
@@ -9759,6 +9821,16 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 		/* Prefer to move from lowest priority CPU's work */
 		if (sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
 			return false;
+
+		/*
+		 * Unlike other callers of sched_asym_prefer(), here both @sg
+		 * and @sds::busiest have tasks running. When they have equal
+		 * priority, their IPC class scores can be used to select a
+		 * better busiest.
+		 */
+		if (sched_asym_ipcc_pick(sds->busiest, sg, &sds->busiest_stat, sgs))
+			return false;
+
 		break;
 
 	case group_misfit_task:
-- 
2.25.1

