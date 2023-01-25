Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9F167A7B3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjAYA2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 19:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbjAYA2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:28:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7011F4DE27
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:28:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7015A613DC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81BCC433A4;
        Wed, 25 Jan 2023 00:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674606452;
        bh=qdP6NXSXpyI8pYe6XWt4MIApSDs2MCybUN24u0PUPWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZK08XQliqevn5CBB4TaWIMENAvtA3RRTjasnvfvdSSTJ/bYHYy+Q4+Yfwn062zEJR
         n8uJ5wyXlYDFdafjugzt8vswtiZ+lJoP/Hwvhh8kkbdEKdhr6SuC6ozXxVcfE0TTHk
         YjUDSLE9auItg+lnJ++fkCGGk2UWe/dZtWAsb5Ya2dCtJ5vLxy/LG2T8+NCHOrvjBG
         bUsN6UNzjxzXt6dy9Y/IgbgmOXMtlatXybXM7jnqNa0SonWXMMhfCqIltDuMU+rJc5
         LJN4UX09lBE+9If4iqZX97KPfm+qSjjQNSaZgWC7gTIDd3L4Nn+9z17CqjP5EftVGK
         RyhcWDEyLizjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 793CD5C1CEF; Tue, 24 Jan 2023 16:27:32 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Waiman Long <longman@redhat.com>,
        John Stultz <jstultz@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 clocksource 5/7] clocksource: Suspend the watchdog temporarily when high read latency detected
Date:   Tue, 24 Jan 2023 16:27:28 -0800
Message-Id: <20230125002730.1471349-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
References: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
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

From: Feng Tang <feng.tang@intel.com>

Bugs have been reported on 8 sockets x86 machines in which the TSC was
wrongly disabled when the system is under heavy workload.

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

This can be reproduced by running memory intensive 'stream' tests,
or some of the stress-ng subcases such as 'ioport'.

The reason for these issues is the when system is under heavy load, the
read latency of the clocksources can be very high.  Even lightweight TSC
reads can show high latencies, and latencies are much worse for external
clocksources such as HPET or the APIC PM timer.  These latencies can
result in false-positive clocksource-unstable determinations.

These issues were initially reported by a customer running on a production
system, and this problem was reproduced on several generations of Xeon
servers, especially when running the stress-ng test.  These Xeon servers
were not production systems, but they did have the latest steppings
and firmware.

Given that the clocksource watchdog is a continual diagnostic check with
frequency of twice a second, there is no need to rush it when the system
is under heavy load.  Therefore, when high clocksource read latencies
are detected, suspend the watchdog timer for 5 minutes.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Acked-by: Waiman Long <longman@redhat.com>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Feng Tang <feng.tang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/clocksource.c | 45 ++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index fc486cd972635..91836b727cef5 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -387,6 +387,15 @@ void clocksource_verify_percpu(struct clocksource *cs)
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
@@ -394,6 +403,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
 	enum wd_read_status read_ret;
+	unsigned long extra_wait = 0;
 	u32 md;
 
 	spin_lock(&watchdog_lock);
@@ -413,13 +423,30 @@ static void clocksource_watchdog(struct timer_list *unused)
 
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
@@ -523,7 +550,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	 * pair clocksource_stop_watchdog() clocksource_start_watchdog().
 	 */
 	if (!timer_pending(&watchdog_timer)) {
-		watchdog_timer.expires += WATCHDOG_INTERVAL;
+		watchdog_timer.expires += WATCHDOG_INTERVAL + extra_wait;
 		add_timer_on(&watchdog_timer, next_cpu);
 	}
 out:
@@ -548,14 +575,6 @@ static inline void clocksource_stop_watchdog(void)
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
2.31.1.189.g2e36527f23

