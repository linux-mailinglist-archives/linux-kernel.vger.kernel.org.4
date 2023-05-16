Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E47048BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjEPJMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjEPJKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51D3448E;
        Tue, 16 May 2023 02:10:05 -0700 (PDT)
Date:   Tue, 16 May 2023 09:10:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228201;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ULuzcb5nad6EGCbAuAqxnfKjuoT6ohKfsh71FfBZLxY=;
        b=jGk5ICOXekSwA+c8Ldtk7ZOr4YrBquk8m0FW4SFtxOLB+AU59bm1rCrGBiag+Vus1VkMg2
        jsGseNre9J5Namo7IkzTvYG2HB1wICD5bdjAUKULf+bX5bYVf2xO65F3izwlVcS3NpRX4E
        SxDNXg0Bsm/BcVwsuYQ5+47/2+lwWefM82TChMXvLmYxxKnM+PDdvqW2rN+j6SBZqujVqh
        dFnUyGQE4Lj4ucNqeU11pOkNdf0Bj9OdJACUes46Lhq+uNOOELfYVgWNrnw/GCaXNdkGWN
        V/wAZ1MsZor1FcFJU6NL7YaJfuWk/vpC6AtY5gfuBbN3aPVLTEuxYWTjIzJ/6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228201;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ULuzcb5nad6EGCbAuAqxnfKjuoT6ohKfsh71FfBZLxY=;
        b=wt/eLqj2Qwx3CL6pOLpnMxowx6QYKbFJkjjQdP7vpTWcq8wSvv22nhMsd/K6YCETsplzNa
        9H+pr+JX0tro4xDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/smpboot: Get rid of cpu_init_secondary()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205255.981999763@linutronix.de>
References: <20230512205255.981999763@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422820115.404.14146820972820297511.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     e94cd1503b153ea753f0c4ed9d5ed12e7abd1306
Gitweb:        https://git.kernel.org/tip/e94cd1503b153ea753f0c4ed9d5ed12e7abd1306
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:44:51 +02:00

x86/smpboot: Get rid of cpu_init_secondary()

The synchronization of the AP with the control CPU is a SMP boot problem
and has nothing to do with cpu_init().

Open code cpu_init_secondary() in start_secondary() and move
wait_for_master_cpu() into the SMP boot code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205255.981999763@linutronix.de
---
 arch/x86/include/asm/processor.h |  1 -
 arch/x86/kernel/cpu/common.c     | 27 ---------------------------
 arch/x86/kernel/smpboot.c        | 24 +++++++++++++++++++-----
 3 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a1e4fa5..d46300e 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -551,7 +551,6 @@ extern void switch_gdt_and_percpu_base(int);
 extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
 extern void cpu_init(void);
-extern void cpu_init_secondary(void);
 extern void cpu_init_exception_handling(void);
 extern void cr4_init(void);
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 80710a6..e25fb13 100644
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
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0bd9c9f..50eff9b 100644
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
@@ -237,13 +248,16 @@ static void notrace start_secondary(void *unused)
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
 
