Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD1D5EFDCE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiI2TTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiI2TTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:19:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB4D237DA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FfSw4xqLKrQ2l6+E8OQcMdt/QaCzcG7Lvd+6tnKno5Q=; b=SvcxiE/M5CrFwuad+Q9lSBiqIV
        jdGmwgxUuRhxbUJ/001z45MavXd2CcAxY2lUL5swFiAM6k6vJBaghajlICJXt/YNJU4E63Q105AaF
        JiUXXYKIwlZVsq7Yr/7m+w6WMe8mn/lukODwzP8x5qIKfTO19APrIIhspSqQeklA803oglNKvOA5J
        J+5LKU/QZ4adR2gj+AdM+wOo2pDQJfeZycasNO1K/Q5HwyEzIZ5UE1lN6R6oZb7KOS7rlkwCOS+7M
        9d8vr8YLW582+tqtugoipqsrXYgAjOmyaagDFnl/QE7Mfkiw96QIkSfuGx3BoKId3tDY066hMWVC9
        6CNe/rOQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odz4G-00DXis-L2; Thu, 29 Sep 2022 19:19:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 74B903001E3;
        Thu, 29 Sep 2022 21:19:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5416D2BC83CC3; Thu, 29 Sep 2022 21:19:28 +0200 (CEST)
Date:   Thu, 29 Sep 2022 21:19:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Subject: Re: [PATCH v2] sched/fair: limit sched slice duration
Message-ID: <YzXvwMXpdhyt/Srm@hirez.programming.kicks-ass.net>
References: <20220916131538.24706-1-vincent.guittot@linaro.org>
 <YzXEZnH6CAtZ+V4R@hirez.programming.kicks-ass.net>
 <CAKfTPtDkQuA9ghEVJZieLfeXLMpimE-jjuLB-1wLntYSD6RoxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDkQuA9ghEVJZieLfeXLMpimE-jjuLB-1wLntYSD6RoxQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 07:15:42PM +0200, Vincent Guittot wrote:
> On Thu, 29 Sept 2022 at 18:14, Peter Zijlstra <peterz@infradead.org> wrote:

> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 5ffec4370602..2b218167fadf 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4575,17 +4575,33 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >  }
> >
> >  /*
> > - * Preempt the current task with a newly woken task if needed:
> > + * Tick driven preemption; preempt the task if it has ran long enough.
> > + * Allows other tasks to have a go.
> >   */
> >  static void
> >  check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> >  {
> > -       unsigned long ideal_runtime, delta_exec;
> >         struct sched_entity *se;
> > -       s64 delta;
> > +       s64 delta, delta_exec;
> > +       u64 ideal_runtime;
> >
> > -       ideal_runtime = sched_slice(cfs_rq, curr);
> > +       /* How long has this task been on the CPU for [walltime]. */
> >         delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
> > +
> > +       /*
> > +        * Ensure that a task that missed wakeup preemption by a
> > +        * narrow margin doesn't have to wait for a full slice.
> > +        * This also mitigates buddy induced latencies under load.
> > +        */
> > +       if (delta_exec < sysctl_sched_min_granularity)
> > +               return;
> 
> ideal_runtime can be lower than sysctl_sched_min_granularity. It can
> be as low as sysctl_sched_idle_min_granularity for idle task. In this
> case, we want to resched even if(delta_exec <
> sysctl_sched_min_granularity). That's why the 1st test was still done
> before

Duh, indeed.

> > +
> > +       /*
> > +        * When many tasks blow up the sched_period; it is possible that
> > +        * sched_slice() reports unusually large results (when many tasks are
> > +        * very light for example). Therefore impose a maximum.
> > +        */
> > +       ideal_runtime = min_t(u64, sched_slice(cfs_rq, curr), sysctl_sched_latency);
> 
> I didn't cap ideal_runtime before this test because we have situations
> where large ideal_runtime is ok: If there is only one normal thread
> with hundreds of idle threads as an example: Is it acceptable to
> trigger a useless resched in this case ? That's why I have computed
> the virtual time generated by the capped version of ideal_runtime.

Yeah; I think that should be fine. It's an edge case, and sched_latency
is fairly large already.

> >         se = __pick_first_entity(cfs_rq);
> >         delta = curr->vruntime - se->vruntime;
> > -
> >         if (delta < 0)
> >                 return;
> >
> > +       /*
> > +        * Compare @delta [vtime] to @ideal_runtime [walltime]. This means that
> > +        * heavy tasks (for which vtime goes slower) get relatively more time
> > +        * before preemption, while light tasks (for which vtime goes faster)
> > +        * get relatively less time.  IOW, heavy task get to run longer.
> > +        */
> 
> After your comment on v1, I looked more deeply on this and the
> comparison of [vtime] with [walltime] can create a large unfairness.
> vtime of nice-20 increases by ~250us for 24ms of walltime which means
> that the nice-20 will have to run for a long time before reaching this
> walltime delta (assuming the vruntime were similar at the beg)

As I wrote, strictly speaking we should do without this. The entire
vtime thing is a band-aid.

I'm sure I've tried taking it out at least once; but sadly I seem to
have forgotten everything relevant :-( That is, I can't tell you why
this code exists.
