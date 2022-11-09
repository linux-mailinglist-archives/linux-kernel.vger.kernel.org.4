Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2731A622BFD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiKIM6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIM6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:58:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E95C175A9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:58:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1696561A85
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9328FC433D6;
        Wed,  9 Nov 2022 12:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667998682;
        bh=f5+8s6ZLlWO2fVcZsvbkDst53XB4AafqIcPVrOJe1G0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GzFoh3RKu+jSDRnBqi+evZmFK6cli/bLkYDLMP/DaA/eQtnC2Q3QGQnVO2BPWmcy4
         XRcygnKqbfFWolLEKSqlsMtClHL8PJgiduko0SjQMzMx6TfltIR02/lzvQyQIwAl89
         hv0O2gBKjbU4a867h5j5fGoep4MfEj0PSKqLyyW/5Bl6wFUanPSc2T+chubeP4Kuzh
         fcYsM2ZPdZxkA3VexysciO+B/F49cUyBaC/r05ndnEjFBcEVYkwIdF+NZq6zQfnODj
         7rhO6JTWkYL7gBE2hBRTezPOJ2qApdZ59vmWnwq7v6qx7R3nrUIzZdRXB5H3EpsjoC
         DNu9ZmMZkZNAA==
Date:   Wed, 9 Nov 2022 12:57:57 +0000
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Crash with PREEMPT_RT on aarch64 machine
Message-ID: <20221109125756.GA24388@willie-the-truck>
References: <20221103115444.m2rjglbkubydidts@quack3>
 <Y2U+Je+LICO2HkNY@linutronix.de>
 <20221107135636.biouna36osqc4rik@quack3>
 <Y2kf6tcX47Cl7q0W@linutronix.de>
 <359cc93a-fce0-5af2-0fd5-81999fad186b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <359cc93a-fce0-5af2-0fd5-81999fad186b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 11:49:01AM -0500, Waiman Long wrote:
> On 11/7/22 10:10, Sebastian Andrzej Siewior wrote:
> > + locking, arm64
> > 
> > On 2022-11-07 14:56:36 [+0100], Jan Kara wrote:
> > > > spinlock_t and raw_spinlock_t differ slightly in terms of locking.
> > > > rt_spin_lock() has the fast path via try_cmpxchg_acquire(). If you
> > > > enable CONFIG_DEBUG_RT_MUTEXES then you would force the slow path which
> > > > always acquires the rt_mutex_base::wait_lock (which is a raw_spinlock_t)
> > > > while the actual lock is modified via cmpxchg.
> > > So I've tried enabling CONFIG_DEBUG_RT_MUTEXES and indeed the corruption
> > > stops happening as well. So do you suspect some bug in the CPU itself?
> > If it is only enabling CONFIG_DEBUG_RT_MUTEXES (and not whole lockdep)
> > then it looks very suspicious.
> > CONFIG_DEBUG_RT_MUTEXES enables a few additional checks but the main
> > part is that rt_mutex_cmpxchg_acquire() + rt_mutex_cmpxchg_release()
> > always fail (and so the slowpath under a raw_spinlock_t is done).
> > 
> > So if it is really the fast path (rt_mutex_cmpxchg_acquire()) then it
> > somehow smells like the CPU is misbehaving.
> > 
> > Could someone from the locking/arm64 department check if the locking in
> > RT-mutex (rtlock_lock()) is correct?
> > 
> > rtmutex locking uses try_cmpxchg_acquire(, ptr, ptr) for the fastpath
> > (and try_cmpxchg_release(, ptr, ptr) for unlock).
> > Now looking at it again, I don't see much difference compared to what
> > queued_spin_trylock() does except the latter always operates on 32bit
> > value instead a pointer.
> 
> Both the fast path of queued spinlock and rt_spin_lock are using
> try_cmpxchg_acquire(), the only difference I saw is the size of the data to
> be cmpxchg'ed. qspinlock uses 32-bit integer whereas rt_spin_lock uses
> 64-bit pointer. So I believe it is more on how the arm64 does cmpxchg. I
> believe there are two different ways of doing it depending on whether LSE
> atomics is available in the platform. So exactly what arm64 system is being
> used here and what hardware capability does it have?

I'd be more inclined to be suspicious of the slowpath tbh, as we need to
make sure that we have acquire semantics on all paths where the lock can
be taken. Looking at the rtmutex code, this really isn't obvious to me --
for example, try_to_take_rt_mutex() appears to be able to return via the
'takeit' label without acquire semantics and it looks like we might be
relying on the caller's subsequent _unlock_ of the wait_lock for ordering,
but that will give us release semantics which aren't correct.

As a quick hack, can you try chucking a barrier into rt_mutex_set_owner()?

Will

--->8

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 7779ee8abc2a..dd6a66c90f53 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -98,6 +98,7 @@ rt_mutex_set_owner(struct rt_mutex_base *lock, struct task_struct *owner)
                val |= RT_MUTEX_HAS_WAITERS;
 
        WRITE_ONCE(lock->owner, (struct task_struct *)val);
+       smp_mb();
 }
 
 static __always_inline void clear_rt_mutex_waiters(struct rt_mutex_base *lock)

