Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A4A694DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjBMRPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBMRPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:15:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CD41E28A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676308504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3kqESg62a3aj2Nvo/thxnnB5v485nRBdfpF0XgkSSY=;
        b=ctRW6sdpqUw7bZyiyFGCbmoHUeXItqIa/LYn622BKxLioiHn9OOE+7U8xf2Ch1VtZijgzz
        MpMj/Ha/mycTzNeqzKdg9xf1OmQGIc92XpaSRtgoeZzR0/vTqtX7WDRVcYE9WyNckeMQvi
        yOhmID929D8G+hEvofUjkQh2dgSDZk4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-lYerhqYSOyO8KXJrrPPDfw-1; Mon, 13 Feb 2023 12:15:01 -0500
X-MC-Unique: lYerhqYSOyO8KXJrrPPDfw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 754763810B08;
        Mon, 13 Feb 2023 17:15:00 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA4FA2026D4B;
        Mon, 13 Feb 2023 17:14:59 +0000 (UTC)
Message-ID: <19c54f55-3b27-6777-e42c-8d7b25b6f2b5@redhat.com>
Date:   Mon, 13 Feb 2023 12:14:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 4/4] locking/rwsem: Enable direct rwsem lock handoff
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20230126003628.365092-1-longman@redhat.com>
 <20230126003628.365092-5-longman@redhat.com>
 <Y+otv+QGyMpHAFO1@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y+otv+QGyMpHAFO1@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 07:31, Peter Zijlstra wrote:
> On Wed, Jan 25, 2023 at 07:36:28PM -0500, Waiman Long wrote:
>
>> @@ -609,6 +618,12 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>>   
>>   	lockdep_assert_held(&sem->wait_lock);
>>   
>> +	if (!waiter->task) {
>> +		/* Write lock handed off */
>> +		smp_acquire__after_ctrl_dep();
>> +		return true;
>> +	}
>> +
>>   	count = atomic_long_read(&sem->count);
>>   	do {
>>   		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>> @@ -754,6 +769,10 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
>>   
>>   	owner = rwsem_owner_flags(sem, &flags);
>>   	state = rwsem_owner_state(owner, flags);
>> +
>> +	if (owner == current)
>> +		return OWNER_NONSPINNABLE;	/* Handoff granted */
>> +
>>   	if (state != OWNER_WRITER)
>>   		return state;
>>   
>> @@ -1168,21 +1186,23 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>>   		 * without sleeping.
>>   		 */
>>   		if (waiter.handoff_set) {
>> -			enum owner_state owner_state;
>> -
>> -			owner_state = rwsem_spin_on_owner(sem);
>> -			if (owner_state == OWNER_NULL)
>> -				goto trylock_again;
>> +			rwsem_spin_on_owner(sem);
>> +			if (!READ_ONCE(waiter.task)) {
>> +				/* Write lock handed off */
>> +				smp_acquire__after_ctrl_dep();
>> +				set_current_state(TASK_RUNNING);
>> +				goto out;
>> +			}
>>   		}
>>   
>>   		schedule_preempt_disabled();
>>   		lockevent_inc(rwsem_sleep_writer);
>>   		set_current_state(state);
>> -trylock_again:
>>   		raw_spin_lock_irq(&sem->wait_lock);
>>   	}
>>   	__set_current_state(TASK_RUNNING);
>>   	raw_spin_unlock_irq(&sem->wait_lock);
>> +out:
>>   	lockevent_inc(rwsem_wlock);
>>   	trace_contention_end(sem, 0);
>>   	return sem;
>> @@ -1190,6 +1210,11 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>>   out_nolock:
>>   	__set_current_state(TASK_RUNNING);
>>   	raw_spin_lock_irq(&sem->wait_lock);
>> +	if (!waiter.task) {
>> +		smp_acquire__after_ctrl_dep();
>> +		raw_spin_unlock_irq(&sem->wait_lock);
>> +		goto out;
>> +	}
>>   	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
>>   	lockevent_inc(rwsem_wlock_fail);
>>   	trace_contention_end(sem, -EINTR);
>> @@ -1202,14 +1227,41 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>>    */
>>   static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
>>   {
>> -	unsigned long flags;
>>   	DEFINE_WAKE_Q(wake_q);
>> +	unsigned long flags;
>> +	unsigned long count;
>>   
>>   	raw_spin_lock_irqsave(&sem->wait_lock, flags);
>>   
>> -	if (!list_empty(&sem->wait_list))
>> -		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
>> +	if (list_empty(&sem->wait_list))
>> +		goto unlock_out;
>> +
>> +	/*
>> +	 * If the rwsem is free and handoff flag is set with wait_lock held,
>> +	 * no other CPUs can take an active lock.
>> +	 */
>> +	count = atomic_long_read(&sem->count);
>> +	if (!(count & RWSEM_LOCK_MASK) && (count & RWSEM_FLAG_HANDOFF)) {
>> +		/*
>> +		 * Since rwsem_mark_wake() will handle the handoff to reader
>> +		 * properly, we don't need to do anything extra for reader.
>> +		 * Special handoff processing will only be needed for writer.
>> +		 */
>> +		struct rwsem_waiter *waiter = rwsem_first_waiter(sem);
>> +		long adj = RWSEM_WRITER_LOCKED - RWSEM_FLAG_HANDOFF;
>> +
>> +		if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
>> +			atomic_long_set(&sem->owner, (long)waiter->task);
>> +			atomic_long_add(adj, &sem->count);
>> +			wake_q_add(&wake_q, waiter->task);
>> +			rwsem_del_waiter(sem, waiter);
>> +			waiter->task = NULL;	/* Signal the handoff */
>> +			goto unlock_out;
>> +		}
>> +	}
>> +	rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
>>   
>> +unlock_out:
>>   	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
>>   	wake_up_q(&wake_q);
>>   
> I am once again confused...
>
> *WHY* are you changing the writer wake-up path? The comments added here
> don't clarify anything.
>
> If we set handoff, we terminate/disallow the spinning/stealing. The
> direct consequence is that the slowpath/wait-list becomes the only way
> forward.
Yes, that is true.
>
> Since we don't take wait_lock on up, we fundamentally have a race
> condition. But *WHY* do you insist on handling that in rwsem_wake()?
> Delaying all that until rwsem_try_write_lock()? Doing so would render
> pretty much all of the above pointless, no?

There is an advantage in doing the handover earlier, if possible. A 
reader that comes in between can spoils the takeover of the rwsem in 
rwsem_try_write_lock() and cause it to sleep again. Since we will have 
to take the wait lock anyway in rwsem_wake(), there isn't much 
additional cost to do some additional check.

Note that the kernel test robot had detected a 19.3% improvement of 
will-it-scale.per_thread_ops [1] due to this commit. That indicates this 
commit is good to have. I am planning to update the commit log to 
include that information as well as additional reasoning as discussed here.

[1] 
https://lore.kernel.org/lkml/202302122155.87699b56-oliver.sang@intel.com/

>
> After all, rwsem_mark_wake() already wakes the writer if it is first,
> no? Why invent yet another special way to wake up the writer.
As I said before, waking up the writer does not mean it can always get 
the rwsem on the first rwsem_try_write_lock(). Doing early handoff in 
rwsem_wake() can remove that ambiguity.
>
> Also; and I asked this last time around; why do we care about the
> handoff to writer *at*all* ? It is the readers that set HANDOFF.

HANDOFF can happen for both readers and writers. Handoff to writer is 
actually more important than to readers.

Cheers,
Longman

