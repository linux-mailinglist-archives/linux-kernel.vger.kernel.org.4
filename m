Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E520663A936
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiK1NO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiK1NNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:13:39 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1A51DA53;
        Mon, 28 Nov 2022 05:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669641218; x=1701177218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=xRdgNgGdXQiORGcgdnIBmgL4e1VMD8FuTc66jRXlDMQ=;
  b=eP3if2/17XG58Aa8gCs/yoHPvTQLjlMwsRb/GHZZrNwMSJXhaeb6x5+r
   uUDoskJFU7j9fkN1QVb7UR4UUy7SsC7JH3IIRwqG7T6gFXG90nEA43f64
   mpc+3oJeU8kKtKxxhS+zq1JAfrT7X9cL76ewDU7rMMKQoctRL7iXmgbIm
   DM/HTwt5k0aVt5fwSJOcEuqaia37mB6umldvwazWGZQM1lpP3DKqg4OjR
   9NAsMwIROJJb0MkzT+O2TCop5NfHvBjRkl3QMfAAM7a3T0hgiEbSjbF2M
   SPBJukrmxYQBZKfWUb3tpNHLQf/+6OMfoPp5EFbuR0SApUEwFuFgs3p9s
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401117159"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401117159"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:13:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749381363"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749381363"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2022 05:13:33 -0800
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
Subject: [PATCH v2 11/22] thermal: intel: hfi: Store per-CPU IPCC scores
Date:   Mon, 28 Nov 2022 05:20:49 -0800
Message-Id: <20221128132100.30253-12-ricardo.neri-calderon@linux.intel.com>
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

The scheduler reads the IPCC scores when balancing load. These reads can
be quite frequent. Hardware can also update the HFI table frequently.
Concurrent access may cause a lot of contention. It gets worse as the
number of CPUs increases.

Instead, create separate per-CPU IPCC scores that the scheduler can read
without the HFI table lock.

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
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v1:
 * Added this patch.
---
 drivers/thermal/intel/intel_hfi.c | 38 +++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index df4dc50e19fb..56dba967849c 100644
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
@@ -172,6 +173,35 @@ static struct workqueue_struct *hfi_updates_wq;
 #define HFI_UPDATE_INTERVAL		HZ
 #define HFI_MAX_THERM_NOTIFY_COUNT	16
 
+#ifdef CONFIG_IPC_CLASSES
+static int __percpu *hfi_ipcc_scores;
+
+static int alloc_hfi_ipcc_scores(void)
+{
+	hfi_ipcc_scores = __alloc_percpu(sizeof(*hfi_ipcc_scores) *
+					 hfi_features.nr_classes,
+					 sizeof(*hfi_ipcc_scores));
+
+	return !hfi_ipcc_scores;
+}
+
+static void set_hfi_ipcc_score(void *caps, int cpu)
+{
+	int i, *hfi_class = per_cpu_ptr(hfi_ipcc_scores, cpu);
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
@@ -194,6 +224,8 @@ static void get_hfi_caps(struct hfi_instance *hfi_instance,
 		cpu_caps[i].efficiency = caps->ee_cap << 2;
 
 		++i;
+
+		set_hfi_ipcc_score(caps, cpu);
 	}
 	raw_spin_unlock_irq(&hfi_instance->table_lock);
 }
@@ -572,8 +604,14 @@ void __init intel_hfi_init(void)
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

