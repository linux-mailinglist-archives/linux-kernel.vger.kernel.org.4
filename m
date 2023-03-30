Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D956D0E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjC3TBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjC3TBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:01:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E404BEE;
        Thu, 30 Mar 2023 12:01:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 19A21CE2B87;
        Thu, 30 Mar 2023 19:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3163DC433EF;
        Thu, 30 Mar 2023 19:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680202892;
        bh=h9wFIXsGa8qCPRudrt2NkuXbT8kMfGfrCv1Y5inotQk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Lo1q69uANy/Bfoaw91pM8zic9hcomhvJxdbRNOyZL7oEzTxKrD1/apGWpcdCx3xEV
         swiMJXNNJF68759OH2D5lQV+PulWYIRzyKqeAPImwmyYeBTFBKyD3ZVdrGAZGlTGfE
         uDe2h8ojVT4F5bP1DVkOhquWVCVeG1WNwTEX3Mp2hdo7Hs3jGyLRrE1EiTeWj8NEYd
         d2IOuJl6aDW9sVnj+/97tzkOlLBOhyaTL25Q68V7sKFjgP2nGRUONKjSMsk8OFluVm
         X9T7D1PoKRBycSVjWmvLEwkUu9W3o60LrD0n/+Vmep08Ql3YaXCKEHYekg7HHyiYVS
         LILghXNoRiwvQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B808D1540476; Thu, 30 Mar 2023 12:01:31 -0700 (PDT)
Date:   Thu, 30 Mar 2023 12:01:31 -0700
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
Message-ID: <ea552470-f3ea-4cb6-ad89-fcbbb245b8fa@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ca153af5-bd66-4d48-afa5-ace3a13aec3c@paulmck-laptop>
 <FC49F388-0480-4687-8DD3-94049FCBC92B@joelfernandes.org>
 <2cd8f407-2b77-48b1-9f17-9aa8e4ce9c64@paulmck-laptop>
 <b4977530-d989-47df-ab7a-d326cdd8dd14@paulmck-laptop>
 <20230330151115.GC2114899@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230330151115.GC2114899@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 03:11:15PM +0000, Joel Fernandes wrote:
> On Tue, Mar 28, 2023 at 03:14:32PM -0700, Paul E. McKenney wrote:
> > On Tue, Mar 28, 2023 at 08:26:13AM -0700, Paul E. McKenney wrote:
> > > On Mon, Mar 27, 2023 at 10:29:31PM -0400, Joel Fernandes wrote:
> > > > Hello,
> > > > 
> > > > > On Mar 27, 2023, at 9:06 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > 
> > > > > ﻿On Mon, Mar 27, 2023 at 11:21:23AM +0000, Zhang, Qiang1 wrote:
> > > > >>>> From: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > >>>> Sent: Tuesday, March 21, 2023 6:28 PM
> > > > >>>> [...]
> > > > >>>> Subject: [PATCH 1/1] Reduce synchronize_rcu() waiting time
> > > > >>>> 
> > > > >>>> A call to a synchronize_rcu() can be expensive from time point of view.
> > > > >>>> Different workloads can be affected by this especially the ones which use this
> > > > >>>> API in its time critical sections.
> > > > >>>> 
> > > > >>> 
> > > > >>> This is interesting and meaningful research. ;-)
> > > > >>> 
> > > > >>>> For example in case of NOCB scenario the wakeme_after_rcu() callback
> > > > >>>> invocation depends on where in a nocb-list it is located. Below is an example
> > > > >>>> when it was the last out of ~3600 callbacks:
> > > > >>> 
> > > > >> 
> > > > >> 
> > > > >> 
> > > > >> Can it be implemented separately as follows?  it seems that the code is simpler
> > > > >> (only personal opinion)  😊.
> > > > >> 
> > > > >> But I didn't test whether this reduce synchronize_rcu() waiting time
> > > > >> 
> > > > >> +static void rcu_poll_wait_gp(struct rcu_tasks *rtp)
> > > > >> +{
> > > > >> +       unsigned long gp_snap;
> > > > >> +
> > > > >> +       gp_snap = start_poll_synchronize_rcu();
> > > > >> +       while (!poll_state_synchronize_rcu(gp_snap))
> > > > >> +               schedule_timeout_idle(1);
> > > > > 
> > > > > I could be wrong, but my guess is that the guys working with
> > > > > battery-powered devices are not going to be very happy with this loop.
> > > > > 
> > > > > All those wakeups by all tasks waiting for a grace period end up
> > > > > consuming a surprisingly large amount of energy.
> > > > 
> > > > Is that really the common case? On the general topic of wake-ups:
> > > > Most of the time there should be only one
> > > > task waiting synchronously on a GP to end. If that is
> > > > true, then it feels like waking
> > > > up nocb Kthreads which indirectly wake other threads is doing more work than usual?
> > > 
> > > A good question, and the number of outstanding synchronize_rcu()
> > > calls will of course be limited by the number of tasks in the system.
> > > But I myself have raised the ire of battery-powered embedded folks with
> > > a rather small number of wakeups, so...
> > > 
> > > And on larger systems there can be a tradeoff between contention on
> > > the one hand and number of wakeups on the other.
> > > 
> > > The original nocb implementation in fact had the grace-period kthead
> > > waking up all of what are now called rcuoc kthreads.  The indirect scheme
> > > reduced the total number of wakeups by up to 50% and also reduced the
> > > CPU consumption of the grace-period kthread, which otherwise would have
> > > become a bottleneck on large systems.
> > > 
> > > And also, a scheme that directly wakes tasks waiting in synchronize_rcu()
> > > might well use the same ->nocb_gp_wq[] waitqueues that are used by the
> > > rcuog kthreads, if that is what you were getting at.
> > 
> > And on small systems, you might of course have the rcuog kthread directly
> > invoke callbacks if there are not very many of them.  This would of
> > course need to be done quite carefully to avoid any number of races
> > with the rcuoc kthreads.  You could do the same thing on a large system,
> > but on a per-rcuog basis.
> > 
> > I vaguely recall discussing this in one of our sessions, but who knows?
> > 
> > Would this really be of benefit?  Or did you have something else in mind?
> 
> Yes, this is what I was also referring to.
> 
> Not sure about benefit, depends on workloads and measurement.

There are of course potential downsides, including slower handling of
callback floods and tuning difficulties due to there being no good way
thus far to estimate how much time a given RCU callback will consume.

But if there are significant benefits to battery-powered systems, then
enabling this sort of thing only on those systems could make a lot
of sense.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > > > I am curious to measure how much does Vlad patch reduce wakeups in the common case.
> > > 
> > > Sounds like a good thing to measure!
> > > 
> > > > I was also wondering how Vlad patch effects RCU-barrier ordering. I guess
> > > > we want the wake up to happen in the order of
> > > > other callbacks also waiting.
> > > 
> > > OK, I will bite.  Why would rcu_barrier() need to care about the
> > > synchronize_rcu() invocations if they no longer used call_rcu()?
> > > 
> > > > One last note, most battery powered systems are perhaps already using expedited RCU ;-)
> > > 
> > > Good point.  And that does raise the question of exactly what workloads
> > > and systems want faster wakeups from synchronize_rcu() and cannot get
> > > this effect from expedited grace periods.
> > > 
> > > 							Thanx, Paul
> > > 
> > > > Thoughts?
> > > > 
> > > >  - Joel 
> > > > 
> > > > > 
> > > > >                            Thanx, Paul
> > > > > 
> > > > >> +}
> > > > >> +
> > > > >> +void call_rcu_poll(struct rcu_head *rhp, rcu_callback_t func);
> > > > >> +DEFINE_RCU_TASKS(rcu_poll, rcu_poll_wait_gp, call_rcu_poll,
> > > > >> +                 "RCU Poll");
> > > > >> +void call_rcu_poll(struct rcu_head *rhp, rcu_callback_t func)
> > > > >> +{
> > > > >> +       call_rcu_tasks_generic(rhp, func, &rcu_poll);
> > > > >> +}
> > > > >> +EXPORT_SYMBOL_GPL(call_rcu_poll);
> > > > >> +
> > > > >> +void synchronize_rcu_poll(void)
> > > > >> +{
> > > > >> +       synchronize_rcu_tasks_generic(&rcu_poll);
> > > > >> +}
> > > > >> +EXPORT_SYMBOL_GPL(synchronize_rcu_poll);
> > > > >> +
> > > > >> +static int __init rcu_spawn_poll_kthread(void)
> > > > >> +{
> > > > >> +       cblist_init_generic(&rcu_poll);
> > > > >> +       rcu_poll.gp_sleep = HZ / 10;
> > > > >> +       rcu_spawn_tasks_kthread_generic(&rcu_poll);
> > > > >> +       return 0;
> > > > >> +}
> > > > >> 
> > > > >> Thanks
> > > > >> Zqiang
> > > > >> 
> > > > >> 
> > > > >>>> 
> > > > >>>> <snip>
> > > > >>>>  <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt
> > > > >>>> CBs=3613 bl=28
> > > > >>>> ...
> > > > >>>>  <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preempt
> > > > >>>> rhp=00000000b2d6dee8 func=__free_vm_area_struct.cfi_jt
> > > > >>>>  <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preempt
> > > > >>>> rhp=00000000a446f607 func=__free_vm_area_struct.cfi_jt
> > > > >>>>  <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preempt
> > > > >>>> rhp=00000000a5cab03b func=__free_vm_area_struct.cfi_jt
> > > > >>>>  <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preempt
> > > > >>>> rhp=0000000013b7e5ee func=__free_vm_area_struct.cfi_jt
> > > > >>>>  <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preempt
> > > > >>>> rhp=000000000a8ca6f9 func=__free_vm_area_struct.cfi_jt
> > > > >>>>  <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preempt
> > > > >>>> rhp=000000008f162ca8 func=wakeme_after_rcu.cfi_jt
> > > > >>>>  <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-
> > > > >>>> invoked=3612 idle=....
> > > > >>>> <snip>
> > > > >>>> 
> > > > >>> 
> > > > >>> Did the results above tell us that CBs-invoked=3612 during the time 21950.145313 ~ 21950.152625?
> > > > >>> 
> > > > >>> Yes.
> > > > >>> 
> > > > >>> 
> > > > >>> If possible, may I know the steps, commands, and related parameters to produce the results above?
> > > > >>> Thank you!
> > > > >>> 
> > > > >>> Build the kernel with CONFIG_RCU_TRACE configuration. Update your "set_event"
> > > > >>> file with appropriate traces:
> > > > >>> 
> > > > >>> <snip>
> > > > >>> XQ-DQ54:/sys/kernel/tracing # echo rcu:rcu_batch_start rcu:rcu_batch_end rcu:rcu_invoke_callback > set_event
> > > > >>> 
> > > > >>> XQ-DQ54:/sys/kernel/tracing # cat set_event
> > > > >>> rcu:rcu_batch_start
> > > > >>> rcu:rcu_invoke_callback
> > > > >>> rcu:rcu_batch_end
> > > > >>> XQ-DQ54:/sys/kernel/tracing #
> > > > >>> <snip>
> > > > >>> 
> > > > >>> Collect traces as much as you want: XQ-DQ54:/sys/kernel/tracing # echo 1 > tracing_on; sleep 10; echo 0 > tracing_on
> > > > >>> Next problem is how to parse it. Of course you will not be able to parse
> > > > >>> megabytes of traces. For that purpose i use a special C trace parser.
> > > > >>> If you need an example please let me know i can show here.
> > > > >>> 
> > > > >>> --
> > > > >>> Uladzislau Rezki
