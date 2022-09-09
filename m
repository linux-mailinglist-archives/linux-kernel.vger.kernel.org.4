Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3635B42CB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiIIXHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiIIXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEE8112B35
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764798; x=1694300798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=n7K7WkJTPPMwFMFFsG9wfZizDgwooozedDH553fMnVM=;
  b=iOKcMIkZ0NrXHXB01EN37dj8FuHXKbELSmrE0CPMdMTh3D4CJNFKOJlV
   Vyj1ipehAgTwjUJlukziWv8ndGa9Bzdv9Oe1tG8ZRu9ZJTmQ6KjRrL8UZ
   BOaWFjbn0tosxBr2ExNOXVIErCfS3k4KPbtVIM9xS6vuyK3jWyrrI/VVB
   BItZbxJ2Gs9Dbqc/Ungq8tmVYXGx7Lg6b5rqNUwygOHRYiC3WneBhN+0E
   klCVYU76naZVrxD45vMLszCpYBPcsJxLdPkBXFDxd4QKiP8C0UlWN+UGf
   q3+N4xMcBtRlDXic+69Ih+D0Jwf8ehbZm2UOSFcVHoiIr8+N2Sq7hm0u2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298386921"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="298386921"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677355032"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 16:06:35 -0700
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
Subject: [RFC PATCH 17/23] thermal: intel: hfi: Enable the Intel Thread Director
Date:   Fri,  9 Sep 2022 16:11:59 -0700
Message-Id: <20220909231205.14009-18-ricardo.neri-calderon@linux.intel.com>
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

Enable Intel Thread Director from the CPU hotplug callback: globally from
CPU0 and then enable the thread-classification hardware in each logical
processor individually.

Also, initialize the number of classes supported.

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
 arch/x86/include/asm/msr-index.h  |  2 ++
 drivers/thermal/intel/Kconfig     | 12 ++++++++++++
 drivers/thermal/intel/intel_hfi.c | 30 ++++++++++++++++++++++++++++--
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6674bdb096f3..810b950dc2e0 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1053,5 +1053,7 @@
 /* Hardware Feedback Interface */
 #define MSR_IA32_HW_FEEDBACK_PTR        0x17d0
 #define MSR_IA32_HW_FEEDBACK_CONFIG     0x17d1
+#define MSR_IA32_HW_FEEDBACK_THREAD_CONFIG 0x17d4
+#define MSR_IA32_HW_FEEDBACK_CHAR	0x17d2
 
 #endif /* _ASM_X86_MSR_INDEX_H */
diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index f0c845679250..8848bf45ffbc 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -113,3 +113,15 @@ config INTEL_HFI_THERMAL
 	  These capabilities may change as a result of changes in the operating
 	  conditions of the system such power and thermal limits. If selected,
 	  the kernel relays updates in CPUs' capabilities to userspace.
+
+config INTEL_THREAD_DIRECTOR
+	bool "Intel Thread Director"
+	depends on INTEL_HFI_THERMAL
+	depends on SMP
+	select SCHED_TASK_CLASSES
+	help
+	  Select this option to enable the Intel Thread Director. If selected,
+	  hardware classifies tasks based on the type of instructions they
+	  execute. It also provides performance capabilities for each class of
+	  task. On hybrid processors, the scheduler uses this data to place
+	  tasks of classes of higher performance on higher-performnance CPUs.
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 967899d2c01f..9ddd3047eb39 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -49,6 +49,8 @@
 /* Hardware Feedback Interface MSR configuration bits */
 #define HW_FEEDBACK_PTR_VALID_BIT		BIT(0)
 #define HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT	BIT(0)
+#define HW_FEEDBACK_CONFIG_ITD_ENABLE_BIT	BIT(1)
+#define HW_FEEDBACK_THREAD_CONFIG_ENABLE_BIT	BIT(0)
 
 /* CPUID detection and enumeration definitions for HFI */
 
@@ -73,6 +75,15 @@ union cpuid6_edx {
 	u32 full;
 };
 
+union cpuid6_ecx {
+	struct {
+		u32	dont_care0:8;
+		u32	nr_classes:8;
+		u32	dont_care1:16;
+	} split;
+	u32 full;
+};
+
 #ifdef CONFIG_INTEL_THREAD_DIRECTOR
 union hfi_thread_feedback_char_msr {
 	struct {
@@ -481,6 +492,11 @@ void intel_hfi_online(unsigned int cpu)
 
 	init_hfi_cpu_index(info);
 
+	if (cpu_feature_enabled(X86_FEATURE_ITD)) {
+		msr_val = HW_FEEDBACK_THREAD_CONFIG_ENABLE_BIT;
+		wrmsrl(MSR_IA32_HW_FEEDBACK_THREAD_CONFIG, msr_val);
+	}
+
 	/*
 	 * Now check if the HFI instance of the package/die of @cpu has been
 	 * initialized (by checking its header). In such case, all we have to
@@ -536,6 +552,10 @@ void intel_hfi_online(unsigned int cpu)
 	 */
 	rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 	msr_val |= HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
+
+	if (cpu_feature_enabled(X86_FEATURE_ITD))
+		msr_val |= HW_FEEDBACK_CONFIG_ITD_ENABLE_BIT;
+
 	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 
 unlock:
@@ -615,8 +635,14 @@ static __init int hfi_parse_features(void)
 	 */
 	hfi_features.class_stride = nr_capabilities;
 
-	/* For now, use only one class of the HFI table */
-	hfi_features.nr_classes = 1;
+	if (cpu_feature_enabled(X86_FEATURE_ITD)) {
+		union cpuid6_ecx ecx;
+
+		ecx.full = cpuid_ecx(CPUID_HFI_LEAF);
+		hfi_features.nr_classes = ecx.split.nr_classes;
+	} else {
+		hfi_features.nr_classes = 1;
+	}
 
 	/*
 	 * The header contains change indications for each supported feature.
-- 
2.25.1

