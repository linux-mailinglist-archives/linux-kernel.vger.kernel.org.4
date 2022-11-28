Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B9463A93A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiK1NOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiK1NNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:13:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62372DCD;
        Mon, 28 Nov 2022 05:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669641219; x=1701177219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=6edsBDhndxufd+3EwJXKfsHyRlYl4SM2zX6wq8H/56U=;
  b=OzSNHXalsHBm3jZdROfgz1/kUfd36h+u4RkznczD5jae31akEp2HLtoI
   GU+8kO2KdFMWV/HLxBZHebThJKcj54O8vgTIp6AIv3RjhGDVpcWya+MQ8
   YujLMP2fiO6j9iWyTx3yhzoG49/IJ85wd8/UgYwGCOmpMzHVID0HzgDCO
   6o7mGpKPv3+u7ia2XzUBjywjqdp4RZbUJG6Ur0LyrhvbAH9eoPw+g5uus
   gZcbH+OewhalZbqqqkwGIsd/OlZusxkcJDFvV8r0Qt/Yv1NQ7GIvDQGJQ
   N4kZyvB1OpvwGWwM0hwA9zun0qqIl7cz6tgPTlL07cHkHyEFYOH6a86WR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401117214"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401117214"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749381384"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749381384"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2022 05:13:35 -0800
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
Subject: [PATCH v2 16/22] thermal: intel: hfi: Enable the Intel Thread Director
Date:   Mon, 28 Nov 2022 05:20:54 -0800
Message-Id: <20221128132100.30253-17-ricardo.neri-calderon@linux.intel.com>
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

Enable Intel Thread Director from the CPU hotplug callback: globally from
CPU0 and then enable the thread-classification hardware in each logical
processor individually.

Also, initialize the number of classes supported.

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
 * None
---
 arch/x86/include/asm/msr-index.h  |  2 ++
 drivers/thermal/intel/intel_hfi.c | 30 ++++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 37ff47552bcb..96303330223b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1075,6 +1075,8 @@
 /* Hardware Feedback Interface */
 #define MSR_IA32_HW_FEEDBACK_PTR        0x17d0
 #define MSR_IA32_HW_FEEDBACK_CONFIG     0x17d1
+#define MSR_IA32_HW_FEEDBACK_THREAD_CONFIG 0x17d4
+#define MSR_IA32_HW_FEEDBACK_CHAR	0x17d2
 
 /* x2APIC locked status */
 #define MSR_IA32_XAPIC_DISABLE_STATUS	0xBD
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 1b3fd704ae9a..8287bfd7d6b6 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -50,6 +50,8 @@
 /* Hardware Feedback Interface MSR configuration bits */
 #define HW_FEEDBACK_PTR_VALID_BIT		BIT(0)
 #define HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT	BIT(0)
+#define HW_FEEDBACK_CONFIG_ITD_ENABLE_BIT	BIT(1)
+#define HW_FEEDBACK_THREAD_CONFIG_ENABLE_BIT	BIT(0)
 
 /* CPUID detection and enumeration definitions for HFI */
 
@@ -74,6 +76,15 @@ union cpuid6_edx {
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
 #ifdef CONFIG_IPC_CLASSES
 union hfi_thread_feedback_char_msr {
 	struct {
@@ -495,6 +506,11 @@ void intel_hfi_online(unsigned int cpu)
 
 	init_hfi_cpu_index(info);
 
+	if (cpu_feature_enabled(X86_FEATURE_ITD)) {
+		msr_val = HW_FEEDBACK_THREAD_CONFIG_ENABLE_BIT;
+		wrmsrl(MSR_IA32_HW_FEEDBACK_THREAD_CONFIG, msr_val);
+	}
+
 	/*
 	 * Now check if the HFI instance of the package/die of @cpu has been
 	 * initialized (by checking its header). In such case, all we have to
@@ -550,6 +566,10 @@ void intel_hfi_online(unsigned int cpu)
 	 */
 	rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 	msr_val |= HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
+
+	if (cpu_feature_enabled(X86_FEATURE_ITD))
+		msr_val |= HW_FEEDBACK_CONFIG_ITD_ENABLE_BIT;
+
 	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 
 unlock:
@@ -629,8 +649,14 @@ static __init int hfi_parse_features(void)
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

