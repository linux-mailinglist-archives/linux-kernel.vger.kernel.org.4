Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686275B42D1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiIIXIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiIIXGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D449117488
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764806; x=1694300806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=fqp/+ja2AfhJThgnSNq5HdkqvXnSgr2PPJsRa8AnaJk=;
  b=QczBKilwnDEPW/wBznPezBi3UWzYS+7y+AsICkn67juUBlF7kbn4eIxd
   hZq2e9QJzh/lZz6/cI9qoYQSB1rbnX9LKkdnguYfeNG9w23JHUjZXydD6
   D/13cQ17jnnAOCe5xKyGCJORnkeKeZPPm1UvNafFKebuAyDBjJZVYRsnP
   aCRgqAcq9glQJqVIcWCqyQcDLkqftpgHaafm7GLr3TubU00UwVwXZld4q
   z8XrhBJFs+VX7ELxSPM/EybW8q865X0NLF1WSezxSaHrroip9I7xE023/
   /j0k0Y8AV9oavFNnQwK7BRdDSKjX/OOIJ2RJ2y5v6Mnx/L+e1+BljdNlL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="296325087"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="296325087"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677354999"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 16:06:33 -0700
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
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [RFC PATCH 09/23] sched/fair: Use task-class performance score to pick the busiest group
Date:   Fri,  9 Sep 2022 16:11:51 -0700
Message-Id: <20220909231205.14009-10-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_sd_pick_busiest() keeps on selecting as the busiest group scheduling
groups of identical priority. Since both groups have the same priority,
either group is a good choice. The classes of tasks in the scheduling
groups can break this tie.

Pick as busiest the scheduling group that yields a higher task-class
performance score after load balancing.

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
 kernel/sched/fair.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 97731f81b570..7368a0b453ee 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8777,6 +8777,60 @@ static void compute_ilb_sg_task_class_scores(struct sg_lb_task_class_stats *clas
 	sgs->task_class_score_before = group_score;
 }
 
+/**
+ * sched_asym_class_prefer - Select a sched group based on its classes of tasks
+ * @a:	Load balancing statistics of @sg_a
+ * @b:	Load balancing statistics of @sg_b
+ *
+ * Returns: true if preferring @a yields a higher overall throughput after
+ * balancing load. Returns false otherwise.
+ */
+static bool sched_asym_class_prefer(struct sg_lb_stats *a,
+				    struct sg_lb_stats *b)
+{
+	if (!sched_task_classes_enabled())
+		return false;
+
+	/* @a increases overall throughput after load balance. */
+	if (a->task_class_score_after > b->task_class_score_after)
+		return true;
+
+	/*
+	 * If @a and @b yield the same overall throughput, pick @a if
+	 * its current throughput is lower than that of @b.
+	 */
+	if (a->task_class_score_after == b->task_class_score_after)
+		return a->task_class_score_before < b->task_class_score_before;
+
+	return false;
+}
+
+/**
+ * sched_asym_class_pick - Select a sched group based on classes of tasks
+ * @a:		A scheduling group
+ * @b:		A second scheduling group
+ * @a_stats:	Load balancing statistics of @a
+ * @b_stats:	Load balancing statistics of @b
+ *
+ * Returns: true if @a has the same priority and @a has classes of tasks that
+ * yield higher overall throughput after load balance. Returns false otherwise.
+ */
+static bool sched_asym_class_pick(struct sched_group *a,
+				  struct sched_group *b,
+				  struct sg_lb_stats *a_stats,
+				  struct sg_lb_stats *b_stats)
+{
+	/*
+	 * Only use the class-specific preference selection if both sched
+	 * groups have the same priority.
+	 */
+	if (arch_asym_cpu_priority(a->asym_prefer_cpu) !=
+	    arch_asym_cpu_priority(b->asym_prefer_cpu))
+		return false;
+
+	return sched_asym_class_prefer(a_stats, b_stats);
+}
+
 #else /* CONFIG_SCHED_TASK_CLASSES */
 static void update_rq_task_classes_stats(struct sg_lb_task_class_stats *class_sgs,
 					 struct rq *rq)
@@ -8793,6 +8847,14 @@ static void compute_ilb_sg_task_class_scores(struct sg_lb_task_class_stats *clas
 {
 }
 
+static bool sched_asym_class_pick(struct sched_group *a,
+				  struct sched_group *b,
+				  struct sg_lb_stats *a_stats,
+				  struct sg_lb_stats *b_stats)
+{
+	return false;
+}
+
 #endif /* CONFIG_SCHED_TASK_CLASSES */
 
 /**
@@ -9049,6 +9111,12 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 		/* Prefer to move from lowest priority CPU's work */
 		if (sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
 			return false;
+
+		/* @sg and @sds::busiest have the same priority. */
+		if (sched_asym_class_pick(sds->busiest, sg, &sds->busiest_stat, sgs))
+			return false;
+
+		/* @sg has lower priority than @sds::busiest. */
 		break;
 
 	case group_misfit_task:
-- 
2.25.1

