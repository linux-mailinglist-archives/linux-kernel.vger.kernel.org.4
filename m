Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B126767A7B1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjAYA2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 19:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbjAYA2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:28:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FFCF75D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:28:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65E0D61411
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5C1C4339E;
        Wed, 25 Jan 2023 00:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674606452;
        bh=xEevU0ma7O1DL7C5uiFkN+haaj0y+rnQnb6YU8qQKmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uD7pPh8DvrqCt71QimBiukpmO6s3hCllmHEYIKbbA2ZbXBrOND1ENGWhgDXKsVe/d
         /0hFuP8UA4x4Xivu47dVTz5SNhTIgdx5oEYe8p6gkAXBx4xxEp9e4BGuzYM9BaRM7U
         1N7YU0sHgyiC4W+ralpiZoAdFKibDQChSdL7D9Axg3rGirTNc7dTSlmGn5WePEDFX6
         RHJL7SNPCfXJWkPVmi97VftpVM/PNgyigN6ggpgcNDAnmNvqBToK4+xWvTzZTyuX51
         21YnxwdFj3wC2jbZiMao9O4/iXRnhOmf0EVqfF0CB2xMMWJ/JDSWn5gTPIJJ9xo5fk
         czf3j5pZNNprQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 767EA5C1C79; Tue, 24 Jan 2023 16:27:32 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        John Stultz <jstultz@google.com>
Subject: [PATCH v2 clocksource 4/7] clocksource: Improve "skew is too large" messages
Date:   Tue, 24 Jan 2023 16:27:27 -0800
Message-Id: <20230125002730.1471349-4-paulmck@kernel.org>
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

When clocksource_watchdog() detects excessive clocksource skew compared
to the watchdog clocksource, it marks the clocksource under test as
unstable and prints several lines worth of message.  But that message
is unclear to anyone unfamiliar with the code:

clocksource: timekeeping watchdog on CPU2: Marking clocksource 'wdtest-ktime' as unstable because the skew is too large:
clocksource:                       'kvm-clock' wd_nsec: 400744390 wd_now: 612625c2c wd_last: 5fa7f7c66 mask: ffffffffffffffff
clocksource:                       'wdtest-ktime' cs_nsec: 600744034 cs_now: 173081397a292d4f cs_last: 17308139565a8ced mask: ffffffffffffffff
clocksource:                       'kvm-clock' (not 'wdtest-ktime') is current clocksource.

Therefore, add the following line near the end of that message:

Clocksource 'wdtest-ktime' skewed 199999644 ns (199 ms) over watchdog 'kvm-clock' interval of 400744390 ns (400 ms)

This new line clearly indicates the amount of skew between the two
clocksources, along with the duration of the time interval over which
the skew occurred, both in nanoseconds and milliseconds.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Feng Tang <feng.tang@intel.com>
---
 kernel/time/clocksource.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b59914953809f..fc486cd972635 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -446,12 +446,20 @@ static void clocksource_watchdog(struct timer_list *unused)
 		/* Check the deviation from the watchdog clocksource. */
 		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
 		if (abs(cs_nsec - wd_nsec) > md) {
+			u64 cs_wd_msec;
+			u64 wd_msec;
+			u32 wd_rem;
+
 			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
 				smp_processor_id(), cs->name);
 			pr_warn("                      '%s' wd_nsec: %lld wd_now: %llx wd_last: %llx mask: %llx\n",
 				watchdog->name, wd_nsec, wdnow, wdlast, watchdog->mask);
 			pr_warn("                      '%s' cs_nsec: %lld cs_now: %llx cs_last: %llx mask: %llx\n",
 				cs->name, cs_nsec, csnow, cslast, cs->mask);
+			cs_wd_msec = div_u64_rem(cs_nsec - wd_nsec, 1000U * 1000U, &wd_rem);
+			wd_msec = div_u64_rem(wd_nsec, 1000U * 1000U, &wd_rem);
+			pr_warn("                      Clocksource '%s' skewed %lld ns (%lld ms) over watchdog '%s' interval of %lld ns (%lld ms)\n",
+				cs->name, cs_nsec - wd_nsec, cs_wd_msec, watchdog->name, wd_nsec, wd_msec);
 			if (curr_clocksource == cs)
 				pr_warn("                      '%s' is current clocksource.\n", cs->name);
 			else if (curr_clocksource)
-- 
2.31.1.189.g2e36527f23

