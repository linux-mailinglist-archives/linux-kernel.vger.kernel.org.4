Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963BF63F5F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiLARJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLARJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:09:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE41FA8964
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:09:50 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6C4211FD81;
        Thu,  1 Dec 2022 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669914589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FZZirPNqoRK4D52+T8TPtbkz37x+dPeRQ3qfwEdybn4=;
        b=ON/yW3QJYUzts4YT/671NebsjmWxGhqZvZ5XV6wIbvoRTYBccM8flKTrvg3AK9QT4qe6x4
        H9djOQIwa1YVWyoRtefAjf5ttBIqiQgZkaG3muThA9Adq1uLd9Zp54bak1GVKmBC8yCe3r
        tBOpYlkBtrr2DYniMv/I07lpSKZDE3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669914589;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FZZirPNqoRK4D52+T8TPtbkz37x+dPeRQ3qfwEdybn4=;
        b=sacZ92Xky1z3ZzRwDi358THpdAvYIridrqCvnWFIfoEwlDkI94gvs3Ui1rBU9jVKmCoq5Z
        TLHcEsSaIhjviSBA==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3EEAF2C141;
        Thu,  1 Dec 2022 17:09:45 +0000 (UTC)
Date:   Thu, 1 Dec 2022 17:09:41 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Will Deacon <will@kernel.org>, Jan Kara <jack@suse.cz>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Crash with PREEMPT_RT on aarch64 machine
Message-ID: <20221201170941.zxorepk6zjrhprg4@suse.de>
References: <Y2U+Je+LICO2HkNY@linutronix.de>
 <20221107135636.biouna36osqc4rik@quack3>
 <Y2kf6tcX47Cl7q0W@linutronix.de>
 <359cc93a-fce0-5af2-0fd5-81999fad186b@redhat.com>
 <20221109125756.GA24388@willie-the-truck>
 <20221109154023.cx2d4y3e7zqnuo35@quack3>
 <20221111142742.rh677sdwu55aeeno@quack3>
 <20221114124147.GA30263@willie-the-truck>
 <Y4Tapja2qq8HiHBZ@linutronix.de>
 <20221130202204.usku3rl6wowiugju@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20221130202204.usku3rl6wowiugju@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 08:22:10PM +0000, Mel Gorman wrote:
> >  extern void rt_mutex_base_init(struct rt_mutex_base *rtb);
> > diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> > index 7779ee8abc2a0..e3cc673e0c988 100644
> > --- a/kernel/locking/rtmutex.c
> > +++ b/kernel/locking/rtmutex.c
> > @@ -97,7 +97,7 @@ rt_mutex_set_owner(struct rt_mutex_base *lock, struct task_struct *owner)
> >  	if (rt_mutex_has_waiters(lock))
> >  		val |= RT_MUTEX_HAS_WAITERS;
> >  
> > -	WRITE_ONCE(lock->owner, (struct task_struct *)val);
> > +	WARN_ON_ONCE(cmpxchg_acquire(&lock->owner, RT_MUTEX_HAS_WAITERS, val) != RT_MUTEX_HAS_WAITERS);
> >  }
> >  
> >  static __always_inline void clear_rt_mutex_waiters(struct rt_mutex_base *lock)
> > @@ -106,6 +106,17 @@ static __always_inline void clear_rt_mutex_waiters(struct rt_mutex_base *lock)
> >  			((unsigned long)lock->owner & ~RT_MUTEX_HAS_WAITERS);
> >  }
> >  
> > +static __always_inline void
> > +rt_mutex_set_owner_pi(struct rt_mutex_base *lock, struct task_struct *owner)
> > +{
> 
> What does pi mean in this context? I think the naming here might
> misleading. rt_mutex_set_owner_pi is used when initialising and when
> clearing the owner. rt_mutex_set_owner is set when acquiring the lock.
> 
> Consider renaming rt_mutex_set_owner_pi to rt_mutex_clear_owner. The init
> could still use rt_mutex_set_owner as an extra barrier is not a big deal
> during init if the straight assignment was unpopular.  The init could also
> do a plain assignment because it cannot have any waiters yet.
> 
> What is less obvious is if rt_mutex_clear_owner should have explicit release
> semantics to pair with rt_mutex_set_owner. It looks like it might not
> matter because at least some paths end up having release semantics anyway
> due to a spinlock but I didn't check all cases and it's potentially fragile.
> 

There are not release semantics so, this? It passed 1 iteration but will
leave it running 10 times overnight

---
 kernel/locking/rtmutex.c     | 48 +++++++++++++++++++++++++++++++++++---------
 kernel/locking/rtmutex_api.c |  6 +++---
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 7779ee8abc2a..35212f260148 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -89,15 +89,33 @@ static inline int __ww_mutex_check_kill(struct rt_mutex *lock,
  * set this bit before looking at the lock.
  */
 
-static __always_inline void
-rt_mutex_set_owner(struct rt_mutex_base *lock, struct task_struct *owner)
+static __always_inline struct task_struct *
+rt_mutex_owner_encode(struct rt_mutex_base *lock, struct task_struct *owner)
 {
 	unsigned long val = (unsigned long)owner;
 
 	if (rt_mutex_has_waiters(lock))
 		val |= RT_MUTEX_HAS_WAITERS;
 
-	WRITE_ONCE(lock->owner, (struct task_struct *)val);
+	return (struct task_struct *)val;
+}
+
+
+static __always_inline void
+rt_mutex_set_owner(struct rt_mutex_base *lock, struct task_struct *owner)
+{
+	/*
+	 * lock->wait_lock is held but explicit acquire semantics are needed
+	 * for a new lock owner so WRITE_ONCE is insufficient.
+	 */
+	xchg_acquire(&lock->owner, rt_mutex_owner_encode(lock, owner));
+}
+
+static __always_inline void
+rt_mutex_clear_owner(struct rt_mutex_base *lock)
+{
+	/* lock->wait_lock is held so the unlock provides release semantics. */
+	WRITE_ONCE(lock->owner, rt_mutex_owner_encode(lock, NULL));
 }
 
 static __always_inline void clear_rt_mutex_waiters(struct rt_mutex_base *lock)
@@ -106,7 +124,8 @@ static __always_inline void clear_rt_mutex_waiters(struct rt_mutex_base *lock)
 			((unsigned long)lock->owner & ~RT_MUTEX_HAS_WAITERS);
 }
 
-static __always_inline void fixup_rt_mutex_waiters(struct rt_mutex_base *lock)
+static __always_inline void
+fixup_rt_mutex_waiters(struct rt_mutex_base *lock, bool acquire_lock)
 {
 	unsigned long owner, *p = (unsigned long *) &lock->owner;
 
@@ -172,8 +191,19 @@ static __always_inline void fixup_rt_mutex_waiters(struct rt_mutex_base *lock)
 	 * still set.
 	 */
 	owner = READ_ONCE(*p);
-	if (owner & RT_MUTEX_HAS_WAITERS)
-		WRITE_ONCE(*p, owner & ~RT_MUTEX_HAS_WAITERS);
+	if (owner & RT_MUTEX_HAS_WAITERS) {
+		/*
+		 * See comments in rt_mutex_set_owner and
+		 * rt_mutex_clear_owner on why xchg_acquire is used for
+		 * updating owner for locking and WRITE_ONCE for unlocking.
+		 * WRITE_ONCE would work for both here although other lock
+		 * acquisitions may enter the slow path unnecessarily.
+		 */
+		if (acquire_lock)
+			xchg_acquire(p, owner & ~RT_MUTEX_HAS_WAITERS);
+		else
+			WRITE_ONCE(*p, owner & ~RT_MUTEX_HAS_WAITERS);
+	}
 }
 
 /*
@@ -1243,7 +1273,7 @@ static int __sched __rt_mutex_slowtrylock(struct rt_mutex_base *lock)
 	 * try_to_take_rt_mutex() sets the lock waiters bit
 	 * unconditionally. Clean this up.
 	 */
-	fixup_rt_mutex_waiters(lock);
+	fixup_rt_mutex_waiters(lock, true);
 
 	return ret;
 }
@@ -1604,7 +1634,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 	 * try_to_take_rt_mutex() sets the waiter bit
 	 * unconditionally. We might have to fix that up.
 	 */
-	fixup_rt_mutex_waiters(lock);
+	fixup_rt_mutex_waiters(lock, true);
 
 	trace_contention_end(lock, ret);
 
@@ -1719,7 +1749,7 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally.
 	 * We might have to fix that up:
 	 */
-	fixup_rt_mutex_waiters(lock);
+	fixup_rt_mutex_waiters(lock, true);
 	debug_rt_mutex_free_waiter(&waiter);
 
 	trace_contention_end(lock, 0);
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 900220941caa..cb9fdff76a8a 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -267,7 +267,7 @@ void __sched rt_mutex_init_proxy_locked(struct rt_mutex_base *lock,
 void __sched rt_mutex_proxy_unlock(struct rt_mutex_base *lock)
 {
 	debug_rt_mutex_proxy_unlock(lock);
-	rt_mutex_set_owner(lock, NULL);
+	rt_mutex_clear_owner(lock);
 }
 
 /**
@@ -382,7 +382,7 @@ int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_base *lock,
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
 	 * have to fix that up.
 	 */
-	fixup_rt_mutex_waiters(lock);
+	fixup_rt_mutex_waiters(lock, true);
 	raw_spin_unlock_irq(&lock->wait_lock);
 
 	return ret;
@@ -438,7 +438,7 @@ bool __sched rt_mutex_cleanup_proxy_lock(struct rt_mutex_base *lock,
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
 	 * have to fix that up.
 	 */
-	fixup_rt_mutex_waiters(lock);
+	fixup_rt_mutex_waiters(lock, false);
 
 	raw_spin_unlock_irq(&lock->wait_lock);
 


