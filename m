Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C91D63A939
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiK1NOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiK1NNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:13:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0681706C;
        Mon, 28 Nov 2022 05:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669641220; x=1701177220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ChhBXDi6i4cO+o51+tVzAGA9ljkMrmhRzO0pv8QvdKc=;
  b=ePLdhY1iJLhxEHUW+R/17wYTQOjttdYPbQAMe9rF7Juv61tJWUUhN1Pf
   CeVD10Hmwt2tSgAHdCWhkFMmDrJ2pzxLnAF+TbBR0H3b30puxwVHjyaEH
   zpl7/dV9D0DPpVYv9tWhPya+aOuL7Pu5e6O6hlyxrM3a1WyRXjwoEDyvU
   m2/bZyISvkNrZj8bsBbdgr7p1w+eaxIN89k7nDapS6Xpum/9VligD797g
   1nH45GwJAfrA2O7e3gGEyVvwsQDW9ZKk5tttnbm18bqBnyHaLRIawpDVb
   lnzkYVWmAfB/kfVQqGAWc2/ImZJzfu6VVXis0dfI8WxHgCLKBZFY2X1Zj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401117189"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401117189"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:13:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749381374"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749381374"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2022 05:13:34 -0800
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
Subject: [PATCH v2 14/22] thermal: intel: hfi: Report the IPC class score of a CPU
Date:   Mon, 28 Nov 2022 05:20:52 -0800
Message-Id: <20221128132100.30253-15-ricardo.neri-calderon@linux.intel.com>
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

Implement the arch_get_ipcc_score() interface of the scheduler. Use the
performance capabilities of the extended Hardware Feedback Interface table
as the IPC score of a class of tasks when placed on a given CPU.

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
 * Adjusted the returned HFI class (which starts at 0) to match the
   scheduler IPCC class (which starts at 1). (PeterZ)
 * Used the new interface names.
---
 arch/x86/include/asm/topology.h   |  2 ++
 drivers/thermal/intel/intel_hfi.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index cf46a3aea283..0fae13058f01 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -230,9 +230,11 @@ void init_freq_invariance_cppc(void);
 #if defined(CONFIG_IPC_CLASSES) && defined(CONFIG_INTEL_HFI_THERMAL)
 int intel_hfi_has_ipc_classes(void);
 void intel_hfi_update_ipcc(struct task_struct *curr);
+int intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu);
 
 #define arch_has_ipc_classes intel_hfi_has_ipc_classes
 #define arch_update_ipcc intel_hfi_update_ipcc
+#define arch_get_ipcc_score intel_hfi_get_ipcc_score
 #endif /* defined(CONFIG_IPC_CLASSES) && defined(CONFIG_INTEL_HFI_THERMAL) */
 
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index f85394b532a7..1f7b18198bd4 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -213,6 +213,33 @@ void intel_hfi_update_ipcc(struct task_struct *curr)
 	curr->ipcc = msr.split.classid + 1;
 }
 
+int intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu)
+{
+	unsigned short hfi_class;
+	int *scores;
+
+	if (cpu < 0 || cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	if (ipcc == IPC_CLASS_UNCLASSIFIED)
+		return -EINVAL;
+
+	/*
+	 * Scheduler IPC classes start at 1. HFI classes start at 0.
+	 * See note intel_hfi_update_ipcc().
+	 */
+	hfi_class = ipcc - 1;
+
+	if (hfi_class >= hfi_features.nr_classes)
+		return -EINVAL;
+
+	scores = per_cpu_ptr(hfi_ipcc_scores, cpu);
+	if (!scores)
+		return -ENODEV;
+
+	return READ_ONCE(scores[hfi_class]);
+}
+
 static int alloc_hfi_ipcc_scores(void)
 {
 	hfi_ipcc_scores = __alloc_percpu(sizeof(*hfi_ipcc_scores) *
-- 
2.25.1

