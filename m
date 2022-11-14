Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293FE628D69
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiKNX2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiKNX2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:28:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935E92A4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:28:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CD4AB815FC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D6BC433B5;
        Mon, 14 Nov 2022 23:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668468509;
        bh=ZjS+OKGtE62BjR1npWFo6xbmcHIB1kAdTslp2K20OB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s8NlDZxiV/u067KU7C3YtF9zAQMKW5UVHP2/5BJ7oZc7OZXi1teKrv56PH4rgoqtB
         /Xz4IV2JIkrnzU5g7ZBl50S2PzuQxzvcmZJTOKm42B+H4fOmRkTcM+VmG7B/Lz4pQ8
         5/tJVZPu/8o2rzZrFMryalyu7GfsPoCLeb1aNi9fL/sZVMpMQ31ZRPL1tV0F/LaNDA
         4T8whGVExx4YhJUByU82/jCN/4R5EYdQRTNACcfmO1NonrIzHq3OkSi6tWL2AkfrZC
         Kt/jjSIPIilpZclEqR5fCHZGZ09PplUdCguPGAxD+oEJrURs3jRRABI8nmix3lyU9q
         TRzDPILoFgNLQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 91E705C16C5; Mon, 14 Nov 2022 15:28:28 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Waiman Long <longman@redhat.com>,
        John Stultz <jstultz@google.com>
Subject: [PATCH clocksource 2/3] clocksource: Add comments to classify bogus measurements
Date:   Mon, 14 Nov 2022 15:28:25 -0800
Message-Id: <20221114232827.835599-2-paulmck@kernel.org>
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

An extremely busy system can delay the clocksource watchdog, so that
the corresponding too-long bogus-measurement error does not necessarily
imply an error in the system.  However, a too-short bogus-measurement
error likely indicates a bug in hardware, firmware or software.

Therefore, add comments clarifying these bogus-measurement pr_warn()s.

Reported-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Feng Tang <feng.tang@intel.com>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
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

