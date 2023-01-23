Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A47B677E89
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjAWPAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjAWPAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:00:05 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95BB7EF4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jx6xBwWV3KlZJYFqxaHCv2RNZl3akg1bI9wqD61dvfk=; b=KCKeQaiIqhIW+5XmEb/IwvdVSf
        SBZkuh0evsSSU3OU4UVhGzdUDqwPmDSAreUd2sgLcwbEBjfOW6/r83BVrCTYpMbBQjuw3v6fVfDk6
        D1HwkZayXUHJ/8rM5EOfMQvP/BVJlqBvcQIkElCZ4U9FOg5RUyNykcU2rlkc1q8ecqk2TvkQosVgF
        /BOef/VQmopJp+zdWeb5HbWnMAi6Qy1zs0vSjaKdQGW3mUCC9q5x6K2liyUhk3pDk9ldS9iPNqREU
        QxtUjdV10YC8Mn362miZUiEjQiIISfORKp19Ho4crZk6P8Yb9DgdLqJCL1CniFmyTNywvCLV424iY
        61Hpzqaw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pJyHi-001Z1D-2B;
        Mon, 23 Jan 2023 14:59:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B0BB830008D;
        Mon, 23 Jan 2023 15:59:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 882D0202471F1; Mon, 23 Jan 2023 15:59:26 +0100 (CET)
Date:   Mon, 23 Jan 2023 15:59:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Ting11 Wang =?utf-8?B?546L5am3?= <wangting11@xiaomi.com>
Subject: Re: [PATCH v6 5/6] locking/rwsem: Enable direct rwsem lock handoff
Message-ID: <Y86gzkVHlsOTY8QL@hirez.programming.kicks-ass.net>
References: <20221118022016.462070-1-longman@redhat.com>
 <20221118022016.462070-6-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118022016.462070-6-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 09:20:15PM -0500, Waiman Long wrote:
> The lock handoff provided in rwsem isn't a true handoff like that in
> the mutex. Instead, it is more like a quiescent state where optimistic
> spinning and lock stealing are disabled to make it easier for the first
> waiter to acquire the lock.
> 
> Reworking the code to enable a true lock handoff is more complex due to
> the following facts:
>  1) The RWSEM_FLAG_HANDOFF bit is protected by the wait_lock and it
>     is too expensive to always take the wait_lock in the unlock path
>     to prevent racing.

Specifically, the issue is that we'd need to turn the
atomic_long_add_return_release() into an atomic_try_cmpxchg_release()
loop, like:

	tmp = atomic_long_read(&sem->count);
	do {
		if (tmp & (WAITERS|HANDOFF))
			return slow_unock();
	} while (atomic_long_try_cmpxchg_release(&sem->count, &tmp,
						 tmp - RWSEM_{READER_BIAS,WRITE_LOCKED});

in order to not race with a concurrent setting of the HANDOFF bit,
right? And we don't like to turn unlock into a cmpxchg loop.

(OTOH we sorta do this for mutex, unconteded mutex has cmpxchg lock and
unlock, any fail and we go to the slow path -- I suppose the distinct
difference is that we sorta expect some contention on the read side)

>  2) The reader lock fast path may add a RWSEM_READER_BIAS at the wrong
>     time to prevent a proper lock handoff from a reader owned rwsem.

This would be much the same, right? We'd have to turn
rwsem_read_trylock() into a cmpxchg-loop and we don't like that.
Therefore we do that speculative add and fix up later.

Now, I'm not enturely sure what issue you allude to here; is the problem
that you can't quite tell when the last reader is gone?

> A lock handoff can only be initiated when the following conditions are
> true:
>  1) The RWSEM_FLAG_HANDOFF bit is set.

d'uh ;-)

>  2) The task to do the handoff don't see any other active lock
>     excluding the lock that it might have held.

2) here is the 2) above, right?

> The new handoff mechanism performs handoff in rwsem_wakeup() to minimize
> overhead. The rwsem count will be known at that point to determine if
> handoff should be done. However, there is a small time gap between the
> rwsem becomes free and the wait_lock is taken

Right, that's between atomic_long_fetch_add_release() and calling the
slow path because WAITERS bit is set.

> where a reader can come in and add a RWSEM_READER_BIAS to the count or

Both 2s above.

> the current first waiter can take the rwsem and clear
> RWSEM_FLAG_HANDOFF in the interim.

The actual intended action.

> That will fail the handoff operation.

I would not list that latter as a failure, it's exactly what we want to
happen, no?

> To handle the former case, a secondary handoff will also be done in
> the rwsem_down_read_slowpath() to catch it.

Right. In short:

Having HANDOVER set:
 - implies WAITERS set
 - disables all fastpaths (spinning or otherwise)
 - dis-allows anybody except first waiter to obtain lock

Therefore, having the window between clearing owner and prodding first
waiter is 'harmless'.

> With true lock handoff, there is no need to do a NULL owner spinning
> anymore as wakeup will be performed if handoff is possible. So it
> is likely that the first waiter won't actually go to sleep even when
> schedule() is called in this case.

Right, removing that NULL spinning was the whole purpose -- except I
seem to have forgotten why it was a problem :-)

OK, lemme go read the actual patch.

Hmmm... you made it a wee bit more complicated, instead of my 3rd clause
above, you added a whole intermediate GRANTED state. Why?

Since we fundamentally must deal with the release->wait_lock hole, why
do we need to do the whole rwsem_wake()->GRANTED->*_slowpath() dance?
Why can't we skip the whole rwsem_wake()->GRANTED part and only do
handoff in the slowpath?
