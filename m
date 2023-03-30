Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C3A6D0E37
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjC3S54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjC3S5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:57:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98E9B46F;
        Thu, 30 Mar 2023 11:57:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 167F562178;
        Thu, 30 Mar 2023 18:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCB8C433D2;
        Thu, 30 Mar 2023 18:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680202667;
        bh=2hQRHYcJhy8FHBAWPs/zn0n5a4GnWVDNYQsiYnpprxw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Yx5Te/I1o9Eqd6XsXWQLv3pSzesnmGtu0LvaKzhI97wCkT1CA7N2qyUHLX5aBpPMF
         bl3XI5GtObESJQFhDsHs8s+A/xRr3XpcMbRDTvD94DjuxSXVcqoWum72rL0rI6jg5r
         wKepPbOqG6HAhrlCInEli0NG3PKzi+lWNoMeJi/pVLtEGT7klhXZO4Mqf4DKN2RB88
         PtLKmUSdtCJU0FEXnRQGuTleqQX/zjSuxx6/fbUy3OFZelncZKNcJPvdLm8Kl5zQLX
         MHSPt6jHOuSjdAw0Y/FSVSjW4XRCyrLAWEXgF7g/KOnTwA+w1Q3nh7CFhRcazuAzzP
         CuH4uXEimRiSg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1BA241540476; Thu, 30 Mar 2023 11:57:47 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:57:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, RCU <rcu@vger.kernel.org>,
        quic_neeraju@quicinc.com, Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Message-ID: <004d562e-8c68-473a-aa72-0976f67979ee@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ca153af5-bd66-4d48-afa5-ace3a13aec3c@paulmck-laptop>
 <FC49F388-0480-4687-8DD3-94049FCBC92B@joelfernandes.org>
 <2cd8f407-2b77-48b1-9f17-9aa8e4ce9c64@paulmck-laptop>
 <20230330150933.GB2114899@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230330150933.GB2114899@google.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 03:09:33PM +0000, Joel Fernandes wrote:
> On Tue, Mar 28, 2023 at 08:26:13AM -0700, Paul E. McKenney wrote:
> > On Mon, Mar 27, 2023 at 10:29:31PM -0400, Joel Fernandes wrote:
> > > Hello,
> > > 
> > > > On Mar 27, 2023, at 9:06 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > 
> > > > ﻿On Mon, Mar 27, 2023 at 11:21:23AM +0000, Zhang, Qiang1 wrote:
> > > >>>> From: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > >>>> Sent: Tuesday, March 21, 2023 6:28 PM
> > > >>>> [...]
> > > >>>> Subject: [PATCH 1/1] Reduce synchronize_rcu() waiting time
> > > >>>> 
> > > >>>> A call to a synchronize_rcu() can be expensive from time point of view.
> > > >>>> Different workloads can be affected by this especially the ones which use this
> > > >>>> API in its time critical sections.
> > > >>>> 
> > > >>> 
> > > >>> This is interesting and meaningful research. ;-)
> > > >>> 
> > > >>>> For example in case of NOCB scenario the wakeme_after_rcu() callback
> > > >>>> invocation depends on where in a nocb-list it is located. Below is an example
> > > >>>> when it was the last out of ~3600 callbacks:
> > > >>> 
> > > >> 
> > > >> 
> > > >> 
> > > >> Can it be implemented separately as follows?  it seems that the code is simpler
> > > >> (only personal opinion)  😊.
> > > >> 
> > > >> But I didn't test whether this reduce synchronize_rcu() waiting time
> > > >> 
> > > >> +static void rcu_poll_wait_gp(struct rcu_tasks *rtp)
> > > >> +{
> > > >> +       unsigned long gp_snap;
> > > >> +
> > > >> +       gp_snap = start_poll_synchronize_rcu();
> > > >> +       while (!poll_state_synchronize_rcu(gp_snap))
> > > >> +               schedule_timeout_idle(1);
> > > > 
> > > > I could be wrong, but my guess is that the guys working with
> > > > battery-powered devices are not going to be very happy with this loop.
> > > > 
> > > > All those wakeups by all tasks waiting for a grace period end up
> > > > consuming a surprisingly large amount of energy.
> > > 
> > > Is that really the common case? On the general topic of wake-ups:
> > > Most of the time there should be only one
> > > task waiting synchronously on a GP to end. If that is
> > > true, then it feels like waking
> > > up nocb Kthreads which indirectly wake other threads is doing more work than usual?
> > 
> > A good question, and the number of outstanding synchronize_rcu()
> > calls will of course be limited by the number of tasks in the system.
> > But I myself have raised the ire of battery-powered embedded folks with
> > a rather small number of wakeups, so...
> 
> But unless I am missing something, even if there is single synchronize_rcu(),
> you have a flurry of potential wakeups right now, instead of the bare minimum
> I think. I have not measured how many wake ups, but I'd love to when I get
> time. Maybe Vlad has some numbers.

It is complicated.  ;-)

Perhaps you are thinking in terms of an isolated synchronize_rcu()
call in an otherwise idle system with all RCU callbacks offloaded,
but booted with rcutree.use_softirq=1.

In that case, there would be three wakeups, one for the rcuog
kthread, one for the rcuoc kthread, and one for the task that invoked
synchronize_rcu().

As above, but with rcutree.use_softirq=0, there would be some additional
wakeups of the rcuc kthreads.  For rcutree.use_softirq=1, there might
also be ksoftirqd wakeups, but probably not on almost-idle systems.

As the system gets busier, the rcuog (and rcuc, if any) kthead wakeups
get amortized over increasing numbers of synchronize_rcu() calls, as to
a lesser extent do the rcuoc kthread wakeups.

On the other hand, a nearly idle system without RCU callback offloading
that is booted with rcutree.use_softirq=1 will just have the one wakeup
in the common case.  Everything else will happen in softirq context,
and ksoftirqd won't get involved in systems that are nearly idle.
Which is yet another reason softirq is so hard to kill.  ;-)

Going back to the offloaded-callbacks case, as I understand it, wakeups
that cause IPIs to be sent to non-idle CPUs are not all that bad for
battery lifetime, so that would figure in as well.  Of course, in the
worst case, the rcuog, rcuoc, and synchronize_rcu() tasks might all be
on different CPUs.  Though perhaps an energy-aware scheduler might have
something to say about that situation, at least in the absence of manual
pinning of tasks to CPUs.

So this will depend on many things, and actual measurements will be
needed.  Also, the default needs to be to opt out of this, at least
initially.  Focusing the debugging risk on the people who actively want
this feature helps keep the larger user community more calm.  ;-)

> > And on larger systems there can be a tradeoff between contention on
> > the one hand and number of wakeups on the other.
> > 
> > The original nocb implementation in fact had the grace-period kthead
> > waking up all of what are now called rcuoc kthreads.  The indirect scheme
> > reduced the total number of wakeups by up to 50% and also reduced the
> > CPU consumption of the grace-period kthread, which otherwise would have
> > become a bottleneck on large systems.
> 
> Thanks for the background.
> 
> > And also, a scheme that directly wakes tasks waiting in synchronize_rcu()
> > might well use the same ->nocb_gp_wq[] waitqueues that are used by the
> > rcuog kthreads, if that is what you were getting at.
> 
> Yes that's what I was getting at. I thought Vlad was going for doing direct
> wake ups from the main RCU GP thread that orchestates RCU grace period
> cycles.

Maybe he was wanting to have something that worked independently of
rcu_nocbs CPUs?  Though if so, one way to make that work would be
to make those waitqueues available on all CPUs.

> > > I am curious to measure how much does Vlad patch reduce wakeups in the common case.
> > 
> > Sounds like a good thing to measure!
> 
> Ok. At the moment I am preparing 2 talks I am giving at OSPM for real-time and
> timers. Plus preparing the PR, so I'm fully booked. :(  [and the LWN article..].

Maybe someone like Vlad will do the measuring, and if not, it will still
be around after OSPM and the upcoming merge window.  Your guys' schedule
is my schedule on this one.

> > > I was also wondering how Vlad patch effects RCU-barrier ordering. I guess
> > > we want the wake up to happen in the order of
> > > other callbacks also waiting.
> > 
> > OK, I will bite.  Why would rcu_barrier() need to care about the
> > synchronize_rcu() invocations if they no longer used call_rcu()?
> 
> Hm, I was just going for the fact that it is a behavioral change. Not
> illuding that it would certainly cause an issue. As we know, Linux kernel
> developers have interesting ways of using RCU APIs. :-)
> 
> But yes, it may not be an issue considering expedited synchronize_rcu() also
> has such behavior anyway, if I'm not mistaken.

All fair points, and this is part of why this needs to be opt-in.

But my rationale is that wakeup delays mean that there is no way for
the caller to determine whether or not rcu_barrier() did or did not wait
for in-flight synchronize_rcu() calls.

Which might well be a failure of imagination on my part.

> > > One last note, most battery powered systems are perhaps already using expedited RCU ;-)
> > 
> > Good point.  And that does raise the question of exactly what workloads
> > and systems want faster wakeups from synchronize_rcu() and cannot get
> > this effect from expedited grace periods.
> 
> Maybe the kind of workloads that don't need GP completion very quickly, but
> just want to reduce wakeups. The wakeups do have a cost, the scheduler can
> wake up several idle CPUs to "spread the awakened load" and cause wastage
> power. And also contend on locks during the wake up.

In that case, the commit log needs to clearly call this out, and at
least some of the measurements need to focus on this case.

I might have misread it, but v1 of Uladzislau's patch seemed to focus
on latency rather than on wakeup minimization.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > >  - Joel 
> > > 
> > > > 
> > > >                            Thanx, Paul
> > > > 
> > > >> +}
> > > >> +
> > > >> +void call_rcu_poll(struct rcu_head *rhp, rcu_callback_t func);
> > > >> +DEFINE_RCU_TASKS(rcu_poll, rcu_poll_wait_gp, call_rcu_poll,
> > > >> +                 "RCU Poll");
> > > >> +void call_rcu_poll(struct rcu_head *rhp, rcu_callback_t func)
> > > >> +{
> > > >> +       call_rcu_tasks_generic(rhp, func, &rcu_poll);
> > > >> +}
> > > >> +EXPORT_SYMBOL_GPL(call_rcu_poll);
> > > >> +
> > > >> +void synchronize_rcu_poll(void)
> > > >> +{
> > > >> +       synchronize_rcu_tasks_generic(&rcu_poll);
> > > >> +}
> > > >> +EXPORT_SYMBOL_GPL(synchronize_rcu_poll);
> > > >> +
> > > >> +static int __init rcu_spawn_poll_kthread(void)
> > > >> +{
> > > >> +       cblist_init_generic(&rcu_poll);
> > > >> +       rcu_poll.gp_sleep = HZ / 10;
> > > >> +       rcu_spawn_tasks_kthread_generic(&rcu_poll);
> > > >> +       return 0;
> > > >> +}
> > > >> 
> > > >> Thanks
> > > >> Zqiang
> > > >> 
> > > >> 
> > > >>>> 
> > > >>>> <snip>
> > > >>>>  <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt
> > > >>>> CBs=3613 bl=28
> > > >>>> ...
> > > >>>>  <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preempt
> > > >>>> rhp=00000000b2d6dee8 func=__free_vm_area_struct.cfi_jt
> > > >>>>  <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preempt
> > > >>>> rhp=00000000a446f607 func=__free_vm_area_struct.cfi_jt
> > > >>>>  <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preempt
> > > >>>> rhp=00000000a5cab03b func=__free_vm_area_struct.cfi_jt
> > > >>>>  <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preempt
> > > >>>> rhp=0000000013b7e5ee func=__free_vm_area_struct.cfi_jt
> > > >>>>  <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preempt
> > > >>>> rhp=000000000a8ca6f9 func=__free_vm_area_struct.cfi_jt
> > > >>>>  <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preempt
> > > >>>> rhp=000000008f162ca8 func=wakeme_after_rcu.cfi_jt
> > > >>>>  <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-
> > > >>>> invoked=3612 idle=....
> > > >>>> <snip>
> > > >>>> 
> > > >>> 
> > > >>> Did the results above tell us that CBs-invoked=3612 during the time 21950.145313 ~ 21950.152625?
> > > >>> 
> > > >>> Yes.
> > > >>> 
> > > >>> 
> > > >>> If possible, may I know the steps, commands, and related parameters to produce the results above?
> > > >>> Thank you!
> > > >>> 
> > > >>> Build the kernel with CONFIG_RCU_TRACE configuration. Update your "set_event"
> > > >>> file with appropriate traces:
> > > >>> 
> > > >>> <snip>
> > > >>> XQ-DQ54:/sys/kernel/tracing # echo rcu:rcu_batch_start rcu:rcu_batch_end rcu:rcu_invoke_callback > set_event
> > > >>> 
> > > >>> XQ-DQ54:/sys/kernel/tracing # cat set_event
> > > >>> rcu:rcu_batch_start
> > > >>> rcu:rcu_invoke_callback
> > > >>> rcu:rcu_batch_end
> > > >>> XQ-DQ54:/sys/kernel/tracing #
> > > >>> <snip>
> > > >>> 
> > > >>> Collect traces as much as you want: XQ-DQ54:/sys/kernel/tracing # echo 1 > tracing_on; sleep 10; echo 0 > tracing_on
> > > >>> Next problem is how to parse it. Of course you will not be able to parse
> > > >>> megabytes of traces. For that purpose i use a special C trace parser.
> > > >>> If you need an example please let me know i can show here.
> > > >>> 
> > > >>> --
> > > >>> Uladzislau Rezki
