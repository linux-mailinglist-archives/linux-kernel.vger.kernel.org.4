Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE4D70488F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjEPJK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjEPJJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:09:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93192D4A;
        Tue, 16 May 2023 02:09:56 -0700 (PDT)
Date:   Tue, 16 May 2023 09:09:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228193;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xe7vykULyAimhkCYWFGM1K9JJh+AEtiKAusB000oAME=;
        b=HV8WyFdoAWdkFxujle3oWDQNEc0l/hr6ohLjD100n7GT+QvROI/CzKjParqFz8uAgbMQgZ
        k2M42/ac00chyj0n1alsYJFTaHyMzUv7VjXOVXBNG7cKmGmuXkQ/9FNVoSoVo4/MVyTeRQ
        mv/fSmVuxxE1VmFgcVyvctnDF23Se+kZTGZxkjjRCh5M2i8hyxRYGHH887IH7yHJS4vLwH
        LZVb8yRFS549ItL4dNPxP4Sb/4A3OMjkdkClBgDcD73LVWSWQBuav10+39dqs9bWQXrfqj
        z+xK9bTKXSnxqVSkujiDhF+yxM3JsWfCa0P+dGwjs8mW2+bK1i2gIh6VQE0Q6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228193;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xe7vykULyAimhkCYWFGM1K9JJh+AEtiKAusB000oAME=;
        b=a02Vco9ORKLejImcfrCop+ztEjjjXToBD8S49IGOavwLS9jQ0wkS+Bqaic81Wo77o1Ly3e
        W1hxD17hYVE60rCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/smpboot/64: Implement
 arch_cpuhp_init_parallel_bringup() and enable it
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205257.467571745@linutronix.de>
References: <20230512205257.467571745@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422819281.404.9214856180312931022.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     0c7ffa32dbd6b09a87fea4ad1de8b27145dfd9a6
Gitweb:        https://git.kernel.org/tip/0c7ffa32dbd6b09a87fea4ad1de8b27145dfd9a6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:56 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:45:05 +02:00

x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable it

Implement the validation function which tells the core code whether
parallel bringup is possible.

The only condition for now is that the kernel does not run in an encrypted
guest as these will trap the RDMSR via #VC, which cannot be handled at that
point in early startup.

There was an earlier variant for AMD-SEV which used the GHBC protocol for
retrieving the APIC ID via CPUID, but there is no guarantee that the
initial APIC ID in CPUID is the same as the real APIC ID. There is no
enforcement from the secure firmware and the hypervisor can assign APIC IDs
as it sees fit as long as the ACPI/MADT table is consistent with that
assignment.

Unfortunately there is no RDMSR GHCB protocol at the moment, so enabling
AMD-SEV guests for parallel startup needs some more thought.

Intel-TDX provides a secure RDMSR hypercall, but supporting that is outside
the scope of this change.

Fixup announce_cpu() as e.g. on Hyper-V CPU1 is the secondary sibling of
CPU0, which makes the @cpu == 1 logic in announce_cpu() fall apart.

[ mikelley: Reported the announce_cpu() fallout

Originally-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205257.467571745@linutronix.de
---
 arch/x86/Kconfig             |  3 +-
 arch/x86/kernel/cpu/common.c |  6 +--
 arch/x86/kernel/smpboot.c    | 87 ++++++++++++++++++++++++++++-------
 3 files changed, 75 insertions(+), 21 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c140a73..953823f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -274,8 +274,9 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
+	select HOTPLUG_PARALLEL			if SMP && X86_64
 	select HOTPLUG_SMT			if SMP
-	select HOTPLUG_SPLIT_STARTUP		if SMP
+	select HOTPLUG_SPLIT_STARTUP		if SMP && X86_32
 	select IRQ_FORCED_THREADING
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 640fd18..7cc44eb 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2128,11 +2128,7 @@ static inline void setup_getcpu(int cpu)
 }
 
 #ifdef CONFIG_X86_64
-static inline void ucode_cpu_init(int cpu)
-{
-	if (cpu)
-		load_ucode_ap();
-}
+static inline void ucode_cpu_init(int cpu) { }
 
 static inline void tss_setup_ist(struct tss_struct *tss)
 {
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 4b97373..660709e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -58,6 +58,7 @@
 #include <linux/overflow.h>
 #include <linux/stackprotector.h>
 #include <linux/cpuhotplug.h>
+#include <linux/mc146818rtc.h>
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
@@ -75,7 +76,7 @@
 #include <asm/fpu/api.h>
 #include <asm/setup.h>
 #include <asm/uv/uv.h>
-#include <linux/mc146818rtc.h>
+#include <asm/microcode.h>
 #include <asm/i8259.h>
 #include <asm/misc.h>
 #include <asm/qspinlock.h>
@@ -128,7 +129,6 @@ int arch_update_cpu_topology(void)
 	return retval;
 }
 
-
 static unsigned int smpboot_warm_reset_vector_count;
 
 static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
@@ -226,16 +226,43 @@ static void notrace start_secondary(void *unused)
 	 */
 	cr4_init();
 
-#ifdef CONFIG_X86_32
-	/* switch away from the initial page table */
-	load_cr3(swapper_pg_dir);
-	__flush_tlb_all();
-#endif
+	/*
+	 * 32-bit specific. 64-bit reaches this code with the correct page
+	 * table established. Yet another historical divergence.
+	 */
+	if (IS_ENABLED(CONFIG_X86_32)) {
+		/* switch away from the initial page table */
+		load_cr3(swapper_pg_dir);
+		__flush_tlb_all();
+	}
+
 	cpu_init_exception_handling();
 
 	/*
-	 * Synchronization point with the hotplug core. Sets the
-	 * synchronization state to ALIVE and waits for the control CPU to
+	 * 32-bit systems load the microcode from the ASM startup code for
+	 * historical reasons.
+	 *
+	 * On 64-bit systems load it before reaching the AP alive
+	 * synchronization point below so it is not part of the full per
+	 * CPU serialized bringup part when "parallel" bringup is enabled.
+	 *
+	 * That's even safe when hyperthreading is enabled in the CPU as
+	 * the core code starts the primary threads first and leaves the
+	 * secondary threads waiting for SIPI. Loading microcode on
+	 * physical cores concurrently is a safe operation.
+	 *
+	 * This covers both the Intel specific issue that concurrent
+	 * microcode loading on SMT siblings must be prohibited and the
+	 * vendor independent issue`that microcode loading which changes
+	 * CPUID, MSRs etc. must be strictly serialized to maintain
+	 * software state correctness.
+	 */
+	if (IS_ENABLED(CONFIG_X86_64))
+		load_ucode_ap();
+
+	/*
+	 * Synchronization point with the hotplug core. Sets this CPUs
+	 * synchronization state to ALIVE and spin-waits for the control CPU to
 	 * release this CPU for further bringup.
 	 */
 	cpuhp_ap_sync_alive();
@@ -918,9 +945,9 @@ static int wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_ei
 /* reduce the number of lines printed when booting a large cpu count system */
 static void announce_cpu(int cpu, int apicid)
 {
+	static int width, node_width, first = 1;
 	static int current_node = NUMA_NO_NODE;
 	int node = early_cpu_to_node(cpu);
-	static int width, node_width;
 
 	if (!width)
 		width = num_digits(num_possible_cpus()) + 1; /* + '#' sign */
@@ -928,10 +955,10 @@ static void announce_cpu(int cpu, int apicid)
 	if (!node_width)
 		node_width = num_digits(num_possible_nodes()) + 1; /* + '#' */
 
-	if (cpu == 1)
-		printk(KERN_INFO "x86: Booting SMP configuration:\n");
-
 	if (system_state < SYSTEM_RUNNING) {
+		if (first)
+			pr_info("x86: Booting SMP configuration:\n");
+
 		if (node != current_node) {
 			if (current_node > (-1))
 				pr_cont("\n");
@@ -942,11 +969,11 @@ static void announce_cpu(int cpu, int apicid)
 		}
 
 		/* Add padding for the BSP */
-		if (cpu == 1)
+		if (first)
 			pr_cont("%*s", width + 1, " ");
+		first = 0;
 
 		pr_cont("%*s#%d", width - num_digits(cpu), " ", cpu);
-
 	} else
 		pr_info("Booting Node %d Processor %d APIC 0x%x\n",
 			node, cpu, apicid);
@@ -1236,6 +1263,36 @@ void __init smp_prepare_cpus_common(void)
 	set_cpu_sibling_map(0);
 }
 
+#ifdef CONFIG_X86_64
+/* Establish whether parallel bringup can be supported. */
+bool __init arch_cpuhp_init_parallel_bringup(void)
+{
+	/*
+	 * Encrypted guests require special handling. They enforce X2APIC
+	 * mode but the RDMSR to read the APIC ID is intercepted and raises
+	 * #VC or #VE which cannot be handled in the early startup code.
+	 *
+	 * AMD-SEV does not provide a RDMSR GHCB protocol so the early
+	 * startup code cannot directly communicate with the secure
+	 * firmware. The alternative solution to retrieve the APIC ID via
+	 * CPUID(0xb), which is covered by the GHCB protocol, is not viable
+	 * either because there is no enforcement of the CPUID(0xb)
+	 * provided "initial" APIC ID to be the same as the real APIC ID.
+	 *
+	 * Intel-TDX has a secure RDMSR hypercall, but that needs to be
+	 * implemented seperately in the low level startup ASM code.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
+		pr_info("Parallel CPU startup disabled due to guest state encryption\n");
+		return false;
+	}
+
+	smpboot_control = STARTUP_READ_APICID;
+	pr_debug("Parallel CPU startup enabled: 0x%08x\n", smpboot_control);
+	return true;
+}
+#endif
+
 /*
  * Prepare for SMP bootup.
  * @max_cpus: configured maximum number of CPUs, It is a legacy parameter
