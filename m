Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5439463A92A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiK1NOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiK1NNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:13:38 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812071D678;
        Mon, 28 Nov 2022 05:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669641217; x=1701177217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=GsviGa0DcVIC2LcEIZUUyDmrwHqAyGZci2nKyeSjNto=;
  b=Mpkr6eFStFskEuiJLekkFdqLeBG5DoXW4DtoVyy0Wywdo0aoFwILAJ4I
   bk/HdXFqz0Llb7RMabI7fawAxTeOmeYJPr2BjYSKwKXTE5jj/nLXdUm4J
   /pMf7EY18eE5kB4XjjUVWu4cqbFSkGuQgf6/spZDo1HtJkCw24MpxsABa
   jmPrWoQgas7ObviX9c7Y9RhK4tSLHGVukeyIbFX0otcEj9cIGGRIjebPn
   nL7RadxxVaqJMuU84hYaU+86Bt6ENYV9BoCCQyChvKBswqWomcHx2e4k9
   vzOvq5Q4PrEEvmPjhOqd7RX7Zi3rHd1td8fNlYS2R55oGBsxICA9UE/fK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401117125"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401117125"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:13:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749381349"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749381349"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2022 05:13:33 -0800
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
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v2 08/22] sched/fair: Use IPC class to pick the busiest group
Date:   Mon, 28 Nov 2022 05:20:46 -0800
Message-Id: <20221128132100.30253-9-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it iterates, update_sd_pick_busiest() keeps on selecting as busiest
sched groups of identical priority. Since both groups have the same
priority, either group is a good choice. The IPCC score of the tasks
placed a sched group can break this tie.

Pick as busiest the sched group that yields a higher IPCC score after
load balancing.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v1:
 * Added a comment to clarify why sched_asym_prefer() needs a tie breaker
   only in update_sd_pick_busiest(). (PeterZ)
 * Renamed functions for accuracy:
   sched_asym_class_prefer() >> sched_asym_ipcc_prefer()
   sched_asym_class_pick() >> sched_asym_ipcc_pick()
 * Reworded commit message for clarity.
---
 kernel/sched/fair.c | 75 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e333f9623b3a..e8b181c31842 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9176,6 +9176,63 @@ static void update_sg_lb_stats_scores(struct sg_lb_ipcc_stats *sgcs,
 	sgs->ipcc_score_before = before;
 }
 
+/**
+ * sched_asym_ipcc_prefer - Select a sched group based on its IPCC score
+ * @a:	Load balancing statistics of @sg_a
+ * @b:	Load balancing statistics of @sg_b
+ *
+ * Returns: true if preferring @a has a higher IPCC score than @b after
+ * balancing load. Returns false otherwise.
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
+ * Returns: true if @a has the same priority and @a has tasks with IPCC classes
+ * that yield higher overall throughput after load balance.
+ * Returns false otherwise.
+ */
+static bool sched_asym_ipcc_pick(struct sched_group *a,
+				 struct sched_group *b,
+				 struct sg_lb_stats *a_stats,
+				 struct sg_lb_stats *b_stats)
+{
+	/*
+	 * Only use the class-specific preference selection if both sched
+	 * groups have the same priority. We are not looking at a specific
+	 * CPU. We do not care about the idle state of the groups'
+	 * preferred CPU.
+	 */
+	if (arch_asym_cpu_priority(a->asym_prefer_cpu, false) !=
+	    arch_asym_cpu_priority(b->asym_prefer_cpu, false))
+		return false;
+
+	return sched_asym_ipcc_prefer(a_stats, b_stats);
+}
+
 #else /* CONFIG_IPC_CLASSES */
 static void update_sg_lb_ipcc_stats(struct sg_lb_ipcc_stats *sgcs,
 				    struct rq *rq)
@@ -9193,6 +9250,14 @@ static void update_sg_lb_stats_scores(struct sg_lb_ipcc_stats *sgcs,
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
@@ -9452,6 +9517,16 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 				      sds->busiest->asym_prefer_cpu,
 				      false))
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

