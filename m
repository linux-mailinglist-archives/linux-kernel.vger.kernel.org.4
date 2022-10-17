Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AFC601223
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiJQO7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiJQO5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:57:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7ED6AA2B;
        Mon, 17 Oct 2022 07:55:13 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018471;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vnO2N6nVw1TEhvVMCgRYZZ4/HKJ6EFn4IqxFiyN50cE=;
        b=xFeFk6zqxHebP/dRZoAx57+M4tEXlHx0ypuH6gpess1lW1YgTvs2Q2JsEjb5PAHu9aobq1
        UvfkZZpSS6sc5xyJcPyRttWakaqBPBpHxAlToFVT7RnW5skqWBrVyl3olHr+B8BVUc5mXk
        04vIQnjvswaxtOLxoh5MIuvnidUP1M3FHDT+IC4GuAuYsdJbs9eEzZJVWuzXPpJ8eG63kL
        TKz5dTqKLw8CY4Q9GUKscbWLZdvf+caJJbIy1mzz+vE6fgs4++lc6A5MZ8ipoPkj04D0K6
        8JHj4mGnXyVzZjB5bX0o+TIgxoRWr2WEUaiwCoBiGjlE/EBN77QV8XEq71Pbeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018471;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vnO2N6nVw1TEhvVMCgRYZZ4/HKJ6EFn4IqxFiyN50cE=;
        b=vTQ0d2ENfK4FonSW0v6NVQ1XKERVg6TamNhfBvoX+nqDgNbyITRcwnphKvf7JmFK8HoKHC
        H3KOmePJQwwhDACg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu: Get rid of redundant switch_to_new_gdt() invocations
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111143.198076128@infradead.org>
References: <20220915111143.198076128@infradead.org>
MIME-Version: 1.0
Message-ID: <166601847006.401.13481476393028263195.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     1f19e2d50baf6515991844eaa8a84a0b0037da70
Gitweb:        https://git.kernel.org/tip/1f19e2d50baf6515991844eaa8a84a0b0037da70
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:10:42 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:40:56 +02:00

x86/cpu: Get rid of redundant switch_to_new_gdt() invocations

The only place where switch_to_new_gdt() is required is early boot to
switch from the early GDT to the direct GDT. Any other invocation is
completely redundant because it does not change anything.

Secondary CPUs come out of the ASM code with GDT and GSBASE correctly set
up. The same is true for XEN_PV.

Remove all the voodoo invocations which are left overs from the ancient
past, rename the function to switch_gdt_and_percpu_base() and mark it init.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111143.198076128@infradead.org
---
 arch/x86/include/asm/processor.h |  2 +-
 arch/x86/kernel/cpu/common.c     | 17 ++++++-----------
 arch/x86/kernel/setup_percpu.c   |  2 +-
 arch/x86/kernel/smpboot.c        |  6 +++++-
 arch/x86/xen/enlighten_pv.c      |  2 +-
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index e21ec97..c660700 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -667,7 +667,7 @@ extern int sysenter_setup(void);
 /* Defined in head.S */
 extern struct desc_ptr		early_gdt_descr;
 
-extern void switch_to_new_gdt(int);
+extern void switch_gdt_and_percpu_base(int);
 extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
 extern void cpu_init(void);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c09abee..f51928d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -729,14 +729,15 @@ void load_fixmap_gdt(int cpu)
 EXPORT_SYMBOL_GPL(load_fixmap_gdt);
 
 /**
- * switch_to_new_gdt - Switch form early GDT to the direct one
+ * switch_gdt_and_percpu_base - Switch to direct GDT and runtime per CPU base
  * @cpu:	The CPU number for which this is invoked
  *
- * Invoked during early boot to switch from early GDT and early per CPU
- * (%fs on 32bit, GS_BASE on 64bit) to the direct GDT and the runtime per
- * CPU area.
+ * Invoked during early boot to switch from early GDT and early per CPU to
+ * the direct GDT and the runtime per CPU area. On 32-bit the percpu base
+ * switch is implicit by loading the direct GDT. On 64bit this requires
+ * to update GSBASE.
  */
-void switch_to_new_gdt(int cpu)
+void __init switch_gdt_and_percpu_base(int cpu)
 {
 	load_direct_gdt(cpu);
 
@@ -2263,12 +2264,6 @@ void cpu_init(void)
 	    boot_cpu_has(X86_FEATURE_TSC) || boot_cpu_has(X86_FEATURE_DE))
 		cr4_clear_bits(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
 
-	/*
-	 * Initialize the per-CPU GDT with the boot GDT,
-	 * and set up the GDT descriptor:
-	 */
-	switch_to_new_gdt(cpu);
-
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		loadsegment(fs, 0);
 		memset(cur->thread.tls_array, 0, GDT_ENTRY_TLS_ENTRIES * 8);
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 49325ca..555089a 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -211,7 +211,7 @@ void __init setup_per_cpu_areas(void)
 		 * area.  Reload any changed state for the boot CPU.
 		 */
 		if (!cpu)
-			switch_to_new_gdt(cpu);
+			switch_gdt_and_percpu_base(cpu);
 	}
 
 	/* indicate the early static arrays will soon be gone */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3f3ea02..ce8728d 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1453,7 +1453,11 @@ void arch_thaw_secondary_cpus_end(void)
 void __init native_smp_prepare_boot_cpu(void)
 {
 	int me = smp_processor_id();
-	switch_to_new_gdt(me);
+
+	/* SMP handles this from setup_per_cpu_areas() */
+	if (!IS_ENABLED(CONFIG_SMP))
+		switch_gdt_and_percpu_base(me);
+
 	/* already set me in cpu_online_mask in boot_cpu_init() */
 	cpumask_set_cpu(me, cpu_callout_mask);
 	cpu_set_state_online(me);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index f82857e..9b89207 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1209,7 +1209,7 @@ static void __init xen_setup_gdt(int cpu)
 	pv_ops.cpu.write_gdt_entry = xen_write_gdt_entry_boot;
 	pv_ops.cpu.load_gdt = xen_load_gdt_boot;
 
-	switch_to_new_gdt(cpu);
+	switch_gdt_and_percpu_base(cpu);
 
 	pv_ops.cpu.write_gdt_entry = xen_write_gdt_entry;
 	pv_ops.cpu.load_gdt = xen_load_gdt;
