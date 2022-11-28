Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455E463A93D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiK1NOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiK1NNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:13:41 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06A41CB37;
        Mon, 28 Nov 2022 05:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669641220; x=1701177220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=6bnvjZwJXP3wVx/GzfxHDbk1nNW034G+XQZFyKkDwVI=;
  b=amtFdyXMYRlgqZ6C2IJoEYMFqv7J+hI5ztwU8lFKkAn6ZsCKsJ7iJI31
   76gQv550LresMwB59yQfho+lV3JuSd2+VWD4eJlgGxhMGnjP1+ltI6CoZ
   ESJ+Nb6v0BM5B1yigVQLtxul6plcd7magRzbu3XQMIJBU3odV4uBFgs6T
   w9zb7VflXdnNwYfJExNjRi58n4bQbEXk6P5rq/G7ALyoNBs/v2Hv6YTW6
   juTbRSK8QOCS04SY/Hv41JXvRvCvAicaYTn1kgQfGh+szSCXm7r4ugsJn
   Rd5DnlCWbL0Ziwn4vXFUqIfNLS7gVzmWli7LSp5SKo55Gm9aFnuY2xz1m
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401117249"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401117249"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:13:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749381393"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749381393"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2022 05:13:35 -0800
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
Subject: [PATCH v2 19/22] thermal: intel: hfi: Implement model-specific checks for task classification
Date:   Mon, 28 Nov 2022 05:20:57 -0800
Message-Id: <20221128132100.30253-20-ricardo.neri-calderon@linux.intel.com>
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

In Alderlake and Raptorlake, the result of thread classification is more
accurate when only one SMT sibling is busy. Classification results for
class 2 and 3 that are always reliable.

To avoid unnecessary migrations, only update the class of a task if it has
been the same during 4 consecutive ticks.

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
 * Adjusted the result the classification of Intel Thread Director to start
   at class 1. Class 0 for the scheduler means that the task is
   unclassified.
 * Used the new names of the IPC classes members in task_struct.
 * Reworked helper functions to use sched_smt_siblings_idle() to query
   the idle state of the SMT siblings of a CPU.
---
 drivers/thermal/intel/intel_hfi.c | 60 ++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 8287bfd7d6b6..a9ae09036909 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -40,6 +40,7 @@
 #include <linux/workqueue.h>
 
 #include <asm/msr.h>
+#include <asm/intel-family.h>
 
 #include "../thermal_core.h"
 #include "intel_hfi.h"
@@ -216,9 +217,64 @@ int intel_hfi_has_ipc_classes(void)
 	return cpu_feature_enabled(X86_FEATURE_ITD);
 }
 
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
+	/* The class of @p changed, only restart the debounce counter. */
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
+		return true;
+	}
+}
+
 void intel_hfi_update_ipcc(struct task_struct *curr)
 {
 	union hfi_thread_feedback_char_msr msr;
+	bool idle;
 
 	/* We should not be here if ITD is not supported. */
 	if (!cpu_feature_enabled(X86_FEATURE_ITD)) {
@@ -234,7 +290,9 @@ void intel_hfi_update_ipcc(struct task_struct *curr)
 	 * 0 is a valid classification for Intel Thread Director. A scheduler
 	 * IPCC class of 0 means that the task is unclassified. Adjust.
 	 */
-	curr->ipcc = msr.split.classid + 1;
+	idle = sched_smt_siblings_idle(task_cpu(curr));
+	if (classification_is_accurate(msr.split.classid, idle))
+		debounce_and_update_class(curr, msr.split.classid + 1);
 }
 
 int intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu)
-- 
2.25.1

