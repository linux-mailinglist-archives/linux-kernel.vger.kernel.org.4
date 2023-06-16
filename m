Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13EC73386B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjFPSxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345156AbjFPSx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:53:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8AE3A9E;
        Fri, 16 Jun 2023 11:53:22 -0700 (PDT)
Date:   Fri, 16 Jun 2023 18:53:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686941600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vwwe934FIcaw97RpxpbJdTmS2f0r5fdZZt43SX5cE2I=;
        b=BojAA2eXo0THrTKJEZbIpojWx9evZe7MU47eHPGhLHbaPCA4AaV/euHLRXdBNIBytdAPDM
        epV2Ac9WAcLrmg9xXoYQGN8uO4mnr/MXB8C9HIOrQX3uoY4Y7gpn3AbYqOPvyxM3k3MGk1
        hKM2HBB1D58LhPQprApVrNrOTsN99rYYi4VQ3wCpgwQkRqj5BZu+I2JIPuy+YiEot603rd
        jNpoH9+HU1OEttuG8EkrXrJyF7Hvog+3onJGDwonYcK7zOJta9yNdMD8mWxZKRWoOoj5HL
        2SjUWR3GxICjTipPDufuqQk5tte59lho7hq6I0Yk34XFgfRT0tLzrg7nxm4v4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686941600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vwwe934FIcaw97RpxpbJdTmS2f0r5fdZZt43SX5cE2I=;
        b=tkIMnXU+b12oBdoyl2GFlPd9wmGyB4UoBkOZvEp7hql83pwsz7qXRQwXu8zxL4obV5XfdV
        3v5QnXA07FHsZLBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] tick/common: Align tick period during sched_timer setup
Cc:     Mathias Krause <minipli@grsecurity.net>,
        "Bhatnagar, Rishabh" <risbhat@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Richard W.M. Jones" <rjones@redhat.com>,
        SeongJae Park <sj@kernel.org>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <5a56290d-806e-b9a5-f37c-f21958b5a8c0@grsecurity.net>
References: <5a56290d-806e-b9a5-f37c-f21958b5a8c0@grsecurity.net>
MIME-Version: 1.0
Message-ID: <168694159988.404.1902283865304443546.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     13bb06f8dd42071cb9a49f6e21099eea05d4b856
Gitweb:        https://git.kernel.org/tip/13bb06f8dd42071cb9a49f6e21099eea05d4b856
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Jun 2023 11:18:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Jun 2023 20:45:28 +02:00

tick/common: Align tick period during sched_timer setup

The tick period is aligned very early while the first clock_event_device is
registered. At that point the system runs in periodic mode and switches
later to one-shot mode if possible.

The next wake-up event is programmed based on the aligned value
(tick_next_period) but the delta value, that is used to program the
clock_event_device, is computed based on ktime_get().

With the subtracted offset, the device fires earlier than the exact time
frame. With a large enough offset the system programs the timer for the
next wake-up and the remaining time left is too small to make any boot
progress. The system hangs.

Move the alignment later to the setup of tick_sched timer. At this point
the system switches to oneshot mode and a high resolution clocksource is
available. At this point it is safe to align tick_next_period because
ktime_get() will now return accurate (not jiffies based) time.

[bigeasy: Patch description + testing].

Fixes: e9523a0d81899 ("tick/common: Align tick period with the HZ tick.")
Reported-by: Mathias Krause <minipli@grsecurity.net>
Reported-by: "Bhatnagar, Rishabh" <risbhat@amazon.com>
Suggested-by: Mathias Krause <minipli@grsecurity.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
Tested-by: Mathias Krause <minipli@grsecurity.net>
Acked-by: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/5a56290d-806e-b9a5-f37c-f21958b5a8c0@grsecurity.net
Link: https://lore.kernel.org/12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com
Link: https://lore.kernel.org/r/20230615091830.RxMV2xf_@linutronix.de
---
 kernel/time/tick-common.c | 13 +------------
 kernel/time/tick-sched.c  | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 65b8658..e9138cd 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -218,19 +218,8 @@ static void tick_setup_device(struct tick_device *td,
 		 * this cpu:
 		 */
 		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
-			ktime_t next_p;
-			u32 rem;
-
 			tick_do_timer_cpu = cpu;
-
-			next_p = ktime_get();
-			div_u64_rem(next_p, TICK_NSEC, &rem);
-			if (rem) {
-				next_p -= rem;
-				next_p += TICK_NSEC;
-			}
-
-			tick_next_period = next_p;
+			tick_next_period = ktime_get();
 #ifdef CONFIG_NO_HZ_FULL
 			/*
 			 * The boot CPU may be nohz_full, in which case set
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 5225467..42c0be3 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -161,8 +161,19 @@ static ktime_t tick_init_jiffy_update(void)
 	raw_spin_lock(&jiffies_lock);
 	write_seqcount_begin(&jiffies_seq);
 	/* Did we start the jiffies update yet ? */
-	if (last_jiffies_update == 0)
+	if (last_jiffies_update == 0) {
+		u32 rem;
+
+		/*
+		 * Ensure that the tick is aligned to a multiple of
+		 * TICK_NSEC.
+		 */
+		div_u64_rem(tick_next_period, TICK_NSEC, &rem);
+		if (rem)
+			tick_next_period += TICK_NSEC - rem;
+
 		last_jiffies_update = tick_next_period;
+	}
 	period = last_jiffies_update;
 	write_seqcount_end(&jiffies_seq);
 	raw_spin_unlock(&jiffies_lock);
