Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5046EE7C1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbjDYSuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjDYSte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:49:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BBA18E8C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:18 -0700 (PDT)
Message-ID: <20230425183313.514700292@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lgf6JYOTW6euMxMOYjqPPRc1RJSaBkir9GoWtN7e358=;
        b=NjeG5dGI+QXoQmwE0IVWJtdyZ1z2UxBAv2ePE70Sk9iqt0kU0RJCZYS+vfL+ULvVlgDSck
        p1fAQ5WvkVJVBoh5OdjoVBoz0qzKHxhoStFxbT2toucywWRQA47dq3DFrCHUvgl8szjEft
        VVaBbFOl2pCOy/kk9DrzAZmhQDlFNgJtPDogDZhyiERmao1ATKhgSdJfklNsRE9ws8Zt2d
        KQVWeS6WpkrbrUegZWJBrFNRRHPpFnM6fALs6Q0N4sFZ2b05whfBMwhgdhyc15H4s3OQ2w
        vhZ8pHSmSk9GFhpsP+9WmBX3h1h0btLQbcOU+q5W6kYoK5wOqBWbsNBp3cd6yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lgf6JYOTW6euMxMOYjqPPRc1RJSaBkir9GoWtN7e358=;
        b=zEkOlMO31FtCg9YakYE1jAgV2nRKOugoFvn2GddGck+moiFgeXzJkcBt67RYqcI3+iDC3G
        29o4RZBVzi+/J7Aw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [patch 13/20] posix-timers: Document sys_clock_settime() permissions in place
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 25 Apr 2023 20:49:16 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation of sys_clock_settime() permissions is at a random place
and mostly word salad.

Remove it and add a concise comment into sys_clock_settime().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -74,13 +74,6 @@ static const struct k_clock clock_realti
  *	    following: 1.) The k_itimer struct (sched.h) is used for
  *	    the timer.  2.) The list, it_lock, it_clock, it_id and
  *	    it_pid fields are not modified by timer code.
- *
- * Permissions: It is assumed that the clock_settime() function defined
- *	    for each clock will take care of permission checks.	 Some
- *	    clocks may be set able by any user (i.e. local process
- *	    clocks) others not.	 Currently the only set able clock we
- *	    have is CLOCK_REALTIME and its high res counter part, both of
- *	    which we beg off on and pass to do_sys_settimeofday().
  */
 static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags);
 
@@ -1165,6 +1158,10 @@ SYSCALL_DEFINE2(clock_settime, const clo
 	if (get_timespec64(&new_tp, tp))
 		return -EFAULT;
 
+	/*
+	 * Permission checks have to be done inside the clock specific
+	 * setter callback.
+	 */
 	return kc->clock_set(which_clock, &new_tp);
 }
 

