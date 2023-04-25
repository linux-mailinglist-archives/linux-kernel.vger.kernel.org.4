Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BE96EE7C3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjDYSuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbjDYSts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:49:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D36F18E99
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:21 -0700 (PDT)
Message-ID: <20230425183313.619897296@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=72SNJQWXyxgouEM/8YH8e+/nPmMmqp+iUvwo4PZXODk=;
        b=nlm2jWMZV/r36zj9M8Eg5puJ5X/Xt6zipxQcxaq1MvPaWAbpRAsU/4hOTRMU7mq9Kxg3ym
        JuF5FcbDqWL8w1QcIUPINEGZy5jc+7nIzNNoioIdn0ifnZ9bmjWvR+VuPhAvsvbyTv9l76
        yzLmQ3ApkiiP1lKRhMH+n3qr/rieZLWuchmmwJ6iaDxlOSTZ62Z6eXLbSMXuyEocQFxgkd
        khP4P2y+Cs9luJKLC76nJCkxPQMymEm3Bzxfr8ZQfUhjgchUU28k1Mjt0NpNsafUuOKjkU
        nkU4jJQc0MA2gvqy0b1X2oJ4RX6qx/KjvPOxPykNav4LoK4fAq0rd1fU/bMCUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=72SNJQWXyxgouEM/8YH8e+/nPmMmqp+iUvwo4PZXODk=;
        b=GPz3Z/f25iG/vwH5IMEnbmRU54ovrir0UJdTos9D2M6jhxmcR1fCgYvqRhT0PaDaUMY2Nx
        zERvioRAZs9SSHDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [patch 15/20] posix-timers: Add proper comments in do_timer_create()
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 25 Apr 2023 20:49:19 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment about timer lifetime at the end of the function is misplaced
and uncomprehensible.

Make it understandable and put it at the right place. Add a new comment
about the visibility of the new timer ID to user space.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -528,12 +528,17 @@ static int do_timer_create(clockid_t whi
 	new_timer->sigq->info.si_tid   = new_timer->it_id;
 	new_timer->sigq->info.si_code  = SI_TIMER;
 
-	if (copy_to_user(created_timer_id,
-			 &new_timer_id, sizeof (new_timer_id))) {
+	if (copy_to_user(created_timer_id, &new_timer_id, sizeof (new_timer_id))) {
 		error = -EFAULT;
 		goto out;
 	}
-
+	/*
+	 * After succesful copy out, the timer ID is visible to user space
+	 * now but not yet valid because new_timer::signal is still NULL.
+	 *
+	 * Complete the initialization with the clock specific create
+	 * callback.
+	 */
 	error = kc->timer_create(new_timer);
 	if (error)
 		goto out;
@@ -543,14 +548,11 @@ static int do_timer_create(clockid_t whi
 	WRITE_ONCE(new_timer->it_signal, current->signal);
 	list_add(&new_timer->list, &current->signal->posix_timers);
 	spin_unlock_irq(&current->sighand->siglock);
-
-	return 0;
 	/*
-	 * In the case of the timer belonging to another task, after
-	 * the task is unlocked, the timer is owned by the other task
-	 * and may cease to exist at any time.  Don't use or modify
-	 * new_timer after the unlock call.
+	 * After unlocking sighand::siglock @new_timer is subject to
+	 * concurrent removal and cannot be touched anymore
 	 */
+	return 0;
 out:
 	posix_timer_unhash_and_free(new_timer);
 	return error;

