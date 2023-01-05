Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A20265E391
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjAEDgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjAEDfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:35:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3760F4882F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 19:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672889696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2OKZoZp+LIjDtRwF5mzJSEFStmp3HBv/QzapCnu4ZhY=;
        b=ZNjRzGJ2cL7NHRVWYMEZiHywctJJwBUOaIUnJUDhsw+R9o0hpIZ9hsZeFMDfZ55uogHmrL
        RH+5oIW68t5OBGLvb0Gj+l1lAeE9Iq3GG24/1XHMqXbBrjIqyVHsOzPoXcz6kaIDKzmCYr
        g7eGWoAxMNEu/WQsoxhxVFkT4uQIgn4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-U4FMCPcTPdShM5_MtqhVOw-1; Wed, 04 Jan 2023 22:34:55 -0500
X-MC-Unique: U4FMCPcTPdShM5_MtqhVOw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A47B73C10699;
        Thu,  5 Jan 2023 03:34:54 +0000 (UTC)
Received: from [10.22.8.39] (unknown [10.22.8.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BC712166B31;
        Thu,  5 Jan 2023 03:34:54 +0000 (UTC)
Message-ID: <fd3ae111-7b4b-ebe9-82a2-42beaaf02157@redhat.com>
Date:   Wed, 4 Jan 2023 22:34:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH V2] locking/qspinlock: Optimize pending state waiting for
 unlock
Content-Language: en-US
To:     guoren@kernel.org, peterz@infradead.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>
References: <20230105021952.3090070-1-guoren@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230105021952.3090070-1-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/23 21:19, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> When we're pending, we only care about lock value. The xchg_tail
> wouldn't affect the pending state. That means the hardware thread
> could stay in a sleep state and leaves the rest execution units'
> resources of pipeline to other hardware threads. This situation is
> the SMT scenarios in the same core. Not an entering low-power state
> situation. Of course, the granularity between cores is "cacheline",
> but the granularity between SMT hw threads of the same core could
> be "byte" which internal LSU handles. For example, when a hw-thread
> yields the resources of the core to other hw-threads, this patch
> could help the hw-thread stay in the sleep state and prevent it
> from being woken up by other hw-threads xchg_tail.
>
> Link: https://lore.kernel.org/lkml/20221224120545.262989-1-guoren@kernel.org/
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Acked-by: Waiman Long <longman@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> ---
> Changes in v2:
>   - Add acked tag
>   - Optimize commit log
>   - Add discussion Link tag
> ---
>   kernel/locking/qspinlock.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 2b23378775fe..ebe6b8ec7cb3 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -371,7 +371,7 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>   	/*
>   	 * We're pending, wait for the owner to go away.
>   	 *
> -	 * 0,1,1 -> 0,1,0
> +	 * 0,1,1 -> *,1,0
>   	 *
>   	 * this wait loop must be a load-acquire such that we match the
>   	 * store-release that clears the locked bit and create lock
> @@ -380,7 +380,7 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>   	 * barriers.
>   	 */
>   	if (val & _Q_LOCKED_MASK)
> -		atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_MASK));
> +		smp_cond_load_acquire(&lock->locked, !VAL);
>   
>   	/*
>   	 * take ownership and clear the pending bit.

Yes, the new patch description looks good to me. Thank for sending the v2.

Cheers,
Longman

