Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D806F7270
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjEDTCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjEDTCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:02:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C5883CF;
        Thu,  4 May 2023 12:02:13 -0700 (PDT)
Message-ID: <20230504185936.750150196@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683226932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Csk76nlugXhAU996VRssrwo8MVI1hAOPsGe3TXuIETM=;
        b=tpY2Pta11o5D+EBlLezP7+DQ0YHNLnnshfEKyGamHfMkSJSDc6pWd24jta33cQ6549e5n0
        YoCRhsqkaZ0RzkSEFfE53xlP/wOrJKVGfAasd+i1K8FwsOnit2R8Qcbst29P+dph3dRJkn
        MWH3Lq9LgxU+JESzbQnOULIN1Fs0BetdOgLMsOeCIiVyyZnbX0XyK/efLbSuRFMNnGI3x6
        cKRhbBjsP/glATrekoMoT4u4F+Pv2ebV/PeVUxNrAcjRy4EL78zxGMHmgOH903YOe9OGR3
        DTNVfbTo3Z9BrgHrkycf+LctlaGconOxbeHGZGJUplx9zbo/SySM8/Japzc/+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683226932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Csk76nlugXhAU996VRssrwo8MVI1hAOPsGe3TXuIETM=;
        b=7clF0BS88qjmoiBaLOkVsFT638/SjDAHfzIc/R9HEwJjRQD5/6IkcSs7vkFzJfGoR95jo3
        dYaej/CZ6HDpvPAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [patch V2 08/38] x86/smpboot: Split up native_cpu_up() into separate
 phases and document them
References: <20230504185733.126511787@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu,  4 May 2023 21:02:11 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

There are four logical parts to what native_cpu_up() does on the BSP (or
on the controlling CPU for a later hotplug):

 1) Wake the AP by sending the INIT/SIPI/SIPI sequence.

 2) Wait for the AP to make it as far as wait_for_master_cpu() which
    sets that CPU's bit in cpu_initialized_mask, then sets the bit in
    cpu_callout_mask to let the AP proceed through cpu_init().

 3) Wait for the AP to finish cpu_init() and get as far as the
    smp_callin() call, which sets that CPU's bit in cpu_callin_mask.

 4) Perform the TSC synchronization and wait for the AP to actually
    mark itself online in cpu_online_mask.

In preparation to allow these phases to operate in parallel on multiple
APs, split them out into separate functions and document the interactions
a little more clearly in both the BP and AP code paths.

No functional change intended.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/smpboot.c |  187 +++++++++++++++++++++++++++++-----------------
 1 file changed, 121 insertions(+), 66 deletions(-)
---
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -193,6 +193,10 @@ static void smp_callin(void)
 
 	wmb();
 
+	/*
+	 * This runs the AP through all the cpuhp states to its target
+	 * state (CPUHP_ONLINE in the case of serial bringup).
+	 */
 	notify_cpu_starting(cpuid);
 
 	/*
@@ -233,14 +237,31 @@ static void notrace start_secondary(void
 	load_cr3(swapper_pg_dir);
 	__flush_tlb_all();
 #endif
+	/*
+	 * Sync point with wait_cpu_initialized(). Before proceeding through
+	 * cpu_init(), the AP will call wait_for_master_cpu() which sets its
+	 * own bit in cpu_initialized_mask and then waits for the BSP to set
+	 * its bit in cpu_callout_mask to release it.
+	 */
 	cpu_init_secondary();
 	rcu_cpu_starting(raw_smp_processor_id());
 	x86_cpuinit.early_percpu_clock_init();
+
+	/*
+	 * Sync point with wait_cpu_callin(). The AP doesn't wait here
+	 * but just sets the bit to let the controlling CPU (BSP) know that
+	 * it's got this far.
+	 */
 	smp_callin();
 
-	/* otherwise gcc will move up smp_processor_id before the cpu_init */
+	/* Otherwise gcc will move up smp_processor_id() before cpu_init() */
 	barrier();
-	/* Check TSC synchronization with the control CPU: */
+
+	/*
+	 * Check TSC synchronization with the control CPU, which will do
+	 * its part of this from wait_cpu_online(), making it an implicit
+	 * synchronization point.
+	 */
 	check_tsc_sync_target();
 
 	/*
@@ -259,6 +280,7 @@ static void notrace start_secondary(void
 	 * half valid vector space.
 	 */
 	lock_vector_lock();
+	/* Sync point with do_wait_cpu_online() */
 	set_cpu_online(smp_processor_id(), true);
 	lapic_online();
 	unlock_vector_lock();
@@ -981,17 +1003,13 @@ int common_cpu_up(unsigned int cpu, stru
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
- * Returns zero if CPU booted OK, else error code from
+ * Returns zero if startup was successfully sent, else error code from
  * ->wakeup_secondary_cpu.
  */
 static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle)
 {
-	/* start_ip had better be page-aligned! */
 	unsigned long start_ip = real_mode_header->trampoline_start;
 
-	unsigned long boot_error = 0;
-	unsigned long timeout;
-
 #ifdef CONFIG_X86_64
 	/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
 	if (apic->wakeup_secondary_cpu_64)
@@ -1048,60 +1066,89 @@ static int do_boot_cpu(int apicid, int c
 	 * - Use an INIT boot APIC message
 	 */
 	if (apic->wakeup_secondary_cpu_64)
-		boot_error = apic->wakeup_secondary_cpu_64(apicid, start_ip);
+		return apic->wakeup_secondary_cpu_64(apicid, start_ip);
 	else if (apic->wakeup_secondary_cpu)
-		boot_error = apic->wakeup_secondary_cpu(apicid, start_ip);
-	else
-		boot_error = wakeup_secondary_cpu_via_init(apicid, start_ip);
+		return apic->wakeup_secondary_cpu(apicid, start_ip);
 
-	if (!boot_error) {
-		/*
-		 * Wait 10s total for first sign of life from AP
-		 */
-		boot_error = -1;
-		timeout = jiffies + 10*HZ;
-		while (time_before(jiffies, timeout)) {
-			if (cpumask_test_cpu(cpu, cpu_initialized_mask)) {
-				/*
-				 * Tell AP to proceed with initialization
-				 */
-				cpumask_set_cpu(cpu, cpu_callout_mask);
-				boot_error = 0;
-				break;
-			}
-			schedule();
-		}
-	}
+	return wakeup_secondary_cpu_via_init(apicid, start_ip);
+}
 
-	if (!boot_error) {
-		/*
-		 * Wait till AP completes initial initialization
-		 */
-		while (!cpumask_test_cpu(cpu, cpu_callin_mask)) {
-			/*
-			 * Allow other tasks to run while we wait for the
-			 * AP to come online. This also gives a chance
-			 * for the MTRR work(triggered by the AP coming online)
-			 * to be completed in the stop machine context.
-			 */
-			schedule();
-		}
-	}
+static int wait_cpu_cpumask(unsigned int cpu, const struct cpumask *mask)
+{
+	unsigned long timeout;
 
-	if (x86_platform.legacy.warm_reset) {
-		/*
-		 * Cleanup possible dangling ends...
-		 */
-		smpboot_restore_warm_reset_vector();
+	/*
+	 * Wait up to 10s for the CPU to report in.
+	 */
+	timeout = jiffies + 10*HZ;
+	while (time_before(jiffies, timeout)) {
+		if (cpumask_test_cpu(cpu, mask))
+			return 0;
+
+		schedule();
 	}
+	return -1;
+}
 
-	return boot_error;
+/*
+ * Bringup step two: Wait for the target AP to reach cpu_init_secondary()
+ * and thus wait_for_master_cpu(), then set cpu_callout_mask to allow it
+ * to proceed.  The AP will then proceed past setting its 'callin' bit
+ * and end up waiting in check_tsc_sync_target() until we reach
+ * do_wait_cpu_online() to tend to it.
+ */
+static int wait_cpu_initialized(unsigned int cpu)
+{
+	/*
+	 * Wait for first sign of life from AP.
+	 */
+	if (wait_cpu_cpumask(cpu, cpu_initialized_mask))
+		return -1;
+
+	cpumask_set_cpu(cpu, cpu_callout_mask);
+	return 0;
 }
 
-int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
+/*
+ * Bringup step three: Wait for the target AP to reach smp_callin().
+ * The AP is not waiting for us here so we don't need to parallelise
+ * this step. Not entirely clear why we care about this, since we just
+ * proceed directly to TSC synchronization which is the next sync
+ * point with the AP anyway.
+ */
+static void wait_cpu_callin(unsigned int cpu)
+{
+	while (!cpumask_test_cpu(cpu, cpu_callin_mask))
+		schedule();
+}
+
+/*
+ * Bringup step four: Synchronize the TSC and wait for the target AP
+ * to reach set_cpu_online() in start_secondary().
+ */
+static void wait_cpu_online(unsigned int cpu)
 {
-	int apicid = apic->cpu_present_to_apicid(cpu);
 	unsigned long flags;
+
+	/*
+	 * Check TSC synchronization with the AP (keep irqs disabled
+	 * while doing so):
+	 */
+	local_irq_save(flags);
+	check_tsc_sync_source(cpu);
+	local_irq_restore(flags);
+
+	/*
+	 * Wait for the AP to mark itself online, so the core caller
+	 * can drop sparse_irq_lock.
+	 */
+	while (!cpu_online(cpu))
+		schedule();
+}
+
+static int native_kick_ap(unsigned int cpu, struct task_struct *tidle)
+{
+	int apicid = apic->cpu_present_to_apicid(cpu);
 	int err;
 
 	lockdep_assert_irqs_enabled();
@@ -1142,25 +1189,33 @@ int native_cpu_up(unsigned int cpu, stru
 		return err;
 
 	err = do_boot_cpu(apicid, cpu, tidle);
-	if (err) {
+	if (err)
 		pr_err("do_boot_cpu failed(%d) to wakeup CPU#%u\n", err, cpu);
-		return err;
-	}
 
-	/*
-	 * Check TSC synchronization with the AP (keep irqs disabled
-	 * while doing so):
-	 */
-	local_irq_save(flags);
-	check_tsc_sync_source(cpu);
-	local_irq_restore(flags);
+	return err;
+}
 
-	while (!cpu_online(cpu)) {
-		cpu_relax();
-		touch_nmi_watchdog();
-	}
+int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
+{
+	int ret;
 
-	return 0;
+	ret = native_kick_ap(cpu, tidle);
+	if (ret)
+		goto out;
+
+	ret = wait_cpu_initialized(cpu);
+	if (ret)
+		goto out;
+
+	wait_cpu_callin(cpu);
+	wait_cpu_online(cpu);
+
+out:
+	/* Cleanup possible dangling ends... */
+	if (x86_platform.legacy.warm_reset)
+		smpboot_restore_warm_reset_vector();
+
+	return ret;
 }
 
 /**

