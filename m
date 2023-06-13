Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060FD72D89A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbjFME0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239717AbjFMEZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:25:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C7A173F;
        Mon, 12 Jun 2023 21:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630189; x=1718166189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=TE4ozxfbws0uqAWGPY8R3I8UzboW/+vJ7ix2tgBVGXY=;
  b=Sq5LoMznLdRAJs/Mvoj89qVywR2vHY046N5hWdn4wWw/Qe6CEApJSyuq
   ODlWQa8TU/V+hl4LJPcr6E1g5Cu4dogCye0r3Mp4BLjtLN8JdLHE7FYF/
   QTRBwe9vwG2LYG8/3fbwjULBuZAnUp5IfvPuAKzaoO6SFvRx//cx6S8y+
   UmfxvhmBAJfOZZTS46LwVN7UjWgzWcjeHFaMgrV9oLoIPDGEVMbphycXK
   ElNQRVCuJ1oBgax9XPe4gJPw1KkjhWuWxiVZ26lQ3L7UD9EHzrIYc9MO2
   V3vgENN/s5pUuGZRtLmQ0d25pJqTiL0Vnc06X0JVzU0TBqatasaTs5pv1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222313"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222313"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:22:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661855010"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661855010"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:22:05 -0700
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
Subject: [PATCH v4 24/24] x86/process: Reset hardware history in context switch
Date:   Mon, 12 Jun 2023 21:24:22 -0700
Message-Id: <20230613042422.5344-25-ricardo.neri-calderon@linux.intel.com>
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

Reset the classification history of the current task when switching to the
next task. Hardware will start the classification of the next task from
scratch.

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
 * None

Changes since v2:
 * None

Changes since v1:
 * Measurements of the cost of the HRESET instruction

   Methodology:
   I created a tight loop with interrupts and preemption disabled. I
   recorded the value of the TSC counter before and after executing
   HRESET or RDTSC. I repeated the measurement 100,000 times.
   I performed the experiment using an Alder Lake S system. I set the
   frequency of the CPUs at a fixed value.

   The table below compares the cost of HRESET with RDTSC (expressed in
   the elapsed TSC count). The cost of the two instructions is
   comparable.

                              PCore      ECore
        Frequency (GHz)        5.0        3.8
        HRESET (avg)          28.5       44.7
        HRESET (stdev %)       3.6        2.3
        RDTSC  (avg)          25.2       35.7
        RDTSC  (stdev %)       3.9        2.6

 * Used an ALTERNATIVE macro instead of static_cpu_has() to execute HRESET
   when supported. (PeterZ)
---
 arch/x86/include/asm/hreset.h | 30 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/common.c  |  7 +++++++
 arch/x86/kernel/process_32.c  |  3 +++
 arch/x86/kernel/process_64.c  |  3 +++
 4 files changed, 43 insertions(+)
 create mode 100644 arch/x86/include/asm/hreset.h

diff --git a/arch/x86/include/asm/hreset.h b/arch/x86/include/asm/hreset.h
new file mode 100644
index 000000000000..d68ca2fb8642
--- /dev/null
+++ b/arch/x86/include/asm/hreset.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_HRESET_H
+
+/**
+ * HRESET - History reset. Available since binutils v2.36.
+ *
+ * Request the processor to reset the history of task classification on the
+ * current logical processor. The history components to be
+ * reset are specified in %eax. Only bits specified in CPUID(0x20).EBX
+ * and enabled in the IA32_HRESET_ENABLE MSR can be selected.
+ *
+ * The assembly code looks like:
+ *
+ *	hreset %eax
+ *
+ * The corresponding machine code looks like:
+ *
+ *	F3 0F 3A F0 ModRM Imm
+ *
+ * The value of ModRM is 0xc0 to specify %eax register addressing.
+ * The ignored immediate operand is set to 0.
+ *
+ * The instruction is documented in the Intel SDM.
+ */
+
+#define __ASM_HRESET  ".byte 0xf3, 0xf, 0x3a, 0xf0, 0xc0, 0x0"
+
+void reset_hardware_history(void);
+
+#endif /* _ASM_X86_HRESET_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d47a442900ad..8cdd88dab7ed 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -53,6 +53,7 @@
 #include <asm/mce.h>
 #include <asm/msr.h>
 #include <asm/cacheinfo.h>
+#include <asm/hreset.h>
 #include <asm/memtype.h>
 #include <asm/microcode.h>
 #include <asm/microcode_intel.h>
@@ -398,6 +399,12 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 
 static u32 hardware_history_features __ro_after_init;
 
+void reset_hardware_history(void)
+{
+	asm_inline volatile (ALTERNATIVE("", __ASM_HRESET, X86_FEATURE_HRESET)
+			     : : "a" (hardware_history_features) : "memory");
+}
+
 static __always_inline void setup_hreset(struct cpuinfo_x86 *c)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_HRESET))
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 708c87b88cc1..7353bb119e79 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -52,6 +52,7 @@
 #include <asm/switch_to.h>
 #include <asm/vm86.h>
 #include <asm/resctrl.h>
+#include <asm/hreset.h>
 #include <asm/proto.h>
 
 #include "process.h"
@@ -214,6 +215,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in(next_p);
 
+	reset_hardware_history();
+
 	return prev_p;
 }
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 3d181c16a2f6..fcf14cba2a9d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -54,6 +54,7 @@
 #include <asm/xen/hypervisor.h>
 #include <asm/vdso.h>
 #include <asm/resctrl.h>
+#include <asm/hreset.h>
 #include <asm/unistd.h>
 #include <asm/fsgsbase.h>
 #ifdef CONFIG_IA32_EMULATION
@@ -659,6 +660,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in(next_p);
 
+	reset_hardware_history();
+
 	return prev_p;
 }
 
-- 
2.25.1

