Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821ED5F51C0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJEJbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJEJbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:31:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78D901FCF2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 02:31:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F168E113E;
        Wed,  5 Oct 2022 02:31:41 -0700 (PDT)
Received: from wubuntu (unknown [10.57.32.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6122F3F67D;
        Wed,  5 Oct 2022 02:31:33 -0700 (PDT)
Date:   Wed, 5 Oct 2022 10:31:31 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Youssef Esmat <youssefesmat@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        clark.williams@gmail.com, bigeasy@linutronix.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Sum of weights idea for CFS PI
Message-ID: <20221005093131.onth46ngd5bz6y3f@wubuntu>
References: <cb6c406e-1431-fcfd-ef82-87259760ead9@joelfernandes.org>
 <20220930134931.mpopdvri4xuponw2@wubuntu>
 <00140e95-0fe2-1ce4-1433-a3211f9da20c@joelfernandes.org>
 <20221003161404.kdow5uyj7kvbqyxs@wubuntu>
 <160a2ded-b8e0-acf0-a8b6-df1b0f2c0fa8@joelfernandes.org>
 <20221004163039.vv3byszpg5dqjhy5@wubuntu>
 <0773b853-afdf-4368-3494-a5bd1cf01893@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0773b853-afdf-4368-3494-a5bd1cf01893@joelfernandes.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/22 15:48, Joel Fernandes wrote:
> 
> 
> On 10/4/2022 12:30 PM, Qais Yousef wrote:
> > On 10/03/22 12:27, Joel Fernandes wrote:
> >> There's a lot to unwind so I will reply in pieces after spending some time
> >> thinking about it, but just for this part:
> >>
> >> On 10/3/2022 12:14 PM, Qais Yousef wrote:
> >>>> In this case, there is no lock involved yet you have a dependency. But I don't
> >>>> mean to sound depressing, and just because there are cases like this does not
> >>>> mean we should not solve the lock-based ones. When I looked at Android, I saw
> >>>> that it uses futex directly from Android Runtime code instead of using pthread.
> >>>> So perhaps this can be trivially converted to FUTEX_LOCK_PI and then what we do
> >>>> in the kernel will JustWork(Tm) ?
> >>> I guess it will depend on individual libc implementation, but I thought all of
> >>> them use FUTEX under the hood for pthreads mutexes.
> >>>
> >>> Maybe we can add a bootparam to force all futexes to be FUTEX_LOCK_PI?
> >>>
> >>
> >> In the case of FUTEX_LOCK_PI, you have to store the TID of the 'lock owner' in
> >> the futex word to signify that lock is held.
> > 
> > Right. So userspace has to opt-in.
> > 
> >> That wont work for the case above, Producer/Consumer signalling each other on a
> >> bounded-buffer, right? That's not locking even though it is acquiring and
> >> release of a limited resource.
> > 
> > Yes but as I tried to point out I don't think proxy-execution handles this case
> > where you don't hold a lock explicitly. But I could be wrong.
> 
> I don't disagree. Proxy execution is an implementation detail, without more
> information from userspace, any implementation cannot help. I was just
> responding to your point about converting all futexes which you cannot do
> without knowing what the futex is used for.

+1

I don't think I read much on literature on priority inversion caused by waiting
on signals. I need to research that.

I think it is considered a voluntary sleep and sane system design should ensure
both of these tasks priorities don't lead to starvation based on expected rate
of producer/consumer.

It doesn't seem to be a problem for PREEMPT_RT since no body has done anything
about it AFAICT?

It could be the fact that in CFS priority is weights (or bandwidth) and this
introduces this new class of problems. I think we should still ask the question
if the priority assignment is wrong when this happens. If there's a clear
relationship between producer/consumer, should they have the same priority if
they do equal amount of work?

> 
> But I am thinking of messing around with rt_mutex_setprio() and some userspace
> tests to see if I can make the sum of weights thing work for the *userspace
> locking* usecases (FUTEX_LOCK_PI). Then run some tests and collect some traces.
> Perhaps you can do that on the Android side as well.

I'd be happy to help, yes :)

In my view, the trickiest part would be is how to account for the stolen time.
If C gets 3/5 share and runs for 2/5 before releasing the lock, then when
A wakes up, it should perceive that it ran for 1/5 (time C stole from A while
holding the lock) and run only for 1/5 before getting preempted. To preserve
its 2/5 share. That is IF we want to be very accurate.

If the 2 tasks are not on the same rq, I think that will not change how things
are done a lot..

> 
> > IIUC Sebastian's
> > understanding is similar to mine. Only 'locks' (FUTEX_LOCK_PI which ends up
> > using rt-mutex) do PI inheritance.
> > 
> > So this signaling scenario is a new class of problems that wasn't handled
> > before; to my understanding.
> Most certainly, agreed.


Sorry I am thinking out loud for most/all part of my reply :)


Thanks!

--
Qais Yousef
