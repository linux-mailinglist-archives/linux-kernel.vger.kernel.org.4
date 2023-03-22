Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E7D6C50A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCVQ1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjCVQ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:27:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36C660D7E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:27:23 -0700 (PDT)
Date:   Wed, 22 Mar 2023 17:27:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679502441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9Rm915zahe3wkfDA3OoSR/L3qpm80GrhS/bMurOPXUw=;
        b=gJD8resC1Fv1HxTm3TwZdZQqtLtBZkthWZGKGNlHWKbcAfflfIJgktQ0dLbUiGo/TuIyrx
        rYRvAfkHk3wjk340s8bMIXiXdbbTEEHS2eDzk3VqeoDOvqnOnU9aWn7bW66AfL1LZQPnxc
        anjx0PS6Lo9GZ4BbSiPiicx174egLrRxeHTV/UC0UngW7loYP8997KJ9zJ/AXzYSt+sCK2
        bzGLXGP2IlUUXtCt25A7MZdeKEyT5ZZJHGMja/nOuOUZXKWm+6+telYXU8EZiJZRX/XkdT
        VvwrgBrxgPha31sTucOiY1uNEeUkwLwhwBMSoNjhmDS4RtGBIKrM1EiAcMKOMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679502441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9Rm915zahe3wkfDA3OoSR/L3qpm80GrhS/bMurOPXUw=;
        b=xiaieJyN/TwkmbQDmpGFACCEw+FEWUcM2mYF2MOK/zHj4RgxKhdi5ULkvybRSRbfZ5+g9d
        aU2xtawMQ9yOGjCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Crystal Wood <swood@redhat.com>, John Keeping <john@metanate.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH] locking/rtmutex: Flush the plug before entering the slowpath.
Message-ID: <20230322162719.wYG1N0hh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_flush_plug() is invoked on schedule() to flush out the IO progress
that has been made so far so that it is globally visible. This is
important to avoid deadlocks because a lock owner can wait for IO.
Therefore the IO must be first flushed before a thread can block on a
lock.

The plug flush routine can acquire a sleeping lock which is contended.
Blocking on a lock requires an assignment to task_struct::pi_blocked_on.
If blk_flush_plug() is invoked from the slow path on schedule() then the
variable is already set and will be overwritten by the lock in
blk_flush_plug().
Therefore it is needed to invoke blk_flush_plug() (and block on
potential locks in the process) before the blocking on the actual lock.

Invoke blk_flush_plug() before blocking on a sleeping lock. The
PREEMPT_RT only sleeping locks (spinlock_t and rwlock_t) are excluded
because their slow path does not invoke blk_flush_plug().

Fixes: e17ba59b7e8e1 ("locking/rtmutex: Guard regular sleeping locks specific functions")
Reported-by: Crystal Wood <swood@redhat.com>
Link: https://lore.kernel.org/4b4ab374d3e24e6ea8df5cadc4297619a6d945af.camel@redhat.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
On 2023-02-20 19:21:51 [+0100], Thomas Gleixner wrote:
> 
> This still leaves the problem vs. io_wq_worker_sleeping() and it's
> running() counterpart after schedule().

io_wq_worker_sleeping() has a kfree() so it probably should be moved,
too.
io_wq_worker_running() is a OR and INC and is fine.

> Aside of that for CONFIG_DEBUG_RT_MUTEXES=y builds it flushes on every
> lock operation whether the lock is contended or not.

For mutex & ww_mutex operations. rwsem is not affected by
CONFIG_DEBUG_RT_MUTEXES. As for mutex it could be mitigated by invoking
try_to_take_rt_mutex() before blk_flush_plug().

 kernel/locking/rtmutex.c     | 7 +++++++
 kernel/locking/rwbase_rt.c   | 8 ++++++++
 kernel/locking/ww_rt_mutex.c | 5 +++++
 3 files changed, 20 insertions(+)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 728f434de2bbf..c1bc2cb1522cb 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -23,6 +23,7 @@
 #include <linux/sched/rt.h>
 #include <linux/sched/wake_q.h>
 #include <linux/ww_mutex.h>
+#include <linux/blkdev.h>
 
 #include <trace/events/lock.h>
 
@@ -1700,6 +1701,12 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
 
+	/*
+	 * If we are going to sleep and we have plugged IO queued, make sure to
+	 * submit it to avoid deadlocks.
+	 */
+	blk_flush_plug(current->plug, true);
+
 	return rt_mutex_slowlock(lock, NULL, state);
 }
 #endif /* RT_MUTEX_BUILD_MUTEX */
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index c201aadb93017..70c08ec4ad8af 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -143,6 +143,14 @@ static __always_inline int rwbase_read_lock(struct rwbase_rt *rwb,
 	if (rwbase_read_trylock(rwb))
 		return 0;
 
+	if (state != TASK_RTLOCK_WAIT) {
+		/*
+		 * If we are going to sleep and we have plugged IO queued,
+		 * make sure to submit it to avoid deadlocks.
+		 */
+		blk_flush_plug(current->plug, true);
+	}
+
 	return __rwbase_read_lock(rwb, state);
 }
 
diff --git a/kernel/locking/ww_rt_mutex.c b/kernel/locking/ww_rt_mutex.c
index d1473c624105c..472e3622abf09 100644
--- a/kernel/locking/ww_rt_mutex.c
+++ b/kernel/locking/ww_rt_mutex.c
@@ -67,6 +67,11 @@ __ww_rt_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ww_ctx,
 			ww_mutex_set_context_fastpath(lock, ww_ctx);
 		return 0;
 	}
+	/*
+	 * If we are going to sleep and we have plugged IO queued, make sure to
+	 * submit it to avoid deadlocks.
+	 */
+	blk_flush_plug(current->plug, true);
 
 	ret = rt_mutex_slowlock(&rtm->rtmutex, ww_ctx, state);
 
-- 
2.40.0

