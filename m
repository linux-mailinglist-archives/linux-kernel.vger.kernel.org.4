Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC94634829
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbiKVU2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiKVU2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:28:16 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEBE14D07
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669148895; x=1700684895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=bhiwDeK4ICYY9tIKImH8FX+AqBh+ctstEwbC4wBb3kI=;
  b=UsM+efA2znobHYPGHWvHjZfJetf7YQSNUD2EqNJq44+DhN4OJsRSU38t
   q7u0pB+hGpumF4AJMOtyMZoB5Nm0FhTY2GaVyNaod7DK1RI7bLcWk1n06
   nFpRgTJTEIUi2jzsS3X8tL6t1MWWzCVx3Ol5ujOGZTINcWU/YAPaj79dy
   irEktVOVkX2qEyAbRV8G+f+dgVIsosVSQ7kNqg7h1/cyBduRPJKzXJLuY
   PD/PFfdIivrjP0tXRoP/WLfFskbBfTAIUmHsLeNv74GVQAB7IlMwt3DMg
   dyWLRouVx+RVBAEI8rqCLvTCZiOdduA8oGUr6A/bX3H/UkyUZRjLQLsra
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="293616514"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="293616514"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:28:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="816228144"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="816228144"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 22 Nov 2022 12:28:15 -0800
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
Subject: [PATCH v2 6/7] x86/sched/itmt: Give all SMT siblings of a core the same priority
Date:   Tue, 22 Nov 2022 12:35:31 -0800
Message-Id: <20221122203532.15013-7-ricardo.neri-calderon@linux.intel.com>
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

Currently, each SMT sibling is given a priority that ensures that in
partially busy systems load is evenly spread among cores.

There is, however, no difference in performance among the SMT siblings of
a core.

Having different priorities for each SMT sibling triggers unnecessary
load balancing towards the higher-priority sibling.

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
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v1:
 * Reworded commit message for clarity.
---
 arch/x86/kernel/itmt.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 4cb5a5e4fa47..2be49ce4f94a 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -174,32 +174,19 @@ int arch_asym_cpu_priority(int cpu, bool check_smt)
 
 /**
  * sched_set_itmt_core_prio() - Set CPU priority based on ITMT
- * @prio:	Priority of cpu core
- * @core_cpu:	The cpu number associated with the core
+ * @prio:	Priority of @cpu
+ * @cpu:	The CPU number
  *
  * The pstate driver will find out the max boost frequency
  * and call this function to set a priority proportional
- * to the max boost frequency. CPU with higher boost
+ * to the max boost frequency. CPUs with higher boost
  * frequency will receive higher priority.
  *
  * No need to rebuild sched domain after updating
  * the CPU priorities. The sched domains have no
  * dependency on CPU priorities.
  */
-void sched_set_itmt_core_prio(int prio, int core_cpu)
+void sched_set_itmt_core_prio(int prio, int cpu)
 {
-	int cpu, i = 1;
-
-	for_each_cpu(cpu, topology_sibling_cpumask(core_cpu)) {
-		int smt_prio;
-
-		/*
-		 * Ensure that the siblings are moved to the end
-		 * of the priority chain and only used when
-		 * all other high priority cpus are out of capacity.
-		 */
-		smt_prio = prio * smp_num_siblings / (i * i);
-		per_cpu(sched_core_priority, cpu) = smt_prio;
-		i++;
-	}
+	per_cpu(sched_core_priority, cpu) = prio;
 }
-- 
2.25.1

