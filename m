Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FDB6EE4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbjDYPvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjDYPvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:51:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D736F46A1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:51:13 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63d32d21f95so1343969b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682437873; x=1685029873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZl+g5Ej3CkAUwqlFRxFOmCl6XeGbuQoLBx1Ft1/RCU=;
        b=cJ5gxBPGIKAw3sdvDbTj+bK3aJIfweq4uAB6lOccOHM9LdZcHNzoR8dPgbBspjunjs
         pjHLL0dr5HfBzQdl654qH5q9X0tVUONRsAhBmrPfFMlgc95p5MClyxPJQbBQnvIVlhEB
         ZMkd6VPr3RvDsHwjyg103tk1p+ftXKelGp2YMRhztSX9ecV4LP06cWMpWtUkSNbQMfPk
         TNtTlC0LbK6xcLfVaaoXYwckSlCcm9ZWfU4jU7xs6Nv2Arg5iCY34BxsRW4PBdgGkrpb
         O7e9emnVnhyM9AYZNtwXthZQrOhzL+AmHQQVZKny9ZxZJmYDgrIHCds+CF/n3/g+o1tz
         mtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682437873; x=1685029873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZl+g5Ej3CkAUwqlFRxFOmCl6XeGbuQoLBx1Ft1/RCU=;
        b=EcbztNuDplUU3dQFb+uCpF0k2of1iySOxYrRusI2Y4Yl7pvORiW8wlfCn3quxceKor
         apHP4IxU88rfkZW3H/wdd+dIM6NYu3EiDb4py1o8MCn3O4V5hd9aNy7jma3IDUfbagrE
         7rgP4lZrg6ArhON1T8IRec/9ej1A+cLwH0nNyHFgOEvYljiKbWbt/70CA3GAZGHZVjAA
         jYIskao4c1Xm6xRQnVcsOzWbEbVNWFEoMxYVboCSc/2Hfb8mcxAwl72iDxjrgth/oxtD
         vjOia+qqKbyk2Cs2yQLBuT15WU3R61u1F4RkE9gaUikfVxvNuo7JzFkV9WfN1ACMBzPO
         yC5w==
X-Gm-Message-State: AAQBX9ewaW/hb+8zby5C1UWOJcNI9TRzEC/GVj5JKRRZk6fUI04NzHuy
        K59oS+jMAC5s7hFmJ4H31U6Yapv+HwCqT20pRCo=
X-Google-Smtp-Source: AKy350bQt2OWtuD2cw1VJuvsFt7QmKRbQ5gmHLaeqXNNtDF04owZbFxlEXRnL10oml1zPoRvhvWCyQ==
X-Received: by 2002:a05:6a20:728a:b0:f1:c0a1:8035 with SMTP id o10-20020a056a20728a00b000f1c0a18035mr23888317pzk.0.1682437873258;
        Tue, 25 Apr 2023 08:51:13 -0700 (PDT)
Received: from [10.200.11.243] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id w68-20020a636247000000b00520f4ecd71esm8193260pgb.93.2023.04.25.08.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 08:51:12 -0700 (PDT)
Message-ID: <6582d31f-e4d5-a982-4797-c22b2dd8b150@bytedance.com>
Date:   Tue, 25 Apr 2023 23:51:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] mm: slub: annotate kmem_cache_node->list_lock as
 raw_spinlock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhao Gongyi <zhaogongyi@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <c6ea3b17-a89c-6f66-5c86-967f1da601b4@suse.cz>
 <ccaf5e8e-3457-a2cf-b6eb-794cbf1b46f5@bytedance.com>
 <f54cfeb9-f1c3-e656-d344-4cbf97a7c28a@suse.cz>
 <932bf921-a076-e166-4f95-1adb24d544cf@bytedance.com>
 <ZDZG6wlWIE4dzd4W@Boquns-Mac-mini.local>
 <PH0PR11MB58805856C1C47D49D1BA8092DA9B9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <e6a21ac6-939c-c686-387b-20f81ba5be53@suse.cz>
 <20230412124735.GE628377@hirez.programming.kicks-ass.net>
 <76e15f10-d3f1-2cab-63cb-25aa3b4f2cd4@bytedance.com>
 <20230413074013.GD4253@hirez.programming.kicks-ass.net>
 <20230425150313.GA1340063@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230425150313.GA1340063@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/25 23:03, Peter Zijlstra wrote:
> On Thu, Apr 13, 2023 at 09:40:13AM +0200, Peter Zijlstra wrote:
>> On Thu, Apr 13, 2023 at 12:44:42AM +0800, Qi Zheng wrote:
>>>> Something like the completely untested below might be of help..
>>
>>> I just tested the above code, and then got the following
>>> warning:
>>>
>>
>>> It seems that the LD_WAIT_SLEEP we set is already greater than the
>>> LD_WAIT_SPIN of the current context.
>>
>> Yeah, I'm an idiot and got it wrong.. I'll try again later if I manage
>> to wake up today :-)
> 
> And then I forgot ofcourse :/ Can you give the below (still mostly
> untested) a spin? The crucial difference is the new
> lock_map_acquire_try(). By making the annotation a 'trylock' it will
> skip the acquire of the annotation itself (since trylocks don't block).

Oh, 'trylock' is a good idea. I just tested the following code and
it can resolve the warning I encountered. :)

Thanks,
Qi

> 
> ---
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 1023f349af71..435a3b0f8ea6 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -551,6 +551,7 @@ do {									\
>   #define rwsem_release(l, i)			lock_release(l, i)
>   
>   #define lock_map_acquire(l)			lock_acquire_exclusive(l, 0, 0, NULL, _THIS_IP_)
> +#define lock_map_acquire_try(l)			lock_acquire_exclusive(l, 0, 1, NULL, _THIS_IP_)
>   #define lock_map_acquire_read(l)		lock_acquire_shared_recursive(l, 0, 0, NULL, _THIS_IP_)
>   #define lock_map_acquire_tryread(l)		lock_acquire_shared_recursive(l, 0, 1, NULL, _THIS_IP_)
>   #define lock_map_release(l)			lock_release(l, _THIS_IP_)
> diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
> index d22430840b53..f3120d6a7d9e 100644
> --- a/include/linux/lockdep_types.h
> +++ b/include/linux/lockdep_types.h
> @@ -33,6 +33,7 @@ enum lockdep_wait_type {
>   enum lockdep_lock_type {
>   	LD_LOCK_NORMAL = 0,	/* normal, catch all */
>   	LD_LOCK_PERCPU,		/* percpu */
> +	LD_LOCK_WAIT,		/* annotation */
>   	LD_LOCK_MAX,
>   };
>   
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 50d4863974e7..d254f9e53c0e 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2253,6 +2253,9 @@ static inline bool usage_match(struct lock_list *entry, void *mask)
>   
>   static inline bool usage_skip(struct lock_list *entry, void *mask)
>   {
> +	if (entry->class->lock_type == LD_LOCK_NORMAL)
> +		return false;
> +
>   	/*
>   	 * Skip local_lock() for irq inversion detection.
>   	 *
> @@ -2279,14 +2282,11 @@ static inline bool usage_skip(struct lock_list *entry, void *mask)
>   	 * As a result, we will skip local_lock(), when we search for irq
>   	 * inversion bugs.
>   	 */
> -	if (entry->class->lock_type == LD_LOCK_PERCPU) {
> -		if (DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < LD_WAIT_CONFIG))
> -			return false;
> -
> -		return true;
> -	}
> +	if (entry->class->lock_type == LD_LOCK_PERCPU &&
> +	    DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < LD_WAIT_CONFIG))
> +		return false;
>   
> -	return false;
> +	return true;
>   }
>   
>   /*
> @@ -4752,7 +4752,8 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
>   
>   	for (; depth < curr->lockdep_depth; depth++) {
>   		struct held_lock *prev = curr->held_locks + depth;
> -		u8 prev_inner = hlock_class(prev)->wait_type_inner;
> +		struct lock_class *class = hlock_class(prev);
> +		u8 prev_inner = class->wait_type_inner;
>   
>   		if (prev_inner) {
>   			/*
> @@ -4762,6 +4763,12 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
>   			 * Also due to trylocks.
>   			 */
>   			curr_inner = min(curr_inner, prev_inner);
> +
> +			/*
> +			 * Allow override for annotations.
> +			 */
> +			if (unlikely(class->lock_type == LD_LOCK_WAIT))
> +				curr_inner = prev_inner;
>   		}
>   	}
>   
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index df86e649d8be..0e089882146b 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -565,8 +565,16 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
>   	 * On RT enabled kernels the pool refill must happen in preemptible
>   	 * context:
>   	 */
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
> +		static struct lockdep_map dep_map = {
> +			.name = "wait-type-override",
> +			.wait_type_inner = LD_WAIT_SLEEP,
> +			.lock_type = LD_LOCK_WAIT,
> +		};
> +		lock_map_acquire_try(&dep_map);
>   		fill_pool();
> +		lock_map_release(&dep_map);
> +	}
>   
>   	db = get_bucket((unsigned long) addr);
>   

-- 
Thanks,
Qi
