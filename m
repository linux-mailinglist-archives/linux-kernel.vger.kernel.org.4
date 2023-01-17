Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7874A66E828
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjAQVJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjAQVHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:07:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F90F9086B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673983952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2LUjVvGCn8bvgtZlOmPhRZtXkQbB6wWVKWPH/jzNYf4=;
        b=dHS4N+AshLaBW/XXZeFmLkTXKZerBm5dmYxcpbb6t42oV0BYSzuqnKBlajMRgBUw5L9taA
        anVISOU9wjDj3g9Go8tUqJ7xVYw//D/45Kd/SPkNRhLJOfv1a2FPZlz2tO0LIYiAG6DrvV
        e5ELQwLoPPu3CbALhxL1R6Dc3UUyToM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-CSCLg9DTMLW7T_M2RdgXxg-1; Tue, 17 Jan 2023 14:32:29 -0500
X-MC-Unique: CSCLg9DTMLW7T_M2RdgXxg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20CA8858F09;
        Tue, 17 Jan 2023 19:32:29 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D349F2026D4B;
        Tue, 17 Jan 2023 19:32:28 +0000 (UTC)
Message-ID: <23a15414-927c-ba0d-eb6a-58f6191ce17b@redhat.com>
Date:   Tue, 17 Jan 2023 14:32:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] rtmutex: ensure we wake up the top waiter
Content-Language: en-US
To:     Wander Lairson Costa <wander@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "open list:LOCKING PRIMITIVES" <linux-kernel@vger.kernel.org>
References: <20230117172649.52465-1-wander@redhat.com>
From:   Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
In-Reply-To: <20230117172649.52465-1-wander@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 1/17/23 12:26, Wander Lairson Costa wrote:
> In task_blocked_on_lock() we save the owner, release the wait_lock and
> call rt_mutex_adjust_prio_chain(). Before we acquire the wait_lock
> again, the owner may release the lock and deboost.
Are you referring to task_blocks_on_rt_mutex(), not task_blocked_on_lock()?
>
> rt_mutex_adjust_prio_chain() acquires the wait_lock. In the requeue
> phase, waiter may be initially in the top of the queue, but after
> dequeued and requeued it may no longer be true.
>
> This scenario ends up waking the wrong task, which will verify it is no
> the top waiter and comes back to sleep. Now we have a situation in which
> no task is holding the lock but no one acquires it.
>
> We can reproduce the bug in PREEMPT_RT with stress-ng:
>
> while true; do
>      stress-ng --sched deadline --sched-period 1000000000 \
>      	    --sched-runtime 800000000 --sched-deadline \
>      	    1000000000 --mmapfork 23 -t 20
> done
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>   kernel/locking/rtmutex.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 010cf4e6d0b8..728f434de2bb 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -901,8 +901,9 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
>   		 * then we need to wake the new top waiter up to try
>   		 * to get the lock.
>   		 */
> -		if (prerequeue_top_waiter != rt_mutex_top_waiter(lock))
> -			wake_up_state(waiter->task, waiter->wake_state);
> +		top_waiter = rt_mutex_top_waiter(lock);
> +		if (prerequeue_top_waiter != top_waiter)
> +			wake_up_state(top_waiter->task, top_waiter->wake_state);
>   		raw_spin_unlock_irq(&lock->wait_lock);
>   		return 0;
>   	}

I would say that if a rt_mutex has no owner but have waiters, we should 
always wake up the top waiter whether or not it is the current waiter. 
So what is the result of the stress-ng run above? Is it a hang? It is 
not clear from your patch description.

I am not that familiar with the rt_mutex code, I am cc'ing Thomas and 
Sebastian for their input.

Cheers,
Longman

