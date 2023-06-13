Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F2472D87E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbjFMEXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239335AbjFMEWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:22:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9DB1734;
        Mon, 12 Jun 2023 21:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630114; x=1718166114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Rg6bBLEQ3AC4QDzW6yr8kT0VDnQBk2LkMuNm2FBH7m4=;
  b=KTPz9mb27IBpJnSggCKlaeBB0xZ5nQdVRqzBHO/LXGSgLzgvw5oY+20H
   3i7YxXtGBSbGNrkgmUiwhWt7WS9J+yDThGMx5Kt2XFpvY+z19Lest6Y5i
   2P1K81sF9W+WaNsEeCRRB+prch9ICqniNy4O8osHEITmrvdkDa45KfzBO
   Ovw6JPKfw3BpMZS5pKO8lmTEr9YCevz9s7h18qRrItZzhOqDpcIvpFzzF
   +dMrOYMxOhd1O1NwVOuIQI3VrXVgrQ31+L8UIK/8UBpSZYPxY9m1fGFxO
   kCvmogFVXA9jHKVUdkNWTtUhTRq9aSJqk6E+mhTNW71+GrPiCMrQX9g4k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222201"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222201"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:21:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661854974"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661854974"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:21:52 -0700
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
Subject: [PATCH v4 14/24] thermal: intel: hfi: Store per-CPU IPCC scores
Date:   Mon, 12 Jun 2023 21:24:12 -0700
Message-Id: <20230613042422.5344-15-ricardo.neri-calderon@linux.intel.com>
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

The scheduler reads the IPCC scores when balancing load. These reads can
occur frequently and originate from many CPUs. Hardware may also
occasionally update the HFI table. Controlling access with locks would
cause contention.

Cache the IPCC scores in separate per-CPU variables that the scheduler can
use. Use a seqcount to synchronize memory accesses to these cached values.
This eliminates the need for locks, as the sequence counter provides the
memory ordering required to prevent the use of stale data.

The HFI delayed workqueue guarantees that only one CPU writes the cached
IPCC scores. The frequency of updates is low (every CONFIG_HZ jiffies or
less), and the number of writes per update is in the order of tens. Writes
should not starve reads.

Only cache IPCC scores in this changeset. A subsequent changeset will
use these scores.

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
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * As Rafael requested, I reworked the memory ordering of the cached IPCC
   scores. I selected a seqcount as is less expensive than a memory
   barrier, which is not necessary anyways.
 * Made alloc_hfi_ipcc_scores() return -ENOMEM on allocation failure.
   (Rafael)
 * Added a comment to describe hfi_ipcc_scores. (Rafael)

Changes since v2:
 * Only create these per-CPU variables when Intel Thread Director is
   supported.

Changes since v1:
 * Added this patch.
---
 drivers/thermal/intel/intel_hfi.c | 66 +++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 20ee4264dcd4..d822ed0bb5c1 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -29,9 +29,11 @@
 #include <linux/kernel.h>
 #include <linux/math.h>
 #include <linux/mutex.h>
+#include <linux/percpu.h>
 #include <linux/percpu-defs.h>
 #include <linux/printk.h>
 #include <linux/processor.h>
+#include <linux/seqlock.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
@@ -180,6 +182,62 @@ static struct workqueue_struct *hfi_updates_wq;
 #define HFI_UPDATE_INTERVAL		HZ
 #define HFI_MAX_THERM_NOTIFY_COUNT	16
 
+/* A cache of the HFI perf capabilities for lockless access. */
+static int __percpu *hfi_ipcc_scores;
+/* Sequence counter for hfi_ipcc_scores */
+static seqcount_t hfi_ipcc_seqcount = SEQCNT_ZERO(hfi_ipcc_seqcount);
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
+	return hfi_ipcc_scores ? 0 : -ENOMEM;
+}
+
+static void set_hfi_ipcc_scores(struct hfi_instance *hfi_instance)
+{
+	int cpu;
+
+	if (!cpu_feature_enabled(X86_FEATURE_ITD))
+		return;
+
+	/*
+	 * Serialize with writes to the HFI table. It also protects the write
+	 * loop against seqcount readers running in interrupt context.
+	 */
+	raw_spin_lock_irq(&hfi_instance->table_lock);
+	/*
+	 * The seqcount implies store-release semantics to order stores with
+	 * lockless loads from the seqcount read side. It also implies a
+	 * compiler barrier.
+	 */
+	write_seqcount_begin(&hfi_ipcc_seqcount);
+	for_each_cpu(cpu, hfi_instance->cpus) {
+		int c, *scores;
+		s16 index;
+
+		index = per_cpu(hfi_cpu_info, cpu).index;
+		scores = per_cpu_ptr(hfi_ipcc_scores, cpu);
+
+		for (c = 0;  c < hfi_features.nr_classes; c++) {
+			struct hfi_cpu_data *caps;
+
+			caps = hfi_instance->data +
+			       index * hfi_features.cpu_stride +
+			       c * hfi_features.class_stride;
+			scores[c] = caps->perf_cap;
+		}
+	}
+
+	write_seqcount_end(&hfi_ipcc_seqcount);
+	raw_spin_unlock_irq(&hfi_instance->table_lock);
+}
+
 /**
  * intel_hfi_read_classid() - Read the currrent classid
  * @classid:	Variable to which the classid will be written.
@@ -275,6 +333,8 @@ static void update_capabilities(struct hfi_instance *hfi_instance)
 		thermal_genl_cpu_capability_event(cpu_count, &cpu_caps[i]);
 
 	kfree(cpu_caps);
+
+	set_hfi_ipcc_scores(hfi_instance);
 out:
 	mutex_unlock(&hfi_instance_lock);
 }
@@ -618,8 +678,14 @@ void __init intel_hfi_init(void)
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

