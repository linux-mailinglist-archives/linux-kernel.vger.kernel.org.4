Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A47763A938
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiK1NOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiK1NNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:13:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDEFA46F;
        Mon, 28 Nov 2022 05:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669641219; x=1701177219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ElamVYUpgDqJdxkmls7IkTtE4f7JXYRsemQvg1xBFFc=;
  b=Ku9+ujnj0jt1DV4ZEqWbFcflA/Y5vkn34TyYe0Bz1h7aC2yrSAKha9K5
   N0lM62DkG2hcWWgGMPqRYervSHCKX1FgnHYN3bZzBOWw/nCdF4cZAAabx
   yZ2Dn00nr8wrnuvhUKP5tlO6rpzbEBdpJCn/lt6G0gFV1IrD6WR2uxqNw
   jhRlK+Lk6xMXvkEsVtrRQkUG8Kn269QlSWABtxPaP6abUCeGp3gdoEbmN
   GsQL5cZzxMf4HiBs8/QNTD1JqmCWHnCDH1xGSPH1/BxS8Usx1NMF1s3vj
   Vy5wNR1uow/QWbttI5ioYBPHhIvvXGgfpnz/YNrnp6OPd0tXLEH2GRQYB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401117179"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401117179"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:13:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749381369"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749381369"
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
Subject: [PATCH v2 13/22] thermal: intel: hfi: Update the IPC class of the current task
Date:   Mon, 28 Nov 2022 05:20:51 -0800
Message-Id: <20221128132100.30253-14-ricardo.neri-calderon@linux.intel.com>
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

Use Intel Thread Director classification to update the IPC class of a
task. Implement the needed scheduler interfaces.

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
 * Redefined union hfi_thread_feedback_char_msr to ensure all
   bit-fields are packed. (PeterZ)
 * Removed CONFIG_INTEL_THREAD_DIRECTOR. (PeterZ)
 * Shortened the names of the functions that implement IPC classes.
 * Removed argument smt_siblings_idle from intel_hfi_update_ipcc().
   (PeterZ)
---
 arch/x86/include/asm/topology.h   |  8 +++++++
 drivers/thermal/intel/intel_hfi.c | 37 +++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 458c891a8273..cf46a3aea283 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -227,4 +227,12 @@ void init_freq_invariance_cppc(void);
 #define arch_init_invariance_cppc init_freq_invariance_cppc
 #endif
 
+#if defined(CONFIG_IPC_CLASSES) && defined(CONFIG_INTEL_HFI_THERMAL)
+int intel_hfi_has_ipc_classes(void);
+void intel_hfi_update_ipcc(struct task_struct *curr);
+
+#define arch_has_ipc_classes intel_hfi_has_ipc_classes
+#define arch_update_ipcc intel_hfi_update_ipcc
+#endif /* defined(CONFIG_IPC_CLASSES) && defined(CONFIG_INTEL_HFI_THERMAL) */
+
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 56dba967849c..f85394b532a7 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -74,6 +74,17 @@ union cpuid6_edx {
 	u32 full;
 };
 
+#ifdef CONFIG_IPC_CLASSES
+union hfi_thread_feedback_char_msr {
+	struct {
+		u64	classid : 8;
+		u64	__reserved : 55;
+		u64	valid : 1;
+	} split;
+	u64 full;
+};
+#endif
+
 /**
  * struct hfi_cpu_data - HFI capabilities per CPU
  * @perf_cap:		Performance capability
@@ -176,6 +187,32 @@ static struct workqueue_struct *hfi_updates_wq;
 #ifdef CONFIG_IPC_CLASSES
 static int __percpu *hfi_ipcc_scores;
 
+int intel_hfi_has_ipc_classes(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_ITD);
+}
+
+void intel_hfi_update_ipcc(struct task_struct *curr)
+{
+	union hfi_thread_feedback_char_msr msr;
+
+	/* We should not be here if ITD is not supported. */
+	if (!cpu_feature_enabled(X86_FEATURE_ITD)) {
+		pr_warn_once("task classification requested but not supported!");
+		return;
+	}
+
+	rdmsrl(MSR_IA32_HW_FEEDBACK_CHAR, msr.full);
+	if (!msr.split.valid)
+		return;
+
+	/*
+	 * 0 is a valid classification for Intel Thread Director. A scheduler
+	 * IPCC class of 0 means that the task is unclassified. Adjust.
+	 */
+	curr->ipcc = msr.split.classid + 1;
+}
+
 static int alloc_hfi_ipcc_scores(void)
 {
 	hfi_ipcc_scores = __alloc_percpu(sizeof(*hfi_ipcc_scores) *
-- 
2.25.1

