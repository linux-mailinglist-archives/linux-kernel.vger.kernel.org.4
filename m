Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED08F70105B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 23:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbjELVIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 17:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239854AbjELVHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 17:07:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC057EF1;
        Fri, 12 May 2023 14:07:18 -0700 (PDT)
Message-ID: <20230512205256.091511483@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683925636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JaqZxTMPaJm1imrOji7tK0gvC/N5/O2xb6G86Du4TqQ=;
        b=cDejufDlaxyCx5CGX4hiOWO/B+3Z4Wh19xsvilcT9IPO7FIYNiPHNJX+pqRc5X+N/dDVs5
        tKDZ+XQ4GQv9J6hR2SPc85jI+MqPX6q6xxXuGbFXUxAJjXbPQHMFewGqbQuhrfB7sY2u2u
        nkHDr5FQjj8WBPk6AwjKUsu+7FyPK4nSUfby3R43DpF7wYT+TQ8zFWGIr2lnlOG6YYmjM4
        uygdhGu263NI6nr6HYNtETYJgziVDxphZhDBdka0UYVVHe8n5+ats7GS5MAlTVrF+827ll
        IFxU3itG8+fVOGZr/SA1ZuDUQI+EuEEA8a+PjeX7nu7Hjbhz0RXLqD2NveT9KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683925636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JaqZxTMPaJm1imrOji7tK0gvC/N5/O2xb6G86Du4TqQ=;
        b=sOj3zUEdJE/NxvevxKX5WPFqqf/zY9uCI4lEroCJWyOhcwEBsNa+MdD4dK9wBn2igUgSdu
        8HJ4zRRiu3a17ODw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Ross Philipson <ross.philipson@oracle.com>
Subject: [patch V4 12/37] x86/smpboot: Move synchronization masks to SMP boot code
References: <20230512203426.452963764@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 12 May 2023 23:07:16 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The usage is in smpboot.c and not in the CPU initialization code.

The XEN_PV usage of cpu_callout_mask is obsolete as cpu_init() not longer
waits and cacheinfo has its own CPU mask now, so cpu_callout_mask can be
made static too.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/cpumask.h |    5 -----
 arch/x86/kernel/cpu/common.c   |   17 -----------------
 arch/x86/kernel/smpboot.c      |   16 ++++++++++++++++
 arch/x86/xen/smp_pv.c          |    3 ---
 4 files changed, 16 insertions(+), 25 deletions(-)
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
@@ -169,15 +161,6 @@ static void ppin_init(struct cpuinfo_x86
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
@@ -1548,6 +1555,15 @@ early_param("possible_cpus", _setup_poss
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
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -254,15 +254,12 @@ cpu_initialize_context(unsigned int cpu,
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
 

