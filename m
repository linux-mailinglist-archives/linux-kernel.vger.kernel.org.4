Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5389E6F04DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243679AbjD0LUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243563AbjD0LTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:19:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599F55263
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:19:46 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682594384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ss/NEuQeuI1dqjAHKhSBAWsmc81HxasKaGCODSbI4ek=;
        b=eKuk40/REqcGKS0ii2ASevLY3qsTGyQpKqrPZwA4rFyEtiPLBKFamvgwzZkSxqe7rqHJW4
        V7/MswqlsuXFxfaXz+WGA8BnoIoKM0NWYcRsY4uUScr1eHt/XaoltlRlkQHJmv71ER4MpW
        Y4yRirWQjv0+Bp/p6rJymqKaruezQ0uaq36fumnq5Gr2iTQ6zqwhLrGMV0LZWfvnJVZDqn
        870vy+aipzwSfn/RWuhqJ52LM8KuvjglSYoQ8uMOv8Z7P+y1qMYXsWNOUEsRwebiQZSCjw
        1vCPylGEcln7uR18jlws4iC9N/tvEzwV4OobbW8in4VPgrhbef9vmrVSVvqneg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682594384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ss/NEuQeuI1dqjAHKhSBAWsmc81HxasKaGCODSbI4ek=;
        b=odiuxUs1bodRYWfNKXGv8oSn53TaRU36lEYWWoaUUgo6tmXnDI/rNSWy8xH4gAaRrZ0T6h
        4d7RhFEJLodYovAg==
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Crystal Wood <swood@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <jstultz@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 3/4] locking/rtmutex: Avoid pointless blk_flush_plug() invocations
Date:   Thu, 27 Apr 2023 13:19:36 +0200
Message-Id: <20230427111937.2745231-4-bigeasy@linutronix.de>
In-Reply-To: <20230427111937.2745231-1-bigeasy@linutronix.de>
References: <20230427111937.2745231-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With DEBUG_RT_MUTEXES enabled the fast-path rt_mutex_cmpxchg_acquire()
always fails and all lock operations take the slow path, which leads to the
invocation of blk_flush_plug() even if the lock is not contended which is
unnecessary and avoids batch processing of requests.

Provide a new helper inline rt_mutex_try_acquire() which maps to
rt_mutex_cmpxchg_acquire() in the non-debug case. For the debug case it
invokes rt_mutex_slowtrylock() which can acquire a non-contended rtmutex
under full debug coverage.

Replace the rt_mutex_cmpxchg_acquire() invocations in __rt_mutex_lock() and
__ww_rt_mutex_lock() with the new helper function, which avoid the
blk_flush_plug() for the non-contended case and preserves the debug
mechanism.

[ tglx: Created a new helper and massaged changelog ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rtmutex.c     | 25 ++++++++++++++++++++++++-
 kernel/locking/ww_rt_mutex.c |  2 +-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index aa66a3c5950a7..dd76c1b9b7d21 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -218,6 +218,11 @@ static __always_inline bool rt_mutex_cmpxchg_acquire(s=
truct rt_mutex_base *lock,
 	return try_cmpxchg_acquire(&lock->owner, &old, new);
 }
=20
+static __always_inline bool rt_mutex_try_acquire(struct rt_mutex_base *loc=
k)
+{
+	return rt_mutex_cmpxchg_acquire(lock, NULL, current);
+}
+
 static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base =
*lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
@@ -297,6 +302,24 @@ static __always_inline bool rt_mutex_cmpxchg_acquire(s=
truct rt_mutex_base *lock,
=20
 }
=20
+static int __sched rt_mutex_slowtrylock(struct rt_mutex_base *lock);
+
+static __always_inline bool rt_mutex_try_acquire(struct rt_mutex_base *loc=
k)
+{
+	/*
+	 * With debug enabled rt_mutex_cmpxchg trylock() will always fail,
+	 * which will unconditionally invoke sched_submit/resume_work() in
+	 * the slow path of __rt_mutex_lock() and __ww_rt_mutex_lock() even
+	 * in the non-contended case.
+	 *
+	 * Avoid that by using rt_mutex_slow_trylock() which is covered by
+	 * the debug code and can acquire a non-contended rtmutex. On
+	 * success the callsite avoids the sched_submit/resume_work()
+	 * dance.
+	 */
+	return rt_mutex_slowtrylock(lock);
+}
+
 static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base =
*lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
@@ -1704,7 +1727,7 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_=
base *lock,
 static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 					   unsigned int state)
 {
-	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
+	if (likely(rt_mutex_try_acquire(lock)))
 		return 0;
=20
 	return rt_mutex_slowlock(lock, NULL, state);
diff --git a/kernel/locking/ww_rt_mutex.c b/kernel/locking/ww_rt_mutex.c
index d1473c624105c..c7196de838edc 100644
--- a/kernel/locking/ww_rt_mutex.c
+++ b/kernel/locking/ww_rt_mutex.c
@@ -62,7 +62,7 @@ __ww_rt_mutex_lock(struct ww_mutex *lock, struct ww_acqui=
re_ctx *ww_ctx,
 	}
 	mutex_acquire_nest(&rtm->dep_map, 0, 0, nest_lock, ip);
=20
-	if (likely(rt_mutex_cmpxchg_acquire(&rtm->rtmutex, NULL, current))) {
+	if (likely(rt_mutex_try_acquire(&rtm->rtmutex))) {
 		if (ww_ctx)
 			ww_mutex_set_context_fastpath(lock, ww_ctx);
 		return 0;
--=20
2.40.1

