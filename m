Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CC57048B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjEPJLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjEPJKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69E23A8B;
        Tue, 16 May 2023 02:10:04 -0700 (PDT)
Date:   Tue, 16 May 2023 09:10:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228201;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3q8O7a28kSLjHluxQewDFtvXhCS5hO4DWnL4DgX97Dw=;
        b=zOfaVihHqPUWaq8awz3QcCU3U30w18i475a4w2pM4BEwvmFH+aoTTHWk/YKgm+01t5/ZOl
        K14bVns3VHE6oBo8/DPpwSBpiAuzavBXsKBmvELTqn5xtdC5r6lNsRGBpvauqmd4En7Ndf
        s/gh3gugL3z3b+0PVkRJf8nTw6MJJ/9YbpYnWBB7A/FHrfkL7IMMxwk8G80g+UC5j/mfUp
        wFr2AX+/jrRDlQY4wtswkxKZjllyOqa1SYtLxSiAznwVARxW2IdXeYKRd9RkOHCTgrnljD
        CP3VRP1Ufa1yr64SXzrrdezj1Xc/O31fbuqNOCP4m+C2IF249lHmUiTGaejr4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228201;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3q8O7a28kSLjHluxQewDFtvXhCS5hO4DWnL4DgX97Dw=;
        b=5Dw+GBggcSjnC6OO01mnWDSIp0e/SaR6Q9Dkk7dTHK3dTRWYwg0bjOFpYlQws3YrvDaPPd
        VQZ+tiL8xNorDvAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/smpboot: Move synchronization masks to SMP boot code
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205256.091511483@linutronix.de>
References: <20230512205256.091511483@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422820054.404.7589840711079362902.tip-bot2@tip-bot2>
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

Commit-ID:     d4f28f07c2fe736bce8ca415a86fb74c629200f3
Gitweb:        https://git.kernel.org/tip/d4f28f07c2fe736bce8ca415a86fb74c629200f3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:16 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:44:52 +02:00

x86/smpboot: Move synchronization masks to SMP boot code

The usage is in smpboot.c and not in the CPU initialization code.

The XEN_PV usage of cpu_callout_mask is obsolete as cpu_init() not longer
waits and cacheinfo has its own CPU mask now, so cpu_callout_mask can be
made static too.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205256.091511483@linutronix.de
---
 arch/x86/include/asm/cpumask.h |  5 -----
 arch/x86/kernel/cpu/common.c   | 17 -----------------
 arch/x86/kernel/smpboot.c      | 16 ++++++++++++++++
 arch/x86/xen/smp_pv.c          |  3 ---
 4 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/cpumask.h b/arch/x86/include/asm/cpumask.h
index c5aed9e..4acfd57 100644
--- a/arch/x86/include/asm/cpumask.h
+++ b/arch/x86/include/asm/cpumask.h
@@ -4,11 +4,6 @@
 #ifndef __ASSEMBLY__
 #include <linux/cpumask.h>
 
-extern cpumask_var_t cpu_callin_mask;
-extern cpumask_var_t cpu_callout_mask;
-extern cpumask_var_t cpu_initialized_mask;
-extern cpumask_var_t cpu_sibling_setup_mask;
-
 extern void setup_cpu_local_masks(void);
 
 /*
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index e25fb13..640fd18 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -67,14 +67,6 @@
 
 u32 elf_hwcap2 __read_mostly;
 
-/* all of these masks are initialized in setup_cpu_local_masks() */
-cpumask_var_t cpu_initialized_mask;
-cpumask_var_t cpu_callout_mask;
-cpumask_var_t cpu_callin_mask;
-
-/* representing cpus for which sibling maps can be computed */
-cpumask_var_t cpu_sibling_setup_mask;
-
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
 EXPORT_SYMBOL(smp_num_siblings);
@@ -169,15 +161,6 @@ clear_ppin:
 	clear_cpu_cap(c, info->feature);
 }
 
-/* correctly size the local cpu masks */
-void __init setup_cpu_local_masks(void)
-{
-	alloc_bootmem_cpumask_var(&cpu_initialized_mask);
-	alloc_bootmem_cpumask_var(&cpu_callin_mask);
-	alloc_bootmem_cpumask_var(&cpu_callout_mask);
-	alloc_bootmem_cpumask_var(&cpu_sibling_setup_mask);
-}
-
 static void default_init(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 50eff9b..8b07c6e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -101,6 +101,13 @@ EXPORT_PER_CPU_SYMBOL(cpu_die_map);
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
 
+/* All of these masks are initialized in setup_cpu_local_masks() */
+static cpumask_var_t cpu_initialized_mask;
+static cpumask_var_t cpu_callout_mask;
+static cpumask_var_t cpu_callin_mask;
+/* Representing CPUs for which sibling maps can be computed */
+static cpumask_var_t cpu_sibling_setup_mask;
+
 /* Logical package management. We might want to allocate that dynamically */
 unsigned int __max_logical_packages __read_mostly;
 EXPORT_SYMBOL(__max_logical_packages);
@@ -1545,6 +1552,15 @@ __init void prefill_possible_map(void)
 		set_cpu_possible(i, true);
 }
 
+/* correctly size the local cpu masks */
+void __init setup_cpu_local_masks(void)
+{
+	alloc_bootmem_cpumask_var(&cpu_initialized_mask);
+	alloc_bootmem_cpumask_var(&cpu_callin_mask);
+	alloc_bootmem_cpumask_var(&cpu_callout_mask);
+	alloc_bootmem_cpumask_var(&cpu_sibling_setup_mask);
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 
 /* Recompute SMT state for all CPUs on offline */
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index a9cf8c8..a6f9128 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -254,15 +254,12 @@ cpu_initialize_context(unsigned int cpu, struct task_struct *idle)
 	struct desc_struct *gdt;
 	unsigned long gdt_mfn;
 
-	/* used to tell cpu_init() that it can proceed with initialization */
-	cpumask_set_cpu(cpu, cpu_callout_mask);
 	if (cpumask_test_and_set_cpu(cpu, xen_cpu_initialized_map))
 		return 0;
 
 	ctxt = kzalloc(sizeof(*ctxt), GFP_KERNEL);
 	if (ctxt == NULL) {
 		cpumask_clear_cpu(cpu, xen_cpu_initialized_map);
-		cpumask_clear_cpu(cpu, cpu_callout_mask);
 		return -ENOMEM;
 	}
 
