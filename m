Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6065F3323
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJCQOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJCQOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:14:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B169F32D85
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 09:14:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6A8816F8;
        Mon,  3 Oct 2022 09:14:14 -0700 (PDT)
Received: from wubuntu (unknown [10.57.35.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2448A3F67D;
        Mon,  3 Oct 2022 09:14:06 -0700 (PDT)
Date:   Mon, 3 Oct 2022 17:14:04 +0100
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
Message-ID: <20221003161404.kdow5uyj7kvbqyxs@wubuntu>
References: <cb6c406e-1431-fcfd-ef82-87259760ead9@joelfernandes.org>
 <20220930134931.mpopdvri4xuponw2@wubuntu>
 <00140e95-0fe2-1ce4-1433-a3211f9da20c@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00140e95-0fe2-1ce4-1433-a3211f9da20c@joelfernandes.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/22 13:34, Joel Fernandes wrote:
> 
> 
> On 9/30/2022 9:49 AM, Qais Yousef wrote:
> > Hi Joel
> > 
> > I'm interested in the topic, if I can be CCed in any future discussions I'd
> > appreciate it :)
> 
> Yes, surely! Will do :)
> 
> > On 09/29/22 16:38, Joel Fernandes wrote:
> >> Hi Peter, all,
> >>
> >> Just following-up about the idea Peter suggested at LPC22 about sum of weights
> >> to solve the CFS priority inversion issues using priority inheritance. I am not
> >> sure if a straight forward summation of the weights of dependencies in the
> >> chain, is sufficient (or may cause too much unfairness).
> >>
> >> I think it will work if all the tasks on CPU are 100% in utilization:
> >>
> >> Say if you have 4 tasks (A, B, C, D) running and each one has equal
> >> weight (W) except for A which has twice the weight (2W).
> >> So the CPU bandwidth distribution is (assuming all are running):
> >> A:   2 / 5
> >> B, C. D:  1 / 5
> >>
> >> Say out of the 4 tasks, 3 of them are a part of a classical priority
> >> inversion scenario (A, B and C).
> >>
> >> Say now A blocks on a lock and that lock's owner C is running, however now
> >> because A has blocked, B gets 1/3 bandwidth, where as it should have been
> >> limited to 1/5. To remedy this, say you give C a weight of 2W. B gets 1/4
> >> bandwidth - still not fair since B is eating away CPU bandwidth causing the
> >> priority inversion we want to remedy.
> >>
> >> The correct bandwidth distribution should be (B and D should be unchanged):
> >> B = 1/5
> >> D = 1/5
> >>
> >> C = 3/5
> >>
> >> This means that C's weight should be 3W , and B and D should be W each
> >> as before. So indeed, C's new weight is its original weight PLUS the
> >> weight of the A - that's needed to keep the CPU usage of the other
> >> tasks (B, D) in check so that C makes forward progress on behalf of A and the
> >> other tasks don't eat into the CPU utilization.
> >>
> >> However, I think this will kinda fall apart if A is asleep 50% of the time
> >> (assume the sleep is because of I/O and unrelated to the PI chain).
> >>
> >> Because now if all were running (and assume no PI dependencies), with A being
> >> 50%, the bandwidth of B, C and D each would be divided into 2 components:
> >>
> >> a.  when A is running, it would be as above.
> >> b.  but if A was sleeping, B, C, and D would get 1/3.
> >>
> >> So on average, B, C and D get:  (1/3 + 1/5) / 2 = 8/30. This gives A about 6/30
> >> or 1/5 bandwidth.
> > 
> > The average metric is interesting one. It can be confusing to reason about too.
> > 
> > I think we have 3 events to take into account here, not 2:
> > 
> > a. when A is running and NOT blocked on C.
> > b. when A is running and BLOCKED on C.
> > c. A is sleeping.
> > 
> > This means A, B, C and D's shares will be:
> > 
> >     A ,  B ,  C ,  D
> > a. 2/5, 1/5, 1/5, 1/5
> > b. -  , 3/5, 1/5, 1/5
> 
> Here did you mean:
> b.  -, 1/5, 3/5, 1/5 ?

Yes! Sorry a typo.

> 
> A blocked on C means, C should get A's weight (on top of its own).
> 
> > c. -  , 1/3, 1/3, 1/3
> > 
> > Since A is sleeping for 50%, I don't think we can assume equal distribution for
> > the 3 events (can't just divide by 3).
> 
> Oh yeah, I did not get to _that_ part of the story yet at this point of the
> email, I brought it up later below where I say "But now say A happen to block"..

Hmm, but that's my point, I think you need to take _that_ part here or we're
not be doing an apple to apple comparison.

> 
> > 
> > I believe we can assume that
> > 
> > a. occurs 25% of the time
> > b. occurs 25% of the time
> > c. occurs 50% of the time
> > 
> > I *think* this should provide something more representative.
> 
> Yes possible. My basic idea was I was trying to *not* change the distribution of
> B based on whether A blocks on C, or whether it does not. In my view, B's
> distribution should not change just because A and C have a lock dependency,
> because otherwise C can get too much or too little time. If C gets too much
> time, then its hurting B. If C gets too little time, then its hurting A.

Maybe I am getting confused. But AFAICT you're treating


	a.  when A is running, it would be as above.
	b.  but if A was sleeping, B, C, and D would get 1/3.

similar to

	a.  when A is running *and blocked on C for all its runtime*
	b.  but if A was sleeping, B, C, and D would get 1/3.

I don't think this is valid. If A is blocked on C for 50% of the time, and
sleeping for 50% of the time, when did it get blocked/unblocked?

This will have an impact on the average share for C and skew it, no?

Unless I missed something, the average share of C being (3/5 + 1/3) is an
impossible state. You need to consider the portion of time when C runs as 1/5,
when A is actually not blocked on anything, too.

Hmm actually I just re-read your statement below and you just say 3/5 (18/30)
is too much. You didn't consider the average. I'll leave the above in hope to
help me understand what am I missing and where I went wrong :-)

Generally IMHO looking at the average will not help. I think if the share
values make sense in each state individually (and I believe they are), that
would be enough. AFAICS, B and D are still taking the right amount of time when
C inherits the bandwidth. And C by definition will run longer when A is blocked
on it for the whole duration of this blocked time.

> 
> >> But now say A happen to block on a lock that C is holding. You would boost C to
> >> weight 3W which gives it 3/5 (or 18/30) as we saw above, which is more than what
> >> C should actually get.
> >>
> >> C should get (8/30 + 6/30 = 14/30) AFAICS.
> >>
> >> Hopefully one can see that a straight summation of weights is not enough. It
> >> needs to be something like:
> >>
> >> C's new weight = C's original weight + (A's weight) * (A's utilization)
> >>
> >> Or something, otherwise the inherited weight may be too much to properly solve it.
> >>
> >> Any thoughts on this? You mentioned you had some notes on this and/or proxy
> >> execution, could you share it?
> > 
> > I assume we'll be using rt-mutex inheritance property to handle this? If this
> > was discussed during a talk, I'd appreciate a link to that.
> 
> Yes that's the idea but I am also aware that 'other' kinds of dependencies in
> userspace that cannot benefit from a kernel-only boost.
> 
> So if we consider a bounded-buffer producer/consumer. We can consider the
> producer as A, and the consumer as C, with B being a random mid-priority task.
> Once the bounded buffer gets full, A is waiting on a signal from C that it
> filled the buffer for which C needs to run in the first place to queue its
> payload into the buffer. However, trouble-maker B is determined to eat away's
> C's time and develop a prio inversion between itself and A. This pattern should
> also generalize to a worker pool consuming work.

Will proxy-execution be able to handle these other cases? I think it is tied to
rt-mutex to be able to detect the dependency chain too. Looks a generic
extension of the problem that all potential solutions will need to deal with.

> 
> In this case, there is no lock involved yet you have a dependency. But I don't
> mean to sound depressing, and just because there are cases like this does not
> mean we should not solve the lock-based ones. When I looked at Android, I saw
> that it uses futex directly from Android Runtime code instead of using pthread.
> So perhaps this can be trivially converted to FUTEX_LOCK_PI and then what we do
> in the kernel will JustWork(Tm) ?

I guess it will depend on individual libc implementation, but I thought all of
them use FUTEX under the hood for pthreads mutexes.

Maybe we can add a bootparam to force all futexes to be FUTEX_LOCK_PI?

> 
> > 
> > In the past in OSPM conference we brought up an issue with performance
> > inversion where a task running on a smaller (slower to be more generic) CPU is
> > holding the lock and causing massive delays for waiters. This is an artefact of
> > DVFS. For HMP, there's an additional cause due to the unequal capacities of the
> > CPUs.
> > 
> > Proxy execution seems to be the nice solution to all of these problems, but
> > it's a long way away. I'm interested to learn how this inheritance will be
> > implemented. And whether there are any userspace conversion issues. i.e: do
> > we need to convert all locks to rt-mutex locks?
> 
> I am not an expert on FUTEX_LOCK_PI and this could be a good time for tglx to
> weigh in, but I think converting all userspace locks to use FUTEX_LOCK_PI sounds
> reasonable to me.

I realized whether we need to worry about in-kernel kthreads users too..

pthreads requires users to specify if they want PTHREAD_PRIO_{INHERIT, PROTECT}
when initializing their mutex.

AFAICS from glibc, PTHREAD_PRIO_INHERIT maps to FUTEX_LOCK_PI.

But PTHREAD_PRIO_PROTOTECT uses a different algorithm that is implemented in
glibc. This makes me think how much this makes sense in linux as for CFS
priorities are transalted into weights and not actual priorites like in RT :-/

I need to dig more..

Expert opinions would help for sure :)


Thanks!

--
Qais Yousef

> 
> Other thoughts?
> 
> thanks,
> 
>  - Joel
> 
