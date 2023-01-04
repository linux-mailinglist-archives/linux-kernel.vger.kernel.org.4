Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7281A65CE32
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjADIWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjADIWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:22:19 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B435817897
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672820538; x=1704356538;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+zi8fBUANz9NNvILWGD9gHQF++g2SGZ8I1IaZ33DaSU=;
  b=kGCQtjQ98B5zlx/M8Cgk9XINcF7i3bp3CsAsLHeyhU8qNOiY9PY+MOTC
   z1Nypdo8vm9VMnFvcAGOwq+Vq0Xf4v3RZ7JZd1fKBcBkIoizpBVTM4pzM
   XJqqnuFp9Aac80ha8gKnRoi3skIf4ibkMqfe9qVBEYAXJ0m93atq2qBuc
   uixFaj4ukMQ1xXsu+CBhzgk/FAKAbuwRhqLuTXvc6yLt8hH9JcXXOiRyH
   ugVIJXovvD8z/8Hey4DbsUFy0jUa7VbOEGpDnhMxrSiZaGsOYdmHTCp/3
   0h+vDVivNfb8dHCfAscUUNIYsw1e9jJJ8phL1n0sCZvNpyFGfPV9VHmk1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="384167254"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="384167254"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 00:22:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="605118154"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="605118154"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by orsmga003.jf.intel.com with ESMTP; 04 Jan 2023 00:22:14 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, paulmck@kernel.org,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, len.brown@intel.com, tim.c.chen@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v5] x86/tsc: Add option to force frequency recalibration with HW timer
Date:   Wed,  4 Jan 2023 16:19:38 +0800
Message-Id: <20230104081938.1014511-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel assumes that the TSC frequency which is provided by the
hardware / firmware via MSRs or CPUID(0x15) is correct after applying
a few basic consistency checks. This disables the TSC recalibration
against HPET or PM timer.

As a result there is no mechanism to validate that frequency in cases
where a firmware or hardware defect is suspected. And there was case
that some user used atomic clock to measure the TSC frequency and
reported an inaccuracy issue, which was later fixed in firmware.

Add an option 'recalibrate' for 'tsc' kernel parameter to force the
tsc freq recalibration with HPET or PM timer, and warn if the
deviation from previous value is more than about 500 PPM, which
provides a way to verify the data from hardware / firmware.

There is no functional change to existing work flow.

Recently there was a real-world case: "The 40ms/s divergence between
TSC and HPET was observed on hardware that is quite recent" [1], on
that platform the TSC frequence 1896 MHz was got from CPUID(0x15),
and the force-reclibration with HPET/PMTIMER both calibrated out
value of 1975 MHz, which also matched with check from software
'chronyd', indicating it's a problem of BIOS or firmware.

[Thanks tglx for helping improving the commit log]

[1]. https://lore.kernel.org/lkml/20221117230910.GI4001@paulmck-ThinkPad-P17-Gen-1/
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Changelog:

  since v4:
    * add the real world case, where the patch helped to root
      caused a BIOS/FW problem of inaccurate CPUID-0x15 info
    * rebase against v6.2-rc1

  since v3:
    * add some real world case into commit log
    * rebase against v6.0-rc1

  since v2:
    * revise the option description in kernel-parameters.txt
    * rebase against v5.19-rc2

  since v1:
    * refine commit log to state clearly the problem and intention
      of the patch by copying Thomas' words.

.../admin-guide/kernel-parameters.txt         |  4 +++
 arch/x86/kernel/tsc.c                         | 34 ++++++++++++++++---
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..d9eb98e748d5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6369,6 +6369,10 @@
 			in situations with strict latency requirements (where
 			interruptions from clocksource watchdog are not
 			acceptable).
+			[x86] recalibrate: force to do frequency recalibration
+			with a HW timer (HPET or PM timer) for systems whose
+			TSC frequency comes from HW or FW through MSR or CPUID(0x15),
+			and warn if the difference is more than 500 ppm.
 
 	tsc_early_khz=  [X86] Skip early TSC calibration and use the given
 			value instead. Useful when the early TSC frequency discovery
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a78e73da4a74..92bbc4a6b3fc 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -48,6 +48,8 @@ static DEFINE_STATIC_KEY_FALSE(__use_tsc);
 
 int tsc_clocksource_reliable;
 
+static int __read_mostly tsc_force_recalibrate;
+
 static u32 art_to_tsc_numerator;
 static u32 art_to_tsc_denominator;
 static u64 art_to_tsc_offset;
@@ -303,6 +305,8 @@ static int __init tsc_setup(char *str)
 		mark_tsc_unstable("boot parameter");
 	if (!strcmp(str, "nowatchdog"))
 		no_tsc_watchdog = 1;
+	if (!strcmp(str, "recalibrate"))
+		tsc_force_recalibrate = 1;
 	return 1;
 }
 
@@ -1374,6 +1378,25 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	else
 		freq = calc_pmtimer_ref(delta, ref_start, ref_stop);
 
+	/* Will hit this only if tsc_force_recalibrate has been set */
+	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
+
+		/* Warn if the deviation exceeds 500 ppm */
+		if (abs(tsc_khz - freq) > (tsc_khz >> 11)) {
+			pr_warn("Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!\n");
+			pr_info("Previous calibrated TSC freq:\t %lu.%03lu MHz\n",
+				(unsigned long)tsc_khz / 1000,
+				(unsigned long)tsc_khz % 1000);
+		}
+
+		pr_info("TSC freq recalibrated by [%s]:\t %lu.%03lu MHz\n",
+			hpet ? "HPET" : "PM_TIMER",
+			(unsigned long)freq / 1000,
+			(unsigned long)freq % 1000);
+
+		return;
+	}
+
 	/* Make sure we're within 1% */
 	if (abs(tsc_khz - freq) > tsc_khz/100)
 		goto out;
@@ -1407,8 +1430,10 @@ static int __init init_tsc_clocksource(void)
 	if (!boot_cpu_has(X86_FEATURE_TSC) || !tsc_khz)
 		return 0;
 
-	if (tsc_unstable)
-		goto unreg;
+	if (tsc_unstable) {
+		clocksource_unregister(&clocksource_tsc_early);
+		return 0;
+	}
 
 	if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC_S3))
 		clocksource_tsc.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
@@ -1421,9 +1446,10 @@ static int __init init_tsc_clocksource(void)
 		if (boot_cpu_has(X86_FEATURE_ART))
 			art_related_clocksource = &clocksource_tsc;
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
-unreg:
 		clocksource_unregister(&clocksource_tsc_early);
-		return 0;
+
+		if (!tsc_force_recalibrate)
+			return 0;
 	}
 
 	schedule_delayed_work(&tsc_irqwork, 0);
-- 
2.34.1

