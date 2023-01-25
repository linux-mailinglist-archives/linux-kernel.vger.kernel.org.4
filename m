Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3168667A87F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 02:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjAYByh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 20:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjAYByf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 20:54:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F3A2005F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 17:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674611630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Etpf0h/KZPoT1mEfVfnaPeogduCbebPhjFqmKMN6/Ag=;
        b=cKytNmuBfgpW3Rq1VSRBZWjzWBUd0/OeouaxPo6mTImukwR9zzNlVNbk2GtnpLFl4pOUu0
        NwACkjKw5W5mN6k88hHluGStkhjCkjXYdkMJFkeqSSsGZLx7iQG29RFxyekNkb8m49XdGR
        xOB6kUy45mm3CdUs4HXPZSG37DsRr7c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-HZIQ6vD5P9iLLYEX037vLA-1; Tue, 24 Jan 2023 20:53:49 -0500
X-MC-Unique: HZIQ6vD5P9iLLYEX037vLA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6966A802C1C;
        Wed, 25 Jan 2023 01:53:48 +0000 (UTC)
Received: from [10.22.10.191] (unknown [10.22.10.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEFAF492B00;
        Wed, 25 Jan 2023 01:53:47 +0000 (UTC)
Message-ID: <c96527ef-7a92-e03d-335f-9b52a7139111@redhat.com>
Date:   Tue, 24 Jan 2023 20:53:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 5/6] locking/rwsem: Enable direct rwsem lock handoff
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20221118022016.462070-1-longman@redhat.com>
 <20221118022016.462070-6-longman@redhat.com>
 <Y86gzkVHlsOTY8QL@hirez.programming.kicks-ass.net>
 <9fb531a9-0951-f7c0-316d-749d2c59ade8@redhat.com>
 <Y8/PM7ONLUkIETxy@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y8/PM7ONLUkIETxy@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/23 07:29, Peter Zijlstra wrote:
> On Mon, Jan 23, 2023 at 12:30:59PM -0500, Waiman Long wrote:
>> On 1/23/23 09:59, Peter Zijlstra wrote:
>>> On Thu, Nov 17, 2022 at 09:20:15PM -0500, Waiman Long wrote:
>>>> The lock handoff provided in rwsem isn't a true handoff like that in
>>>> the mutex. Instead, it is more like a quiescent state where optimistic
>>>> spinning and lock stealing are disabled to make it easier for the first
>>>> waiter to acquire the lock.
>>>>
>>>> Reworking the code to enable a true lock handoff is more complex due to
>>>> the following facts:
>>>>    1) The RWSEM_FLAG_HANDOFF bit is protected by the wait_lock and it
>>>>       is too expensive to always take the wait_lock in the unlock path
>>>>       to prevent racing.
>>> Specifically, the issue is that we'd need to turn the
>>> atomic_long_add_return_release() into an atomic_try_cmpxchg_release()
>>> loop, like:
>>>
>>> 	tmp = atomic_long_read(&sem->count);
>>> 	do {
>>> 		if (tmp & (WAITERS|HANDOFF))
>>> 			return slow_unock();
>>> 	} while (atomic_long_try_cmpxchg_release(&sem->count, &tmp,
>>> 						 tmp - RWSEM_{READER_BIAS,WRITE_LOCKED});
>>>
>>> in order to not race with a concurrent setting of the HANDOFF bit,
>>> right? And we don't like to turn unlock into a cmpxchg loop.
>>>
>>> (OTOH we sorta do this for mutex, unconteded mutex has cmpxchg lock and
>>> unlock, any fail and we go to the slow path -- I suppose the distinct
>>> difference is that we sorta expect some contention on the read side)
>> I see that your inclination is to do the handoff right at the unlock time.
>> It is certainly possible to do that, but it will be more complex in the case
>> of rwsem than mutex.
> Still, it would make things ever so much simpler -- but I agree we'll
> probably not get away with it on the performance side of things.
>
>>> Right. In short:
>>>
>>> Having HANDOVER set:
>>>    - implies WAITERS set
>>>    - disables all fastpaths (spinning or otherwise)
>>>    - dis-allows anybody except first waiter to obtain lock
>>>
>>> Therefore, having the window between clearing owner and prodding first
>>> waiter is 'harmless'.
>> As said above, we need to confirm that the HANDOFF bit is set with wait_lock
>> held. Now, the HANDOFF bit may not set at unlock time, or it may not be.
>>
>> We can pass the count value fetched at unlock time down to rwsem_wake() to
>> confirm that HANDOFF bit is set at unlock time. However, it is also possible
>> that the original waiter that set HANDOFF have bailed out, then a reader
>> acquire the lock and another waiter set HANDOFF before the unlocker acquire
>> the wait lock. Then the rwsem is really reader-owned in this case. So we
>> can't perform handoff. That is why I also check for if there is an active
>> lock (mostly read lock) at rwsem_wake(). However, that can be a false
>> negative because an incoming reader may have just added a READER_BIAS which
>> is to be removed soon. That is the reason why I have a secondary handoff
>> check in the reader slowpath.
>>
>>>> With true lock handoff, there is no need to do a NULL owner spinning
>>>> anymore as wakeup will be performed if handoff is possible. So it
>>>> is likely that the first waiter won't actually go to sleep even when
>>>> schedule() is called in this case.
>>> Right, removing that NULL spinning was the whole purpose -- except I
>>> seem to have forgotten why it was a problem :-)
>>>
>>> OK, lemme go read the actual patch.
>>>
>>> Hmmm... you made it a wee bit more complicated, instead of my 3rd clause
>>> above, you added a whole intermediate GRANTED state. Why?
>>>
>>> Since we fundamentally must deal with the release->wait_lock hole, why
>>> do we need to do the whole rwsem_wake()->GRANTED->*_slowpath() dance?
>>> Why can't we skip the whole rwsem_wake()->GRANTED part and only do
>>> handoff in the slowpath?
>> First of all, the owner value for a reader-owned rwsem is mostly of an
>> advisory value as it holds one of the possible owners. So it may be a bit
>> risky to use it as an indication that a handoff had happened as it may be
>> screwed up in some rare cases. That is why I use the repurposed
>> handoff_state value in the waiter structure. Also reading this value is less
>> costly than reading the rwsem cacheline which can be heavily contended.
>>
>> I will update the patch description to highlight the points that I discussed
>> in this email.
> Maybe I'm being dense, but I'm not seeing it. If we make HANDOFF block
> all the fastpaths, all the spinning, all the stealing, everything; then
> all that is left is the slowpath that is holding wait_lock.
>
> Then in both slowpaths, ensure only the first waiter can go on and we're
> done.
>
> What am I missing? Why does it need to be so complicated?
>
> That is, afaict something like the below would actually work, no? Yes,
> simply deleting that spinning in write_slowpath isn't ideal, but I
> suspect we can do something to rwsem_try_write_lock() to make up for
> that if we think about it.
>
> Again, please explain, explicitly and in small steps, why you think you
> need all that complexity.
>
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -40,7 +40,7 @@
>    *
>    * When the rwsem is reader-owned and a spinning writer has timed out,
>    * the nonspinnable bit will be set to disable optimistic spinning.
> -
> + *
>    * When a writer acquires a rwsem, it puts its task_struct pointer
>    * into the owner field. It is cleared after an unlock.
>    *
> @@ -430,6 +430,10 @@ static void rwsem_mark_wake(struct rw_se
>   			 * Mark writer at the front of the queue for wakeup.
>   			 * Until the task is actually later awoken later by
>   			 * the caller, other writers are able to steal it.
> +			 *
> +			 * *Unless* HANDOFF is set, in which case only the
> +			 * first waiter is allowed to take it.
> +			 *
>   			 * Readers, on the other hand, will block as they
>   			 * will notice the queued writer.
>   			 */
> @@ -463,6 +467,9 @@ static void rwsem_mark_wake(struct rw_se
>   			 * force the issue.
>   			 */
>   			if (time_after(jiffies, waiter->timeout)) {
> +				/*
> +				 * Setting HANDOFF blocks fastpaths and stealing.
> +				 */
>   				if (!(oldcount & RWSEM_FLAG_HANDOFF)) {
>   					adjustment -= RWSEM_FLAG_HANDOFF;
>   					lockevent_inc(rwsem_rlock_handoff);
> @@ -471,6 +478,13 @@ static void rwsem_mark_wake(struct rw_se
>   			}
>   
>   			atomic_long_add(-adjustment, &sem->count);
> +
> +			if (waiter->handoff_set) {
> +				/*
> +				 * With HANDOFF set we must terminate all spinning.
> +				 */
> +				rwsem_set_nonspinnable(sem);
> +			}
>   			return;
>   		}
>   		/*
> @@ -844,7 +858,6 @@ static bool rwsem_optimistic_spin(struct
>   		 * Try to acquire the lock
>   		 */
>   		taken = rwsem_try_write_lock_unqueued(sem);
> -
>   		if (taken)
>   			break;
>   
> @@ -1159,22 +1172,6 @@ rwsem_down_write_slowpath(struct rw_sema
>   		if (signal_pending_state(state, current))
>   			goto out_nolock;
>   
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
> -		}
> -
>   		schedule_preempt_disabled();
>   		lockevent_inc(rwsem_sleep_writer);
>   		set_current_state(state);
>
Thanks for the comments and suggested changes. I will adopt some of your 
suggestions to simplify the patchset. Will post a new version once I 
finish my testing.

Cheers,
Longman

