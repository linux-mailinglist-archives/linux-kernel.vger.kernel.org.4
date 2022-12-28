Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6B565726C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 04:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiL1D5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 22:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiL1D5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 22:57:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9648FDB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 19:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672199813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1iYDXrCp4jgzwZqV3/lBsJk4Z6q54s9p14WCehQlX+A=;
        b=RMlZwEJvLiCK05sAiPvryVU+LxUG15ar6FmCsQkspGSF87rbXqZEE+gWk3mF53zCIJtkGt
        c2+4vltxcag/CiJnlUII50VelMnbskibsbG+SLcMlz2jLx/0YUMylRDX5+ECmuB59DQfcE
        Y/rG9yM4TkEZJRV2EMCwJf9hzpjYUgw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-AerkMQY8Mpy1ie3MWqqDaw-1; Tue, 27 Dec 2022 22:56:49 -0500
X-MC-Unique: AerkMQY8Mpy1ie3MWqqDaw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 549E1811E6E;
        Wed, 28 Dec 2022 03:56:49 +0000 (UTC)
Received: from [10.22.16.116] (unknown [10.22.16.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD01251FF;
        Wed, 28 Dec 2022 03:56:48 +0000 (UTC)
Message-ID: <e6095b17-d825-e60d-c15e-1c93c3289ce5@redhat.com>
Date:   Tue, 27 Dec 2022 22:56:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH] locking/barriers: Introduce
 smp_cond_load_mask_relaxed & acquire
Content-Language: en-US
To:     guoren@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
References: <20221225115529.490378-1-guoren@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221225115529.490378-1-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/25/22 06:55, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The current cond_load primitive contains two parts (condition expression
> and load value), but the usage of cond_load may require the sub-size
> condition expression of the load size. That means hardware could utilize
> a mask argument to optimize the wait condition. If the mask argument
> size is less than the hardware minimum wait size, the hardware uses its
> minimum size.
>
> The patch contains a qspinlock example: When it is at the head of the
> waitqueue, it waits for the owner & pending to go away. The forward
> progress condition only cares locked_pending part, but it needs to load
> the 32-bit lock value as a return.
>
> That also means WFE-liked instruction would need a mask argument of the
> load reservation set.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> ---
>   include/asm-generic/barrier.h | 22 ++++++++++++++++++++++
>   include/linux/atomic.h        |  4 ++++
>   kernel/locking/qspinlock.c    |  3 ++-
>   3 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index 961f4d88f9ef..fec61629f769 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -275,6 +275,28 @@ do {									\
>   })
>   #endif
>   
> +/**
> + * smp_cond_load_mask_relaxed() - (Spin) wait for cond with ACQUIRE ordering
> + * @ptr: pointer to the variable to wait on
> + * @cond: boolean expression to wait for
> + * @mask: mask *ptr to wait for (effect of 0 is the same with -1)
> + */
> +#ifndef smp_cond_load_mask_relaxed
> +#define smp_cond_load_mask_relaxed(ptr, cond_expr, mask)	\
> +	smp_cond_load_relaxed(ptr, cond_expr)
> +#endif
> +
> +/**
> + * smp_cond_load_mask_acquire() - (Spin) wait for cond with ACQUIRE ordering
> + * @ptr: pointer to the variable to wait on
> + * @cond: boolean expression to wait for
> + * @mask: mask *ptr to wait for (effect of 0 is the same with -1)
> + */
> +#ifndef smp_cond_load_mask_acquire
> +#define smp_cond_load_mask_acquire(ptr, cond_expr, mask)	\
> +	smp_cond_load_acquire(ptr, cond_expr)
> +#endif
> +
>   /*
>    * pmem_wmb() ensures that all stores for which the modification
>    * are written to persistent storage by preceding instructions have
> diff --git a/include/linux/atomic.h b/include/linux/atomic.h
> index 8dd57c3a99e9..dc7351945f27 100644
> --- a/include/linux/atomic.h
> +++ b/include/linux/atomic.h
> @@ -27,9 +27,13 @@
>   
>   #define atomic_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
>   #define atomic_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
> +#define atomic_cond_read_mask_acquire(v, c, m) smp_cond_load_mask_acquire(&(v)->counter, (c), (m))
> +#define atomic_cond_read_mask_relaxed(v, c, m) smp_cond_load_mask_relaxed(&(v)->counter, (c), (m))
>   
>   #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
>   #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
> +#define atomic64_cond_read_mask_acquire(v, c, m) smp_cond_load_mask_acquire(&(v)->counter, (c), (m))
> +#define atomic64_cond_read_mask_relaxed(v, c, m) smp_cond_load_mask_relaxed(&(v)->counter, (c), (m))
>   
>   /*
>    * The idea here is to build acquire/release variants by adding explicit
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index ebe6b8ec7cb3..14fdd2ee752c 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -511,7 +511,8 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>   	if ((val = pv_wait_head_or_lock(lock, node)))
>   		goto locked;
>   
> -	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
> +	val = atomic_cond_read_mask_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK),
> +					    _Q_LOCKED_PENDING_MASK);
>   
>   locked:
>   	/*

This patch is essentially a no-op. You will have to have at least one 
arch that has its own version of smp_cond_load_mask*() and get some 
benefit out of it. Otherwise, it is not likely to be merged.

Cheers,
Longman

