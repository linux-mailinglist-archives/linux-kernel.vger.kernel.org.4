Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996B9701063
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 23:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbjELVI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 17:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239762AbjELVHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 17:07:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D0DE733;
        Fri, 12 May 2023 14:07:22 -0700 (PDT)
Message-ID: <20230512205256.206394064@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683925640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sV700lvJEg0dpnky36xy6IzX+5YcmbLPF3iuwfreLQI=;
        b=paQ53o7/mL5ElBtzALRvm5FWr+aqzidPhADEkGkNnFUgSdXdZKTpQ9LdM20zv3wNd69sIS
        it6M97+Fbbx8ktP1fteK/FRxSsUJ+d0bN0dEWXHrN+1EXE74+t5yfLHYlX4A2jlo5kaWpy
        u1Y4a1rKKqdKc7NvKZPW3+05W/WKM4dmC8NnWIBvmIiGSBT0dFtCcrPLjhVylwcQhwWEFh
        l3HKtTadZMnBQhRy9Lw4oQ4h0oFirsIvEgTyNYGnpZi6RiB0cbK/DRRrBfV3ithiX6HrKL
        M7rlozY1wPYf1JFhsOIHtY0UQp0uMjycyx8ukit8UWdY1BCjZKlup+pYCxy6HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683925640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sV700lvJEg0dpnky36xy6IzX+5YcmbLPF3iuwfreLQI=;
        b=sb9Uqj+LJNN+k1afPutXlTsDK2EI5uKAFco5RBP+AD3FcfTjEj4fGPWwaSSh6It8iDbVO5
        x1PNGDR7T4lyhTCA==
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
        Ross Philipson <ross.philipson@oracle.com>
Subject: [patch V4 14/37] x86/smpboot: Remove cpu_callin_mask
References: <20230512203426.452963764@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 12 May 2023 23:07:19 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Now that TSC synchronization is SMP function call based there is no reason
to wait for the AP to be set in smp_callin_mask. The control CPU waits for
the AP to set itself in the online mask anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
---
V4: Rename smp_callin() to ap_starting() - Peter Z.
---
 arch/x86/kernel/smpboot.c |   74 +++++++++-------------------------------------
 1 file changed, 15 insertions(+), 59 deletions(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -104,7 +104,6 @@ EXPORT_PER_CPU_SYMBOL(cpu_info);
 /* All of these masks are initialized in setup_cpu_local_masks() */
 static cpumask_var_t cpu_initialized_mask;
 static cpumask_var_t cpu_callout_mask;
-static cpumask_var_t cpu_callin_mask;
 /* Representing CPUs for which sibling maps can be computed */
 static cpumask_var_t cpu_sibling_setup_mask;
 
@@ -161,38 +160,30 @@ static inline void smpboot_restore_warm_
 
 }
 
-/*
- * Report back to the Boot Processor during boot time or to the caller processor
- * during CPU online.
- */
-static void smp_callin(void)
+/* Run the next set of setup steps for the upcoming CPU */
+static void ap_starting(void)
 {
-	int cpuid;
-
-	/*
-	 * If waken up by an INIT in an 82489DX configuration
-	 * cpu_callout_mask guarantees we don't get here before
-	 * an INIT_deassert IPI reaches our local APIC, so it is
-	 * now safe to touch our local APIC.
-	 */
-	cpuid = smp_processor_id();
+	int cpuid = smp_processor_id();
 
 	/*
-	 * the boot CPU has finished the init stage and is spinning
-	 * on callin_map until we finish. We are free to set up this
-	 * CPU, first the APIC. (this is probably redundant on most
-	 * boards)
+	 * If woken up by an INIT in an 82489DX configuration
+	 * cpu_callout_mask guarantees the CPU does not reach this point
+	 * before an INIT_deassert IPI reaches the local APIC, so it is now
+	 * safe to touch the local APIC.
+	 *
+	 * Set up this CPU, first the APIC, which is probably redundant on
+	 * most boards.
 	 */
 	apic_ap_setup();
 
-	/* Save our processor parameters. */
+	/* Save the processor parameters. */
 	smp_store_cpu_info(cpuid);
 
 	/*
 	 * The topology information must be up to date before
 	 * notify_cpu_starting().
 	 */
-	set_cpu_sibling_map(raw_smp_processor_id());
+	set_cpu_sibling_map(cpuid);
 
 	ap_init_aperfmperf();
 
@@ -205,11 +196,6 @@ static void smp_callin(void)
 	 * state CPUHP_ONLINE.
 	 */
 	notify_cpu_starting(cpuid);
-
-	/*
-	 * Allow the master to continue.
-	 */
-	cpumask_set_cpu(cpuid, cpu_callin_mask);
 }
 
 static void ap_calibrate_delay(void)
@@ -268,12 +254,7 @@ static void notrace start_secondary(void
 	rcu_cpu_starting(raw_smp_processor_id());
 	x86_cpuinit.early_percpu_clock_init();
 
-	/*
-	 * Sync point with wait_cpu_callin(). The AP doesn't wait here
-	 * but just sets the bit to let the controlling CPU (BSP) know that
-	 * it's got this far.
-	 */
-	smp_callin();
+	ap_starting();
 
 	/* Check TSC synchronization with the control CPU. */
 	check_tsc_sync_target();
@@ -1109,7 +1090,7 @@ static int wait_cpu_cpumask(unsigned int
  * and thus wait_for_master_cpu(), then set cpu_callout_mask to allow it
  * to proceed.  The AP will then proceed past setting its 'callin' bit
  * and end up waiting in check_tsc_sync_target() until we reach
- * do_wait_cpu_online() to tend to it.
+ * wait_cpu_online() to tend to it.
  */
 static int wait_cpu_initialized(unsigned int cpu)
 {
@@ -1124,20 +1105,7 @@ static int wait_cpu_initialized(unsigned
 }
 
 /*
- * Bringup step three: Wait for the target AP to reach smp_callin().
- * The AP is not waiting for us here so we don't need to parallelise
- * this step. Not entirely clear why we care about this, since we just
- * proceed directly to TSC synchronization which is the next sync
- * point with the AP anyway.
- */
-static void wait_cpu_callin(unsigned int cpu)
-{
-	while (!cpumask_test_cpu(cpu, cpu_callin_mask))
-		schedule();
-}
-
-/*
- * Bringup step four: Wait for the target AP to reach set_cpu_online() in
+ * Bringup step three: Wait for the target AP to reach set_cpu_online() in
  * start_secondary().
  */
 static void wait_cpu_online(unsigned int cpu)
@@ -1167,14 +1135,6 @@ static int native_kick_ap(unsigned int c
 	}
 
 	/*
-	 * Already booted CPU?
-	 */
-	if (cpumask_test_cpu(cpu, cpu_callin_mask)) {
-		pr_debug("do_boot_cpu %d Already started\n", cpu);
-		return -ENOSYS;
-	}
-
-	/*
 	 * Save current MTRR state in case it was changed since early boot
 	 * (e.g. by the ACPI SMI) to initialize new CPUs with MTRRs in sync:
 	 */
@@ -1211,7 +1171,6 @@ int native_cpu_up(unsigned int cpu, stru
 	if (ret)
 		goto out;
 
-	wait_cpu_callin(cpu);
 	wait_cpu_online(cpu);
 
 out:
@@ -1327,7 +1286,6 @@ void __init smp_prepare_cpus_common(void
 	 * Setup boot CPU information
 	 */
 	smp_store_boot_cpu_info(); /* Final full version of the data */
-	cpumask_copy(cpu_callin_mask, cpumask_of(0));
 	mb();
 
 	for_each_possible_cpu(i) {
@@ -1542,7 +1500,6 @@ early_param("possible_cpus", _setup_poss
 void __init setup_cpu_local_masks(void)
 {
 	alloc_bootmem_cpumask_var(&cpu_initialized_mask);
-	alloc_bootmem_cpumask_var(&cpu_callin_mask);
 	alloc_bootmem_cpumask_var(&cpu_callout_mask);
 	alloc_bootmem_cpumask_var(&cpu_sibling_setup_mask);
 }
@@ -1606,7 +1563,6 @@ static void remove_cpu_from_maps(int cpu
 {
 	set_cpu_online(cpu, false);
 	cpumask_clear_cpu(cpu, cpu_callout_mask);
-	cpumask_clear_cpu(cpu, cpu_callin_mask);
 	/* was set by cpu_init() */
 	cpumask_clear_cpu(cpu, cpu_initialized_mask);
 	numa_remove_cpu(cpu);

