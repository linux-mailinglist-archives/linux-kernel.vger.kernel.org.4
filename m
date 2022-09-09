Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4665B42D6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiIIXIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiIIXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2F2115CCF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764799; x=1694300799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=HtkFo8d75chl2B/55R+uXknx9vI9zbqpcllc2KJw6l8=;
  b=BUlvUevlx228Xz0clZjInhch3H4C04e/Vc7Z1WOFssEjt7mtvIGxtOxG
   8dFrwC2GYhAH0HeNSucV1fK36VKTyubwgyB2yXa8syOcbRXDzq8+ZeHdU
   eSCTvVgKLkDSH8Doj4cQ4BMv6o5QnD3wexb/WVixczPRzpFTmU/X15ygJ
   BwkHskt4pGHnJvOspQIt5EmQ8DgljvPHLyli6DlvdTEJ2ZsEnMM3aMxQp
   bZAh1bel0UbFvuQhP7BjyWT5EHInsvaPQCY6s/CAifgudAP4v0IiloHPE
   VkuMjEaCskOAim4c8NG32QBHwOxoOBBDHUVo3Ci/vsH0EfoLYKr+kuvea
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298386924"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="298386924"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677355047"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 16:06:36 -0700
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
Subject: [RFC PATCH 20/23] thermal: intel: hfi: Implement model-specific checks for task classification
Date:   Fri,  9 Sep 2022 16:12:02 -0700
Message-Id: <20220909231205.14009-21-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/thermal/intel/intel_hfi.c | 58 ++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 9ddd3047eb39..972ccfd392cf 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -39,6 +39,7 @@
 #include <linux/workqueue.h>
 
 #include <asm/msr.h>
+#include <asm/intel-family.h>
 
 #include "../thermal_core.h"
 #include "intel_hfi.h"
@@ -214,6 +215,60 @@ int intel_hfi_has_task_classes(void)
 	return cpu_feature_enabled(X86_FEATURE_ITD);
 }
 
+#define CLASS_DEBOUNCER_SKIPS 4
+
+/**
+ * debounce_and_update_class() - Process and update a task's classification
+ *
+ * @p:		The task of which the classification will be updated
+ * @new_class:	The new class that hardware provides
+ *
+ * Update the classification of @p with the new value that hardware provides.
+ * Only update the classification of @p it has been the same during
+ * CLASS_DEBOUNCER_SKIPS consecutive ticks.
+ */
+static void debounce_and_update_class(struct task_struct *p, u8 new_class)
+{
+	char debounce_skip;
+
+	/* The class of @p changed, only restart the debounce counter. */
+	if (p->class_candidate != new_class) {
+		p->class_debounce_counter = 1;
+		goto out;
+	}
+
+	/*
+	 * The class of @p did not change. Update it if it has been the same
+	 * for CLASS_DEBOUNCER_SKIPS user ticks.
+	 */
+	debounce_skip = p->class_debounce_counter + 1;
+	if (debounce_skip < CLASS_DEBOUNCER_SKIPS)
+		p->class_debounce_counter++;
+	else
+		p->class = new_class;
+
+out:
+	p->class_candidate = new_class;
+}
+
+static bool classification_is_accurate(u8 class, bool smt_siblings_idle)
+{
+	switch (boot_cpu_data.x86_model) {
+	case INTEL_FAM6_ALDERLAKE:
+	case INTEL_FAM6_ALDERLAKE_L:
+	case INTEL_FAM6_RAPTORLAKE:
+	case INTEL_FAM6_RAPTORLAKE_P:
+	case INTEL_FAM6_RAPTORLAKE_S:
+		if (class == 3 || class == 2 || smt_siblings_idle)
+			return true;
+
+		return false;
+
+	default:
+		return true;
+	}
+}
+
 void intel_hfi_update_task_class(struct task_struct *curr, bool smt_siblings_idle)
 {
 	union hfi_thread_feedback_char_msr msr;
@@ -228,7 +283,8 @@ void intel_hfi_update_task_class(struct task_struct *curr, bool smt_siblings_idl
 	if (!msr.split.valid)
 		return;
 
-	curr->class = msr.split.classid;
+	if (classification_is_accurate(msr.split.classid, smt_siblings_idle))
+		debounce_and_update_class(curr, msr.split.classid);
 }
 
 static void get_one_hfi_cap(struct hfi_instance *hfi_instance, s16 index,
-- 
2.25.1

