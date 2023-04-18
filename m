Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABB76E65A1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjDRNOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjDRNON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:14:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D085A1562E;
        Tue, 18 Apr 2023 06:14:12 -0700 (PDT)
Date:   Tue, 18 Apr 2023 13:14:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681823648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/GXGqGs7T+Ve8kmreWNRb9Lyte+TG2+q4hyj5YfKx4g=;
        b=eR6/V/FZPoSXwSdj2suTN78MOzvTVGGcQFyPbHuq7Qexwet1C2m6uGmiuCiWbSRxdq271J
        vg8k4CgH0BDXsAR/6qeBQr/bWaqbn3FaNMfU7lCpxUl/3f5fCvvopDvE1CmZ5UEZfP1jAV
        xKXNk9CZJk7Fo+cPZZRqsxQy++6lz62llQG2Zo4IoQfUU/tSpIwVkix9VM0y8VlwlTgYUW
        APf+bTeEekaSGjjQhXnX0QvQuint1b0VBrn6uGBDiwS3LcSr8lBFDAB4BRH3uDwcYmADLX
        9nJxoKZQKRlf3PGG5oygeHhk+rP/FJLNl4E+u0Bvo7FWVEEMejNFG3aQiQadQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681823648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/GXGqGs7T+Ve8kmreWNRb9Lyte+TG2+q4hyj5YfKx4g=;
        b=JKmIDZMh0U5+EdmbwxKJUkW/6LPDzL+NvKw1UdNJf7lN1RjhnkArXmR1CVa7rs0uyem1a4
        HqYlE9fqCoCLyKAw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/common: Align tick period with the HZ tick.
Cc:     Gusenleitner Klaus <gus@keba.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230406095735.0_14edn3@linutronix.de>
References: <20230406095735.0_14edn3@linutronix.de>
MIME-Version: 1.0
Message-ID: <168182364782.404.4164105102665678709.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e9523a0d81899361214d118ad60ef76f0e92f71d
Gitweb:        https://git.kernel.org/tip/e9523a0d81899361214d118ad60ef76f0e92f71d
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 18 Apr 2023 14:26:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Apr 2023 15:06:50 +02:00

tick/common: Align tick period with the HZ tick.

With HIGHRES enabled tick_sched_timer() is programmed every jiffy to
expire the timer_list timers. This timer is programmed accurate in
respect to CLOCK_MONOTONIC so that 0 seconds and nanoseconds is the
first tick and the next one is 1000/CONFIG_HZ ms later. For HZ=250 it is
every 4 ms and so based on the current time the next tick can be
computed.

This accuracy broke since the commit mentioned below because the jiffy
based clocksource is initialized with higher accuracy in
read_persistent_wall_and_boot_offset(). This higher accuracy is
inherited during the setup in tick_setup_device(). The timer still fires
every 4ms with HZ=250 but timer is no longer aligned with
CLOCK_MONOTONIC with 0 as it origin but has an offset in the us/ns part
of the timestamp. The offset differs with every boot and makes it
impossible for user land to align with the tick.

Align the tick period with CLOCK_MONOTONIC ensuring that it is always a
multiple of 1000/CONFIG_HZ ms.

Fixes: 857baa87b6422 ("sched/clock: Enable sched clock early")
Reported-by: Gusenleitner Klaus <gus@keba.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/20230406095735.0_14edn3@linutronix.de
Link: https://lore.kernel.org/r/20230418122639.ikgfvu3f@linutronix.de
---
 kernel/time/tick-common.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 4678935..65b8658 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -218,9 +218,19 @@ static void tick_setup_device(struct tick_device *td,
 		 * this cpu:
 		 */
 		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
+			ktime_t next_p;
+			u32 rem;
+
 			tick_do_timer_cpu = cpu;
 
-			tick_next_period = ktime_get();
+			next_p = ktime_get();
+			div_u64_rem(next_p, TICK_NSEC, &rem);
+			if (rem) {
+				next_p -= rem;
+				next_p += TICK_NSEC;
+			}
+
+			tick_next_period = next_p;
 #ifdef CONFIG_NO_HZ_FULL
 			/*
 			 * The boot CPU may be nohz_full, in which case set
