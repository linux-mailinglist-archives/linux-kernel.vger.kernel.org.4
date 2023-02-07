Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7C768CE99
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjBGFDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjBGFB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:01:57 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AC7CA05;
        Mon,  6 Feb 2023 21:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675746115; x=1707282115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vDnh1C/cq9wjWDStRuJO1Z3DAdsnd8sqeD4zFb0EIc0=;
  b=KRH57/e/ImFV0sKKTP80CpIj4dO4n+IZ5L2AQHQEqx+QQjlj1auDvaS6
   ImagWXbEZaydTT+vz3o4cHHtECTMXZ9lEnCS6V6Hcj3VwbKk1Npu5lEO2
   d8Z8HO7RpvcId73r9XM16gwpA0G7BF3Pq4hXwy12hYctZs1kDnhIEHDZN
   Hlu2iTzt/oW87/2icGmfrUTU9Frt7SXNYyOCH+qAtLEycVSfbMqeq+aWx
   ABGC5shFVOvjV+lmwlJO+8IPVkNvYlIalOTBsQSTx7cntDLEXMA4CrNWe
   bz6J+pEXY6e+tiAvUzLFLXcr4nN/oH75swM+fJrYPAthgRzDAJSSEVxoi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415625884"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415625884"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 21:01:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668657744"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668657744"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 21:01:43 -0800
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
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v3 13/24] thermal: intel: hfi: Store per-CPU IPCC scores
Date:   Mon,  6 Feb 2023 21:10:54 -0800
Message-Id: <20230207051105.11575-14-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scheduler reads the IPCC scores when balancing load. These reads can
be quite frequent. Hardware can also update the HFI table frequently.
Concurrent access may cause a lot of lock contention. It gets worse as the
number of CPUs increases.

Instead, create separate per-CPU IPCC scores that the scheduler can read
without the HFI table lock.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 * Only create these per-CPU variables when Intel Thread Director is
   supported.

Changes since v1:
 * Added this patch.
---
 drivers/thermal/intel/intel_hfi.c | 46 +++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 2527ae3836c7..b06021828892 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -29,6 +29,7 @@
 #include <linux/kernel.h>
 #include <linux/math.h>
 #include <linux/mutex.h>
+#include <linux/percpu.h>
 #include <linux/percpu-defs.h>
 #include <linux/printk.h>
 #include <linux/processor.h>
@@ -170,6 +171,43 @@ static struct workqueue_struct *hfi_updates_wq;
 #define HFI_UPDATE_INTERVAL		HZ
 #define HFI_MAX_THERM_NOTIFY_COUNT	16
 
+#ifdef CONFIG_IPC_CLASSES
+static int __percpu *hfi_ipcc_scores;
+
+static int alloc_hfi_ipcc_scores(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_ITD))
+		return 0;
+
+	hfi_ipcc_scores = __alloc_percpu(sizeof(*hfi_ipcc_scores) *
+					 hfi_features.nr_classes,
+					 sizeof(*hfi_ipcc_scores));
+
+	return !hfi_ipcc_scores;
+}
+
+static void set_hfi_ipcc_score(void *caps, int cpu)
+{
+	int i, *hfi_class;
+
+	if (!cpu_feature_enabled(X86_FEATURE_ITD))
+		return;
+
+	hfi_class = per_cpu_ptr(hfi_ipcc_scores, cpu);
+
+	for (i = 0;  i < hfi_features.nr_classes; i++) {
+		struct hfi_cpu_data *class_caps;
+
+		class_caps = caps + i * hfi_features.class_stride;
+		WRITE_ONCE(hfi_class[i], class_caps->perf_cap);
+	}
+}
+
+#else
+static int alloc_hfi_ipcc_scores(void) { return 0; }
+static void set_hfi_ipcc_score(void *caps, int cpu) { }
+#endif /* CONFIG_IPC_CLASSES */
+
 static void get_hfi_caps(struct hfi_instance *hfi_instance,
 			 struct thermal_genl_cpu_caps *cpu_caps)
 {
@@ -192,6 +230,8 @@ static void get_hfi_caps(struct hfi_instance *hfi_instance,
 		cpu_caps[i].efficiency = caps->ee_cap << 2;
 
 		++i;
+
+		set_hfi_ipcc_score(caps, cpu);
 	}
 	raw_spin_unlock_irq(&hfi_instance->table_lock);
 }
@@ -580,8 +620,14 @@ void __init intel_hfi_init(void)
 	if (!hfi_updates_wq)
 		goto err_nomem;
 
+	if (alloc_hfi_ipcc_scores())
+		goto err_ipcc;
+
 	return;
 
+err_ipcc:
+	destroy_workqueue(hfi_updates_wq);
+
 err_nomem:
 	for (j = 0; j < i; ++j) {
 		hfi_instance = &hfi_instances[j];
-- 
2.25.1

