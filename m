Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909E46EB148
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbjDUR7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDUR65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:58:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A65C19B7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:58:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682099933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CjqTfBnc4i/DyCn3WWU4lGoX298Bo5kCZ4dIanehkdE=;
        b=wQZAoPm+AKwSOHRBsjEFp5FTdyIF/9OzYheDefHhnBgKm0EbXyJFUCyRXlAfuzwuCP+hTY
        ROgNbofOc5ECZNkcqhmD1srQyruXelKD58gNmpQR8fzQIqHZRYxU0zAtao3SkSePCpfZsB
        xPC9zw7hQbtPV5+icjchdrk0ln92wVj/AwNLj+f/pMGXhqRzSmWtjKQIXBpT+aBmVdxHGG
        wSHRXJdcgYcr31eLNq6WH9Ez16Bobt03A77N88akgcm+6gYkPQcP4jHQMsR6PC3PfwS/Oy
        6lNQK9Fl04m/2A5rgBDDX1TT1Y3hR6zucdJIS4xkfbLgOU4fprWy6Q9VPqvaDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682099933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CjqTfBnc4i/DyCn3WWU4lGoX298Bo5kCZ4dIanehkdE=;
        b=SwNFXIZ+5/zHRK8UTHZFOaMgZcB0GGIORr67bdrbcIi68lcLAhYty55NHotl98CbL5/TQ4
        E48iIAtyHUF/0uAg==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Crystal Wood <swood@redhat.com>, John Keeping <john@metanate.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] locking/rtmutex: Do the trylock-slowpath with
 DEBUG_RT_MUTEXES enabled.
In-Reply-To: <20230328165430.9eOXd-55@linutronix.de>
References: <20230322162719.wYG1N0hh@linutronix.de>
 <20230328165430.9eOXd-55@linutronix.de>
Date:   Fri, 21 Apr 2023 19:58:52 +0200
Message-ID: <87zg7115ib.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28 2023 at 18:54, Sebastian Andrzej Siewior wrote:
> On 2023-03-22 17:27:21 [+0100], To Thomas Gleixner wrote:
>> > Aside of that for CONFIG_DEBUG_RT_MUTEXES=y builds it flushes on every
>> > lock operation whether the lock is contended or not.
>> 
>> For mutex & ww_mutex operations. rwsem is not affected by
>> CONFIG_DEBUG_RT_MUTEXES. As for mutex it could be mitigated by invoking
>> try_to_take_rt_mutex() before blk_flush_plug().

> I haven't observed anything in the ww-mutex path so we can ignore it or
> do something similar to this.

Yay for consistency !

I fixed it up to the below.

Thanks,

        tglx
---

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -219,6 +219,11 @@ static __always_inline bool rt_mutex_cmp
 	return try_cmpxchg_acquire(&lock->owner, &old, new);
 }
 
+static __always_inline bool rt_mutex_try_acquire(struct rt_mutex_base *lock)
+{
+	return rt_mutex_cmpxchg_acquire(lock, old, new);
+}
+
 static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
@@ -298,6 +303,20 @@ static __always_inline bool rt_mutex_cmp
 
 }
 
+static __always_inline bool rt_mutex_try_acquire(struct rt_mutex_base *lock)
+{
+	/*
+	 * With debug enabled rt_mutex_cmpxchg trylock() will always fail,
+	 * which will unconditionally invoke blk_flush_plug() in the slow
+	 * path of __rt_mutex_lock() and __ww_rt_mutex_lock() even in the
+	 * non-contended case.
+	 *
+	 * Avoid that by using rt_mutex_slow_trylock() which is fully covered
+	 * by the debug code and can acquire a non-contended rtmutex.
+	 */
+	return rt_mutex_slowtrylock(lock);
+}
+
 static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
@@ -1698,9 +1717,8 @@ static int __sched rt_mutex_slowlock(str
 static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 					   unsigned int state)
 {
-	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
+	if (likely(rt_mutex_try_acquire(lock)))
 		return 0;
-
 	/*
 	 * The task is about to sleep. Flush plugged IO as that might
 	 * take locks and corrupt tsk::pi_blocked_on.
--- a/kernel/locking/ww_rt_mutex.c
+++ b/kernel/locking/ww_rt_mutex.c
@@ -62,7 +62,7 @@ static int __sched
 	}
 	mutex_acquire_nest(&rtm->dep_map, 0, 0, nest_lock, ip);
 
-	if (likely(rt_mutex_cmpxchg_acquire(&rtm->rtmutex, NULL, current))) {
+	if (likely(rt_mutex_try_acquire(&rtm->rtmutex, NULL, current))) {
 		if (ww_ctx)
 			ww_mutex_set_context_fastpath(lock, ww_ctx);
 		return 0;
