Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C538460103A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJQN3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJQN3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:29:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D1A1A3BB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666013389; x=1697549389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EEHjGPSGt+4bmtkff7+Q3rjKMcvh7S09g7DA8Sh/8KE=;
  b=fM6PivgX7XKDe1Tq9u9xM4qstFw8DPMkxJQ+7B5HTnH1ZgU82LJq1xKV
   EknanaLf6oORQZzb0sYgm97czSd0N6HyA+cs1lk8sNpntnBBCLWUMBnIL
   MaCaNRfDnEfSQYuOVfhe3ne0r5Fe5icHVLFcKN5Bys67A9RQCVc4DvUqW
   dsKoRnAJo/vEo6chO1SnHo6sK2lIAyH6wUJ4Rw02kyYXmxu3TB+yDyL/A
   dujKsJ2XieMqCtXwO06tJ8JiU3GmJmCTr/hxw4lCPXinitAfbUQEEVU+z
   vBSDHQ4+tNQWLwyXEhBEOws6WdwdCW9SyDiJjQfxwB+DiDtvrvm2q5blx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="285521025"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="285521025"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 06:29:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="691357639"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="691357639"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga008.fm.intel.com with ESMTP; 17 Oct 2022 06:29:45 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, tim.c.chen@intel.com, liaoyu15@huawei.com,
        Feng Tang <feng.tang@intel.com>
Subject: [RFC PATCH] x86/tsc: use topology_max_packages() in tsc watchdog check
Date:   Mon, 17 Oct 2022 21:29:42 +0800
Message-Id: <20221017132942.1646934-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Peter Zijlstra suggested to use logical package ids, but it is
only usable after smp_init() and all CPUs are initialized.

One solution is to skip the watchdog for 'tsc-early' clocksource,
and move the check after smp_init(), while before 'tsc'
clocksoure is registered, where topology_max_packages() could
be used as a much more accurate socket number.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/x86/kernel/tsc.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index cafacb2e58cc..8dc7a0aeaf4d 100644
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
+	    topology_max_packages() <= 2)
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

