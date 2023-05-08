Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87C06FB78D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 21:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbjEHTrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 15:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjEHTqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 15:46:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782D07AA2;
        Mon,  8 May 2023 12:45:01 -0700 (PDT)
Message-ID: <20230508185218.578643863@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683575046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=i+dpCSWhwU+6bxlys4Er8+x/ffOHETyJWzg+gvnggWo=;
        b=3YwCUqtcytN4aZ861iesyIkZVFpl/8iL7JOPtbTJ0r8YY9O0hA7PFKQWP/VhOladl6YVHd
        oXNqHi6CaE4fWqff5AfQx90V5PHNtVWab0q5q+CzuVLQ5ClyvMceIGCQoA0U4NdI74Hytu
        Y3+HQXGflBDUkC3QrjVDyzDuu8vc8DF+sOcub1w+SQcfQYuMDSr3sl8AKEXss71YCzdSNs
        K7FTL0G2EvbmjosCTFqcQQ7qoBmKw+7tjhjizRZuxtJ5Q9gW/83BR4ZSbhIvjd7P97RrbH
        UnZ5DsNlB/OjkMSIOge9mTydw1E/0zyqU08V3gaeRZYJK9GS0p6p4RbTCnf4YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683575046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=i+dpCSWhwU+6bxlys4Er8+x/ffOHETyJWzg+gvnggWo=;
        b=0A6YOWIgV3ASET2u6qXUkyJUtq2zMc+7jX705tummCTsCytwDoD9pqfjOP2BrOuDpfQPwG
        r85LDKJye1tnlVAA==
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
Subject: [patch v3 24/36] [patch V2 24/38] MIPS: SMP_CPS: Switch to hotplug
 core state synchronization
References: <20230508181633.089804905@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  8 May 2023 21:44:05 +0200 (CEST)
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

Switch to the CPU hotplug core state tracking and synchronization
mechanim. This unfortunately requires to add dead reporting to the non CPS
platforms as CPS is the only user, but it allows an overall consolidation
of this functionality.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>


---
 arch/mips/Kconfig               |    1 +
 arch/mips/cavium-octeon/smp.c   |    1 +
 arch/mips/include/asm/smp-ops.h |    1 +
 arch/mips/kernel/smp-bmips.c    |    1 +
 arch/mips/kernel/smp-cps.c      |   14 +++++---------
 arch/mips/kernel/smp.c          |    8 ++++++++
 arch/mips/loongson64/smp.c      |    1 +
 7 files changed, 18 insertions(+), 9 deletions(-)
---

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2285,6 +2285,7 @@ config MIPS_CPS
 	select MIPS_CM
 	select MIPS_CPS_PM if HOTPLUG_CPU
 	select SMP
+	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select SYNC_R4K if (CEVT_R4K || CSRC_R4K)
 	select SYS_SUPPORTS_HOTPLUG_CPU
 	select SYS_SUPPORTS_SCHED_SMT if CPU_MIPSR6
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -345,6 +345,7 @@ void play_dead(void)
 	int cpu = cpu_number_map(cvmx_get_core_num());
 
 	idle_task_exit();
+	cpuhp_ap_report_dead();
 	octeon_processor_boot = 0xff;
 	per_cpu(cpu_state, cpu) = CPU_DEAD;
 
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -33,6 +33,7 @@ struct plat_smp_ops {
 #ifdef CONFIG_HOTPLUG_CPU
 	int (*cpu_disable)(void);
 	void (*cpu_die)(unsigned int cpu);
+	void (*cleanup_dead_cpu)(unsigned cpu);
 #endif
 #ifdef CONFIG_KEXEC
 	void (*kexec_nonboot_cpu)(void);
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -392,6 +392,7 @@ static void bmips_cpu_die(unsigned int c
 void __ref play_dead(void)
 {
 	idle_task_exit();
+	cpuhp_ap_report_dead();
 
 	/* flush data cache */
 	_dma_cache_wback_inv(0, ~0);
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -503,8 +503,7 @@ void play_dead(void)
 		}
 	}
 
-	/* This CPU has chosen its way out */
-	(void)cpu_report_death();
+	cpuhp_ap_report_dead();
 
 	cps_shutdown_this_cpu(cpu_death);
 
@@ -527,7 +526,9 @@ static void wait_for_sibling_halt(void *
 	} while (!(halted & TCHALT_H));
 }
 
-static void cps_cpu_die(unsigned int cpu)
+static void cps_cpu_die(unsigned int cpu) { }
+
+static void cps_cleanup_dead_cpu(unsigned cpu)
 {
 	unsigned core = cpu_core(&cpu_data[cpu]);
 	unsigned int vpe_id = cpu_vpe_id(&cpu_data[cpu]);
@@ -535,12 +536,6 @@ static void cps_cpu_die(unsigned int cpu
 	unsigned stat;
 	int err;
 
-	/* Wait for the cpu to choose its way out */
-	if (!cpu_wait_death(cpu, 5)) {
-		pr_err("CPU%u: didn't offline\n", cpu);
-		return;
-	}
-
 	/*
 	 * Now wait for the CPU to actually offline. Without doing this that
 	 * offlining may race with one or more of:
@@ -624,6 +619,7 @@ static const struct plat_smp_ops cps_smp
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_disable		= cps_cpu_disable,
 	.cpu_die		= cps_cpu_die,
+	.cleanup_dead_cpu	= cps_cleanup_dead_cpu,
 #endif
 #ifdef CONFIG_KEXEC
 	.kexec_nonboot_cpu	= cps_kexec_nonboot_cpu,
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -690,6 +690,14 @@ void flush_tlb_one(unsigned long vaddr)
 EXPORT_SYMBOL(flush_tlb_page);
 EXPORT_SYMBOL(flush_tlb_one);
 
+#ifdef CONFIG_HOTPLUG_CPU
+void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
+{
+	if (mp_ops->cleanup_dead_cpu)
+		mp_ops->cleanup_dead_cpu(cpu);
+}
+#endif
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 
 static void tick_broadcast_callee(void *info)
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -775,6 +775,7 @@ void play_dead(void)
 	void (*play_dead_at_ckseg1)(int *);
 
 	idle_task_exit();
+	cpuhp_ap_report_dead();
 
 	prid_imp = read_c0_prid() & PRID_IMP_MASK;
 	prid_rev = read_c0_prid() & PRID_REV_MASK;


