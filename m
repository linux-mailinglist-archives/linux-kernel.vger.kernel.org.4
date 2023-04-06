Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF166DA28C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbjDFUVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239013AbjDFUVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:21:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB9C83F2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680812464; x=1712348464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=1GwN8Z6Tl0O9JXGbYpwm3LTEhQCLgFtn0AiDdW1pPe8=;
  b=MYUk4ZHy74oYIByA1n/aIiKfkNDQfhdZ5uu8R5hUe+/f4txgtTSad8I7
   9hoBxARjEo118Hic9IfmUn8EBEbkIX1iVa6Yfa+IqKOFsAotcW8p/kcR2
   SuEZwvXhe4SVrRAQtRZ4ialKP/c1ccRjRRUT0ZgYFNkG9fw/8tgGFY/xN
   MZypUaHugFTAWC0T9nOZozAcs4c7ivejg3/gQFgLuqom3T5DR20/Biy2L
   /+2KgM60TIKdyIN/qLVlS1UEpoqR21jWpF3VSsPkPKtKnlYvZoub8oEZm
   bOpTk4ZKTB5DN49TrxGfJ+1i/OZuHSdM9LI4O72Qu5pSxOeiutixbhWvl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="407957815"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="407957815"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 13:21:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="861529906"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="861529906"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2023 13:21:02 -0700
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
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v4 11/12] x86/sched/itmt: Give all SMT siblings of a core the same priority
Date:   Thu,  6 Apr 2023 13:31:47 -0700
Message-Id: <20230406203148.19182-12-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
References: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X86 does not have the SD_ASYM_PACKING flag in the SMT domain. The scheduler
knows how to handle SMT and non-SMT cores of different priority. There is
no reason for SMT siblings of a core to have different priorities.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Tested-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * None

Changes since v2:
 * None

Changes since v1:
 * Reworded commit message for clarity.
---
 arch/x86/kernel/itmt.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 670eb08b972a..ee4fe8cdb857 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -165,32 +165,19 @@ int arch_asym_cpu_priority(int cpu)
 
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

