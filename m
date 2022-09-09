Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64F45B42CC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiIIXIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiIIXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53CC115CEF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764800; x=1694300800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=4/7wf2K0L2ZI9Ae6WbjdcBQhTlRm2vZLmwpxFr1238w=;
  b=LtVeqDkmcOKJQzDuSRKuHIlh6s8QksVPldpEWXFUEtdEdSl1ZBTg1fiE
   KRAXbUdci4TUoLmlGbRjUOcTBVZTGA1dj793W2Bn5N+PK0ALZ/HFpmGGL
   kkL18yh5gHJSqSYm9DiRIKV+yaZ51zLv3ID+v9LhXTWZ8GTphoA83jbYA
   tfNhk9rKHoZkMfVSlFZEiHw17iCSYx42Hzdqtpsf4KtWSEuEy2IbQHHkG
   j6k7px8iYS/g/lOZeOKByTz2NXWdgVhCQx33B1PTfWwF892HrUuPlOcZP
   eV2gg9UCcbzIZ2669zDrBoROqFqt8G2efBtYn7VT+Gcz7bWZhDb2X3VYK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298386932"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="298386932"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677355063"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 16:06:37 -0700
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
Subject: [RFC PATCH 23/23] x86/process: Reset hardware history in context switch
Date:   Fri,  9 Sep 2022 16:12:05 -0700
Message-Id: <20220909231205.14009-24-ricardo.neri-calderon@linux.intel.com>
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

Reset the classification history of the current task when switching to
the next task. Hardware will start anew the classification of the next
running task.

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
 arch/x86/include/asm/hreset.h | 30 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/common.c  | 10 ++++++++++
 arch/x86/kernel/process_32.c  |  3 +++
 arch/x86/kernel/process_64.c  |  3 +++
 4 files changed, 46 insertions(+)
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
index 108642fe6761..4622a0ebf8a1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -52,6 +52,7 @@
 #include <asm/cpu.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
+#include <asm/hreset.h>
 #include <asm/memtype.h>
 #include <asm/microcode.h>
 #include <asm/microcode_intel.h>
@@ -413,6 +414,15 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 
 static u32 hardware_history_features __read_mostly;
 
+void reset_hardware_history(void)
+{
+	if (!static_cpu_has(X86_FEATURE_HRESET))
+		return;
+
+	asm volatile("mov %0, %%eax;" __ASM_HRESET "\n" : :
+		     "r" (hardware_history_features) : "%rax");
+}
+
 static __always_inline void setup_hreset(struct cpuinfo_x86 *c)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_HRESET))
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 2f314b170c9f..74d8ad83e0b3 100644
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
 	resctrl_sched_in();
 
+	reset_hardware_history();
+
 	return prev_p;
 }
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 1962008fe743..0b175f30f359 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -53,6 +53,7 @@
 #include <asm/xen/hypervisor.h>
 #include <asm/vdso.h>
 #include <asm/resctrl.h>
+#include <asm/hreset.h>
 #include <asm/unistd.h>
 #include <asm/fsgsbase.h>
 #ifdef CONFIG_IA32_EMULATION
@@ -657,6 +658,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in();
 
+	reset_hardware_history();
+
 	return prev_p;
 }
 
-- 
2.25.1

