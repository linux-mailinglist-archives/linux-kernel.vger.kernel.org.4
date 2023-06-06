Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054D6724674
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbjFFOkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbjFFOjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:39:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCB1171D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:38:14 -0700 (PDT)
Message-ID: <20230606142032.655376396@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CLYMwgJmr5FlvwjCFRZh30bCjVfx+q+Z6l1NHlqA5Kg=;
        b=SBEkWjjKOPc5r+5qv1tF0CLdempgLMDgk3cqd3AUuEo9hq8jZKn6O3sLLj0nysbfM68AYn
        VikIQ8Zln3DJFEQyrO8rAU45wcbGPtUUHnJDPSTrsLR/EHe/Q+FByVe3EfMAO4ntt05wBz
        IMPaxCElQF7f3rpKXvZLfYJZwvTcIjsl3nIGGxvbPOnexQCQu+XuRrreGtQYgQ8iDSMOFJ
        XkB4GmB6/R4Qj3LdbTQYkT557pSh2o3wqC1padUFRnRJsbGMdq2ZR7RbVGwWdm0IyyfB0Y
        SJfuSEVhr7SUTgvVfJbOTwNF8qzx3PDPf6chFeCTao3G1pVQpnn/gVH7QN0jyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CLYMwgJmr5FlvwjCFRZh30bCjVfx+q+Z6l1NHlqA5Kg=;
        b=kCwRxsDUwnRH9F3ouDI9aLA4jIZh6Raet5hysFRmvvgVfj9nsm6Vn789ZsSIWMFM5RAHaA
        P1eLYe5cCVClT/Cg==
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
Subject: [patch 29/45] posix-timers: Make signal overrun accounting sensible
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:38:04 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The handling of the timer overrun in the signal code is inconsistent as it
takes previous overruns into account. This is just wrong as after the
reprogramming of a timer the overrun count starts over from a clean state,
i.e. 0.

Make the accounting in send_sigqueue() consistent with that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |   34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1957,6 +1957,34 @@ int send_sigqueue(struct sigqueue *q, st
 	 */
 	q->info.si_sys_private = si_private;
 
+	/*
+	 * Set the overrun count to zero unconditionally. The posix timer
+	 * code does not self rearm periodic timers. They are rearmed from
+	 * dequeue_signal().
+	 *
+	 * But there is a situation where @q is already enqueued:
+	 *
+	 * 1) timer_settime()
+	 *      arm_timer()
+	 * 2) timer_expires()
+	 *      send_sigqueue(@q)
+	 *        enqueue(@q)
+	 * 3) timer_settime()
+	 *      arm_timer()
+	 * 4) timer_expires()
+	 *      send_sigqueue(@q) <- Observes @q already queued
+	 *
+	 * In this case incrementing si_overrun does not make sense because
+	 * there is no relationship between timer_settime() #1 and #2.
+	 *
+	 * The POSIX specification is useful as always: "The effect of
+	 * disarming or resetting a timer with pending expiration
+	 * notifications is unspecified."
+	 *
+	 * Just do the sensible thing and reset the overrun.
+	 */
+	q->info.si_overrun = 0;
+
 	ret = 1; /* the signal is ignored */
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t, false))
@@ -1964,15 +1992,9 @@ int send_sigqueue(struct sigqueue *q, st
 
 	ret = 0;
 	if (unlikely(!list_empty(&q->list))) {
-		/*
-		 * If an SI_TIMER entry is already queue just increment
-		 * the overrun count.
-		 */
-		q->info.si_overrun++;
 		result = TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;
 	}
-	q->info.si_overrun = 0;
 
 	signalfd_notify(t, sig);
 	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;

