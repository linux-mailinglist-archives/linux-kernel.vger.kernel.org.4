Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A223A72D889
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbjFMEYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239331AbjFMEXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:23:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BBA1FCE;
        Mon, 12 Jun 2023 21:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630121; x=1718166121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WzB7EIesme5f3MZe0K+4oIdjGvzQwrDPxjYwpN58ncc=;
  b=EOLMGIUz+iZigu//V0TNAjS38rUotldulUFi6kmtkyOftaSfBbfZiLel
   1b/+3eIqkhCTBC75+NIYMdX7N+4ET6PMPPwoszeH5P/XoTgKL+OPBBhYh
   ssyR/Tq1H/HTA2RQduf1uIPdJWB6Zng+Fofi9SINHCpBQf0Pup3EeEm6Z
   U6uUSb/XUlNTB/NJLzcU1HQ1IedTv/vXp58fXmQoJyxaUQ7TqYPEmcFm5
   BpLFTN4pMblYv0l6raZktbTPSY7AhHaQRBuR7mTQXEQeBI9Mm+um5GlsD
   O3P9GpkYVhmKxCQ7Zi0pefBJaUplpzXHKpaX2TFTYZdwTZ1TLTe/tkpv4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222229"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222229"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:21:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661854984"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661854984"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:21:56 -0700
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
Subject: [PATCH v4 17/24] thermal: intel: hfi: Enable the Intel Thread Director
Date:   Mon, 12 Jun 2023 21:24:15 -0700
Message-Id: <20230613042422.5344-18-ricardo.neri-calderon@linux.intel.com>
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

Enable Intel Thread Director from the CPU hotplug callback: globally from
CPU0 and then enable the thread-classification hardware in each logical
processor individually.

Also, initialize the number of classes supported.

Let the scheduler know that it can start using IPC classes.

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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com> # intel_hfi.c
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * Dropped the definition of MSR_IA32_HW_FEEDBACK_CHAR. It is now added in
   patch 14 to fix a build break during bisection.
   (Reported-by: kernel test robot <lkp@intel.com>).
 * Added Acked-by from Rafael.

Changes since v2:
 * Use the new sched_enable_ipc_classes() interface to enable the use of
   IPC classes in the scheduler.

Changes since v1:
 * None
---
 arch/x86/include/asm/msr-index.h  |  1 +
 drivers/thermal/intel/intel_hfi.c | 41 +++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 0bc4ed0ff787..7823b87bf383 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1108,6 +1108,7 @@
 /* Hardware Feedback Interface */
 #define MSR_IA32_HW_FEEDBACK_PTR        0x17d0
 #define MSR_IA32_HW_FEEDBACK_CONFIG     0x17d1
+#define MSR_IA32_HW_FEEDBACK_THREAD_CONFIG 0x17d4
 #define MSR_IA32_HW_FEEDBACK_CHAR	0x17d2
 
 /* x2APIC locked status */
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index e23c49da02ee..75bf18dc7f51 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -33,6 +33,7 @@
 #include <linux/percpu-defs.h>
 #include <linux/printk.h>
 #include <linux/processor.h>
+#include <linux/sched/topology.h>
 #include <linux/seqlock.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -50,6 +51,8 @@
 /* Hardware Feedback Interface MSR configuration bits */
 #define HW_FEEDBACK_PTR_VALID_BIT		BIT(0)
 #define HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT	BIT(0)
+#define HW_FEEDBACK_CONFIG_ITD_ENABLE_BIT	BIT(1)
+#define HW_FEEDBACK_THREAD_CONFIG_ENABLE_BIT	BIT(0)
 
 /* CPUID detection and enumeration definitions for HFI */
 
@@ -74,6 +77,15 @@ union cpuid6_edx {
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
 union hfi_thread_feedback_char_msr {
 	struct {
 		u64	classid : 8;
@@ -541,6 +553,11 @@ void intel_hfi_online(unsigned int cpu)
 
 	init_hfi_cpu_index(info);
 
+	if (cpu_feature_enabled(X86_FEATURE_ITD)) {
+		msr_val = HW_FEEDBACK_THREAD_CONFIG_ENABLE_BIT;
+		wrmsrl(MSR_IA32_HW_FEEDBACK_THREAD_CONFIG, msr_val);
+	}
+
 	/*
 	 * Now check if the HFI instance of the package/die of @cpu has been
 	 * initialized (by checking its header). In such case, all we have to
@@ -596,8 +613,22 @@ void intel_hfi_online(unsigned int cpu)
 	 */
 	rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 	msr_val |= HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
+
+	if (cpu_feature_enabled(X86_FEATURE_ITD))
+		msr_val |= HW_FEEDBACK_CONFIG_ITD_ENABLE_BIT;
+
 	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 
+	/*
+	 * We have all we need to support IPC classes. Task classification is
+	 * now working.
+	 *
+	 * All class scores are zero until after the first HFI update. That is
+	 * OK. The scheduler queries these scores at every load balance.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_ITD))
+		sched_enable_ipc_classes();
+
 unlock:
 	mutex_unlock(&hfi_instance_lock);
 	return;
@@ -675,8 +706,14 @@ static __init int hfi_parse_features(void)
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

