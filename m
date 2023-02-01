Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1161D6864B3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjBAKt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjBAKt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:49:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E59405B97;
        Wed,  1 Feb 2023 02:49:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8315B2F4;
        Wed,  1 Feb 2023 02:50:07 -0800 (PST)
Received: from [10.57.49.213] (unknown [10.57.49.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D48DD3F882;
        Wed,  1 Feb 2023 02:49:23 -0800 (PST)
Message-ID: <a5d842e2-a877-14fa-77a3-2d991da105ee@arm.com>
Date:   Wed, 1 Feb 2023 10:49:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/1] perf: Fix warning from concurrent read/write of
 perf_event_pmu_context
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-perf-users@vger.kernel.org, ravi.bangoria@amd.com,
        syzbot+697196bc0265049822bd@syzkaller.appspotmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230127143141.1782804-1-james.clark@arm.com>
 <20230127143141.1782804-2-james.clark@arm.com>
 <Y9kYKBMBEa7j+O3n@hirez.programming.kicks-ass.net>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <Y9kYKBMBEa7j+O3n@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/01/2023 13:31, Peter Zijlstra wrote:
> On Fri, Jan 27, 2023 at 02:31:41PM +0000, James Clark wrote:
> 
>> @@ -4897,32 +4895,32 @@ static void free_epc_rcu(struct rcu_head *head)
>>  static void put_pmu_ctx(struct perf_event_pmu_context *epc)
>>  {
>>  	unsigned long flags;
>> +	struct perf_event_context *ctx = epc->ctx;
>>  
>> -	if (!atomic_dec_and_test(&epc->refcount))
>> +	/*
>> +	 * XXX
>> +	 *
>> +	 * lockdep_assert_held(&ctx->mutex);
>> +	 *
>> +	 * can't because of the call-site in _free_event()/put_event()
>> +	 * which isn't always called under ctx->mutex.
>> +	 */
>> +	raw_spin_lock_irqsave(&ctx->lock, flags);
>> +	if (!atomic_dec_and_test(&epc->refcount)) {
>> +		raw_spin_unlock_irqrestore(&ctx->lock, flags);
>>  		return;
>> +	}
> 
> This is a bit of an anti-pattern and better donw using dec_and_lock. As
> such, I'll fold the below into it.
> 

Yep that looks better. Thanks Peter.

> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -476,6 +476,15 @@ extern int _atomic_dec_and_lock_irqsave(
>  #define atomic_dec_and_lock_irqsave(atomic, lock, flags) \
>  		__cond_lock(lock, _atomic_dec_and_lock_irqsave(atomic, lock, &(flags)))
>  
> +extern int _atomic_dec_and_raw_lock(atomic_t *atomic, raw_spinlock_t *lock);
> +#define atomic_dec_and_raw_lock(atomic, lock) \
> +		__cond_lock(lock, _atomic_dec_and_raw_lock(atomic, lock))
> +
> +extern int _atomic_dec_and_raw_lock_irqsave(atomic_t *atomic, raw_spinlock_t *lock,
> +					unsigned long *flags);
> +#define atomic_dec_and_raw_lock_irqsave(atomic, lock, flags) \
> +		__cond_lock(lock, _atomic_dec_and_raw_lock_irqsave(atomic, lock, &(flags)))
> +
>  int __alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
>  			     size_t max_size, unsigned int cpu_mult,
>  			     gfp_t gfp, const char *name,
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4901,11 +4901,8 @@ static void put_pmu_ctx(struct perf_even
>  	 * can't because of the call-site in _free_event()/put_event()
>  	 * which isn't always called under ctx->mutex.
>  	 */
> -	raw_spin_lock_irqsave(&ctx->lock, flags);
> -	if (!atomic_dec_and_test(&epc->refcount)) {
> -		raw_spin_unlock_irqrestore(&ctx->lock, flags);
> +	if (!atomic_dec_and_raw_lock_irqsave(&epc->refcount, &ctx->lock, flags))
>  		return;
> -	}
>  
>  	WARN_ON_ONCE(list_empty(&epc->pmu_ctx_entry));
>  
> --- a/lib/dec_and_lock.c
> +++ b/lib/dec_and_lock.c
> @@ -49,3 +49,34 @@ int _atomic_dec_and_lock_irqsave(atomic_
>  	return 0;
>  }
>  EXPORT_SYMBOL(_atomic_dec_and_lock_irqsave);
> +
> +int _atomic_dec_and_raw_lock(atomic_t *atomic, raw_spinlock_t *lock)
> +{
> +	/* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
> +	if (atomic_add_unless(atomic, -1, 1))
> +		return 0;
> +
> +	/* Otherwise do it the slow way */
> +	raw_spin_lock(lock);
> +	if (atomic_dec_and_test(atomic))
> +		return 1;
> +	raw_spin_unlock(lock);
> +	return 0;
> +}
> +EXPORT_SYMBOL(_atomic_dec_and_raw_lock);
> +
> +int _atomic_dec_and_raw_lock_irqsave(atomic_t *atomic, raw_spinlock_t *lock,
> +				     unsigned long *flags)
> +{
> +	/* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
> +	if (atomic_add_unless(atomic, -1, 1))
> +		return 0;
> +
> +	/* Otherwise do it the slow way */
> +	raw_spin_lock_irqsave(lock, *flags);
> +	if (atomic_dec_and_test(atomic))
> +		return 1;
> +	raw_spin_unlock_irqrestore(lock, *flags);
> +	return 0;
> +}
> +EXPORT_SYMBOL(_atomic_dec_and_raw_lock_irqsave);
