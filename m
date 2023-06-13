Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2892E72D87D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbjFMEXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbjFMEWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:22:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E794C19B4;
        Mon, 12 Jun 2023 21:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630112; x=1718166112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=sAQ1uZpZ/GyeSOWenRYpSLcOx4BePCSSLjrCLgIxfbo=;
  b=M1+Q8CFCUKIxt2wmqtf/pdblWM21fJbRHXfb+95muJ4pZjnYvJk1ASr+
   clq2H+58OTHabHu4MaFFlimWLxtHO1aOnnf4U/8IYtwx2OMq2m6AzfPgx
   n9pxpjqCnpPhR3K/jgGSiaEHsXwFr0tXU2rgoPEKXpmAqePXIAWjqBIbr
   ORSc7bnwJYb26Mf5su8wzeLbYVFYQD8GflqJ3v00U9zykIAHcChhfhGY4
   XHKC7UMRmhFLEYnE2Wj8r7KL06XfCNcwQXlm5zBTwJFkL331NLXAOwnUt
   Rn/ue3bRW7Xy5hP7o5NHEKrWvv06ecf3bNmqg4qb7CcT37r/6Id9DUnLj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222183"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222183"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:21:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661854971"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661854971"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:21:50 -0700
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
Subject: [PATCH v4 13/24] x86/sched: Update the IPC class of the current task
Date:   Mon, 12 Jun 2023 21:24:11 -0700
Message-Id: <20230613042422.5344-14-ricardo.neri-calderon@linux.intel.com>
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

Intel Thread Director provides a classification value based on the type of
instructions that CPU is currently executing. Use this classification to
update the IPC class of the current task.

The responsibility for configuring and enabling both the Hardware Feedback
Interface and Intel Thread Director lies with the HFI driver, but it should
not directly handle tasks.

Update the HFI driver to read the register that provides the classification
result. Implement the arch_update_ipcc() interface of the scheduler under
arch/x86 code to update the IPC class of individual tasks.

Task classification only makes sense when used along with the HFI driver.
Make HFI driver select CONFIG_IPC_CLASSES. However, users may still select
CONFIG_IPC_CLASSES. Add function stubs to prevent build errors.

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
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * Relocated the implementation of arch_update_ipcc() from drivers/thermal
   to arch/x86. (Rafael)
 * Moved the definition of MSR_IA32_HW_FEEDBACK_CHAR into this patch.
   (Reported-by: kernel test robot <lkp@intel.com>)
 * Select CONFIG_IPC_CLASSES when CONFIG_INTEL_HFI_THERMAL is selected to
   reduce the configuration burden of the user/administrator. (Srinivas)

Changes since v2:
 * Removed the implementation of arch_has_ipc_classes().

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
 arch/x86/include/asm/msr-index.h  |  1 +
 arch/x86/include/asm/topology.h   | 11 +++++++++
 arch/x86/kernel/Makefile          |  2 ++
 arch/x86/kernel/sched_ipcc.c      | 35 +++++++++++++++++++++++++++++
 drivers/thermal/intel/Kconfig     |  1 +
 drivers/thermal/intel/intel_hfi.c | 37 +++++++++++++++++++++++++++++++
 6 files changed, 87 insertions(+)
 create mode 100644 arch/x86/kernel/sched_ipcc.c

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3aedae61af4f..0bc4ed0ff787 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1108,6 +1108,7 @@
 /* Hardware Feedback Interface */
 #define MSR_IA32_HW_FEEDBACK_PTR        0x17d0
 #define MSR_IA32_HW_FEEDBACK_CONFIG     0x17d1
+#define MSR_IA32_HW_FEEDBACK_CHAR	0x17d2
 
 /* x2APIC locked status */
 #define MSR_IA32_XAPIC_DISABLE_STATUS	0xBD
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index caf41c4869a0..7d2ed7f7bb8c 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -235,4 +235,15 @@ void init_freq_invariance_cppc(void);
 #define arch_init_invariance_cppc init_freq_invariance_cppc
 #endif
 
+#ifdef CONFIG_INTEL_HFI_THERMAL
+int intel_hfi_read_classid(u8 *classid);
+#else
+static inline int intel_hfi_read_classid(u8 *classid) { return -ENODEV; }
+#endif
+
+#ifdef CONFIG_IPC_CLASSES
+void intel_update_ipcc(struct task_struct *curr);
+#define arch_update_ipcc intel_update_ipcc
+#endif
+
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 4070a01c11b7..f9b9d213ddaa 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -145,6 +145,8 @@ obj-$(CONFIG_CFI_CLANG)			+= cfi.o
 
 obj-$(CONFIG_CALL_THUNKS)		+= callthunks.o
 
+obj-$(CONFIG_IPC_CLASSES)		+= sched_ipcc.o
+
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/sched_ipcc.c b/arch/x86/kernel/sched_ipcc.c
new file mode 100644
index 000000000000..685e7b3b5375
--- /dev/null
+++ b/arch/x86/kernel/sched_ipcc.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel support for scheduler IPC classes
+ *
+ * Copyright (c) 2023, Intel Corporation.
+ *
+ * Author: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
+ *
+ * On hybrid processors, the architecture differences between types of CPUs
+ * lead to different number of retired instructions per cycle (IPC). IPCs may
+ * differ further by classes of instructions.
+ *
+ * The scheduler assigns an IPC class to every task with arch_update_ipcc()
+ * from data that hardware provides. Implement this interface for x86.
+ *
+ * See kernel/sched/sched.h for details.
+ */
+
+#include <linux/sched.h>
+
+#include <asm/topology.h>
+
+void intel_update_ipcc(struct task_struct *curr)
+{
+	u8 hfi_class;
+
+	if (intel_hfi_read_classid(&hfi_class))
+		return;
+
+	/*
+	 * 0 is a valid classification for Intel Thread Director. A scheduler
+	 * IPCC class of 0 means that the task is unclassified. Adjust.
+	 */
+	curr->ipcc = hfi_class + 1;
+}
diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index ecd7e07eece0..418db04dc876 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -109,6 +109,7 @@ config INTEL_HFI_THERMAL
 	depends on CPU_SUP_INTEL
 	depends on X86_THERMAL_VECTOR
 	select THERMAL_NETLINK
+	select IPC_CLASSES
 	help
 	  Select this option to enable the Hardware Feedback Interface. If
 	  selected, hardware provides guidance to the operating system on
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index b41547912fda..20ee4264dcd4 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -72,6 +72,15 @@ union cpuid6_edx {
 	u32 full;
 };
 
+union hfi_thread_feedback_char_msr {
+	struct {
+		u64	classid : 8;
+		u64	__reserved : 55;
+		u64	valid : 1;
+	} split;
+	u64 full;
+};
+
 /**
  * struct hfi_cpu_data - HFI capabilities per CPU
  * @perf_cap:		Performance capability
@@ -171,6 +180,34 @@ static struct workqueue_struct *hfi_updates_wq;
 #define HFI_UPDATE_INTERVAL		HZ
 #define HFI_MAX_THERM_NOTIFY_COUNT	16
 
+/**
+ * intel_hfi_read_classid() - Read the currrent classid
+ * @classid:	Variable to which the classid will be written.
+ *
+ * Read the classification that Intel Thread Director has produced when this
+ * function is called. Thread classification must be enabled before calling
+ * this function.
+ *
+ * Return: 0 if the produced classification is valid. Error otherwise.
+ */
+int intel_hfi_read_classid(u8 *classid)
+{
+	union hfi_thread_feedback_char_msr msr;
+
+	/* We should not be here if ITD is not supported. */
+	if (!cpu_feature_enabled(X86_FEATURE_ITD)) {
+		pr_warn_once("task classification requested but not supported!");
+		return -ENODEV;
+	}
+
+	rdmsrl(MSR_IA32_HW_FEEDBACK_CHAR, msr.full);
+	if (!msr.split.valid)
+		return -EINVAL;
+
+	*classid = msr.split.classid;
+	return 0;
+}
+
 static void get_hfi_caps(struct hfi_instance *hfi_instance,
 			 struct thermal_genl_cpu_caps *cpu_caps)
 {
-- 
2.25.1

