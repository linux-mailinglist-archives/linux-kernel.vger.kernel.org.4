Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0495B42C9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiIIXHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiIIXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C55A115CC4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764798; x=1694300798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=MIecFpx/fYz164sdD9AyklxOPY/JrvhjZ46OYbtFEpc=;
  b=NVdElGE05XuA+fHb4hVamp7prbShAQZ1Ttf3rnc2F9P7cZfrgVZqsfXD
   XLUk5Hzyz06rObQzgpYcaOjHlIiZJyoTVEKnuwoIF4cFi7unc2f7zeFoJ
   1wIIkDw7/Mmnts5x8rR8f/7WN3rES8FaAKtCIIGkAsRD7YVcM8GEM9If3
   hRd/nDm1uJ2jSJmfydrOX99r04MSBBNw5lCrnLlkIMkj8Qr6fvHAQ/8Y9
   SvLJHEUwF2zFADViro/0cqifSpSWt29C/YUQTS75l9DZsV9wFd4yxT4ce
   U6uaO68D4jmb8q0130/MIU7FQLqqXriBCetz6U2AVl4FO7HyEA1vWEJqf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298386918"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="298386918"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677355019"
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
Subject: [RFC PATCH 14/23] thermal: intel: hfi: Update the class of the current task
Date:   Fri,  9 Sep 2022 16:11:56 -0700
Message-Id: <20220909231205.14009-15-ricardo.neri-calderon@linux.intel.com>
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

Support the interfaces of the scheduler for classes of tasks. If an Intel
processor supports Intel Thread Director, then it supports classes of
tasks.

Use the hardware resources that Intel Thread Director provides to assign
a class to the currently running task.

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
 arch/x86/include/asm/topology.h   |  8 +++++++
 drivers/thermal/intel/intel_hfi.c | 35 +++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 458c891a8273..9c6df4fd9414 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -227,4 +227,12 @@ void init_freq_invariance_cppc(void);
 #define arch_init_invariance_cppc init_freq_invariance_cppc
 #endif
 
+#ifdef CONFIG_INTEL_THREAD_DIRECTOR
+int intel_hfi_has_task_classes(void);
+void intel_hfi_update_task_class(struct task_struct *curr, bool smt_siblings_idle);
+
+#define arch_has_task_classes intel_hfi_has_task_classes
+#define arch_update_task_class intel_hfi_update_task_class
+#endif
+
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 4bafe6848d5d..f46d9331f912 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -73,6 +73,17 @@ union cpuid6_edx {
 	u32 full;
 };
 
+#ifdef CONFIG_INTEL_THREAD_DIRECTOR
+union hfi_thread_feedback_char_msr {
+	struct {
+		u8	classid;
+		u64	__reserved:55;
+		u8	valid:1;
+	} split;
+	u64 full;
+};
+#endif
+
 /**
  * struct hfi_cpu_data - HFI capabilities per CPU
  * @perf_cap:		Performance capability
@@ -172,6 +183,30 @@ static struct workqueue_struct *hfi_updates_wq;
 #define HFI_UPDATE_INTERVAL		HZ
 #define HFI_MAX_THERM_NOTIFY_COUNT	16
 
+#ifdef CONFIG_INTEL_THREAD_DIRECTOR
+int intel_hfi_has_task_classes(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_ITD);
+}
+
+void intel_hfi_update_task_class(struct task_struct *curr, bool smt_siblings_idle)
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
+	curr->class = msr.split.classid;
+}
+#endif /* CONFIG_INTEL_THREAD_DIRECTOR */
+
 static void get_hfi_caps(struct hfi_instance *hfi_instance,
 			 struct thermal_genl_cpu_caps *cpu_caps)
 {
-- 
2.25.1

