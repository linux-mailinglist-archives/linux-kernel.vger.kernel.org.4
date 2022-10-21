Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE491606FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJUGVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJUGVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:21:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B48228CCB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666333296; x=1697869296;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=82XaA9wBL8ylCEUuqFFOH7RcjY72krt4WxJEMtkW/4Y=;
  b=WvSzdrC8xvI4iMWxfrFfRIBNEde0zcneuZ4cROE67wX5IV2mgi4D6vGB
   A6GWRZLGSlQseUT1CAe8jz15arNCqiZTuHXP/x3T5sWpQsiqRT3Kc7P1R
   n5CBmo4izkE+YCS9TkxwdcR4p82bDo9AzulDw73/UfrNWiP21drrDStNR
   F1h3Pvr2ivlpGdBuwrDJ38ttnbsxqTyx+ANhT5A13neXnNX61oYwZacu2
   whyRs6TNpXyZ7M2hEDHh/Z11ex5mFSVjQvHDaLoE0Bg5LMdSAH6hKXj+/
   fzz1NTz0TJz1i3aXKbDIWiA7a3zJKIzD2fn121XTS2Cr+RM8juzu/atfj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="287324640"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="287324640"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 23:21:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="755625351"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="755625351"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by orsmga004.jf.intel.com with ESMTP; 20 Oct 2022 23:21:33 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, tim.c.chen@intel.com,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        liaoyu15@huawei.com, Feng Tang <feng.tang@intel.com>
Subject: [PATCH v1 1/2] x86/tsc: use logical_package as a better estimation of socket numbers
Date:   Fri, 21 Oct 2022 14:21:30 +0800
Message-Id: <20221021062131.1826810-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
on qualified platorms") was introduced to solve problem that
sometimes TSC clocksource is wrongly judged as unstable by watchdog
like 'jiffies', HPET, etc.

In it, the hardware socket number is a key factor for judging
whether to disable the watchdog for TSC, and 'nr_online_nodes' was
chosen as an estimation due to it is needed in early boot phase
before registering 'tsc-early' clocksource, where all none-boot
CPUs are not brought up yet.

In recent patch review, Dave Hansen pointed out there are many
cases that 'nr_online_nodes' could have issue, like:
* numa emulation (numa=fake=4 etc.)
* numa=off
* platforms with CPU+DRAM nodes, CPU-less HBM nodes, CPU-less
  persistent memory nodes.
* SNC (sub-numa cluster) mode is enabled

Peter Zijlstra suggested to use logical package ids, but it is
only usable after smp_init() and all CPUs are initialized.

One solution is to skip the watchdog for 'tsc-early' clocksource,
and move the check after smp_init(), while before 'tsc'
clocksoure is registered, where 'logical_packages' could be used
as a much more accurate socket number.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Hi reviewers,

I separate the code to 2 patches, as I think they are covering 2
problems and easy for bisect. Feel free to combine them into one,
as the 2/2 are a trivial change.

Thanks,
Feng

Changelog:
 
 Since RFC:
 * use 'logical_packages' instead of topology_max_packages(), whose
   implementaion is not accurate, like for heterogeneous systems
   which have combination of Core/Atom CPUs like Alderlake (Dave Hansen)

 arch/x86/include/asm/topology.h |  4 ++++
 arch/x86/kernel/smpboot.c       |  2 +-
 arch/x86/kernel/tsc.c           | 42 +++++++++++++--------------------
 3 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 458c891a8273..f9002549770c 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -122,8 +122,11 @@ extern unsigned int __max_die_per_package;
 #define topology_sibling_cpumask(cpu)		(per_cpu(cpu_sibling_map, cpu))
 
 extern unsigned int __max_logical_packages;
+extern unsigned int logical_packages;
 #define topology_max_packages()			(__max_logical_packages)
 
+extern unsigned int logical_packages;
+
 static inline int topology_max_die_per_package(void)
 {
 	return __max_die_per_package;
@@ -144,6 +147,7 @@ bool topology_is_primary_thread(unsigned int cpu);
 bool topology_smt_supported(void);
 #else
 #define topology_max_packages()			(1)
+#define logical_packages 			(1)
 static inline int
 topology_update_package_map(unsigned int apicid, unsigned int cpu) { return 0; }
 static inline int
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3f3ea0287f69..d81156beb7e7 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -102,7 +102,7 @@ EXPORT_PER_CPU_SYMBOL(cpu_info);
 /* Logical package management. We might want to allocate that dynamically */
 unsigned int __max_logical_packages __read_mostly;
 EXPORT_SYMBOL(__max_logical_packages);
-static unsigned int logical_packages __read_mostly;
+unsigned int logical_packages __read_mostly;
 static unsigned int logical_die __read_mostly;
 
 /* Maximum number of SMT threads on any online core */
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index cafacb2e58cc..178448ef00c7 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1131,8 +1131,7 @@ static struct clocksource clocksource_tsc_early = {
 	.uncertainty_margin	= 32 * NSEC_PER_MSEC,
 	.read			= read_tsc,
 	.mask			= CLOCKSOURCE_MASK(64),
-	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
-				  CLOCK_SOURCE_MUST_VERIFY,
+	.flags			= CLOCK_SOURCE_IS_CONTINUOUS,
 	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
 	.enable			= tsc_cs_enable,
 	.resume			= tsc_resume,
@@ -1180,12 +1179,6 @@ void mark_tsc_unstable(char *reason)
 
 EXPORT_SYMBOL_GPL(mark_tsc_unstable);
 
-static void __init tsc_disable_clocksource_watchdog(void)
-{
-	clocksource_tsc_early.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
-	clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
-}
-
 static void __init check_system_tsc_reliable(void)
 {
 #if defined(CONFIG_MGEODEGX1) || defined(CONFIG_MGEODE_LX) || defined(CONFIG_X86_GENERIC)
@@ -1202,23 +1195,6 @@ static void __init check_system_tsc_reliable(void)
 #endif
 	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE))
 		tsc_clocksource_reliable = 1;
-
-	/*
-	 * Disable the clocksource watchdog when the system has:
-	 *  - TSC running at constant frequency
-	 *  - TSC which does not stop in C-States
-	 *  - the TSC_ADJUST register which allows to detect even minimal
-	 *    modifications
-	 *  - not more than two sockets. As the number of sockets cannot be
-	 *    evaluated at the early boot stage where this has to be
-	 *    invoked, check the number of online memory nodes as a
-	 *    fallback solution which is an reasonable estimate.
-	 */
-	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
-	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
-	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
-	    nr_online_nodes <= 2)
-		tsc_disable_clocksource_watchdog();
 }
 
 /*
@@ -1413,6 +1389,20 @@ static int __init init_tsc_clocksource(void)
 	if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC_S3))
 		clocksource_tsc.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
 
+	/*
+	 * Disable the clocksource watchdog when the system has:
+	 *  - TSC running at constant frequency
+	 *  - TSC which does not stop in C-States
+	 *  - the TSC_ADJUST register which allows to detect even minimal
+	 *    modifications
+	 *  - not more than two sockets.
+	 */
+	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
+	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
+	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
+	    logical_packages <= 2)
+		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
+
 	/*
 	 * When TSC frequency is known (retrieved via MSR or CPUID), we skip
 	 * the refined calibration and directly register it as a clocksource.
@@ -1547,7 +1537,7 @@ void __init tsc_init(void)
 	}
 
 	if (tsc_clocksource_reliable || no_tsc_watchdog)
-		tsc_disable_clocksource_watchdog();
+		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
 
 	clocksource_register_khz(&clocksource_tsc_early, tsc_khz);
 	detect_art();
-- 
2.34.1

