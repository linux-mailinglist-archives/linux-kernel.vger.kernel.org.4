Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087A55F0CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiI3Ntk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiI3Nth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:49:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6783E7B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:49:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29B7813D5;
        Fri, 30 Sep 2022 06:49:41 -0700 (PDT)
Received: from wubuntu (unknown [10.57.34.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 392B13F792;
        Fri, 30 Sep 2022 06:49:33 -0700 (PDT)
Date:   Fri, 30 Sep 2022 14:49:31 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Youssef Esmat <youssefesmat@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Sum of weights idea for CFS PI
Message-ID: <20220930134931.mpopdvri4xuponw2@wubuntu>
References: <cb6c406e-1431-fcfd-ef82-87259760ead9@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb6c406e-1431-fcfd-ef82-87259760ead9@joelfernandes.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel

I'm interested in the topic, if I can be CCed in any future discussions I'd
appreciate it :)

On 09/29/22 16:38, Joel Fernandes wrote:
> Hi Peter, all,
> 
> Just following-up about the idea Peter suggested at LPC22 about sum of weights
> to solve the CFS priority inversion issues using priority inheritance. I am not
> sure if a straight forward summation of the weights of dependencies in the
> chain, is sufficient (or may cause too much unfairness).
> 
> I think it will work if all the tasks on CPU are 100% in utilization:
> 
> Say if you have 4 tasks (A, B, C, D) running and each one has equal
> weight (W) except for A which has twice the weight (2W).
> So the CPU bandwidth distribution is (assuming all are running):
> A:   2 / 5
> B, C. D:  1 / 5
> 
> Say out of the 4 tasks, 3 of them are a part of a classical priority
> inversion scenario (A, B and C).
> 
> Say now A blocks on a lock and that lock's owner C is running, however now
> because A has blocked, B gets 1/3 bandwidth, where as it should have been
> limited to 1/5. To remedy this, say you give C a weight of 2W. B gets 1/4
> bandwidth - still not fair since B is eating away CPU bandwidth causing the
> priority inversion we want to remedy.
> 
> The correct bandwidth distribution should be (B and D should be unchanged):
> B = 1/5
> D = 1/5
> 
> C = 3/5
> 
> This means that C's weight should be 3W , and B and D should be W each
> as before. So indeed, C's new weight is its original weight PLUS the
> weight of the A - that's needed to keep the CPU usage of the other
> tasks (B, D) in check so that C makes forward progress on behalf of A and the
> other tasks don't eat into the CPU utilization.
> 
> However, I think this will kinda fall apart if A is asleep 50% of the time
> (assume the sleep is because of I/O and unrelated to the PI chain).
> 
> Because now if all were running (and assume no PI dependencies), with A being
> 50%, the bandwidth of B, C and D each would be divided into 2 components:
> 
> a.  when A is running, it would be as above.
> b.  but if A was sleeping, B, C, and D would get 1/3.
> 
> So on average, B, C and D get:  (1/3 + 1/5) / 2 = 8/30. This gives A about 6/30
> or 1/5 bandwidth.

The average metric is interesting one. It can be confusing to reason about too.

I think we have 3 events to take into account here, not 2:

a. when A is running and NOT blocked on C.
b. when A is running and BLOCKED on C.
c. A is sleeping.

This means A, B, C and D's shares will be:

    A ,  B ,  C ,  D
a. 2/5, 1/5, 1/5, 1/5
b. -  , 3/5, 1/5, 1/5
c. -  , 1/3, 1/3, 1/3

Since A is sleeping for 50%, I don't think we can assume equal distribution for
the 3 events (can't just divide by 3).

I believe we can assume that

a. occurs 25% of the time
b. occurs 25% of the time
c. occurs 50% of the time

I *think* this should provide something more representative.

> 
> But now say A happen to block on a lock that C is holding. You would boost C to
> weight 3W which gives it 3/5 (or 18/30) as we saw above, which is more than what
> C should actually get.
> 
> C should get (8/30 + 6/30 = 14/30) AFAICS.
> 
> Hopefully one can see that a straight summation of weights is not enough. It
> needs to be something like:
> 
> C's new weight = C's original weight + (A's weight) * (A's utilization)
> 
> Or something, otherwise the inherited weight may be too much to properly solve it.
> 
> Any thoughts on this? You mentioned you had some notes on this and/or proxy
> execution, could you share it?

I assume we'll be using rt-mutex inheritance property to handle this? If this
was discussed during a talk, I'd appreciate a link to that.

In the past in OSPM conference we brought up an issue with performance
inversion where a task running on a smaller (slower to be more generic) CPU is
holding the lock and causing massive delays for waiters. This is an artefact of
DVFS. For HMP, there's an additional cause due to the unequal capacities of the
CPUs.

Proxy execution seems to be the nice solution to all of these problems, but
it's a long way away. I'm interested to learn how this inheritance will be
implemented. And whether there are any userspace conversion issues. i.e: do
we need to convert all locks to rt-mutex locks?


Thanks

--
Qais Yousef
