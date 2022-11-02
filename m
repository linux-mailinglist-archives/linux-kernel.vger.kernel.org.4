Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9185A616FB1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiKBV1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiKBV04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:26:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284CFE018
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:26:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k2so560256ejr.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 14:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIQoMPi58A0gWm+0yyQM6paqt2awzIoScCt7O3DQWTI=;
        b=RdbJYeMSz2qGEhi2/fOq8+khYzrBAgIWpP3ISt8bG2CoKqq+QnsyVBi5+49D+U9tXY
         wOsPwXm9zLpjtQIT69ORh1RtqgS1WxaoPh4VW+/a1uKyLXg87F7SfsHW0vDYmD5shu47
         7uF+J0fGri1/fg/6MrY7Yr2TcEDty+EAKsjjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIQoMPi58A0gWm+0yyQM6paqt2awzIoScCt7O3DQWTI=;
        b=jM2R497ES/ZUyuc1J0t5+1qerGaZYkbmHmxIOmN0VvxStnXJau3rSDGG0dlY120Pss
         fBwi4l5gP1OhLIotXHe/4TH8v4DPQ7FOKfy9cbPDObeiLy52CdMoqLqGXoWpVJeABZ+R
         hx17xfoyfXDxemX2Uf6285fmxj3rkEWZmXmpR7f8MHQzZDtTb4AjzgWfPd4mLiZ5jwxk
         2jmNvCTC9Z5mERgO5RQXjWa5r2ZnmjubkdbQ8ArxJpXSW/cynp9tHsV/7fDSmM+ZwSJH
         rk3YMcuuionrie9BiZH7PhVA7sm4qaCm0aF/tJqIYhl+hN6SGuoqJEMNkvB//kRDhGwG
         wZ/A==
X-Gm-Message-State: ACrzQf0EokN+FUVlovEyVYIoAqGSo21+xxvsY4It8sOHJ6jQKh2CYJB6
        Rn2uQvkTH5g4yGVl/WCyIOfGZlfPqd/p/8lLZ5RZLQuFyaM=
X-Google-Smtp-Source: AMsMyM6C57tqxXM1gt+boUMWiNKfuzPOWPwXUdnZY/hxauN/6Q77ck/OTQJT/O5bDAzcDpY0L4gs0QwTR7ga6NX0hWc=
X-Received: by 2002:a17:906:6a17:b0:794:f0e8:1918 with SMTP id
 qw23-20020a1709066a1700b00794f0e81918mr26053231ejc.474.1667424411648; Wed, 02
 Nov 2022 14:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221102184911.GP5600@paulmck-ThinkPad-P17-Gen-1>
 <755B5ED1-653D-4E57-B114-77CDE10A9033@joelfernandes.org> <20221102202813.GR5600@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221102202813.GR5600@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 2 Nov 2022 17:26:40 -0400
Message-ID: <CAEXW_YQ+SxBoNUkPHhC3O0DJNQtZomN_4GPtvaWuDs5sSU4FAw@mail.gmail.com>
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
To:     paulmck@kernel.org
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022 at 4:28 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Nov 02, 2022 at 03:46:59PM -0400, Joel Fernandes wrote:
> >
> >
> > > On Nov 2, 2022, at 2:49 PM, Paul E. McKenney <paulmck@kernel.org> wro=
te:
> > >
> > > =EF=BB=BFOn Wed, Nov 02, 2022 at 07:31:40PM +0100, Uladzislau Rezki w=
rote:
> > >>> On Wed, Nov 02, 2022 at 01:29:17PM -0400, Joel Fernandes wrote:
> > >>> On Wed, Nov 2, 2022 at 1:24 PM Uladzislau Rezki <urezki@gmail.com> =
wrote:
> > >>>>
> > >>>> On Wed, Nov 02, 2022 at 09:35:44AM -0700, Paul E. McKenney wrote:
> > >>>>> On Wed, Nov 02, 2022 at 12:13:17PM -0400, Joel Fernandes wrote:
> > >>>>>> On Wed, Nov 2, 2022 at 8:37 AM Uladzislau Rezki <urezki@gmail.co=
m> wrote:
> > >>>>>>>
> > >>>>>>> On Sat, Oct 29, 2022 at 01:28:56PM +0000, Joel Fernandes (Googl=
e) wrote:
> > >>>>>>>> On ChromeOS, I am (almost) always seeing the optimization trig=
ger.
> > >>>>>>>> Tested boot up and trace_printk'ing how often it triggers.
> > >>>>>>>>
> > >>>>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org=
>
> > >>>>>>>> ---
> > >>>>>>>> kernel/rcu/tree.c | 18 +++++++++++++++++-
> > >>>>>>>> 1 file changed, 17 insertions(+), 1 deletion(-)
> > >>>>>>>>
> > >>>>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > >>>>>>>> index 591187b6352e..3e4c50b9fd33 100644
> > >>>>>>>> --- a/kernel/rcu/tree.c
> > >>>>>>>> +++ b/kernel/rcu/tree.c
> > >>>>>>>> @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
> > >>>>>>>>
> > >>>>>>>> /**
> > >>>>>>>>  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RC=
U grace period
> > >>>>>>>> + * @rdp: The rdp of the CPU that this kfree_rcu corresponds t=
o.
> > >>>>>>>>  * @head: List of kfree_rcu() objects not yet waiting for a gr=
ace period
> > >>>>>>>>  * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting=
 for a grace period
> > >>>>>>>>  * @krw_arr: Array of batches of kfree_rcu() objects waiting f=
or a grace period
> > >>>>>>>> @@ -2964,6 +2965,8 @@ struct kfree_rcu_cpu {
> > >>>>>>>>      struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> > >>>>>>>>      raw_spinlock_t lock;
> > >>>>>>>>      struct delayed_work monitor_work;
> > >>>>>>>> +     struct rcu_data *rdp;
> > >>>>>>>> +     unsigned long last_gp_seq;
> > >>>>>>>>      bool initialized;
> > >>>>>>>>      int count;
> > >>>>>>>>
> > >>>>>>>> @@ -3167,6 +3170,7 @@ schedule_delayed_monitor_work(struct kfr=
ee_rcu_cpu *krcp)
> > >>>>>>>>                      mod_delayed_work(system_wq, &krcp->monito=
r_work, delay);
> > >>>>>>>>              return;
> > >>>>>>>>      }
> > >>>>>>>> +     krcp->last_gp_seq =3D krcp->rdp->gp_seq;
> > >>>>>>>>      queue_delayed_work(system_wq, &krcp->monitor_work, delay)=
;
> > >>>>>>>> }
> > >>>>>>>>
> > >>>>>>>> @@ -3217,7 +3221,17 @@ static void kfree_rcu_monitor(struct wo=
rk_struct *work)
> > >>>>>>>>                      // be that the work is in the pending sta=
te when
> > >>>>>>>>                      // channels have been detached following =
by each
> > >>>>>>>>                      // other.
> > >>>>>>>> -                     queue_rcu_work(system_wq, &krwp->rcu_wor=
k);
> > >>>>>>>> +                     //
> > >>>>>>>> +                     // NOTE about gp_seq wrap: In case of gp=
_seq overflow,
> > >>>>>>>> +                     // it is possible for rdp->gp_seq to be =
less than
> > >>>>>>>> +                     // krcp->last_gp_seq even though a GP mi=
ght be over. In
> > >>>>>>>> +                     // this rare case, we would just have on=
e extra GP.
> > >>>>>>>> +                     if (krcp->last_gp_seq &&
> > >>>>>>>>
> > >>>>>>> This check can be eliminated i think. A kfree_rcu_cpu is define=
d as
> > >>>>>>> static so by default the last_gp_set is set to zero.
> > >>>>>>
> > >>>>>> Ack.
> > >>>>>>
> > >>>>>>>> @@ -4802,6 +4816,8 @@ static void __init kfree_rcu_batch_init(=
void)
> > >>>>>>>>      for_each_possible_cpu(cpu) {
> > >>>>>>>>              struct kfree_rcu_cpu *krcp =3D per_cpu_ptr(&krc, =
cpu);
> > >>>>>>>>
> > >>>>>>>> +             krcp->rdp =3D per_cpu_ptr(&rcu_data, cpu);
> > >>>>>>>> +             krcp->last_gp_seq =3D 0;
> > >>>>>>>>
> > >>>>>>> Yep. This one can be just dropped.
> > >>>>>>>
> > >>>>>>> But all the rest looks good :) I will give it a try from test p=
oint of
> > >>>>>>> view. It is interested from the memory footprint point of view.
> > >>>>>>
> > >>>>>> Ack. Thanks. Even though we should not sample rdp->gp_seq, I thi=
nk it
> > >>>>>> is still worth a test.
> > >>>>>
> > >>>>> Just for completeness, the main purpose of rdp->gp_seq is to reje=
ct
> > >>>>> quiescent states that were seen during already-completed grace pe=
riods.
> > >>>>>
> > >>>> So it means that instead of gp_seq reading we should take a snaphs=
hot
> > >>>> of the current state:
> > >>>>
> > >>>> snp =3D get_state_synchronize_rcu();
> > >>>>
> > >>>> and later on do a:
> > >>>>
> > >>>> cond_synchronize_rcu(snp);
> > >>>>
> > >>>> to wait for a GP.
> > >>>
> > >>> This can't be called from the timer IRQ handler though (monitor)
> > >>>
> > >>>> Or if the poll_state_synchronize_rcu(oldstate)) !=3D 0
> > >>>> queue_rcu_work().
> > >>>
> > >>> But something like this should be possible (maybe)
> > >>>
> > >>>> Sorry for a description using the RCU API functions name :)
> > >>>
> > >>> I believe you will have to call rcu_poll_gp_seq_start() as well if =
you
> > >>> are using polled API. I am planning to look at this properly more,
> > >>> soon. Right now I am going to write up the rcutop doc and share wit=
h
> > >>> you guys.
> > >>>
> > >>> (Maybe RCU polling is the right thing to do as we reuse all the inf=
ra
> > >>> and any corner case it is handling)
> > >>>
> > >> OK. This is in my todo list also. Since we have discussed it let's m=
ove
> > >> it forward.
> > >>
> > >> Below what i have came up with to switch for polling APIs:
> > >>
> > >>> From 799ce1653d159ef3d35f34a284f738c2c267c75f Mon Sep 17 00:00:00 2=
001
> > >> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > >> Date: Wed, 2 Nov 2022 19:26:27 +0100
> > >> Subject: [PATCH 1/1] rcu: kvfree_rcu: Reduce a memory footptint by u=
sing
> > >> polling APIs
> > >>
> > >> Total time taken by all kfree'ers: 6564718459 ns, loops: 10000, batc=
hes: 1110, memory footprint: 5057MB
> > >> Total time taken by all kfree'ers: 8431051895 ns, loops: 10000, batc=
hes: 1109, memory footprint: 2749MB
> > >> Total time taken by all kfree'ers: 9477830789 ns, loops: 10000, batc=
hes: 1158, memory footprint: 2934MB
> > >> Total time taken by all kfree'ers: 9950211144 ns, loops: 10000, batc=
hes: 981, memory footprint: 2704MB
> > >>
> > >> with a patch:
> > >>
> > >> Total time taken by all kfree'ers: 7712110118 ns, loops: 10000, batc=
hes: 1660, memory footprint: 91MB
> > >> Total time taken by all kfree'ers: 7002403664 ns, loops: 10000, batc=
hes: 1482, memory footprint: 86MB
> > >> Total time taken by all kfree'ers: 7842282319 ns, loops: 10000, batc=
hes: 1738, memory footprint: 86MB
> > >> Total time taken by all kfree'ers: 7230161977 ns, loops: 10000, batc=
hes: 1542, memory footprint: 72MB
> > >>
> > >> Tested with NOCB option, all offloading CPUs:
> > >>
> > >> kvm.sh --memory 10G --torture rcuscale --allcpus --duration 1 \
> > >>  --kconfig CONFIG_NR_CPUS=3D64 \
> > >>  --kconfig CONFIG_RCU_NOCB_CPU=3Dy \
> > >>  --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=3Dy \
> > >>  --bootargs "rcuscale.kfree_rcu_test=3D1 rcuscale.kfree_nthreads=3D1=
6 \
> > >>  rcuscale.holdoff=3D20 rcuscale.kfree_loops=3D10000 torture.disable_=
onoff_at_boot" --trust-make
> > >>
> > >> According to data there is a big gain in memory footprint with a pat=
ch.
> > >> It is because of call_rcu() and call_rcu_flush() take more effort an=
d
> > >> time to queue a callback and then wait for a gp.
> > >>
> > >> With polling API:
> > >>  a) we do not need to queue any callback;
> > >>  b) we might not even need wait for a GP completion.
> > >>
> > >> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > >> ---
> > >> kernel/rcu/tree.c | 21 ++++++++++++++++-----
> > >> 1 file changed, 16 insertions(+), 5 deletions(-)
> > >>
> > >> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > >> index 76973d716921..17c3d6f2c55b 100644
> > >> --- a/kernel/rcu/tree.c
> > >> +++ b/kernel/rcu/tree.c
> > >> @@ -2919,18 +2919,20 @@ struct kvfree_rcu_bulk_data {
> > >>    ((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void =
*))
> > >>
> > >> /**
> > >> + * @rcu_work: A work to reclaim a memory after a grace period
> > >>  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
> > >> - * @rcu_work: Let queue_rcu_work() invoke workqueue handler after g=
race period
> > >>  * @head_free: List of kfree_rcu() objects waiting for a grace perio=
d
> > >>  * @bkvhead_free: Bulk-List of kvfree_rcu() objects waiting for a gr=
ace period
> > >>  * @krcp: Pointer to @kfree_rcu_cpu structure
> > >> + * @gp_snap: A snapshot of current grace period
> > >>  */
> > >>
> > >> struct kfree_rcu_cpu_work {
> > >> -    struct rcu_work rcu_work;
> > >> +    struct work_struct rcu_work;
> > >>    struct rcu_head *head_free;
> > >>    struct kvfree_rcu_bulk_data *bkvhead_free[FREE_N_CHANNELS];
> > >>    struct kfree_rcu_cpu *krcp;
> > >> +    unsigned long gp_snap;
> > >> };
> > >>
> > >> /**
> > >> @@ -3066,10 +3068,12 @@ static void kfree_rcu_work(struct work_struc=
t *work)
> > >>    struct kfree_rcu_cpu_work *krwp;
> > >>    int i, j;
> > >>
> > >> -    krwp =3D container_of(to_rcu_work(work),
> > >> +    krwp =3D container_of(work,
> > >>                struct kfree_rcu_cpu_work, rcu_work);
> > >>    krcp =3D krwp->krcp;
> > >>
> > >> +    cond_synchronize_rcu(krwp->gp_snap);
> > >
> > > Might this provoke OOMs in case of callback flooding?
> > >
> > > An alternative might be something like this:
> > >
> > >    if (!poll_state_synchronize_rcu(krwp->gp_snap)) {
> > >        queue_rcu_work(system_wq, &krwp->rcu_work);
> > >        return;
> > >    }
> > >
> > > Either way gets you a non-lazy callback in the case where a grace
> > > period has not yet elapsed.
> > > Or am I missing something that prevents OOMs here?
> >
> > The memory consumptions appears to be much less in his testing with the=
 onslaught of kfree, which makes OOM probably less likely.
> >
> > Though, was your reasoning that in case of a grace period not elapsing,=
 we need a non lazy callback queued, so as to make the reclaim happen soone=
r?
> >
> > If so, the cond_synchronize_rcu() should already be conditionally queue=
ing non-lazy CB since we don=E2=80=99t make synchronous users wait for seco=
nds. Or did I miss something?
>
> My concern is that the synchronize_rcu() will block a kworker kthread
> for some time, and that in callback-flood situations this might slow
> things down due to exhausting the supply of kworkers.
>
> In contrast, use of queue_rcu_work() frees up the kworker to handle
> other pages that are filling up.
>
> Perhaps your point is that the delay from synchronize_rcu() should make
> the following pages take the fastpath through cond_synchronize_rcu()?
>
> Either way, it might well be that context-switch overhead forces us
> to batch these things somehow.  But let's worry about that when and if
> it actually happens.

Your point sounds reasonable. Though we'd hope cmwq scales worker
thread count as needed, but we shouldn't probably stress it.

Though I am thinking, workqueue context is normally used to invoke
code that can block, and would the issue you mentioned affect those as
well, or affect RCU when those non-RCU work items block. So for
example, when other things in the system that can queue things on the
system_wq and block.  (I might be throwing darts in the dark).

To be safe, we can implement your suggestion which is basically a form
of my initial patch.

Should we add Tejun to the thread?

thanks,

 - Joel

>
>                                                         Thanx, Paul
>
> > Thanks,
> >
> > - Joel
> >
> > >
> > >                            Thanx, Paul
> > >
> > >> +
> > >>    raw_spin_lock_irqsave(&krcp->lock, flags);
> > >>    // Channels 1 and 2.
> > >>    for (i =3D 0; i < FREE_N_CHANNELS; i++) {
> > >> @@ -3194,6 +3198,13 @@ static void kfree_rcu_monitor(struct work_str=
uct *work)
> > >>        if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
> > >>            (krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
> > >>                (krcp->head && !krwp->head_free)) {
> > >> +            /*
> > >> +             * Take a snapshot for this krwp. Please note no
> > >> +             * more any objects can be added to this krwp free
> > >> +             * channels.
> > >> +             */
> > >> +            krwp->gp_snap =3D get_state_synchronize_rcu();
> > >> +
> > >>            // Channel 1 corresponds to the SLAB-pointer bulk path.
> > >>            // Channel 2 corresponds to vmalloc-pointer bulk path.
> > >>            for (j =3D 0; j < FREE_N_CHANNELS; j++) {
> > >> @@ -3217,7 +3228,7 @@ static void kfree_rcu_monitor(struct work_stru=
ct *work)
> > >>            // be that the work is in the pending state when
> > >>            // channels have been detached following by each
> > >>            // other.
> > >> -            queue_rcu_work(system_wq, &krwp->rcu_work);
> > >> +            queue_work(system_wq, &krwp->rcu_work);
> > >>        }
> > >>    }
> > >>
> > >> @@ -4808,7 +4819,7 @@ static void __init kfree_rcu_batch_init(void)
> > >>        struct kfree_rcu_cpu *krcp =3D per_cpu_ptr(&krc, cpu);
> > >>
> > >>        for (i =3D 0; i < KFREE_N_BATCHES; i++) {
> > >> -            INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_wor=
k);
> > >> +            INIT_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
> > >>            krcp->krw_arr[i].krcp =3D krcp;
> > >>        }
> > >>
> > >> --
> > >> 2.30.2
> > >>
> > >> --
> > >> Uladzislau Rezki
