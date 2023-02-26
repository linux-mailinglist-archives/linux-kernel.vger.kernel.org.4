Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF946A2F57
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 13:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBZL7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 06:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBZL7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 06:59:21 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DA4A5C9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 03:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gYwB9ynkbLFlFzWA/o3htiyKvxFJV48vL8ZxyUW5WK0=; b=cznaStWcSqDLw01XpLagwfuqcX
        ymtoYD9LeeuSgOxCHLjm4X0MHZd0Mu05FYuJBhlU5c/1AkCAQpm4wgFV5hqNGgzcKLQNxkKvdnEPS
        FBTWnfkzLGUJ7prkXLsle26wu8G8WAygW6u8W7h72bA0fXoH27hRvij0meNk5IqTkVE4v5EOyaTjF
        X3o46nuyUteHfUG1IU5E4IjWRxsoEvs+6TfiL16S0inSVv6fh+wIIBuG5+zGUS28Y33E6851RNBbg
        ZdZ1msoZIhCYXdhS31KIs0rkVrAnVm1CQVyIj7KeFuDsI8gAR7x4KAp+dUMDqU0dfAr7bF75aI+KA
        2QS+GQYQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pWFgL-00Dtga-1r;
        Sun, 26 Feb 2023 11:59:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8AF6F300293;
        Sun, 26 Feb 2023 12:59:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A935203E17C9; Sun, 26 Feb 2023 12:59:08 +0100 (CET)
Date:   Sun, 26 Feb 2023 12:59:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     longman@redhat.com, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 3/6] locking/rwsem: Rework writer wakeup
Message-ID: <Y/tJjJMurN1uaC9V@hirez.programming.kicks-ass.net>
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

At the very least this needs to be:

	atomic_long_set(&sem->owner, (long)waiter->task);

> +	rwsem_waiter_wake(waiter, wake_q);
> +}
