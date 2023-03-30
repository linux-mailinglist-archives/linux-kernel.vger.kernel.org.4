Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D266D0928
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjC3PLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjC3PK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:10:58 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20583C3D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:09:36 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id t19so18720132qta.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1680188974;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d9SSEYK9+rLxf8rsg8ZhJkHKzQe51MzIdNwTny7GCDE=;
        b=m6UVd1hdrKFSzgvADYkcehDr1RbP+WDP6ki0+MRYiZePeMzYfH5bnL8iaZpk1yobQ9
         Ij9sX5WPve0A+sxBY7mx8QBV6b9MwsVb7Ppm9uYSBSUpSAmJQ5/9d+Eftrlv2kmvdugk
         hYP6HwviiUDgkgvncrcG1qSBEZVp5Gp72jLwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680188974;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9SSEYK9+rLxf8rsg8ZhJkHKzQe51MzIdNwTny7GCDE=;
        b=yD6DX3sjMI6ZfI9tA8zyeYMAhSwkncNPSZmoqs0M4lJ6nUoAxiAHLnH6Zg5c/WSuPX
         C1lOoydjTEhR6HXHM/ruvAoh70EsQIYhtpkqTPkN0dz1eLbeqUfxIeeT3gCkgUxHuXwc
         qvF9axxJL+s79fvgeJ6vepccaX4cgSdKBd2IFgOyxyaWUXZuqZvVmu+nnby2RHtdNn+a
         73sejBOk/Ie5vPjWh64/xBMD7ykDgH2ypktirxJBnIr6i5gVufFZXFJg2AjKwaa3xYzX
         Ln2Cs6glaMndEkFPD4nzfN3Umu/X0mS0xvZxzE1kYvUrhG90Itle/VHjJI38cqrsX4TP
         idaA==
X-Gm-Message-State: AAQBX9ff5RyQr0hhNKn5K42IluYug4jbeprqAcn4m1HrPYuFLRh98ATI
        Upa3L4OPBtBtvAozoazrXnwj6A==
X-Google-Smtp-Source: AKy350bLyYVwa9hLM4jIL0bMyImUrBVP5LGI21RzzgdZezsUwraYXUHEaBqU1OwBv14FXe6M6ncxSg==
X-Received: by 2002:a05:622a:190f:b0:3bf:b5fe:372d with SMTP id w15-20020a05622a190f00b003bfb5fe372dmr37528110qtc.61.1680188974011;
        Thu, 30 Mar 2023 08:09:34 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id d3-20020ac847c3000000b003e4f1b3ce43sm2124925qtr.50.2023.03.30.08.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:09:33 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:09:33 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, RCU <rcu@vger.kernel.org>,
        quic_neeraju@quicinc.com, Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Message-ID: <20230330150933.GB2114899@google.com>
References: <ca153af5-bd66-4d48-afa5-ace3a13aec3c@paulmck-laptop>
 <FC49F388-0480-4687-8DD3-94049FCBC92B@joelfernandes.org>
 <2cd8f407-2b77-48b1-9f17-9aa8e4ce9c64@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cd8f407-2b77-48b1-9f17-9aa8e4ce9c64@paulmck-laptop>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 08:26:13AM -0700, Paul E. McKenney wrote:
> On Mon, Mar 27, 2023 at 10:29:31PM -0400, Joel Fernandes wrote:
> > Hello,
> > 
> > > On Mar 27, 2023, at 9:06 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > 
> > > ﻿On Mon, Mar 27, 2023 at 11:21:23AM +0000, Zhang, Qiang1 wrote:
> > >>>> From: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > >>>> Sent: Tuesday, March 21, 2023 6:28 PM
> > >>>> [...]
> > >>>> Subject: [PATCH 1/1] Reduce synchronize_rcu() waiting time
> > >>>> 
> > >>>> A call to a synchronize_rcu() can be expensive from time point of view.
> > >>>> Different workloads can be affected by this especially the ones which use this
> > >>>> API in its time critical sections.
> > >>>> 
> > >>> 
> > >>> This is interesting and meaningful research. ;-)
> > >>> 
> > >>>> For example in case of NOCB scenario the wakeme_after_rcu() callback
> > >>>> invocation depends on where in a nocb-list it is located. Below is an example
> > >>>> when it was the last out of ~3600 callbacks:
> > >>> 
> > >> 
> > >> 
> > >> 
> > >> Can it be implemented separately as follows?  it seems that the code is simpler
> > >> (only personal opinion)  😊.
> > >> 
> > >> But I didn't test whether this reduce synchronize_rcu() waiting time
> > >> 
> > >> +static void rcu_poll_wait_gp(struct rcu_tasks *rtp)
> > >> +{
> > >> +       unsigned long gp_snap;
> > >> +
> > >> +       gp_snap = start_poll_synchronize_rcu();
> > >> +       while (!poll_state_synchronize_rcu(gp_snap))
> > >> +               schedule_timeout_idle(1);
> > > 
> > > I could be wrong, but my guess is that the guys working with
> > > battery-powered devices are not going to be very happy with this loop.
> > > 
> > > All those wakeups by all tasks waiting for a grace period end up
> > > consuming a surprisingly large amount of energy.
> > 
> > Is that really the common case? On the general topic of wake-ups:
> > Most of the time there should be only one
> > task waiting synchronously on a GP to end. If that is
> > true, then it feels like waking
> > up nocb Kthreads which indirectly wake other threads is doing more work than usual?
> 
> A good question, and the number of outstanding synchronize_rcu()
> calls will of course be limited by the number of tasks in the system.
> But I myself have raised the ire of battery-powered embedded folks with
> a rather small number of wakeups, so...

But unless I am missing something, even if there is single synchronize_rcu(),
you have a flurry of potential wakeups right now, instead of the bare minimum
I think. I have not measured how many wake ups, but I'd love to when I get
time. Maybe Vlad has some numbers.

> And on larger systems there can be a tradeoff between contention on
> the one hand and number of wakeups on the other.
> 
> The original nocb implementation in fact had the grace-period kthead
> waking up all of what are now called rcuoc kthreads.  The indirect scheme
> reduced the total number of wakeups by up to 50% and also reduced the
> CPU consumption of the grace-period kthread, which otherwise would have
> become a bottleneck on large systems.

Thanks for the background.

> And also, a scheme that directly wakes tasks waiting in synchronize_rcu()
> might well use the same ->nocb_gp_wq[] waitqueues that are used by the
> rcuog kthreads, if that is what you were getting at.

Yes that's what I was getting at. I thought Vlad was going for doing direct
wake ups from the main RCU GP thread that orchestates RCU grace period
cycles.

> > I am curious to measure how much does Vlad patch reduce wakeups in the common case.
> 
> Sounds like a good thing to measure!

Ok. At the moment I am preparing 2 talks I am giving at OSPM for real-time and
timers. Plus preparing the PR, so I'm fully booked. :(  [and the LWN article..].
> 
> > I was also wondering how Vlad patch effects RCU-barrier ordering. I guess
> > we want the wake up to happen in the order of
> > other callbacks also waiting.
> 
> OK, I will bite.  Why would rcu_barrier() need to care about the
> synchronize_rcu() invocations if they no longer used call_rcu()?

Hm, I was just going for the fact that it is a behavioral change. Not
illuding that it would certainly cause an issue. As we know, Linux kernel
developers have interesting ways of using RCU APIs. :-)

But yes, it may not be an issue considering expedited synchronize_rcu() also
has such behavior anyway, if I'm not mistaken.

> > One last note, most battery powered systems are perhaps already using expedited RCU ;-)
> 
> Good point.  And that does raise the question of exactly what workloads
> and systems want faster wakeups from synchronize_rcu() and cannot get
> this effect from expedited grace periods.

Maybe the kind of workloads that don't need GP completion very quickly, but
just want to reduce wakeups. The wakeups do have a cost, the scheduler can
wake up several idle CPUs to "spread the awakened load" and cause wastage
power. And also contend on locks during the wake up.

thanks,

 - Joel


> >  - Joel 
> > 
> > > 
> > >                            Thanx, Paul
> > > 
> > >> +}
> > >> +
> > >> +void call_rcu_poll(struct rcu_head *rhp, rcu_callback_t func);
> > >> +DEFINE_RCU_TASKS(rcu_poll, rcu_poll_wait_gp, call_rcu_poll,
> > >> +                 "RCU Poll");
> > >> +void call_rcu_poll(struct rcu_head *rhp, rcu_callback_t func)
> > >> +{
> > >> +       call_rcu_tasks_generic(rhp, func, &rcu_poll);
> > >> +}
> > >> +EXPORT_SYMBOL_GPL(call_rcu_poll);
> > >> +
> > >> +void synchronize_rcu_poll(void)
> > >> +{
> > >> +       synchronize_rcu_tasks_generic(&rcu_poll);
> > >> +}
> > >> +EXPORT_SYMBOL_GPL(synchronize_rcu_poll);
> > >> +
> > >> +static int __init rcu_spawn_poll_kthread(void)
> > >> +{
> > >> +       cblist_init_generic(&rcu_poll);
> > >> +       rcu_poll.gp_sleep = HZ / 10;
> > >> +       rcu_spawn_tasks_kthread_generic(&rcu_poll);
> > >> +       return 0;
> > >> +}
> > >> 
> > >> Thanks
> > >> Zqiang
> > >> 
> > >> 
> > >>>> 
> > >>>> <snip>
> > >>>>  <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt
> > >>>> CBs=3613 bl=28
> > >>>> ...
> > >>>>  <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preempt
> > >>>> rhp=00000000b2d6dee8 func=__free_vm_area_struct.cfi_jt
> > >>>>  <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preempt
> > >>>> rhp=00000000a446f607 func=__free_vm_area_struct.cfi_jt
> > >>>>  <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preempt
> > >>>> rhp=00000000a5cab03b func=__free_vm_area_struct.cfi_jt
> > >>>>  <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preempt
> > >>>> rhp=0000000013b7e5ee func=__free_vm_area_struct.cfi_jt
> > >>>>  <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preempt
> > >>>> rhp=000000000a8ca6f9 func=__free_vm_area_struct.cfi_jt
> > >>>>  <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preempt
> > >>>> rhp=000000008f162ca8 func=wakeme_after_rcu.cfi_jt
> > >>>>  <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-
> > >>>> invoked=3612 idle=....
> > >>>> <snip>
> > >>>> 
> > >>> 
> > >>> Did the results above tell us that CBs-invoked=3612 during the time 21950.145313 ~ 21950.152625?
> > >>> 
> > >>> Yes.
> > >>> 
> > >>> 
> > >>> If possible, may I know the steps, commands, and related parameters to produce the results above?
> > >>> Thank you!
> > >>> 
> > >>> Build the kernel with CONFIG_RCU_TRACE configuration. Update your "set_event"
> > >>> file with appropriate traces:
> > >>> 
> > >>> <snip>
> > >>> XQ-DQ54:/sys/kernel/tracing # echo rcu:rcu_batch_start rcu:rcu_batch_end rcu:rcu_invoke_callback > set_event
> > >>> 
> > >>> XQ-DQ54:/sys/kernel/tracing # cat set_event
> > >>> rcu:rcu_batch_start
> > >>> rcu:rcu_invoke_callback
> > >>> rcu:rcu_batch_end
> > >>> XQ-DQ54:/sys/kernel/tracing #
> > >>> <snip>
> > >>> 
> > >>> Collect traces as much as you want: XQ-DQ54:/sys/kernel/tracing # echo 1 > tracing_on; sleep 10; echo 0 > tracing_on
> > >>> Next problem is how to parse it. Of course you will not be able to parse
> > >>> megabytes of traces. For that purpose i use a special C trace parser.
> > >>> If you need an example please let me know i can show here.
> > >>> 
> > >>> --
> > >>> Uladzislau Rezki
