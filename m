Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A35068CE9D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjBGFDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjBGFB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:01:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78A26EBF;
        Mon,  6 Feb 2023 21:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675746117; x=1707282117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=3ZodASqqSSM2NIj1LSnSMKhTz+ez7n5TchQdgqVyKMk=;
  b=cf3RcTOkwDxK/NR3BWE33SHlTo7EtZxQEsk/ll545VQT14y2JO6ZaclE
   FP+2ti8Bzb61Sst5OGfjNqF23wahIOHdpU6++RAAsvcssP0J4pn6d4/Cb
   D7O7oYuFeRapk0b96g2ehWZj/YxfsCQU+avvB65ooJTzxmLLVYc67Xpc8
   DGmU+eOTBhyAweTDJHMgr1bqc5lErPud88NxWOd93bTZO0c8rdObktfsf
   fAJQD/AH7uEOd6scEKRIjli/Ksi6ntnHo4WOTcsGWJrHVVOtu0ZVUqMZw
   A1mtrQKDfki2gCri0mN2zGkTRDc8y86fWRwgkI+8kWO2QWht0csLSO9Pu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415625917"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415625917"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 21:01:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668657758"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668657758"
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
Subject: [PATCH v3 17/24] thermal: intel: hfi: Enable the Intel Thread Director
Date:   Mon,  6 Feb 2023 21:10:58 -0800
Message-Id: <20230207051105.11575-18-ricardo.neri-calderon@linux.intel.com>
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
 * Use the new sched_enable_ipc_classes() interface to enable the use of
   IPC classes in the scheduler.

Changes since v1:
 * None
---
 arch/x86/include/asm/msr-index.h  |  2 ++
 drivers/thermal/intel/intel_hfi.c | 40 +++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index ad35355ee43e..0ea25cc9c621 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1106,6 +1106,8 @@
 /* Hardware Feedback Interface */
 #define MSR_IA32_HW_FEEDBACK_PTR        0x17d0
 #define MSR_IA32_HW_FEEDBACK_CONFIG     0x17d1
+#define MSR_IA32_HW_FEEDBACK_THREAD_CONFIG 0x17d4
+#define MSR_IA32_HW_FEEDBACK_CHAR	0x17d2
 
 /* x2APIC locked status */
 #define MSR_IA32_XAPIC_DISABLE_STATUS	0xBD
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 7ea6acce7107..35d947f47550 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -48,6 +48,8 @@
 /* Hardware Feedback Interface MSR configuration bits */
 #define HW_FEEDBACK_PTR_VALID_BIT		BIT(0)
 #define HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT	BIT(0)
+#define HW_FEEDBACK_CONFIG_ITD_ENABLE_BIT	BIT(1)
+#define HW_FEEDBACK_THREAD_CONFIG_ENABLE_BIT	BIT(0)
 
 /* CPUID detection and enumeration definitions for HFI */
 
@@ -72,6 +74,15 @@ union cpuid6_edx {
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
@@ -506,6 +517,11 @@ void intel_hfi_online(unsigned int cpu)
 
 	init_hfi_cpu_index(info);
 
+	if (cpu_feature_enabled(X86_FEATURE_ITD)) {
+		msr_val = HW_FEEDBACK_THREAD_CONFIG_ENABLE_BIT;
+		wrmsrl(MSR_IA32_HW_FEEDBACK_THREAD_CONFIG, msr_val);
+	}
+
 	/*
 	 * Now check if the HFI instance of the package/die of @cpu has been
 	 * initialized (by checking its header). In such case, all we have to
@@ -561,8 +577,22 @@ void intel_hfi_online(unsigned int cpu)
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
@@ -640,8 +670,14 @@ static __init int hfi_parse_features(void)
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

