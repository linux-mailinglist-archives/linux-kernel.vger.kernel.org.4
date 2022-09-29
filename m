Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7C15EF3AC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiI2Kr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiI2KrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:47:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65EED13F286
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:47:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9D5115BF;
        Thu, 29 Sep 2022 03:47:30 -0700 (PDT)
Received: from wubuntu (FVFF764EQ05P.cambridge.arm.com [10.1.30.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C92323F73B;
        Thu, 29 Sep 2022 03:47:21 -0700 (PDT)
Date:   Thu, 29 Sep 2022 11:47:20 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Connor O'Brien <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [RFC][PATCH v3 0/3] Softirq -rt Optimizations
Message-ID: <20220929104720.k5wdaxrtrkxi24qt@wubuntu>
References: <20220921012550.3288570-1-jstultz@google.com>
 <20220928130043.d6ijyxbq43tfvqg7@wubuntu>
 <529cd76702b44678a4d4abe539105942@AcuMS.aculab.com>
 <20220928155618.ylyns4x4tog34zui@wubuntu>
 <c5c8218e587941bc91a2cc49883235d0@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5c8218e587941bc91a2cc49883235d0@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/22 16:19, David Laight wrote:
> From: Qais Yousef
> > Sent: 28 September 2022 16:56
> > 
> > On 09/28/22 13:51, David Laight wrote:
> > > From: Qais Yousef
> > > > Sent: 28 September 2022 14:01
> > > >
> > > > Hi John
> > > >
> > > > On 09/21/22 01:25, John Stultz wrote:
> > > > > Hey all,
> > > > >
> > > > > This series is a set of patches that optimize scheduler decisions around
> > > > > realtime tasks and softirqs.  This series is a rebased and reworked set
> > > > > of changes that have been shipping on Android devices for a number of
> > > > > years, originally created to resolve audio glitches seen on devices
> > > > > caused by softirqs for network or storage drivers.
> > > > >
> > > > > Long running softirqs cause issues because they aren’t currently taken
> > > > > into account when a realtime task is woken up, but they will delay
> > > > > realtime tasks from running if the realtime tasks are placed on a cpu
> > > > > currently running a softirq.
> > > >
> > > > Thanks a lot for sending this series. I've raised this problem in various
> > > > venues in the past, but it seems it is hard to do something better than what
> > > > you propose here.
> > > >
> > > > Borrowing some behaviours from PREEMPT_RT (like threadedirqs) won't cut it
> > > > outside PREEMPT_RT AFAIU.
> > > >
> > > > Peter did suggest an alternative at one point in the past to be more aggressive
> > > > in limiting softirqs [1] but I never managed to find the time to verify it
> > > > - especially its impact on network throughput as this seems to be the tricky
> > > > trade-of (and tricky thing to verify for me at least). I'm not sure if BLOCK
> > > > softirqs are as sensitive.
> > >
> > > I've had issues with the opposite problem.
> > > Long running RT tasks stopping the softint code running.
> > >
> > > If an RT task is running, the softint will run in the context of the
> > > RT task - so has priority over it.
> > > If the RT task isn't running the softint stops the RT task being scheduled.
> > > This is really just the same.
> > >
> > > If the softint defers back to thread context it won't be scheduled
> > > until any RT task finishes. This is the opposite priority.
> > 
> > If we can get a subset of threadedirqs (call it threadedsoftirqs) from
> > PREEMPT_RT where softirqs can be converted into RT kthreads, that'll alleviate
> > both sides of the problem IMO. But last I checked with Thomas this won't be
> > possible. But things might have changed since then..
> 
> Part of the problem is that can significantly increase latency.
> Some softirq calls will be latency sensitive.

Probably part of the problem why it can't be made available outside PREEMPT_RT
:)

> 
> > > IIRC there is another strange case where the RT thread has been woken
> > > but isn't yet running - can't remember the exact details.
> > >
> > > I can (mostly) handle the RT task being delayed (there are a lot of RT
> > > threads sharing the work) but it is paramount that the ethernet receive
> > > code actually runs - I can't afford to drop packets (they contain audio
> > > the RT threads are processing).
> > >
> > > In my case threaded NAPI (mostly) fixes it - provided the NAPI thread are RT.
> > 
> > There's a netdev_budget and netdev_bugdet_usecs params in procfs that control
> > how long the NET_RX spends in the softirq. Maybe you need to tweak those too.
> > In your case, you probably want to increase the budget.
> 
> Maybe, but the problem is that the softint code is far too willing
> to drop to kthread context.
> Eric made a change to reduce that (to avoid losing ethernet packets)
> but the original test got added back - there are now two tests, but
> the original one dominates. Eric's bug fix got reverted (with extra
> tests that make the code slower).

Would be good to know what fix you're referring to.

> I did test with that changed, but still got some lost packets.
> Trying to receive 500000 UDP packets/sec is quite hard!
> They are also split across 10k unconnected sockets.

There's a hardcoded value in kernel/softirq.c::MAX_SOFTIRQ_TIME which is set to
2ms.

It might be worth bringing your problem with the networking community. I don't
think your use case is unique - but they'd know better and what needs to be
done to achieve it.

Note there's a physical upper limit that will be dictated by the hardware;
whether it's the number of cores, max frequencies, memory (speed and size) etc.

I'm assuming this is not a problem, but worth to highlight.

> > Note that in Android the BLOCK layer seems to cause similar problems which
> > don't have these NET facilities. So NET is only one side of the problem.
> 
> Isn't the block layer softints stopping other code?
> I'd really got the other problem.
> Although I do have a 10ms timer wakeup that really needs not to be delayed.

I was just trying to highlight that this series is concerned with more than
just networking.

I thought you had concerns about this series, but it seems you're trying to
highlight another type of relevant problem.


Cheers

--
Qais Yousef
