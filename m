Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE982694FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjBMStC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjBMSsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:48:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B665C1CAEC;
        Mon, 13 Feb 2023 10:48:35 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:48:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676314114;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eS/JiuuqtXiw1NTI+j2SyVN5tbmyJPF5sj86ctZ/cyU=;
        b=AFo2V4uVrT+j5jBY2rM373rmvEJZF41ubniCbrjWi/FjPbYfZmqqjjoufV3gl0BuC/YQwo
        2BVC6YQUrowfn3QJPxwCp+TtL2nziY/xhs8VeH86+cHlMTunOAT2Xegr+xIgsJrGfoWZH3
        TTkSdlW8qKyywQokoerD/ERGWX9FvVXp1wZxXt1D95ZfpkmU0v0Y3uhaZmkALB71Ztrr9L
        QLwSeGtqu9mxKjBQirW/AxNg1sfBjcsz3m7dlD5mK6fP6rSV2yCQ9sWPiCTF0sEncsKqi7
        RJIEsahWs/KrwkSBRs3heu6vHzVlULGbvyZUlNB10zD4NUTcAdQoRCWVnhe9Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676314114;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eS/JiuuqtXiw1NTI+j2SyVN5tbmyJPF5sj86ctZ/cyU=;
        b=jJAkY8Y0CSamjw/YqEiALEVwZ0VWHBz4eHkB/BfgerYoOdJ6WHY3UWk4/Xl4CSLi1MKMPj
        KS30a1S0umhDq3Cw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Loosen clocksource watchdog constraints
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167631411389.4906.18096787596269259442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c37e85c135cead4256dc8860073c468d8925c3df
Gitweb:        https://git.kernel.org/tip/c37e85c135cead4256dc8860073c468d892=
5c3df
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 06 Dec 2022 19:36:10 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 03 Jan 2023 20:43:45 -08:00

clocksource: Loosen clocksource watchdog constraints

Currently, MAX_SKEW_USEC is set to 100 microseconds, which has worked
reasonably well.  However, NTP is willing to tolerate 500 microseconds
of skew per second, and a clocksource that is good enough for NTP should
be good enough for the clocksource watchdog.  The watchdog's skew is
controlled by MAX_SKEW_USEC and the CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
Kconfig option.  However, these values are doubled before being associated
with a clocksource's ->uncertainty_margin, and the ->uncertainty_margin
values of the pair of clocksource's being compared are summed before
checking against the skew.

Therefore, set both MAX_SKEW_USEC and the default for the
CLOCKSOURCE_WATCHDOG_MAX_SKEW_US Kconfig option to 125 microseconds of
skew per second, resulting in 500 microseconds of skew per second in
the clocksource watchdog's skew comparison.

Suggested-by Rik van Riel <riel@surriel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/Kconfig       |  6 +++++-
 kernel/time/clocksource.c | 15 +++++++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index a41753b..bae8f11 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -200,10 +200,14 @@ config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
 	int "Clocksource watchdog maximum allowable skew (in =CE=BCs)"
 	depends on CLOCKSOURCE_WATCHDOG
 	range 50 1000
-	default 100
+	default 125
 	help
 	  Specify the maximum amount of allowable watchdog skew in
 	  microseconds before reporting the clocksource to be unstable.
+	  The default is based on a half-second clocksource watchdog
+	  interval and NTP's maximum frequency drift of 500 parts
+	  per million.	If the clocksource is good enough for NTP,
+	  it is good enough for the clocksource watchdog!
=20
 endmenu
 endif
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 4a2c3bb..a3d19f6 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -96,6 +96,11 @@ static int finished_booting;
 static u64 suspend_start;
=20
 /*
+ * Interval: 0.5sec.
+ */
+#define WATCHDOG_INTERVAL (HZ >> 1)
+
+/*
  * Threshold: 0.0312s, when doubled: 0.0625s.
  * Also a default for cs->uncertainty_margin when registering clocks.
  */
@@ -106,11 +111,14 @@ static u64 suspend_start;
  * clocksource surrounding a read of the clocksource being validated.
  * This delay could be due to SMIs, NMIs, or to VCPU preemptions.  Used as
  * a lower bound for cs->uncertainty_margin values when registering clocks.
+ *
+ * The default of 500 parts per million is based on NTP's limits.
+ * If a clocksource is good enough for NTP, it is good enough for us!
  */
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
 #define MAX_SKEW_USEC	CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
 #else
-#define MAX_SKEW_USEC	100
+#define MAX_SKEW_USEC	(125 * WATCHDOG_INTERVAL / HZ)
 #endif
=20
 #define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
@@ -140,11 +148,6 @@ static inline void clocksource_watchdog_unlock(unsigned =
long *flags)
 static int clocksource_watchdog_kthread(void *data);
 static void __clocksource_change_rating(struct clocksource *cs, int rating);
=20
-/*
- * Interval: 0.5sec.
- */
-#define WATCHDOG_INTERVAL (HZ >> 1)
-
 static void clocksource_watchdog_work(struct work_struct *work)
 {
 	/*
