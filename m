Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CA65F03E6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 06:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiI3Eu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 00:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiI3EuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 00:50:21 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFF11A803
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 21:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1664513388; x=1696049388;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/KfZ4OUR1AljEZyjACuGNyt+cwoWa/eMPZugI7IrO4A=;
  b=HD//JKn/8FV14M7P866dyJagT0tNSdK4cns71N/15Tk3uR6jzC+eZg0n
   uSAu6/kF8V0TOVXOo29Tx2Dc7TpKOLtEAJ39WT0wD/p+sPWIV4e4d9xnZ
   F2cJmrp3UARqbQrrLCBlvpDOZYMA9wzbMgTu5FHCCUMhWtmpdHtfPfd+s
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Sep 2022 21:46:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 21:46:48 -0700
Received: from [10.216.24.223] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 21:46:45 -0700
Message-ID: <0e0a6a29-1b2a-ff86-123d-1f6da272879c@quicinc.com>
Date:   Fri, 30 Sep 2022 10:16:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] locking/rwsem: Prevent non-first waiter from spinning in
 down_write() slowpath
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <john.p.donnelly@oracle.com>,
        Hillf Danton <hdanton@sina.com>
References: <20220929180413.107374-1-longman@redhat.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220929180413.107374-1-longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for looking into this issue.

On 9/29/2022 11:34 PM, Waiman Long wrote:
> A non-first waiter can potentially spin in the for loop of
> rwsem_down_write_slowpath() without sleeping but fail to acquire the
> lock even if the rwsem is free if the following sequence happens:
> 
>    Non-first waiter       First waiter      Lock holder
>    ----------------       ------------      -----------
>    Acquire wait_lock
>    rwsem_try_write_lock():
>      Set handoff bit if RT or
>        wait too long
>      Set waiter->handoff_set
>    Release wait_lock
>                           Acquire wait_lock
>                           Inherit waiter->handoff_set
>                           Release wait_lock
> 					   Clear owner
>                                             Release lock
>    if (waiter.handoff_set) {
>      rwsem_spin_on_owner(();
>      if (OWNER_NULL)
>        goto trylock_again;
>    }
>    trylock_again:
>    Acquire wait_lock
>    rwsem_try_write_lock():
>       if (first->handoff_set && (waiter != first))
>       	return false;
>    Release wait_lock
> 
> It is especially problematic if the non-first waiter is an RT task and
> it is running on the same CPU as the first waiter as this can lead to
> live lock.
> 
> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more consistent")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/locking/rwsem.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 65f0262f635e..ad676e99e0b3 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -628,6 +628,11 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>   		new = count;
>   
>   		if (count & RWSEM_LOCK_MASK) {
> +			/*
> +			 * A waiter (first or not) can set the handoff bit
> +			 * if it is an RT task or wait in the wait queue
> +			 * for too long.
> +			 */
>   			if (has_handoff || (!rt_task(waiter->task) &&
>   					    !time_after(jiffies, waiter->timeout)))
>   				return false;
> @@ -643,11 +648,13 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>   	} while (!atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
>   
>   	/*
> -	 * We have either acquired the lock with handoff bit cleared or
> -	 * set the handoff bit.
> +	 * We have either acquired the lock with handoff bit cleared or set
> +	 * the handoff bit. Only the first waiter can have its handoff_set
> +	 * set here to enable optimistic spinning in slowpath loop.
>   	 */
>   	if (new & RWSEM_FLAG_HANDOFF) {
> -		waiter->handoff_set = true;
> +		if (waiter == first)
> +			waiter->handoff_set = true;
>   		lockevent_inc(rwsem_wlock_handoff);

nit: Should this not get incremented on waiter->handoff_set=true only ?


>   		return false;
>   	}

-Mukesh
