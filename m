Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF3E6053C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJSXJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiJSXJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:09:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA0715D091
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 16:09:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A605B8261A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1ABC433C1;
        Wed, 19 Oct 2022 23:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220945;
        bh=BHGbq0AYz6Alv20BhnG96r7P6jl8a1dcx8eJdRaPpFs=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=FWTCdwBBZISvzlpQvULM3Q4iY7kUkhx6Gu97ErrtAwTj9q2+BUVdcoL+czET+2QqQ
         0/cDPGEga5cyVoJwqG+3MTuf5smc1WFtLDEfmtZA3IWGoG0MnToe61Gzng4W88lRb7
         BZyjIy1mQp9+wtsGollAO1TabRjxW7AR5yXBa1Gd+2/bW32sZyquo57VvmrAJ/weMU
         lFmVjdKZXLt58NM1crCmJiObTJsu7qISU8fQ7t7JmgirLhwCDz0PVTsAAN7m5tH3r5
         MejsphWUEuaeqmBmI+K6nG0apFtS46BrQBAxf7mFGKcUzAxqz3hb3WfpwXDabWU4GJ
         VHqsYTifRq/QA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BC76E5C06B4; Wed, 19 Oct 2022 16:09:04 -0700 (PDT)
Date:   Wed, 19 Oct 2022 16:09:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     clm@meta.com, jstultz@google.com, tglx@linutronix.de,
        sboyd@kernel.org, feng.tang@intel.com, longman@redhat.com
Subject: [PATCH clocksource] Reject bogus watchdog clocksource measurements
Message-ID: <20221019230904.GA2502730@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One remaining clocksource-skew issue involves extreme CPU overcommit,
which can cause the clocksource watchdog measurements to be delayed by
tens of seconds.  This in turn means that a clock-skew criterion that
is appropriate for a 500-millisecond interval will instead give lots of
false positives.

Therefore, check for the watchdog clocksource reporting much larger or
much less than the time specified by WATCHDOG_INTERVAL.  In these cases,
print a pr_warn() warning and refrain from marking the clocksource under
test as being unstable.

Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Waiman Long <longman@redhat.com>

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 8058bec87acee..dcaf38c062161 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -386,7 +386,7 @@ EXPORT_SYMBOL_GPL(clocksource_verify_percpu);
 
 static void clocksource_watchdog(struct timer_list *unused)
 {
-	u64 csnow, wdnow, cslast, wdlast, delta;
+	u64 csnow, wdnow, cslast, wdlast, delta, wdi;
 	int next_cpu, reset_pending;
 	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
@@ -440,6 +440,17 @@ static void clocksource_watchdog(struct timer_list *unused)
 		if (atomic_read(&watchdog_reset_pending))
 			continue;
 
+		/* Check for bogus measurements. */
+		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
+		if (wd_nsec < (wdi >> 2)) {
+			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
+			continue;
+		}
+		if (wd_nsec > (wdi << 2)) {
+			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
+			continue;
+		}
+
 		/* Check the deviation from the watchdog clocksource. */
 		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
 		if (abs(cs_nsec - wd_nsec) > md) {
