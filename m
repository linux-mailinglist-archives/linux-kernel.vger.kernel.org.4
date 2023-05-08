Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3266FB726
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 21:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjEHTod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 15:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjEHToL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 15:44:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CD472A4;
        Mon,  8 May 2023 12:43:48 -0700 (PDT)
Message-ID: <20230508185217.898282342@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683575026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WRyTY63fFKNT8NNe9pdrXSxP97ZO9fcfInZz6PguA8M=;
        b=1cHMH34GyxfIxkvmlBecr+5mzqthYk0E5c5P4+XqqcL8e6XurHWWxoOFIeJNtH/QSimVPW
        18V4fky6NzTdKRpcATR0yTdNUZbSMxJNRORImkmezodXTP7pe74xPQQAr7BpbhkgTBLmJ9
        9+OjV54jcwTxOTA+n9J3KUmsDNgl2gb3hdT1mCXG5keQW7p23s7uTtMRmJhNI8qHCATek2
        VFYxci2MRuYhxjE+yAzrFzousZ3auxKM0KBHlEanvL+LGxBtvIkKatD++/+hdxq+0bTgJP
        Q8JQ6UU2zRO8a9/lotv6c8YTYGM7ip1GcZN4ZI6sLMyO//NiTtDVmoUIAZOoIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683575026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WRyTY63fFKNT8NNe9pdrXSxP97ZO9fcfInZz6PguA8M=;
        b=a+XTx0gdMg20467/DY65JXjTt0K7JO0GQA4Eac40m+yQL/vp4DDGDsEbZstdM86jzLh2iO
        AyCWRRDCHHJEPTBg==
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
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: [patch v3 12/36] [patch V2 12/38] x86/smpboot: Make TSC
 synchronization function call based
References: <20230508181633.089804905@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  8 May 2023 21:43:46 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Spin-waiting on the control CPU until the AP reaches the TSC
synchronization is just a waste especially in the case that there is no
synchronization required.

As the synchronization has to run with interrupts disabled the control CPU
part can just be done from a SMP function call. The upcoming AP issues that
call async only in the case that synchronization is required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>


---
 arch/x86/include/asm/tsc.h |    2 --
 arch/x86/kernel/smpboot.c  |   20 +++-----------------
 arch/x86/kernel/tsc_sync.c |   36 +++++++++++-------------------------
 3 files changed, 14 insertions(+), 44 deletions(-)
---

--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -55,12 +55,10 @@ extern bool tsc_async_resets;
 #ifdef CONFIG_X86_TSC
 extern bool tsc_store_and_check_tsc_adjust(bool bootcpu);
 extern void tsc_verify_tsc_adjust(bool resume);
-extern void check_tsc_sync_source(int cpu);
 extern void check_tsc_sync_target(void);
 #else
 static inline bool tsc_store_and_check_tsc_adjust(bool bootcpu) { return false; }
 static inline void tsc_verify_tsc_adjust(bool resume) { }
-static inline void check_tsc_sync_source(int cpu) { }
 static inline void check_tsc_sync_target(void) { }
 #endif
 
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -278,11 +278,7 @@ static void notrace start_secondary(void
 	/* Otherwise gcc will move up smp_processor_id() before cpu_init() */
 	barrier();
 
-	/*
-	 * Check TSC synchronization with the control CPU, which will do
-	 * its part of this from wait_cpu_online(), making it an implicit
-	 * synchronization point.
-	 */
+	/* Check TSC synchronization with the control CPU. */
 	check_tsc_sync_target();
 
 	/*
@@ -1144,21 +1140,11 @@ static void wait_cpu_callin(unsigned int
 }
 
 /*
- * Bringup step four: Synchronize the TSC and wait for the target AP
- * to reach set_cpu_online() in start_secondary().
+ * Bringup step four: Wait for the target AP to reach set_cpu_online() in
+ * start_secondary().
  */
 static void wait_cpu_online(unsigned int cpu)
 {
-	unsigned long flags;
-
-	/*
-	 * Check TSC synchronization with the AP (keep irqs disabled
-	 * while doing so):
-	 */
-	local_irq_save(flags);
-	check_tsc_sync_source(cpu);
-	local_irq_restore(flags);
-
 	/*
 	 * Wait for the AP to mark itself online, so the core caller
 	 * can drop sparse_irq_lock.
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -245,7 +245,6 @@ bool tsc_store_and_check_tsc_adjust(bool
  */
 static atomic_t start_count;
 static atomic_t stop_count;
-static atomic_t skip_test;
 static atomic_t test_runs;
 
 /*
@@ -344,21 +343,14 @@ static inline unsigned int loop_timeout(
 }
 
 /*
- * Source CPU calls into this - it waits for the freshly booted
- * target CPU to arrive and then starts the measurement:
+ * The freshly booted CPU initiates this via an async SMP function call.
  */
-void check_tsc_sync_source(int cpu)
+static void check_tsc_sync_source(void *__cpu)
 {
+	unsigned int cpu = (unsigned long)__cpu;
 	int cpus = 2;
 
 	/*
-	 * No need to check if we already know that the TSC is not
-	 * synchronized or if we have no TSC.
-	 */
-	if (unsynchronized_tsc())
-		return;
-
-	/*
 	 * Set the maximum number of test runs to
 	 *  1 if the CPU does not provide the TSC_ADJUST MSR
 	 *  3 if the MSR is available, so the target can try to adjust
@@ -368,16 +360,9 @@ void check_tsc_sync_source(int cpu)
 	else
 		atomic_set(&test_runs, 3);
 retry:
-	/*
-	 * Wait for the target to start or to skip the test:
-	 */
-	while (atomic_read(&start_count) != cpus - 1) {
-		if (atomic_read(&skip_test) > 0) {
-			atomic_set(&skip_test, 0);
-			return;
-		}
+	/* Wait for the target to start. */
+	while (atomic_read(&start_count) != cpus - 1)
 		cpu_relax();
-	}
 
 	/*
 	 * Trigger the target to continue into the measurement too:
@@ -397,14 +382,14 @@ void check_tsc_sync_source(int cpu)
 	if (!nr_warps) {
 		atomic_set(&test_runs, 0);
 
-		pr_debug("TSC synchronization [CPU#%d -> CPU#%d]: passed\n",
+		pr_debug("TSC synchronization [CPU#%d -> CPU#%u]: passed\n",
 			smp_processor_id(), cpu);
 
 	} else if (atomic_dec_and_test(&test_runs) || random_warps) {
 		/* Force it to 0 if random warps brought us here */
 		atomic_set(&test_runs, 0);
 
-		pr_warn("TSC synchronization [CPU#%d -> CPU#%d]:\n",
+		pr_warn("TSC synchronization [CPU#%d -> CPU#%u]:\n",
 			smp_processor_id(), cpu);
 		pr_warn("Measured %Ld cycles TSC warp between CPUs, "
 			"turning off TSC clock.\n", max_warp);
@@ -457,11 +442,12 @@ void check_tsc_sync_target(void)
 	 * SoCs the TSC is frequency synchronized, but still the TSC ADJUST
 	 * register might have been wreckaged by the BIOS..
 	 */
-	if (tsc_store_and_check_tsc_adjust(false) || tsc_clocksource_reliable) {
-		atomic_inc(&skip_test);
+	if (tsc_store_and_check_tsc_adjust(false) || tsc_clocksource_reliable)
 		return;
-	}
 
+	/* Kick the control CPU into the TSC synchronization function */
+	smp_call_function_single(cpumask_first(cpu_online_mask), check_tsc_sync_source,
+				 (unsigned long *)(unsigned long)cpu, 0);
 retry:
 	/*
 	 * Register this CPU's participation and wait for the


