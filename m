Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8E5739026
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjFUTgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjFUTgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:36:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374E61733
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:36:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687376168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nZqMtAcS8VE7tIXvGLTC8A1h+3EE65bl6ekyCp5H6nE=;
        b=edZtbxQKMlMbfky1+A1uvsHHfJW4mtx+mN+MXCy8mFoMH2gBgQZnFqRYNFssbhcl9ON88z
        Yah3rwHzhfKdnzuECgNyILiS0ZiCfre3EuTk+oy9nHPo7mIj0NUjRS+EuvlAqMAiuPK1EQ
        oUgHMGkEkhSfOXlURm3dcGNX4Y8OShRDinE8SOXOZDOR28Luwwhxbm3U8XV0aQGHLnR//Z
        21V3rvwnZNRCV8OYi+Qe1NujxaKMIF5Et08orzlZK7xcWYUGZboCvfJCQioC6jeWa5iT0H
        8oXC8kqyiHMQqg5npSXM0mLkFlY8yhUr8XPWObRCnD4Zq+XaPJdiBbFCLTrNhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687376168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nZqMtAcS8VE7tIXvGLTC8A1h+3EE65bl6ekyCp5H6nE=;
        b=K4YtI9ys6WQI2Pyd2oja4BYr1EH3zLzFlQ6DB91LbOWMGb7DribLaS7pWXIlr9h5/MV75K
        Hcu9jB2RvjRb1wAg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v6.4
Message-ID: <168737611661.277769.2194490737572202840.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Wed, 21 Jun 2023 21:36:08 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-20=
23-06-21

up to:  13bb06f8dd42: tick/common: Align tick period during sched_timer setup


A single regression fix for a regression fix:

  For a long time the tick was aligned to clock MONOTONIC so that the tick
  event happened at a multiple of nanoseconds per tick starting from clock
  MONOTONIC =3D 0.

  At some point this changed as the refined jiffies clocksource which is
  used during boot before the TSC or other clocksources becomes usable, was
  adjusted with a boot offset, so that time 0 is closer to the point where
  the kernel starts.

  This broke the assumption in the tick code that when the tick setup
  happens early on ktime_get() will return a multiple of nanoseconds per
  tick. As a consequence applications which aligned their periodic
  execution so that it does not collide with the tick were not longer
  guaranteed that the tick period starts from time 0.

  The fix for this regression was to realign the tick when it is initially
  set up to a multiple of tick periods. That works as long as the
  underlying tick device supports periodic mode, but breaks under certain
  conditions when the tick device supports only one shot mode.

  Depending on the offset, the alignment delta to clock MONOTONIC can get
  in a range where the minimal programming delta of the underlying clock
  event device is larger than the calculated delta to the next tick. This
  results in a boot hang as the tick code tries to play catch up, but as
  the tick never fires jiffies are not advanced so it keeps trying for
  ever.

  Solve this by moving the tick alignement into the NOHZ / HIGHRES
  enablement code because at that point it is guaranteed that the
  underlying clocksource is high resolution capable and not longer
  depending on the tick.

  This is far before user space starts, so at the point where applications
  try to align their timers, the old behaviour of the tick happening at a
  multiple of nanoseconds per tick starting from clock MONOTONIC =3D 0 is
  restored.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      tick/common: Align tick period during sched_timer setup


 kernel/time/tick-common.c | 13 +------------
 kernel/time/tick-sched.c  | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 65b8658da829..e9138cd7a0f5 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -218,19 +218,8 @@ static void tick_setup_device(struct tick_device *td,
 		 * this cpu:
 		 */
 		if (tick_do_timer_cpu =3D=3D TICK_DO_TIMER_BOOT) {
-			ktime_t next_p;
-			u32 rem;
-
 			tick_do_timer_cpu =3D cpu;
-
-			next_p =3D ktime_get();
-			div_u64_rem(next_p, TICK_NSEC, &rem);
-			if (rem) {
-				next_p -=3D rem;
-				next_p +=3D TICK_NSEC;
-			}
-
-			tick_next_period =3D next_p;
+			tick_next_period =3D ktime_get();
 #ifdef CONFIG_NO_HZ_FULL
 			/*
 			 * The boot CPU may be nohz_full, in which case set
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 52254679ec48..42c0be3080bd 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -161,8 +161,19 @@ static ktime_t tick_init_jiffy_update(void)
 	raw_spin_lock(&jiffies_lock);
 	write_seqcount_begin(&jiffies_seq);
 	/* Did we start the jiffies update yet ? */
-	if (last_jiffies_update =3D=3D 0)
+	if (last_jiffies_update =3D=3D 0) {
+		u32 rem;
+
+		/*
+		 * Ensure that the tick is aligned to a multiple of
+		 * TICK_NSEC.
+		 */
+		div_u64_rem(tick_next_period, TICK_NSEC, &rem);
+		if (rem)
+			tick_next_period +=3D TICK_NSEC - rem;
+
 		last_jiffies_update =3D tick_next_period;
+	}
 	period =3D last_jiffies_update;
 	write_seqcount_end(&jiffies_seq);
 	raw_spin_unlock(&jiffies_lock);

