Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B36B736CA8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjFTNBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjFTNBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:01:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9945619A6;
        Tue, 20 Jun 2023 06:00:53 -0700 (PDT)
Date:   Tue, 20 Jun 2023 13:00:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687266051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IHnqKX3zFPUhzg5NdonDjx0z2k46RLriZ3H8hzKz34o=;
        b=m2QRURdmIwASV8t/9sTC4LSTORlRxdRZ2mSgvCNAtpjS4dqnZYv85LGZ8CwS2WLgTx0nms
        cbRVy1yxisRlLaY1TeHZJKOW04ed8oCC3uqHgvRnIqXSNT+NxnPYwjbS/d+XmyHHAmn5/m
        6pOfoRWRv2lKf31SzFTmuq/ii1j7KD5rYcb3YL1f9eRVhI+5+CBCEyMqb+ubx3OSofhirr
        xw8/YHHd5zjRd0oPXp3gbmuX9C2g5QtE5qWcIzwgjs+tZn3aoLMbkpD8rGSTyJoYclfq+4
        hwxzEBMX6hrGZSq9r5kMfBolEefb8xTk/paxUWErZiNfip1k9Fbly1zR3zNDiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687266051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IHnqKX3zFPUhzg5NdonDjx0z2k46RLriZ3H8hzKz34o=;
        b=HyausT/1rulZK1G7R74e7gTO+GYoGfqoOe2NDriMNjCDqDdygES1xoQ7YYeWNit7ZbBn6W
        mq7j0MwUqP8wewBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/smp: Put CPUs into INIT on shutdown if possible
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230615193330.608657211@linutronix.de>
References: <20230615193330.608657211@linutronix.de>
MIME-Version: 1.0
Message-ID: <168726604886.404.14688140659781504530.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     45e34c8af58f23db4474e2bfe79183efec09a18b
Gitweb:        https://git.kernel.org/tip/45e34c8af58f23db4474e2bfe79183efec09a18b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Jun 2023 22:34:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Jun 2023 14:51:47 +02:00

x86/smp: Put CPUs into INIT on shutdown if possible

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
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230615193330.608657211@linutronix.de

---
 arch/x86/include/asm/smp.h |  2 ++-
 arch/x86/kernel/smp.c      | 39 ++++++++++++++++++++++++++++++-------
 arch/x86/kernel/smpboot.c  | 19 ++++++++++++++++++-
 3 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index d4ce5cb..5906aa9 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -139,6 +139,8 @@ void native_send_call_func_ipi(const struct cpumask *mask);
 void native_send_call_func_single_ipi(int cpu);
 void x86_idle_thread_init(unsigned int cpu, struct task_struct *idle);
 
+bool smp_park_other_cpus_in_init(void);
+
 void smp_store_boot_cpu_info(void);
 void smp_store_cpu_info(int id);
 
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 174d623..0076932 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -131,7 +131,7 @@ static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
 }
 
 /*
- * this function calls the 'stop' function on all other CPUs in the system.
+ * Disable virtualization, APIC etc. and park the CPU in a HLT loop
  */
 DEFINE_IDTENTRY_SYSVEC(sysvec_reboot)
 {
@@ -172,13 +172,17 @@ static void native_stop_other_cpus(int wait)
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
@@ -194,7 +198,7 @@ static void native_stop_other_cpus(int wait)
 		/*
 		 * Don't wait longer than a second for IPI completion. The
 		 * wait request is not checked here because that would
-		 * prevent an NMI shutdown attempt in case that not all
+		 * prevent an NMI/INIT shutdown in case that not all
 		 * CPUs reach shutdown state.
 		 */
 		timeout = USEC_PER_SEC;
@@ -202,7 +206,27 @@ static void native_stop_other_cpus(int wait)
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
+	 * make HLT resume and handle the MCE. The machine crashes and burns
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
@@ -225,6 +249,7 @@ static void native_stop_other_cpus(int wait)
 			udelay(1);
 	}
 
+done:
 	local_irq_save(flags);
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index b403ead..4ee4339 100644
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
