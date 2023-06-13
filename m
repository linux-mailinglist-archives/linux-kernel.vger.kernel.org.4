Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4390F72E2AF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242286AbjFMMSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239026AbjFMMR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:17:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BB810CB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:17:57 -0700 (PDT)
Message-ID: <20230613121615.639116359@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686658676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=R5syc+q39gNuEsthP9jc/1HJgP0yzbDEM2sa8HGymTo=;
        b=QXedgiILOgX4U9zO3CpAhkrakhg9ImQwY+RPK/CFpWR/NPGFDxYzxTb01iiQD+kdy/xIMX
        S8AghohdvJy4E2MXd438LrqAVWwiybcycrcDk2/D+u9Cdr0yJ8ziniVcOroKsFSKujZULM
        mvzlFJiUyvSNksBMEekXftCnW86ji3TOu70xvjvs89LCGvDxWO95cAphre5e7jAW6yUZ8y
        DVrXPvsGZR4jLkQkH4A37eTEutJX8+FFSA1aT3JiIXJ7N/wAbaYWUPLKE8cXrDlRHD9YmZ
        bKUu3zxKy3Dwe5EvNb26Iw8xv5mwmQsI28UaqUgm6k//8FMxGy9eAMUm13ud/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686658676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=R5syc+q39gNuEsthP9jc/1HJgP0yzbDEM2sa8HGymTo=;
        b=BJ/4X4yKAF5hpJKeO67DVXz59+LWF0mDLNOOQ+A5fnBzBhTjR4Pk2hTQUD1QKX8dR5VqI+
        v+20bgFNZFvVyKCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [patch V2 1/8] x86/smp: Make stop_other_cpus() more robust
References: <20230613115353.599087484@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 13 Jun 2023 14:17:55 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Make this more robust by adding a counter which is set to the number of
online CPUs before sending the IPIs and decremented in stop_this_cpu()
after the WBINVD completed. Check for that counter in stop_other_cpus()
instead of watching num_online_cpus().

Fixes: 08f253ec3767 ("x86/cpu: Clear SME feature flag when not in use")
Reported-by: Tony Battersby <tonyb@cybernetics.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com
---
 arch/x86/include/asm/cpu.h |    2 ++
 arch/x86/kernel/process.c  |   10 ++++++++++
 arch/x86/kernel/smp.c      |   15 ++++++++++++---
 3 files changed, 24 insertions(+), 3 deletions(-)


--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -98,4 +98,6 @@ extern u64 x86_read_arch_cap_msr(void);
 int intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
 int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type);
 
+extern atomic_t stop_cpus_count;
+
 #endif /* _ASM_X86_CPU_H */
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -759,6 +759,8 @@ bool xen_set_default_idle(void)
 }
 #endif
 
+atomic_t stop_cpus_count;
+
 void __noreturn stop_this_cpu(void *dummy)
 {
 	local_irq_disable();
@@ -783,6 +785,14 @@ void __noreturn stop_this_cpu(void *dumm
 	 */
 	if (cpuid_eax(0x8000001f) & BIT(0))
 		native_wbinvd();
+
+	/*
+	 * native_stop_other_cpus() will write to @stop_cpus_count after
+	 * observing that it went down to zero, which will invalidate the
+	 * cacheline on this CPU.
+	 */
+	atomic_dec(&stop_cpus_count);
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
@@ -171,6 +172,8 @@ static void native_stop_other_cpus(int w
 		if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) != -1)
 			return;
 
+		atomic_set(&stop_cpus_count, num_online_cpus() - 1);
+
 		/* sync above data before sending IRQ */
 		wmb();
 
@@ -183,12 +186,12 @@ static void native_stop_other_cpus(int w
 		 * CPUs reach shutdown state.
 		 */
 		timeout = USEC_PER_SEC;
-		while (num_online_cpus() > 1 && timeout--)
+		while (atomic_read(&stop_cpus_count) > 0 && timeout--)
 			udelay(1);
 	}
 
 	/* if the REBOOT_VECTOR didn't work, try with the NMI */
-	if (num_online_cpus() > 1) {
+	if (atomic_read(&stop_cpus_count) > 0) {
 		/*
 		 * If NMI IPI is enabled, try to register the stop handler
 		 * and send the IPI. In any case try to wait for the other
@@ -208,7 +211,7 @@ static void native_stop_other_cpus(int w
 		 * one or more CPUs do not reach shutdown state.
 		 */
 		timeout = USEC_PER_MSEC * 10;
-		while (num_online_cpus() > 1 && (wait || timeout--))
+		while (atomic_read(&stop_cpus_count) > 0 && (wait || timeout--))
 			udelay(1);
 	}
 
@@ -216,6 +219,12 @@ static void native_stop_other_cpus(int w
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
 	local_irq_restore(flags);
+
+	/*
+	 * Ensure that the cache line is invalidated on the other CPUs. See
+	 * comment vs. SME in stop_this_cpu().
+	 */
+	atomic_set(&stop_cpus_count, INT_MAX);
 }
 
 /*

