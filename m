Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F9472D95E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 07:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbjFMFgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 01:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240367AbjFMFgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:36:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B0030E6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 22:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686634375; x=1718170375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R9c4pKHRdrSlCBk6dSsMemyO2HEpJapH/lMhjwhIo64=;
  b=hP6pd6av2anjU2lJLW4BioD0CHhfJCXjKHccw6ylCpJ0Cl9qCYD/gUra
   R0VH6FHtQajGCN7cRfvEbzSybZQOY5pPYAfUtouewnH44AW1FWqsaz1w1
   9Dd1WLYvo+2Ena0FDNLSqtH+ATeQVsUibNulzxmRSYfP34qD1uV4In3t2
   nxb3ooCCeulD6kVl3yTBVlJWTVb5/igFVPDm20kEKv6VNUqNI/YGaBc0d
   LZR0P84C/9V5ZapsiK+kKxCvFqCLdXy9MXTvumvR3M0GQGrT3MuYPcj+T
   Y9g/LsFCHliWvPHCZglOAJbxUdZv2e86gQisC3zET+QFFVg8zooNGFvp7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="357117806"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="357117806"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 22:32:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="776671625"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="776671625"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2023 22:32:39 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Paul E . McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, tim.c.chen@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: [Patch v2 2/2] x86/tsc: use logical_packages as a better estimation of socket numbers
Date:   Tue, 13 Jun 2023 13:25:23 +0800
Message-Id: <20230613052523.1106821-2-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613052523.1106821-1-feng.tang@intel.com>
References: <20230613052523.1106821-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
on qualified platorms") was introduced to solve problem that
sometimes TSC clocksource is wrongly judged as unstable by watchdog
like 'jiffies', HPET, etc.

In it, the hardware socket number is a key factor for judging whether
to disable the watchdog for TSC, and 'nr_online_nodes' was chosen as
an estimation due to it is needed in early boot phase before
registering 'tsc-early' clocksource, where all none-boot CPUs are not
brought up yet.

In recent patch review, Dave and Rui pointed out there are many cases
in which 'nr_online_nodes' is not accurate, like:

* numa emulation (numa=fake=4 etc.)
* numa=off
* platforms with CPU-less HBM nodes, CPU-less Optane memory nodes.
* SNC (sub-numa cluster) mode enabled
* 'nr_cpus=' and 'maxcpus=' kernel cmdline parameter setup

Peter Zijlstra suggested 'logical_packages', and it seems to be the
best option we have as it covers all the cases above except the
last one. But it is only usable after smp_init() and all CPUs are
brought up, while 'tsc-early' is initialized before that.

One solution is to skip the watchdog for 'tsc-early' clocksource,
and move the check after smp_init(), while before 'tsc' clocksource
is registered, where 'logical_packages' could be used.

For 'nr_cpus' and 'maxcpus' cmdline case, the global flag
'package_count_unreliable' will be set to true and the watchdog
will be kept as is.

Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
Reported-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Changelog:

  since v1:
   * Handle the 'maxcpus=' and 'nr_cpus=' cmdline parameter cases,
     by keeping watchdog as the package number is unreliable (Dave Hansen)

  since RFC:
   * use 'logical_packages' instead of topology_max_packages(), whose
     implementaion is not accurate, like for heterogeneous systems
     which have combination of Core/Atom CPUs like Alderlake (Dave Hansen)

 arch/x86/include/asm/topology.h |  3 +++
 arch/x86/kernel/smpboot.c       |  2 +-
 arch/x86/kernel/tsc.c           | 43 +++++++++++++--------------------
 3 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 458c891a8273..d47b7b39e44d 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -124,6 +124,8 @@ extern unsigned int __max_die_per_package;
 extern unsigned int __max_logical_packages;
 #define topology_max_packages()			(__max_logical_packages)
 
+extern unsigned int logical_packages;
+
 static inline int topology_max_die_per_package(void)
 {
 	return __max_die_per_package;
@@ -144,6 +146,7 @@ bool topology_is_primary_thread(unsigned int cpu);
 bool topology_smt_supported(void);
 #else
 #define topology_max_packages()			(1)
+#define logical_packages	1
 static inline int
 topology_update_package_map(unsigned int apicid, unsigned int cpu) { return 0; }
 static inline int
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index b78770b0c43d..c5ac9eb17cd7 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -104,7 +104,7 @@ EXPORT_PER_CPU_SYMBOL(cpu_info);
 /* Logical package management. We might want to allocate that dynamically */
 unsigned int __max_logical_packages __read_mostly;
 EXPORT_SYMBOL(__max_logical_packages);
-static unsigned int logical_packages __read_mostly;
+unsigned int logical_packages __read_mostly;
 static unsigned int logical_die __read_mostly;
 
 /* Maximum number of SMT threads on any online core */
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 344698852146..fe762f7268a0 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1146,8 +1146,7 @@ static struct clocksource clocksource_tsc_early = {
 	.uncertainty_margin	= 32 * NSEC_PER_MSEC,
 	.read			= read_tsc,
 	.mask			= CLOCKSOURCE_MASK(64),
-	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
-				  CLOCK_SOURCE_MUST_VERIFY,
+	.flags			= CLOCK_SOURCE_IS_CONTINUOUS,
 	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
 	.enable			= tsc_cs_enable,
 	.resume			= tsc_resume,
@@ -1195,12 +1194,6 @@ void mark_tsc_unstable(char *reason)
 
 EXPORT_SYMBOL_GPL(mark_tsc_unstable);
 
-static void __init tsc_disable_clocksource_watchdog(void)
-{
-	clocksource_tsc_early.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
-	clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
-}
-
 bool tsc_clocksource_watchdog_disabled(void)
 {
 	return !(clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY) &&
@@ -1223,23 +1216,6 @@ static void __init check_system_tsc_reliable(void)
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
@@ -1455,6 +1431,21 @@ static int __init init_tsc_clocksource(void)
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
+	    is_package_count_reliable() &&
+	    logical_packages <= 2)
+		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
+
 	/*
 	 * When TSC frequency is known (retrieved via MSR or CPUID), we skip
 	 * the refined calibration and directly register it as a clocksource.
@@ -1590,7 +1581,7 @@ void __init tsc_init(void)
 	}
 
 	if (tsc_clocksource_reliable || no_tsc_watchdog)
-		tsc_disable_clocksource_watchdog();
+		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
 
 	clocksource_register_khz(&clocksource_tsc_early, tsc_khz);
 	detect_art();
-- 
2.34.1

