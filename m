Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A8D73A2F8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjFVO13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFVO11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:27:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B91919B7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:27:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687444044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FXNabFu3R+CbSGJ3eO4pu2dnBfEqHysqMWZ3iEe7Y0Q=;
        b=Q709QPTQzQFuc/s1h83xeJ+U2hg4ZjFW0TzYMIZWZ4t+NvNDqdwmfiluHuy97ZOyoFmloE
        0Eu63qHBkAKwQHtGlKs1mMMEqSpnwBhmULzITMXod6Nat2eTg1bC9DaZRU8eRYUnquDFaN
        u2BvF0exfdBFQaonxker0buFCYKPtEGhsXkCjK30PON11Wu84dqh49uYjrpmHpX2I6UBqk
        4XEvEMvyQoJu065VgwNdLfmNeXtyNWj9SbV8p4sUynCFPJOKujeVpz255uHrf0EGW+nfgD
        YgUZzFoihyoqSLhskz0waOASK3G6spHrpzk+lxNd5dzE2BkQI8Y/m+AqcgUIAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687444044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FXNabFu3R+CbSGJ3eO4pu2dnBfEqHysqMWZ3iEe7Y0Q=;
        b=nFRGSvijeky8vzMenKyb5Cz8B4Ih/YoXcicZ1GDA3etHLquMupGs7aus2yCTKMLf1MOAaV
        cSQpU451LOV4C5Bg==
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
In-Reply-To: <ZIwMstkB7CG3pDYu@feng-clx>
References: <20230613052523.1106821-1-feng.tang@intel.com>
 <20230613052523.1106821-2-feng.tang@intel.com>
 <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
 <ZIwMstkB7CG3pDYu@feng-clx>
Date:   Thu, 22 Jun 2023 16:27:23 +0200
Message-ID: <87h6qz7et0.ffs@tglx>
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

On Fri, Jun 16 2023 at 15:18, Feng Tang wrote:
> On Thu, Jun 15, 2023 at 11:20:21AM +0200, Peter Zijlstra wrote:
> Yes. Rui is working on a MADT based parsing which may take a while
> before being stable, given all kinds of fancy firmware out there.

Please not yet another mad table parser.

The topology can be evaluated during early boot via:

  1) The APIC IDs of the possible CPUs.

  2) CPUID leaf 0xb or 0x1f where the topmost subleaf gives the number
     of bits to shift the APIC ID right for the package/socket

Trying to accomodate for anything else than the documented enumeration
is crazy. If fancy firmware is broken then they can keep the pieces.

So something like the below should just work.

I fundamentally hate the hackery in topology.c, but cleaning this mess
up is a completely different problem and already worked on.

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
+bool logical_packages_update(u32 apicid);
 #else
 static inline bool apic_id_is_primary_thread(unsigned int id) { return false; }
 static inline void apic_smt_update(void) { }
+static inline bool logical_packages_update(u32 apicid) { return true; }
 #endif
 
 struct msi_msg;
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -177,6 +177,9 @@ static int acpi_register_lapic(int id, u
 		return -EINVAL;
 	}
 
+	if (!logical_packages_update(acpiid))
+		return -EINVAL;
+
 	if (!enabled) {
 		++disabled_cpus;
 		return -EINVAL;
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
@@ -1501,17 +1501,50 @@ void __init native_smp_prepare_boot_cpu(
 	native_pv_lock_init();
 }
 
+bool logical_packages_update(u32 apicid)
+{
+	unsigned int pkg;
+
+	if (!apic_to_pkg_shift)
+		return true;
+
+	pkg = (apicid >> apic_to_pkg_shift) + 1;
+	if (pkg <= __max_logical_packages)
+		return true;
+
+	if (system_state == SYSTEM_BOOTING) {
+		__max_logical_packages = pkg;
+		return true;
+	}
+
+	pr_err("Physical hotplug APICID %x package %u > max logical packages %u\n",
+	       apicid, pkg, __max_logical_packages);
+	return false;
+}
+
 void __init calculate_max_logical_packages(void)
 {
-	int ncpus;
+	unsigned int ncpus, npkg;
 
 	/*
 	 * Today neither Intel nor AMD support heterogeneous systems so
 	 * extrapolate the boot cpu's data to all packages.
 	 */
 	ncpus = cpu_data(0).booted_cores * topology_max_smt_threads();
-	__max_logical_packages = DIV_ROUND_UP(total_cpus, ncpus);
-	pr_info("Max logical packages: %u\n", __max_logical_packages);
+	npkg = DIV_ROUND_UP(total_cpus, ncpus);
+
+	/* Did logical_packages_update() set up __max_logical_packages? */
+	if (!__max_logical_packages) {
+		__max_logical_packages = npkg;
+	} else {
+		pr_info("Max logical packages ACPI enumeration: %u\n",
+		       __max_logical_packages);
+		if (npkg <= __max_logical_packages)
+			return;
+		__max_logical_packages = npkg;
+	}
+
+	pr_info("Max logical packages estimated: %u\n", __max_logical_packages);
 }
 
 void __init native_smp_cpus_done(unsigned int max_cpus)
