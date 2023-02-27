Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9D46A3F7A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjB0KbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjB0KbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:31:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F971A485
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 02:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ejmSjp5ilFhyYrBBpq16zUoi1mBnjuRQo93r6GReCME=; b=tqeL5joEcDckVW9arljhlxpppL
        Egb7aGR4EY0KknodHfMPreGW4IZfd6FBWW+V3em+kp4WDyN0Bw9RDQKzY1v4t/u1POHtMuiKZ4gmO
        MnvwOYI4tNvpyctq3wV51QTiSPHTJGfIafDv4HYRaexVRWF8u6QAogDm93rqIDt9YOIrzoTp0yxZb
        jd81z0gXEfWIuHZ/SGmsbmBKdsQjKCq0T8PmVkaeSuwwW1MD0eRoyMX4prBs2o+c3y+0d7hmx/TGS
        ccaUZwPB21UWTCQo5smVuBjaWoc97iRVUA6RUtmJUn9qBH/r1zOClb6K4XOanO2Tkwjmf9zSHgEcD
        LP7bpENA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWamd-0002JJ-DR; Mon, 27 Feb 2023 10:31:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55B0A30049E;
        Mon, 27 Feb 2023 11:31:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F13922F1DD83; Mon, 27 Feb 2023 11:31:02 +0100 (CET)
Date:   Mon, 27 Feb 2023 11:31:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com
Subject: Re: [PATCH 3/6] locking/rwsem: Rework writer wakeup
Message-ID: <Y/yGZgz1cJ1+pTt5@hirez.programming.kicks-ass.net>
References: <20230223122642.491637862@infradead.org>
 <20230223123319.487908155@infradead.org>
 <Y/t1AwGC9OoN/lFc@hirez.programming.kicks-ass.net>
 <Y/uN+89FlTw45uiA@hirez.programming.kicks-ass.net>
 <943686ee-975d-a463-46d1-04b200ac19b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <943686ee-975d-a463-46d1-04b200ac19b1@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 07:22:47PM -0500, Waiman Long wrote:

> @@ -1151,55 +1154,39 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem,
> int state)
>                 }
>         } else {
>                 atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
> +               if (rwsem_try_write_lock(sem, &waiter))
> +                       waiter.task = NULL;
>         }
> +       raw_spin_unlock_irq(&sem->wait_lock);
> 
>         /* wait until we successfully acquire the lock */
> -       set_current_state(state);
>         trace_contention_begin(sem, LCB_F_WRITE);
> 
>         for (;;) {
> -               if (rwsem_try_write_lock(sem, &waiter)) {
> -                       /* rwsem_try_write_lock() implies ACQUIRE on success
> */
> +               set_current_state(state);
> +               if (!smp_load_acquire(&waiter.task)) {
> +                       /* Matches rwsem_waiter_wake()'s
> smp_store_release(). */
>                         break;
>                 }
> -
> 
> The additional rwsem_try_write_lock() call seems to address the missed
> wakeup problem AFAICT.

Indeed, prior to this I could readily reproduce the lockup.

So when thinking about missing wakeups I noticed this race on WAITERS.
If we queue but the unlock does not yet observe WAITERS the unlock does
not go into the slow path and wakeup gets lost.

Reader side fixes this with rwsem_cond_wake_waiter(), but I could not
convince myself that is correct for writer side -- perhaps it is, will
need to think more on that.

> I do have some concern that early lock transfer to a lock owner that has not
> been woken up yet may suppress writer lock stealing from optimistic spinning
> causing some performance regression in some cases. Let's see if the test
> robot report anything.

Ah yes, I suppose that is indeed a possibility. Given this is all under
wait_lock and the spinner is not, I was hoping it would still have
sufficient time to win. But yes, robots will tell us.
