Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79206170BE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 23:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiKBWfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 18:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBWfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:35:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498DFBC34;
        Wed,  2 Nov 2022 15:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6549B824FA;
        Wed,  2 Nov 2022 22:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E891C433C1;
        Wed,  2 Nov 2022 22:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667428516;
        bh=Om3QRnnYQbp26+VRHx4KigiYKkeJ2zYlKKUn85uboR8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pjdQVRYuP5GYuEsXnZH+YCVcvsJopXm/BJZ2vO1koF+0IjJJHhnO/17OvWEbzj0R6
         iK5729OfIfhuVNDE4YxYufV+554yXmmp0zU2GXHlcHoqRrKFOD3lYQMWjtH5we6aJt
         tVuuHEqcakAoeD1epF1i73alrRfh5YzMk9mTBbiQmAkNOG+inwqMiYapf4JCjrmw68
         nwFb1qJAUgIJer0hUJyNZCMXE8KlOo+FSpVlGt5gDc/YVy82V/HBFQt/wysEYqkyma
         dA1uR6bS8xVmPesK3/llPOSyy3zXCNkLsUGp3vrJPVnB4YTvrFwD2x/OkMiWkT4Xy0
         FmfxIsX74J5eQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3147A5C1813; Wed,  2 Nov 2022 15:35:16 -0700 (PDT)
Date:   Wed, 2 Nov 2022 15:35:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Message-ID: <20221102223516.GT5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221102184911.GP5600@paulmck-ThinkPad-P17-Gen-1>
 <755B5ED1-653D-4E57-B114-77CDE10A9033@joelfernandes.org>
 <20221102202813.GR5600@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ+SxBoNUkPHhC3O0DJNQtZomN_4GPtvaWuDs5sSU4FAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQ+SxBoNUkPHhC3O0DJNQtZomN_4GPtvaWuDs5sSU4FAw@mail.gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 05:26:40PM -0400, Joel Fernandes wrote:
> On Wed, Nov 2, 2022 at 4:28 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Nov 02, 2022 at 03:46:59PM -0400, Joel Fernandes wrote:
> > >
> > >
> > > > On Nov 2, 2022, at 2:49 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > ﻿On Wed, Nov 02, 2022 at 07:31:40PM +0100, Uladzislau Rezki wrote:
> > > >>> On Wed, Nov 02, 2022 at 01:29:17PM -0400, Joel Fernandes wrote:
> > > >>> On Wed, Nov 2, 2022 at 1:24 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >>>>
> > > >>>> On Wed, Nov 02, 2022 at 09:35:44AM -0700, Paul E. McKenney wrote:
> > > >>>>> On Wed, Nov 02, 2022 at 12:13:17PM -0400, Joel Fernandes wrote:
> > > >>>>>> On Wed, Nov 2, 2022 at 8:37 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >>>>>>>
> > > >>>>>>> On Sat, Oct 29, 2022 at 01:28:56PM +0000, Joel Fernandes (Google) wrote:
> > > >>>>>>>> On ChromeOS, I am (almost) always seeing the optimization trigger.
> > > >>>>>>>> Tested boot up and trace_printk'ing how often it triggers.
> > > >>>>>>>>
> > > >>>>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >>>>>>>> ---
> > > >>>>>>>> kernel/rcu/tree.c | 18 +++++++++++++++++-
> > > >>>>>>>> 1 file changed, 17 insertions(+), 1 deletion(-)
> > > >>>>>>>>
> > > >>>>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > >>>>>>>> index 591187b6352e..3e4c50b9fd33 100644
> > > >>>>>>>> --- a/kernel/rcu/tree.c
> > > >>>>>>>> +++ b/kernel/rcu/tree.c
> > > >>>>>>>> @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
> > > >>>>>>>>
> > > >>>>>>>> /**
> > > >>>>>>>>  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
> > > >>>>>>>> + * @rdp: The rdp of the CPU that this kfree_rcu corresponds to.
> > > >>>>>>>>  * @head: List of kfree_rcu() objects not yet waiting for a grace period
> > > >>>>>>>>  * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
> > > >>>>>>>>  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> > > >>>>>>>> @@ -2964,6 +2965,8 @@ struct kfree_rcu_cpu {
> > > >>>>>>>>      struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> > > >>>>>>>>      raw_spinlock_t lock;
> > > >>>>>>>>      struct delayed_work monitor_work;
> > > >>>>>>>> +     struct rcu_data *rdp;
> > > >>>>>>>> +     unsigned long last_gp_seq;
> > > >>>>>>>>      bool initialized;
> > > >>>>>>>>      int count;
> > > >>>>>>>>
> > > >>>>>>>> @@ -3167,6 +3170,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
> > > >>>>>>>>                      mod_delayed_work(system_wq, &krcp->monitor_work, delay);
> > > >>>>>>>>              return;
> > > >>>>>>>>      }
> > > >>>>>>>> +     krcp->last_gp_seq = krcp->rdp->gp_seq;
> > > >>>>>>>>      queue_delayed_work(system_wq, &krcp->monitor_work, delay);
> > > >>>>>>>> }
> > > >>>>>>>>
> > > >>>>>>>> @@ -3217,7 +3221,17 @@ static void kfree_rcu_monitor(struct work_struct *work)
> > > >>>>>>>>                      // be that the work is in the pending state when
> > > >>>>>>>>                      // channels have been detached following by each
> > > >>>>>>>>                      // other.
> > > >>>>>>>> -                     queue_rcu_work(system_wq, &krwp->rcu_work);
> > > >>>>>>>> +                     //
> > > >>>>>>>> +                     // NOTE about gp_seq wrap: In case of gp_seq overflow,
> > > >>>>>>>> +                     // it is possible for rdp->gp_seq to be less than
> > > >>>>>>>> +                     // krcp->last_gp_seq even though a GP might be over. In
> > > >>>>>>>> +                     // this rare case, we would just have one extra GP.
> > > >>>>>>>> +                     if (krcp->last_gp_seq &&
> > > >>>>>>>>
> > > >>>>>>> This check can be eliminated i think. A kfree_rcu_cpu is defined as
> > > >>>>>>> static so by default the last_gp_set is set to zero.
> > > >>>>>>
> > > >>>>>> Ack.
> > > >>>>>>
> > > >>>>>>>> @@ -4802,6 +4816,8 @@ static void __init kfree_rcu_batch_init(void)
> > > >>>>>>>>      for_each_possible_cpu(cpu) {
> > > >>>>>>>>              struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > >>>>>>>>
> > > >>>>>>>> +             krcp->rdp = per_cpu_ptr(&rcu_data, cpu);
> > > >>>>>>>> +             krcp->last_gp_seq = 0;
> > > >>>>>>>>
> > > >>>>>>> Yep. This one can be just dropped.
> > > >>>>>>>
> > > >>>>>>> But all the rest looks good :) I will give it a try from test point of
> > > >>>>>>> view. It is interested from the memory footprint point of view.
> > > >>>>>>
> > > >>>>>> Ack. Thanks. Even though we should not sample rdp->gp_seq, I think it
> > > >>>>>> is still worth a test.
> > > >>>>>
> > > >>>>> Just for completeness, the main purpose of rdp->gp_seq is to reject
> > > >>>>> quiescent states that were seen during already-completed grace periods.
> > > >>>>>
> > > >>>> So it means that instead of gp_seq reading we should take a snaphshot
> > > >>>> of the current state:
> > > >>>>
> > > >>>> snp = get_state_synchronize_rcu();
> > > >>>>
> > > >>>> and later on do a:
> > > >>>>
> > > >>>> cond_synchronize_rcu(snp);
> > > >>>>
> > > >>>> to wait for a GP.
> > > >>>
> > > >>> This can't be called from the timer IRQ handler though (monitor)
> > > >>>
> > > >>>> Or if the poll_state_synchronize_rcu(oldstate)) != 0
> > > >>>> queue_rcu_work().
> > > >>>
> > > >>> But something like this should be possible (maybe)
> > > >>>
> > > >>>> Sorry for a description using the RCU API functions name :)
> > > >>>
> > > >>> I believe you will have to call rcu_poll_gp_seq_start() as well if you
> > > >>> are using polled API. I am planning to look at this properly more,
> > > >>> soon. Right now I am going to write up the rcutop doc and share with
> > > >>> you guys.
> > > >>>
> > > >>> (Maybe RCU polling is the right thing to do as we reuse all the infra
> > > >>> and any corner case it is handling)
> > > >>>
> > > >> OK. This is in my todo list also. Since we have discussed it let's move
> > > >> it forward.
> > > >>
> > > >> Below what i have came up with to switch for polling APIs:
> > > >>
> > > >>> From 799ce1653d159ef3d35f34a284f738c2c267c75f Mon Sep 17 00:00:00 2001
> > > >> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > > >> Date: Wed, 2 Nov 2022 19:26:27 +0100
> > > >> Subject: [PATCH 1/1] rcu: kvfree_rcu: Reduce a memory footptint by using
> > > >> polling APIs
> > > >>
> > > >> Total time taken by all kfree'ers: 6564718459 ns, loops: 10000, batches: 1110, memory footprint: 5057MB
> > > >> Total time taken by all kfree'ers: 8431051895 ns, loops: 10000, batches: 1109, memory footprint: 2749MB
> > > >> Total time taken by all kfree'ers: 9477830789 ns, loops: 10000, batches: 1158, memory footprint: 2934MB
> > > >> Total time taken by all kfree'ers: 9950211144 ns, loops: 10000, batches: 981, memory footprint: 2704MB
> > > >>
> > > >> with a patch:
> > > >>
> > > >> Total time taken by all kfree'ers: 7712110118 ns, loops: 10000, batches: 1660, memory footprint: 91MB
> > > >> Total time taken by all kfree'ers: 7002403664 ns, loops: 10000, batches: 1482, memory footprint: 86MB
> > > >> Total time taken by all kfree'ers: 7842282319 ns, loops: 10000, batches: 1738, memory footprint: 86MB
> > > >> Total time taken by all kfree'ers: 7230161977 ns, loops: 10000, batches: 1542, memory footprint: 72MB
> > > >>
> > > >> Tested with NOCB option, all offloading CPUs:
> > > >>
> > > >> kvm.sh --memory 10G --torture rcuscale --allcpus --duration 1 \
> > > >>  --kconfig CONFIG_NR_CPUS=64 \
> > > >>  --kconfig CONFIG_RCU_NOCB_CPU=y \
> > > >>  --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y \
> > > >>  --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 \
> > > >>  rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make
> > > >>
> > > >> According to data there is a big gain in memory footprint with a patch.
> > > >> It is because of call_rcu() and call_rcu_flush() take more effort and
> > > >> time to queue a callback and then wait for a gp.
> > > >>
> > > >> With polling API:
> > > >>  a) we do not need to queue any callback;
> > > >>  b) we might not even need wait for a GP completion.
> > > >>
> > > >> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > >> ---
> > > >> kernel/rcu/tree.c | 21 ++++++++++++++++-----
> > > >> 1 file changed, 16 insertions(+), 5 deletions(-)
> > > >>
> > > >> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > >> index 76973d716921..17c3d6f2c55b 100644
> > > >> --- a/kernel/rcu/tree.c
> > > >> +++ b/kernel/rcu/tree.c
> > > >> @@ -2919,18 +2919,20 @@ struct kvfree_rcu_bulk_data {
> > > >>    ((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
> > > >>
> > > >> /**
> > > >> + * @rcu_work: A work to reclaim a memory after a grace period
> > > >>  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
> > > >> - * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
> > > >>  * @head_free: List of kfree_rcu() objects waiting for a grace period
> > > >>  * @bkvhead_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
> > > >>  * @krcp: Pointer to @kfree_rcu_cpu structure
> > > >> + * @gp_snap: A snapshot of current grace period
> > > >>  */
> > > >>
> > > >> struct kfree_rcu_cpu_work {
> > > >> -    struct rcu_work rcu_work;
> > > >> +    struct work_struct rcu_work;
> > > >>    struct rcu_head *head_free;
> > > >>    struct kvfree_rcu_bulk_data *bkvhead_free[FREE_N_CHANNELS];
> > > >>    struct kfree_rcu_cpu *krcp;
> > > >> +    unsigned long gp_snap;
> > > >> };
> > > >>
> > > >> /**
> > > >> @@ -3066,10 +3068,12 @@ static void kfree_rcu_work(struct work_struct *work)
> > > >>    struct kfree_rcu_cpu_work *krwp;
> > > >>    int i, j;
> > > >>
> > > >> -    krwp = container_of(to_rcu_work(work),
> > > >> +    krwp = container_of(work,
> > > >>                struct kfree_rcu_cpu_work, rcu_work);
> > > >>    krcp = krwp->krcp;
> > > >>
> > > >> +    cond_synchronize_rcu(krwp->gp_snap);
> > > >
> > > > Might this provoke OOMs in case of callback flooding?
> > > >
> > > > An alternative might be something like this:
> > > >
> > > >    if (!poll_state_synchronize_rcu(krwp->gp_snap)) {
> > > >        queue_rcu_work(system_wq, &krwp->rcu_work);
> > > >        return;
> > > >    }
> > > >
> > > > Either way gets you a non-lazy callback in the case where a grace
> > > > period has not yet elapsed.
> > > > Or am I missing something that prevents OOMs here?
> > >
> > > The memory consumptions appears to be much less in his testing with the onslaught of kfree, which makes OOM probably less likely.
> > >
> > > Though, was your reasoning that in case of a grace period not elapsing, we need a non lazy callback queued, so as to make the reclaim happen sooner?
> > >
> > > If so, the cond_synchronize_rcu() should already be conditionally queueing non-lazy CB since we don’t make synchronous users wait for seconds. Or did I miss something?
> >
> > My concern is that the synchronize_rcu() will block a kworker kthread
> > for some time, and that in callback-flood situations this might slow
> > things down due to exhausting the supply of kworkers.
> >
> > In contrast, use of queue_rcu_work() frees up the kworker to handle
> > other pages that are filling up.
> >
> > Perhaps your point is that the delay from synchronize_rcu() should make
> > the following pages take the fastpath through cond_synchronize_rcu()?
> >
> > Either way, it might well be that context-switch overhead forces us
> > to batch these things somehow.  But let's worry about that when and if
> > it actually happens.
> 
> Your point sounds reasonable. Though we'd hope cmwq scales worker
> thread count as needed, but we shouldn't probably stress it.

It is especially inadvisable to stress it during OOM events, when the
workqueue system might well get an allocation failure when it tries
creating another kworker kthread.  And we do want this to work well when
at/near OOM, because this is one of the things that can free memory.  ;-)

> Though I am thinking, workqueue context is normally used to invoke
> code that can block, and would the issue you mentioned affect those as
> well, or affect RCU when those non-RCU work items block. So for
> example, when other things in the system that can queue things on the
> system_wq and block.  (I might be throwing darts in the dark).
> 
> To be safe, we can implement your suggestion which is basically a form
> of my initial patch.
> 
> Should we add Tejun to the thread?

Let's get organized first, but that would be a good thing.  Or I could
reach out to Tejun internally.

For but one thing to get organized about, maybe kfree_rcu() should be
using a workqueue with the WQ_MEM_RECLAIM flag set.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> >
> >                                                         Thanx, Paul
> >
> > > Thanks,
> > >
> > > - Joel
> > >
> > > >
> > > >                            Thanx, Paul
> > > >
> > > >> +
> > > >>    raw_spin_lock_irqsave(&krcp->lock, flags);
> > > >>    // Channels 1 and 2.
> > > >>    for (i = 0; i < FREE_N_CHANNELS; i++) {
> > > >> @@ -3194,6 +3198,13 @@ static void kfree_rcu_monitor(struct work_struct *work)
> > > >>        if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
> > > >>            (krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
> > > >>                (krcp->head && !krwp->head_free)) {
> > > >> +            /*
> > > >> +             * Take a snapshot for this krwp. Please note no
> > > >> +             * more any objects can be added to this krwp free
> > > >> +             * channels.
> > > >> +             */
> > > >> +            krwp->gp_snap = get_state_synchronize_rcu();
> > > >> +
> > > >>            // Channel 1 corresponds to the SLAB-pointer bulk path.
> > > >>            // Channel 2 corresponds to vmalloc-pointer bulk path.
> > > >>            for (j = 0; j < FREE_N_CHANNELS; j++) {
> > > >> @@ -3217,7 +3228,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
> > > >>            // be that the work is in the pending state when
> > > >>            // channels have been detached following by each
> > > >>            // other.
> > > >> -            queue_rcu_work(system_wq, &krwp->rcu_work);
> > > >> +            queue_work(system_wq, &krwp->rcu_work);
> > > >>        }
> > > >>    }
> > > >>
> > > >> @@ -4808,7 +4819,7 @@ static void __init kfree_rcu_batch_init(void)
> > > >>        struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > >>
> > > >>        for (i = 0; i < KFREE_N_BATCHES; i++) {
> > > >> -            INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
> > > >> +            INIT_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
> > > >>            krcp->krw_arr[i].krcp = krcp;
> > > >>        }
> > > >>
> > > >> --
> > > >> 2.30.2
> > > >>
> > > >> --
> > > >> Uladzislau Rezki
