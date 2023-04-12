Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935EC6DEB6F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjDLFvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDLFvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:51:46 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8651BD1;
        Tue, 11 Apr 2023 22:51:45 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id h14so191611qvr.7;
        Tue, 11 Apr 2023 22:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681278704; x=1683870704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvoUVygYOW2rUunYuamK7w2S9WEkc7tFRqN89hV4hPk=;
        b=gA5lCO46B+6ruQh/YRtnNjPsNTHjdUCzaAlHSLkulLacw1xZYb/eyxzFs+y7PCYtT3
         bhQFC3NOEPbZUS7CpJJOLHoDIb4DALTFUjAlKU54Rc4tZNZpClEkz1lyTQwiA/wLnn0n
         zy76SqHmpyq0WaA9mCv/ezvrBzFwufytiEqrkPlFJH0K0MVeUmvpdEDRrYvsaIPfCl0u
         4mBbDr/eJENN4le1LgTeGNqDYjXaylZCXjn7z8au9wcdT1PpuotFwjrZ3lzVZeOybmsi
         GhMJIUEIdrcfDbMN0h7bgG54qXf8BenQ22fjil05Zle2jFBWeOGlbOy+mDFLhf32dUww
         u5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681278704; x=1683870704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvoUVygYOW2rUunYuamK7w2S9WEkc7tFRqN89hV4hPk=;
        b=iGIA16B6fcmLUZPXbs/1XrCDzYdFL3DAEMpCTlerHvGR4GvlHSadCDuyhH8KeBse1v
         FZlcrR54lJgsFUdA3acoKQE4pai2c5BVkW0dlEPpsBfciUTsajg4lCkLjDktR6oZTz9d
         Q2mHkOmYA6kYu55KErIqhb0tPOkU7tH2PvQZmQimmUxMzX46rY/i8pgjeHh7O9Gt9pV2
         DKXHw6469cEMURxqJhjKayeTZPjporWvEVxFAtTzHymQTf3aBL5ZZYtnSTGtpg2zw/+H
         DwcDkqRjrBYBa/ARtEw1sZiaCM0LtgPDoUCQ/F0WhreR7yCJtfnSO2FhGnnmcb2/HAKC
         i3tQ==
X-Gm-Message-State: AAQBX9cfUgKsJgbIjPaqeWo3i8VqDgC/4gvGo4GC9Z2htfgt/GJ/79Fk
        uMrYSOZDNe5pi/gbz+dGep5zKihJaEk=
X-Google-Smtp-Source: AKy350ZROPNKm2R2IXTYYFnwI965VTRavSgYHkf77npfXYkY7KCJJrKBsX2OLzOP5lOPt/r36ojSGA==
X-Received: by 2002:a05:6214:2027:b0:5ee:a282:d38e with SMTP id 7-20020a056214202700b005eea282d38emr2735807qvf.10.1681278704507;
        Tue, 11 Apr 2023 22:51:44 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id ep9-20020a05621418e900b005e14936cb09sm3779649qvb.11.2023.04.11.22.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 22:51:43 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 32FDA27C0054;
        Wed, 12 Apr 2023 01:51:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 12 Apr 2023 01:51:43 -0400
X-ME-Sender: <xms:7UY2ZAMJY7RbR4a4fess2gw3ACWZiBH6u2S35Hqst9U1OSoJAeY_1A>
    <xme:7UY2ZG-k_fix67PkquslqaHXAizaNAMVisU4bnbuUh1k_tW_CJcM_U5hoVL1uDSai
    ILQ2e_c52X0onwzWg>
X-ME-Received: <xmr:7UY2ZHQVb7Xe_Ct4yrOPgHZ5U_RVHwj15R59c4zJlOVT6xmEYWkN0R3byMed03TV5uduFBds_rTyrlFrjVOaWSwjvTEIMgVRUt0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekhedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:7UY2ZIvGZbGRvlGJyG2Ckq5WjnmCUf6rDqBPU27pnlCs_wometsE5A>
    <xmx:7UY2ZIcvHsc-VK71rXuaSjyVt2aXXyFz5vKOCr508xHJuOGFngLhRw>
    <xmx:7UY2ZM0i6EmqzDtZop8rZNEiz7rboYvuEz__ViMxFaoMD7DnlYvZqw>
    <xmx:70Y2ZM-2eX2HBMEDGuAwgiIZD-YE_rKoqibRL97N7yhua3DIns-peg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 01:51:41 -0400 (EDT)
Date:   Tue, 11 Apr 2023 22:51:39 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, 42.hyeyoo@gmail.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        iamjoonsoo.kim@lge.com, rientjes@google.com, penberg@kernel.org,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhao Gongyi <zhaogongyi@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] mm: slub: annotate kmem_cache_node->list_lock as
 raw_spinlock
Message-ID: <ZDZG6wlWIE4dzd4W@Boquns-Mac-mini.local>
References: <20230411130854.46795-1-zhengqi.arch@bytedance.com>
 <c6ea3b17-a89c-6f66-5c86-967f1da601b4@suse.cz>
 <ccaf5e8e-3457-a2cf-b6eb-794cbf1b46f5@bytedance.com>
 <f54cfeb9-f1c3-e656-d344-4cbf97a7c28a@suse.cz>
 <932bf921-a076-e166-4f95-1adb24d544cf@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <932bf921-a076-e166-4f95-1adb24d544cf@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 10:25:06PM +0800, Qi Zheng wrote:
> 
> 
> On 2023/4/11 22:19, Vlastimil Babka wrote:
> > On 4/11/23 16:08, Qi Zheng wrote:
> > > 
> > > 
> > > On 2023/4/11 21:40, Vlastimil Babka wrote:
> > > > On 4/11/23 15:08, Qi Zheng wrote:
> > > > > The list_lock can be held in the critical section of
> > > > > raw_spinlock, and then lockdep will complain about it
> > > > > like below:
> > > > > 
> > > > >    =============================
> > > > >    [ BUG: Invalid wait context ]
> > > > >    6.3.0-rc6-next-20230411 #7 Not tainted
> > > > >    -----------------------------
> > > > >    swapper/0/1 is trying to lock:
> > > > >    ffff888100055418 (&n->list_lock){....}-{3:3}, at: ___slab_alloc+0x73d/0x1330
> > > > >    other info that might help us debug this:
> > > > >    context-{5:5}
> > > > >    2 locks held by swapper/0/1:
> > > > >     #0: ffffffff824e8160 (rcu_tasks.cbs_gbl_lock){....}-{2:2}, at: cblist_init_generic+0x22/0x2d0
> > > > >     #1: ffff888136bede50 (&ACCESS_PRIVATE(rtpcp, lock)){....}-{2:2}, at: cblist_init_generic+0x232/0x2d0
> > > > >    stack backtrace:
> > > > >    CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc6-next-20230411 #7
> > > > >    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> > > > >    Call Trace:
> > > > >     <TASK>
> > > > >     dump_stack_lvl+0x77/0xc0
> > > > >     __lock_acquire+0xa65/0x2950
> > > > >     ? arch_stack_walk+0x65/0xf0
> > > > >     ? arch_stack_walk+0x65/0xf0
> > > > >     ? unwind_next_frame+0x602/0x8d0
> > > > >     lock_acquire+0xe0/0x300
> > > > >     ? ___slab_alloc+0x73d/0x1330
> > > > >     ? find_usage_forwards+0x39/0x50
> > > > >     ? check_irq_usage+0x162/0xa70
> > > > >     ? __bfs+0x10c/0x2c0
> > > > >     _raw_spin_lock_irqsave+0x4f/0x90
> > > > >     ? ___slab_alloc+0x73d/0x1330
> > > > >     ___slab_alloc+0x73d/0x1330
> > > > >     ? fill_pool+0x16b/0x2a0
> > > > >     ? look_up_lock_class+0x5d/0x160
> > > > >     ? register_lock_class+0x48/0x500
> > > > >     ? __lock_acquire+0xabc/0x2950
> > > > >     ? fill_pool+0x16b/0x2a0
> > > > >     kmem_cache_alloc+0x358/0x3b0
> > > > >     ? __lock_acquire+0xabc/0x2950
> > > > >     fill_pool+0x16b/0x2a0
> > > > >     ? __debug_object_init+0x292/0x560
> > > > >     ? lock_acquire+0xe0/0x300
> > > > >     ? cblist_init_generic+0x232/0x2d0
> > > > >     __debug_object_init+0x2c/0x560

This "__debug_object_init" is because INIT_WORK() is called in
cblist_init_generic(), so..

> > > > >     cblist_init_generic+0x147/0x2d0
> > > > >     rcu_init_tasks_generic+0x15/0x190
> > > > >     kernel_init_freeable+0x6e/0x3e0
> > > > >     ? rest_init+0x1e0/0x1e0
> > > > >     kernel_init+0x1b/0x1d0
> > > > >     ? rest_init+0x1e0/0x1e0
> > > > >     ret_from_fork+0x1f/0x30
> > > > >     </TASK>
> > > > > 
> > > > > The fill_pool() can only be called in the !PREEMPT_RT kernel
> > > > > or in the preemptible context of the PREEMPT_RT kernel, so
> > > > > the above warning is not a real issue, but it's better to
> > > > > annotate kmem_cache_node->list_lock as raw_spinlock to get
> > > > > rid of such issue.
> > > > 
> > > > + CC some RT and RCU people
> > > 
> > > Thanks.
> > > 
> > > > 
> > > > AFAIK raw_spinlock is not just an annotation, but on RT it changes the
> > > > implementation from preemptible mutex to actual spin lock, so it would be
> > > 
> > > Yeah.
> > > 
> > > > rather unfortunate to do that for a spurious warning. Can it be somehow
> > > > fixed in a better way?

... probably a better fix is to drop locks and call INIT_WORK(), or make
the cblist_init_generic() lockless (or part lockless), given it's just
initializing the cblist, it's probably doable. But I haven't taken a
careful look yet.

Regards,
Boqun

> > > 
> > > It's indeed unfortunate for the warning in the commit message. But
> > > functions like kmem_cache_alloc(GFP_ATOMIC) may indeed be called
> > > in the critical section of raw_spinlock or in the hardirq context, which
> > 
> > Hmm, I thought they may not, actually.
> > 
> > > will cause problem in the PREEMPT_RT kernel. So I still think it is
> > > reasonable to convert kmem_cache_node->list_lock to raw_spinlock type.
> > 
> > It wouldn't be the complete solution anyway. Once we allow even a GFP_ATOMIC
> > slab allocation for such context, it means also page allocation can happen
> > to refill the slabs, so lockdep will eventually complain about zone->lock,
> > and who knows what else.
> 
> Oh, indeed. :(
> 
> > 
> > > In addition, there are many fix patches for this kind of warning in the
> > > git log, so I also think there should be a general and better solution. :)
> > 
> > Maybe, but given above, I doubt it's this one.
> > 
> > > 
> > > > 
> > > 
> > 
> 
> -- 
> Thanks,
> Qi
