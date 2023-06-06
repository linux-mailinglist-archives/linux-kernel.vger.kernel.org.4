Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC3772465F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbjFFOiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbjFFOh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:37:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3070172E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:39 -0700 (PDT)
Message-ID: <20230606142031.705286109@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dI0D1Wo/Od6DcD7Ru+BANLzwyGF+XR8DfEoK3hFuF2Q=;
        b=Yk/DXFdlqLfDQyfx0BKzMlN/bE3cA9fTYL2SSewfi6g0ICus4972urAWOD18WUFrh8QElC
        J2cZ+8OHKTjsths3W8x50BG9w+ENc2CAv0z9OyxhrYV9U2Khyusw5ZL++NT1iWc3Iw/NoW
        U7GHdOSNqa54uenn6q2mW4QdYxaUIH3QWvztjseXzYm93xO3le3AajEnSDX02FtCwZzB5H
        7ta7T0VkQEUzZ4AVGTQ5cTQG5WGT2B3OV/cOVbp7uyRGicCMiZfpp+wBEnp2KxryAAA8if
        PJvMUwjuhbMdyuEf4D+zN9MMG1vngzz37BKBmzPQrDgwUdGEgP7QnKYvj/Z12w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dI0D1Wo/Od6DcD7Ru+BANLzwyGF+XR8DfEoK3hFuF2Q=;
        b=SNm/mWkMVZs8Rfv0eVLM0rOkYdYVZZ281k1zAaoHe4TG53Ioth7F4d1QqGFxgdGx53QrZA
        udmiyD8CV7sID9CQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [patch 12/45] posix-cpu-timers: Simplify posix_cpu_timer_set()
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:37 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid the late sighand lock/unlock dance when a timer is not armed to
enforce reevaluation of the timer base so that the process wide CPU timer
sampling can be disabled.

Do it right at the point where the arming decision is made which already
has sighand locked.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -720,10 +720,14 @@ static int posix_cpu_timer_set(struct k_
 	/*
 	 * Arm the timer if it is not disabled, the new expiry value has
 	 * not yet expired and the timer requires signal delivery.
-	 * SIGEV_NONE timers are never armed.
+	 * SIGEV_NONE timers are never armed. In case the timer is not
+	 * armed, enforce the reevaluation of the timer base so that the
+	 * process wide cputime counter can be disabled eventually.
 	 */
 	if (!sigev_none && new_expires && now < new_expires)
 		arm_timer(timer, p);
+	else
+		trigger_base_recalc_expires(timer, p);
 
 	unlock_task_sighand(p, &flags);
 	/*
@@ -742,30 +746,14 @@ static int posix_cpu_timer_set(struct k_
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1;
 
-	if (!sigev_none && now >= new_expires) {
-		if (new_expires != 0) {
-			/*
-			 * The designated time already passed, so we notify
-			 * immediately, even if the thread never runs to
-			 * accumulate more time on this clock.
-			 */
-			cpu_timer_fire(timer);
-		}
-
-		/*
-		 * Make sure we don't keep around the process wide cputime
-		 * counter or the tick dependency if they are not necessary.
-		 */
-		sighand = lock_task_sighand(p, &flags);
-		if (!sighand)
-			goto out;
-
-		if (!cpu_timer_queued(ctmr))
-			trigger_base_recalc_expires(timer, p);
-
-		unlock_task_sighand(p, &flags);
-	}
- out:
+	/*
+	 * If the new expiry time was already in the past the timer was not
+	 * queued. Fire it immediately even if the thread never runs to
+	 * accumulate more time on this clock.
+	 */
+	if (!sigev_none && new_expires && now >= new_expires)
+		cpu_timer_fire(timer);
+out:
 	rcu_read_unlock();
 	if (old)
 		old->it_interval = ns_to_timespec64(old_incr);

