Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9105E6945CD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjBMMc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBMMcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:32:25 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6500A10F5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8TPm/BaZtYebhLCZqBDWI5ilC85NjFZZyhkowqSPzXY=; b=hHz8KncP9URMezpUaZY8Kz0m6a
        U/H+WGYi0HRQAVrl2QU2JzTs/iizgTBCtl9VfaLyBaDJcSelDmkjkP9Zh20ks5yc0V48mHvecEmVm
        CB/ZmT6PC8Gs+6VX7O8b/wlXSNCrpNmVtxKGf9scti5pMHlTsuy2GIe9SrWF2GPA5Va152qEgrXbZ
        Ijs8PgPGhs5uTvsyblX/TMI5aAhD+AtwG30ue0FHYHc4Zr2f10FJxj8/0XydDpWr0UVzX1KkSRQOB
        u4kbxeM2KXBo3QN+OSi4Jtr+lz9lW2/3kBvMaSx0xH6I7ASZPHvETnh1aU1E1SB4GptC0MgqeZPWN
        0iGf7CcA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pRXzN-009IKF-0A;
        Mon, 13 Feb 2023 12:31:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D1C0A300673;
        Mon, 13 Feb 2023 13:31:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B88E92010F0F0; Mon, 13 Feb 2023 13:31:59 +0100 (CET)
Date:   Mon, 13 Feb 2023 13:31:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Ting11 Wang =?utf-8?B?546L5am3?= <wangting11@xiaomi.com>
Subject: Re: [PATCH v7 4/4] locking/rwsem: Enable direct rwsem lock handoff
Message-ID: <Y+otv+QGyMpHAFO1@hirez.programming.kicks-ass.net>
References: <20230126003628.365092-1-longman@redhat.com>
 <20230126003628.365092-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126003628.365092-5-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 07:36:28PM -0500, Waiman Long wrote:

> @@ -609,6 +618,12 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>  
>  	lockdep_assert_held(&sem->wait_lock);
>  
> +	if (!waiter->task) {
> +		/* Write lock handed off */
> +		smp_acquire__after_ctrl_dep();
> +		return true;
> +	}
> +
>  	count = atomic_long_read(&sem->count);
>  	do {
>  		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
> @@ -754,6 +769,10 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
>  
>  	owner = rwsem_owner_flags(sem, &flags);
>  	state = rwsem_owner_state(owner, flags);
> +
> +	if (owner == current)
> +		return OWNER_NONSPINNABLE;	/* Handoff granted */
> +
>  	if (state != OWNER_WRITER)
>  		return state;
>  
> @@ -1168,21 +1186,23 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>  		 * without sleeping.
>  		 */
>  		if (waiter.handoff_set) {
> -			enum owner_state owner_state;
> -
> -			owner_state = rwsem_spin_on_owner(sem);
> -			if (owner_state == OWNER_NULL)
> -				goto trylock_again;
> +			rwsem_spin_on_owner(sem);
> +			if (!READ_ONCE(waiter.task)) {
> +				/* Write lock handed off */
> +				smp_acquire__after_ctrl_dep();
> +				set_current_state(TASK_RUNNING);
> +				goto out;
> +			}
>  		}
>  
>  		schedule_preempt_disabled();
>  		lockevent_inc(rwsem_sleep_writer);
>  		set_current_state(state);
> -trylock_again:
>  		raw_spin_lock_irq(&sem->wait_lock);
>  	}
>  	__set_current_state(TASK_RUNNING);
>  	raw_spin_unlock_irq(&sem->wait_lock);
> +out:
>  	lockevent_inc(rwsem_wlock);
>  	trace_contention_end(sem, 0);
>  	return sem;
> @@ -1190,6 +1210,11 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>  out_nolock:
>  	__set_current_state(TASK_RUNNING);
>  	raw_spin_lock_irq(&sem->wait_lock);
> +	if (!waiter.task) {
> +		smp_acquire__after_ctrl_dep();
> +		raw_spin_unlock_irq(&sem->wait_lock);
> +		goto out;
> +	}
>  	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
>  	lockevent_inc(rwsem_wlock_fail);
>  	trace_contention_end(sem, -EINTR);
> @@ -1202,14 +1227,41 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>   */
>  static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
>  {
> -	unsigned long flags;
>  	DEFINE_WAKE_Q(wake_q);
> +	unsigned long flags;
> +	unsigned long count;
>  
>  	raw_spin_lock_irqsave(&sem->wait_lock, flags);
>  
> -	if (!list_empty(&sem->wait_list))
> -		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
> +	if (list_empty(&sem->wait_list))
> +		goto unlock_out;
> +
> +	/*
> +	 * If the rwsem is free and handoff flag is set with wait_lock held,
> +	 * no other CPUs can take an active lock.
> +	 */
> +	count = atomic_long_read(&sem->count);
> +	if (!(count & RWSEM_LOCK_MASK) && (count & RWSEM_FLAG_HANDOFF)) {
> +		/*
> +		 * Since rwsem_mark_wake() will handle the handoff to reader
> +		 * properly, we don't need to do anything extra for reader.
> +		 * Special handoff processing will only be needed for writer.
> +		 */
> +		struct rwsem_waiter *waiter = rwsem_first_waiter(sem);
> +		long adj = RWSEM_WRITER_LOCKED - RWSEM_FLAG_HANDOFF;
> +
> +		if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
> +			atomic_long_set(&sem->owner, (long)waiter->task);
> +			atomic_long_add(adj, &sem->count);
> +			wake_q_add(&wake_q, waiter->task);
> +			rwsem_del_waiter(sem, waiter);
> +			waiter->task = NULL;	/* Signal the handoff */
> +			goto unlock_out;
> +		}
> +	}
> +	rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
>  
> +unlock_out:
>  	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
>  	wake_up_q(&wake_q);
>  

I am once again confused...

*WHY* are you changing the writer wake-up path? The comments added here
don't clarify anything.

If we set handoff, we terminate/disallow the spinning/stealing. The
direct consequence is that the slowpath/wait-list becomes the only way
forward.

Since we don't take wait_lock on up, we fundamentally have a race
condition. But *WHY* do you insist on handling that in rwsem_wake()?
Delaying all that until rwsem_try_write_lock()? Doing so would render
pretty much all of the above pointless, no?

After all, rwsem_mark_wake() already wakes the writer if it is first,
no? Why invent yet another special way to wake up the writer.


Also; and I asked this last time around; why do we care about the
handoff to writer *at*all* ? It is the readers that set HANDOFF.

