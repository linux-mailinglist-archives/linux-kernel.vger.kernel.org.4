Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449416186D4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiKCSAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiKCR7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:59:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6D45F4B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667498362; x=1699034362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l5Os29/ppjad/9iy+qu+cEfFUnnSmf25B2n89ch0efI=;
  b=DAeYtUL9vdItvnMJPjl83NSlmemZNPvBiOiR/lizOfK8vTtYMZg5EB28
   ZsnWksVBExo3/irx/9/xAWQwrXJk2C7NTY8CUGUS2Uf2FONu+PJRbASPO
   GAMMnbLWMOUM2ET35MNvJ8KN3/iwyYt0ozGCvtKqa0/FGP/u8WTdTPAdt
   FsB06I19pEmzTXZo1yhqF2rm+I360XSB4O60NQNlF4DBZBAbEmH8dMTZC
   8vbhLOx8HSupW6xSeMnLJVNrkYZu2ZiaYFl/27zGqQS8mKv4x84orh4r/
   BUCGgFh9hdYJY14QLOZy8e5fdqU3bHePJal372vtiXAZXWzBke3sg64yN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308476970"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="308476970"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809762559"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="809762559"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:18 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [v2 07/13] x86/microcode: Place siblings in NMI loop while update in progress
Date:   Thu,  3 Nov 2022 17:58:55 +0000
Message-Id: <20221103175901.164783-8-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103175901.164783-1-ashok.raj@intel.com>
References: <20221103175901.164783-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microcode updates affect the state of the running CPU. In the case of
hyper-threads, the thread initiating the update is in a known state
(performing wrmsr 0x79), but its HT sibling can be executing arbitrary
instructions.

If one of these arbitrary instruction is being patched by the update at the
same time the sibling is trying to execute from it, its using microcode in
an unstable state.

Ensuring a rendezvous of all CPUs using stop_machine() ensures that
siblings are not executing any random user space code, and stop_machine()
also masks interrupts that can be masked.

The ones that can still slip in are the exceptions. They are:

NMI entry code and NMI handlers can also execute relatively arbitrary
instructions. This is an effort to ensure NMI doesn't slip until the wrmsr
has completed.

== Solution: NMI prevention during update ==

Before the stop_machine() rendezvous, an NMI handler is registered. The
handler is placed at the beginning of all other handlers. The siblings
then kick themselves into NMI by doing a self NMI IPI.

The handler does two things:

- Informs the primary thread that it has entered the NMI handler. Only
  after all siblings of a core have entered NMI, the primary proceeds
  with wrmsr to update microcode.
- It spins until the primary CPU has completed the wrmsr and informs the
  sibling to quit the NMI loop.

Also an important thing to remember is the microcode requests for exclusive
access to the core before performing an update. This effectively pulls the
sibling into microcode control until the wrmsr has released exclusive
access. Since the sibling is not executing any instructions while the
wrmsr completes, no other exceptions will surface on the sibling CPU.

Breakpoints can be another source that can lead do taking exceptions. But
on NMI entry, the kernel seems to be save/clear/restore the breakpoint
control register (DR7). local_db_save() and local_db_restore(). This
effectively eliminates any breakpoints leading the sibling into
uncontrolled execution.

The algorithm is something like this:

After stop_machine() all threads are executing __reload_late()

hold_sibling_in_nmi()
{
	/* Not a candidate for uCode NMI Sync */
	if (cpu has no nmi_primary_ptr)
		return;

	update sibling reached NMI for primary to continue

	while (primary not done with update)
		wait;

	return;
}

exc_nmi:IDT()
{
	....
	hold_sibling_in_nmi();
	...
}

__reload_late()
{

	entry_rendezvous(&late_cpus_in);

	if (this_cpu is first_cpu in the core)
		wait for core siblings to drop in NMI
		apply_microcode()
		set completion to release sibling from NMI
	else
		set sibling info to drop into NMI
		send self_IPI(NMI_VECTOR);

wait_for_siblings:

	exit_rendezvous(&late_cpus_out);
}

reload_late()
{
	register_nmi_handler()
	stop_machine(__reload_late);
	unregister_nmi_handler();
}

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/include/asm/microcode.h       | 37 ++++++++++
 arch/x86/kernel/cpu/microcode/core.c   | 98 ++++++++++++++++++++++++--
 arch/x86/kernel/cpu/microcode/nmi.c    | 71 +++++++++++++++++++
 arch/x86/kernel/nmi.c                  |  7 ++
 arch/x86/kernel/cpu/microcode/Makefile |  1 +
 5 files changed, 210 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/microcode/nmi.c

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index d5a58bde091c..ffb46f2b0354 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -6,6 +6,37 @@
 #include <linux/earlycpio.h>
 #include <linux/initrd.h>
 
+/*
+ * Although this is a per-cpu structure, both the primary and siblings use
+ * only the primary structure to communicate.
+ * All core siblings set an indication they all reached NMI handler.
+ * Once primary has completed the microcode update, sets core_done to
+ * release all core siblings out of NMI.
+ *
+ * num_core_cpus - Number of CPUs in the core.
+ * callin	 - Siblings set to inform primary once they reach NMI.
+ * core_done	 - Set by primary once microcode update has completed.
+ * failed	 - Set when there is a timeout situation during rendezvous
+ */
+struct core_rendez {
+	int num_core_cpus;
+	atomic_t callin;
+	atomic_t core_done;
+	atomic_t failed;
+};
+
+DECLARE_PER_CPU(struct core_rendez, core_sync);
+
+/*
+ * The following structure is only used by secondary.
+ * Sets the primary per_cpu variable to be found inside the NMI handler to
+ * indicate this CPU  is supposed to drop into NMI. Its consulted in the
+ * NMI handler before entering the loop waiting for primary to finish the
+ * loading process. Once loading is complete the NMI handler clears this
+ * pointer.
+ */
+DECLARE_PER_CPU(struct core_rendez *, nmi_primary_ptr);
+
 struct ucode_patch {
 	struct list_head plist;
 	void *data;		/* Intel uses only this one */
@@ -135,4 +166,10 @@ static inline void reload_early_microcode(void)			{ }
 static inline void microcode_bsp_resume(void)			{ }
 #endif
 
+#ifdef CONFIG_MICROCODE_LATE_LOADING
+extern void hold_sibling_in_nmi(void);
+#else
+static inline void hold_sibling_in_nmi(void) { }
+#endif
+
 #endif /* _ASM_X86_MICROCODE_H */
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index d41207e50ee6..6084a87ea8f3 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -39,6 +39,8 @@
 #include <asm/processor.h>
 #include <asm/cmdline.h>
 #include <asm/setup.h>
+#include <asm/apic.h>
+#include <asm/mce.h>
 
 #include "../cpu.h"
 
@@ -380,6 +382,59 @@ static int __wait_for_cpus(atomic_t *t, long long timeout)
 	return 0;
 }
 
+/*
+ * This simply ensures that the self IPI with NMI to siblings is marked as
+ * handled.
+ */
+static int ucode_nmi_cb(unsigned int val, struct pt_regs *regs)
+{
+	return NMI_HANDLED;
+}
+
+/*
+ * Primary thread waits for all siblings to report that they have enterered
+ * the NMI handler
+ */
+static int __wait_for_core_siblings(struct core_rendez *rendez)
+{
+	int num_sibs = rendez->num_core_cpus - 1;
+	unsigned long long timeout = NSEC_PER_MSEC;
+	atomic_t *t = &rendez->callin;
+	int cpu = smp_processor_id();
+
+	while (atomic_read(t) < num_sibs) {
+		cpu_relax();
+		ndelay(SPINUNIT);
+		touch_nmi_watchdog();
+		timeout -= SPINUNIT;
+		if (timeout < SPINUNIT) {
+			pr_err("CPU%d timedout waiting for siblings\n", cpu);
+			atomic_inc(&rendez->failed);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static void prepare_for_nmi(void)
+{
+	int cpu, first_cpu;
+	struct core_rendez *pcpu_core;
+
+	for_each_online_cpu(cpu) {
+		first_cpu = cpumask_first(topology_sibling_cpumask(cpu));
+		if (cpu != first_cpu)
+			continue;
+
+		pcpu_core = &per_cpu(core_sync, first_cpu);
+		pcpu_core->num_core_cpus =
+		     cpumask_weight(topology_sibling_cpumask(cpu));
+		atomic_set(&pcpu_core->callin, 0);
+		atomic_set(&pcpu_core->core_done, 0);
+		atomic_set(&pcpu_core->failed, 0);
+	}
+}
+
 /*
  * Returns:
  * < 0 - on error
@@ -387,14 +442,15 @@ static int __wait_for_cpus(atomic_t *t, long long timeout)
  */
 static int __reload_late(void *info)
 {
-	int cpu = smp_processor_id();
+	int first_cpu, cpu = smp_processor_id();
+	struct core_rendez *pcpu_core;
 	enum ucode_state err;
 	int ret = 0;
 
 	/*
 	 * Wait for all CPUs to arrive. A load will not be attempted unless all
 	 * CPUs show up.
-	 * */
+	 */
 	if (__wait_for_cpus(&late_cpus_in, NSEC_PER_SEC))
 		return -1;
 
@@ -405,10 +461,32 @@ static int __reload_late(void *info)
 	 * loading attempts happen on multiple threads of an SMT core. See
 	 * below.
 	 */
-	if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
+	first_cpu = cpumask_first(topology_sibling_cpumask(cpu));
+	pcpu_core = &per_cpu(core_sync, first_cpu);
+
+	/*
+	 * Set the CPUs that we should hold in NMI until the primary has
+	 * completed the microcode update.
+	 */
+	if (first_cpu == cpu) {
+		/*
+		 * Wait for all siblings to enter
+		 * NMI before performing the update
+		 */
+		ret = __wait_for_core_siblings(pcpu_core);
+		if (ret || atomic_read(&pcpu_core->failed)) {
+			pr_err("CPU %d core lead timeout waiting for siblings\n", cpu);
+			ret = -1;
+		}
+		pr_debug("Primary CPU %d proceeding with update\n", cpu);
 		err = microcode_ops->apply_microcode(cpu);
-	else
+		atomic_set(&pcpu_core->core_done, 1);
+	} else {
+		/* We set the per-cpu of sibling in this case */
+		this_cpu_write(nmi_primary_ptr, pcpu_core);
+		apic->send_IPI_self(NMI_VECTOR);
 		goto wait_for_siblings;
+	}
 
 	if (err >= UCODE_NFOUND) {
 		if (err == UCODE_ERROR)
@@ -490,6 +568,15 @@ static int microcode_reload_late(void)
 	atomic_set(&late_cpus_in,  0);
 	atomic_set(&late_cpus_out, 0);
 
+	prepare_for_nmi();
+
+	ret = register_nmi_handler(NMI_LOCAL, ucode_nmi_cb, NMI_FLAG_FIRST,
+				   "ucode_nmi");
+	if (ret) {
+		pr_err("Unable to register NMI handler\n");
+		goto done;
+	}
+
 	copy_cpu_caps(&info);
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
 	if (ret == 0)
@@ -498,6 +585,9 @@ static int microcode_reload_late(void)
 	pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
 		old, boot_cpu_data.microcode);
 
+	unregister_nmi_handler(NMI_LOCAL, "ucode_nmi");
+
+done:
 	return ret;
 }
 
diff --git a/arch/x86/kernel/cpu/microcode/nmi.c b/arch/x86/kernel/cpu/microcode/nmi.c
new file mode 100644
index 000000000000..8899659cc5d6
--- /dev/null
+++ b/arch/x86/kernel/cpu/microcode/nmi.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 Ashok Raj <ashok.raj@intel.com>
+ *
+ * X86 CPU microcode update NMI handler.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/cpu.h>
+#include <linux/nmi.h>
+
+#include <asm/microcode.h>
+
+#define SPINUNIT	100 /* 100 nsec */
+
+DEFINE_PER_CPU(struct core_rendez, core_sync);
+DEFINE_PER_CPU(struct core_rendez *, nmi_primary_ptr);
+
+#define SPINUNIT 100 /* 100 nsec */
+
+static void delay(int ms)
+{
+	unsigned long timeout = jiffies + ((ms * HZ) / 1000);
+
+	while (time_before(jiffies, timeout))
+		cpu_relax();
+}
+
+/*
+ * Siblings wait until microcode update is completed by the primary thread.
+ */
+static int __wait_for_update(atomic_t *t)
+{
+	unsigned long long timeout = NSEC_PER_MSEC;
+
+	while (!arch_atomic_read(t)) {
+		cpu_relax();
+		delay(1);
+		timeout -= SPINUNIT;
+		if (timeout < SPINUNIT)
+			return 1;
+	}
+	return 0;
+}
+
+noinstr void hold_sibling_in_nmi(void)
+{
+	struct	 core_rendez *pcpu_core;
+	int ret = 0;
+
+	pcpu_core = this_cpu_read(nmi_primary_ptr);
+	if (likely(!pcpu_core))
+		return;
+
+	/*
+	 * Increment the callin to inform primary thread that the sibling
+	 * has arrived and parked in the NMI handler
+	 */
+	arch_atomic_inc(&pcpu_core->callin);
+
+	ret = __wait_for_update(&pcpu_core->core_done);
+	if (ret)
+		atomic_inc(&pcpu_core->failed);
+
+	/*
+	 * Clear the nmi_trap, so future NMI's won't be affected
+	 */
+	this_cpu_write(nmi_primary_ptr, NULL);
+}
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index cec0bfa3bc04..619afeaef07c 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -28,6 +28,7 @@
 #include <asm/cpu_entry_area.h>
 #include <asm/traps.h>
 #include <asm/mach_traps.h>
+#include <asm/microcode.h>
 #include <asm/nmi.h>
 #include <asm/x86_init.h>
 #include <asm/reboot.h>
@@ -505,6 +506,12 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 
 	this_cpu_write(nmi_dr7, local_db_save());
 
+	/*
+	 * If microcodeupdate is in progress, check and hold the sibling in
+	 * the NMI until primary has completed the update
+	 */
+	hold_sibling_in_nmi();
+
 	irq_state = irqentry_nmi_enter(regs);
 
 	inc_irq_stat(__nmi_count);
diff --git a/arch/x86/kernel/cpu/microcode/Makefile b/arch/x86/kernel/cpu/microcode/Makefile
index 34098d48c48f..e469990bba73 100644
--- a/arch/x86/kernel/cpu/microcode/Makefile
+++ b/arch/x86/kernel/cpu/microcode/Makefile
@@ -3,3 +3,4 @@ microcode-y				:= core.o
 obj-$(CONFIG_MICROCODE)			+= microcode.o
 microcode-$(CONFIG_MICROCODE_INTEL)	+= intel.o
 microcode-$(CONFIG_MICROCODE_AMD)	+= amd.o
+microcode-$(CONFIG_MICROCODE_LATE_LOADING) += nmi.o
-- 
2.34.1

