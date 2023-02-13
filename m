Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF7E694FC1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjBMSs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjBMSsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:48:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18951CAE9;
        Mon, 13 Feb 2023 10:48:34 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:48:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676314113;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9gBKdjlSTAABDh+Tqq2iFzBMT5CiqULyiZe+8Xzhd+4=;
        b=h9iUCx9rOkdwGAVmkVWAoYPw1ZpOjodJdnCQFGNV5AabEI03uQ8eQvbAEJybquYjT8uxWy
        YqeYrLAJIu8xAUY8OHvYSh+pog036AmZgcRAYE4KCJOWyLchfZXspGSQ1YsS/pHauFM70K
        MBU4NiEUZtGfCIIwJte+dYVnBCwdkIVH4jNCmPQK2+WVp/sCl7Dx5xVTc2KAcbEEzl5I7h
        71neGWFJYdYAIQjWkcDV8LRJpK1aNvjmuWPB3CwQrCsqcuv2Z1GhEce/tmXpiBEyWPHQ0T
        P+FHcr0rvUvGTiUXwdrlXnKFFkFs7rXi0TxXBY9LujchOh8/Nqk0iCL2qZ8oCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676314113;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9gBKdjlSTAABDh+Tqq2iFzBMT5CiqULyiZe+8Xzhd+4=;
        b=bRGzLeX8RE58rGsyMOcpK3X5J8WzvYB7lv727skzMNZ+4C4+UHUHNhKOhRLYlfSy1UwRDs
        jGPWStpeM5UjyiAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Improve "skew is too large" messages
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Feng Tang <feng.tang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167631411316.4906.13551838694214324654.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     dd029269947a32047b8ce1f8513b0b3b13f0df32
Gitweb:        https://git.kernel.org/tip/dd029269947a32047b8ce1f8513b0b3b13f0df32
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 13 Dec 2022 16:42:15 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 05 Jan 2023 12:33:11 -08:00

clocksource: Improve "skew is too large" messages

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
index b599149..fc486cd 100644
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
