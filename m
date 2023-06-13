Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4D972D893
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239321AbjFMEZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239412AbjFMEZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:25:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD7E294F;
        Mon, 12 Jun 2023 21:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630159; x=1718166159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=kkx8+i7/ujXbIWdrAp+zwYJqUDlBUvhBgxYJWBRnjXc=;
  b=LCZYlE7YCGhLrx8+gTEekjH/iUW6Fl8f6LFKw/Cf4wmSbr/rGgnR0G93
   y3rIK9nc8bwPZroUcpO1SO6Fq/8rO05NrpKhBrI418PGmd5TCOG6HGPUS
   +mFNwnmC8ZZgYdz8CyZc5Zo8mSyHPFB0MgDnX1mIdMCK/vCPcks1aImrK
   eSsoJyubC8VhWD95szP6QcAwCug0FrQQl6QNfA8cs2Tio9V8oq9NnZal4
   OaI/MDOblMD2p8fC+Ma+hq2Y6TOP2X2X6/V/sJRfHzRata0k035ySCxR4
   fWKmGilb9Esw+WEVovZARaHNI6ITrHetEoxwub6JCgxGHLwr2oZYpuZwM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222277"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222277"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:22:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661854998"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661854998"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:22:01 -0700
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
Subject: [PATCH v4 21/24] x86/sched/ipcc: Implement model-specific checks for task classification
Date:   Mon, 12 Jun 2023 21:24:19 -0700
Message-Id: <20230613042422.5344-22-ricardo.neri-calderon@linux.intel.com>
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

In Alder Lake and Raptor Lake, the result of thread classification is more
accurate when only one SMT sibling is busy. Classification results for
class 2 and 3 are always reliable.

Changing the classification of a task too frequently may lead to
unnecessary migrations.

Only update the class of a task if it is considered accurate and has been
constant during four consecutive user ticks.

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
 * Relocated this code to arch/x86/kernel/sched_ipcc.c (Rafael)

Changes since v2:
 * None

Changes since v1:
 * Adjusted the result the classification of Intel Thread Director to start
   at class 1. Class 0 for the scheduler means that the task is
   unclassified.
 * Used the new names of the IPC classes members in task_struct.
 * Reworked helper functions to use sched_smt_siblings_idle() to query
   the idle state of the SMT siblings of a CPU.
---
 arch/x86/kernel/sched_ipcc.c | 60 +++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sched_ipcc.c b/arch/x86/kernel/sched_ipcc.c
index 685e7b3b5375..dd73fc8be49b 100644
--- a/arch/x86/kernel/sched_ipcc.c
+++ b/arch/x86/kernel/sched_ipcc.c
@@ -18,11 +18,67 @@
 
 #include <linux/sched.h>
 
+#include <asm/intel-family.h>
 #include <asm/topology.h>
 
+#define CLASS_DEBOUNCER_SKIPS 4
+
+/**
+ * debounce_and_update_class() - Process and update a task's classification
+ *
+ * @p:		The task of which the classification will be updated
+ * @new_ipcc:	The new IPC classification
+ *
+ * Update the classification of @p with the new value that hardware provides.
+ * Only update the classification of @p if it has been the same during
+ * CLASS_DEBOUNCER_SKIPS consecutive ticks.
+ */
+static void debounce_and_update_class(struct task_struct *p, u8 new_ipcc)
+{
+	u16 debounce_skip;
+
+	/* The class of @p changed. Only restart the debounce counter. */
+	if (p->ipcc_tmp != new_ipcc) {
+		p->ipcc_cntr = 1;
+		goto out;
+	}
+
+	/*
+	 * The class of @p did not change. Update it if it has been the same
+	 * for CLASS_DEBOUNCER_SKIPS user ticks.
+	 */
+	debounce_skip = p->ipcc_cntr + 1;
+	if (debounce_skip < CLASS_DEBOUNCER_SKIPS)
+		p->ipcc_cntr++;
+	else
+		p->ipcc = new_ipcc;
+
+out:
+	p->ipcc_tmp = new_ipcc;
+}
+
+static bool classification_is_accurate(u8 hfi_class, bool smt_siblings_idle)
+{
+	switch (boot_cpu_data.x86_model) {
+	case INTEL_FAM6_ALDERLAKE:
+	case INTEL_FAM6_ALDERLAKE_L:
+	case INTEL_FAM6_RAPTORLAKE:
+	case INTEL_FAM6_RAPTORLAKE_P:
+	case INTEL_FAM6_RAPTORLAKE_S:
+		if (hfi_class == 3 || hfi_class == 2 || smt_siblings_idle)
+			return true;
+
+		return false;
+
+	default:
+		return false;
+	}
+}
+
 void intel_update_ipcc(struct task_struct *curr)
 {
 	u8 hfi_class;
+	bool idle;
 
 	if (intel_hfi_read_classid(&hfi_class))
 		return;
@@ -31,5 +87,7 @@ void intel_update_ipcc(struct task_struct *curr)
 	 * 0 is a valid classification for Intel Thread Director. A scheduler
 	 * IPCC class of 0 means that the task is unclassified. Adjust.
 	 */
-	curr->ipcc = hfi_class + 1;
+	idle = sched_smt_siblings_idle(task_cpu(curr));
+	if (classification_is_accurate(hfi_class, idle))
+		debounce_and_update_class(curr, hfi_class + 1);
 }
-- 
2.25.1

