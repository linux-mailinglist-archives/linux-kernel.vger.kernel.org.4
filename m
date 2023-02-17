Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBC769AE05
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjBQO0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBQO0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:26:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC90E12861
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 06:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676643952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2b6cwdinvmI6diXBICfRFCC+B/ekU8nIvCBW57ShfY=;
        b=jT3WJZCj7wsw1mysdMjey1NiYHqboLGomjN7fYY6MjLx1FHG32R8ASzlepvGSrVLPYVM+P
        dVCYQ6UbMfk/mjxwsl+Izunv+zhuWGLJq+m/G6WMYfJ9qsIpJ7HG0QimbakoZDNdPA3Phf
        grVTxRETuOw/zr2tlHKj2rFSp93P4SE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-h6Yl_JXIOzS0a0Q_CxNxbQ-1; Fri, 17 Feb 2023 09:25:49 -0500
X-MC-Unique: h6Yl_JXIOzS0a0Q_CxNxbQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02C51800B23;
        Fri, 17 Feb 2023 14:25:49 +0000 (UTC)
Received: from [10.22.16.226] (unknown [10.22.16.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D807175A2;
        Fri, 17 Feb 2023 14:25:48 +0000 (UTC)
Message-ID: <dbab4166-abed-1633-1ee6-a2844fc401f6@redhat.com>
Date:   Fri, 17 Feb 2023 09:25:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/3] locking/rwsem: Enable early rwsem writer lock
 handoff
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>
References: <20230216210933.1169097-1-longman@redhat.com>
 <20230216210933.1169097-3-longman@redhat.com>
 <Y+8PlCPWDFiFjE8M@Boquns-Mac-mini.local>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y+8PlCPWDFiFjE8M@Boquns-Mac-mini.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/17/23 00:24, Boqun Feng wrote:
> On Thu, Feb 16, 2023 at 04:09:32PM -0500, Waiman Long wrote:
>> The lock handoff provided in rwsem isn't a true handoff like that in
>> the mutex. Instead, it is more like a quiescent state where optimistic
>> spinning and lock stealing are disabled to make it easier for the first
>> waiter to acquire the lock.
>>
>> For readers, setting the HANDOFF bit will disable writers from stealing
>> the lock. The actual handoff is done at rwsem_wake() time after taking
>> the wait_lock. There isn't much we need to improve here other than
>> setting the RWSEM_NONSPINNABLE bit in owner.
>>
>> For writers, setting the HANDOFF bit does not guarantee that it can
>> acquire the rwsem successfully in a subsequent rwsem_try_write_lock()
>> after setting the bit there. A reader can come in and add a
>> RWSEM_READER_BIAS temporarily which can spoil the takeover of the rwsem
>> in rwsem_try_write_lock() leading to additional delay.
>>
>> For mutex, lock handoff is done at unlock time as the owner value and
>> the handoff bit is in the same lock word and can be updated atomically.
>>
>> That is the not case for rwsem which has a count value for locking and
>> a different owner value for storing lock owner. In addition, the handoff
>> processing differs depending on whether the first waiter is a writer or a
>> reader. We can only make that waiter type determination after acquiring
>> the wait lock. Together with the fact that the RWSEM_FLAG_HANDOFF bit
>> is stable while holding the wait_lock, the most convenient place to
>> do the early handoff is at rwsem_mark_wake() where wait_lock has to be
>> acquired anyway.
>>
>> There isn't much additional cost in doing this check and early handoff
>> in rwsem_mark_wake() while increasing the chance that a lock handoff
>> will be successful when the HANDOFF setting writer wakes up without
>> even the need to take the wait_lock at all. Note that if early handoff
>> fails to happen in rwsem_mark_wake(), a late handoff can still happen
>> when the awoken writer calls rwsem_try_write_lock().
>>
>> Kernel test robot noticed a 19.3% improvement of
>> will-it-scale.per_thread_ops in an earlier version of this commit [1].
>>
>> [1] https://lore.kernel.org/lkml/202302122155.87699b56-oliver.sang@intel.com/
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/locking/lock_events_list.h |  1 +
>>   kernel/locking/rwsem.c            | 71 +++++++++++++++++++++++++++----
>>   2 files changed, 64 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
>> index 97fb6f3f840a..fd80f5828f24 100644
>> --- a/kernel/locking/lock_events_list.h
>> +++ b/kernel/locking/lock_events_list.h
>> @@ -67,3 +67,4 @@ LOCK_EVENT(rwsem_rlock_handoff)	/* # of read lock handoffs		*/
>>   LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
>>   LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
>>   LOCK_EVENT(rwsem_wlock_handoff)	/* # of write lock handoffs		*/
>> +LOCK_EVENT(rwsem_wlock_ehandoff) /* # of write lock early handoffs	*/
>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>> index e589f69793df..fc3961ceabe8 100644
>> --- a/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -412,8 +412,9 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>>   			    enum rwsem_wake_type wake_type,
>>   			    struct wake_q_head *wake_q)
>>   {
>> +	long count = atomic_long_read(&sem->count);
>>   	struct rwsem_waiter *waiter, *tmp;
>> -	long count, woken = 0, adjustment = 0;
>> +	long woken = 0, adjustment = 0;
>>   	struct list_head wlist;
>>   
>>   	lockdep_assert_held(&sem->wait_lock);
>> @@ -432,19 +433,39 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>>   		 * Mark writer at the front of the queue for wakeup.
>>   		 * Until the task is actually later awoken later by
>>   		 * the caller, other writers are able to steal it.
>> +		 *
>> +		 * *Unless* HANDOFF is set, in which case only the
>> +		 * first waiter is allowed to take it.
>> +		 *
>>   		 * Readers, on the other hand, will block as they
>>   		 * will notice the queued writer.
>>   		 */
>>   		wake_q_add(wake_q, waiter->task);
>>   		lockevent_inc(rwsem_wake_writer);
>> +
>> +		if ((count & RWSEM_LOCK_MASK) || !(count & RWSEM_FLAG_HANDOFF))
>> +			return;
>> +
>> +		/*
>> +		 * If the rwsem is free and handoff flag is set with wait_lock
>> +		 * held, no other CPUs can take an active lock. We can do an
>> +		 * early handoff.
>> +		 */
>> +		adjustment = RWSEM_WRITER_LOCKED - RWSEM_FLAG_HANDOFF;
>> +		atomic_long_set(&sem->owner, (long)waiter->task);
>> +		waiter->task = NULL;
>> +		atomic_long_add(adjustment, &sem->count);
>> +		rwsem_del_waiter(sem, waiter);
>> +		lockevent_inc(rwsem_wlock_ehandoff);
>>   	}
>>   	return;
>>   
>>   wake_readers:
>>   	/*
>> -	 * No reader wakeup if there are too many of them already.
>> +	 * No reader wakeup if there are too many of them already or
>> +	 * something wrong happens.
>>   	 */
>> -	if (unlikely(atomic_long_read(&sem->count) < 0))
>> +	if (unlikely(count < 0))
>>   		return;
>>   
>>   	/*
>> @@ -468,7 +489,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>>   					adjustment -= RWSEM_FLAG_HANDOFF;
>>   					lockevent_inc(rwsem_rlock_handoff);
>>   				}
>> +				/*
>> +				 * With HANDOFF set for reader, we must
>> +				 * terminate all spinning.
>> +				 */
>>   				waiter->handoff_set = true;
>> +				rwsem_set_nonspinnable(sem);
>>   			}
>>   
>>   			atomic_long_add(-adjustment, &sem->count);
>> @@ -610,6 +636,12 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>>   
>>   	lockdep_assert_held(&sem->wait_lock);
>>   
>> +	if (!waiter->task) {
>> +		/* Write lock handed off */
>> +		smp_acquire__after_ctrl_dep();
> I don't think you need smp_acquire__after_ctrl_dep() here, since:
>
> *	The other side is just a normal write "waiter->task = NULL"
> *	The "&sem->wait_lock" already provides the necessary ACQUIRE
>
> , but I come to this series so late, I may miss something subtle.

You are probably right about that. I was just being on cautious side to 
make sure that there is a proper acquire barrier. Thinking about it, the 
lock acquire is actually done in the previous wait_lock critical section 
where the early lock handoff is done. So the wait_lock acquire barrier 
should be good enough.


>
>> +		return true;
>> +	}
>> +
>>   	count = atomic_long_read(&sem->count);
>>   	do {
>>   		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>> @@ -755,6 +787,10 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
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
>> @@ -1164,32 +1200,51 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>>   		 * the lock, attempt to spin on owner to accelerate lock
>>   		 * transfer. If the previous owner is a on-cpu writer and it
>>   		 * has just released the lock, OWNER_NULL will be returned.
>> -		 * In this case, we attempt to acquire the lock again
>> -		 * without sleeping.
>> +		 * In this case, the waker may be in the process of early
>> +		 * lock handoff. Use the wait_lock to synchronize with that
>> +		 * before checking for handoff.
>>   		 */
>>   		if (waiter.handoff_set) {
>>   			enum owner_state owner_state;
>>   
>>   			owner_state = rwsem_spin_on_owner(sem);
>> -			if (owner_state == OWNER_NULL)
>> -				goto trylock_again;
>> +			if ((owner_state == OWNER_NULL) &&
>> +			    READ_ONCE(waiter.task)) {
> In theory, if there is a read outside some synchronization (say locks),
> not only READ_ONCE(), but also WRITE_ONCE() is needed (even for write
> inside locks), otherwise, KCSAN will yell (if
> KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n). This is because plain write may get
> teared.

Yes, I should have used a WRITE_ONCE() in writing NULL to waiter->task.

Thanks,
Longman

