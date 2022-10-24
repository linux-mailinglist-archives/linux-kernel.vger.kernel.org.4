Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AB160B746
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiJXTWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJXTV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:21:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D9C2DAB9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y76cDcGX4dVgey7lIKStdXOJ0UmbK2raI2xoFIhvPbI=; b=TxEb6imbx2gP032MNM5vpvrsOf
        owBuhzetNSGU5dtVOhDuJ8Hel66wTbN7NG1k+etLaj04ZMwgZ29lJ/SpnZ3+zGen+EuCA5xIdn7HC
        agzjvTOJfKH4FSWXFWnuFxvrOnIR1WlE73OddBVBFT8bMUAgR9aZAglN6qaHtXYbv1iVzIK78eCva
        D5gg44HiK/l0fUVsVmsZdVY2mYIdOf8XnJ9qnxXQ+hAjjmTKEjK2Aq9EecW/bHAKiwCx4yrg6U9L0
        TvFm7fYJegfIcYrrQgb9sUmxpFp9IaMmmLWDEa2B4BR6UIEbnAub/reEKwurAWaikuya3lK/QPQjn
        4fGNQ1lA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omxKu-00FSeP-8v; Mon, 24 Oct 2022 13:17:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39BD630069C;
        Mon, 24 Oct 2022 15:17:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E60D2029A1D9; Mon, 24 Oct 2022 15:17:42 +0200 (CEST)
Date:   Mon, 24 Oct 2022 15:17:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Ting11 Wang =?utf-8?B?546L5am3?= <wangting11@xiaomi.com>
Subject: Re: [PATCH v3 1/5] locking/rwsem: Prevent non-first waiter from
 spinning in down_write() slowpath
Message-ID: <Y1aQdlf7E7OgwoqO@hirez.programming.kicks-ass.net>
References: <20221017211356.333862-1-longman@redhat.com>
 <20221017211356.333862-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017211356.333862-2-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 05:13:52PM -0400, Waiman Long wrote:
> A non-first waiter can potentially spin in the for loop of
> rwsem_down_write_slowpath() without sleeping but fail to acquire the
> lock even if the rwsem is free if the following sequence happens:
> 
>   Non-first waiter       First waiter      Lock holder
>   ----------------       ------------      -----------
>   Acquire wait_lock
>   rwsem_try_write_lock():
>     Set handoff bit if RT or
>       wait too long
>     Set waiter->handoff_set
>   Release wait_lock
>                          Acquire wait_lock
>                          Inherit waiter->handoff_set
>                          Release wait_lock
> 					   Clear owner
>                                            Release lock
>   if (waiter.handoff_set) {
>     rwsem_spin_on_owner(();
>     if (OWNER_NULL)
>       goto trylock_again;
>   }
>   trylock_again:
>   Acquire wait_lock
>   rwsem_try_write_lock():
>      if (first->handoff_set && (waiter != first))
>      	return false;
>   Release wait_lock
> 
> It is especially problematic if the non-first waiter is an RT task and
> it is running on the same CPU as the first waiter as this can lead to
> live lock.

I'm struggling to connect the Changelog to the actual patch. I see the
problem, but I don't see how the below helps or is even related to the
described problem.

>  kernel/locking/rwsem.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 44873594de03..be2df9ea7c30 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -624,18 +624,16 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>  			 */
>  			if (first->handoff_set && (waiter != first))
>  				return false;
> -
> -			/*
> -			 * First waiter can inherit a previously set handoff
> -			 * bit and spin on rwsem if lock acquisition fails.
> -			 */
> -			if (waiter == first)
> -				waiter->handoff_set = true;
>  		}
>  
>  		new = count;
>  
>  		if (count & RWSEM_LOCK_MASK) {
> +			/*
> +			 * A waiter (first or not) can set the handoff bit
> +			 * if it is an RT task or wait in the wait queue
> +			 * for too long.
> +			 */
>  			if (has_handoff || (!rt_task(waiter->task) &&
>  					    !time_after(jiffies, waiter->timeout)))
>  				return false;
> @@ -651,11 +649,12 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>  	} while (!atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
>  
>  	/*
> -	 * We have either acquired the lock with handoff bit cleared or
> -	 * set the handoff bit.
> +	 * We have either acquired the lock with handoff bit cleared or set
> +	 * the handoff bit. Only the first waiter can have its handoff_set
> +	 * set here to enable optimistic spinning in slowpath loop.
>  	 */
>  	if (new & RWSEM_FLAG_HANDOFF) {
> -		waiter->handoff_set = true;
> +		first->handoff_set = true;
>  		lockevent_inc(rwsem_wlock_handoff);
>  		return false;
>  	}
> -- 
> 2.31.1
> 
