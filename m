Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7616C6FF372
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbjEKNx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbjEKNx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:53:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BC830C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=oGt8Fhll3C/V4qi+D0XuWcFjbbPahmaQJChF0zGsRM8=; b=iIOSyArc+Pwpknln/qeD6SlJVY
        PqT9e+vv5Lvljn94kzVfXMEvIHKvL6Jy+T4PWL034k5g5Yoj0TIYyOPgDs1IhEGOn1ptlVQmepQXu
        2ODuuddClb4hW4Oa6VesjpC77CEtBU1LyCFPH9dC5CWlRcZt6QeFnO1PxUg73SqFLHbQkWTnWtIsz
        7rmVgWwRqm7F7VNEWy4lQv1nMp5wPBgkMcP9T0TLaqbbFTv1mGP1E3jcLlHm4WyLdCQ2t5S5CncKJ
        AbZVTJx7klLNWb/Lkn4GfeE2+utWW7K/rbYPrjUMr9R+izggi974uT2O1L2m0PAKuaC7iBw0Q3mPO
        3LwqoRtw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1px6jC-00HGP9-01; Thu, 11 May 2023 13:53:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 521C0300023;
        Thu, 11 May 2023 15:53:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F06D2350E488; Thu, 11 May 2023 15:53:04 +0200 (CEST)
Date:   Thu, 11 May 2023 15:53:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Crystal Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <jstultz@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/4] sched/core: Provide sched_rtmutex() and expose
 sched work helpers
Message-ID: <20230511135303.GE83892@hirez.programming.kicks-ass.net>
References: <20230427111937.2745231-1-bigeasy@linutronix.de>
 <20230427111937.2745231-2-bigeasy@linutronix.de>
 <20230503132051.GB1676736@hirez.programming.kicks-ass.net>
 <e17e3aa2c9ac1d6e410f66986da3c41efa9f7462.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e17e3aa2c9ac1d6e410f66986da3c41efa9f7462.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 05:14:38PM -0500, Crystal Wood wrote:
> On Wed, 2023-05-03 at 15:20 +0200, Peter Zijlstra wrote:

> > Urgh, so I really don't like this.
> > 
> > The end result is something like:
> > 
> >         rt_mutex_lock()
> >           sched_submit_work();
> >             // a nested rt_mutex_lock() here will not clobber
> >             // ->pi_blocked_on because it's not set yet.
> > 
> >           task_blocks_on_rt_mutex();
> >             tsk->pi_blocked_on = waiter;
> >             rt_mutex_enqueue(lock, waiter); <-- the real problem
> > 
> >           rt_mutex_slowlock_block();
> >             schedule_rtmutex();
> > 
> >           sched_resume_work();
> > 
> > And all of this it not just because tsk->pi_blocked_on, but mostly
> > because of task_blocks_on_rt_mutex() enqueueing the waiter. The whole
> > enqueue thing is what makes the 'simple' solution of saving/restoring
> > tsk->pi_blocked_on not work.
> > 
> > Basically the pi_blocked_on curruption is a side effect, not the
> > fundamental issue. One task having two waiters registered is the bigger
> > issue.
> 
> Where do you see pi_blocked_on being saved/restored? 

I'm not, I'm saying that *IF* ->pi_blocked_on corruption were the real
problem that would be a sufficient solution.

But ->pi_blocked_on corruption is just a wee side effect of the real
problem, which is that the waiter is already enqueued and we've already
done PI and can't very well back out of all that in a hurry.

> The whole point of
> this patchset is to deal with sched_submit_work() before anything has
> been done on the "outer" lock acquisition (not just pi_blocked_on, but
> also enqueuing) other than failing the fast path.

It's also terribly fragile, sprinkling stuff all over that shouldn't be
sprinkled.

And it's sprinkled far wider than it needs to be -- per the below
argument it really only should be applied to rtlock, not to rt_mutex or
ww_rt_mutex or any of the others that normally block and shouldn't be
used anyway.

> > Now, sched_submit_work() could also use (regular) mutex -- after all
> > it's a fully preemptible context. And then we're subject to the 'same'
> > problem but with tsk->blocked_on (DEBUG_MUTEXES=y).
> 
> It's fully preemptible but it still shouldn't be doing things that would
> block on non-RT.  That'd already be broken for a number of reasons (task
> state corruption, infinite recursion if current->plug isn't cleared
> before doing whatever causes another standard schedule(), etc).

task->state is fairly immune to corruption normally -- the typical
case is that the nested block resolves and resets it to RUNNING, at
which point the outer loop 'fails' to schedule() and re-tries. All that
is mostly harmless.

But yes, all that code *SHOULD* not block, but nothing is really
enforcing that.

