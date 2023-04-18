Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CE06E61BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjDRM1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjDRM1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:27:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A669020
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:26:54 -0700 (PDT)
Date:   Tue, 18 Apr 2023 14:26:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681820801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FqUkCjI9Mr4UILiIZm8CkQghAtfwUwan4upLdsoWU00=;
        b=XZCTq6LE1G+yciJO4kkfRVEAfFAeZE7nrI8z+Dh+O/lMDTr0YoepfNWfDxQ6Fqm7Z+tStJ
        96mQTG7/wu3/uKC512CHUpWq25rGf5h79ujTEUjCj6dSTr6mCCp/MJxzZiRak+WxXZQ/ku
        7Xa493KJmgCnOu6l6fs5DhY8Slk3lbULWfjgNl6nEOXyrhCcTFFDQxhT87nl/v1cmoW8yv
        DcrfVVX9hyGyFhxhzcblp+6etyRd7nKKHAPPWdOENefzJ21kCuHMYZ4W0vuOa0HXsTcjzn
        hA+yEAJ6wSbeLukxaQtqIgPnu8zoB0wbOYkMBarar0jwKWxVe9MG14eOwFa0Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681820801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FqUkCjI9Mr4UILiIZm8CkQghAtfwUwan4upLdsoWU00=;
        b=D5xGMZhIC3TRcsju2YKfLuBS0K+Vt7c+TQfwcD6r/DFJUSdxKYRJ/sOYUBEfxmHB15FZOK
        LhZxFuEP3rAulMBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Gusenleitner Klaus <gus@keba.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH] timekeeping: Align tick_sched_timer() with the HZ tick.
Message-ID: <20230418122639.ikgfvu3f@linutronix.de>
References: <20230406095735.0_14edn3@linutronix.de>
 <20230406105529.GB392176@hirez.programming.kicks-ass.net>
 <87mt3lqnde.ffs@tglx>
 <20230406150254.ZrawA2Y-@linutronix.de>
 <87jzypq6gq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzypq6gq.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Align the tick timer with CLOCK_MONOTONIC ensuring that it is always a
multiple of 1000/CONFIG_HZ ms.

Reported-by: Gusenleitner Klaus <gus@keba.com>
Link: https://lore.kernel.org/20230406095735.0_14edn3@linutronix.de
Fixes: 857baa87b6422 ("sched/clock: Enable sched clock early")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/tick-common.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 46789356f856e..65b8658da829e 100644
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
-- 
2.40.0
