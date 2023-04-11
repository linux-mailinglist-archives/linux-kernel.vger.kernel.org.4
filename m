Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBFC6DDD46
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjDKOIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjDKOIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:08:31 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3750F197
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:08:10 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a52648fcddso2176075ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681222089; x=1683814089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/FuUBX/oF7NlHyBeA4tCFMg08z1lRlCt7snQ+IazRc=;
        b=ZGQN5zSPpnt9Gr1BTrqkXN1evZuAqurPhKj7vfdZedWsMBx9/8buvIj9JD67dQipmx
         VCWCR1nyWiIVGts1LB3aLAVr3Ztl0vD9HBB1VD+FQRXySUy5NXLUokW56RYI33TBmtuo
         XHUf5MoBdM60D6qfs2MeHfgxm6dtlJA1Xr74wxJl0IFBEe0qdOr08v3QZ2tCQvjL7w3D
         fC+iKD6AerXomXzioNocXZKkim1biNzIYLqt+c7BWrbjKykiaoBMnjhmIK8ypzjKyWLc
         X8ZdMCmVxIB5hCGQtFpOBStEmIynJBo2f1oPcqxi++RHHTk1HeXBonkg5ST/oGb4rRmg
         II4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681222089; x=1683814089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/FuUBX/oF7NlHyBeA4tCFMg08z1lRlCt7snQ+IazRc=;
        b=lW0+HKw9roZdv0UyeBkOg90FBOsq37TRY6Idon6MKgjhidJ1yhQKMLBcUdEfJOqPC0
         v4cMEMRuSesTQB8sb70aC1iZy0iuZ9hDCWlEcWABxaXrdlW+HoomLPBn3feSo7TX3Y7i
         XdwWTCoq7i/oi07xslBm2UIrHh5dO/f55tnW08sx+XoRk6X/XNR/3dyFViNqy3aDETcu
         oyPM/4fbztw4MEf13hCTdaUdnxQUPyMGBQdwHN+75Owg/npGMp6g5U6DyGglSgA0tb54
         8eAl9UtTIwA3b6XzoupV7lUpNC0LK2Tj8Be5/PL/ul/iKeA3NLqxYe7qppImvhTWWTkR
         uGxg==
X-Gm-Message-State: AAQBX9d/j180agNDEkU4sTb1SzVy3yXzMUXk/gPOmq5mm27lZzP7ohLa
        GyA8gi2GICJWclx13iNmtRoKrg==
X-Google-Smtp-Source: AKy350Y0ucw/4ZrTHcZLDUPrDQNrdscqkfy1vGI2p/5yLdQsTXgObQ0lOKINHgGJ5Lb77YesOypQDQ==
X-Received: by 2002:a17:902:fb4f:b0:1a5:aca9:50c5 with SMTP id lf15-20020a170902fb4f00b001a5aca950c5mr8257942plb.6.1681222089487;
        Tue, 11 Apr 2023 07:08:09 -0700 (PDT)
Received: from [10.200.10.123] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id s4-20020a170902988400b0019cd1ee1523sm9758946plp.30.2023.04.11.07.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 07:08:09 -0700 (PDT)
Message-ID: <ccaf5e8e-3457-a2cf-b6eb-794cbf1b46f5@bytedance.com>
Date:   Tue, 11 Apr 2023 22:08:01 +0800
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
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <c6ea3b17-a89c-6f66-5c86-967f1da601b4@suse.cz>
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



On 2023/4/11 21:40, Vlastimil Babka wrote:
> On 4/11/23 15:08, Qi Zheng wrote:
>> The list_lock can be held in the critical section of
>> raw_spinlock, and then lockdep will complain about it
>> like below:
>>
>>   =============================
>>   [ BUG: Invalid wait context ]
>>   6.3.0-rc6-next-20230411 #7 Not tainted
>>   -----------------------------
>>   swapper/0/1 is trying to lock:
>>   ffff888100055418 (&n->list_lock){....}-{3:3}, at: ___slab_alloc+0x73d/0x1330
>>   other info that might help us debug this:
>>   context-{5:5}
>>   2 locks held by swapper/0/1:
>>    #0: ffffffff824e8160 (rcu_tasks.cbs_gbl_lock){....}-{2:2}, at: cblist_init_generic+0x22/0x2d0
>>    #1: ffff888136bede50 (&ACCESS_PRIVATE(rtpcp, lock)){....}-{2:2}, at: cblist_init_generic+0x232/0x2d0
>>   stack backtrace:
>>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc6-next-20230411 #7
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>>   Call Trace:
>>    <TASK>
>>    dump_stack_lvl+0x77/0xc0
>>    __lock_acquire+0xa65/0x2950
>>    ? arch_stack_walk+0x65/0xf0
>>    ? arch_stack_walk+0x65/0xf0
>>    ? unwind_next_frame+0x602/0x8d0
>>    lock_acquire+0xe0/0x300
>>    ? ___slab_alloc+0x73d/0x1330
>>    ? find_usage_forwards+0x39/0x50
>>    ? check_irq_usage+0x162/0xa70
>>    ? __bfs+0x10c/0x2c0
>>    _raw_spin_lock_irqsave+0x4f/0x90
>>    ? ___slab_alloc+0x73d/0x1330
>>    ___slab_alloc+0x73d/0x1330
>>    ? fill_pool+0x16b/0x2a0
>>    ? look_up_lock_class+0x5d/0x160
>>    ? register_lock_class+0x48/0x500
>>    ? __lock_acquire+0xabc/0x2950
>>    ? fill_pool+0x16b/0x2a0
>>    kmem_cache_alloc+0x358/0x3b0
>>    ? __lock_acquire+0xabc/0x2950
>>    fill_pool+0x16b/0x2a0
>>    ? __debug_object_init+0x292/0x560
>>    ? lock_acquire+0xe0/0x300
>>    ? cblist_init_generic+0x232/0x2d0
>>    __debug_object_init+0x2c/0x560
>>    cblist_init_generic+0x147/0x2d0
>>    rcu_init_tasks_generic+0x15/0x190
>>    kernel_init_freeable+0x6e/0x3e0
>>    ? rest_init+0x1e0/0x1e0
>>    kernel_init+0x1b/0x1d0
>>    ? rest_init+0x1e0/0x1e0
>>    ret_from_fork+0x1f/0x30
>>    </TASK>
>>
>> The fill_pool() can only be called in the !PREEMPT_RT kernel
>> or in the preemptible context of the PREEMPT_RT kernel, so
>> the above warning is not a real issue, but it's better to
>> annotate kmem_cache_node->list_lock as raw_spinlock to get
>> rid of such issue.
> 
> + CC some RT and RCU people

Thanks.

> 
> AFAIK raw_spinlock is not just an annotation, but on RT it changes the
> implementation from preemptible mutex to actual spin lock, so it would be

Yeah.

> rather unfortunate to do that for a spurious warning. Can it be somehow
> fixed in a better way?

It's indeed unfortunate for the warning in the commit message. But
functions like kmem_cache_alloc(GFP_ATOMIC) may indeed be called
in the critical section of raw_spinlock or in the hardirq context, which
will cause problem in the PREEMPT_RT kernel. So I still think it is
reasonable to convert kmem_cache_node->list_lock to raw_spinlock type.

In addition, there are many fix patches for this kind of warning in the
git log, so I also think there should be a general and better solution. :)

> 

-- 
Thanks,
Qi
