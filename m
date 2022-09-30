Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD1B5F0D18
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiI3OJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiI3OI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:08:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316891730C9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 07:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664546891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rw7b5B/4jn5c0e8mAD+SrhlZ+QMKprZHs/Gzpg2278=;
        b=HUAm8e16rHXjOaXeKkJKwPyRGxmec4qj+0q7tZFRslNlNA/+yVxndZLcz4oLo7EU47G0tH
        NlRP4YioHZXt47OtzFRBgkCRHVMJGjYR5Ccgir6jSPv/Z8WLYEzz7t63jHrNKCOKOAki29
        YGOv6PE1hyKSu3IdXEO8FlKAVuyn8ec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-BOMCHwNiPW6qfI2ydT0oEw-1; Fri, 30 Sep 2022 10:08:07 -0400
X-MC-Unique: BOMCHwNiPW6qfI2ydT0oEw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17FB9862FE0;
        Fri, 30 Sep 2022 14:08:07 +0000 (UTC)
Received: from [10.22.32.213] (unknown [10.22.32.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7165A492B04;
        Fri, 30 Sep 2022 14:08:06 +0000 (UTC)
Message-ID: <285ba94c-04fc-413f-d16f-d4628caee9f2@redhat.com>
Date:   Fri, 30 Sep 2022 10:08:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] locking/rwsem: Prevent non-first waiter from spinning in
 down_write() slowpath
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>
References: <20220929180413.107374-1-longman@redhat.com>
 <7f204676-501b-4c74-2d44-6abbeca5f53e@quicinc.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <7f204676-501b-4c74-2d44-6abbeca5f53e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/22 01:06, Mukesh Ojha wrote:
> Hi,
>
> On 9/29/2022 11:34 PM, Waiman Long wrote:
>> A non-first waiter can potentially spin in the for loop of
>> rwsem_down_write_slowpath() without sleeping but fail to acquire the
>> lock even if the rwsem is free if the following sequence happens:
>>
>>    Non-first waiter       First waiter      Lock holder
>>    ----------------       ------------      -----------
>>    Acquire wait_lock
>>    rwsem_try_write_lock():
>>      Set handoff bit if RT or
>>        wait too long
>>      Set waiter->handoff_set
>>    Release wait_lock
>>                           Acquire wait_lock
>>                           Inherit waiter->handoff_set
>>                           Release wait_lock
>>                        Clear owner
>>                                             Release lock
>>    if (waiter.handoff_set) {
>>      rwsem_spin_on_owner(();
>>      if (OWNER_NULL)
>>        goto trylock_again;
>>    }
>>    trylock_again:
>>    Acquire wait_lock
>>    rwsem_try_write_lock():
>>       if (first->handoff_set && (waiter != first))
>>           return false;
>>    Release wait_lock
>>
>> It is especially problematic if the non-first waiter is an RT task and
>> it is running on the same CPU as the first waiter as this can lead to
>> live lock.
>>
>> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more 
>> consistent")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/locking/rwsem.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>> index 65f0262f635e..ad676e99e0b3 100644
>> --- a/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -628,6 +628,11 @@ static inline bool rwsem_try_write_lock(struct 
>> rw_semaphore *sem,
>>           new = count;
>>             if (count & RWSEM_LOCK_MASK) {
>> +            /*
>> +             * A waiter (first or not) can set the handoff bit
>> +             * if it is an RT task or wait in the wait queue
>> +             * for too long.
>> +             */
>>               if (has_handoff || (!rt_task(waiter->task) &&
>>                           !time_after(jiffies, waiter->timeout)))
>
> Not related to this issue, however wanted to understand the idea about 
> this.
>
> If RT task comes in any order either come first or later it is setting 
> the RWSEM_FLAG_HANDOFF bit.
> So, here we are giving some priority right a way to RT task however it
> can not get waiter->handoff_set=true since it is not the first 
> waiter.(after this patch), is it not conflicting ?

I have thought about moving the RT task forward in the wait queue, but 
then it will greatly complicate the code to try to do what a PREEMPT_RT 
kernel does using a rt_mutex variant of rwsem. The reason why HANDOFF 
bit is set when an RT task is in the wait queue is speed up the 
progression of the wait queue without the interference of optimistic 
spinner.

>
>
> Why can't we just keep like as below and not set
> new |= RWSEM_FLAG_HANDOFF; and return false from here.
>
> --------------0<------------------------------------
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 65f0262..dbe3e16 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -628,8 +628,8 @@ static inline bool rwsem_try_write_lock(struct
> rw_semaphore *sem,
>                  new = count;
>
>                  if (count & RWSEM_LOCK_MASK) {
> -                       if (has_handoff || (!rt_task(waiter->task) &&
> -                                           !time_after(jiffies,
> waiter->timeout)))
> +                       if (has_handoff || (rt_task(waiter->task) &&
> waiter != first) ||
> +                          (!rt_task(waiter->task) &&
> !time_after(jiffies, waiter->timeout)))
>                                  return false;
>
As I said above, we want to make more forward progress in the wait queue 
if a RT task is waiting there to try to reduce its latency. That is the 
point of that if statement.

Cheers,
Longman


