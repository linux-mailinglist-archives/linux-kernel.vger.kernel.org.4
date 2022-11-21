Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC7A63178B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 01:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiKUAWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 19:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKUAWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 19:22:07 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77521EEFF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 16:22:04 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id w9so6427037qtv.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 16:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=38IXGu4A04WYVWlM/XvutiCiEucS0LFyjAzvwaiVYtE=;
        b=yhTRUgA3SmCI32m+Fphjj7LlIOgcnyblbLIffV+QYtIKviQGYLAYOZjlMzQ73zsYHk
         E7ufP/Rf9JBRegUc4hboVxfPGS9qJ+U/XRxboYXXBIKnS0QtZaAg7lbJ3hnDxhK5k23U
         QBTRFeOD0CLt7A4URX7NetpZC46UcG9Ma0Wmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38IXGu4A04WYVWlM/XvutiCiEucS0LFyjAzvwaiVYtE=;
        b=O0iKoGfxc5hVo6WFTLw0vW3mXi13ab6hx2xzNRQrguSDhB1PiGQ8mG5uxGlq6VsohW
         fOVqw3FNLgrIQYuNjfd7BgdyayxOLQCk1YHE5q9Ge1YEDTovu0oujwGqJNNRhaMeYB+g
         3g8JTeVmtF6qO/LvtxKoeL8MjujfIhGKzcYxIm3axjd6PPt85/TdEz5RTv96k0o3gWxw
         MhTg/nP9Wfc8ciHKmvfgE/FRZjE/UX1PjD/G72agyybgRIPlFwcQPrKRBbR3yooi8FBr
         KL+5P3DSZUb3X5QXbxZRF2lhUFkchLOO2G2+Va06AFvU6wzCFXvJ50nMUU/0IKBTOWpc
         Ed/Q==
X-Gm-Message-State: ANoB5pnqStCYLcdOMs5XDJm5b5F+aC/qz3fX8xBCVtE8BmMAoCXGL851
        rAD/91bfFqX8j1jhTNyOCFo9pQ==
X-Google-Smtp-Source: AA0mqf5b7SUWumGCvxlQqpShxI60Tx/Iu0x/1tLLaGa/K30erKL/qDefH1qSGZP60FOCHcoj8qLwbw==
X-Received: by 2002:ac8:4f47:0:b0:397:3f40:decb with SMTP id i7-20020ac84f47000000b003973f40decbmr873547qtw.136.1668990123808;
        Sun, 20 Nov 2022 16:22:03 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id u18-20020a05620a455200b006cdd0939ffbsm7396710qkp.86.2022.11.20.16.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 16:22:03 -0800 (PST)
Date:   Mon, 21 Nov 2022 00:22:03 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Message-ID: <Y3rEq7IFKjYA+/bj@google.com>
References: <dab347c1-3724-8ac6-c051-9d2caea20101@arm.com>
 <34B2D8B9-A0C1-4280-944D-17224FB24339@joelfernandes.org>
 <4e396924-c3be-1932-91a3-5f458cc843fe@arm.com>
 <Y2ANPi7y5HhHvelr@google.com>
 <4ec6ab79-9f0f-e14b-dd06-d2840a1bf71a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ec6ab79-9f0f-e14b-dd06-d2840a1bf71a@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dietmar,

On Fri, Nov 04, 2022 at 06:09:26PM +0100, Dietmar Eggemann wrote:
> On 31/10/2022 19:00, Joel Fernandes wrote:
> > On Mon, Oct 31, 2022 at 05:39:45PM +0100, Dietmar Eggemann wrote:
> >> On 29/10/2022 05:31, Joel Fernandes wrote:
> >>> Hello Dietmar,
> >>>
> >>>> On Oct 24, 2022, at 6:13 AM, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>>>
> >>>> ﻿On 03/10/2022 23:44, Connor O'Brien wrote:
> >>>>> From: Peter Zijlstra <peterz@infradead.org>
> 
> [...]
> 
> >>>>> +    rq_unpin_lock(rq, rf);
> >>>>> +    raw_spin_rq_unlock(rq);
> >>>>
> >>>> Don't we run into rq_pin_lock()'s:
> >>>>
> >>>> SCHED_WARN_ON(rq->balance_callback && rq->balance_callback !=
> >>>> &balance_push_callback)
> >>>>
> >>>> by releasing rq lock between queue_balance_callback(, push_rt/dl_tasks)
> >>>> and __balance_callbacks()?
> >>>
> >>> Apologies, I’m a bit lost here. The code you are responding to inline does not call rq_pin_lock, it calls rq_unpin_lock.  So what scenario does the warning trigger according to you?
> >>
> >> True, but the code which sneaks in between proxy()'s
> >> raw_spin_rq_unlock(rq) and raw_spin_rq_lock(rq) does.
> >>
> > 
> > Got it now, thanks a lot for clarifying. Can this be fixed by do a
> > __balance_callbacks() at:
> 
> I tried the: 
> 
>    head = splice_balance_callbacks(rq)
>    task_rq_unlock(rq, p, &rf);
>    ...
>    balance_callbacks(rq, head);
> 
> separation known from __sched_setscheduler() in __schedule() (right
> after pick_next_task()) but it doesn't work. Lot of `BUG: scheduling
> while atomic:`

How about something like the following? This should exclude concurrent
balance callback queues from other CPUs and let us release the rq lock early
in proxy(). I ran locktorture with your diff to make writer threads RT, and I
cannot reproduce any crash with it:

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] Exclude balance callback queuing during proxy's migrate

In commit 565790d28b1e ("sched: Fix balance_callback()"), it is clear that rq
lock needs to be held when __balance_callbacks() in schedule() is called.
However, it is possible that because rq lock is dropped in proxy(), another
CPU, say in __sched_setscheduler() can queue balancing callbacks and cause
issues.

To remedy this, exclude balance callback queuing on other CPUs, during the
proxy().

Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c  | 15 +++++++++++++++
 kernel/sched/sched.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 88a5fa34dc06..f1dac21fcd90 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6739,6 +6739,10 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 		p->wake_cpu = wake_cpu;
 	}
 
+	// Prevent other CPUs from queuing balance callbacks while we migrate
+	// tasks in the migrate_list with the rq lock released.
+	raw_spin_lock(&rq->balance_lock);
+
 	rq_unpin_lock(rq, rf);
 	raw_spin_rq_unlock(rq);
 	raw_spin_rq_lock(that_rq);
@@ -6758,7 +6762,18 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 	}
 
 	raw_spin_rq_unlock(that_rq);
+
+	// This may make lockdep unhappy as we acquire rq->lock with balance_lock
+	// held. But that should be a false positive, as the following pattern
+	// happens only on the current CPU with interrupts disabled:
+	// rq_lock()
+	// balance_lock();
+	// rq_unlock();
+	// rq_lock();
 	raw_spin_rq_lock(rq);
+
+	raw_spin_unlock(&rq->balance_lock);
+
 	rq_repin_lock(rq, rf);
 
 	return NULL; /* Retry task selection on _this_ CPU. */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 354e75587fed..932d32bf9571 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1057,6 +1057,7 @@ struct rq {
 	unsigned long		cpu_capacity_orig;
 
 	struct callback_head	*balance_callback;
+	raw_spinlock_t		balance_lock;
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
@@ -1748,6 +1749,7 @@ queue_balance_callback(struct rq *rq,
 		       void (*func)(struct rq *rq))
 {
 	lockdep_assert_rq_held(rq);
+	raw_spin_lock(&rq->balance_lock);
 
 	/*
 	 * Don't (re)queue an already queued item; nor queue anything when
@@ -1760,6 +1762,7 @@ queue_balance_callback(struct rq *rq,
 	head->func = (void (*)(struct callback_head *))func;
 	head->next = rq->balance_callback;
 	rq->balance_callback = head;
+	raw_spin_unlock(&rq->balance_lock);
 }
 
 #define rcu_dereference_check_sched_domain(p) \
-- 
2.38.1.584.g0f3c55d4c2-goog

