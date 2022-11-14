Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464AE628D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbiKNX2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbiKNX2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:28:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1E92AB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:28:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E647B8133B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CD9C433C1;
        Mon, 14 Nov 2022 23:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668468508;
        bh=yWPbFrTyk/Pat7LzvV8D6SH/ODiafdLuMh9HWpa0Mu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U240jKJW3sGDmowlbl/h6Mpt1cLwUTBap5/9nPpthjXqufdIfx3lsVzDx64c4n4U6
         lqhJEx33abLRxkuqwVzQ0P+CIA0CtLmgw3pa6ppp9r3SQYG2RZrFPcvunWrMMkT95W
         iLXI+bL723pmkqztOnufnepz4/RqzkbCmRynMvy62SH7ClaXgmkTNpzHwEUahn/6PE
         KYXQJtyBlNztfhYW1XsJbTX3Q0w2LK6rUEJu4AmRQWQqtTHjD+x0o70rT5b9MuS836
         2z+L/5AI0wxGBRFD34YsWct/iuPJyN2g5d5EV4cXYCqFnGj9mgdfE0grCP0u4rPekl
         gJFxfBgHRSvng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 940665C1718; Mon, 14 Nov 2022 15:28:28 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Waiman Long <longman@redhat.com>,
        John Stultz <jstultz@google.com>
Subject: [PATCH clocksource 3/3] clocksource: Exponential backoff for load-induced bogus watchdog reads
Date:   Mon, 14 Nov 2022 15:28:26 -0800
Message-Id: <20221114232827.835599-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221114232807.GA834337@paulmck-ThinkPad-P17-Gen-1>
References: <20221114232807.GA834337@paulmck-ThinkPad-P17-Gen-1>
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

The clocksource watchdog will reject measurements that are excessively
delayed, that is, by more than 1.5 seconds beyond the intended 0.5-second
watchdog interval.  On an extremely busy system, this can result in a
console message being printed every two seconds.  This is excessively
noisy for a non-error condition.

Therefore, apply exponential backoff to these messages.  This exponential
backoff is capped at 1024 times the watchdog interval, which comes to
not quite one message per ten minutes.

Please note that the bogus watchdog reads that occur when the watchdog
interval is less than 0.125 seconds are still printed unconditionally
because these likely correspond to a serious error condition in the
timer code or hardware.

[ paulmck: Apply Feng Tang feedback. ]
[ paulmck: Apply Waiman Long feedback. ]

Reported-by: Waiman Long <longman@redhat.com>
Reported-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Feng Tang <feng.tang@intel.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
---
 include/linux/clocksource.h |  3 +++
 kernel/time/clocksource.c   | 31 +++++++++++++++++++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 1d42d4b173271..23b73f2293d6d 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -125,6 +125,9 @@ struct clocksource {
 	struct list_head	wd_list;
 	u64			cs_last;
 	u64			wd_last;
+	u64			wd_last_bogus;
+	int			wd_bogus_shift;
+	unsigned long		wd_bogus_count;
 #endif
 	struct module		*owner;
 };
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 3f5317faf891f..4015ec6503a52 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -442,14 +442,33 @@ static void clocksource_watchdog(struct timer_list *unused)
 
 		/* Check for bogus measurements. */
 		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
-		if (wd_nsec < (wdi >> 2)) {
-			/* This usually indicates broken timer code or hardware. */
-			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
+		if (wd_nsec > (wdi << 2) || cs_nsec > (wdi << 2)) {
+			bool needwarn = false;
+			u64 wd_lb;
+
+			cs->wd_bogus_count++;
+			if (!cs->wd_bogus_shift) {
+				needwarn = true;
+			} else {
+				delta = clocksource_delta(wdnow, cs->wd_last_bogus, watchdog->mask);
+				wd_lb = clocksource_cyc2ns(delta, watchdog->mult, watchdog->shift);
+				if ((1 << cs->wd_bogus_shift) * wdi <= wd_lb)
+					needwarn = true;
+			}
+			if (needwarn) {
+				/* This can happen on busy systems, which can delay the watchdog. */
+				pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval (%lu since last message), probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL, cs->wd_bogus_count);
+				cs->wd_last_bogus = wdnow;
+				if (cs->wd_bogus_shift < 10)
+					cs->wd_bogus_shift++;
+				cs->wd_bogus_count = 0;
+			}
 			continue;
 		}
-		if (wd_nsec > (wdi << 2)) {
-			/* This can happen on busy systems, which can delay the watchdog. */
-			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
+		/* Check too-short measurements second to handle wrap. */
+		if (wd_nsec < (wdi >> 2) || cs_nsec < (wdi >> 2)) {
+			/* This usually indicates broken timer code or hardware. */
+			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
 			continue;
 		}
 
-- 
2.31.1.189.g2e36527f23

