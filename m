Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DAA655C24
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 02:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLYB4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 20:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYB4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 20:56:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3793C655E
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 17:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671933317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6FJzEUgdT17VkIabU/3KekROiWJW/FnuMP0hhgMDKj8=;
        b=UTr231WWY3GXVekoicYG3KNWyDJAFTWk2fh2jS0mpqOpDSe4JjN6Zg17aPjrVnKoErQggC
        aOew7n5Jv6e2oiArALuUTGL6H515FogGGapSSJbi/8uw60uy68FjFmb67MOGNIGRyPFnKn
        R+IMEMsx6SDVF1Q2V1Kkzqm/ctxgOfU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-_3nCPurzOIOMeBKwDgShHg-1; Sat, 24 Dec 2022 20:55:10 -0500
X-MC-Unique: _3nCPurzOIOMeBKwDgShHg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFF2D1C05148;
        Sun, 25 Dec 2022 01:55:09 +0000 (UTC)
Received: from [10.22.8.48] (unknown [10.22.8.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B0ED2166B33;
        Sun, 25 Dec 2022 01:55:09 +0000 (UTC)
Message-ID: <08ce1ab6-4678-74ce-43cc-2d3f04d1525d@redhat.com>
Date:   Sat, 24 Dec 2022 20:55:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] locking/qspinlock: Optimize pending state waiting for
 unlock
Content-Language: en-US
To:     guoren@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
References: <20221224120545.262989-1-guoren@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221224120545.262989-1-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/22 07:05, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> When we're pending, we only care about lock value. The xchg_tail
> wouldn't affect the pending state. That means the hardware thread
> could stay in a sleep state and leaves the rest execution units'
> resources of pipeline to other hardware threads. This optimization
> may work only for SMT scenarios because the granularity between
> cores is cache-block.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
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
Yes, we don't care about the tail.
> @@ -380,7 +380,7 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>   	 * barriers.
>   	 */
>   	if (val & _Q_LOCKED_MASK)
> -		atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_MASK));
> +		smp_cond_load_acquire(&lock->locked, !VAL);
>   
>   	/*
>   	 * take ownership and clear the pending bit.

We may save an AND operation here which may be a cycle or two.  I 
remember that it may be more costly to load a byte instead of an integer 
in some arches. So it doesn't seem like that much of an optimization 
from my point of view. I know that arm64 will enter a low power state in 
this *cond_load_acquire() loop, but I believe any change in the state of 
the the lock cacheline will wake it up. So it doesn't really matter if 
you are checking a byte or an int.

Do you have any other data point to support your optimization claim?

Cheers,
Longman

