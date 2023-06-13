Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9284272D891
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbjFMEZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239825AbjFMEYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:24:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1172693;
        Mon, 12 Jun 2023 21:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630141; x=1718166141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=40EcOZxxZvEM9rJzNTuBarR/nR+bap62+RifKT4WIh0=;
  b=EWVioQCCzCHgSWQrhh+A1sXBGbS2Nh213ZPWTe5WDsdN5wgFBXpdYe+O
   ewrEX2eqDfWO4xh+PdQqd8PSkthtQDW2ecnGhf/j/uj1ix+Ny1r8IYTjI
   zFote07seVZL+XdQOJIQgxdNbwSrNox8iQICdZdHgV1OKHe3y6/x1rUN6
   SYk6X+iu7J07Yi/Yw+A6jcskjViQG/iFZVdtn0AkRzkCE9kfeA3PNPmsl
   XM7I0SJ2/kvq5Fz8BePXNWTrKsuv5fna3VyAUbGzr/qKaKkq3FyGS+lO7
   uYOOZjut80D9E6mLJlZA6sQ6ekiziIYQdvDz+trzrwgrJw+ZLQsknpqzj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222265"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222265"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:22:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661854995"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661854995"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:21:59 -0700
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
Subject: [PATCH v4 20/24] sched/fair: Introduce sched_smt_siblings_idle()
Date:   Mon, 12 Jun 2023 21:24:18 -0700
Message-Id: <20230613042422.5344-21-ricardo.neri-calderon@linux.intel.com>
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

X86 needs to know the idle state of the SMT siblings of a CPU to improve
the accuracy of IPCC classification. X86 implements support for IPC classes
in the thermal HFI driver.

Rename is_core_idle() as sched_smt_siblings_idle() and make it available
outside the scheduler code.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Perry Yuan <Perry.Yuan@amd.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
is_core_idle() is no longer an inline function after this patch. To rule
out performance degradation, I compared the execution time of the inline
and non-inline versions on a 4-socket Cascade Lake system using the NUMA
stressor of stress-ng.

I used this test command:

        $ stress-ng --numa 1500 -t 10m

During the test, is_core_idle() was called ~200,000 times. To measure the
execution time, I recorded the value of the TSC counter before and after
calling is_core_idle() and calculated the difference.
value.

I arbitrarily removed outliers (defined as any delta larger than 5000
counts). This required removing ~40 samples.

The table below summarizes the difference in execution time. All values
are expressed in TSC counts, except for the standard deviation, expressed
as a percentage of the average.

                              Average  Median  Std(%) Mode
        TSCdelta inline        668.76     626   67.24   42
        TSCdelta non-inline    677.64     624   67.67   46

The metrics show that both the inline and non-inline versions exhibit
similar performance characteristics.
---
Changes since v3:
 * None

Changes since v2:
 * Brought back this previously dropped patch.
 * Profiled inline vs non-inline is_core_idle(). I found not major penalty.
 * Merged is_core_idle() and sched_smt_siblings_idle() into a single
   function. (Dietmar)

Changes since v1:
 * Dropped this patch.
---
 include/linux/sched.h |  2 ++
 kernel/sched/fair.c   | 13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 719147460ca8..986344ebf2f6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2461,4 +2461,6 @@ static inline void sched_core_fork(struct task_struct *p) { }
 
 extern void sched_set_stop_task(int cpu, struct task_struct *stop);
 
+extern bool sched_smt_siblings_idle(int cpu);
+
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da3e009eef42..a52589a6c561 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1064,7 +1064,14 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
  * Scheduling class queueing methods:
  */
 
-static inline bool is_core_idle(int cpu)
+/**
+ * sched_smt_siblings_idle - Check whether SMT siblings of a CPU are idle
+ * @cpu:	The CPU to check
+ *
+ * Returns true if all the SMT siblings of @cpu are idle or @cpu does not have
+ * SMT siblings. The idle state of @cpu is not considered.
+ */
+bool sched_smt_siblings_idle(int cpu)
 {
 #ifdef CONFIG_SCHED_SMT
 	int sibling;
@@ -1767,7 +1774,7 @@ static inline int numa_idle_core(int idle_core, int cpu)
 	 * Prefer cores instead of packing HT siblings
 	 * and triggering future load balancing.
 	 */
-	if (is_core_idle(cpu))
+	if (sched_smt_siblings_idle(cpu))
 		idle_core = cpu;
 
 	return idle_core;
@@ -9652,7 +9659,7 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 	if (!sched_smt_active())
 		return true;
 
-	return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
+	return sd->flags & SD_SHARE_CPUCAPACITY || sched_smt_siblings_idle(cpu);
 }
 
 /**
-- 
2.25.1

