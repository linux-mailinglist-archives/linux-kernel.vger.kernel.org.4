Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8BC7320F7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbjFOUeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjFOUeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:34:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDA32726
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:34:02 -0700 (PDT)
Message-ID: <20230615193330.608657211@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686861241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sB20Kb5T4u+9i61NvPvEsJiORwRSTA74S2zqtl199PY=;
        b=BaHhWLU2EShAROun32+ROuKfZitFcUI5v3U7bROdAZZ+ckMrySgLc6wkjRD9eMH/aRZymJ
        Nqhwos4Mm+AzCezgDOxqtjrLZIkwk77SeZceGfXdBeB5Bz2owgmnkxeIZZKR5CRUaktjRx
        vsdx3FEXH1wleZ9nHyTAdZsKxEe1h46OHVvifivtS7H2ZxNimLANOPFDsNz7r5ofpXafva
        7k4HcrkVQim8S8pJbI7EoESkdShYAkJlZ0AWnrv2zoNfSvD6T4nb0At6k20gC/M0YRHm4m
        32SoFhkjwOM6qjDr+NYT0+FJ2l+yV+udh3/8REXIkmtiCr68V4eOGYfHhx2JJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686861241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sB20Kb5T4u+9i61NvPvEsJiORwRSTA74S2zqtl199PY=;
        b=g4FohfePyTHWmZB41seYYWB41AN9TC1rgqtGNVATbK2B6nrMKeBT3NOlKk72yoPJY5Y5H5
        fHJgAOsNIAGRrmAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [patch v3 7/7] x86/smp: Put CPUs into INIT on shutdown if possible
References: <20230615190036.898273129@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 15 Jun 2023 22:34:00 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parking CPUs in a HLT loop is not completely safe vs. kexec() as HLT can
resume execution due to NMI, SMI and MCE, which has the same issue as the
MWAIT loop.

Kicking the secondary CPUs into INIT makes this safe against NMI and SMI.

A broadcast MCE will take the machine down, but a broadcast MCE which makes
HLT resume and execute overwritten text, pagetables or data will end up in
a disaster too.

So chose the lesser of two evils and kick the secondary CPUs into INIT
unless the system has installed special wakeup mechanisms which are not
using INIT.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
V3: Renamed the function to smp_park_other_cpus_in_init() so it can
    be reused for crash eventually.
---
 arch/x86/include/asm/smp.h |    2 ++
 arch/x86/kernel/smp.c      |   39 ++++++++++++++++++++++++++++++++-------
 arch/x86/kernel/smpboot.c  |   19 +++++++++++++++++++
 3 files changed, 53 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -139,6 +139,8 @@ void native_send_call_func_ipi(const str
 void native_send_call_func_single_ipi(int cpu);
 void x86_idle_thread_init(unsigned int cpu, struct task_struct *idle);
 
+bool smp_park_other_cpus_in_init(void);
+
 void smp_store_boot_cpu_info(void);
 void smp_store_cpu_info(int id);
 
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -131,7 +131,7 @@ static int smp_stop_nmi_callback(unsigne
 }
 
 /*
- * this function calls the 'stop' function on all other CPUs in the system.
+ * Disable virtualization, APIC etc. and park the CPU in a HLT loop
  */
 DEFINE_IDTENTRY_SYSVEC(sysvec_reboot)
 {
@@ -172,13 +172,17 @@ static void native_stop_other_cpus(int w
 	 * 2) Wait for all other CPUs to report that they reached the
 	 *    HLT loop in stop_this_cpu()
 	 *
-	 * 3) If #2 timed out send an NMI to the CPUs which did not
-	 *    yet report
+	 * 3) If the system uses INIT/STARTUP for CPU bringup, then
+	 *    send all present CPUs an INIT vector, which brings them
+	 *    completely out of the way.
 	 *
-	 * 4) Wait for all other CPUs to report that they reached the
+	 * 4) If #3 is not possible and #2 timed out send an NMI to the
+	 *    CPUs which did not yet report
+	 *
+	 * 5) Wait for all other CPUs to report that they reached the
 	 *    HLT loop in stop_this_cpu()
 	 *
-	 * #3 can obviously race against a CPU reaching the HLT loop late.
+	 * #4 can obviously race against a CPU reaching the HLT loop late.
 	 * That CPU will have reported already and the "have all CPUs
 	 * reached HLT" condition will be true despite the fact that the
 	 * other CPU is still handling the NMI. Again, there is no
@@ -194,7 +198,7 @@ static void native_stop_other_cpus(int w
 		/*
 		 * Don't wait longer than a second for IPI completion. The
 		 * wait request is not checked here because that would
-		 * prevent an NMI shutdown attempt in case that not all
+		 * prevent an NMI/INIT shutdown in case that not all
 		 * CPUs reach shutdown state.
 		 */
 		timeout = USEC_PER_SEC;
@@ -202,7 +206,27 @@ static void native_stop_other_cpus(int w
 			udelay(1);
 	}
 
-	/* if the REBOOT_VECTOR didn't work, try with the NMI */
+	/*
+	 * Park all other CPUs in INIT including "offline" CPUs, if
+	 * possible. That's a safe place where they can't resume execution
+	 * of HLT and then execute the HLT loop from overwritten text or
+	 * page tables.
+	 *
+	 * The only downside is a broadcast MCE, but up to the point where
+	 * the kexec() kernel brought all APs online again an MCE will just
+	 * make HLT resume and handle the MCE. The machine crashs and burns
+	 * due to overwritten text, page tables and data. So there is a
+	 * choice between fire and frying pan. The result is pretty much
+	 * the same. Chose frying pan until x86 provides a sane mechanism
+	 * to park a CPU.
+	 */
+	if (smp_park_other_cpus_in_init())
+		goto done;
+
+	/*
+	 * If park with INIT was not possible and the REBOOT_VECTOR didn't
+	 * take all secondary CPUs offline, try with the NMI.
+	 */
 	if (!cpumask_empty(&cpus_stop_mask)) {
 		/*
 		 * If NMI IPI is enabled, try to register the stop handler
@@ -234,6 +258,7 @@ static void native_stop_other_cpus(int w
 			udelay(1);
 	}
 
+done:
 	local_irq_save(flags);
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1465,6 +1465,25 @@ void arch_thaw_secondary_cpus_end(void)
 	cache_aps_init();
 }
 
+bool smp_park_other_cpus_in_init(void)
+{
+	unsigned int cpu, this_cpu = smp_processor_id();
+	unsigned int apicid;
+
+	if (apic->wakeup_secondary_cpu_64 || apic->wakeup_secondary_cpu)
+		return false;
+
+	for_each_present_cpu(cpu) {
+		if (cpu == this_cpu)
+			continue;
+		apicid = apic->cpu_present_to_apicid(cpu);
+		if (apicid == BAD_APICID)
+			continue;
+		send_init_sequence(apicid);
+	}
+	return true;
+}
+
 /*
  * Early setup to make printk work.
  */

