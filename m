Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1355FBEFA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 03:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJLByc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 21:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJLBya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 21:54:30 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5732DA4BA4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 18:54:28 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id f8so2267283qkg.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 18:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOv3BJ7T7opVvvRIpW/3q9EbOO/+JK6FaGVr6+4Ny9Q=;
        b=M6oAG02bgn+s4tIN7GimmzmjyN1n8j06TpjvIu2FYnHrdKEDs2TFz3+Yyapldh0rRR
         QN35vJGME0iglbMfDxqp9Qw5vLxxs/OsZ0vjx9bBSCkzl9Kxq+mqPuxTul8fEArR24QK
         Uhzu+c1UJwJMUIOp92xlVK+Wv8DfZgABd6VG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOv3BJ7T7opVvvRIpW/3q9EbOO/+JK6FaGVr6+4Ny9Q=;
        b=xzCYXM/SOwtt27xQrf1+joo2etCItZ4rMIn3g5pVkrglG+Wh1BYu1ZBsocqbnLNGrI
         ROj9vCAfO1NFtFlnSGF/n60sqX80+6y0CF31V5pnk4dEhYSXc5bd7ZlYaztytjRyMY6H
         O0anhd+qvUglm7ufIq2Ya8D0LHYyfaRvLLGBlrfZqp/Y/HCQbEocwAPbyxNtyc3Mp63l
         f1fLdBZhWDOhhmtH27/QiwznuicvKlFPNoI29MGoTDL63NrG7unNG7UrEY1vL/1AAugF
         ZjR61HRSK9B7vMZlcm8oAVq310wuxhV0YVLHJncm/QzAwsoHU1GyCu6q4keod9104AGb
         raqA==
X-Gm-Message-State: ACrzQf2UhKvtnTjjlfrJpqGY/QCX6g5P1ZavbJZUKln40NNqHKhqycWO
        xmjNglClrzbTPG87QEVAnOdGyw==
X-Google-Smtp-Source: AMsMyM6rZ4sllUOm6DRsSnQ2hvWsD3l5NxjSodLR6qws7+BorI42zMh41SqoX3kvUfm38tGp03rhaQ==
X-Received: by 2002:a37:511:0:b0:6ed:e638:4203 with SMTP id 17-20020a370511000000b006ede6384203mr7289893qkf.713.1665539667251;
        Tue, 11 Oct 2022 18:54:27 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id r9-20020a05620a298900b006b953a7929csm5451609qkp.73.2022.10.11.18.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 18:54:26 -0700 (PDT)
Date:   Wed, 12 Oct 2022 01:54:26 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Connor O'Brien <connoro@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, youssefesmat@google.com
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Message-ID: <Y0YeUhDZWb49mpLo@google.com>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-8-connoro@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003214501.2050087-8-connoro@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 03, 2022 at 09:44:57PM +0000, Connor O'Brien wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> A task currently holding a mutex (executing a critical section) might
> find benefit in using scheduling contexts of other tasks blocked on the
> same mutex if they happen to have higher priority of the current owner
> (e.g., to prevent priority inversions).
> 
> Proxy execution lets a task do exactly that: if a mutex owner has
> waiters, it can use waiters' scheduling context to potentially continue
> running if preempted.
> 
> The basic mechanism is implemented by this patch, the core of which
> resides in the proxy() function. Potential proxies (i.e., tasks blocked
> on a mutex) are not dequeued, so, if one of them is actually selected by
> schedule() as the next task to be put to run on a CPU, proxy() is used
> to walk the blocked_on relation and find which task (mutex owner) might
> be able to use the proxy's scheduling context.
> 
> Here come the tricky bits. In fact, owner task might be in all sort of
> states when a proxy is found (blocked, executing on a different CPU,
> etc.). Details on how to handle different situations are to be found in
> proxy() code comments.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> [rebased, added comments and changelog]
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> [Fixed rebase conflicts]
> [squashed sched: Ensure blocked_on is always guarded by blocked_lock]
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> [fix rebase conflicts, various fixes & tweaks commented inline]
> [squashed sched: Use rq->curr vs rq->proxy checks]
> Signed-off-by: Connor O'Brien <connoro@google.com>
> Link: https://lore.kernel.org/all/20181009092434.26221-6-juri.lelli@redhat.com/
[..]  
> +#ifdef CONFIG_PROXY_EXEC
> +
> +/*
> + * Find who @next (currently blocked on a mutex) can proxy for.
> + *
> + * Follow the blocked-on relation:
> + *
> + *                ,-> task
> + *                |     | blocked-on
> + *                |     v
> + *     proxied-by |   mutex
> + *                |     | owner
> + *                |     v
> + *                `-- task
> + *
> + * and set the proxied-by relation, this latter is used by the mutex code
> + * to find which (blocked) task to hand-off to.
> + *
> + * Lock order:
> + *
> + *   p->pi_lock
> + *     rq->lock
> + *       mutex->wait_lock
> + *         p->blocked_lock
> + *
> + * Returns the task that is going to be used as execution context (the one
> + * that is actually going to be put to run on cpu_of(rq)).
> + */
> +static struct task_struct *
> +proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)

Dang, this is intense ;-) , but cool..

Just some inital high level questions / comments from me:

> +{
> +	struct task_struct *p = next;
> +	struct task_struct *owner = NULL;
> +	struct mutex *mutex;
> +	struct rq *that_rq;
> +	int this_cpu, that_cpu;
> +	bool curr_in_chain = false;
> +	LIST_HEAD(migrate_list);
> +
> +	this_cpu = cpu_of(rq);
> +
> +	/*
> +	 * Follow blocked_on chain.
> +	 *
> +	 * TODO: deadlock detection
> +	 */

This function is awfully big and feels like it should be split up for
readability.

> +	for (p = next; p->blocked_on; p = owner) {
> +		mutex = p->blocked_on;
> +		/* Something changed in the chain, pick_again */
> +		if (!mutex)
> +			return NULL;
> +
> +		/*
> +		 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
> +		 * and ensure @owner sticks around.
> +		 */
> +		raw_spin_lock(&mutex->wait_lock);
> +		raw_spin_lock(&p->blocked_lock);
> +
> +		/* Check again that p is blocked with blocked_lock held */
> +		if (!task_is_blocked(p) || mutex != p->blocked_on) {
> +			/*
> +			 * Something changed in the blocked_on chain and
> +			 * we don't know if only at this level. So, let's
> +			 * just bail out completely and let __schedule
> +			 * figure things out (pick_again loop).
> +			 */
> +			raw_spin_unlock(&p->blocked_lock);
> +			raw_spin_unlock(&mutex->wait_lock);
> +			return NULL;
> +		}
> +
> +		if (task_current(rq, p))
> +			curr_in_chain = true;
> +
> +		owner = mutex_owner(mutex);
> +		/*
> +		 * XXX can't this be 0|FLAGS? See __mutex_unlock_slowpath for(;;)
> +		 * Mmm, OK, this can't probably happen because we force
> +		 * unlock to skip the for(;;) loop. Is this acceptable though?
> +		 */
> +		if (task_cpu(owner) != this_cpu)
> +			goto migrate_task;
> +
> +		if (task_on_rq_migrating(owner))
> +			goto migrating_task;
> +
> +		if (owner == p)
> +			goto owned_task;
> +
> +		if (!owner->on_rq)
> +			goto blocked_task;
> +
> +		/*
> +		 * OK, now we're absolutely sure @owner is not blocked _and_
> +		 * on this rq, therefore holding @rq->lock is sufficient to
> +		 * guarantee its existence, as per ttwu_remote().
> +		 */
> +		raw_spin_unlock(&p->blocked_lock);
> +		raw_spin_unlock(&mutex->wait_lock);
> +
> +		owner->blocked_proxy = p;
> +	}
> +
> +	WARN_ON_ONCE(!owner->on_rq);
> +
> +	return owner;

Here, for CFS, doesn't this mean that the ->vruntime of the blocked task does
not change while it is giving the owner a chance to run?

So that feels like if the blocked task is on the left-most node of the cfs
rbtree, then it will always proxy to the owner while not letting other
unrelated CFS tasks to run. That sounds like a breakage of fairness.

Or did I miss something?

> +
> +migrate_task:
> +	/*
> +	 * The blocked-on relation must not cross CPUs, if this happens
> +	 * migrate @p to the @owner's CPU.
> +	 *
> +	 * This is because we must respect the CPU affinity of execution
> +	 * contexts (@owner) but we can ignore affinity for scheduling
> +	 * contexts (@p). So we have to move scheduling contexts towards
> +	 * potential execution contexts.
> +	 *
> +	 * XXX [juril] what if @p is not the highest prio task once migrated
> +	 * to @owner's CPU?

Then that sounds like the right thing is happening, and @p will not proxy()
to @owner. Why does @p need to be highest prio?

> +	 *
> +	 * XXX [juril] also, after @p is migrated it is not migrated back once
> +	 * @owner releases the lock? Isn't this a potential problem w.r.t.
> +	 * @owner affinity settings?

Juri, Do you mean here, '@p affinity settings' ?  @p's affinity is being
ignored right?

> +	 * [juril] OK. It is migrated back into its affinity mask in
> +	 * ttwu_remote(), or by using wake_cpu via select_task_rq, guess we
> +	 * might want to add a comment about that here. :-)

Good idea!

I am also wondering, how much more run-queue lock contention do these
additional migrations add, that we did not have before. Do we have any data
on that? Too much migration should not negate benefits of PE hopefully.

thanks,

 - Joel





> +	 * TODO: could optimize by finding the CPU of the final owner
> +	 * and migrating things there. Given:
> +	 *
> +	 *	CPU0	CPU1	CPU2
> +	 *
> +	 *	 a ----> b ----> c
> +	 *
> +	 * the current scheme would result in migrating 'a' to CPU1,
> +	 * then CPU1 would migrate b and a to CPU2. Only then would
> +	 * CPU2 run c.
> +	 */
> +	that_cpu = task_cpu(owner);
> +	that_rq = cpu_rq(that_cpu);
> +	/*
> +	 * @owner can disappear, simply migrate to @that_cpu and leave that CPU
> +	 * to sort things out.
> +	 */
> +	raw_spin_unlock(&p->blocked_lock);
> +	raw_spin_unlock(&mutex->wait_lock);
> +
> +	/*
> +	 * Since we're going to drop @rq, we have to put(@next) first,
> +	 * otherwise we have a reference that no longer belongs to us.  Use
> +	 * @fake_task to fill the void and make the next pick_next_task()
> +	 * invocation happy.
> +	 *
> +	 * XXX double, triple think about this.
> +	 * XXX put doesn't work with ON_RQ_MIGRATE
> +	 *
> +	 * CPU0				CPU1
> +	 *
> +	 *				B mutex_lock(X)
> +	 *
> +	 * A mutex_lock(X) <- B
> +	 * A __schedule()
> +	 * A pick->A
> +	 * A proxy->B
> +	 * A migrate A to CPU1
> +	 *				B mutex_unlock(X) -> A
> +	 *				B __schedule()
> +	 *				B pick->A
> +	 *				B switch_to (A)
> +	 *				A ... does stuff
> +	 * A ... is still running here
> +	 *
> +	 *		* BOOM *
> +	 */
> +	put_prev_task(rq, next);
> +	if (curr_in_chain) {
> +		rq->proxy = rq->idle;
> +		set_tsk_need_resched(rq->idle);
> +		/*
> +		 * XXX [juril] don't we still need to migrate @next to
> +		 * @owner's CPU?
> +		 */
> +		return rq->idle;
> +	}
> +	rq->proxy = rq->idle;
> +
> +	for (; p; p = p->blocked_proxy) {
> +		int wake_cpu = p->wake_cpu;
> +
> +		WARN_ON(p == rq->curr);
> +
> +		deactivate_task(rq, p, 0);
> +		set_task_cpu(p, that_cpu);
> +		/*
> +		 * We can abuse blocked_entry to migrate the thing, because @p is
> +		 * still on the rq.
> +		 */
> +		list_add(&p->blocked_entry, &migrate_list);
> +
> +		/*
> +		 * Preserve p->wake_cpu, such that we can tell where it
> +		 * used to run later.
> +		 */
> +		p->wake_cpu = wake_cpu;
> +	}
> +
> +	rq_unpin_lock(rq, rf);
> +	raw_spin_rq_unlock(rq);
> +	raw_spin_rq_lock(that_rq);
> +
> +	while (!list_empty(&migrate_list)) {
> +		p = list_first_entry(&migrate_list, struct task_struct, blocked_entry);
> +		list_del_init(&p->blocked_entry);
> +
> +		enqueue_task(that_rq, p, 0);
> +		check_preempt_curr(that_rq, p, 0);
> +		p->on_rq = TASK_ON_RQ_QUEUED;
> +		/*
> +		 * check_preempt_curr has already called
> +		 * resched_curr(that_rq) in case it is
> +		 * needed.
> +		 */
> +	}
> +
> +	raw_spin_rq_unlock(that_rq);
> +	raw_spin_rq_lock(rq);
> +	rq_repin_lock(rq, rf);
> +
> +	return NULL; /* Retry task selection on _this_ CPU. */
> +
> +migrating_task:
> +	/*
> +	 * XXX connoro: one of the chain of mutex owners is currently
> +	 * migrating to this CPU, but has not yet been enqueued because
> +	 * we are holding the rq lock. As a simple solution, just schedule
> +	 * rq->idle to give the migration a chance to complete. Much like
> +	 * the migrate_task case we should end up back in proxy(), this
> +	 * time hopefully with all relevant tasks already enqueued.
> +	 */
> +	raw_spin_unlock(&p->blocked_lock);
> +	raw_spin_unlock(&mutex->wait_lock);
> +	put_prev_task(rq, next);
> +	rq->proxy = rq->idle;
> +	set_tsk_need_resched(rq->idle);
> +	return rq->idle;
> +owned_task:
> +	/*
> +	 * Its possible we interleave with mutex_unlock like:
> +	 *
> +	 *				lock(&rq->lock);
> +	 *				  proxy()
> +	 * mutex_unlock()
> +	 *   lock(&wait_lock);
> +	 *   next(owner) = current->blocked_proxy;
> +	 *   unlock(&wait_lock);
> +	 *
> +	 *   wake_up_q();
> +	 *     ...
> +	 *       ttwu_runnable()
> +	 *         __task_rq_lock()
> +	 *				  lock(&wait_lock);
> +	 *				  owner == p
> +	 *
> +	 * Which leaves us to finish the ttwu_runnable() and make it go.
> +	 *
> +	 * XXX is this happening in case of an HANDOFF to p?
> +	 * In any case, reading of the owner in __mutex_unlock_slowpath is
> +	 * done atomically outside wait_lock (only adding waiters to wake_q is
> +	 * done inside the critical section).
> +	 * Does this means we can get to proxy _w/o an owner_ if that was
> +	 * cleared before grabbing wait_lock? Do we account for this case?
> +	 * OK we actually do (see PROXY_EXEC ifdeffery in unlock function).
> +	 */
> +
> +	set_task_blocked_on(owner, NULL);
> +
> +	/*
> +	 * XXX connoro: previous versions would immediately run owner here if
> +	 * it's allowed to run on this CPU, but this creates potential races
> +	 * with the wakeup logic. Instead we can just take the blocked_task path
> +	 * when owner is already !on_rq, or else schedule rq->idle so that ttwu_runnable
> +	 * can get the rq lock and mark owner as running.
> +	 */
> +	if (!owner->on_rq)
> +		goto blocked_task;
> +
> +	raw_spin_unlock(&p->blocked_lock);
> +	raw_spin_unlock(&mutex->wait_lock);
> +	put_prev_task(rq, next);
> +	rq->proxy = rq->idle;
> +	set_tsk_need_resched(rq->idle);
> +	return rq->idle;
> +
> +blocked_task:
> +	/*
> +	 * XXX connoro: rq->curr must not be added to the blocked_entry list
> +	 * or else ttwu_do_activate could enqueue it elsewhere before it switches out
> +	 * here. The approach to avoiding this is the same as in the migrate_task case.
> +	 */
> +	if (curr_in_chain) {
> +		raw_spin_unlock(&p->blocked_lock);
> +		raw_spin_unlock(&mutex->wait_lock);
> +		put_prev_task(rq, next);
> +		rq->proxy = rq->idle;
> +		set_tsk_need_resched(rq->idle);
> +		return rq->idle;
> +	}
> +	/*
> +	 * If !@owner->on_rq, holding @rq->lock will not pin the task,
> +	 * so we cannot drop @mutex->wait_lock until we're sure its a blocked
> +	 * task on this rq.
> +	 *
> +	 * We use @owner->blocked_lock to serialize against ttwu_activate().
> +	 * Either we see its new owner->on_rq or it will see our list_add().
> +	 */
> +	if (owner != p) {
> +		raw_spin_unlock(&p->blocked_lock);
> +		raw_spin_lock(&owner->blocked_lock);
> +	}
> +
> +	/*
> +	 * Walk back up the blocked_proxy relation and enqueue them all on @owner
> +	 *
> +	 * ttwu_activate() will pick them up and place them on whatever rq
> +	 * @owner will run next.
> +	 * XXX connoro: originally we would jump back into the main proxy() loop
> +	 * owner->on_rq !=0 path, but if we then end up taking the owned_task path
> +	 * then we can overwrite p->on_rq after ttwu_do_activate sets it to 1 which breaks
> +	 * the assumptions made in ttwu_do_activate.
> +	 */
> +	if (!owner->on_rq) {
> +		for (; p; p = p->blocked_proxy) {
> +			if (p == owner)
> +				continue;
> +			BUG_ON(!p->on_rq);
> +			deactivate_task(rq, p, DEQUEUE_SLEEP);
> +			if (task_current_proxy(rq, p)) {
> +				put_prev_task(rq, next);
> +				rq->proxy = rq->idle;
> +			}
> +			/*
> +			 * XXX connoro: need to verify this is necessary. The rationale is that
> +			 * ttwu_do_activate must not have a chance to activate p elsewhere before
> +			 * it's fully extricated from its old rq.
> +			 */
> +			smp_mb();
> +			list_add(&p->blocked_entry, &owner->blocked_entry);
> +		}
> +	}
> +	if (task_current_proxy(rq, next)) {
> +		put_prev_task(rq, next);
> +		rq->proxy = rq->idle;
> +	}
> +	raw_spin_unlock(&owner->blocked_lock);
> +	raw_spin_unlock(&mutex->wait_lock);
> +
> +	return NULL; /* retry task selection */
> +}
> +#else /* PROXY_EXEC */
> +static struct task_struct *
> +proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
> +{
> +	return next;
> +}
> +#endif /* PROXY_EXEC */
> +
>  /*
>   * __schedule() is the main scheduler function.
>   *
> @@ -6447,7 +6984,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>  	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
>  		if (signal_pending_state(prev_state, prev)) {
>  			WRITE_ONCE(prev->__state, TASK_RUNNING);
> -		} else {
> +		} else if (!task_is_blocked(prev)) {
>  			prev->sched_contributes_to_load =
>  				(prev_state & TASK_UNINTERRUPTIBLE) &&
>  				!(prev_state & TASK_NOLOAD) &&
> @@ -6473,11 +7010,37 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>  				atomic_inc(&rq->nr_iowait);
>  				delayacct_blkio_start();
>  			}
> +		} else {
> +			/*
> +			 * XXX
> +			 * Let's make this task, which is blocked on
> +			 * a mutex, (push/pull)able (RT/DL).
> +			 * Unfortunately we can only deal with that by
> +			 * means of a dequeue/enqueue cycle. :-/
> +			 */
> +			dequeue_task(rq, prev, 0);
> +			enqueue_task(rq, prev, 0);
>  		}
>  		switch_count = &prev->nvcsw;
>  	}
>  
> -	rq->proxy = next = pick_next_task(rq, prev, &rf);
> +pick_again:
> +	/*
> +	 * If picked task is actually blocked it means that it can act as a
> +	 * proxy for the task that is holding the mutex picked task is blocked
> +	 * on. Get a reference to the blocked (going to be proxy) task here.
> +	 * Note that if next isn't actually blocked we will have rq->proxy ==
> +	 * rq->curr == next in the end, which is intended and means that proxy
> +	 * execution is currently "not in use".
> +	 */
> +	rq->proxy = next = pick_next_task(rq, rq->proxy, &rf);
> +	next->blocked_proxy = NULL;
> +	if (unlikely(task_is_blocked(next))) {
> +		next = proxy(rq, next, &rf);
> +		if (!next)
> +			goto pick_again;
> +	}
> +
>  	clear_tsk_need_resched(prev);
>  	clear_preempt_need_resched();
>  #ifdef CONFIG_SCHED_DEBUG
> @@ -6565,6 +7128,10 @@ static inline void sched_submit_work(struct task_struct *tsk)
>  	 */
>  	SCHED_WARN_ON(current->__state & TASK_RTLOCK_WAIT);
>  
> +	/* XXX still necessary? tsk_is_pi_blocked check here was deleted... */
> +	if (task_is_blocked(tsk))
> +		return;
> +
>  	/*
>  	 * If we are going to sleep and we have plugged IO queued,
>  	 * make sure to submit it to avoid deadlocks.
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d5ab7ff64fbc..5416d61e87e7 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1748,7 +1748,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
>  
>  	enqueue_dl_entity(&p->dl, flags);
>  
> -	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
> +	if (!task_current(rq, p) && p->nr_cpus_allowed > 1 && !task_is_blocked(p))
>  		enqueue_pushable_dl_task(rq, p);
>  }
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d142f0611b34..2d8e9f9c6826 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7370,7 +7370,9 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>  		goto idle;
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> -	if (!prev || prev->sched_class != &fair_sched_class)
> +	if (!prev ||
> +	    prev->sched_class != &fair_sched_class ||
> +	    rq->curr !=	rq->proxy)
>  		goto simple;
>  
>  	/*
> @@ -7888,6 +7890,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  
>  	lockdep_assert_rq_held(env->src_rq);
>  
> +	if (task_is_blocked(p))
> +		return 0;
> +
>  	/*
>  	 * We do not migrate tasks that are:
>  	 * 1) throttled_lb_pair, or
> @@ -7938,7 +7943,11 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  	/* Record that we found at least one task that could run on dst_cpu */
>  	env->flags &= ~LBF_ALL_PINNED;
>  
> -	if (task_running(env->src_rq, p)) {
> +	/*
> +	 * XXX mutex unlock path may have marked proxy as unblocked allowing us to
> +	 * reach this point, but we still shouldn't migrate it.
> +	 */
> +	if (task_running(env->src_rq, p) || task_current_proxy(env->src_rq, p)) {
>  		schedstat_inc(p->stats.nr_failed_migrations_running);
>  		return 0;
>  	}
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 116556f4fb0a..09385fcb1713 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1548,7 +1548,8 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
>  
>  	enqueue_rt_entity(rt_se, flags);
>  
> -	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
> +	if (!task_current(rq, p) && p->nr_cpus_allowed > 1 &&
> +	    !task_is_blocked(p))
>  		enqueue_pushable_task(rq, p);
>  }
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 0ef59dc7b8ea..354e75587fed 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2079,6 +2079,19 @@ static inline int task_current_proxy(struct rq *rq, struct task_struct *p)
>  	return rq->proxy == p;
>  }
>  
> +#ifdef CONFIG_PROXY_EXEC
> +static inline bool task_is_blocked(struct task_struct *p)
> +{
> +	return !!p->blocked_on;
> +}
> +#else /* !PROXY_EXEC */
> +static inline bool task_is_blocked(struct task_struct *p)
> +{
> +	return false;
> +}
> +
> +#endif /* PROXY_EXEC */
> +
>  static inline int task_running(struct rq *rq, struct task_struct *p)
>  {
>  #ifdef CONFIG_SMP
> @@ -2233,12 +2246,18 @@ struct sched_class {
>  
>  static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
>  {
> -	WARN_ON_ONCE(rq->proxy != prev);
> +	WARN_ON_ONCE(rq->curr != prev && prev != rq->proxy);
> +
> +	/* XXX connoro: is this check necessary? */
> +	if (prev == rq->proxy && task_cpu(prev) != cpu_of(rq))
> +		return;
> +
>  	prev->sched_class->put_prev_task(rq, prev);
>  }
>  
>  static inline void set_next_task(struct rq *rq, struct task_struct *next)
>  {
> +	WARN_ON_ONCE(!task_current_proxy(rq, next));
>  	next->sched_class->set_next_task(rq, next, false);
>  }
>  
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
