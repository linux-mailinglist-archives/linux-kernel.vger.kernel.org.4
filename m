Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1630D6DDDB7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjDKOZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDKOZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:25:41 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF011FEB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:25:14 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a52648fcddso2195225ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681223114; x=1683815114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aA7yXN2+joEEpx3b7NOs0sHQ48HGW5HeFIOcYZGJQBg=;
        b=InNRK7xYUtsP0RDhwa4iJNlfY20/3ga2Y0fEzIPEJ0GP3rIFSZbBIUPAYccdhF91NP
         dYZUzVNDVsVN+gaQdIiiiylpiW3f9YwZVs+xrHGII8JR9af23y8n5R1WuUH0XnmWSZPN
         vKZZCvZDC8hCG/zZ99KDy3kONCzfliryQlHJEGvq9vne0Fy4otIf9oA0ApPUKD3sh/vc
         WJZfNLRgkgDgHDl9+4zPhtXAEGnbjsyJ59l9IH3vqW3BIN9p2P2IshMA70laqQoQ/8BW
         XGSGPxe/o0Vrff1wyBs0TtwQcOZRZnDSTJnBRzJZ2cfNt3SqKjeSv9CYuZKLjHSZr3/Y
         ypUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681223114; x=1683815114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aA7yXN2+joEEpx3b7NOs0sHQ48HGW5HeFIOcYZGJQBg=;
        b=PPrLO8rSoOG5phC4tQcYZ8ACebEPu/Qa/wjofNhY2EbZIYS1c/gszEXC6Ip6fVWRmz
         ugCppdRDUJP62WIPbOv08YRSGUmaFASmEWN2ILNH9b8X8XWMPKtKsJQCfnQcM/CkMhs4
         WZ+VpCvPXEFlSMClniLuUrMpnypA01TRD3Fev9q9/JQGgbshbN+XT8AgvTyXUZmkI8v4
         gU/Wgu4HmRA/0aZb2nIXkLV5UujwKbTw6ixPllK3mAgufGzi/fYO7SBdNtD/vqKn9kwT
         9RD1OhKzqq0DYzyuOwZ3RLM5RwEu9DuQnkpC1ROO8XaQZnNG0bHH90ov6vkhcRQlSFkS
         T65g==
X-Gm-Message-State: AAQBX9dY7CjlZ1cgTupWRoUjc1C4Ux+yrAZk4DtzN/2gxyfoJAmBuenX
        No3OYsgsQx3mlBNbhZnl8+Ud/w==
X-Google-Smtp-Source: AKy350bQ2ra+ZXetukJ7ouMbRthj7VXcB4A0+lPJqVl2wB2w7X5R+G66Xn43uyLmj+e+OV5XltwqaQ==
X-Received: by 2002:a17:90a:cf0c:b0:236:7144:669f with SMTP id h12-20020a17090acf0c00b002367144669fmr14473327pju.2.1681223114321;
        Tue, 11 Apr 2023 07:25:14 -0700 (PDT)
Received: from [10.200.10.123] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090ae68100b00234115a2221sm8570146pjy.39.2023.04.11.07.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 07:25:13 -0700 (PDT)
Message-ID: <932bf921-a076-e166-4f95-1adb24d544cf@bytedance.com>
Date:   Tue, 11 Apr 2023 22:25:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] mm: slub: annotate kmem_cache_node->list_lock as
 raw_spinlock
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, 42.hyeyoo@gmail.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        iamjoonsoo.kim@lge.com, rientjes@google.com, penberg@kernel.org,
        cl@linux.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhao Gongyi <zhaogongyi@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20230411130854.46795-1-zhengqi.arch@bytedance.com>
 <c6ea3b17-a89c-6f66-5c86-967f1da601b4@suse.cz>
 <ccaf5e8e-3457-a2cf-b6eb-794cbf1b46f5@bytedance.com>
 <f54cfeb9-f1c3-e656-d344-4cbf97a7c28a@suse.cz>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <f54cfeb9-f1c3-e656-d344-4cbf97a7c28a@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/11 22:19, Vlastimil Babka wrote:
> On 4/11/23 16:08, Qi Zheng wrote:
>>
>>
>> On 2023/4/11 21:40, Vlastimil Babka wrote:
>>> On 4/11/23 15:08, Qi Zheng wrote:
>>>> The list_lock can be held in the critical section of
>>>> raw_spinlock, and then lockdep will complain about it
>>>> like below:
>>>>
>>>>    =============================
>>>>    [ BUG: Invalid wait context ]
>>>>    6.3.0-rc6-next-20230411 #7 Not tainted
>>>>    -----------------------------
>>>>    swapper/0/1 is trying to lock:
>>>>    ffff888100055418 (&n->list_lock){....}-{3:3}, at: ___slab_alloc+0x73d/0x1330
>>>>    other info that might help us debug this:
>>>>    context-{5:5}
>>>>    2 locks held by swapper/0/1:
>>>>     #0: ffffffff824e8160 (rcu_tasks.cbs_gbl_lock){....}-{2:2}, at: cblist_init_generic+0x22/0x2d0
>>>>     #1: ffff888136bede50 (&ACCESS_PRIVATE(rtpcp, lock)){....}-{2:2}, at: cblist_init_generic+0x232/0x2d0
>>>>    stack backtrace:
>>>>    CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc6-next-20230411 #7
>>>>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>>>>    Call Trace:
>>>>     <TASK>
>>>>     dump_stack_lvl+0x77/0xc0
>>>>     __lock_acquire+0xa65/0x2950
>>>>     ? arch_stack_walk+0x65/0xf0
>>>>     ? arch_stack_walk+0x65/0xf0
>>>>     ? unwind_next_frame+0x602/0x8d0
>>>>     lock_acquire+0xe0/0x300
>>>>     ? ___slab_alloc+0x73d/0x1330
>>>>     ? find_usage_forwards+0x39/0x50
>>>>     ? check_irq_usage+0x162/0xa70
>>>>     ? __bfs+0x10c/0x2c0
>>>>     _raw_spin_lock_irqsave+0x4f/0x90
>>>>     ? ___slab_alloc+0x73d/0x1330
>>>>     ___slab_alloc+0x73d/0x1330
>>>>     ? fill_pool+0x16b/0x2a0
>>>>     ? look_up_lock_class+0x5d/0x160
>>>>     ? register_lock_class+0x48/0x500
>>>>     ? __lock_acquire+0xabc/0x2950
>>>>     ? fill_pool+0x16b/0x2a0
>>>>     kmem_cache_alloc+0x358/0x3b0
>>>>     ? __lock_acquire+0xabc/0x2950
>>>>     fill_pool+0x16b/0x2a0
>>>>     ? __debug_object_init+0x292/0x560
>>>>     ? lock_acquire+0xe0/0x300
>>>>     ? cblist_init_generic+0x232/0x2d0
>>>>     __debug_object_init+0x2c/0x560
>>>>     cblist_init_generic+0x147/0x2d0
>>>>     rcu_init_tasks_generic+0x15/0x190
>>>>     kernel_init_freeable+0x6e/0x3e0
>>>>     ? rest_init+0x1e0/0x1e0
>>>>     kernel_init+0x1b/0x1d0
>>>>     ? rest_init+0x1e0/0x1e0
>>>>     ret_from_fork+0x1f/0x30
>>>>     </TASK>
>>>>
>>>> The fill_pool() can only be called in the !PREEMPT_RT kernel
>>>> or in the preemptible context of the PREEMPT_RT kernel, so
>>>> the above warning is not a real issue, but it's better to
>>>> annotate kmem_cache_node->list_lock as raw_spinlock to get
>>>> rid of such issue.
>>>
>>> + CC some RT and RCU people
>>
>> Thanks.
>>
>>>
>>> AFAIK raw_spinlock is not just an annotation, but on RT it changes the
>>> implementation from preemptible mutex to actual spin lock, so it would be
>>
>> Yeah.
>>
>>> rather unfortunate to do that for a spurious warning. Can it be somehow
>>> fixed in a better way?
>>
>> It's indeed unfortunate for the warning in the commit message. But
>> functions like kmem_cache_alloc(GFP_ATOMIC) may indeed be called
>> in the critical section of raw_spinlock or in the hardirq context, which
> 
> Hmm, I thought they may not, actually.
> 
>> will cause problem in the PREEMPT_RT kernel. So I still think it is
>> reasonable to convert kmem_cache_node->list_lock to raw_spinlock type.
> 
> It wouldn't be the complete solution anyway. Once we allow even a GFP_ATOMIC
> slab allocation for such context, it means also page allocation can happen
> to refill the slabs, so lockdep will eventually complain about zone->lock,
> and who knows what else.

Oh, indeed. :(

> 
>> In addition, there are many fix patches for this kind of warning in the
>> git log, so I also think there should be a general and better solution. :)
> 
> Maybe, but given above, I doubt it's this one.
> 
>>
>>>
>>
> 

-- 
Thanks,
Qi
