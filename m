Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3BA6DEC07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjDLGps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLGpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:45:46 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD43F0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:45:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a66895aafdso348885ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681281944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vrFdgvoxy98DSYr+EbiMnh9ylo3lbJcx7INofpJJVwY=;
        b=Yst/A2hgpm83fjujRtUUdbnAqM3zJTCI3m2IfTAPbAPb5WLu9MHsx8WWf7lN1gNgJY
         2/aGLhwL1e5fd1S5fJr8vJKmqiorxXI87CMtslOFrwtecwpj0VEb18P4HyLeFfAeDzXu
         05wXN42NMiCE0JNgB9mdL7paKsf8+022DWbNgJ/0w2ZPwtQ2NicH8TqrSLjJRJYDrSTW
         1dz1AzJKU2cmVK73WewxREVsxOJcyVy914MgJDQiQ6WvteHaV2wREIUS00q7loGMOryq
         hKPPq0Ri8cLKi8nPessNEDue/JoTS2+PqDst4v0UCm1oRpO/f8AEy5QhhHU+veg7vivq
         pf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681281944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrFdgvoxy98DSYr+EbiMnh9ylo3lbJcx7INofpJJVwY=;
        b=sV9rkzi5VFZmB+6iqdi8GnPJj5evuHAMr9KA70VUg6pnu6KjhGFwrtuAiaS7AU2qva
         lN4Ih+vSg/sStbR0WCYM2vhDfKRCXzytHTE9HYi+rzEEJz4AsSjFK7WvLDkPvHV4DLoM
         RJrrs52IuE3Rbv+M2+MmqGPUU4EepuzDA2pV+WDh8DAh39FxkrlM40vVglOM4LKYgxBc
         4ATlWFGPBtjojKsb6qhkR6maa/b2q3HU0Tmr9BECxnNCtYu48aVHOL+RrkQZ3PKfJetH
         2zR0QBNPg2VkJwumM0wbAWzf2J4QVh880AoJ0sUrNAGBsYH9frY3BPXIfpPvdcawqinA
         pPKw==
X-Gm-Message-State: AAQBX9eYB6e6cvlCKgo2erOr4FjVa+2aO7+qVzlrPFeCOV9AiZ3sJ71Z
        JhfDtr1ftM5YrnwZ8N3vkMIBRQ==
X-Google-Smtp-Source: AKy350bIjNkh7YW+7NxOPWb0TAAZ0CFAd1RXn2vW2g/ngTNSJz6ZwrdCUpOPmjX3Ify2wd/jJmzfIw==
X-Received: by 2002:a05:6a20:7da6:b0:e3:e236:bbd4 with SMTP id v38-20020a056a207da600b000e3e236bbd4mr1439750pzj.2.1681281943943;
        Tue, 11 Apr 2023 23:45:43 -0700 (PDT)
Received: from [10.200.10.123] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id j17-20020aa783d1000000b00639a1f7b54fsm4302367pfn.60.2023.04.11.23.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 23:45:43 -0700 (PDT)
Message-ID: <31a423b5-5662-6358-a10d-489126ee0b01@bytedance.com>
Date:   Wed, 12 Apr 2023 14:45:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] mm: slub: annotate kmem_cache_node->list_lock as
 raw_spinlock
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, 42.hyeyoo@gmail.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        iamjoonsoo.kim@lge.com, rientjes@google.com, penberg@kernel.org,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhao Gongyi <zhaogongyi@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20230411130854.46795-1-zhengqi.arch@bytedance.com>
 <c6ea3b17-a89c-6f66-5c86-967f1da601b4@suse.cz>
 <ccaf5e8e-3457-a2cf-b6eb-794cbf1b46f5@bytedance.com>
 <f54cfeb9-f1c3-e656-d344-4cbf97a7c28a@suse.cz>
 <932bf921-a076-e166-4f95-1adb24d544cf@bytedance.com>
 <ZDZG6wlWIE4dzd4W@Boquns-Mac-mini.local>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <ZDZG6wlWIE4dzd4W@Boquns-Mac-mini.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/12 13:51, Boqun Feng wrote:
> On Tue, Apr 11, 2023 at 10:25:06PM +0800, Qi Zheng wrote:
>>
>>
>> On 2023/4/11 22:19, Vlastimil Babka wrote:
>>> On 4/11/23 16:08, Qi Zheng wrote:
>>>>
>>>>
>>>> On 2023/4/11 21:40, Vlastimil Babka wrote:
>>>>> On 4/11/23 15:08, Qi Zheng wrote:
>>>>>> The list_lock can be held in the critical section of
>>>>>> raw_spinlock, and then lockdep will complain about it
>>>>>> like below:
>>>>>>
>>>>>>     =============================
>>>>>>     [ BUG: Invalid wait context ]
>>>>>>     6.3.0-rc6-next-20230411 #7 Not tainted
>>>>>>     -----------------------------
>>>>>>     swapper/0/1 is trying to lock:
>>>>>>     ffff888100055418 (&n->list_lock){....}-{3:3}, at: ___slab_alloc+0x73d/0x1330
>>>>>>     other info that might help us debug this:
>>>>>>     context-{5:5}
>>>>>>     2 locks held by swapper/0/1:
>>>>>>      #0: ffffffff824e8160 (rcu_tasks.cbs_gbl_lock){....}-{2:2}, at: cblist_init_generic+0x22/0x2d0
>>>>>>      #1: ffff888136bede50 (&ACCESS_PRIVATE(rtpcp, lock)){....}-{2:2}, at: cblist_init_generic+0x232/0x2d0
>>>>>>     stack backtrace:
>>>>>>     CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc6-next-20230411 #7
>>>>>>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>>>>>>     Call Trace:
>>>>>>      <TASK>
>>>>>>      dump_stack_lvl+0x77/0xc0
>>>>>>      __lock_acquire+0xa65/0x2950
>>>>>>      ? arch_stack_walk+0x65/0xf0
>>>>>>      ? arch_stack_walk+0x65/0xf0
>>>>>>      ? unwind_next_frame+0x602/0x8d0
>>>>>>      lock_acquire+0xe0/0x300
>>>>>>      ? ___slab_alloc+0x73d/0x1330
>>>>>>      ? find_usage_forwards+0x39/0x50
>>>>>>      ? check_irq_usage+0x162/0xa70
>>>>>>      ? __bfs+0x10c/0x2c0
>>>>>>      _raw_spin_lock_irqsave+0x4f/0x90
>>>>>>      ? ___slab_alloc+0x73d/0x1330
>>>>>>      ___slab_alloc+0x73d/0x1330
>>>>>>      ? fill_pool+0x16b/0x2a0
>>>>>>      ? look_up_lock_class+0x5d/0x160
>>>>>>      ? register_lock_class+0x48/0x500
>>>>>>      ? __lock_acquire+0xabc/0x2950
>>>>>>      ? fill_pool+0x16b/0x2a0
>>>>>>      kmem_cache_alloc+0x358/0x3b0
>>>>>>      ? __lock_acquire+0xabc/0x2950
>>>>>>      fill_pool+0x16b/0x2a0
>>>>>>      ? __debug_object_init+0x292/0x560
>>>>>>      ? lock_acquire+0xe0/0x300
>>>>>>      ? cblist_init_generic+0x232/0x2d0
>>>>>>      __debug_object_init+0x2c/0x560
> 
> This "__debug_object_init" is because INIT_WORK() is called in
> cblist_init_generic(), so..

Yes, a more precise call stack is as follows:

cblist_init_generic
--> INIT_WORK
     --> lockdep_init_map
         --> lockdep_init_map_type
             --> register_lock_class
                 --> init_data_structures_once
                     --> init_rcu_head
                         --> debug_object_init
                             --> __debug_object_init

> 
>>>>>>      cblist_init_generic+0x147/0x2d0
>>>>>>      rcu_init_tasks_generic+0x15/0x190
>>>>>>      kernel_init_freeable+0x6e/0x3e0
>>>>>>      ? rest_init+0x1e0/0x1e0
>>>>>>      kernel_init+0x1b/0x1d0
>>>>>>      ? rest_init+0x1e0/0x1e0
>>>>>>      ret_from_fork+0x1f/0x30
>>>>>>      </TASK>
>>>>>>
>>>>>> The fill_pool() can only be called in the !PREEMPT_RT kernel
>>>>>> or in the preemptible context of the PREEMPT_RT kernel, so
>>>>>> the above warning is not a real issue, but it's better to
>>>>>> annotate kmem_cache_node->list_lock as raw_spinlock to get
>>>>>> rid of such issue.
>>>>>
>>>>> + CC some RT and RCU people
>>>>
>>>> Thanks.
>>>>
>>>>>
>>>>> AFAIK raw_spinlock is not just an annotation, but on RT it changes the
>>>>> implementation from preemptible mutex to actual spin lock, so it would be
>>>>
>>>> Yeah.
>>>>
>>>>> rather unfortunate to do that for a spurious warning. Can it be somehow
>>>>> fixed in a better way?
> 
> ... probably a better fix is to drop locks and call INIT_WORK(), or make
> the cblist_init_generic() lockless (or part lockless), given it's just
> initializing the cblist, it's probably doable. But I haven't taken a
> careful look yet.

This might be a doable solution for this warning, but I also saw another 
stacks like the following on v5.15:

[   30.349171] Call Trace:
[   30.349171]  <TASK>
[   30.349171]  dump_stack_lvl+0x69/0x97
[   30.349171]  __lock_acquire+0x4a0/0x1aa0
[   30.349171]  lock_acquire+0x275/0x2e0
[   30.349171]  _raw_spin_lock_irqsave+0x4c/0x90
[   30.349171]  ___slab_alloc.constprop.95+0x3ea/0xa80
[   30.349171]  __slab_alloc.isra.89.constprop.94+0x1c/0x30
[   30.349171]  kmem_cache_alloc+0x2bd/0x320
[   30.349171]  fill_pool+0x1b2/0x2d0
[   30.349171]  __debug_object_init+0x2c/0x500
[   30.349171]  debug_object_activate+0x136/0x200
[   30.349171]  add_timer+0x10b/0x170
[   30.349171]  queue_delayed_work_on+0x63/0xa0
[   30.349171]  init_mm_internals+0x226/0x2b0
[   30.349171]  kernel_init_freeable+0x82/0x24e
[   30.349171]  kernel_init+0x17/0x140
[   30.349171]  ret_from_fork+0x1f/0x30
[   30.349171]  </TASK>

So I'm a bit confused whether to fix individual cases or should there be
a general solution.

Thanks,
Qi

> 
> Regards,
> Boqun
> 
>>>>
>>>> It's indeed unfortunate for the warning in the commit message. But
>>>> functions like kmem_cache_alloc(GFP_ATOMIC) may indeed be called
>>>> in the critical section of raw_spinlock or in the hardirq context, which
>>>
>>> Hmm, I thought they may not, actually.
>>>
>>>> will cause problem in the PREEMPT_RT kernel. So I still think it is
>>>> reasonable to convert kmem_cache_node->list_lock to raw_spinlock type.
>>>
>>> It wouldn't be the complete solution anyway. Once we allow even a GFP_ATOMIC
>>> slab allocation for such context, it means also page allocation can happen
>>> to refill the slabs, so lockdep will eventually complain about zone->lock,
>>> and who knows what else.
>>
>> Oh, indeed. :(
>>
>>>
>>>> In addition, there are many fix patches for this kind of warning in the
>>>> git log, so I also think there should be a general and better solution. :)
>>>
>>> Maybe, but given above, I doubt it's this one.
>>>
>>>>
>>>>>
>>>>
>>>
>>
>> -- 
>> Thanks,
>> Qi

-- 
Thanks,
Qi
