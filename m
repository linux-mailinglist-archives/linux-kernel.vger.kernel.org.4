Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEFA6A2F58
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 13:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBZMAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 07:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBZMAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 07:00:36 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323E810243
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 04:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4P7S7ys9f5T4EFYxejrQB0gC4941kvhcWft63v8+UoM=; b=Xzw59T5ynzVfr/ZHAGTslgsIAY
        K8RPI6jOZcBAcaHTezrDtbsHqz1DT2TN4gJ0U7tUaUQzZMOc4ZQT6XjCeZ2M6RKEW7J9Ij8j26VBa
        tUSFJjL4Fjx0zRzOe9QSBDJ+tMqelkmPahqX93U0HeqiHHVIZfg8a7Aaal+Ku6w1iNLy71kb4batg
        KSzYPqiVY4F/VDMHxD2/vAOyq4yrhPA1IanPX8HG5C+E70BRwjgvzj8ts4zrV3ciEIsrUH/kmV06e
        5DzAVBJulAubsCYsu0Np+Qa3VW8Gr+BsaQ6NHopU7ujI3XDWDelijqSGHt/xqoTojRnqV0xOBHT7q
        GPoV8Q8g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pWFhb-00Dtho-0q;
        Sun, 26 Feb 2023 12:00:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC5AC300380;
        Sun, 26 Feb 2023 13:00:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE3A6203E17C9; Sun, 26 Feb 2023 13:00:26 +0100 (CET)
Date:   Sun, 26 Feb 2023 13:00:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com
Subject: Re: [PATCH 3/6] locking/rwsem: Rework writer wakeup
Message-ID: <Y/tJ2n1e22YhsZ17@hirez.programming.kicks-ass.net>
References: <20230223122642.491637862@infradead.org>
 <20230223123319.487908155@infradead.org>
 <bf2948c4-dd6a-1cf6-16b5-39e5e17ef72a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf2948c4-dd6a-1cf6-16b5-39e5e17ef72a@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 04:38:08PM -0500, Waiman Long wrote:

> > @@ -1143,54 +1138,36 @@ rwsem_down_write_slowpath(struct rw_sema
> >   	} else {
> >   		atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
> >   	}
> > +	raw_spin_unlock_irq(&sem->wait_lock);
> >   	/* wait until we successfully acquire the lock */
> > -	set_current_state(state);
> >   	trace_contention_begin(sem, LCB_F_WRITE);
> >   	for (;;) {
> > -		if (rwsem_try_write_lock(sem, &waiter)) {
> > -			/* rwsem_try_write_lock() implies ACQUIRE on success */
> > +		set_current_state(state);
> > +		if (!smp_load_acquire(&waiter.task)) {
> > +			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
> >   			break;
> >   		}
> > -
> > -		raw_spin_unlock_irq(&sem->wait_lock);
> > -
> > -		if (signal_pending_state(state, current))
> > -			goto out_nolock;
> > -
> > -		/*
> > -		 * After setting the handoff bit and failing to acquire
> > -		 * the lock, attempt to spin on owner to accelerate lock
> > -		 * transfer. If the previous owner is a on-cpu writer and it
> > -		 * has just released the lock, OWNER_NULL will be returned.
> > -		 * In this case, we attempt to acquire the lock again
> > -		 * without sleeping.
> > -		 */
> > -		if (waiter.handoff_set) {
> > -			enum owner_state owner_state;
> > -
> > -			owner_state = rwsem_spin_on_owner(sem);
> > -			if (owner_state == OWNER_NULL)
> > -				goto trylock_again;
> > +		if (signal_pending_state(state, current)) {
> > +			raw_spin_lock_irq(&sem->wait_lock);
> > +			if (waiter.task)
> > +				goto out_nolock;
> > +			raw_spin_unlock_irq(&sem->wait_lock);
> > +			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
> > +			break;
> >   		}
> > -
> >   		schedule_preempt_disabled();
> >   		lockevent_inc(rwsem_sleep_writer);
> > -		set_current_state(state);
> > -trylock_again:
> > -		raw_spin_lock_irq(&sem->wait_lock);
> >   	}
> >   	__set_current_state(TASK_RUNNING);
> > -	raw_spin_unlock_irq(&sem->wait_lock);
> >   	lockevent_inc(rwsem_wlock);
> >   	trace_contention_end(sem, 0);
> >   	return sem;
> >   out_nolock:
> > -	__set_current_state(TASK_RUNNING);
> > -	raw_spin_lock_irq(&sem->wait_lock);
> >   	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
> > +	__set_current_state(TASK_RUNNING);
> >   	lockevent_inc(rwsem_wlock_fail);
> >   	trace_contention_end(sem, -EINTR);
> >   	return ERR_PTR(-EINTR);
> 
> I believe it is better to change state inside the wait_lock critical section
> to provide a release barrier for free.

I can't follow... a release for what? Note that the reader slowpath has
this exact form already.


