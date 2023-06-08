Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE73727F75
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbjFHLxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbjFHLxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:53:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB6C1FFA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=15567I756xOufGMVWMuldgQkqOzWABqEMzsY8u11rnI=; b=UGEbX34pX3GRWqcOzJCqhwEDld
        10gLysMJknAENhKyXw33Vltbo++t7ZCoYWni9gw6gMyhJ1EEy8ZDnIGmgGycsYPEdUROxJcT9ckLy
        RNFpU8f5z1U/y9N7s4gbEJFwCHgxNShC+K76tIKznladjzsG5Gb1DUbN/KiIq7+BteQwjOI7JhIe5
        qkRuTvYJhvp3MIvV30yPNtt7AB/+H1VPyOSS5AqkDSQAu37KtOg5cVfJ7HrhhYvYlbmjzEA3lLmNZ
        J2Yjy5ig4glCxBxEfMzmEXpx+0zZhD+HFpXwPzXQjgZndXVjcD7DptJM3fiC5bXi2izhmnfJxykVY
        sCYv2GAA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q7ECL-00FQrz-RV; Thu, 08 Jun 2023 11:53:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55DB8300222;
        Thu,  8 Jun 2023 13:52:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B23720D72196; Thu,  8 Jun 2023 13:52:58 +0200 (CEST)
Date:   Thu, 8 Jun 2023 13:52:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: Re: [RFC][PATCH 15/15] sched/eevdf: Use sched_attr::sched_runtime to
 set request/slice
Message-ID: <20230608115258.GJ998233@hirez.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <20230531124604.615053451@infradead.org>
 <CAKfTPtCTe7pc=fahynt1kTffUXk5B18usEE_Ay40vE-yjVt0=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCTe7pc=fahynt1kTffUXk5B18usEE_Ay40vE-yjVt0=A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 03:55:18PM +0200, Vincent Guittot wrote:
> On Wed, 31 May 2023 at 14:47, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > As an alternative to the latency-nice interface; allow applications to
> > directly set the request/slice using sched_attr::sched_runtime.
> >
> > The implementation clamps the value to: 0.1[ms] <= slice <= 100[ms]
> > which is 1/10 the size of HZ=1000 and 10 times the size of HZ=100.
> 
> There were some discussions about the latency interface and setting a
> raw time value. The problems with using a raw time value are:

So yeah, I'm well aware of that. And I'm not saying this is a better
interface -- just an alternative.

> - what  does this raw time value mean ? and how it applies to the
> scheduling latency of the task. Typically what does setting
> sched_runtime to 1ms means ? Regarding the latency, users would expect
> to be scheduled in less than 1ms but this is not what will (always)
> happen with a sched_slice set to 1ms whereas we ensure that the task
> will run for sched_runtime in the sched_period (and before
> sched_deadline) when using it with deadline scheduler. so this will be
> confusing

Confusing only if you don't know how to look at it; users are confused
in general and that's unfixable, nature will always invent a better
moron. The best we can do is provide enough clues for someone that does
know what he's doing.

So let me start by explaining how such an interface could be used and
how to look at it.

(and because we all love steady state things; I too shall use it)

Consider 4 equal-weight always running tasks (A,B,C,D) with a default
slice of 1ms.  The perfect schedule for this is a straight up FIFO
rotation of the 4 tasks, 1ms each for a total period of 4ms.

  ABCDABCD...
  +---+---+---+---

By keeping the tasks in the same order, we ensure the max latency is the
min latency -- consistency is king. If for one period you were to
say flip the first and last tasks in the order, your max latency takes a
hit, the task that was first will now have to wait 7ms instead of it's
usual 3ms.

  ABCDDBCA...
  +---+---+---+---

So far so obvious and boring..

Now, is we were to change the slice of task D to 2ms, what happens is
that it can't run the first time, because the slice rotations are 1ms,
and it needs 2ms, so it needs to save up and bank the first slot, so you
get a schedule like:

  ABCABCDDABCABCDD...
  +---+---+---+---+---

And here you can see that the total period becomes 8 (N*r_max). The
period for the 1ms tasks is still 4ms -- on average, but the period for
the 2ms task is 8ms.


A more complex example would be 3 tasks: A(w=1,r=1), B(w=1,r=1),
C(w=2,r=1) [to keep the 4ms period]:

  CCABCCAB...
  +---+---+---+---

If we change the slice of B to 2 then it becomes:

  CCACCABBCCACCABB...
  +---+---+---+---+---

So the total period is W*r_max (8ms), each task will average to a period
of W*r_i and each task will get the fair share of w_i/W time over the
total period (W*r_max per previous).

> - more than a runtime, we want to set a scheduling latency hint which
> would be more aligned with a deadline

We all wants ponies ;-) But seriously if you have a real deadline, use
SCHED_DEADLINE.

> - Then the user will complain that he set 1ms but its task is
> scheduled after several (or even dozens) ms in some cases. Also, you
> will probably end up with everybody setting 0.1ms and expecting 0.1ms
> latency. The latency nice like the nice give an opaque weight against
> others without any determinism that we can't respect

Now, notably I used sched_attr::sched_runtime, not _deadline nor _period.
Runtime is how long you expect each job-execution to take (WCET and all
that) in a periodic or sporadic task model.

Given this is a best effort overcommit scheduling class, we *CANNOT*
guarantee actual latency. The best we can offer is consistency (and this
is where EEVDF is *much* better than CFS).

We cannot, and must not pretend to provide a real deadline; hence we
should really not use that term in the user interface for this.


From the above examples we can see that if you ask for 1ms slices, you
get 1ms slices spaced (on average) closer together than if you were to
ask for 2ms slices -- even though they end up with the same share of
CPU-time.

Per the previous argument, the 2ms slice task has to forgo one slot in
first period to bank and save up for a 2ms slot in a super period.

How, if you're not a CPU hogging bully and don't use much CPU time at
all (your music player etc..) then setting the slice length to what it
actually takes to decode the next sample buffer, you can likely get a
smaller average period.

Conversely, if you ask for a slice significantly smaller than your job
execution time, you'll see it'll get split up in smaller chunks and
suffer preemption.

> - How do you set that you don't want to preempt others ? But still
> want to keep your allocated running time.

SCHED_BATCH is what we have for that. That actually works.

