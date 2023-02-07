Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8226A68CE63
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjBGEvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjBGEuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:50:51 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B384224
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675745450; x=1707281450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=V6FYmmT4588dHQyb2k4T7y1sGWHIXNL1S/nAV83f7Kc=;
  b=bItoG2aADFROUGdSb2VH4jrC46brvF3ikHNj8OPk60rTl3tqoRZqr/Zr
   /9Dj4KrZpwmDCPPG4jx+l/OHLJoEGLQhC8HmNTRYFEekfFJEeEJtS6xtY
   EIObkfX+FqfjbP3AUrAR8XTSlEX8P95FceKsYlrnAp0lJSblV9gsupVet
   jWz/1aViJVasfUOQPGJKoy17irsWgdfPGgiuF/ZAY4h2hCmQgaj9U5KxQ
   i+JB29OenZssRNAk+prtey3McNTeVtDbKGJcPhtGLI7bm/F7Kx5+YHiRa
   elPdtxUIFvt5qVD0xZwYKswhNe1rpK11rGtFgQ/tLvK1B1HzG/MN9dI7r
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415624062"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415624062"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 20:50:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668653808"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668653808"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 20:50:48 -0800
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
Subject: [PATCH v3 10/10] x86/sched/itmt: Give all SMT siblings of a core the same priority
Date:   Mon,  6 Feb 2023 20:58:38 -0800
Message-Id: <20230207045838.11243-11-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Changes since v2:
 * None.

Changes since v1:
 * Reworded commit message for clarity.
---
 arch/x86/kernel/itmt.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 9ff480e94511..6510883c5e81 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -174,32 +174,19 @@ int arch_asym_cpu_priority(int cpu)
 
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

