Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9D6634827
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiKVU2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiKVU2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:28:15 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC03C1B1D8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669148894; x=1700684894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ZxiRvtsJwz9dFNPg5MHP4zjCzO9YSRx6bjDINyhvJ5o=;
  b=YO5abYmcCWkxOVmwE0RoQ8gdQ02Gl9vS8d2LzhQcaNrhIaclRTjZDDva
   w5ZimWTsceDPCaNUq56YuyLrJ8tzVeStPDv6caiGQTFbfd2pNFRc6Zy2D
   reQHuqADcqYYODzbEyaRuUVGxwJiw7DSV7WqyPBLunxBEVkDHmPrcLA1I
   UUY3hn5dNJFqTXvHa/SUhP3KGvaJaV4b1fi2wwDzyIm8bhFTnUresYOk5
   j2whgaklJBIUugC1QQ6HyQ9yf+en30WsRKYO3LyW8ReX5RPzsZGvzdgp0
   5SJWvlE6+5jr2zf4Ay+e+/CIo4vLXHms8hlce/MztAlwoGMTNeqowluFK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="293616509"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="293616509"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:28:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="816228136"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="816228136"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 22 Nov 2022 12:28:14 -0800
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
Subject: [PATCH v2 4/7] sched/fair: Introduce sched_smt_siblings_idle()
Date:   Tue, 22 Nov 2022 12:35:29 -0800
Message-Id: <20221122203532.15013-5-ricardo.neri-calderon@linux.intel.com>
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

Architectures that implement arch_asym_cpu_priority() may need to know the
idle state of the SMT siblings of a CPU. The scheduler has this information
and functionality. Expose it.

Move the existing functionality outside of the NUMA code.

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
 * Introduced this patch.
---
 include/linux/sched.h |  2 ++
 kernel/sched/fair.c   | 39 ++++++++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffb6eb55cd13..0d01c64ac737 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2426,4 +2426,6 @@ static inline void sched_core_fork(struct task_struct *p) { }
 
 extern void sched_set_stop_task(int cpu, struct task_struct *stop);
 
+extern bool sched_smt_siblings_idle(int cpu);
+
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0e4251f83807..9517c48df50e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1052,6 +1052,28 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
  * Scheduling class queueing methods:
  */
 
+static inline bool is_core_idle(int cpu)
+{
+#ifdef CONFIG_SCHED_SMT
+	int sibling;
+
+	for_each_cpu(sibling, cpu_smt_mask(cpu)) {
+		if (cpu == sibling)
+			continue;
+
+		if (!idle_cpu(sibling))
+			return false;
+	}
+#endif
+
+	return true;
+}
+
+bool sched_smt_siblings_idle(int cpu)
+{
+	return is_core_idle(cpu);
+}
+
 #ifdef CONFIG_NUMA
 #define NUMA_IMBALANCE_MIN 2
 
@@ -1691,23 +1713,6 @@ struct numa_stats {
 	int idle_cpu;
 };
 
-static inline bool is_core_idle(int cpu)
-{
-#ifdef CONFIG_SCHED_SMT
-	int sibling;
-
-	for_each_cpu(sibling, cpu_smt_mask(cpu)) {
-		if (cpu == sibling)
-			continue;
-
-		if (!idle_cpu(sibling))
-			return false;
-	}
-#endif
-
-	return true;
-}
-
 struct task_numa_env {
 	struct task_struct *p;
 
-- 
2.25.1

