Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9375B99E1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiIOLmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiIOLkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61C84CA03
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=JK3KySIepD4b8zwV/e/6YQKawXqTa+1F0zsnN9YcJks=; b=vXi/Mo2VxHTrSlmRsq2LmeOva0
        Q+qAnR2Tk6/zL8Pt3gjHC62qxla8foKoRcynauyZm9y1FNfblrUe+Wfq71BBMULpDXGPLN++4uWt4
        EIXTBSBPcZTKP5797SSe/5MTBrkUXdXr4k5LqIUGfaocA6TBl9Pi4ngiQ36PQK8LDIth49XaqXX9Y
        dhifoded7qbidICQQg2nGlxK+/R6Hk2e3jAaARXx56A9T03aYo3u5xCfwQSaLr4/SoGD0in8mW0CV
        TpPs/aQo7TtgSIhgGdpB9LyxKtzD/9D13oxJ6uORnPoTfSZzG+tPk299DD97wVbrHkx5+SQhhlXgv
        tvRQ16jg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDa-0012Mm-I6; Thu, 15 Sep 2022 11:39:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F366D30067B;
        Thu, 15 Sep 2022 13:39:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DAF8B29AADBE5; Thu, 15 Sep 2022 13:39:38 +0200 (CEST)
Message-ID: <20220915111143.198076128@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:10:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 03/59] x86/cpu: Get rid of redundant switch_to_new_gdt() invocations
References: <20220915111039.092790446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The only place where switch_to_new_gdt() is required is early boot to
switch from the early GDT to the direct GDT. Any other invocation is
completely redundant because it does not change anything.

Secondary CPUs come out of the ASM code with GDT and GSBASE correctly set
up. The same is true for XEN_PV.

Remove all the voodoo invocations which are left overs from the ancient
past, rename the function to switch_gdt_and_percpu_base() and mark it init.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/processor.h |    2 +-
 arch/x86/kernel/cpu/common.c     |   17 ++++++-----------
 arch/x86/kernel/setup_percpu.c   |    2 +-
 arch/x86/kernel/smpboot.c        |    6 +++++-
 arch/x86/xen/enlighten_pv.c      |    2 +-
 5 files changed, 14 insertions(+), 15 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -670,7 +670,7 @@ extern int sysenter_setup(void);
 /* Defined in head.S */
 extern struct desc_ptr		early_gdt_descr;
 
-extern void switch_to_new_gdt(int);
+extern void switch_gdt_and_percpu_base(int);
 extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
 extern void cpu_init(void);
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
 
@@ -2251,12 +2252,6 @@ void cpu_init(void)
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
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1167,7 +1167,7 @@ static void __init xen_setup_gdt(int cpu
 	pv_ops.cpu.write_gdt_entry = xen_write_gdt_entry_boot;
 	pv_ops.cpu.load_gdt = xen_load_gdt_boot;
 
-	switch_to_new_gdt(cpu);
+	switch_gdt_and_percpu_base(cpu);
 
 	pv_ops.cpu.write_gdt_entry = xen_write_gdt_entry;
 	pv_ops.cpu.load_gdt = xen_load_gdt;


