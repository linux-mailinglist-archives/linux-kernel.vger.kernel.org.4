Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A066DF688
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDLNKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDLNKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925D159F9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681304963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QhVhYd9Vs+tavYq5Jm3v9EJMHv5TuQ7ez9lqlKu9Zx0=;
        b=TkYgUszd6BMAlnBIjNHMOwli+aPJtzd+hINrFS9Li3rW6sRwxbUksfpx8SbZLCWc3ixsQU
        DlJCv30Mov2XUBmILMkGg4vSEoH4AsEwLZP2fWYaaAAk+K5oUWWaE9a0qe2VqiB2+0eXn7
        ngQozIoOijj0ii+Ip7kxXkrbIrMxXSA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-HMnNroGjM9qtD4zWW6V99w-1; Wed, 12 Apr 2023 09:09:13 -0400
X-MC-Unique: HMnNroGjM9qtD4zWW6V99w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D937686F122;
        Wed, 12 Apr 2023 13:09:09 +0000 (UTC)
Received: from [10.22.32.168] (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E8E52027043;
        Wed, 12 Apr 2023 13:09:06 +0000 (UTC)
Message-ID: <752cafb6-fd26-0168-f871-d2d4afe417bc@redhat.com>
Date:   Wed, 12 Apr 2023 09:09:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mm: slub: annotate kmem_cache_node->list_lock as
 raw_spinlock
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
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
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230411130854.46795-1-zhengqi.arch@bytedance.com>
 <c6ea3b17-a89c-6f66-5c86-967f1da601b4@suse.cz>
 <ccaf5e8e-3457-a2cf-b6eb-794cbf1b46f5@bytedance.com>
 <f54cfeb9-f1c3-e656-d344-4cbf97a7c28a@suse.cz>
 <932bf921-a076-e166-4f95-1adb24d544cf@bytedance.com>
 <ZDZG6wlWIE4dzd4W@Boquns-Mac-mini.local>
 <PH0PR11MB58805856C1C47D49D1BA8092DA9B9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <e6a21ac6-939c-c686-387b-20f81ba5be53@suse.cz>
 <29efad1c-5ad4-5d26-b1b9-eeee6119e711@bytedance.com>
 <7f928c82-0aaf-5fac-6a54-a3d95a87b296@bytedance.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <7f928c82-0aaf-5fac-6a54-a3d95a87b296@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/23 04:32, Qi Zheng wrote:
>
>
> On 2023/4/12 15:30, Qi Zheng wrote:
>>
>>
>> On 2023/4/12 14:50, Vlastimil Babka wrote:
>>>
>>>
>>> On 4/12/23 08:44, Zhang, Qiang1 wrote:
>>>>>
>>>>>
>>>>> On 2023/4/11 22:19, Vlastimil Babka wrote:
>>>>>> On 4/11/23 16:08, Qi Zheng wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2023/4/11 21:40, Vlastimil Babka wrote:
>>>>>>>> On 4/11/23 15:08, Qi Zheng wrote:
>>>>>>>>> The list_lock can be held in the critical section of
>>>>>>>>> raw_spinlock, and then lockdep will complain about it
>>>>>>>>> like below:
>>>>>>>>>
>>>>>>>>>     =============================
>>>>>>>>>     [ BUG: Invalid wait context ]
>>>>>>>>>     6.3.0-rc6-next-20230411 #7 Not tainted
>>>>>>>>>     -----------------------------
>>>>>>>>>     swapper/0/1 is trying to lock:
>>>>>>>>>     ffff888100055418 (&n->list_lock){....}-{3:3}, at: 
>>>>>>>>> ___slab_alloc+0x73d/0x1330
>>>>>>>>>     other info that might help us debug this:
>>>>>>>>>     context-{5:5}
>>>>>>>>>     2 locks held by swapper/0/1:
>>>>>>>>>      #0: ffffffff824e8160 
>>>>>>>>> (rcu_tasks.cbs_gbl_lock){....}-{2:2}, at: 
>>>>>>>>> cblist_init_generic+0x22/0x2d0
>>>>>>>>>      #1: ffff888136bede50 (&ACCESS_PRIVATE(rtpcp, 
>>>>>>>>> lock)){....}-{2:2}, at: cblist_init_generic+0x232/0x2d0
>>>>>>>>>     stack backtrace:
>>>>>>>>>     CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
>>>>>>>>> 6.3.0-rc6-next-20230411 #7
>>>>>>>>>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
>>>>>>>>> BIOS 1.14.0-2 04/01/2014
>>>>>>>>>     Call Trace:
>>>>>>>>>      <TASK>
>>>>>>>>>      dump_stack_lvl+0x77/0xc0
>>>>>>>>>      __lock_acquire+0xa65/0x2950
>>>>>>>>>      ? arch_stack_walk+0x65/0xf0
>>>>>>>>>      ? arch_stack_walk+0x65/0xf0
>>>>>>>>>      ? unwind_next_frame+0x602/0x8d0
>>>>>>>>>      lock_acquire+0xe0/0x300
>>>>>>>>>      ? ___slab_alloc+0x73d/0x1330
>>>>>>>>>      ? find_usage_forwards+0x39/0x50
>>>>>>>>>      ? check_irq_usage+0x162/0xa70
>>>>>>>>>      ? __bfs+0x10c/0x2c0
>>>>>>>>>      _raw_spin_lock_irqsave+0x4f/0x90
>>>>>>>>>      ? ___slab_alloc+0x73d/0x1330
>>>>>>>>>      ___slab_alloc+0x73d/0x1330
>>>>>>>>>      ? fill_pool+0x16b/0x2a0
>>>>>>>>>      ? look_up_lock_class+0x5d/0x160
>>>>>>>>>      ? register_lock_class+0x48/0x500
>>>>>>>>>      ? __lock_acquire+0xabc/0x2950
>>>>>>>>>      ? fill_pool+0x16b/0x2a0
>>>>>>>>>      kmem_cache_alloc+0x358/0x3b0
>>>>>>>>>      ? __lock_acquire+0xabc/0x2950
>>>>>>>>>      fill_pool+0x16b/0x2a0
>>>>>>>>>      ? __debug_object_init+0x292/0x560
>>>>>>>>>      ? lock_acquire+0xe0/0x300
>>>>>>>>>      ? cblist_init_generic+0x232/0x2d0
>>>>>>>>>      __debug_object_init+0x2c/0x560
>>>>>
>>>>> This "__debug_object_init" is because INIT_WORK() is called in
>>>>> cblist_init_generic(), so..
>>>>>
>>>>>>>>> cblist_init_generic+0x147/0x2d0
>>>>>>>>>      rcu_init_tasks_generic+0x15/0x190
>>>>>>>>>      kernel_init_freeable+0x6e/0x3e0
>>>>>>>>>      ? rest_init+0x1e0/0x1e0
>>>>>>>>>      kernel_init+0x1b/0x1d0
>>>>>>>>>      ? rest_init+0x1e0/0x1e0
>>>>>>>>>      ret_from_fork+0x1f/0x30
>>>>>>>>>      </TASK>
>>>>>>>>>
>>>>>>>>> The fill_pool() can only be called in the !PREEMPT_RT kernel
>>>>>>>>> or in the preemptible context of the PREEMPT_RT kernel, so
>>>>>>>>> the above warning is not a real issue, but it's better to
>>>>>>>>> annotate kmem_cache_node->list_lock as raw_spinlock to get
>>>>>>>>> rid of such issue.
>>>>>>>>
>>>>>>>> + CC some RT and RCU people
>>>>>>>
>>>>>>> Thanks.
>>>>>>>
>>>>>>>>
>>>>>>>> AFAIK raw_spinlock is not just an annotation, but on RT it 
>>>>>>>> changes the
>>>>>>>> implementation from preemptible mutex to actual spin lock, so 
>>>>>>>> it would be
>>>>>>>
>>>>>>> Yeah.
>>>>>>>
>>>>>>>> rather unfortunate to do that for a spurious warning. Can it be 
>>>>>>>> somehow
>>>>>>>> fixed in a better way?
>>>>>
>>>>> ... probably a better fix is to drop locks and call INIT_WORK(), 
>>>>> or make
>>>>> the cblist_init_generic() lockless (or part lockless), given it's 
>>>>> just
>>>>> initializing the cblist, it's probably doable. But I haven't taken a
>>>>> careful look yet.
>>>>>
>>>>
>>>>
>>>> This is just one of the paths that triggers an invalid wait,  the 
>>>> following paths can also trigger:
>>>>
>>>> [  129.914547] [ BUG: Invalid wait context ]
>>>> [  129.914775] 6.3.0-rc1-yocto-standard+ #2 Not tainted
>>>> [  129.915044] -----------------------------
>>>> [  129.915272] kworker/2:0/28 is trying to lock:
>>>> [  129.915516] ffff88815660f570 (&c->lock){-.-.}-{3:3}, at: 
>>>> ___slab_alloc+0x68/0x12e0
>>>> [  129.915967] other info that might help us debug this:
>>>> [  129.916241] context-{5:5}
>>>> [  129.916392] 3 locks held by kworker/2:0/28:
>>>> [  129.916642]  #0: ffff888100084d48 
>>>> ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x515/0xba0
>>>> [  129.917145]  #1: ffff888100c17dd0 
>>>> ((work_completion)(&(&krcp->monitor_work)->work)){+.+.}-{0:0}, at: 
>>>> process_on0
>>>> [  129.917758]  #2: ffff8881565f8508 (krc.lock){....}-{2:2}, at: 
>>>> kfree_rcu_monitor+0x29f/0x810
>>>> [  129.918207] stack backtrace:
>>>> [  129.918374] CPU: 2 PID: 28 Comm: kworker/2:0 Not tainted 
>>>> 6.3.0-rc1-yocto-standard+ #2
>>>> [  129.918784] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), 
>>>> BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.o4
>>>> [  129.919397] Workqueue: events kfree_rcu_monitor
>>>> [  129.919662] Call Trace:
>>>> [  129.919812]  <TASK>
>>>> [  129.919941]  dump_stack_lvl+0x64/0xb0
>>>> [  129.920171]  dump_stack+0x10/0x20
>>>> [  129.920372]  __lock_acquire+0xeb8/0x3a80
>>>> [  129.920603]  ? ret_from_fork+0x2c/0x50
>>>> [  129.920824]  ? __pfx___lock_acquire+0x10/0x10
>>>> [  129.921068]  ? unwind_next_frame.part.0+0x1ba/0x3c0
>>>> [  129.921343]  ? ret_from_fork+0x2c/0x50
>>>> [  129.921573]  ? __this_cpu_preempt_check+0x13/0x20
>>>> [  129.921847]  lock_acquire+0x194/0x480
>>>> [  129.922060]  ? ___slab_alloc+0x68/0x12e0
>>>> [  129.922293]  ? __pfx_lock_acquire+0x10/0x10
>>>> [  129.922529]  ? __pfx_mark_lock.part.0+0x10/0x10
>>>> [  129.922778]  ? __kasan_check_read+0x11/0x20
>>>> [  129.922998]  ___slab_alloc+0x9a/0x12e0
>>>> [  129.923222]  ? ___slab_alloc+0x68/0x12e0
>>>> [  129.923452]  ? __pfx_mark_lock.part.0+0x10/0x10
>>>> [  129.923706]  ? __kasan_check_read+0x11/0x20
>>>> [  129.923937]  ? fill_pool+0x22a/0x370
>>>> [  129.924161]  ? __lock_acquire+0xf5b/0x3a80
>>>> [  129.924387]  ? fill_pool+0x22a/0x370
>>>> [  129.924590]  __slab_alloc.constprop.0+0x5b/0x90
>>>> [  129.924832]  kmem_cache_alloc+0x296/0x3d0
>>>> [  129.925073]  ? fill_pool+0x22a/0x370
>>>> [  129.925291]  fill_pool+0x22a/0x370
>>>> [  129.925495]  ? __pfx_fill_pool+0x10/0x10
>>>> [  129.925718]  ? __pfx___lock_acquire+0x10/0x10
>>>> [  129.926034]  ? __kasan_check_read+0x11/0x20
>>>> [  129.926269]  ? check_chain_key+0x200/0x2b0
>>>> [  129.926503]  __debug_object_init+0x82/0x8c0
>>>> [  129.926734]  ? __pfx_lock_release+0x10/0x10
>>>> [  129.926984]  ? __pfx___debug_object_init+0x10/0x10
>>>> [  129.927249]  ? __kasan_check_read+0x11/0x20
>>>> [  129.927498]  ? do_raw_spin_unlock+0x9c/0x100
>>>> [  129.927758]  debug_object_activate+0x2d1/0x2f0
>>>> [  129.928022]  ? __pfx_debug_object_activate+0x10/0x10
>>>> [  129.928300]  ? __this_cpu_preempt_check+0x13/0x20
>>>> [  129.928583]  __call_rcu_common.constprop.0+0x94/0xeb0
>>>> [  129.928897]  ? __this_cpu_preempt_check+0x13/0x20
>>>> [  129.929186]  ? __pfx_rcu_work_rcufn+0x10/0x10
>>>> [  129.929459]  ? __pfx___call_rcu_common.constprop.0+0x10/0x10
>>>> [  129.929803]  ? __pfx_lock_acquired+0x10/0x10
>>>> [  129.930067]  ? __pfx_do_raw_spin_trylock+0x10/0x10
>>>> [  129.930363]  ? kfree_rcu_monitor+0x29f/0x810
>>>> [  129.930627]  call_rcu+0xe/0x20
>>>> [  129.930821]  queue_rcu_work+0x4f/0x60
>>>> [  129.931050]  kfree_rcu_monitor+0x5d3/0x810
>>>> [  129.931302]  ? __pfx_kfree_rcu_monitor+0x10/0x10
>>>> [  129.931587]  ? __this_cpu_preempt_check+0x13/0x20
>>>> [  129.931878]  process_one_work+0x607/0xba0
>>>> [  129.932129]  ? __pfx_process_one_work+0x10/0x10
>>>> [  129.932408]  ? worker_thread+0xd6/0x710
>>>> [  129.932653]  worker_thread+0x2d4/0x710
>>>> [  129.932888]  ? __pfx_worker_thread+0x10/0x10
>>>> [  129.933154]  kthread+0x18b/0x1c0
>>>> [  129.933363]  ? __pfx_kthread+0x10/0x10
>>>> [  129.933598]  ret_from_fork+0x2c/0x50
>>>> [  129.933825]  </TASK>
>>>>
>>>> Maybe no need to convert ->list_lock to raw_spinlock.
>>>>
>>>> --- a/lib/debugobjects.c
>>>> +++ b/lib/debugobjects.c
>>>> @@ -562,10 +562,10 @@ __debug_object_init(void *addr, const struct 
>>>> debug_obj_descr *descr, int onstack
>>>>          unsigned long flags;
>>>>
>>>>          /*
>>>> -        * On RT enabled kernels the pool refill must happen in 
>>>> preemptible
>>>> +        * The pool refill must happen in preemptible
>>>>           * context:
>>>>           */
>>>> -       if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
>>>> +       if (preemptible())
>>>>                  fill_pool();
>>>
>>> +CC Peterz
>>>
>>> Aha so this is in fact another case where the code is written with
>>> actual differences between PREEMPT_RT and !PREEMPT_RT in mind, but
>>> CONFIG_PROVE_RAW_LOCK_NESTING always assumes PREEMPT_RT?
>>
>> Maybe we should make CONFIG_PROVE_RAW_LOCK_NESTING depend on
>> CONFIG_PREEMPT_RT:
>
> I found a discussion [1] of why CONFIG_PROVE_RAW_LOCK_NESTING didn't
> depend on CONFIG_PREEMPT_RT before in the commit history:
>
> ```
> >>> We now always get a "Invalid wait context" warning with
> >>> CONFIG_PROVE_RAW_LOCK_NESTING=y, see the full warning below:
> >>>
> >>>        [    0.705900] =============================
> >>>        [    0.706002] [ BUG: Invalid wait context ]
> >>>        [    0.706180] 5.13.0+ #4 Not tainted
> >>>        [    0.706349] -----------------------------
> >> I believe the purpose of CONFIG_PROVE_RAW_LOCK_NESTING is experimental
> >> and it is turned off by default. Turning it on can cause problem as
> >> shown in your lockdep splat. Limiting it to just PREEMPT_RT will 
> defeat
> >> its purpose to find potential spinlock nesting problem in 
> non-PREEMPT_RT
> >> kernel.
> > As far as I know, a spinlock can nest another spinlock. In
> > non-PREEMPT_RT kernel
> > spin_lock and raw_spin_lock are same , so here acquiring a spin_lock 
> in hardirq
> > context is acceptable, the warning is not needed. My knowledge on this
> > is not enough,
> > Will dig into this.
> >
> >> The point is to fix the issue found,
> > Agree. I thought there was a spinlock usage issue, but by checking
> > deactivate_slab context,
> > looks like the spinlock usage is well. Maybe I'm missing something?
>
> Yes, spinlock and raw spinlock are the same in non-RT kernel. They are
> only different in RT kernel. However, non-RT kernel is also more heavily
> tested than the RT kernel counterpart. The purpose of this config option
> is to expose spinlock nesting problem in more areas of the code. If you
> look at the config help text of PROVE_RAW_LOCK_NESTING:
>
>          help
>           Enable the raw_spinlock vs. spinlock nesting checks which 
> ensure
>           that the lock nesting rules for PREEMPT_RT enabled kernels are
>           not violated.
>
>           NOTE: There are known nesting problems. So if you enable this
>           option expect lockdep splats until these problems have been 
> fully
>           addressed which is work in progress. This config switch 
> allows to
>           identify and analyze these problems. It will be removed and the
>           check permanentely enabled once the main issues have been 
> fixed.
>
>           If unsure, select N.
>
> So lockdep splat is expected. It will take time to address all the
> issues found.
> ```
>
> Also +Waiman Long.

I believe the purpose of not making PROVE_RAW_LOCK_NESTING depending on 
PREEMPT_RT is to allow people to discover this kind of nest locking 
problem without enabling PREEMPT_RT.

Anyway, I don't think you can change list_lock to a raw spinlock. 
According to mm/slub.c:

  * Lock order:
  *   1. slab_mutex (Global Mutex)
  *   2. node->list_lock (Spinlock)
  *   3. kmem_cache->cpu_slab->lock (Local lock)
  *   4. slab_lock(slab) (Only on some arches)
  *   5. object_map_lock (Only for debugging)

For PREEMPT_RT, local lock is a per-cpu spinlock (rt_mutex). So 
list_lock has to be spinlock also.

Cheers,
Longman


