Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A6A7337D1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjFPSCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFPSCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:02:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739921707
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:01:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686938517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=It73UFyyvHcpxiWzbSASpebA+peGnCgZ9bdgCn/OPdA=;
        b=ImHinwvqrCT3slf8E/dNuXOchhCmMOyQPzimEL59E8i+P9PmGDNsUzPB6be1uS1FHBOZao
        wfHQCXMgpQD2ADlM9B7D3zOxOsAlnaPCxqsOmo4M/0zTMkr6wNXwHJjrDXAqCrd2weyTNr
        2Vpi0P4QCrek9BxZtBntfzXQBaD7lFp1bkB386QAm686xdU9hI7s9FiVehfTxJiT7b6Vd6
        DDtjvxuJAv5jt7/OJuT7YPflV5ApMzzeLq3sT03a+/syEgLSHOMlJ2QB6jJfRAY8zSGlHD
        sbcw0LGPt+/U2z0yKu0nx5JHXJY204SV0h5K5rAnfqFB1WPGGIpP4pano/kn2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686938517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=It73UFyyvHcpxiWzbSASpebA+peGnCgZ9bdgCn/OPdA=;
        b=Ruhrabjc2Vb6kqt5vaPsczV2AqQnmCzHcj6YibaPttRO/IIYO4zdtA1vkZ+jqakZHBK+ob
        gBLiI6eNPQwtlFBA==
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch v3 1/7] x86/smp: Make stop_other_cpus() more robust
In-Reply-To: <ZIxt9Er5nJRjCUXh@a4bf019067fa.jf.intel.com>
References: <20230615190036.898273129@linutronix.de>
 <20230615193330.263684884@linutronix.de>
 <ZIvByEFqiJZOyau2@a4bf019067fa.jf.intel.com> <87mt0z7si2.ffs@tglx>
 <ZIxt9Er5nJRjCUXh@a4bf019067fa.jf.intel.com>
Date:   Fri, 16 Jun 2023 20:01:56 +0200
Message-ID: <87h6r770bv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16 2023 at 07:13, Ashok Raj wrote:
> On Fri, Jun 16, 2023 at 09:53:25AM +0200, Thomas Gleixner wrote:
>> > can we simplify this by just apic->send_IPI(cpu, NMI_VECTOR); ??
>> 
>> That would not set APIC_DM_NMI in delivery mode and the IPI would be
>> sent with APIC_DM_FIXED.
>
> That's correct. 
>
> Maybe if we use apic->send_IPI_mask(cpumask_of(cpu), NMI_VECTOR)
>
> apic->send_IPI_mask(cpumask_of(cpu),NMI_VECTOR)
>    __x2apic_send_IPI_mask() 
>       __x2apic_send_IPI_dest()
> 	  unsigned long cfg = __prepare_ICR(0, vector, dest);
> 	  native_x2apic_icr_write(cfg, apicid);
>
> __prepare_ICR() seems to have the magic for APIC_DM_NMI?

Bah. I clearly neither can read nor can remember any of the internals of
that code:

apic->send_IPI()
  x2apic_send_IPI()
    __x2apic_send_IPI_dest()

It also works for all other APIC incarnations. 

Thanks,

        tglx
---
From: Thomas Gleixner <tglx@linutronix.de>
Subject: x86/smp: Make stop_other_cpus() more robust
Date: Wed, 26 Apr 2023 18:37:00 +0200

Tony reported intermittent lockups on poweroff. His analysis identified the
wbinvd() in stop_this_cpu() as the culprit. This was added to ensure that
on SME enabled machines a kexec() does not leave any stale data in the
caches when switching from encrypted to non-encrypted mode or vice versa.

That wbindv() is conditional on the SME feature bit which is read directly
from CPUID. But that readout does not check whether the CPUID leaf is
available or not. If it's not available the CPU will return the value of
the highest supported leaf instead. Depending on the content the "SME" bit
might be set or not.

That's incorrect but harmless. Making the CPUID readout conditional makes
the observed hangs go away, but it does not fix the underlying problem:

CPU0					CPU1

 stop_other_cpus()
   send_IPIs(REBOOT);			stop_this_cpu()
   while (num_online_cpus() > 1);         set_online(false);
   proceed... -> hang
				          wbinvd()

WBINVD is an expensive operation and if multiple CPUs issue it at the same
time the resulting delays are even larger.

But CPU0 already observed num_online_cpus() going down to 1 and proceeds
which causes the system to hang.

This issue exists independent of WBINVD, but the delays caused by WBINVD
make it more prominent.

Make this more robust by adding a cpumask which is initialized to the
online CPU mask before sending the IPIs and CPUs clear their bit in
stop_this_cpu() after the WBINVD completed. Check for that cpumask to
become empty in stop_other_cpus() instead of watching num_online_cpus().

The cpumask cannot plug all holes either, but it's better than a raw
counter and allows to restrict the NMI fallback IPI to be sent only the
CPUs which have not reported within the timeout window.

Fixes: 08f253ec3767 ("x86/cpu: Clear SME feature flag when not in use")
Reported-by: Tony Battersby <tonyb@cybernetics.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com
---
V3: Use a cpumask to make the NMI case slightly safer - Ashok
V4: Simplify the NMI IPI code - Ashok
---
 arch/x86/include/asm/cpu.h |    2 +
 arch/x86/kernel/process.c  |   23 +++++++++++++++-
 arch/x86/kernel/smp.c      |   62 +++++++++++++++++++++++++++++----------------
 3 files changed, 64 insertions(+), 23 deletions(-)


--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -98,4 +98,6 @@ extern u64 x86_read_arch_cap_msr(void);
 int intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
 int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type);
 
+extern struct cpumask cpus_stop_mask;
+
 #endif /* _ASM_X86_CPU_H */
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -759,13 +759,23 @@ bool xen_set_default_idle(void)
 }
 #endif
 
+struct cpumask cpus_stop_mask;
+
 void __noreturn stop_this_cpu(void *dummy)
 {
+	unsigned int cpu = smp_processor_id();
+
 	local_irq_disable();
+
 	/*
-	 * Remove this CPU:
+	 * Remove this CPU from the online mask and disable it
+	 * unconditionally. This might be redundant in case that the reboot
+	 * vector was handled late and stop_other_cpus() sent an NMI.
+	 *
+	 * According to SDM and APM NMIs can be accepted even after soft
+	 * disabling the local APIC.
 	 */
-	set_cpu_online(smp_processor_id(), false);
+	set_cpu_online(cpu, false);
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
 
@@ -783,6 +793,15 @@ void __noreturn stop_this_cpu(void *dumm
 	 */
 	if (cpuid_eax(0x8000001f) & BIT(0))
 		native_wbinvd();
+
+	/*
+	 * This brings a cache line back and dirties it, but
+	 * native_stop_other_cpus() will overwrite cpus_stop_mask after it
+	 * observed that all CPUs reported stop. This write will invalidate
+	 * the related cache line on this CPU.
+	 */
+	cpumask_clear_cpu(cpu, &cpus_stop_mask);
+
 	for (;;) {
 		/*
 		 * Use native_halt() so that memory contents don't change
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -27,6 +27,7 @@
 #include <asm/mmu_context.h>
 #include <asm/proto.h>
 #include <asm/apic.h>
+#include <asm/cpu.h>
 #include <asm/idtentry.h>
 #include <asm/nmi.h>
 #include <asm/mce.h>
@@ -146,31 +147,43 @@ static int register_stop_handler(void)
 
 static void native_stop_other_cpus(int wait)
 {
-	unsigned long flags;
-	unsigned long timeout;
+	unsigned int cpu = smp_processor_id();
+	unsigned long flags, timeout;
 
 	if (reboot_force)
 		return;
 
-	/*
-	 * Use an own vector here because smp_call_function
-	 * does lots of things not suitable in a panic situation.
-	 */
+	/* Only proceed if this is the first CPU to reach this code */
+	if (atomic_cmpxchg(&stopping_cpu, -1, cpu) != -1)
+		return;
 
 	/*
-	 * We start by using the REBOOT_VECTOR irq.
-	 * The irq is treated as a sync point to allow critical
-	 * regions of code on other cpus to release their spin locks
-	 * and re-enable irqs.  Jumping straight to an NMI might
-	 * accidentally cause deadlocks with further shutdown/panic
-	 * code.  By syncing, we give the cpus up to one second to
-	 * finish their work before we force them off with the NMI.
+	 * 1) Send an IPI on the reboot vector to all other CPUs.
+	 *
+	 *    The other CPUs should react on it after leaving critical
+	 *    sections and re-enabling interrupts. They might still hold
+	 *    locks, but there is nothing which can be done about that.
+	 *
+	 * 2) Wait for all other CPUs to report that they reached the
+	 *    HLT loop in stop_this_cpu()
+	 *
+	 * 3) If #2 timed out send an NMI to the CPUs which did not
+	 *    yet report
+	 *
+	 * 4) Wait for all other CPUs to report that they reached the
+	 *    HLT loop in stop_this_cpu()
+	 *
+	 * #3 can obviously race against a CPU reaching the HLT loop late.
+	 * That CPU will have reported already and the "have all CPUs
+	 * reached HLT" condition will be true despite the fact that the
+	 * other CPU is still handling the NMI. Again, there is no
+	 * protection against that as "disabled" APICs still respond to
+	 * NMIs.
 	 */
-	if (num_online_cpus() > 1) {
-		/* did someone beat us here? */
-		if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) != -1)
-			return;
+	cpumask_copy(&cpus_stop_mask, cpu_online_mask);
+	cpumask_clear_cpu(cpu, &cpus_stop_mask);
 
+	if (!cpumask_empty(&cpus_stop_mask)) {
 		/* sync above data before sending IRQ */
 		wmb();
 
@@ -183,12 +196,12 @@ static void native_stop_other_cpus(int w
 		 * CPUs reach shutdown state.
 		 */
 		timeout = USEC_PER_SEC;
-		while (num_online_cpus() > 1 && timeout--)
+		while (!cpumask_empty(&cpus_stop_mask) && timeout--)
 			udelay(1);
 	}
 
 	/* if the REBOOT_VECTOR didn't work, try with the NMI */
-	if (num_online_cpus() > 1) {
+	if (!cpumask_empty(&cpus_stop_mask)) {
 		/*
 		 * If NMI IPI is enabled, try to register the stop handler
 		 * and send the IPI. In any case try to wait for the other
@@ -200,7 +213,8 @@ static void native_stop_other_cpus(int w
 
 			pr_emerg("Shutting down cpus with NMI\n");
 
-			apic_send_IPI_allbutself(NMI_VECTOR);
+			for_each_cpu(cpu, &cpus_stop_mask)
+				apic->send_IPI(cpu, NMI_VECTOR);
 		}
 		/*
 		 * Don't wait longer than 10 ms if the caller didn't
@@ -208,7 +222,7 @@ static void native_stop_other_cpus(int w
 		 * one or more CPUs do not reach shutdown state.
 		 */
 		timeout = USEC_PER_MSEC * 10;
-		while (num_online_cpus() > 1 && (wait || timeout--))
+		while (!cpumask_empty(&cpus_stop_mask) && (wait || timeout--))
 			udelay(1);
 	}
 
@@ -216,6 +230,12 @@ static void native_stop_other_cpus(int w
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
 	local_irq_restore(flags);
+
+	/*
+	 * Ensure that the cpus_stop_mask cache lines are invalidated on
+	 * the other CPUs. See comment vs. SME in stop_this_cpu().
+	 */
+	cpumask_clear(&cpus_stop_mask);
 }
 
 /*
