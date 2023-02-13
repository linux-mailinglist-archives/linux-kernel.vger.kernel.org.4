Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403E0694FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjBMSsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBMSsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:48:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF5B1CAED;
        Mon, 13 Feb 2023 10:48:34 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:48:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676314112;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JI3CaTz9ebX/gfzOd6IiU2Ga82Qcqi5LHVfoHQzLK48=;
        b=vQbCdgF7wyg0FmfXtuQR8NdhgbkpaN3Xn0xj5e9xV9aaqSlllTjCvGuMSqa2DYWZgBWnPo
        7A7Hm1Ba1wXA2fkHdqV1ufxXSBhArUhpO9/EdcRDjYdOVPBh+HPk8Vdx79fyC4KJKGmDKz
        a/DNhIrEITWaY6vjVoTkrW8uB71fECAiZetR5VdI9XRgoFTzCPJqqpsWVkzAJFheSwDtDT
        dDwwdOi0HSzOXyT/wqtq4UjrJF1HC4zxw8kq9eiqdr3WLfLz9J0mxlV3kzYlXfTPeZY9jD
        ICER4UsmUNPDh6k9hpctHJ65nBFZJAGPuR3OcORdBqCz8TKczL5YEBPkG1ni4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676314112;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JI3CaTz9ebX/gfzOd6IiU2Ga82Qcqi5LHVfoHQzLK48=;
        b=hSj1xePr+Aup80bYasaNa9Zq4rgWfd5+HtStKvJhDSOy//gHj06HhX9ru7AMvYxWYH0KiS
        bi6bqdxb4QndyyAQ==
From:   "tip-bot2 for Feng Tang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] x86/tsc: Add option to force frequency
 recalibration with HW timer
Cc:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        <x86@kernel.org>, <linux-doc@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167631411229.4906.2814222117383015670.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a7ec817d55421ac214cac9d3e5ebb65d848198dc
Gitweb:        https://git.kernel.org/tip/a7ec817d55421ac214cac9d3e5ebb65d848198dc
Author:        Feng Tang <feng.tang@intel.com>
AuthorDate:    Wed, 04 Jan 2023 16:19:38 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 02 Feb 2023 14:22:52 -08:00

x86/tsc: Add option to force frequency recalibration with HW timer

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
[ paulmck: Wordsmith Kconfig help text. ]

[1]. https://lore.kernel.org/lkml/20221117230910.GI4001@paulmck-ThinkPad-P17-Gen-1/
Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: <x86@kernel.org>
Cc: <linux-doc@vger.kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++-
 arch/x86/kernel/tsc.c                           | 34 ++++++++++++++--
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3..95f0d10 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6369,6 +6369,10 @@
 			in situations with strict latency requirements (where
 			interruptions from clocksource watchdog are not
 			acceptable).
+			[x86] recalibrate: force recalibration against a HW timer
+			(HPET or PM timer) on systems whose TSC frequency was
+			obtained from HW or FW using either an MSR or CPUID(0x15).
+			Warn if the difference is more than 500 ppm.
 
 	tsc_early_khz=  [X86] Skip early TSC calibration and use the given
 			value instead. Useful when the early TSC frequency discovery
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a78e73d..92bbc4a 100644
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
 
@@ -1374,6 +1378,25 @@ restart:
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
