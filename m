Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF69E6ED704
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 23:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjDXVyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 17:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDXVyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:54:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F83E5FDB;
        Mon, 24 Apr 2023 14:54:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07D9D6296B;
        Mon, 24 Apr 2023 21:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACECC433D2;
        Mon, 24 Apr 2023 21:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682373241;
        bh=KmDJOQ/GxaMF/T8mWHapdMOXlQEKWjFEDLLApJKrrcA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Tm6esVbnKygbpzQqTo+uW+bg/v0UynPuCKEl2wg6/+agk6yaVdZqjrqgcAQIBUEEM
         ObP+qunWjxZ8HNE7q0nwy4uPxvsc689h8K9PwP2yei1XQr/yZ4ax5coaJUA7rcYMGx
         FQZ0OBqnFV4U7nBzJfpPXWmL19ZPy0lxjqHC4oEKPc2jsiuOD3pSpv9q5qQdITQkEK
         9F/Mqsx49Bshc8FcSHBcDc8CH7pKfQIGRx7lCrc7LbDHsNxdJOzugZym5uAfRm5fvr
         kjDEvGqvm6tXhsyA/GjbpvXlkmRlQ8HYUlX2D6YHezkYvJlgBKp3sAY790H8J4z8Q6
         3dAxwgZwyqXUQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EE24815405A7; Mon, 24 Apr 2023 14:54:00 -0700 (PDT)
Date:   Mon, 24 Apr 2023 14:54:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>, Hu Chunyu <chuhu@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 2/3] sched/task: Add the put_task_struct_atomic_safe()
 function
Message-ID: <2a57855e-da25-4c1a-bbca-0c75ddd5f7ba@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230414125532.14958-1-wander@redhat.com>
 <20230414125532.14958-3-wander@redhat.com>
 <9ff7ea3a-b48b-4cff-851e-179713393531@paulmck-laptop>
 <CAAq0SUk_-yNgKTyY47+n2oKQ3KF1VYgp2zdScF9fJ5jWP5wKpQ@mail.gmail.com>
 <105084b0-9d65-4896-97e4-35ef3c6f1fae@paulmck-laptop>
 <CAAq0SUkJQtBzhrTiHEHH3LnL8nM7j7ebh_OsRhNUr9mNfrbROA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAq0SUkJQtBzhrTiHEHH3LnL8nM7j7ebh_OsRhNUr9mNfrbROA@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 05:34:29PM -0300, Wander Lairson Costa wrote:
> On Mon, Apr 24, 2023 at 3:52 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Mon, Apr 24, 2023 at 03:43:09PM -0300, Wander Lairson Costa wrote:
> > > On Mon, Apr 24, 2023 at 3:09 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > On Fri, Apr 14, 2023 at 09:55:28AM -0300, Wander Lairson Costa wrote:
> > > > > Due to the possibility of indirectly acquiring sleeping locks, it is
> > > > > unsafe to call put_task_struct() in atomic contexts when the kernel is
> > > > > compiled with PREEMPT_RT.
> > > > >
> > > > > To mitigate this issue, this commit introduces
> > > > > put_task_struct_atomic_safe(), which schedules __put_task_struct()
> > > > > through call_rcu() when PREEMPT_RT is enabled. While a workqueue would
> > > > > be a more natural approach, we cannot allocate dynamic memory from
> > > > > atomic context in PREEMPT_RT, making the code more complex.
> > > > >
> > > > > This implementation ensures safe execution in atomic contexts and
> > > > > avoids any potential issues that may arise from using the non-atomic
> > > > > version.
> > > > >
> > > > > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > > > > Reported-by: Hu Chunyu <chuhu@redhat.com>
> > > > > Cc: Paul McKenney <paulmck@kernel.org>
> > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > ---
> > > > >  include/linux/sched/task.h | 31 +++++++++++++++++++++++++++++++
> > > > >  kernel/fork.c              |  8 ++++++++
> > > > >  2 files changed, 39 insertions(+)
> > > > >
> > > > > diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> > > > > index b597b97b1f8f..5c13b83d7008 100644
> > > > > --- a/include/linux/sched/task.h
> > > > > +++ b/include/linux/sched/task.h
> > > > > @@ -141,6 +141,37 @@ static inline void put_task_struct_many(struct task_struct *t, int nr)
> > > > >
> > > > >  void put_task_struct_rcu_user(struct task_struct *task);
> > > > >
> > > > > +extern void __delayed_put_task_struct(struct rcu_head *rhp);
> > > > > +
> > > > > +static inline void put_task_struct_atomic_safe(struct task_struct *task)
> > > > > +{
> > > > > +     if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > > > > +             /*
> > > > > +              * Decrement the refcount explicitly to avoid unnecessarily
> > > > > +              * calling call_rcu.
> > > > > +              */
> > > > > +             if (refcount_dec_and_test(&task->usage))
> > > > > +                     /*
> > > > > +                      * under PREEMPT_RT, we can't call put_task_struct
> > > > > +                      * in atomic context because it will indirectly
> > > > > +                      * acquire sleeping locks.
> > > > > +                      * call_rcu() will schedule delayed_put_task_struct_rcu()
> > > > > +                      * to be called in process context.
> > > > > +                      *
> > > > > +                      * __put_task_struct() is called called when
> > > > > +                      * refcount_dec_and_test(&t->usage) succeeds.
> > > > > +                      *
> > > > > +                      * This means that it can't "conflict" with
> > > > > +                      * put_task_struct_rcu_user() which abuses ->rcu the same
> > > > > +                      * way; rcu_users has a reference so task->usage can't be
> > > > > +                      * zero after rcu_users 1 -> 0 transition.
> > > > > +                      */
> > > > > +                     call_rcu(&task->rcu, __delayed_put_task_struct);
> > > >
> > > > This will invoke __delayed_put_task_struct() with softirqs disabled.
> > > > Or do softirq-disabled contexts count as non-atomic in PREEMPT_RT?
> > >
> > > softirqs execute in thread context in PREEMPT_RT. We are good here.
> >
> > So the sleeping lock is a spinlock rather than (say) a mutex?
> 
> Yes, under PREEMPT_RT, spinlocks are implemented in terms of rtmutex.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

                                                        Thanx, Paul

> > > > > +     } else {
> > > > > +             put_task_struct(task);
> > > > > +     }
> > > > > +}
> > > > > +
> > > > >  /* Free all architecture-specific resources held by a thread. */
> > > > >  void release_thread(struct task_struct *dead_task);
> > > > >
> > > > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > > > index 0c92f224c68c..9884794fe4b8 100644
> > > > > --- a/kernel/fork.c
> > > > > +++ b/kernel/fork.c
> > > > > @@ -854,6 +854,14 @@ void __put_task_struct(struct task_struct *tsk)
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(__put_task_struct);
> > > > >
> > > > > +void __delayed_put_task_struct(struct rcu_head *rhp)
> > > > > +{
> > > > > +     struct task_struct *task = container_of(rhp, struct task_struct, rcu);
> > > > > +
> > > > > +     __put_task_struct(task);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(__delayed_put_task_struct);
> > > > > +
> > > > >  void __init __weak arch_task_cache_init(void) { }
> > > > >
> > > > >  /*
> > > > > --
> > > > > 2.39.2
> > > > >
> > > >
> > >
> >
> 
