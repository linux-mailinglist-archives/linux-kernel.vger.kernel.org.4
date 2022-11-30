Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7387A63E1D1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiK3UXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiK3UXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:23:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0249B26D2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 12:22:11 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A31D51F37C;
        Wed, 30 Nov 2022 20:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669839730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f6X4hpOzyUX3YVOUPhEwTm+3un8r1C0lik5rE82UgtM=;
        b=wKR23TcQL30HtgMz4ggVFhBAra8lbFTWtvPeImgz9aIBTyAogl5tIdleYIpeH2FN3+KgGW
        6z9hOFZnMIG/L4EYMstngLFsP3NDwDeqSV8aMSsZXet52/mo892wYCkgHl5IONVRcOD3hN
        C5y2+MoWvB8pWvL2abV+CzlEbl0PCzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669839730;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f6X4hpOzyUX3YVOUPhEwTm+3un8r1C0lik5rE82UgtM=;
        b=VJIKicuc0t79aDuVTBCITOE2HFhyaj9RmI/dnS2T+USBHaf8NXqBHCg7krp1BBEPc61+7Z
        LNDVL15Wwv5G5YDQ==
Received: from suse.de (mgorman.udp.ovpn2.nue.suse.de [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E4D5C2C14F;
        Wed, 30 Nov 2022 20:22:08 +0000 (UTC)
Date:   Wed, 30 Nov 2022 20:22:04 +0000
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
Message-ID: <20221130202204.usku3rl6wowiugju@suse.de>
References: <20221103115444.m2rjglbkubydidts@quack3>
 <Y2U+Je+LICO2HkNY@linutronix.de>
 <20221107135636.biouna36osqc4rik@quack3>
 <Y2kf6tcX47Cl7q0W@linutronix.de>
 <359cc93a-fce0-5af2-0fd5-81999fad186b@redhat.com>
 <20221109125756.GA24388@willie-the-truck>
 <20221109154023.cx2d4y3e7zqnuo35@quack3>
 <20221111142742.rh677sdwu55aeeno@quack3>
 <20221114124147.GA30263@willie-the-truck>
 <Y4Tapja2qq8HiHBZ@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y4Tapja2qq8HiHBZ@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 04:58:30PM +0100, Sebastian Andrzej Siewior wrote:
> How about this?
> 
> - The fast path is easy???
> 
> - The slow path first sets the WAITER bits (mark_rt_mutex_waiters()) so
>   I made that one _acquire so that it is visible by the unlocker forcing
>   everyone into slow path.
> 
> - If the lock is acquired, then the owner is written via
>   rt_mutex_set_owner(). This happens under wait_lock so it is
>   serialized and so a WRITE_ONCE() is used to write the final owner. I
>   replaced it with a cmpxchg_acquire() to have the owner there.
>   Not sure if I shouldn't make this as you put it:
> |   e.g. by making use of dependency ordering where it already exists.
>   The other (locking) CPU needs to see the owner not only the WAITER
>   bit. I'm not sure if this could be replaced with smp_store_release().
> 
> - After the whole operation completes, fixup_rt_mutex_waiters() cleans
>   the WAITER bit and I kept the _acquire semantic here. Now looking at
>   it again, I don't think that needs to be done since that shouldn't be
>   set here.
> 
> - There is rtmutex_spin_on_owner() which (as the name implies) spins on
>   the owner as long as it active. It obtains it via READ_ONCE() and I'm
>   not sure if any memory barrier is needed. Worst case is that it will
>   spin while owner isn't set if it observers a stale value.
> 
> - The unlock path first clears the waiter bit if there are no waiters
>   recorded (via simple assignments under the wait_lock (every locker
>   will fail with the cmpxchg_acquire() and go for the wait_lock)) and
>   then finally drop it via rt_mutex_cmpxchg_release(,, NULL).
>   Should there be a wait, it will just store the WAITER bit with
>   smp_store_release() (setting the owner is NULL but the WAITER bit
>   forces everyone into the slow path).
> 
> - Added rt_mutex_set_owner_pi() which does simple assignment. This is
>   used from the futex code and here everything happens under a lock.
> 
> - I added a smp_load_acquire() to rt_mutex_base_is_locked() since I
>   *think* want to observe a real waiter and not something stale.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

include/linux/rtmutex.h needs to also include asm/barrier.h to resolve
some build problems. Once that was resolved, 10 iterations of the dbench
work completed successfully and without the patch, 1 iteration could not
complete.

Review is trickier as I'm not spent any reasonable amount of time on locking
primitives. I'd have to defer to Peter in that regard but I skimmed it at
least before wrapping up for the evening.

> ---
>  include/linux/rtmutex.h      |  2 +-
>  kernel/locking/rtmutex.c     | 26 ++++++++++++++++++--------
>  kernel/locking/rtmutex_api.c |  4 ++--
>  3 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
> index 7d049883a08ac..4447e01f723d4 100644
> --- a/include/linux/rtmutex.h
> +++ b/include/linux/rtmutex.h
> @@ -41,7 +41,7 @@ struct rt_mutex_base {
>   */
>  static inline bool rt_mutex_base_is_locked(struct rt_mutex_base *lock)
>  {
> -	return READ_ONCE(lock->owner) != NULL;
> +	return smp_load_acquire(&lock->owner) != NULL;
>  }
>  

I don't believe this is necessary. It's only needed when checking if a
lock is acquired or not and it's inherently race-prone. It's harmless if
a stale value is observed and it does not pair with a release. Mostly it's
useful for debugging checks.

>  extern void rt_mutex_base_init(struct rt_mutex_base *rtb);
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 7779ee8abc2a0..e3cc673e0c988 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -97,7 +97,7 @@ rt_mutex_set_owner(struct rt_mutex_base *lock, struct task_struct *owner)
>  	if (rt_mutex_has_waiters(lock))
>  		val |= RT_MUTEX_HAS_WAITERS;
>  
> -	WRITE_ONCE(lock->owner, (struct task_struct *)val);
> +	WARN_ON_ONCE(cmpxchg_acquire(&lock->owner, RT_MUTEX_HAS_WAITERS, val) != RT_MUTEX_HAS_WAITERS);
>  }
>  
>  static __always_inline void clear_rt_mutex_waiters(struct rt_mutex_base *lock)
> @@ -106,6 +106,17 @@ static __always_inline void clear_rt_mutex_waiters(struct rt_mutex_base *lock)
>  			((unsigned long)lock->owner & ~RT_MUTEX_HAS_WAITERS);
>  }
>  
> +static __always_inline void
> +rt_mutex_set_owner_pi(struct rt_mutex_base *lock, struct task_struct *owner)
> +{

What does pi mean in this context? I think the naming here might
misleading. rt_mutex_set_owner_pi is used when initialising and when
clearing the owner. rt_mutex_set_owner is set when acquiring the lock.

Consider renaming rt_mutex_set_owner_pi to rt_mutex_clear_owner. The init
could still use rt_mutex_set_owner as an extra barrier is not a big deal
during init if the straight assignment was unpopular.  The init could also
do a plain assignment because it cannot have any waiters yet.

What is less obvious is if rt_mutex_clear_owner should have explicit release
semantics to pair with rt_mutex_set_owner. It looks like it might not
matter because at least some paths end up having release semantics anyway
due to a spinlock but I didn't check all cases and it's potentially fragile.

> +	unsigned long val = (unsigned long)owner;
> +
> +	if (rt_mutex_has_waiters(lock))
> +		val |= RT_MUTEX_HAS_WAITERS;
> +
> +	WRITE_ONCE(lock->owner, val);
> +}
> +
>  static __always_inline void fixup_rt_mutex_waiters(struct rt_mutex_base *lock)
>  {
>  	unsigned long owner, *p = (unsigned long *) &lock->owner;
> @@ -173,7 +184,7 @@ static __always_inline void fixup_rt_mutex_waiters(struct rt_mutex_base *lock)
>  	 */
>  	owner = READ_ONCE(*p);
>  	if (owner & RT_MUTEX_HAS_WAITERS)
> -		WRITE_ONCE(*p, owner & ~RT_MUTEX_HAS_WAITERS);
> +		cmpxchg_acquire(p, owner, owner & ~RT_MUTEX_HAS_WAITERS);
>  }
>  
>  /*
> @@ -196,17 +207,16 @@ static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base *lock,
>  }
>  
>  /*
> - * Callers must hold the ->wait_lock -- which is the whole purpose as we force
> - * all future threads that attempt to [Rmw] the lock to the slowpath. As such
> - * relaxed semantics suffice.
> + * Callers hold the ->wait_lock. This needs to be visible to the lockowner,
> + * forcing him into the slow path for the unlock operation.
>   */
>  static __always_inline void mark_rt_mutex_waiters(struct rt_mutex_base *lock)
>  {
>  	unsigned long owner, *p = (unsigned long *) &lock->owner;
>  
>  	do {
> -		owner = *p;
> -	} while (cmpxchg_relaxed(p, owner,
> +		owner = READ_ONCE(*p);
> +	} while (cmpxchg_acquire(p, owner,
>  				 owner | RT_MUTEX_HAS_WAITERS) != owner);
>  }
>  

Not 100% sure although I see it's to cover an exit path from
try_to_take_rt_mutex. I'm undecided if rt_mutex_set_owner having acquire
semantics and rt_mutex_clear_owner having clear semantics would be
sufficient. try_to_take_rt_mutex can still return with release semantics
but only in the case where it fails to acquire the lock.

> @@ -1218,7 +1228,7 @@ static void __sched mark_wakeup_next_waiter(struct rt_wake_q_head *wqh,
>  	 * slow path making sure no task of lower priority than
>  	 * the top waiter can steal this lock.
>  	 */
> -	lock->owner = (void *) RT_MUTEX_HAS_WAITERS;
> +	smp_store_release(&lock->owner, (void *) RT_MUTEX_HAS_WAITERS);
>  
>  	/*
>  	 * We deboosted before waking the top waiter task such that we don't

This is within a locked section and would definitely see a barrier if
rt_mutex_wake_q_add_task calls wake_q_add but it's less clear if the
optimisation in rt_mutex_wake_q_add_task could race so I'm undecided if
it's necessary or not.

> diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
> index 900220941caac..9acc176f93d38 100644
> --- a/kernel/locking/rtmutex_api.c
> +++ b/kernel/locking/rtmutex_api.c
> @@ -249,7 +249,7 @@ void __sched rt_mutex_init_proxy_locked(struct rt_mutex_base *lock,
>  	 * recursion. Give the futex/rtmutex wait_lock a separate key.
>  	 */
>  	lockdep_set_class(&lock->wait_lock, &pi_futex_key);
> -	rt_mutex_set_owner(lock, proxy_owner);
> +	rt_mutex_set_owner_pi(lock, proxy_owner);
>  }
>  
>  /**
> @@ -267,7 +267,7 @@ void __sched rt_mutex_init_proxy_locked(struct rt_mutex_base *lock,
>  void __sched rt_mutex_proxy_unlock(struct rt_mutex_base *lock)
>  {
>  	debug_rt_mutex_proxy_unlock(lock);
> -	rt_mutex_set_owner(lock, NULL);
> +	rt_mutex_set_owner_pi(lock, NULL);
>  }
>  
>  /**
> -- 
> 2.38.1
> 

-- 
Mel Gorman
SUSE Labs
