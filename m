Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37D0634828
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbiKVU2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbiKVU2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:28:14 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBB6165A6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669148894; x=1700684894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=y/1MAtHpQYdgN3xn2hBOyK3a06TFyZ6nWBTd2NULu+4=;
  b=MxSPRBvh003O+2p68QIC1ZbnVoGu99y4zO9Yy24dMEH3kuTwg1Icre7+
   uDKuvzxf3eCuDeyF9YK1i07kq+IddE+20oF8s7oJPrV7CCYBOzeKkWgQj
   FMqOqvYzzyOF/3GUulFs+iBLkZskZKp2GnSDeEslNnZ2TG6OSV/A18wku
   K6PFVnT+sBUZeZCwwjo1yUdvuIwZzxpNKSXXsy/iB/ufuEKPoecm48iDm
   3F7/PFXNPKveqHQacpxV0IeK2bzGpzo9CeCcWW8rJ/k8VXzVij18OvEZ+
   D831iiw0WsFamIkkW66TfCIuW0FOPLsrh9V5XmEG6WJHw/SRt+zleXnyn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="293616506"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="293616506"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:28:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="816228127"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="816228127"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 22 Nov 2022 12:28:12 -0800
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
Subject: [PATCH v2 2/7] sched: Prepare sched_asym_prefer() to handle idle state of SMT siblings
Date:   Tue, 22 Nov 2022 12:35:27 -0800
Message-Id: <20221122203532.15013-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The throughput of an SMT sibling decreases if one or more of its siblings
are also busy. Idle, lower-priority cores can help. Thus, it is necessary
to consider the idle state of the SMT siblings of CPUs when selecting by
priority.

In some cases, sched_asym_prefer() does not care about the idle state
(when building sched domains or looking at the priority of the preferred
CPU in a sched group).

Add a new parameter to check the state of the SMT siblings of a CPU when
applicable.

While here, remove a spurious newline.

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
Changes since v1:
 * Introduced this patch
---
 kernel/sched/fair.c     | 17 ++++++++++-------
 kernel/sched/sched.h    |  8 ++++++--
 kernel/sched/topology.c |  6 +++++-
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 18c672ff39ef..d18947a9c03e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8921,7 +8921,7 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
 		 * can help if it has higher priority and is idle (i.e.,
 		 * it has no running tasks).
 		 */
-		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
+		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu, false);
 	}
 
 	/*
@@ -8934,7 +8934,7 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
 	 * exactly one busy CPU. This covers SMT and non-SMT sched groups.
 	 */
 	if (sg_busy_cpus == 1 && !sds->local_stat.sum_nr_running)
-		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
+		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu, false);
 
 	return false;
 #else
@@ -8952,7 +8952,8 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
 	    (group->flags & SD_SHARE_CPUCAPACITY))
 		return asym_smt_can_pull_tasks(env->dst_cpu, sds, sgs, group);
 
-	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
+	/* Neither env::dst_cpu nor group::asym_prefer_cpu have SMT siblings. */
+	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu, false);
 }
 
 static inline bool
@@ -9118,7 +9119,9 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 
 	case group_asym_packing:
 		/* Prefer to move from lowest priority CPU's work */
-		if (sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
+		if (sched_asym_prefer(sg->asym_prefer_cpu,
+				      sds->busiest->asym_prefer_cpu,
+				      false))
 			return false;
 		break;
 
@@ -10060,7 +10063,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 
 		/* Make sure we only pull tasks from a CPU of lower priority */
 		if ((env->sd->flags & SD_ASYM_PACKING) &&
-		    sched_asym_prefer(i, env->dst_cpu) &&
+		    sched_asym_prefer(i, env->dst_cpu, true) &&
 		    nr_running == 1)
 			continue;
 
@@ -10153,7 +10156,7 @@ asym_active_balance(struct lb_env *env)
 	 * highest priority CPUs.
 	 */
 	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
-	       sched_asym_prefer(env->dst_cpu, env->src_cpu);
+	       sched_asym_prefer(env->dst_cpu, env->src_cpu, true);
 }
 
 static inline bool
@@ -10889,7 +10892,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * around.
 		 */
 		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
-			if (sched_asym_prefer(i, cpu)) {
+			if (sched_asym_prefer(i, cpu, true)) {
 				flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 				goto unlock;
 			}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a4a20046e586..0fc7c0130755 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -795,8 +795,12 @@ static inline long se_weight(struct sched_entity *se)
 	return scale_load_down(se->load.weight);
 }
 
-
-static inline bool sched_asym_prefer(int a, int b)
+/*
+ * Used to compare specific CPUs. Also when comparing the preferred CPU of a
+ * sched group or building the sched domains; in such cases checking the state
+ * of SMT siblings, if any, is not needed.
+ */
+static inline bool sched_asym_prefer(int a, int b, bool check_smt)
 {
 	return arch_asym_cpu_priority(a) > arch_asym_cpu_priority(b);
 }
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..8154ef590b9f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1282,7 +1282,11 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
 		for_each_cpu(cpu, sched_group_span(sg)) {
 			if (max_cpu < 0)
 				max_cpu = cpu;
-			else if (sched_asym_prefer(cpu, max_cpu))
+			/*
+			 * We want the CPU priorities unaffected by the idle
+			 * state of its SMT siblings, if any.
+			 */
+			else if (sched_asym_prefer(cpu, max_cpu, false))
 				max_cpu = cpu;
 		}
 		sg->asym_prefer_cpu = max_cpu;
-- 
2.25.1

