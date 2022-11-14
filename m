Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B07628D68
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbiKNX2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbiKNX2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:28:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0691157
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:28:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E4EB614B9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE716C433D7;
        Mon, 14 Nov 2022 23:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668468508;
        bh=KYiqFd5L+cDLkyT6epEDOfkYEWTRr614tu/0hHbUz6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A/X+O8aXEOSxP8x3DYS+35d+nm6T3IXGs6J4bGbc9VfVQJy6ELwhDCbAljCbdcbW+
         Ya5GV1QLglrEjUrSTQZIv6iqQxhsq0oyu7YU/sNFM7Gw+9kVv/ShrNhJoovoAOcZH0
         5uDZXAVidcgeYyG2M8Ey/jRi0JwE4Pmjk9a46yFg6Cj+6EHyfMYQJFxKiArml6sDHY
         TQAeKK6DnJnLxNRN5rUd+GHXuMV7vRPOyMhCZ/utvlTHSTX5aBElinuRp/lAQLkaO7
         YeySi0M0Dlq8AeCCEeZtOjQXttBbN3owtuSf7eOnLeTrmeqPViADFlD4VDtkTAsIXa
         N9YdWvJoIzvKQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8F9315C14FC; Mon, 14 Nov 2022 15:28:28 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Chris Mason <clm@meta.com>, John Stultz <jstultz@google.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH clocksource 1/3] clocksource: Reject bogus watchdog clocksource measurements
Date:   Mon, 14 Nov 2022 15:28:24 -0800
Message-Id: <20221114232827.835599-1-paulmck@kernel.org>
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
---
 kernel/time/clocksource.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

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
-- 
2.31.1.189.g2e36527f23

