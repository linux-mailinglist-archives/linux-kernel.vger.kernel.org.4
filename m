Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504E16DDD93
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjDKOTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjDKOTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:19:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F4D4680;
        Tue, 11 Apr 2023 07:19:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 08067219D4;
        Tue, 11 Apr 2023 14:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681222775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BV/iOuY3tZ30InHD5r4cvxoa3TS4xAh5ueSwnmy0PUI=;
        b=crdDxRaBGzyB3zB0DL1Kg4gQ1WCo2jvVvFNkRIhz3KimP4omI5TwRwL/nAXz3tG3c2ElZc
        jhDHt5N1fZaPOP7+25uTcrsykzfJbq6Q0jzZjsIvggDb9sl/oNRkveFD80krveiwNWe03g
        DzyIz/IoTwiWe6y7KuYLg02GCRdkgh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681222775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BV/iOuY3tZ30InHD5r4cvxoa3TS4xAh5ueSwnmy0PUI=;
        b=ByqMOCwojdA9dsMWcuK6BbwAOTKrFQ4DgFdf1zXapgeMlAX555Mddlr73GFZo2pSdG3ZaV
        9ksEujjGUUXvAqCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C0BF13638;
        Tue, 11 Apr 2023 14:19:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CmiHJXZsNWSQVAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 11 Apr 2023 14:19:34 +0000
Message-ID: <f54cfeb9-f1c3-e656-d344-4cbf97a7c28a@suse.cz>
Date:   Tue, 11 Apr 2023 16:19:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mm: slub: annotate kmem_cache_node->list_lock as
 raw_spinlock
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, 42.hyeyoo@gmail.com,
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
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ccaf5e8e-3457-a2cf-b6eb-794cbf1b46f5@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 16:08, Qi Zheng wrote:
> 
> 
> On 2023/4/11 21:40, Vlastimil Babka wrote:
>> On 4/11/23 15:08, Qi Zheng wrote:
>>> The list_lock can be held in the critical section of
>>> raw_spinlock, and then lockdep will complain about it
>>> like below:
>>>
>>>   =============================
>>>   [ BUG: Invalid wait context ]
>>>   6.3.0-rc6-next-20230411 #7 Not tainted
>>>   -----------------------------
>>>   swapper/0/1 is trying to lock:
>>>   ffff888100055418 (&n->list_lock){....}-{3:3}, at: ___slab_alloc+0x73d/0x1330
>>>   other info that might help us debug this:
>>>   context-{5:5}
>>>   2 locks held by swapper/0/1:
>>>    #0: ffffffff824e8160 (rcu_tasks.cbs_gbl_lock){....}-{2:2}, at: cblist_init_generic+0x22/0x2d0
>>>    #1: ffff888136bede50 (&ACCESS_PRIVATE(rtpcp, lock)){....}-{2:2}, at: cblist_init_generic+0x232/0x2d0
>>>   stack backtrace:
>>>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc6-next-20230411 #7
>>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>>>   Call Trace:
>>>    <TASK>
>>>    dump_stack_lvl+0x77/0xc0
>>>    __lock_acquire+0xa65/0x2950
>>>    ? arch_stack_walk+0x65/0xf0
>>>    ? arch_stack_walk+0x65/0xf0
>>>    ? unwind_next_frame+0x602/0x8d0
>>>    lock_acquire+0xe0/0x300
>>>    ? ___slab_alloc+0x73d/0x1330
>>>    ? find_usage_forwards+0x39/0x50
>>>    ? check_irq_usage+0x162/0xa70
>>>    ? __bfs+0x10c/0x2c0
>>>    _raw_spin_lock_irqsave+0x4f/0x90
>>>    ? ___slab_alloc+0x73d/0x1330
>>>    ___slab_alloc+0x73d/0x1330
>>>    ? fill_pool+0x16b/0x2a0
>>>    ? look_up_lock_class+0x5d/0x160
>>>    ? register_lock_class+0x48/0x500
>>>    ? __lock_acquire+0xabc/0x2950
>>>    ? fill_pool+0x16b/0x2a0
>>>    kmem_cache_alloc+0x358/0x3b0
>>>    ? __lock_acquire+0xabc/0x2950
>>>    fill_pool+0x16b/0x2a0
>>>    ? __debug_object_init+0x292/0x560
>>>    ? lock_acquire+0xe0/0x300
>>>    ? cblist_init_generic+0x232/0x2d0
>>>    __debug_object_init+0x2c/0x560
>>>    cblist_init_generic+0x147/0x2d0
>>>    rcu_init_tasks_generic+0x15/0x190
>>>    kernel_init_freeable+0x6e/0x3e0
>>>    ? rest_init+0x1e0/0x1e0
>>>    kernel_init+0x1b/0x1d0
>>>    ? rest_init+0x1e0/0x1e0
>>>    ret_from_fork+0x1f/0x30
>>>    </TASK>
>>>
>>> The fill_pool() can only be called in the !PREEMPT_RT kernel
>>> or in the preemptible context of the PREEMPT_RT kernel, so
>>> the above warning is not a real issue, but it's better to
>>> annotate kmem_cache_node->list_lock as raw_spinlock to get
>>> rid of such issue.
>> 
>> + CC some RT and RCU people
> 
> Thanks.
> 
>> 
>> AFAIK raw_spinlock is not just an annotation, but on RT it changes the
>> implementation from preemptible mutex to actual spin lock, so it would be
> 
> Yeah.
> 
>> rather unfortunate to do that for a spurious warning. Can it be somehow
>> fixed in a better way?
> 
> It's indeed unfortunate for the warning in the commit message. But
> functions like kmem_cache_alloc(GFP_ATOMIC) may indeed be called
> in the critical section of raw_spinlock or in the hardirq context, which

Hmm, I thought they may not, actually.

> will cause problem in the PREEMPT_RT kernel. So I still think it is
> reasonable to convert kmem_cache_node->list_lock to raw_spinlock type.

It wouldn't be the complete solution anyway. Once we allow even a GFP_ATOMIC
slab allocation for such context, it means also page allocation can happen
to refill the slabs, so lockdep will eventually complain about zone->lock,
and who knows what else.

> In addition, there are many fix patches for this kind of warning in the
> git log, so I also think there should be a general and better solution. :)

Maybe, but given above, I doubt it's this one.

> 
>> 
> 

