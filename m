Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C138F651C54
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 09:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiLTI2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 03:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiLTI2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 03:28:01 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E50D165B3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 00:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671524880; x=1703060880;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T158du3kGmXXokicPR6fB328LpH2wH7Nj0/DHwUoQRI=;
  b=KIvnwobu77IleDooldn66umBovdYqOgGCMySIhPpw21iY5pIaWdfG/mA
   BkRwm2qzNXWbZ8U39z7SbybuwTut8/REKoRqwBgjF4WW9fzkwllFGhLpg
   UXWEe4KAZOqOr6mQpRhvs5zwz2kZYVtch83FSQHWk5UejythVg2LTNDz8
   cxVPZpKVbwV3KNa8kurPB4tUFUycAoACa1mhwjOejwHAdUrZH533zwxU4
   0awhQJBiqZJCOzcb5fZvMOfS8VtcFJGl19MjgWT/ZnO/Px0pkqk4hFCve
   KWOoA3xb1hcbWaDH5JuVJki9/XnskJ9dyqxtDJP8oY55zO1pFZM/ltPSn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="307240031"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="307240031"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 00:27:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="793206662"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="793206662"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga001.fm.intel.com with ESMTP; 20 Dec 2022 00:27:56 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [RFC PATCH] clocksource: Suspend the watchdog temporarily when high read lantency detected
Date:   Tue, 20 Dec 2022 16:25:12 +0800
Message-Id: <20221220082512.186283-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were bug reported on 8 sockets x86 machines that TSC was wrongly
disabled when system is under heavy workload.

 [ 818.380354] clocksource: timekeeping watchdog on CPU336: hpet wd-wd read-back delay of 1203520ns
 [ 818.436160] clocksource: wd-tsc-wd read-back delay of 181880ns, clock-skew test skipped!
 [ 819.402962] clocksource: timekeeping watchdog on CPU338: hpet wd-wd read-back delay of 324000ns
 [ 819.448036] clocksource: wd-tsc-wd read-back delay of 337240ns, clock-skew test skipped!
 [ 819.880863] clocksource: timekeeping watchdog on CPU339: hpet read-back delay of 150280ns, attempt 3, marking unstable
 [ 819.936243] tsc: Marking TSC unstable due to clocksource watchdog
 [ 820.068173] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
 [ 820.092382] sched_clock: Marking unstable (818769414384, 1195404998)
 [ 820.643627] clocksource: Checking clocksource tsc synchronization from CPU 267 to CPUs 0,4,25,70,126,430,557,564.
 [ 821.067990] clocksource: Switched to clocksource hpet

This can be reproduced when system is running memory intensive 'stream'
test, or some stress-ng subcases like 'ioport'.

The reason is when system is under heavy load, the read latency of
clocksource can be very high, it can be seen even with lightweight
TSC read, and is much worse on MMIO or IO port read based external
clocksource. Causing the watchdog check to be inaccurate.

As the clocksource watchdog is a lifetime check with frequency of
twice a second, there is no need to rush doing it when the system
is under heavy load and the clocksource read latency is very high,
suspend the watchdog timer for 5 minutes.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 kernel/time/clocksource.c | 45 ++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 9cf32ccda715..8cd74b89d577 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -384,6 +384,15 @@ void clocksource_verify_percpu(struct clocksource *cs)
 }
 EXPORT_SYMBOL_GPL(clocksource_verify_percpu);
 
+static inline void clocksource_reset_watchdog(void)
+{
+	struct clocksource *cs;
+
+	list_for_each_entry(cs, &watchdog_list, wd_list)
+		cs->flags &= ~CLOCK_SOURCE_WATCHDOG;
+}
+
+
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	u64 csnow, wdnow, cslast, wdlast, delta;
@@ -391,6 +400,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
 	enum wd_read_status read_ret;
+	unsigned long extra_wait = 0;
 	u32 md;
 
 	spin_lock(&watchdog_lock);
@@ -410,13 +420,30 @@ static void clocksource_watchdog(struct timer_list *unused)
 
 		read_ret = cs_watchdog_read(cs, &csnow, &wdnow);
 
-		if (read_ret != WD_READ_SUCCESS) {
-			if (read_ret == WD_READ_UNSTABLE)
-				/* Clock readout unreliable, so give it up. */
-				__clocksource_unstable(cs);
+		if (read_ret == WD_READ_UNSTABLE) {
+			/* Clock readout unreliable, so give it up. */
+			__clocksource_unstable(cs);
 			continue;
 		}
 
+		/*
+		 * When WD_READ_SKIP is returned, it means the system is likely
+		 * under very heavy load, where the latency of reading
+		 * watchdog/clocksource is very big, and affect the accuracy of
+		 * watchdog check. So give system some space and suspend the
+		 * watchdog check for 5 minutes.
+		 */
+		if (read_ret == WD_READ_SKIP) {
+			/*
+			 * As the watchdog timer will be suspended, and
+			 * cs->last could keep unchanged for 5 minutes, reset
+			 * the counters.
+			 */
+			clocksource_reset_watchdog();
+			extra_wait = HZ * 300;
+			break;
+		}
+
 		/* Clocksource initialized ? */
 		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
 		    atomic_read(&watchdog_reset_pending)) {
@@ -512,7 +539,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	 * pair clocksource_stop_watchdog() clocksource_start_watchdog().
 	 */
 	if (!timer_pending(&watchdog_timer)) {
-		watchdog_timer.expires += WATCHDOG_INTERVAL;
+		watchdog_timer.expires += WATCHDOG_INTERVAL + extra_wait;
 		add_timer_on(&watchdog_timer, next_cpu);
 	}
 out:
@@ -537,14 +564,6 @@ static inline void clocksource_stop_watchdog(void)
 	watchdog_running = 0;
 }
 
-static inline void clocksource_reset_watchdog(void)
-{
-	struct clocksource *cs;
-
-	list_for_each_entry(cs, &watchdog_list, wd_list)
-		cs->flags &= ~CLOCK_SOURCE_WATCHDOG;
-}
-
 static void clocksource_resume_watchdog(void)
 {
 	atomic_inc(&watchdog_reset_pending);
-- 
2.34.1

