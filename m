Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3A167834E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjAWRd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjAWRcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:32:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FAE2F786
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674495062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xv2BrUQpZsK6KCLyiVDSwEGSmc5H2wdmD1zuK8InlTs=;
        b=SrKFZWE9V1irMH7ipWJdw5c0BblSmQMmgmzAYQ8p0oEhhsERadD2ZgbK7blsvw/5lmmQ80
        GJTuI8eii2dRmWU6dQgVOTsdKP7+zy5jIBeF6jrKKSnIpNnlv5cp+XgM66gOhRKwAicOsn
        0iqPY6L+GcWyngWWVq4hk9VhcdKhV98=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-Qwf3jcoVOpu9LR7Qg77KAw-1; Mon, 23 Jan 2023 12:31:00 -0500
X-MC-Unique: Qwf3jcoVOpu9LR7Qg77KAw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8912857F43;
        Mon, 23 Jan 2023 17:30:59 +0000 (UTC)
Received: from [10.22.34.140] (unknown [10.22.34.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CE81492C3E;
        Mon, 23 Jan 2023 17:30:59 +0000 (UTC)
Message-ID: <9fb531a9-0951-f7c0-316d-749d2c59ade8@redhat.com>
Date:   Mon, 23 Jan 2023 12:30:59 -0500
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y86gzkVHlsOTY8QL@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 09:59, Peter Zijlstra wrote:
> On Thu, Nov 17, 2022 at 09:20:15PM -0500, Waiman Long wrote:
>> The lock handoff provided in rwsem isn't a true handoff like that in
>> the mutex. Instead, it is more like a quiescent state where optimistic
>> spinning and lock stealing are disabled to make it easier for the first
>> waiter to acquire the lock.
>>
>> Reworking the code to enable a true lock handoff is more complex due to
>> the following facts:
>>   1) The RWSEM_FLAG_HANDOFF bit is protected by the wait_lock and it
>>      is too expensive to always take the wait_lock in the unlock path
>>      to prevent racing.
> Specifically, the issue is that we'd need to turn the
> atomic_long_add_return_release() into an atomic_try_cmpxchg_release()
> loop, like:
>
> 	tmp = atomic_long_read(&sem->count);
> 	do {
> 		if (tmp & (WAITERS|HANDOFF))
> 			return slow_unock();
> 	} while (atomic_long_try_cmpxchg_release(&sem->count, &tmp,
> 						 tmp - RWSEM_{READER_BIAS,WRITE_LOCKED});
>
> in order to not race with a concurrent setting of the HANDOFF bit,
> right? And we don't like to turn unlock into a cmpxchg loop.
>
> (OTOH we sorta do this for mutex, unconteded mutex has cmpxchg lock and
> unlock, any fail and we go to the slow path -- I suppose the distinct
> difference is that we sorta expect some contention on the read side)

I see that your inclination is to do the handoff right at the unlock 
time. It is certainly possible to do that, but it will be more complex 
in the case of rwsem than mutex.

First of all for mutex, the owner is the lock word. You do a successful 
cmpxchg once and it is all done. rwsem isn't like that. Its owner field 
is separated from the actual lock word (count). So setting the right 
lock value and owner cannot be atomic. That is why I am using the 
wait_lock for synchronizing between the unlocker and the first waiter 
that set handoff. Since rwsem_wake() will take the wait_lock anyway, so 
I decide to do the handoff at that time.

Another consideration that I have is to minimize the unlock overhead. To 
do handoff at unlock time requires an extra read of the rwsem count.


>   2) The reader lock fast path may add a RWSEM_READER_BIAS at the wrong
>      time to prevent a proper lock handoff from a reader owned rwsem.
> This would be much the same, right? We'd have to turn
> rwsem_read_trylock() into a cmpxchg-loop and we don't like that.
> Therefore we do that speculative add and fix up later.
>
> Now, I'm not enturely sure what issue you allude to here; is the problem
> that you can't quite tell when the last reader is gone?
>> A lock handoff can only be initiated when the following conditions are
>> true:
>>   1) The RWSEM_FLAG_HANDOFF bit is set.
> d'uh ;-)
>
>>   2) The task to do the handoff don't see any other active lock
>>      excluding the lock that it might have held.
> 2) here is the 2) above, right?
>
>> The new handoff mechanism performs handoff in rwsem_wakeup() to minimize
>> overhead. The rwsem count will be known at that point to determine if
>> handoff should be done. However, there is a small time gap between the
>> rwsem becomes free and the wait_lock is taken
> Right, that's between atomic_long_fetch_add_release() and calling the
> slow path because WAITERS bit is set.
Yes, there is no extra overhead unless the waiter bit is set.
>
>> where a reader can come in and add a RWSEM_READER_BIAS to the count or
> Both 2s above.
>
>> the current first waiter can take the rwsem and clear
>> RWSEM_FLAG_HANDOFF in the interim.
> The actual intended action.
>
>> That will fail the handoff operation.
> I would not list that latter as a failure, it's exactly what we want to
> happen, no?

Yes, that is the intended action.

I adds this due to the fact that even if the HANDOFF bit is observed to 
be set at unlock time, it does not guarantee a handoff can be 
successfully done because the first waiter can be interrupted out or 
killed in the interim. The HANDOFF bit has to be confirmed to be set 
while holding the wait lock to be sure that we can do a handoff.

>> To handle the former case, a secondary handoff will also be done in
>> the rwsem_down_read_slowpath() to catch it.
> Right. In short:
>
> Having HANDOVER set:
>   - implies WAITERS set
>   - disables all fastpaths (spinning or otherwise)
>   - dis-allows anybody except first waiter to obtain lock
>
> Therefore, having the window between clearing owner and prodding first
> waiter is 'harmless'.

As said above, we need to confirm that the HANDOFF bit is set with 
wait_lock held. Now, the HANDOFF bit may not set at unlock time, or it 
may not be.

We can pass the count value fetched at unlock time down to rwsem_wake() 
to confirm that HANDOFF bit is set at unlock time. However, it is also 
possible that the original waiter that set HANDOFF have bailed out, then 
a reader acquire the lock and another waiter set HANDOFF before the 
unlocker acquire the wait lock. Then the rwsem is really reader-owned in 
this case. So we can't perform handoff. That is why I also check for if 
there is an active lock (mostly read lock) at rwsem_wake(). However, 
that can be a false negative because an incoming reader may have just 
added a READER_BIAS which is to be removed soon. That is the reason why 
I have a secondary handoff check in the reader slowpath.

>
>> With true lock handoff, there is no need to do a NULL owner spinning
>> anymore as wakeup will be performed if handoff is possible. So it
>> is likely that the first waiter won't actually go to sleep even when
>> schedule() is called in this case.
> Right, removing that NULL spinning was the whole purpose -- except I
> seem to have forgotten why it was a problem :-)
>
> OK, lemme go read the actual patch.
>
> Hmmm... you made it a wee bit more complicated, instead of my 3rd clause
> above, you added a whole intermediate GRANTED state. Why?
>
> Since we fundamentally must deal with the release->wait_lock hole, why
> do we need to do the whole rwsem_wake()->GRANTED->*_slowpath() dance?
> Why can't we skip the whole rwsem_wake()->GRANTED part and only do
> handoff in the slowpath?

First of all, the owner value for a reader-owned rwsem is mostly of an 
advisory value as it holds one of the possible owners. So it may be a 
bit risky to use it as an indication that a handoff had happened as it 
may be screwed up in some rare cases. That is why I use the repurposed 
handoff_state value in the waiter structure. Also reading this value is 
less costly than reading the rwsem cacheline which can be heavily contended.

I will update the patch description to highlight the points that I 
discussed in this email.

Cheers,
Longman

