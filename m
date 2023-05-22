Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F5170B3D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 05:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjEVDhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 23:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEVDhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 23:37:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB7DA2
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 20:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684726621; x=1716262621;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P59aXtyfm/ISccYK7l1gh94sKmTWDcB1nL/Li5f4TEA=;
  b=k5R3ktOXkdkt0+QT6+0OUnnjFlCtu1g5BcSiKlgOnMr8fWofsbXdACSw
   2JM03bymWJiWZ/FDw9y9IKYZmafvavn0fkU7gt+bDOEjE1WfFRCxCXVCA
   QayN3eETImf5BnjwyPN4Nf8EWQEsQazCW2NJ/lgaX2AbeYys3O85MHbps
   Hy4Gw7MAVhHh4NT1axLbn+TSYreprOi10XyxozdEi33VNt8a9TdN7jjpm
   7nkqtTxkMVk2U+yxFIzjRoYzo/zhcPAeS7Gv3g7bew+sByTY6eMe/4Pn2
   LnET4VN1atNRHmo70FimFJx8UWrcm0avaeSHLsmcsMNtg3EJHjyDoCG3q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="350327417"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="350327417"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 20:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="815499748"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="815499748"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga002.fm.intel.com with ESMTP; 21 May 2023 20:36:59 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, paulmck@kernel.org,
        rui.zhang@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH RFC] x86/tsc: Make recalibration default on for TSC_KNOWN_FREQ cases
Date:   Mon, 22 May 2023 11:30:18 +0800
Message-Id: <20230522033018.1276836-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a7ec817d5542 ("x86/tsc: Add option to force frequency
recalibration with HW timer") was added to handle cases that the
firmware has bug and provides a wrong TSC frequency number, and it
is optional given that this kind of firmware issue rarely happens
(Paul reported once [1]).

But Rui reported that some Sapphire Rapids platform met this issue
again recently, and as firmware is also a kind of 'software' which
can't be bug free, make the recalibration default on. When the
values from firmware and HW timer's calibration have big gap,
raise a warning and let vendor to check which side is broken.

One downside is, many VMs also has X86_FEATURE_TSC_KNOWN_FREQ set,
and they will also do this recalibration.

[1]. https://lore.kernel.org/lkml/20221117230910.GI4001@paulmck-ThinkPad-P17-Gen-1/
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ----
 arch/x86/kernel/tsc.c                           | 14 ++++----------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..a826ab3b5dfb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6451,10 +6451,6 @@
 			in situations with strict latency requirements (where
 			interruptions from clocksource watchdog are not
 			acceptable).
-			[x86] recalibrate: force recalibration against a HW timer
-			(HPET or PM timer) on systems whose TSC frequency was
-			obtained from HW or FW using either an MSR or CPUID(0x15).
-			Warn if the difference is more than 500 ppm.
 			[x86] watchdog: Use TSC as the watchdog clocksource with
 			which to check other HW timers (HPET or PM timer), but
 			only on systems where TSC has been deemed trustworthy.
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 344698852146..b77c5b1ad304 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -48,8 +48,6 @@ static DEFINE_STATIC_KEY_FALSE(__use_tsc);
 
 int tsc_clocksource_reliable;
 
-static int __read_mostly tsc_force_recalibrate;
-
 static u32 art_to_tsc_numerator;
 static u32 art_to_tsc_denominator;
 static u64 art_to_tsc_offset;
@@ -310,8 +308,6 @@ static int __init tsc_setup(char *str)
 				 __func__);
 		tsc_as_watchdog = 0;
 	}
-	if (!strcmp(str, "recalibrate"))
-		tsc_force_recalibrate = 1;
 	if (!strcmp(str, "watchdog")) {
 		if (no_tsc_watchdog)
 			pr_alert("%s: tsc=watchdog overridden by earlier tsc=nowatchdog\n",
@@ -1395,7 +1391,6 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	else
 		freq = calc_pmtimer_ref(delta, ref_start, ref_stop);
 
-	/* Will hit this only if tsc_force_recalibrate has been set */
 	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
 
 		/* Warn if the deviation exceeds 500 ppm */
@@ -1456,17 +1451,16 @@ static int __init init_tsc_clocksource(void)
 		clocksource_tsc.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
 
 	/*
-	 * When TSC frequency is known (retrieved via MSR or CPUID), we skip
-	 * the refined calibration and directly register it as a clocksource.
+	 * When TSC frequency is known (retrieved via MSR or CPUID), we
+	 * directly register it as a clocksource. As the firmware could
+	 * be wrong (very unlikely) about the values, the recalibration
+	 * by hardware timer is kept just as a sanity check.
 	 */
 	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
 		if (boot_cpu_has(X86_FEATURE_ART))
 			art_related_clocksource = &clocksource_tsc;
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
 		clocksource_unregister(&clocksource_tsc_early);
-
-		if (!tsc_force_recalibrate)
-			return 0;
 	}
 
 	schedule_delayed_work(&tsc_irqwork, 0);
-- 
2.34.1

