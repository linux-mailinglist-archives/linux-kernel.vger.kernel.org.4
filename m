Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A5166E853
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjAQVWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjAQVSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:18:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD5A4997F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673984424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XaDyc8xu3ZBmig406jBdgvro3NfBt+kNJQlm5d92Zbc=;
        b=Tp1SBA0ngmgXamUSdyvaNvYCbk1xj9FN6rXDgjhWCqpuJG2TlMNOYAdAaZ3/eht10bAGqE
        +6E6W2KHpDPg9TBm3Y9cycuwGDu6fq4fCNEIrI+dVZVgPKakQyYmHyN80wRneWc6Li75KU
        MQpkSVg63YIc9lmpbtp9+NZ0T/gD4Z0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-UuZjKGf8NSG6_Cpeccvt9g-1; Tue, 17 Jan 2023 14:40:22 -0500
X-MC-Unique: UuZjKGf8NSG6_Cpeccvt9g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 654AC101A521;
        Tue, 17 Jan 2023 19:40:22 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30E382026D68;
        Tue, 17 Jan 2023 19:40:22 +0000 (UTC)
Message-ID: <c7cae935-c378-24bf-7e9c-bbf5feb4185a@redhat.com>
Date:   Tue, 17 Jan 2023 14:40:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] rtmutex: ensure we wake up the top waiter
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Wander Lairson Costa <wander@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "open list:LOCKING PRIMITIVES" <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230117172649.52465-1-wander@redhat.com>
 <23a15414-927c-ba0d-eb6a-58f6191ce17b@redhat.com>
In-Reply-To: <23a15414-927c-ba0d-eb6a-58f6191ce17b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/23 14:32, Waiman Long wrote:
> On 1/17/23 12:26, Wander Lairson Costa wrote:
>> In task_blocked_on_lock() we save the owner, release the wait_lock and
>> call rt_mutex_adjust_prio_chain(). Before we acquire the wait_lock
>> again, the owner may release the lock and deboost.
> Are you referring to task_blocks_on_rt_mutex(), not 
> task_blocked_on_lock()?
>>
>> rt_mutex_adjust_prio_chain() acquires the wait_lock. In the requeue
>> phase, waiter may be initially in the top of the queue, but after
>> dequeued and requeued it may no longer be true.
>>
>> This scenario ends up waking the wrong task, which will verify it is no
>> the top waiter and comes back to sleep. Now we have a situation in which
>> no task is holding the lock but no one acquires it.
>>
>> We can reproduce the bug in PREEMPT_RT with stress-ng:
>>
>> while true; do
>>      stress-ng --sched deadline --sched-period 1000000000 \
>>              --sched-runtime 800000000 --sched-deadline \
>>              1000000000 --mmapfork 23 -t 20
>> done
>>
>> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
>> ---
>>   kernel/locking/rtmutex.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
>> index 010cf4e6d0b8..728f434de2bb 100644
>> --- a/kernel/locking/rtmutex.c
>> +++ b/kernel/locking/rtmutex.c
>> @@ -901,8 +901,9 @@ static int __sched 
>> rt_mutex_adjust_prio_chain(struct task_struct *task,
>>            * then we need to wake the new top waiter up to try
>>            * to get the lock.
>>            */
>> -        if (prerequeue_top_waiter != rt_mutex_top_waiter(lock))
>> -            wake_up_state(waiter->task, waiter->wake_state);
>> +        top_waiter = rt_mutex_top_waiter(lock);
>> +        if (prerequeue_top_waiter != top_waiter)
>> +            wake_up_state(top_waiter->task, top_waiter->wake_state);
>>           raw_spin_unlock_irq(&lock->wait_lock);
>>           return 0;
>>       }
>
> I would say that if a rt_mutex has no owner but have waiters, we 
> should always wake up the top waiter whether or not it is the current 
> waiter. So what is the result of the stress-ng run above? Is it a 
> hang? It is not clear from your patch description.

BTW, if it is a hang. What arch has this problem? x86 or arm64? There is 
a recent report of some rt_mutex locking issue in arm64, I believe. I 
don't know if it will be related. So it is important to know in what 
arch you see this problem.

Cheers,
Longman

