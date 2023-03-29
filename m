Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA7E6CD0D1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjC2DqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjC2Dp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583D926AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 20:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680061511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aSDDiMH0p9WcBAlTXqJi3wXATdVEQgYiEh/ApzzCZ+E=;
        b=FkqbWys/0iE8s5f3fHsHponQNEz4O62HJ/2oS78VaeHoyCB8yN5mud7b8/r0yInbcZKTxU
        q7jmJ+kRfDGrtSKfDSvXBlmqjCe/5aJZpBgVafEdRE/vkCdSoPFnz4bUKAasyNMUHttq+6
        hRoo7w0NhomU88WVSmOGd9+CJzinE3Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-L24i7gjiMWyGwUQzQL2r2w-1; Tue, 28 Mar 2023 23:45:07 -0400
X-MC-Unique: L24i7gjiMWyGwUQzQL2r2w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED8061C041A0;
        Wed, 29 Mar 2023 03:45:06 +0000 (UTC)
Received: from [10.22.18.156] (unknown [10.22.18.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFD92492C3E;
        Wed, 29 Mar 2023 03:45:06 +0000 (UTC)
Message-ID: <8b0b7f01-c286-0650-9600-c66467569e93@redhat.com>
Date:   Tue, 28 Mar 2023 23:45:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 8/8] locking/rwsem: Restore old write lock slow path
 behavior
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20230327202413.1955856-1-longman@redhat.com>
 <20230327202413.1955856-9-longman@redhat.com>
 <20230328140259.GF4253@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230328140259.GF4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/23 10:02, Peter Zijlstra wrote:
> On Mon, Mar 27, 2023 at 04:24:13PM -0400, Waiman Long wrote:
>
>>   kernel/locking/rwsem.c | 34 +++++++++++++++++++++++++++++++---
>>   1 file changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>> index 7bd26e64827a..cf9dc1e250e0 100644
>> --- a/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -426,6 +426,7 @@ rwsem_waiter_wake(struct rwsem_waiter *waiter, struct wake_q_head *wake_q)
>>   static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>>   					struct rwsem_waiter *waiter)
>>   {
>> +	bool first = (rwsem_first_waiter(sem) == waiter);
>>   	long count, new;
>>   
>>   	lockdep_assert_held(&sem->wait_lock);
>> @@ -434,6 +435,9 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>>   	do {
>>   		new = count;
>>   
>> +		if (!first && (count & (RWSEM_FLAG_HANDOFF | RWSEM_LOCK_MASK)))
>> +			return false;
>> +
>>   		if (count & RWSEM_LOCK_MASK) {
>>   			/*
>>   			 * A waiter (first or not) can set the handoff bit
> I couldn't immediately make sense of the above, and I think there's case
> where not-first would still want to set handoff you're missing.

It is possible to do that, but we need a minor change to make sure that 
you set the handoff_set flag of the first waiter instead of the current 
waiter which is what the current rwsem code is doing. Other than that, I 
think the change is OK, though I need to take a further look into it 
tomorrow as it is now late for me too.

Cheers,
longman

>
> After a few detours, I ended up with the below; does that make sense or
> did I just make a bigger mess? (entirely possible due to insufficient
> sleep etc..).
>
>
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -426,12 +426,27 @@ rwsem_waiter_wake(struct rwsem_waiter *w
>   static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>   					struct rwsem_waiter *waiter)
>   {
> +	bool first = (rwsem_first_waiter(sem) == waiter);
>   	long count, new;
>   
>   	lockdep_assert_held(&sem->wait_lock);
>   
>   	count = atomic_long_read(&sem->count);
>   	do {
> +		/*
> +		 * first handoff
> +		 *
> +		 *   0     0     | take
> +		 *   0     1     | not take
> +		 *   1     0     | take
> +		 *   1     1     | take
> +		 *
> +		 */
> +		bool handoff = count & RWSEM_FLAG_HANDOFF;
> +
> +		if (!first && handoff)
> +			return false;
> +
>   		new = count;
>   
>   		if (count & RWSEM_LOCK_MASK) {
> @@ -440,7 +455,7 @@ static inline bool rwsem_try_write_lock(
>   			 * if it is an RT task or wait in the wait queue
>   			 * for too long.
>   			 */
> -			if ((count & RWSEM_FLAG_HANDOFF) ||
> +			if (handoff ||
>   			    (!rt_task(waiter->task) &&
>   			     !time_after(jiffies, waiter->timeout)))
>   				return false;
> @@ -501,11 +516,19 @@ static void rwsem_writer_wake(struct rw_
>   		 */
>   		list_del(&waiter->list);
>   		atomic_long_set(&sem->owner, (long)waiter->task);
> -
> -	} else if (!rwsem_try_write_lock(sem, waiter))
> +		rwsem_waiter_wake(waiter, wake_q);
>   		return;
> +	}
>   
> -	rwsem_waiter_wake(waiter, wake_q);
> +	/*
> +	 * Mark writer at the front of the queue for wakeup.
> +	 *
> +	 * Until the task is actually awoken later by the caller, other writers
> +	 * are able to steal it. Readers, on the other hand, will block as they
> +	 * will notice the queued writer.
> +	 */
> +	wake_q_add(wake_q, waiter->task);
> +	lockevent_inc(rwsem_wake_writer);
>   }
>   
>   static void rwsem_reader_wake(struct rw_semaphore *sem,
> @@ -1038,6 +1061,25 @@ rwsem_waiter_wait(struct rw_semaphore *s
>   			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
>   			break;
>   		}
> +		if (!reader) {
> +			/*
> +			 * If rwsem_writer_wake() did not take the lock, we must
> +			 * rwsem_try_write_lock() here.
> +			 */
> +			raw_spin_lock_irq(&sem->wait_lock);
> +			if (waiter->task && rwsem_try_write_lock(sem, waiter)) {
> +				waiter->task = NULL;
> +				raw_spin_unlock_irq(&sem->wait_lock);
> +				break;
> +			}
> +			raw_spin_unlock_irq(&sem->wait_lock);
> +
> +			if (waiter->handoff_set)
> +				rwsem_spin_on_owner(sem);
> +
> +			if (!smp_load_acquire(&waiter->task))
> +				break;
> +		}
>   		if (signal_pending_state(state, current)) {
>   			raw_spin_lock_irq(&sem->wait_lock);
>   			if (waiter->task)
>

