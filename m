Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F015B42D3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiIIXHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiIIXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26DC1153A5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764797; x=1694300797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=V+XE+HwnTyiz33d+vGV9bfegjagMw1gGclttOzUh/uQ=;
  b=WFXHjmJXBwuKjp/fIG+G2ARoxUOMZ9rhHBGoy2XnFZ+5XzvWNMHBk+/X
   8hv9lb/X9OdVpJh/hnqblREa61qviKkxzJx0R989H9WmeH1dkzTQeG2CB
   X5u+/IdvmBhjlbuuh/ccRag65tJGHxquA8nnhlcaOT6aLy9X/wY403EcV
   ZrU2CAOgPnZ0qmJWqIO9O1RDoYjOE2NCVSFWaaaXDHDUTnGlhX3RtVurv
   MkqBlxNEvinFLMJn5g+YykM9xzBZyfHbiQ9UQ8pD0Fm3CbSJbFsKqytEM
   H/8GuB0HVLfGqNobuiDILL5WC+lrd1cs/6y0tWzq7IrxPoUM5J0SlDcEI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298386919"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="298386919"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677355024"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 16:06:34 -0700
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
Subject: [RFC PATCH 15/23] thermal: intel: hfi: Report per-cpu class-specific performance scores
Date:   Fri,  9 Sep 2022 16:11:57 -0700
Message-Id: <20220909231205.14009-16-ricardo.neri-calderon@linux.intel.com>
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

Support the arch_get_task_class_score() interface of the scheduler. Use the
data that Intel Thread Director provides to inform the scheduler the
performance of a class of tasks when placed on a given CPU.

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
 arch/x86/include/asm/topology.h   |  2 ++
 drivers/thermal/intel/intel_hfi.c | 40 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 9c6df4fd9414..2ed234104ef4 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -230,9 +230,11 @@ void init_freq_invariance_cppc(void);
 #ifdef CONFIG_INTEL_THREAD_DIRECTOR
 int intel_hfi_has_task_classes(void);
 void intel_hfi_update_task_class(struct task_struct *curr, bool smt_siblings_idle);
+int intel_hfi_get_task_class_score(int class, int cpu);
 
 #define arch_has_task_classes intel_hfi_has_task_classes
 #define arch_update_task_class intel_hfi_update_task_class
+#define arch_get_task_class_score intel_hfi_get_task_class_score
 #endif
 
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index f46d9331f912..1b6072c828ff 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -205,6 +205,46 @@ void intel_hfi_update_task_class(struct task_struct *curr, bool smt_siblings_idl
 
 	curr->class = msr.split.classid;
 }
+
+static void get_one_hfi_cap(struct hfi_instance *hfi_instance, s16 index,
+			    struct hfi_cpu_data *hfi_caps, int class)
+{
+	struct hfi_cpu_data *caps;
+
+	/* Find the capabilities of @cpu */
+	caps = hfi_instance->data + index * hfi_features.cpu_stride +
+	       class * hfi_features.class_stride;
+	memcpy(hfi_caps, caps, sizeof(*hfi_caps));
+}
+
+int intel_hfi_get_task_class_score(int class, int cpu)
+{
+	struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, cpu);
+	struct hfi_instance *instance;
+	struct hfi_cpu_data caps;
+	unsigned long flags;
+	int cap;
+
+	if (cpu < 0 || cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	if (class == TASK_CLASS_UNCLASSIFIED)
+		return -EINVAL;
+
+	if (class >= (int)hfi_features.nr_classes)
+		return -EINVAL;
+
+	instance = info->hfi_instance;
+	if (!instance)
+		return -ENOENT;
+
+	raw_spin_lock_irqsave(&instance->table_lock, flags);
+	get_one_hfi_cap(instance, info->index, &caps, class);
+	cap = caps.perf_cap;
+	raw_spin_unlock_irqrestore(&instance->table_lock, flags);
+
+	return cap;
+}
 #endif /* CONFIG_INTEL_THREAD_DIRECTOR */
 
 static void get_hfi_caps(struct hfi_instance *hfi_instance,
-- 
2.25.1

