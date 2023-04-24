Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0A26ED416
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjDXSJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDXSJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:09:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93D86E91;
        Mon, 24 Apr 2023 11:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73B2C622EC;
        Mon, 24 Apr 2023 18:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8417C433D2;
        Mon, 24 Apr 2023 18:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682359759;
        bh=DCPhmzjXeq8Lo44Zu22jyvJqFljz6eHBBKLb+VcR4h8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bz3XKFtgJK/4SHg5scRNDEawqSH+rwy+/+N0pE2HH+hvD7acuajV2zGUCNYwwENxx
         bXHiZJV3KsaoFcF7pcjaqkzN9QBFB4vTIoIXDap3eAFrYavW1CinS77iPtR8Ga0knG
         gVfg4HyYq6rD0Bil+T2ZdEbOwbvlaEP4HY2O9APbrngyfZmK4Q+XGYkFMN/2DEAMnH
         8kwmcyoXqA0Q+WB4rIwAOPCXI4WypsacITSB+qAmJFAa+KvV6cVuEAYfISvcuomA+W
         DJWNSwYu4Iwtkb66oO7/ZOw+ZhhwZGC7HNpuxoiSIPXiqQA71nsD0wp44s113eici6
         8LkmgE8FzyFcw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5C48315404E7; Mon, 24 Apr 2023 11:09:19 -0700 (PDT)
Date:   Mon, 24 Apr 2023 11:09:19 -0700
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
Message-ID: <9ff7ea3a-b48b-4cff-851e-179713393531@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230414125532.14958-1-wander@redhat.com>
 <20230414125532.14958-3-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414125532.14958-3-wander@redhat.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 09:55:28AM -0300, Wander Lairson Costa wrote:
> Due to the possibility of indirectly acquiring sleeping locks, it is
> unsafe to call put_task_struct() in atomic contexts when the kernel is
> compiled with PREEMPT_RT.
> 
> To mitigate this issue, this commit introduces
> put_task_struct_atomic_safe(), which schedules __put_task_struct()
> through call_rcu() when PREEMPT_RT is enabled. While a workqueue would
> be a more natural approach, we cannot allocate dynamic memory from
> atomic context in PREEMPT_RT, making the code more complex.
> 
> This implementation ensures safe execution in atomic contexts and
> avoids any potential issues that may arise from using the non-atomic
> version.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Reported-by: Hu Chunyu <chuhu@redhat.com>
> Cc: Paul McKenney <paulmck@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/sched/task.h | 31 +++++++++++++++++++++++++++++++
>  kernel/fork.c              |  8 ++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index b597b97b1f8f..5c13b83d7008 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -141,6 +141,37 @@ static inline void put_task_struct_many(struct task_struct *t, int nr)
>  
>  void put_task_struct_rcu_user(struct task_struct *task);
>  
> +extern void __delayed_put_task_struct(struct rcu_head *rhp);
> +
> +static inline void put_task_struct_atomic_safe(struct task_struct *task)
> +{
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		/*
> +		 * Decrement the refcount explicitly to avoid unnecessarily
> +		 * calling call_rcu.
> +		 */
> +		if (refcount_dec_and_test(&task->usage))
> +			/*
> +			 * under PREEMPT_RT, we can't call put_task_struct
> +			 * in atomic context because it will indirectly
> +			 * acquire sleeping locks.
> +			 * call_rcu() will schedule delayed_put_task_struct_rcu()
> +			 * to be called in process context.
> +			 *
> +			 * __put_task_struct() is called called when
> +			 * refcount_dec_and_test(&t->usage) succeeds.
> +			 *
> +			 * This means that it can't "conflict" with
> +			 * put_task_struct_rcu_user() which abuses ->rcu the same
> +			 * way; rcu_users has a reference so task->usage can't be
> +			 * zero after rcu_users 1 -> 0 transition.
> +			 */
> +			call_rcu(&task->rcu, __delayed_put_task_struct);

This will invoke __delayed_put_task_struct() with softirqs disabled.
Or do softirq-disabled contexts count as non-atomic in PREEMPT_RT?

							Thanx, Paul

> +	} else {
> +		put_task_struct(task);
> +	}
> +}
> +
>  /* Free all architecture-specific resources held by a thread. */
>  void release_thread(struct task_struct *dead_task);
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 0c92f224c68c..9884794fe4b8 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -854,6 +854,14 @@ void __put_task_struct(struct task_struct *tsk)
>  }
>  EXPORT_SYMBOL_GPL(__put_task_struct);
>  
> +void __delayed_put_task_struct(struct rcu_head *rhp)
> +{
> +	struct task_struct *task = container_of(rhp, struct task_struct, rcu);
> +
> +	__put_task_struct(task);
> +}
> +EXPORT_SYMBOL_GPL(__delayed_put_task_struct);
> +
>  void __init __weak arch_task_cache_init(void) { }
>  
>  /*
> -- 
> 2.39.2
> 
