Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47EB736CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjFTNBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjFTNBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:01:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0308419A4;
        Tue, 20 Jun 2023 06:00:52 -0700 (PDT)
Date:   Tue, 20 Jun 2023 13:00:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687266051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fk9EflcXQS6AEQ2DMFBvgsGzU0jVoz68awZdHSQfTNg=;
        b=O1NElTPoSGpOoKoWggeNQ4H3euVzFL7WwY4jmpydNyG7fu9ZIqhxOvEY8m/vFejpz16kwV
        N4QWsa9UT0keXmtW/8wx2AuL7hVjHH8px70KTZgpJHdbV2hlaxbbhAK+1+nEO6XeyKiFHP
        jI1YdBVgtvNFxH/nA96wr6oqzNTyZYUk3CKP0+k8pG2vUHRTE5Q/NcW5tOhxkL4Ue3QuyJ
        pj4AMLHLe563ilnZYcKUpE1LFhFyt5oSzETHunvUC2nCIEsgW3PoJ17XDzyi1Iq1FVtB3X
        1ECSzBckw6y+IBO8s6lG3cHf1MJc1qlyFV8Bf2vYUsGROc+1pbl6yFu+tpomSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687266051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fk9EflcXQS6AEQ2DMFBvgsGzU0jVoz68awZdHSQfTNg=;
        b=/D0Q8ab5R3iMyYF8F0bD5kE1r7YFi4AmKGIS9XNsYXmA9/c7FQnstjlUyE5dGvzlpqI91n
        dEP7oir4GSsUtQBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/smp: Cure kexec() vs. mwait_play_dead() breakage
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230615193330.492257119@linutronix.de>
References: <20230615193330.492257119@linutronix.de>
MIME-Version: 1.0
Message-ID: <168726605092.404.12077647740780792295.tip-bot2@tip-bot2>
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

Commit-ID:     d7893093a7417527c0d73c9832244e65c9d0114f
Gitweb:        https://git.kernel.org/tip/d7893093a7417527c0d73c9832244e65c9d0114f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Jun 2023 22:33:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Jun 2023 14:51:47 +02:00

x86/smp: Cure kexec() vs. mwait_play_dead() breakage

TLDR: It's a mess.

When kexec() is executed on a system with offline CPUs, which are parked in
mwait_play_dead() it can end up in a triple fault during the bootup of the
kexec kernel or cause hard to diagnose data corruption.

The reason is that kexec() eventually overwrites the previous kernel's text,
page tables, data and stack. If it writes to the cache line which is
monitored by a previously offlined CPU, MWAIT resumes execution and ends
up executing the wrong text, dereferencing overwritten page tables or
corrupting the kexec kernels data.

Cure this by bringing the offlined CPUs out of MWAIT into HLT.

Write to the monitored cache line of each offline CPU, which makes MWAIT
resume execution. The written control word tells the offlined CPUs to issue
HLT, which does not have the MWAIT problem.

That does not help, if a stray NMI, MCE or SMI hits the offlined CPUs as
those make it come out of HLT.

A follow up change will put them into INIT, which protects at least against
NMI and SMI.

Fixes: ea53069231f9 ("x86, hotplug: Use mwait to offline a processor, fix the legacy case")
Reported-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230615193330.492257119@linutronix.de

---
 arch/x86/include/asm/smp.h |  2 +-
 arch/x86/kernel/smp.c      |  5 +++-
 arch/x86/kernel/smpboot.c  | 59 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 66 insertions(+)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 4e91054..d4ce5cb 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -132,6 +132,8 @@ void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
 void cond_wakeup_cpu0(void);
 
+void smp_kick_mwait_play_dead(void);
+
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
 void native_send_call_func_single_ipi(int cpu);
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index d842875..174d623 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/gfp.h>
+#include <linux/kexec.h>
 
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
@@ -157,6 +158,10 @@ static void native_stop_other_cpus(int wait)
 	if (atomic_cmpxchg(&stopping_cpu, -1, cpu) != -1)
 		return;
 
+	/* For kexec, ensure that offline CPUs are out of MWAIT and in HLT */
+	if (kexec_in_progress)
+		smp_kick_mwait_play_dead();
+
 	/*
 	 * 1) Send an IPI on the reboot vector to all other CPUs.
 	 *
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c5ac5d7..483df04 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -53,6 +53,7 @@
 #include <linux/tboot.h>
 #include <linux/gfp.h>
 #include <linux/cpuidle.h>
+#include <linux/kexec.h>
 #include <linux/numa.h>
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
@@ -106,6 +107,9 @@ struct mwait_cpu_dead {
 	unsigned int	status;
 };
 
+#define CPUDEAD_MWAIT_WAIT	0xDEADBEEF
+#define CPUDEAD_MWAIT_KEXEC_HLT	0x4A17DEAD
+
 /*
  * Cache line aligned data for mwait_play_dead(). Separate on purpose so
  * that it's unlikely to be touched by other CPUs.
@@ -173,6 +177,10 @@ static void smp_callin(void)
 {
 	int cpuid;
 
+	/* Mop up eventual mwait_play_dead() wreckage */
+	this_cpu_write(mwait_cpu_dead.status, 0);
+	this_cpu_write(mwait_cpu_dead.control, 0);
+
 	/*
 	 * If waken up by an INIT in an 82489DX configuration
 	 * cpu_callout_mask guarantees we don't get here before
@@ -1807,6 +1815,10 @@ static inline void mwait_play_dead(void)
 			(highest_subcstate - 1);
 	}
 
+	/* Set up state for the kexec() hack below */
+	md->status = CPUDEAD_MWAIT_WAIT;
+	md->control = CPUDEAD_MWAIT_WAIT;
+
 	wbinvd();
 
 	while (1) {
@@ -1824,10 +1836,57 @@ static inline void mwait_play_dead(void)
 		mb();
 		__mwait(eax, 0);
 
+		if (READ_ONCE(md->control) == CPUDEAD_MWAIT_KEXEC_HLT) {
+			/*
+			 * Kexec is about to happen. Don't go back into mwait() as
+			 * the kexec kernel might overwrite text and data including
+			 * page tables and stack. So mwait() would resume when the
+			 * monitor cache line is written to and then the CPU goes
+			 * south due to overwritten text, page tables and stack.
+			 *
+			 * Note: This does _NOT_ protect against a stray MCE, NMI,
+			 * SMI. They will resume execution at the instruction
+			 * following the HLT instruction and run into the problem
+			 * which this is trying to prevent.
+			 */
+			WRITE_ONCE(md->status, CPUDEAD_MWAIT_KEXEC_HLT);
+			while(1)
+				native_halt();
+		}
+
 		cond_wakeup_cpu0();
 	}
 }
 
+/*
+ * Kick all "offline" CPUs out of mwait on kexec(). See comment in
+ * mwait_play_dead().
+ */
+void smp_kick_mwait_play_dead(void)
+{
+	u32 newstate = CPUDEAD_MWAIT_KEXEC_HLT;
+	struct mwait_cpu_dead *md;
+	unsigned int cpu, i;
+
+	for_each_cpu_andnot(cpu, cpu_present_mask, cpu_online_mask) {
+		md = per_cpu_ptr(&mwait_cpu_dead, cpu);
+
+		/* Does it sit in mwait_play_dead() ? */
+		if (READ_ONCE(md->status) != CPUDEAD_MWAIT_WAIT)
+			continue;
+
+		/* Wait up to 5ms */
+		for (i = 0; READ_ONCE(md->status) != newstate && i < 1000; i++) {
+			/* Bring it out of mwait */
+			WRITE_ONCE(md->control, newstate);
+			udelay(5);
+		}
+
+		if (READ_ONCE(md->status) != newstate)
+			pr_err_once("CPU%u is stuck in mwait_play_dead()\n", cpu);
+	}
+}
+
 void __noreturn hlt_play_dead(void)
 {
 	if (__this_cpu_read(cpu_info.x86) >= 4)
