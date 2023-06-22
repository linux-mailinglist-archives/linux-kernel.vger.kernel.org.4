Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D4873ACE9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjFVXHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjFVXH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:07:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F42135
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 16:07:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687475245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gvYbXwq2eSAZRz3hMFUqvNYl8+fG5F3sO59deliWYI0=;
        b=2sJUWJyocUarp+h83+VJcOl63TkpanwxdYEGl/8lSrlBpDzzCTx7exhEN8L3OcQ0fEvJYJ
        EfN8TkSWyfmDJ7DoyTuL2eXuq3HL+QJyyD4oAKaWhQuJlj1av5l7SwMUIeTW6aJmQ+qzaG
        XCeJDXiHy52+Ytuc/pOnvrnWGo2wucdriFZBcVfChKyf+v5zjzvcYrXNdH0HBSoWyRIohs
        18YS84ZLUIud1ue9bKP7XVfqxNuLWx4O1pdqH89MiemZxODmSIr7KMNj7n6/oHSRByjqEa
        pX0bTkgF26NBdM8PSFMTPxk4g3b78PqYFlqqo3IA3mGf3+TRA7zhpfnOQyyv2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687475245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gvYbXwq2eSAZRz3hMFUqvNYl8+fG5F3sO59deliWYI0=;
        b=ZQjvlkM0XNNM0OJhmGLAgWzrVc5BXrcT5iDrkNn/rU+1eKhNflA5lHvUFlrLzxqEMOafEz
        EWb/fXO8Xboi9ICA==
To:     Feng Tang <feng.tang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Paul E . McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        tim.c.chen@intel.com
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
In-Reply-To: <87h6qz7et0.ffs@tglx>
References: <20230613052523.1106821-1-feng.tang@intel.com>
 <20230613052523.1106821-2-feng.tang@intel.com>
 <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
 <ZIwMstkB7CG3pDYu@feng-clx> <87h6qz7et0.ffs@tglx>
Date:   Fri, 23 Jun 2023 01:07:24 +0200
Message-ID: <87edm36qqb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22 2023 at 16:27, Thomas Gleixner wrote:
> On Fri, Jun 16 2023 at 15:18, Feng Tang wrote:
> So something like the below should just work.

Well it works in principle, but does not take any of the command line
parameters which limit nr_possible CPUs or the actual kernel
configuration into account. But the principle itself works correctly.

Below is an updated version, which takes them into account.

The data here is from a two socket system with 32 CPUs per socket.

No command line parameters (NR_CPUS=64):

 smpboot: Allowing 64 CPUs, 32 hotplug CPUs
 clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1e3306b9ada, max_idle_ns: 440795224413 ns
 smp: Brought up 1 node, 32 CPUs
 smpboot: Max logical packages ACPI enumeration: 2

"possible_cpus=32" (NR_CPUS=64) or
No command line parameter (NR_CPUS=32):

 smpboot: Allowing 32 CPUs, 0 hotplug CPUs
 clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1e3306b9ada, max_idle_ns: 440795224413 ns
 smp: Brought up 1 node, 32 CPUs
 smpboot: Max logical packages ACPI enumeration: 1

maxcpus=32
 smpboot: Allowing 64 CPUs, 0 hotplug CPUs
 clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1e3306b9ada, max_idle_ns: 440795224413 ns
 smp: Brought up 1 node, 32 CPUs
 smpboot: Max logical packages ACPI enumeration: 2

But that's really all we should do. If the ACPI table enumerates CPUs as
hotpluggable which can never arrive, then so be it.

We have enough parameters to override the BIOS nonsense. Trying to do
more magic MAD table parsing with heuristics is just wrong.

We already have way too many heuristics and workarounds for broken
firmware, but for the problem at hand, we really don't need more.

The only systems I observed so far which have a non-sensical amount of
"hotpluggable" CPUs are high-end server machines. It's a resonable
expectation that machines with high-end price tags come with correct
firmware. Trying to work around that (except with the existing command
line options) is just proliferating this mess. This has to stop.

Thanks,

        tglx
---

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -509,9 +509,12 @@ extern int default_check_phys_apicid_pre
 #ifdef CONFIG_SMP
 bool apic_id_is_primary_thread(unsigned int id);
 void apic_smt_update(void);
+extern unsigned int apic_to_pkg_shift;
+void logical_packages_update(u32 apicid, bool enabled);
 #else
 static inline bool apic_id_is_primary_thread(unsigned int id) { return false; }
 static inline void apic_smt_update(void) { }
+static inline void logical_packages_update(u32 apicid, bool enabled) { }
 #endif
 
 struct msi_msg;
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -178,6 +178,7 @@ static int acpi_register_lapic(int id, u
 	}
 
 	if (!enabled) {
+		logical_packages_update(acpiid, false);
 		++disabled_cpus;
 		return -EINVAL;
 	}
@@ -189,6 +190,8 @@ static int acpi_register_lapic(int id, u
 	if (cpu >= 0)
 		early_per_cpu(x86_cpu_to_acpiid, cpu) = acpiid;
 
+	logical_packages_update(acpiid, cpu >= 0);
+
 	return cpu;
 }
 
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -692,6 +692,8 @@ static void early_init_amd(struct cpuinf
 		}
 	}
 
+	detect_extended_topology_early(c);
+
 	if (cpu_has(c, X86_FEATURE_TOPOEXT))
 		smp_num_siblings = ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
 }
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -29,6 +29,8 @@ unsigned int __max_die_per_package __rea
 EXPORT_SYMBOL(__max_die_per_package);
 
 #ifdef CONFIG_SMP
+unsigned int apic_to_pkg_shift __ro_after_init;
+
 /*
  * Check if given CPUID extended topology "leaf" is implemented
  */
@@ -66,7 +68,7 @@ int detect_extended_topology_early(struc
 {
 #ifdef CONFIG_SMP
 	unsigned int eax, ebx, ecx, edx;
-	int leaf;
+	int leaf, subleaf;
 
 	leaf = detect_extended_topology_leaf(c);
 	if (leaf < 0)
@@ -80,6 +82,14 @@ int detect_extended_topology_early(struc
 	 */
 	c->initial_apicid = edx;
 	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
+
+	for (subleaf = 1; subleaf < 8; subleaf++) {
+		cpuid_count(leaf, subleaf, &eax, &ebx, &ecx, &edx);
+
+		if (ebx == 0 || !LEAFB_SUBTYPE(ecx))
+			break;
+		apic_to_pkg_shift = BITS_SHIFT_NEXT_LEVEL(eax);
+	}
 #endif
 	return 0;
 }
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1501,17 +1501,91 @@ void __init native_smp_prepare_boot_cpu(
 	native_pv_lock_init();
 }
 
+struct logical_pkg {
+	unsigned int	enabled_cpus;
+	unsigned int	disabled_cpus;
+};
+
+/*
+ * Needs to be size of NR_CPUS because virt allows to create the weirdest
+ * topologies just because it can.
+ */
+static struct logical_pkg logical_pkgs[NR_CPUS] __refdata;
+
+void logical_packages_update(u32 apicid, bool enabled)
+{
+	struct logical_pkg *lp;
+	unsigned int pkg;
+
+	if (!apic_to_pkg_shift || system_state != SYSTEM_BOOTING)
+		return;
+
+	pkg = (apicid >> apic_to_pkg_shift);
+
+	lp = logical_pkgs + pkg;
+	if (enabled)
+		lp->enabled_cpus++;
+	else
+		lp->disabled_cpus++;
+
+	if (++pkg > __max_logical_packages)
+		__max_logical_packages = pkg;
+}
+
+static void __init logical_packages_finish_setup(unsigned int possible)
+{
+	unsigned int pkg, maxpkg = 0, maxcpus = 0;
+
+	if (!apic_to_pkg_shift)
+		return;
+
+	/* Scan the enabled CPUs first */
+	for (pkg = 0; pkg < __max_logical_packages; pkg++) {
+		if (!logical_pkgs[pkg].enabled_cpus)
+			continue;
+
+		maxpkg++;
+		maxcpus += logical_pkgs[pkg].enabled_cpus;
+
+		if (maxcpus >= possible) {
+			__max_logical_packages = maxpkg;
+			return;
+		}
+	}
+
+	/* There is still room, scan for disabled CPUs */
+	for (pkg = 0; pkg < __max_logical_packages; pkg++) {
+		if (logical_pkgs[pkg].enabled_cpus || !logical_pkgs[pkg].disabled_cpus)
+			continue;
+
+		maxpkg++;
+		maxcpus += logical_pkgs[pkg].disabled_cpus;
+
+		if (maxcpus >= possible)
+			break;
+	}
+
+	__max_logical_packages = maxpkg;
+}
+
 void __init calculate_max_logical_packages(void)
 {
 	int ncpus;
 
+	if (__max_logical_packages) {
+		pr_info("Max logical packages ACPI enumeration: %u\n",
+		       __max_logical_packages);
+		return;
+	}
+
 	/*
 	 * Today neither Intel nor AMD support heterogeneous systems so
 	 * extrapolate the boot cpu's data to all packages.
 	 */
 	ncpus = cpu_data(0).booted_cores * topology_max_smt_threads();
 	__max_logical_packages = DIV_ROUND_UP(total_cpus, ncpus);
-	pr_info("Max logical packages: %u\n", __max_logical_packages);
+
+	pr_info("Max logical packages estimated: %u\n", __max_logical_packages);
 }
 
 void __init native_smp_cpus_done(unsigned int max_cpus)
@@ -1619,6 +1693,8 @@ early_param("possible_cpus", _setup_poss
 
 	for (i = 0; i < possible; i++)
 		set_cpu_possible(i, true);
+
+	logical_packages_finish_setup(possible);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU



