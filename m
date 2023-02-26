Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBD76A329A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBZQCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBZQCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:02:01 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFA310257
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 08:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xa7VjT4CRQrbYYzS7d+rfaPxV+rb2tyxrX3efVtfnBc=; b=ZOJ9RAfoDTbLN2RiZS0x0F9ozJ
        u6YVnW6SG45ORM1yylFv7BoEy3qvs40r8OhnPUmeZqMmOXzp3nELeW7fy8ZiftuQbuOhqQ80dGPK1
        s93yGk5b1LyYvA2YcHjfq1Q99VizV25xz4TrtHANC1MN6uzZ0Zh9XyqG3xHrtCxW0y/VeiwtbcUWW
        ESgElQY+yzxQYX2kWDMguIXebS+FPOqib5vLi+D7aI2vpyP6Rr3ZiJ1hbaLsd0zdkmhc178zrwjS6
        Dn/pubc3Q0pmJ2cXZHCi6Xt+xawgeCa+8lkYjiuURS0oeqnxlcvvbNRYDI4dbiJvTmbQRBoNhJoqD
        Nwlacrwg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pWIZp-00DwBq-0D;
        Sun, 26 Feb 2023 15:04:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AEA01300269;
        Sun, 26 Feb 2023 16:04:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F41B23A0ED63; Sun, 26 Feb 2023 16:04:35 +0100 (CET)
Date:   Sun, 26 Feb 2023 16:04:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     longman@redhat.com, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 3/6] locking/rwsem: Rework writer wakeup
Message-ID: <Y/t1AwGC9OoN/lFc@hirez.programming.kicks-ass.net>
References: <20230223122642.491637862@infradead.org>
 <20230223123319.487908155@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223123319.487908155@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 01:26:45PM +0100, Peter Zijlstra wrote:
> @@ -1072,7 +1067,7 @@ rwsem_down_read_slowpath(struct rw_semap
>  	for (;;) {
>  		set_current_state(state);
>  		if (!smp_load_acquire(&waiter.task)) {
> -			/* Matches rwsem_mark_wake()'s smp_store_release(). */
> +			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
>  			break;
>  		}
>  		if (signal_pending_state(state, current)) {
> @@ -1143,54 +1138,36 @@ rwsem_down_write_slowpath(struct rw_sema
>  	} else {
>  		atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);

Found it; if we remove the try_write_lock below, then at least this
new-waiter path needs to still do a trylock.

Let me go test the other patches on top of all this and push out a fresh
set if that all still works.

>  	}
> +	raw_spin_unlock_irq(&sem->wait_lock);
>  
>  	/* wait until we successfully acquire the lock */
> -	set_current_state(state);
>  	trace_contention_begin(sem, LCB_F_WRITE);
>  
>  	for (;;) {
> -		if (rwsem_try_write_lock(sem, &waiter)) {
> -			/* rwsem_try_write_lock() implies ACQUIRE on success */
> +		set_current_state(state);
> +		if (!smp_load_acquire(&waiter.task)) {
> +			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
>  			break;
>  		}
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
>  		}
> -
>  		schedule_preempt_disabled();
>  		lockevent_inc(rwsem_sleep_writer);
> -		set_current_state(state);
> -trylock_again:
> -		raw_spin_lock_irq(&sem->wait_lock);
>  	}
>  	__set_current_state(TASK_RUNNING);
> -	raw_spin_unlock_irq(&sem->wait_lock);
>  	lockevent_inc(rwsem_wlock);
>  	trace_contention_end(sem, 0);
>  	return sem;
>  
>  out_nolock:
> -	__set_current_state(TASK_RUNNING);
> -	raw_spin_lock_irq(&sem->wait_lock);
>  	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
> +	__set_current_state(TASK_RUNNING);
>  	lockevent_inc(rwsem_wlock_fail);
>  	trace_contention_end(sem, -EINTR);
>  	return ERR_PTR(-EINTR);
> 
> 
