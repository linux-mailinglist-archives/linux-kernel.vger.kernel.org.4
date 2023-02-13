Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4CB694FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjBMSsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBMSsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:48:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B6A1CAEC;
        Mon, 13 Feb 2023 10:48:33 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:48:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676314112;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QktjQdaPWXrlU2U5DJ5UdMkhC/ABQCVbeDlMTF+Qflo=;
        b=r/qU9kaAAFZJZC+xfs8i87E8mlk88m2U0J1BLMNwmDnpHAmI+3NkyXpHDnbYYbhq3oyV2o
        IIEQ8x8V/WCdRMsnlKYL8T3NcByR8xg+rjOnkDqvAum8bf/BfJR3ueYCUKpHqPboV/iz8b
        yNzmkSlK9Qqh1gQw2cH1ts+UfM70oNnAAbPpdyOQ9Y/tyKnQz8X92tTFYbaJ773pxNuOlK
        v2sPiPoTUVdac6otOOM7Ho9fjaWW6FllF/ny5zyBfAVYMobtjvoZ5BYClo8mkxJcdpIZKa
        /iKHOQbZFAgqAjhx3dZYp47++W+lg/5cYQLsLu5lO957c5ZGpS+AY7MGj1VD3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676314112;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QktjQdaPWXrlU2U5DJ5UdMkhC/ABQCVbeDlMTF+Qflo=;
        b=engVG8xBzqN/+/A0oUST9xZIbf318V+GP+AUkhEbAOQYqytt6zSqzq446kn08qqPEobUVX
        WMUqY8chQWtVqiDQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Verify HPET and PMTMR when TSC unverified
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Waiman Long <longman@redhat.com>, <x86@kernel.org>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167631411184.4906.7018924399872835917.tip-bot2@tip-bot2>
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

Commit-ID:     efc8b329c7fdc30921a7dfc109237523e1e5b1cc
Gitweb:        https://git.kernel.org/tip/efc8b329c7fdc30921a7dfc109237523e1e5b1cc
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 21 Dec 2022 16:20:25 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 02 Feb 2023 14:23:02 -08:00

clocksource: Verify HPET and PMTMR when TSC unverified

On systems with two or fewer sockets, when the boot CPU has CONSTANT_TSC,
NONSTOP_TSC, and TSC_ADJUST, clocksource watchdog verification of the
TSC is disabled.  This works well much of the time, but there is the
occasional production-level system that meets all of these criteria, but
which still has a TSC that skews significantly from atomic-clock time.
This is usually attributed to a firmware or hardware fault.  Yes, the
various NTP daemons do express their opinions of userspace-to-atomic-clock
time skew, but they put them in various places, depending on the daemon
and distro in question.  It would therefore be good for the kernel to
have some clue that there is a problem.

The old behavior of marking the TSC unstable is a non-starter because a
great many workloads simply cannot tolerate the overheads and latencies
of the various non-TSC clocksources.  In addition, NTP-corrected systems
sometimes can tolerate significant kernel-space time skew as long as
the userspace time sources are within epsilon of atomic-clock time.

Therefore, when watchdog verification of TSC is disabled, enable it for
HPET and PMTMR (AKA ACPI PM timer).  This provides the needed in-kernel
time-skew diagnostic without degrading the system's performance.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Waiman Long <longman@redhat.com>
Cc: <x86@kernel.org>
Tested-by: Feng Tang <feng.tang@intel.com>
---
 arch/x86/include/asm/time.h   | 1 +
 arch/x86/kernel/hpet.c        | 2 ++
 arch/x86/kernel/tsc.c         | 5 +++++
 drivers/clocksource/acpi_pm.c | 6 ++++--
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/time.h b/arch/x86/include/asm/time.h
index 8ac563a..a53961c 100644
--- a/arch/x86/include/asm/time.h
+++ b/arch/x86/include/asm/time.h
@@ -8,6 +8,7 @@
 extern void hpet_time_init(void);
 extern void time_init(void);
 extern bool pit_timer_init(void);
+extern bool tsc_clocksource_watchdog_disabled(void);
 
 extern struct clock_event_device *global_clock_event;
 
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 71f3364..c8eb1ac 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -1091,6 +1091,8 @@ int __init hpet_enable(void)
 	if (!hpet_counting())
 		goto out_nohpet;
 
+	if (tsc_clocksource_watchdog_disabled())
+		clocksource_hpet.flags |= CLOCK_SOURCE_MUST_VERIFY;
 	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
 
 	if (id & HPET_ID_LEGSUP) {
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 92bbc4a..a5371c6 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1190,6 +1190,11 @@ static void __init tsc_disable_clocksource_watchdog(void)
 	clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
 }
 
+bool tsc_clocksource_watchdog_disabled(void)
+{
+	return !(clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY);
+}
+
 static void __init check_system_tsc_reliable(void)
 {
 #if defined(CONFIG_MGEODEGX1) || defined(CONFIG_MGEODE_LX) || defined(CONFIG_X86_GENERIC)
diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
index 279ddff..8233877 100644
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -23,6 +23,7 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <asm/io.h>
+#include <asm/time.h>
 
 /*
  * The I/O port the PMTMR resides at.
@@ -210,8 +211,9 @@ static int __init init_acpi_pm_clocksource(void)
 		return -ENODEV;
 	}
 
-	return clocksource_register_hz(&clocksource_acpi_pm,
-						PMTMR_TICKS_PER_SEC);
+	if (tsc_clocksource_watchdog_disabled())
+		clocksource_acpi_pm.flags |= CLOCK_SOURCE_MUST_VERIFY;
+	return clocksource_register_hz(&clocksource_acpi_pm, PMTMR_TICKS_PER_SEC);
 }
 
 /* We use fs_initcall because we want the PCI fixups to have run
