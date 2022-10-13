Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D6E5FE308
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiJMUAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJMUAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:00:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5A34DF0F;
        Thu, 13 Oct 2022 13:00:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBEB2B82026;
        Thu, 13 Oct 2022 20:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627D8C433C1;
        Thu, 13 Oct 2022 20:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665691203;
        bh=lT0xCcs8gPxn4mJZ8eC38qELd8nIUAX3/Iu/+Z8ntUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TzodfSjWq/+9Bifv5u45YZFRR2G6PjG4XW1GyGJS4w87dw/1tQmO5YCputmrmAP/n
         vXCSJ2mpCreCBTlFmDdP2lNj+MxzixOmhKa5F80QP7pL0RDRbxQkapvOu8mSz9Tjif
         LrLSoSMXpYI0BkA4tvs7kWFq3QCmCwFj+FVnhnFyN7NYG1sRF4lE4JTfMzYMBydVke
         OMZfDKU7isbX9YKkNB0WeYMeF+mGK2JZLtz2xIcQQ3v9TtBi8r+y/oFbFg2LIXSYkr
         MhLfKZVDg8+EzxjFDnZRN8CXL4Pc0z3htMWpOtwuWupOUgGWSSeaPSsw957NcPuwfb
         XJZTNJO02h58A==
Date:   Thu, 13 Oct 2022 13:00:00 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sched: Introduce struct balance_callback to avoid CFI
 mismatches
Message-ID: <Y0huQNtO8bA2j98Y@dev-arch.thelio-3990X>
References: <20221008000758.2957718-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221008000758.2957718-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 05:07:58PM -0700, Kees Cook wrote:
> Introduce distinct struct balance_callback instead of performing function
> pointer casting which will trip CFI. Avoids warnings as found by Clang's
> future -Wcast-function-type-strict option:
> 
> In file included from kernel/sched/core.c:84:
> kernel/sched/sched.h:1755:15: warning: cast from 'void (*)(struct rq *)' to 'void (*)(struct callback_head *)' converts to incompatible function type [-Wcast-function-type-strict]
>         head->func = (void (*)(struct callback_head *))func;
>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> No binary differences result from this change.
> 
> This patch is a cleanup based on Brad Spengler/PaX Team's modifications
> to sched code in their last public patch of grsecurity/PaX based on my
> understanding of the code. Changes or omissions from the original code
> are mine and don't reflect the original grsecurity/PaX code.
> 
> Reported-by: Sami Tolvanen <samitolvanen@google.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1724
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  kernel/sched/core.c     | 24 ++++++++++++------------
>  kernel/sched/deadline.c |  4 ++--
>  kernel/sched/rt.c       |  4 ++--
>  kernel/sched/sched.h    | 14 ++++++++++----
>  4 files changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ee28253c9ac0..911db628092e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4815,10 +4815,10 @@ static inline void finish_task(struct task_struct *prev)
>  
>  #ifdef CONFIG_SMP
>  
> -static void do_balance_callbacks(struct rq *rq, struct callback_head *head)
> +static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
>  {
>  	void (*func)(struct rq *rq);
> -	struct callback_head *next;
> +	struct balance_callback *next;
>  
>  	lockdep_assert_rq_held(rq);
>  
> @@ -4845,15 +4845,15 @@ static void balance_push(struct rq *rq);
>   * This abuse is tolerated because it places all the unlikely/odd cases behind
>   * a single test, namely: rq->balance_callback == NULL.
>   */
> -struct callback_head balance_push_callback = {
> +struct balance_callback balance_push_callback = {
>  	.next = NULL,
> -	.func = (void (*)(struct callback_head *))balance_push,
> +	.func = balance_push,
>  };
>  
> -static inline struct callback_head *
> +static inline struct balance_callback *
>  __splice_balance_callbacks(struct rq *rq, bool split)
>  {
> -	struct callback_head *head = rq->balance_callback;
> +	struct balance_callback *head = rq->balance_callback;
>  
>  	if (likely(!head))
>  		return NULL;
> @@ -4875,7 +4875,7 @@ __splice_balance_callbacks(struct rq *rq, bool split)
>  	return head;
>  }
>  
> -static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
> +static inline struct balance_callback *splice_balance_callbacks(struct rq *rq)
>  {
>  	return __splice_balance_callbacks(rq, true);
>  }
> @@ -4885,7 +4885,7 @@ static void __balance_callbacks(struct rq *rq)
>  	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
>  }
>  
> -static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
> +static inline void balance_callbacks(struct rq *rq, struct balance_callback *head)
>  {
>  	unsigned long flags;
>  
> @@ -4902,12 +4902,12 @@ static inline void __balance_callbacks(struct rq *rq)
>  {
>  }
>  
> -static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
> +static inline struct balance_callback *splice_balance_callbacks(struct rq *rq)
>  {
>  	return NULL;
>  }
>  
> -static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
> +static inline void balance_callbacks(struct rq *rq, struct balance_callback *head)
>  {
>  }
>  
> @@ -6179,7 +6179,7 @@ static void sched_core_balance(struct rq *rq)
>  	preempt_enable();
>  }
>  
> -static DEFINE_PER_CPU(struct callback_head, core_balance_head);
> +static DEFINE_PER_CPU(struct balance_callback, core_balance_head);
>  
>  static void queue_core_balance(struct rq *rq)
>  {
> @@ -7410,7 +7410,7 @@ static int __sched_setscheduler(struct task_struct *p,
>  	int oldpolicy = -1, policy = attr->sched_policy;
>  	int retval, oldprio, newprio, queued, running;
>  	const struct sched_class *prev_class;
> -	struct callback_head *head;
> +	struct balance_callback *head;
>  	struct rq_flags rf;
>  	int reset_on_fork;
>  	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 0ab79d819a0d..6498951b7d41 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -644,8 +644,8 @@ static inline bool need_pull_dl_task(struct rq *rq, struct task_struct *prev)
>  	return rq->online && dl_task(prev);
>  }
>  
> -static DEFINE_PER_CPU(struct callback_head, dl_push_head);
> -static DEFINE_PER_CPU(struct callback_head, dl_pull_head);
> +static DEFINE_PER_CPU(struct balance_callback, dl_push_head);
> +static DEFINE_PER_CPU(struct balance_callback, dl_pull_head);
>  
>  static void push_dl_tasks(struct rq *);
>  static void pull_dl_task(struct rq *);
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 55f39c8f4203..ad020a2a72f3 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -410,8 +410,8 @@ static inline int has_pushable_tasks(struct rq *rq)
>  	return !plist_head_empty(&rq->rt.pushable_tasks);
>  }
>  
> -static DEFINE_PER_CPU(struct callback_head, rt_push_head);
> -static DEFINE_PER_CPU(struct callback_head, rt_pull_head);
> +static DEFINE_PER_CPU(struct balance_callback, rt_push_head);
> +static DEFINE_PER_CPU(struct balance_callback, rt_pull_head);
>  
>  static void push_rt_tasks(struct rq *);
>  static void pull_rt_task(struct rq *);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e26688d387ae..54971a57a4ea 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -953,6 +953,12 @@ struct uclamp_rq {
>  DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
>  #endif /* CONFIG_UCLAMP_TASK */
>  
> +struct rq;
> +struct balance_callback {
> +	struct balance_callback *next;
> +	void (*func)(struct rq *rq);
> +};
> +
>  /*
>   * This is the main, per-CPU runqueue data structure.
>   *
> @@ -1051,7 +1057,7 @@ struct rq {
>  	unsigned long		cpu_capacity;
>  	unsigned long		cpu_capacity_orig;
>  
> -	struct callback_head	*balance_callback;
> +	struct balance_callback *balance_callback;
>  
>  	unsigned char		nohz_idle_balance;
>  	unsigned char		idle_balance;
> @@ -1559,7 +1565,7 @@ struct rq_flags {
>  #endif
>  };
>  
> -extern struct callback_head balance_push_callback;
> +extern struct balance_callback balance_push_callback;
>  
>  /*
>   * Lockdep annotation that avoids accidental unlocks; it's like a
> @@ -1739,7 +1745,7 @@ init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
>  
>  static inline void
>  queue_balance_callback(struct rq *rq,
> -		       struct callback_head *head,
> +		       struct balance_callback *head,
>  		       void (*func)(struct rq *rq))
>  {
>  	lockdep_assert_rq_held(rq);
> @@ -1752,7 +1758,7 @@ queue_balance_callback(struct rq *rq,
>  	if (unlikely(head->next || rq->balance_callback == &balance_push_callback))
>  		return;
>  
> -	head->func = (void (*)(struct callback_head *))func;
> +	head->func = func;
>  	head->next = rq->balance_callback;
>  	rq->balance_callback = head;
>  }
> -- 
> 2.34.1
> 
