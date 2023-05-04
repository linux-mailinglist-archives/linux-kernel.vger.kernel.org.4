Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDBD6F7271
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjEDTC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjEDTCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:02:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1547E86B4;
        Thu,  4 May 2023 12:02:14 -0700 (PDT)
Message-ID: <20230504185936.802783450@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683226933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=djhcX/6oz1v3ZZHjWNR6fK2ATXnp39FPHavEh8Z2jPk=;
        b=ga7wmIakplENkJi6T5NoX0Dl4GKg+ap6nn7fRMuH4AJ0N/j8tLX4hOYKXxI82FfjNe6bvd
        vJmMRr19EbOXhlvWVBPj00971oHJ7EVwTVpYtKkKm1bHOPAtWTEqef+PWJeugHX4N45lMG
        uoAym6vetzrOuFxrlyf44EwZaO13wrZDfo/XkIGx0LvkxSOhnQMBCiqIzIQDgAgSp3wxnj
        y26KQIzEJjp7eB7O+cYD+6cb4y96+ikG+vSFWeNtad9FTEpCRcUHe+gEoz7H09GJDNgB1J
        AKbp/YjUjDEWvORBc7uiaoZEw4Hkz37CASo4CL84FTmpzcTx9pDR5194rYnnxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683226933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=djhcX/6oz1v3ZZHjWNR6fK2ATXnp39FPHavEh8Z2jPk=;
        b=9d54JiewPSGmVQNrhzbBmbqIIQ6FHVsRs8p39dYcszm+2PpRs6UAq3uJ7Lp1hIlyibfgPq
        eWLViIKxHt4DgPAQ==
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
Subject: [patch V2 09/38] x86/smpboot: Get rid of cpu_init_secondary()
References: <20230504185733.126511787@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu,  4 May 2023 21:02:13 +0200 (CEST)
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

The synchronization of the AP with the control CPU is a SMP boot problem
and has nothing to do with cpu_init().

Open code cpu_init_secondary() in start_secondary() and move
wait_for_master_cpu() into the SMP boot code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/processor.h |    1 -
 arch/x86/kernel/cpu/common.c     |   27 ---------------------------
 arch/x86/kernel/smpboot.c        |   24 +++++++++++++++++++-----
 3 files changed, 19 insertions(+), 33 deletions(-)
---
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -551,7 +551,6 @@ extern void switch_gdt_and_percpu_base(i
 extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
 extern void cpu_init(void);
-extern void cpu_init_secondary(void);
 extern void cpu_init_exception_handling(void);
 extern void cr4_init(void);
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2123,19 +2123,6 @@ static void dbg_restore_debug_regs(void)
 #define dbg_restore_debug_regs()
 #endif /* ! CONFIG_KGDB */
 
-static void wait_for_master_cpu(int cpu)
-{
-#ifdef CONFIG_SMP
-	/*
-	 * wait for ACK from master CPU before continuing
-	 * with AP initialization
-	 */
-	WARN_ON(cpumask_test_and_set_cpu(cpu, cpu_initialized_mask));
-	while (!cpumask_test_cpu(cpu, cpu_callout_mask))
-		cpu_relax();
-#endif
-}
-
 static inline void setup_getcpu(int cpu)
 {
 	unsigned long cpudata = vdso_encode_cpunode(cpu, early_cpu_to_node(cpu));
@@ -2239,8 +2226,6 @@ void cpu_init(void)
 	struct task_struct *cur = current;
 	int cpu = raw_smp_processor_id();
 
-	wait_for_master_cpu(cpu);
-
 	ucode_cpu_init(cpu);
 
 #ifdef CONFIG_NUMA
@@ -2293,18 +2278,6 @@ void cpu_init(void)
 	load_fixmap_gdt(cpu);
 }
 
-#ifdef CONFIG_SMP
-void cpu_init_secondary(void)
-{
-	/*
-	 * Relies on the BP having set-up the IDT tables, which are loaded
-	 * on this CPU in cpu_init_exception_handling().
-	 */
-	cpu_init_exception_handling();
-	cpu_init();
-}
-#endif
-
 #ifdef CONFIG_MICROCODE_LATE_LOADING
 /**
  * store_cpu_caps() - Store a snapshot of CPU capabilities
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -220,6 +220,17 @@ static void ap_calibrate_delay(void)
 	cpu_data(smp_processor_id()).loops_per_jiffy = loops_per_jiffy;
 }
 
+static void wait_for_master_cpu(int cpu)
+{
+	/*
+	 * Wait for release by control CPU before continuing with AP
+	 * initialization.
+	 */
+	WARN_ON(cpumask_test_and_set_cpu(cpu, cpu_initialized_mask));
+	while (!cpumask_test_cpu(cpu, cpu_callout_mask))
+		cpu_relax();
+}
+
 /*
  * Activate a secondary processor.
  */
@@ -237,13 +248,16 @@ static void notrace start_secondary(void
 	load_cr3(swapper_pg_dir);
 	__flush_tlb_all();
 #endif
+	cpu_init_exception_handling();
+
 	/*
-	 * Sync point with wait_cpu_initialized(). Before proceeding through
-	 * cpu_init(), the AP will call wait_for_master_cpu() which sets its
-	 * own bit in cpu_initialized_mask and then waits for the BSP to set
-	 * its bit in cpu_callout_mask to release it.
+	 * Sync point with wait_cpu_initialized(). Sets AP in
+	 * cpu_initialized_mask and then waits for the control CPU
+	 * to release it.
 	 */
-	cpu_init_secondary();
+	wait_for_master_cpu(raw_smp_processor_id());
+
+	cpu_init();
 	rcu_cpu_starting(raw_smp_processor_id());
 	x86_cpuinit.early_percpu_clock_init();
 

