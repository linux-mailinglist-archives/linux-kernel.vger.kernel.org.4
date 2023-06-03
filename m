Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3B0721274
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 22:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjFCUI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 16:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjFCUIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 16:08:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693E4E69
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 13:07:54 -0700 (PDT)
Message-ID: <20230603200459.947733085@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685822825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=58ciVfBbzjxuvXyJZlI2x4w/lpUE1kObMgg65Z8puj4=;
        b=k0RLuIJfu2acp3uJige/wnB1o3b00dIeIQUtTTHPmJUvBflBrt59Udj5QRO++OiMNS4JEs
        9Y5njrqjzdJmXr3CBhRkWOQvJj9YfbabsAvF5atOh17zeYQVA+pXV1r/ApNQJJSX0gsrp0
        xANnVDlXQzFANAA2WFVU7w0MOTn4aZ4B75QFXY0qq+0jcBOJPlxNyYiBt3cL0SgxvfEjN1
        hfTbA9Awl+dwJ1N9oCkYmRb5PBuZBX4APwrLeYXe+i6hBbbQMH4zpyDB9+U/qqUK21B5Bg
        ZXmYJNn6RYMN8OyfCiLTsBsOhMgrM1Ubsdw5fh6f2grzels7iZGIk/Er3cxUWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685822825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=58ciVfBbzjxuvXyJZlI2x4w/lpUE1kObMgg65Z8puj4=;
        b=ukQiSp2yRu+wh7kqBZofjrfC6122zjd2/ElbhiDKxg4ad5K2CCUaIUqZRe9ViVeyGK8gmv
        j1xamtJMAH4PJ8Bg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [patch 6/6] x86/smp: Put CPUs into INIT on shutdown if possible
References: <20230603193439.502645149@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat,  3 Jun 2023 22:07:04 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 arch/x86/include/asm/smp.h |    2 ++
 arch/x86/kernel/smp.c      |   38 +++++++++++++++++++++++++++++---------
 arch/x86/kernel/smpboot.c  |   19 +++++++++++++++++++
 3 files changed, 50 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -139,6 +139,8 @@ void native_send_call_func_ipi(const str
 void native_send_call_func_single_ipi(int cpu);
 void x86_idle_thread_init(unsigned int cpu, struct task_struct *idle);
 
+bool smp_park_nonboot_cpus_in_init(void);
+
 void smp_store_boot_cpu_info(void);
 void smp_store_cpu_info(int id);
 
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -130,7 +130,7 @@ static int smp_stop_nmi_callback(unsigne
 }
 
 /*
- * this function calls the 'stop' function on all other CPUs in the system.
+ * Disable virtualization, APIC etc. and park the CPU in a HLT loop
  */
 DEFINE_IDTENTRY_SYSVEC(sysvec_reboot)
 {
@@ -147,8 +147,7 @@ static int register_stop_handler(void)
 
 static void native_stop_other_cpus(int wait)
 {
-	unsigned long flags;
-	unsigned long timeout;
+	unsigned long flags, timeout;
 
 	if (reboot_force)
 		return;
@@ -164,10 +163,10 @@ static void native_stop_other_cpus(int w
 	/*
 	 * Start by using the REBOOT_VECTOR. That acts as a sync point to
 	 * allow critical regions of code on other cpus to leave their
-	 * critical regions. Jumping straight to an NMI might accidentally
-	 * cause deadlocks with further shutdown code. This gives the CPUs
-	 * up to one second to finish their work before forcing them off
-	 * with the NMI.
+	 * critical regions. Jumping straight to NMI or INIT might
+	 * accidentally cause deadlocks with further shutdown code. This
+	 * gives the CPUs up to one second to finish their work before
+	 * forcing them off with the NMI or INIT.
 	 */
 	if (num_online_cpus() > 1) {
 		apic_send_IPI_allbutself(REBOOT_VECTOR);
@@ -175,7 +174,7 @@ static void native_stop_other_cpus(int w
 		/*
 		 * Don't wait longer than a second for IPI completion. The
 		 * wait request is not checked here because that would
-		 * prevent an NMI shutdown attempt in case that not all
+		 * prevent an NMI/INIT shutdown in case that not all
 		 * CPUs reach shutdown state.
 		 */
 		timeout = USEC_PER_SEC;
@@ -183,7 +182,27 @@ static void native_stop_other_cpus(int w
 			udelay(1);
 	}
 
-	/* if the REBOOT_VECTOR didn't work, try with the NMI */
+	/*
+	 * Park all nonboot CPUs in INIT including offline CPUs, if
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
+	if (smp_park_nonboot_cpus_in_init())
+		goto done;
+
+	/*
+	 * If park with INIT was not possible and the REBOOT_VECTOR didn't
+	 * take all secondary CPUs offline, try with the NMI.
+	 */
 	if (num_online_cpus() > 1) {
 		/*
 		 * If NMI IPI is enabled, try to register the stop handler
@@ -208,6 +227,7 @@ static void native_stop_other_cpus(int w
 			udelay(1);
 	}
 
+done:
 	local_irq_save(flags);
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1467,6 +1467,25 @@ void arch_thaw_secondary_cpus_end(void)
 	cache_aps_init();
 }
 
+bool smp_park_nonboot_cpus_in_init(void)
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

