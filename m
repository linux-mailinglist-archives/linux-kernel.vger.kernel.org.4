Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C615F6CC894
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjC1Qyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjC1Qye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:54:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942BB61AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:54:33 -0700 (PDT)
Date:   Tue, 28 Mar 2023 18:54:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680022471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sk9W5B4mLybL4P5YFSo3bhVLXYVTDyOOwN7NOF+D6nQ=;
        b=nH13hCV0vxF5SzhySjDO+gNg9Qio+BdJHSewkitpHh/ZxqQg2EGrB3Np363ObvmRuE7jmn
        X8t/GdfaK0BP3Z0owNSjosVR3sndUjYl/s7ZrLuLm1FiBol7VsjzMdzBIL4PAGNWGVoBiQ
        lVVUY1Oci541iQWL7IJ+JPDvun9xPQFDUONjAkDqHIAfRCPgrrHbtwSvulVuQLV8GevwWH
        DOZRke+bn0A/l4lE0QUHsweC7XAOHSDf7VqNeVqynrZnkVb6mm2ehGjZlj5HAFDu8rHlWS
        kmj+zh7kYk5gciZw4PDDj7wYQViFg+ZoYixetCZsJrBgCX0Cy95KqF6+iWZ+PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680022471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sk9W5B4mLybL4P5YFSo3bhVLXYVTDyOOwN7NOF+D6nQ=;
        b=6g9ZJUlK3spzJpRqwfE/oiN6P8UR9zzDk0C9NzM1ipADGHxikilaP35kAaDjDV8KJv6vB0
        t2MeNlbP85Nq1EBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Crystal Wood <swood@redhat.com>, John Keeping <john@metanate.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH] locking/rtmutex: Do the trylock-slowpath with
 DEBUG_RT_MUTEXES enabled.
Message-ID: <20230328165430.9eOXd-55@linutronix.de>
References: <20230322162719.wYG1N0hh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322162719.wYG1N0hh@linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With DEBUG_RT_MUTEXES enabled the fast-path locking
(rt_mutex_cmpxchg_acquire()) always fails. This leads to the invocation
of blk_flush_plug() even if the lock is not acquired which is
unnecessary and avoids batch processing of requests.

rt_mutex_slowtrylock() performs the trylock-slowpath and acquires the
lock if possible.
__rt_mutex_trylock() performs the fastpath try-lock and the slowpath
trylock. The latter is not desired in the non-debug case because it
fails very often even after rt_mutex_owner() reported that there is no
owner.
Here some numbers from a boot up + a few FS operations, hackbench:
- total __rt_mutex_lock() -> __rt_mutex_trylock() invocations with no
  owner: 32160
- success: 189
- failed: 31971
  - RT_MUTEX_HAS_WAITERS was set the whole time: 27469
  - owner appeared after the wait_lock has been obtained: 4502

The slowlock trylock failed in most cases without an owner because a
waiter was pending and did not acquire the lock yet. The few cases in
which it succeeded were because the pending bit was cleared after the
wait_lock was acquired.
Based on these numbers, rt_mutex_slowtrylock() in the non-DEBUG case
adds just overhead without contributing anything to the locking process.

In a dist-upgrade test with DEBUG_RT_MUTEXES enabled, the here proposed
rt_mutex_slowtrylock() optimisation acquired all locks with
current->plug set and avoided a blk_flush_plug() invocation.

Use rt_mutex_slowtrylock() in the DEBUG_RT_MUTEXES case to acquire the
lock instead the disabled rt_mutex_cmpxchg_acquire().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
On 2023-03-22 17:27:21 [+0100], To Thomas Gleixner wrote:
> > Aside of that for CONFIG_DEBUG_RT_MUTEXES=y builds it flushes on every
> > lock operation whether the lock is contended or not.
> 
> For mutex & ww_mutex operations. rwsem is not affected by
> CONFIG_DEBUG_RT_MUTEXES. As for mutex it could be mitigated by invoking
> try_to_take_rt_mutex() before blk_flush_plug().

This fixes the problem. I only observed blk_flush_plug() invocations
from down_read()/rwbase_read_lock() and down() which are not affected by
CONFIG_DEBUG_RT_MUTEXES.
I haven't observed anything in the ww-mutex path so we can ignore it or
do something similar to this.

 kernel/locking/rtmutex.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c1bc2cb1522cb..08c599a5089a2 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1698,9 +1698,18 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
 static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 					   unsigned int state)
 {
+	/*
+	 * With DEBUG enabled cmpxchg trylock will always fail. Instead of
+	 * invoking blk_flush_plug() try the trylock-slowpath first which will
+	 * succeed if the lock is not contended.
+	 */
+#ifdef CONFIG_DEBUG_RT_MUTEXES
+	if (likely(rt_mutex_slowtrylock(lock)))
+		return 0;
+#else
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
-
+#endif
 	/*
 	 * If we are going to sleep and we have plugged IO queued, make sure to
 	 * submit it to avoid deadlocks.
-- 
2.40.0
