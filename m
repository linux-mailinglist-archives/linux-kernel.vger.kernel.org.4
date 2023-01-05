Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A8965E234
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjAEBHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjAEBHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:07:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B640C30563
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:07:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E548B81984
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027F7C433F1;
        Thu,  5 Jan 2023 01:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672880823;
        bh=yfdddVAsVm0wKfhUXEcuvIc8bj3pYmqk8I+8WWgBY/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dpm8So2JL3X9PMhoZWVSdv/dq+i0y0lDDjxvZNzRpeCudBE03jip4QbBJGQxMHeSw
         pv/k+fHdtkYX+fYjpzTNThW48lBT5ckHs88usJbEF0VwgXRbMPs/F4Zg1jt7u4yZGW
         mIOjb0uHBU00ZaMyp0O887Ahv97F9p++x/6vM4EK0afW5hvRUubYuVoxhFN8efGeIo
         ucpSdcvf9jdsYe1lFNjh7BYHsw4CeHsBODFyNsHCk0QhB036Clj72vZZicDG44I+kB
         ks2Q75ka9F7YVDqMfOVEN1yJuL0rnOfl3k1tLjHEOgwb+KK2TI9c7Ae1TCfL1NNLh5
         87KrokWCUWMrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AA98E5C086D; Wed,  4 Jan 2023 17:07:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH clocksource 2/6] clocksource: Loosen clocksource watchdog constraints
Date:   Wed,  4 Jan 2023 17:06:57 -0800
Message-Id: <20230105010701.1773895-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105010429.GA1773522@paulmck-ThinkPad-P17-Gen-1>
References: <20230105010429.GA1773522@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index a41753be1a2bf..bae8f11070bef 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -200,10 +200,14 @@ config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
 	int "Clocksource watchdog maximum allowable skew (in μs)"
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
 
 endmenu
 endif
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 4a2c3bb92e2e9..a3d19f6660ac7 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -95,6 +95,11 @@ static char override_name[CS_NAME_LEN];
 static int finished_booting;
 static u64 suspend_start;
 
+/*
+ * Interval: 0.5sec.
+ */
+#define WATCHDOG_INTERVAL (HZ >> 1)
+
 /*
  * Threshold: 0.0312s, when doubled: 0.0625s.
  * Also a default for cs->uncertainty_margin when registering clocks.
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
 
 #define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
@@ -140,11 +148,6 @@ static inline void clocksource_watchdog_unlock(unsigned long *flags)
 static int clocksource_watchdog_kthread(void *data);
 static void __clocksource_change_rating(struct clocksource *cs, int rating);
 
-/*
- * Interval: 0.5sec.
- */
-#define WATCHDOG_INTERVAL (HZ >> 1)
-
 static void clocksource_watchdog_work(struct work_struct *work)
 {
 	/*
-- 
2.31.1.189.g2e36527f23

