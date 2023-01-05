Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C9165E231
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjAEBHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjAEBHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:07:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC343055C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:07:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26D1761896
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3B5C433AE;
        Thu,  5 Jan 2023 01:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672880823;
        bh=/IAu4A8czS9Ro0tYmgqlY7WbRqRFFlgq0vaHiJqT+No=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m0KxLN5JEXw/4+Ba7IOnj0Hvvm8LbLPFx8JJyYLkkOc4RsFGjK9/EVnQ8t4CafMNb
         sybTvhPX02Y3nDI301MUT3axdSlaKktepbaJVwCKVHKAWEUyvlrFFYhthot5cBzPuM
         muTumVrEzFWUSiwwvTuxND99dVqp0TsI3xVSjnJkI4iCLjnyj/91ovEheWlMKwzWKc
         DHqFpEoDCsUtPkQi5OsDRicxJez4Culc9bt97KSyEAZSxKxSzGnL53Cz/qAFddzwA3
         zRcomGuCLcvWEQPXrx7sm3rvJTUf+pO3UtNQPuic+ISDBIGMwJIxmFrSef2Q8HfO3n
         gA5gwJdR7VZ8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B29EB5C1ADF; Wed,  4 Jan 2023 17:07:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org
Subject: [PATCH clocksource 6/6] clocksource: Verify HPET and PMTMR when TSC unverified
Date:   Wed,  4 Jan 2023 17:07:01 -0800
Message-Id: <20230105010701.1773895-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105010429.GA1773522@paulmck-ThinkPad-P17-Gen-1>
References: <20230105010429.GA1773522@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems with two or fewer sockets, when the boot CPU has CONSTANT_TSC,
NONSTOP_TSC, and TSC_ADJUST, clocksource watchdog verification of the
TSC is disabled.  This works well much of the time, but there is the
occasional system that meets all of these criteria, but which still
has a TSC that skews significantly from atomic-clock time.  This is
usually attributed to a firmware or hardware fault.  Yes, the various
NTP daemons do express their opinions of userspace-to-atomic-clock time
skew, but they put them in various places, depending on the daemon and
distro in question.  It would therefore be good for the kernel to have
some clue that there is a problem.

The old behavior of marking the TSC unstable is a non-starter because a
great many workloads simply cannot tolerate the overheads and latencies
of the various non-TSC clocksources.  In addition, NTP-corrected systems
often seem to be able to tolerate significant kernel-space time skew as
long as the userspace time sources are within epsilon of atomic-clock
time.

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
index 8ac563abb567b..a53961c64a567 100644
--- a/arch/x86/include/asm/time.h
+++ b/arch/x86/include/asm/time.h
@@ -8,6 +8,7 @@
 extern void hpet_time_init(void);
 extern void time_init(void);
 extern bool pit_timer_init(void);
+extern bool tsc_clocksource_watchdog_disabled(void);
 
 extern struct clock_event_device *global_clock_event;
 
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 71f336425e58a..c8eb1ac5125ab 100644
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
index a78e73da4a74b..af3782fb6200c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1186,6 +1186,11 @@ static void __init tsc_disable_clocksource_watchdog(void)
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
index 279ddff81ab49..82338773602ca 100644
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
-- 
2.31.1.189.g2e36527f23

