Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC512694FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBMSsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBMSse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:48:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7139C1CAE9;
        Mon, 13 Feb 2023 10:48:33 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:48:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676314112;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=10aKowH0O7xPF52QLDURYI+M9aMFRFNzFxX/Nv4RgY8=;
        b=0ugPr2Mvu5D2SCsN+V+b59CqI5Vtf+oE0KShAnXvOzv4PBNy3L7Bx9JxyQEKanEJROhmnO
        GTHy3El/JmEauWIHXLmtyF6OZG05V5fWEWJcym3HvGey1k0SHg+pvr0wKgrT+u7crBgLiD
        fQgSUlMLpyC1AK/4a4YdDy/QZU0zgdzp+uZqPrCNiuEbK17SaK27/NU/mYQ0ni1SYoDBsu
        35pgiW7VVNIR2tAFFnJ9u9hRLmqWvz4Bjk/lYpr3msNCAM9CwFjdgSw7lST0xq5Dgk7t0A
        m1ddnA8t+0+bZBtLfJZlv65RWPlH0yiIJWD6l4Fnwj09vPDcaTF6JDBz7sGAyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676314112;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=10aKowH0O7xPF52QLDURYI+M9aMFRFNzFxX/Nv4RgY8=;
        b=cPcXBWmC2Uq9efntRZOeXbKuyNww9A8Q0OLORtCopYYy1MmpHBlL7oipAAi9zvb0SZLWxX
        7hu1WV+/4BDTL6CA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Enable TSC watchdog checking of HPET
 and PMTMR only when requested
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167631411143.4906.5479453461226971405.tip-bot2@tip-bot2>
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

Commit-ID:     0051293c533017e2a860e0a0a33517bc40240fff
Gitweb:        https://git.kernel.org/tip/0051293c533017e2a860e0a0a33517bc40240fff
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 01 Feb 2023 13:53:07 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 06 Feb 2023 16:38:30 -08:00

clocksource: Enable TSC watchdog checking of HPET and PMTMR only when requested

Unconditionally enabling TSC watchdog checking of the HPET and PMTMR
clocksources can degrade latency and performance.  Therefore, provide
a new "watchdog" option to the tsc= boot parameter that opts into such
checking.  Note that tsc=watchdog is overridden by a tsc=nowatchdog
regardless of their relative positions in the list of boot parameters.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Waiman Long <longman@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 +++++-
 arch/x86/kernel/tsc.c                           | 18 ++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 95f0d10..7b4df6d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6373,6 +6373,12 @@
 			(HPET or PM timer) on systems whose TSC frequency was
 			obtained from HW or FW using either an MSR or CPUID(0x15).
 			Warn if the difference is more than 500 ppm.
+			[x86] watchdog: Use TSC as the watchdog clocksource with
+			which to check other HW timers (HPET or PM timer), but
+			only on systems where TSC has been deemed trustworthy.
+			This will be suppressed by an earlier tsc=nowatchdog and
+			can be overridden by a later tsc=nowatchdog.  A console
+			message will flag any such suppression or overriding.
 
 	tsc_early_khz=  [X86] Skip early TSC calibration and use the given
 			value instead. Useful when the early TSC frequency discovery
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a5371c6..306c233 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -294,6 +294,7 @@ __setup("notsc", notsc_setup);
 
 static int no_sched_irq_time;
 static int no_tsc_watchdog;
+static int tsc_as_watchdog;
 
 static int __init tsc_setup(char *str)
 {
@@ -303,10 +304,22 @@ static int __init tsc_setup(char *str)
 		no_sched_irq_time = 1;
 	if (!strcmp(str, "unstable"))
 		mark_tsc_unstable("boot parameter");
-	if (!strcmp(str, "nowatchdog"))
+	if (!strcmp(str, "nowatchdog")) {
 		no_tsc_watchdog = 1;
+		if (tsc_as_watchdog)
+			pr_alert("%s: Overriding earlier tsc=watchdog with tsc=nowatchdog\n",
+				 __func__);
+		tsc_as_watchdog = 0;
+	}
 	if (!strcmp(str, "recalibrate"))
 		tsc_force_recalibrate = 1;
+	if (!strcmp(str, "watchdog")) {
+		if (no_tsc_watchdog)
+			pr_alert("%s: tsc=watchdog overridden by earlier tsc=nowatchdog\n",
+				 __func__);
+		else
+			tsc_as_watchdog = 1;
+	}
 	return 1;
 }
 
@@ -1192,7 +1205,8 @@ static void __init tsc_disable_clocksource_watchdog(void)
 
 bool tsc_clocksource_watchdog_disabled(void)
 {
-	return !(clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY);
+	return !(clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY) &&
+	       tsc_as_watchdog && !no_tsc_watchdog;
 }
 
 static void __init check_system_tsc_reliable(void)
