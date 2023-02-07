Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5A568CE9A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjBGFDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjBGFB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:01:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C74CCDF1;
        Mon,  6 Feb 2023 21:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675746117; x=1707282117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=A+SMOZzgEsVxAgLjF6sCJ/1gpwfA0tMbTNw8B4DLAIM=;
  b=fCIWpLnWvVOZblBGvUfz1mfcwQWd0Wj6VTVW0bEwvGTCk23O+ZGxeuld
   jjtcNSGAX6l4iZ/W9PZlReroJ2vApzJ3USF1g8Lm5qUnqlG7JT1qMWDI0
   H6FNfi+ZqU1aCCQh8BNlveiPN+RIkkMHbCJ10uUqyWtocDETvtzI67hYH
   hj9Z0//AAgnDnozgPFdehOz5Miy7HNxQ9O9luBHuopvI18PATDNOP04hv
   0kmhNvELgkcUgxUUwU9wzBR/rmZt6fH1Go/E3a8qZeLjprt4QZbQHVhjZ
   uunENef9sTQ0wGONgCJh2cT7ncG+dxubU8Opat1VDUcw4tNLBdVseObBe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415625902"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415625902"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 21:01:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668657752"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668657752"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 21:01:44 -0800
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
Subject: [PATCH v3 15/24] thermal: intel: hfi: Report the IPC class score of a CPU
Date:   Mon,  6 Feb 2023 21:10:56 -0800
Message-Id: <20230207051105.11575-16-ricardo.neri-calderon@linux.intel.com>
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

Implement the arch_get_ipcc_score() interface of the scheduler. Use the
performance capabilities of the extended Hardware Feedback Interface table
as the IPC score.

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
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 * None

Changes since v1:
 * Adjusted the returned HFI class (which starts at 0) to match the
   scheduler IPCC class (which starts at 1). (PeterZ)
 * Used the new interface names.
---
 arch/x86/include/asm/topology.h   |  2 ++
 drivers/thermal/intel/intel_hfi.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index ffcdac3f398f..c4fcd9c3c634 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -229,8 +229,10 @@ void init_freq_invariance_cppc(void);
 
 #if defined(CONFIG_IPC_CLASSES) && defined(CONFIG_INTEL_HFI_THERMAL)
 void intel_hfi_update_ipcc(struct task_struct *curr);
+unsigned long intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu);
 
 #define arch_update_ipcc intel_hfi_update_ipcc
+#define arch_get_ipcc_score intel_hfi_get_ipcc_score
 #endif /* defined(CONFIG_IPC_CLASSES) && defined(CONFIG_INTEL_HFI_THERMAL) */
 
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 530dcf57e06e..fa9b4a678d92 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -206,6 +206,33 @@ void intel_hfi_update_ipcc(struct task_struct *curr)
 	curr->ipcc = msr.split.classid + 1;
 }
 
+unsigned long intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu)
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
 	if (!cpu_feature_enabled(X86_FEATURE_ITD))
-- 
2.25.1

