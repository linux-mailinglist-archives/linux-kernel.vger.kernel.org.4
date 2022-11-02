Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3FC616CA9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiKBSkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiKBSkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:40:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526D42FA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:40:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC822B82433
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 18:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84177C433D6;
        Wed,  2 Nov 2022 18:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667414410;
        bh=QDzLlEsdJgBZfwCe8fdmspQ4lio25AEQNSzuvHZI6ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oOPiGX/M5djAqWhXtUaku0rxJ5mAilaYczj6k7j7MtJo6Tmkwc1sYfYOlgYiI27Nk
         VnRB6Maz1sSNTubTnml6bEBh90vY+rh5txbOgv8DEOfj2d/sAXLCww17SYH82X5YkS
         yXO2z8MApivd7vyuDAsZyf1c/JtHoatzZ3Rv0V/K+O26jcejH8sdHtSnpUJXbbgx6K
         dfJuyj2Sk9+/eGw+y+Gi88/Y8eVCGOpxTwyKKU8SkAWirAk7Gk8rgGFnA+Tj7iPbk1
         RywLpHvtNsuL9+Si2Vmeb8Bny9cjpkAlPviby8mubnG22nkQ0D0IJilU0j3O62GT/U
         E/Fc5tBi0PiOw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3F37B5C1813; Wed,  2 Nov 2022 11:40:10 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        John Stultz <jstultz@google.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH clocksource 1/2] clocksource: Add comments to classify bogus measurements
Date:   Wed,  2 Nov 2022 11:40:08 -0700
Message-Id: <20221102184009.1306751-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221102184001.GA1306489@paulmck-ThinkPad-P17-Gen-1>
References: <20221102184001.GA1306489@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An extremely busy system can delay the clocksource watchdog, so that
the corresponding too-long bogus-measurement error does not necessarily
imply an error in the system.  However, a too-short bogus-measurement
error likely indicates a bug in hardware, firmware or software.

Therefore, add comments clarifying these bogus-measurement pr_warn()s.

Reported-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Waiman Long <longman@redhat.com>
---
 kernel/time/clocksource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index dcaf38c062161..3f5317faf891f 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -443,10 +443,12 @@ static void clocksource_watchdog(struct timer_list *unused)
 		/* Check for bogus measurements. */
 		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
 		if (wd_nsec < (wdi >> 2)) {
+			/* This usually indicates broken timer code or hardware. */
 			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
 			continue;
 		}
 		if (wd_nsec > (wdi << 2)) {
+			/* This can happen on busy systems, which can delay the watchdog. */
 			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
 			continue;
 		}
-- 
2.31.1.189.g2e36527f23

