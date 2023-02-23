Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182A06A122A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjBWVjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBWVjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:39:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551331A64F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 13:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677188293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kqgwoPDu0udxKVhnk8uvaBcBVYX5nSRw5GTuP6V+NFk=;
        b=c+paS85sSYVjYqtgcAPzMxCd47iGgVx9c7syP1KYYCyLpF1L3aFxYktw6mdA/S2eq/zI1L
        augM1Z4o/xCtamhCSa983vddC8IihMNBUuNBie8DeZwibGBTGFwvJu/a22soIslGbS7ok2
        I9D8Pbl62ulf5ie0yX+lkpZP8CHCDbI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-KNlCcAX6OmW5SR41J5EMkQ-1; Thu, 23 Feb 2023 16:38:09 -0500
X-MC-Unique: KNlCcAX6OmW5SR41J5EMkQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FD6729ABA1C;
        Thu, 23 Feb 2023 21:38:09 +0000 (UTC)
Received: from [10.22.16.134] (unknown [10.22.16.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 294C0C15BA0;
        Thu, 23 Feb 2023 21:38:09 +0000 (UTC)
Message-ID: <bf2948c4-dd6a-1cf6-16b5-39e5e17ef72a@redhat.com>
Date:   Thu, 23 Feb 2023 16:38:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/6] locking/rwsem: Rework writer wakeup
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        will@kernel.org
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com
References: <20230223122642.491637862@infradead.org>
 <20230223123319.487908155@infradead.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230223123319.487908155@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/23 07:26, Peter Zijlstra wrote:
> Currently readers and writers have distinctly different wait/wake
> methods. For readers the ->count adjustment happens on the wakeup
> side, while for writers the ->count adjustment happens on the wait
> side.
>
> This asymmetry is unfortunate since the wake side has an additional
> guarantee -- specifically, the wake side has observed the unlocked
> state, and thus it can know that speculative READER_BIAS perbutations
> on ->count are just that, they will be undone.
>
> Additionally, unifying the wait/wake methods allows sharing code.
>
> As such, do a straight-forward transform of the writer wakeup into the
> wake side.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   kernel/locking/rwsem.c |  253 ++++++++++++++++++++++---------------------------
>   1 file changed, 115 insertions(+), 138 deletions(-)
>
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -107,7 +107,7 @@
>    *
>    * There are three places where the lock handoff bit may be set or cleared.
>    * 1) rwsem_mark_wake() for readers		-- set, clear
> - * 2) rwsem_try_write_lock() for writers	-- set, clear
> + * 2) rwsem_writer_wake() for writers	-- set, clear
>    * 3) rwsem_del_waiter()			-- clear
>    *
>    * For all the above cases, wait_lock will be held. A writer must also
> @@ -377,7 +377,7 @@ rwsem_add_waiter(struct rw_semaphore *se
>   /*
>    * Remove a waiter from the wait_list and clear flags.
>    *
> - * Both rwsem_mark_wake() and rwsem_try_write_lock() contain a full 'copy' of
> + * Both rwsem_mark_wake() and rwsem_writer_wake() contain a full 'copy' of
>    * this function. Modify with care.
>    *
>    * Return: true if wait_list isn't empty and false otherwise
> @@ -394,6 +394,100 @@ rwsem_del_waiter(struct rw_semaphore *se
>   	return false;
>   }
>   
> +static inline void
> +rwsem_waiter_wake(struct rwsem_waiter *waiter, struct wake_q_head *wake_q)
> +{
> +	struct task_struct *tsk;
> +
> +	tsk = waiter->task;
> +	get_task_struct(tsk);
> +
> +	/*
> +	 * Ensure calling get_task_struct() before setting the reader
> +	 * waiter to nil such that rwsem_down_read_slowpath() cannot
> +	 * race with do_exit() by always holding a reference count
> +	 * to the task to wakeup.
> +	 */
> +	smp_store_release(&waiter->task, NULL);
> +	/*
> +	 * Ensure issuing the wakeup (either by us or someone else)
> +	 * after setting the reader waiter to nil.
> +	 */
> +	wake_q_add_safe(wake_q, tsk);
> +}
> +
> +/*
> + * This function must be called with the sem->wait_lock held to prevent
> + * race conditions between checking the rwsem wait list and setting the
> + * sem->count accordingly.
> + *
> + * Implies rwsem_del_waiter() on success.
> + */
> +static void rwsem_writer_wake(struct rw_semaphore *sem,
> +			      struct rwsem_waiter *waiter,
> +			      struct wake_q_head *wake_q)
> +{
> +	struct rwsem_waiter *first = rwsem_first_waiter(sem);
> +	long count, new;
> +
> +	lockdep_assert_held(&sem->wait_lock);
> +
> +	count = atomic_long_read(&sem->count);
> +	do {
> +		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
> +
> +		if (has_handoff) {
> +			/*
> +			 * Honor handoff bit and yield only when the first
> +			 * waiter is the one that set it. Otherwisee, we
> +			 * still try to acquire the rwsem.
> +			 */
> +			if (first->handoff_set && (waiter != first))
> +				return;
> +		}
This "if" statement if for a non-first waiter that somehow got woken up 
to have a chance to steal the lock. Now the handoff is done in the wake 
side for the first waiter, this "if" statement is not applicable and can 
be removed.
> +
> +		new = count;
> +
> +		if (count & RWSEM_LOCK_MASK) {
> +			/*
> +			 * A waiter (first or not) can set the handoff bit
> +			 * if it is an RT task or wait in the wait queue
> +			 * for too long.
> +			 */
> +			if (has_handoff || (!rt_task(waiter->task) &&
> +					    !time_after(jiffies, waiter->timeout)))
> +				return;
> +
> +			new |= RWSEM_FLAG_HANDOFF;
> +		} else {
> +			new |= RWSEM_WRITER_LOCKED;
> +			new &= ~RWSEM_FLAG_HANDOFF;
> +
> +			if (list_is_singular(&sem->wait_list))
> +				new &= ~RWSEM_FLAG_WAITERS;
> +		}
> +	} while (!atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
> +
> +	/*
> +	 * We have either acquired the lock with handoff bit cleared or set
> +	 * the handoff bit. Only the first waiter can have its handoff_set
> +	 * set here to enable optimistic spinning in slowpath loop.
> +	 */
> +	if (new & RWSEM_FLAG_HANDOFF) {
> +		first->handoff_set = true;
> +		lockevent_inc(rwsem_wlock_handoff);
> +		return;
> +	}
> +
> +	/*
> +	 * Have rwsem_writer_wake() fully imply rwsem_del_waiter() on
> +	 * success.
> +	 */
> +	list_del(&waiter->list);
> +	rwsem_set_owner(sem);
> +	rwsem_waiter_wake(waiter, wake_q);
> +}
> +
>   /*
>    * handle the lock release when processes blocked on it that can now run
>    * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
> @@ -424,23 +518,12 @@ static void rwsem_mark_wake(struct rw_se
>   	 */
>   	waiter = rwsem_first_waiter(sem);
>   
> -	if (waiter->type != RWSEM_WAITING_FOR_WRITE)
> -		goto wake_readers;
> -
> -	if (wake_type == RWSEM_WAKE_ANY) {
> -		/*
> -		 * Mark writer at the front of the queue for wakeup.
> -		 * Until the task is actually later awoken later by
> -		 * the caller, other writers are able to steal it.
> -		 * Readers, on the other hand, will block as they
> -		 * will notice the queued writer.
> -		 */
> -		wake_q_add(wake_q, waiter->task);
> -		lockevent_inc(rwsem_wake_writer);
> +	if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
> +		if (wake_type == RWSEM_WAKE_ANY)
> +			rwsem_writer_wake(sem, waiter, wake_q);
> +		return;
>   	}
> -	return;
>   
> -wake_readers:
>   	/*
>   	 * No reader wakeup if there are too many of them already.
>   	 */
> @@ -547,25 +630,8 @@ static void rwsem_mark_wake(struct rw_se
>   		atomic_long_add(adjustment, &sem->count);
>   
>   	/* 2nd pass */
> -	list_for_each_entry_safe(waiter, tmp, &wlist, list) {
> -		struct task_struct *tsk;
> -
> -		tsk = waiter->task;
> -		get_task_struct(tsk);
> -
> -		/*
> -		 * Ensure calling get_task_struct() before setting the reader
> -		 * waiter to nil such that rwsem_down_read_slowpath() cannot
> -		 * race with do_exit() by always holding a reference count
> -		 * to the task to wakeup.
> -		 */
> -		smp_store_release(&waiter->task, NULL);
> -		/*
> -		 * Ensure issuing the wakeup (either by us or someone else)
> -		 * after setting the reader waiter to nil.
> -		 */
> -		wake_q_add_safe(wake_q, tsk);
> -	}
> +	list_for_each_entry_safe(waiter, tmp, &wlist, list)
> +		rwsem_waiter_wake(waiter, wake_q);
>   }
>   
>   /*
> @@ -596,77 +662,6 @@ rwsem_del_wake_waiter(struct rw_semaphor
>   }
>   
>   /*
> - * This function must be called with the sem->wait_lock held to prevent
> - * race conditions between checking the rwsem wait list and setting the
> - * sem->count accordingly.
> - *
> - * Implies rwsem_del_waiter() on success.
> - */
> -static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
> -					struct rwsem_waiter *waiter)
> -{
> -	struct rwsem_waiter *first = rwsem_first_waiter(sem);
> -	long count, new;
> -
> -	lockdep_assert_held(&sem->wait_lock);
> -
> -	count = atomic_long_read(&sem->count);
> -	do {
> -		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
> -
> -		if (has_handoff) {
> -			/*
> -			 * Honor handoff bit and yield only when the first
> -			 * waiter is the one that set it. Otherwisee, we
> -			 * still try to acquire the rwsem.
> -			 */
> -			if (first->handoff_set && (waiter != first))
> -				return false;
> -		}
> -
> -		new = count;
> -
> -		if (count & RWSEM_LOCK_MASK) {
> -			/*
> -			 * A waiter (first or not) can set the handoff bit
> -			 * if it is an RT task or wait in the wait queue
> -			 * for too long.
> -			 */
> -			if (has_handoff || (!rt_task(waiter->task) &&
> -					    !time_after(jiffies, waiter->timeout)))
> -				return false;
> -
> -			new |= RWSEM_FLAG_HANDOFF;
> -		} else {
> -			new |= RWSEM_WRITER_LOCKED;
> -			new &= ~RWSEM_FLAG_HANDOFF;
> -
> -			if (list_is_singular(&sem->wait_list))
> -				new &= ~RWSEM_FLAG_WAITERS;
> -		}
> -	} while (!atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
> -
> -	/*
> -	 * We have either acquired the lock with handoff bit cleared or set
> -	 * the handoff bit. Only the first waiter can have its handoff_set
> -	 * set here to enable optimistic spinning in slowpath loop.
> -	 */
> -	if (new & RWSEM_FLAG_HANDOFF) {
> -		first->handoff_set = true;
> -		lockevent_inc(rwsem_wlock_handoff);
> -		return false;
> -	}
> -
> -	/*
> -	 * Have rwsem_try_write_lock() fully imply rwsem_del_waiter() on
> -	 * success.
> -	 */
> -	list_del(&waiter->list);
> -	rwsem_set_owner(sem);
> -	return true;
> -}
> -
> -/*
>    * The rwsem_spin_on_owner() function returns the following 4 values
>    * depending on the lock owner state.
>    *   OWNER_NULL  : owner is currently NULL
> @@ -1072,7 +1067,7 @@ rwsem_down_read_slowpath(struct rw_semap
>   	for (;;) {
>   		set_current_state(state);
>   		if (!smp_load_acquire(&waiter.task)) {
> -			/* Matches rwsem_mark_wake()'s smp_store_release(). */
> +			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
>   			break;
>   		}
>   		if (signal_pending_state(state, current)) {
> @@ -1143,54 +1138,36 @@ rwsem_down_write_slowpath(struct rw_sema
>   	} else {
>   		atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
>   	}
> +	raw_spin_unlock_irq(&sem->wait_lock);
>   
>   	/* wait until we successfully acquire the lock */
> -	set_current_state(state);
>   	trace_contention_begin(sem, LCB_F_WRITE);
>   
>   	for (;;) {
> -		if (rwsem_try_write_lock(sem, &waiter)) {
> -			/* rwsem_try_write_lock() implies ACQUIRE on success */
> +		set_current_state(state);
> +		if (!smp_load_acquire(&waiter.task)) {
> +			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
>   			break;
>   		}
> -
> -		raw_spin_unlock_irq(&sem->wait_lock);
> -
> -		if (signal_pending_state(state, current))
> -			goto out_nolock;
> -
> -		/*
> -		 * After setting the handoff bit and failing to acquire
> -		 * the lock, attempt to spin on owner to accelerate lock
> -		 * transfer. If the previous owner is a on-cpu writer and it
> -		 * has just released the lock, OWNER_NULL will be returned.
> -		 * In this case, we attempt to acquire the lock again
> -		 * without sleeping.
> -		 */
> -		if (waiter.handoff_set) {
> -			enum owner_state owner_state;
> -
> -			owner_state = rwsem_spin_on_owner(sem);
> -			if (owner_state == OWNER_NULL)
> -				goto trylock_again;
> +		if (signal_pending_state(state, current)) {
> +			raw_spin_lock_irq(&sem->wait_lock);
> +			if (waiter.task)
> +				goto out_nolock;
> +			raw_spin_unlock_irq(&sem->wait_lock);
> +			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
> +			break;
>   		}
> -
>   		schedule_preempt_disabled();
>   		lockevent_inc(rwsem_sleep_writer);
> -		set_current_state(state);
> -trylock_again:
> -		raw_spin_lock_irq(&sem->wait_lock);
>   	}
>   	__set_current_state(TASK_RUNNING);
> -	raw_spin_unlock_irq(&sem->wait_lock);
>   	lockevent_inc(rwsem_wlock);
>   	trace_contention_end(sem, 0);
>   	return sem;
>   
>   out_nolock:
> -	__set_current_state(TASK_RUNNING);
> -	raw_spin_lock_irq(&sem->wait_lock);
>   	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
> +	__set_current_state(TASK_RUNNING);
>   	lockevent_inc(rwsem_wlock_fail);
>   	trace_contention_end(sem, -EINTR);
>   	return ERR_PTR(-EINTR);

I believe it is better to change state inside the wait_lock critical 
section to provide a release barrier for free.

Cheers,
Longman

