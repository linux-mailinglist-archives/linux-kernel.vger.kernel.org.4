Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2DE69BDFC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 00:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjBRXma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 18:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjBRXm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 18:42:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542C313D69
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 15:42:27 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676763745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=192d4j78BdgD8dV3Oaf5bDl5lKhXH9kNsVC6xEfm6Vo=;
        b=fhYiysIAwJSLoB0R85KulOIPH1YXYmwhKJvbcG3pmvg7vDWnztuvIb4uOEWbLDftomTbSm
        eqvSPs3tGtx36TWFRSoPxZn0IJw/ioyk21lCFh19FWYuXFJpzvFeLVAPCpT7mk3aT7x7EH
        9/xok3f6uEDagq81H0b6vcbDrv6QDBC3vfmCJKcCag101ISk8TNNAxu3e1TplfYOr1C6Ii
        dsLEq1zqt7rzuxx8EogHe24BPA2Wl1EfqTW9INEFH8v21Dw9X2bOid+yKooiMMoL5plyPP
        mmtzBYgdhmhUQ4rrq0CbDP/fq4my7JsHpxEabhzQnXe1BSvZTe4xOvpmZK3/8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676763745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=192d4j78BdgD8dV3Oaf5bDl5lKhXH9kNsVC6xEfm6Vo=;
        b=FBjwFGx52gYluHJtqRyLXJPxt+tBrRP53imHX1O2SrbZDl9irQYUmUKINKpXpOLTTs7Vkp
        Zr4xi9aIgL+m6gCg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v6.2
References: <167676366161.269954.1941292974323519398.tglx@xen13>
Message-ID: <167676366307.269954.6868386581301990072.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 19 Feb 2023 00:42:25 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-20=
23-02-19

up to:  d125d1349abe: alarmtimer: Prevent starvation by small intervals and S=
IG_IGN


A fix for a long standing issue in the alarmtimer code:

 Posix-timers armed with a short interval with an ignored signal result
 in an unpriviledged DoS. Due to the ignored signal the timer switches
 into self rearm mode. This issue had been "fixed" before but a rework of
 the alarmtimer code 5 years ago lost that workaround.

 There is no real good solution for this issue, which is also worked around
 in the core posix-timer code in the same way, but it certainly moved way
 up on the ever growing todo list.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      alarmtimer: Prevent starvation by small intervals and SIG_IGN


 kernel/time/alarmtimer.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 5897828b9d7e..7e5dff602585 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -470,11 +470,35 @@ u64 alarm_forward(struct alarm *alarm, ktime_t now, kti=
me_t interval)
 }
 EXPORT_SYMBOL_GPL(alarm_forward);
=20
-u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
+static u64 __alarm_forward_now(struct alarm *alarm, ktime_t interval, bool t=
hrottle)
 {
 	struct alarm_base *base =3D &alarm_bases[alarm->type];
+	ktime_t now =3D base->get_ktime();
+
+	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && throttle) {
+		/*
+		 * Same issue as with posix_timer_fn(). Timers which are
+		 * periodic but the signal is ignored can starve the system
+		 * with a very small interval. The real fix which was
+		 * promised in the context of posix_timer_fn() never
+		 * materialized, but someone should really work on it.
+		 *
+		 * To prevent DOS fake @now to be 1 jiffie out which keeps
+		 * the overrun accounting correct but creates an
+		 * inconsistency vs. timer_gettime(2).
+		 */
+		ktime_t kj =3D NSEC_PER_SEC / HZ;
+
+		if (interval < kj)
+			now =3D ktime_add(now, kj);
+	}
+
+	return alarm_forward(alarm, now, interval);
+}
=20
-	return alarm_forward(alarm, base->get_ktime(), interval);
+u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
+{
+	return __alarm_forward_now(alarm, interval, false);
 }
 EXPORT_SYMBOL_GPL(alarm_forward_now);
=20
@@ -551,9 +575,10 @@ static enum alarmtimer_restart alarm_handle_timer(struct=
 alarm *alarm,
 	if (posix_timer_event(ptr, si_private) && ptr->it_interval) {
 		/*
 		 * Handle ignored signals and rearm the timer. This will go
-		 * away once we handle ignored signals proper.
+		 * away once we handle ignored signals proper. Ensure that
+		 * small intervals cannot starve the system.
 		 */
-		ptr->it_overrun +=3D alarm_forward_now(alarm, ptr->it_interval);
+		ptr->it_overrun +=3D __alarm_forward_now(alarm, ptr->it_interval, true);
 		++ptr->it_requeue_pending;
 		ptr->it_active =3D 1;
 		result =3D ALARMTIMER_RESTART;

