Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197B1682A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjAaK3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjAaK3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:29:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E1E2DE4A;
        Tue, 31 Jan 2023 02:29:49 -0800 (PST)
Date:   Tue, 31 Jan 2023 10:29:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675160988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mi0xskgCf7FEoeugCADqGqRpxrjV8N9iSMOx8TKwgyY=;
        b=o7pkl7BmSceGIKBIFG31b7hTLaYQumkypW5o134JypcNjctxCAr0wR1ByOi91tU76crIJV
        SyGy8x1MsBCqjc2UGUNm5HavPduD/O4w7rL02bKZpk8Dzj34kdK/EMJhmN3yIzvCglgav2
        DhHPn5xrSUKnGLEBCMR6JgPeexa1tDmFy9VU3v+wUlAPHbzzLzYbRCs91Wif0vOz5E+Sst
        iYXR9INJHX8WJqJ8/Vsd4eBAi7PG/Oj0/1/gyw4rdv5prjHrz+u1bOg9YUvaoqJiHN//oY
        UcvD2GL/sin87SPiauMRj3YH4q7RYV4TEK4RfX1zRCRannJ8n1A78osCsXulwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675160988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mi0xskgCf7FEoeugCADqGqRpxrjV8N9iSMOx8TKwgyY=;
        b=rK0ix6KNPot4u+gCmovCg7/jzTNOV/pFJQfItjTIeJ25do+1bVazxUF8waEjCXO/lDBOOY
        J6cmpQOKFcCRPFBQ==
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Ignore slack time for RT tasks in
 schedule_hrtimeout_range()
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230123173206.6764-3-dave@stgolabs.net>
References: <20230123173206.6764-3-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <167516098750.4906.3310557441657379579.tip-bot2@tip-bot2>
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

Commit-ID:     0c52310f260014d95c1310364379772cb74cf82d
Gitweb:        https://git.kernel.org/tip/0c52310f260014d95c1310364379772cb74cf82d
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Mon, 23 Jan 2023 09:32:06 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 31 Jan 2023 11:23:07 +01:00

hrtimer: Ignore slack time for RT tasks in schedule_hrtimeout_range()

While in theory the timer can be triggered before expires + delta, for the
cases of RT tasks they really have no business giving any lenience for
extra slack time, so override any passed value by the user and always use
zero for schedule_hrtimeout_range() calls. Furthermore, this is similar to
what the nanosleep(2) family already does with current->timer_slack_ns.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230123173206.6764-3-dave@stgolabs.net

---
 kernel/time/hrtimer.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 667b713..e8c0829 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2272,7 +2272,7 @@ void __init hrtimers_init(void)
 /**
  * schedule_hrtimeout_range_clock - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t)
+ * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
  * @mode:	timer mode
  * @clock_id:	timer clock to be used
  */
@@ -2299,6 +2299,13 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 		return -EINTR;
 	}
 
+	/*
+	 * Override any slack passed by the user if under
+	 * rt contraints.
+	 */
+	if (rt_task(current))
+		delta = 0;
+
 	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 	hrtimer_sleeper_start_expires(&t, mode);
@@ -2318,7 +2325,7 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
 /**
  * schedule_hrtimeout_range - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t)
+ * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
  * @mode:	timer mode
  *
  * Make the current task sleep until the given expiry time has
@@ -2326,7 +2333,8 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
  * the current task state has been set (see set_current_state()).
  *
  * The @delta argument gives the kernel the freedom to schedule the
- * actual wakeup to a time that is both power and performance friendly.
+ * actual wakeup to a time that is both power and performance friendly
+ * for regular (non RT/DL) tasks.
  * The kernel give the normal best effort behavior for "@expires+@delta",
  * but may decide to fire the timer earlier, but no earlier than @expires.
  *
