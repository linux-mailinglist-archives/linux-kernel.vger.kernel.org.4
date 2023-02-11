Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB192692EE4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 07:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBKGpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 01:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjBKGpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 01:45:34 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B65835AF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 22:45:33 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-52ed582a847so30514757b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 22:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/B9GAfQBYBoDhp2FsGVxBOlSI/O26/vnD5AYsxIyzR8=;
        b=Yv539ZuxLzEXoqlnYNJ4YBJiTtbId/KwCDAMas26JG8dvIgIIHPaSZWDtR/CzvuUVP
         ptyMI+e2fx2SyiZXjqX44ub7akJo68csVGHFXhCJ9OJSRg2dGOtwAOb9egWJH7BL1taq
         tee4lpO0rn+caE1sS9lo3uI+UEldjkVwUy5naRuVeFA9fQqRx4ytRbM3bPMFOf8OB+Tk
         ezMJj+jH/3XwS2q7I+JFN6GSE3uL55mgfu5suJRcLYUwOUN3Wk2QWwx9hdSmIFjL46EL
         jd+Bdc2mWz965ZkWRd/cv60cFAjY3hRX9EARTZw9xzPrrKg4Xo26PiVbaOPlceRez8Ce
         d/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/B9GAfQBYBoDhp2FsGVxBOlSI/O26/vnD5AYsxIyzR8=;
        b=K9qXN4qWZ2zthJmCsXKfaHBZ0ppF78KFOXNCTcvoESbA/Puqf5FB3cLloEhJkYOa+d
         LpY7rjKw7MFAYLEFrcKHIACgsM5Cuahn27JYU0DCFp8Kk45UH31epdGjt4gqgd+qILcg
         xTPv5+VtGSNSzEgfqTbZuusl1k81DjFK+piX/SmS61C+Z8tmPhtAAhcuEWrmcyERlZ9a
         b/uys26KPhxv9rkAy8ByNX1Ti3KnsA6MG6Rd6YyzulROSTCGdkhf94RmgmFjTaz+n+kI
         eVDcw95EmAg1lmwPI1HUlifxRRx7itfJwTP3Yt75G0gUjylAF67CEZEpq7MLiHYzbZXU
         CQoQ==
X-Gm-Message-State: AO0yUKWuGvSLEW4gcj5g4zuUE9OuT3aBcG2WqiG95cgIMOFFaxbUHbMu
        xPI7wxeY9f2TZQ5d5STBUKFImWt0eYV/MFTDZlYtwsdKRUrzgMVxZX7UlUvbZG8nLmfRpShxzzP
        EwTUIpqZ0oTllDu0FjLeoZe6BLDR8AjQn7Pr4FJR3PY9x95VpJib1+Cssfpgnd9bDbSHZIwE=
X-Google-Smtp-Source: AK7set+ki8mezg9O1UkdIzgf8OnruyYeeAJKTirGl1WuhBHfTqZq2qa3dc8OFKVV1QmBe/8AxAWFkaIMjgIa
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:a97:0:b0:52e:c29d:7328 with SMTP id
 145-20020a810a97000000b0052ec29d7328mr12ywk.7.1676097931564; Fri, 10 Feb 2023
 22:45:31 -0800 (PST)
Date:   Sat, 11 Feb 2023 06:45:26 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230211064527.3481754-1-jstultz@google.com>
Subject: [RFC][PATCH 1/2] time: alarmtimer: Fix erroneous case of using 0 as
 an "invalid" initialization value
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael reported seeing an error where alarmtimers would
occasionally not wake the system up.

It was found that in alarmtimer_suspend() it was exiting via
the:
    if (min == 0)
        return 0;
check. This logic was from one of the early versions of the
original alarmtimer patch, where we initialized min to 0, and
then this check would exit early if we found no timers to expire
(leaving min still at 0).

However, its possible for an alarmtimer to expire as we are
checking it, leaving the calculated delta to be zero, and thus
setting min to zero.

This is the result of my using 0 as an invalid time value which
is clearly erroneous. Instead KTIME_MAX should have been used.

This patch, split out from a change originally suggested by
Thomas Gleixner, changes the logic to instead use KTIME_MAX.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michael <michael@mipisi.de>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: kernel-team@android.com
Reported-by: Michael <michael@mipisi.de>
Reported-by: Michael Trimarchi <michael@amarulasolutions.com>
Fixes: ff3ead96d17f ("timers: Introduce in-kernel alarm-timer interface")
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.1909021247250.3955@nanos.tec.linutronix.de/
[jstultz: Forward ported to 6.2-rc, and split out just the
          KTIME_MAX change]
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/time/alarmtimer.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 5897828b9d7e..f7b2128f64e2 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -251,7 +251,7 @@ static int alarmtimer_suspend(struct device *dev)
 	min = freezer_delta;
 	expires = freezer_expires;
 	type = freezer_alarmtype;
-	freezer_delta = 0;
+	freezer_delta = KTIME_MAX;
 	spin_unlock_irqrestore(&freezer_delta_lock, flags);
 
 	rtc = alarmtimer_get_rtcdev();
@@ -271,13 +271,14 @@ static int alarmtimer_suspend(struct device *dev)
 		if (!next)
 			continue;
 		delta = ktime_sub(next->expires, base->get_ktime());
-		if (!min || (delta < min)) {
+		if (delta < min) {
 			expires = next->expires;
 			min = delta;
 			type = i;
 		}
 	}
-	if (min == 0)
+	/* No timers to expire */
+	if (min == KTIME_MAX)
 		return 0;
 
 	if (ktime_to_ns(min) < 2 * NSEC_PER_SEC) {
@@ -503,7 +504,7 @@ static void alarmtimer_freezerset(ktime_t absexp, enum alarmtimer_type type)
 	delta = ktime_sub(absexp, base->get_ktime());
 
 	spin_lock_irqsave(&freezer_delta_lock, flags);
-	if (!freezer_delta || (delta < freezer_delta)) {
+	if (delta < freezer_delta) {
 		freezer_delta = delta;
 		freezer_expires = absexp;
 		freezer_alarmtype = type;
-- 
2.39.1.581.gbfd45094c4-goog

