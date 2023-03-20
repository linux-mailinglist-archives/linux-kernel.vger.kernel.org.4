Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2B36C0C93
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCTIzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjCTIzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:55:35 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888A6F97A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:55:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x15so1068789pjk.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679302533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etVRjG5VQd5JEo4AAumSaMHCADdqFC9A7g60eMBxkGk=;
        b=Yvbt1ce2ZU/iRTCCRTnc4o5D5ZFrUmPyAis6HQ5TWGBLog0KNK4Tb4X3fd17FF2xTJ
         o4i1bdI1WuNwCW4FBA9ulhhuBd0ZbzYslvlr4w28pmLvIWKIV8bY26M5f4kQ3hWsJIgB
         WzaEFeTjFOlGzdE+debD6AuaQgd+eaOKd7IV44uz/4q9wcgzcttOAwIINewA2Prvw+T2
         toU1MvngNg6rDh23R7nBJJEDnEdS7OEpgeBQsQDpJeTAk1Tf49BCLNNiiS0SUwUGWWfg
         M05Ve1N+q7hpKOjqUYE+9p80i47E8daQtLUmzAqb/uXddjuvT1RVLnGQsyluBkvEez5o
         nZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679302533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=etVRjG5VQd5JEo4AAumSaMHCADdqFC9A7g60eMBxkGk=;
        b=UIr5DNWlwpV9GY4vMvn2MrIQNCec7geuDQ4w9puwLVde9WD9zycZcOMtEdDQPfMJoH
         mL1GP4TJPgn1nDJ1oBE/NabTt301QKLubwz8KxapxZr6urojZDoI4kjN9fbJRHnLn9d3
         kxxJuLQ2t1r5uYDIAV6nN9+DJAT1Zutp7yvtsxyXu6MygmsfFyXXrrfdeOGgNKBDduaQ
         3WUPzKY6U9Wu9kld0xUt2EBJgPazMb67gdCr2WFJXBik26uZQ80y+7xmcM58ONLDkX1d
         18pr40g4c7Qah34Xjlic7y8Yzai2ciLQlZ7n2jnJcsEzmQRms7vnLMs5/f+yyotnYd9R
         5Xlg==
X-Gm-Message-State: AO0yUKXYz7iDpLiaYS63ulPy4k1MOms1TCtF8vMwJLC8K3gNXzdpvBW9
        dFSFe+Nvb3FbLQg8q36wJ9LakA==
X-Google-Smtp-Source: AK7set+C/oDQm4dY/QkJT2G1hreLYy1/MKeuAR4dixIREuei1yGUPBJRN/CcmAGVxSkAsFLXhWl9Jw==
X-Received: by 2002:a05:6a20:3aa9:b0:d6:847d:c7af with SMTP id d41-20020a056a203aa900b000d6847dc7afmr12733980pzh.16.1679302532809;
        Mon, 20 Mar 2023 01:55:32 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id l2-20020a62be02000000b0062549352d1esm5803702pff.162.2023.03.20.01.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 01:55:32 -0700 (PDT)
Message-ID: <4972a8be-d300-a66e-7fac-a83f11b56fbf@bytedance.com>
Date:   Mon, 20 Mar 2023 16:55:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] sched/core: Minor optimize pick_next_task() when
 core-sched enable
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>,
        joel@joelfernandes.org
References: <20230308100414.37114-1-jiahao.os@bytedance.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20230308100414.37114-1-jiahao.os@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kindly ping...

On 2023/3/8 Hao Jia wrote:
> If core-sched is enabled, sometimes we will traverse each CPU on the core
> to find the highest priority task 'max' on the entire core, and then try
> and find a runnable task that matches @max.
> But in the following case, we choose the runnable task is not the best.
> 
> core max: task2 (cookie 0)
> 
> 	rq0				rq1
> task0(cookie non-zero)		task2(cookie 0)
> task1(cookie 0)
> task3(cookie 0)
> ...
> 
> pick-task: idle			pick-task: task2
> 
> CPU0 and CPU1 are two CPUs on the same core, task0 and task2 are the
> highest priority tasks on rq0 and rq1 respectively, task2 is @max
> on the entire core.
> 
> In the case that 'max' has a zero cookie, instead of continuing to
> search for a runnable task on rq0 that matches @max's cookie, we
> choose idle for rq0 directly.
> At this time, it is obviously better to choose task1 to run for rq0,
> which will increase the CPU utilization.
> Therefore, we queue tasks with zero cookies in core_tree, and record
> the number of non-zero cookie tasks of each rq to detect the status
> of the sched-core.
> 
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> ---
>   kernel/sched/core.c       | 29 +++++++++++++++--------------
>   kernel/sched/core_sched.c |  9 ++++-----
>   kernel/sched/sched.h      |  1 +
>   3 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index af017e038b48..765cd14c52e1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -236,8 +236,8 @@ void sched_core_enqueue(struct rq *rq, struct task_struct *p)
>   {
>   	rq->core->core_task_seq++;
>   
> -	if (!p->core_cookie)
> -		return;
> +	if (p->core_cookie)
> +		rq->cookied_count++;
>   
>   	rb_add(&p->core_node, &rq->core_tree, rb_sched_core_less);
>   }
> @@ -246,11 +246,16 @@ void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
>   {
>   	rq->core->core_task_seq++;
>   
> +	if (p->core_cookie)
> +		rq->cookied_count--;
> +
>   	if (sched_core_enqueued(p)) {
>   		rb_erase(&p->core_node, &rq->core_tree);
>   		RB_CLEAR_NODE(&p->core_node);
>   	}
>   
> +	if (!sched_core_enabled(rq))
> +		return;
>   	/*
>   	 * Migrating the last task off the cpu, with the cpu in forced idle
>   	 * state. Reschedule to create an accounting edge for forced idle,
> @@ -370,7 +375,7 @@ static void sched_core_assert_empty(void)
>   	int cpu;
>   
>   	for_each_possible_cpu(cpu)
> -		WARN_ON_ONCE(!RB_EMPTY_ROOT(&cpu_rq(cpu)->core_tree));
> +		WARN_ON_ONCE(cpu_rq(cpu)->cookied_count);
>   }
>   
>   static void __sched_core_enable(void)
> @@ -2061,14 +2066,12 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>   	uclamp_rq_inc(rq, p);
>   	p->sched_class->enqueue_task(rq, p, flags);
>   
> -	if (sched_core_enabled(rq))
> -		sched_core_enqueue(rq, p);
> +	sched_core_enqueue(rq, p);
>   }
>   
>   static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>   {
> -	if (sched_core_enabled(rq))
> -		sched_core_dequeue(rq, p, flags);
> +	sched_core_dequeue(rq, p, flags);
>   
>   	if (!(flags & DEQUEUE_NOCLOCK))
>   		update_rq_clock(rq);
> @@ -6126,13 +6129,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>   		rq_i = cpu_rq(i);
>   		p = rq_i->core_pick;
>   
> -		if (!cookie_equals(p, cookie)) {
> -			p = NULL;
> -			if (cookie)
> -				p = sched_core_find(rq_i, cookie);
> -			if (!p)
> -				p = idle_sched_class.pick_task(rq_i);
> -		}
> +		if (!cookie_equals(p, cookie))
> +			p = sched_core_find(rq_i, cookie);
>   
>   		rq_i->core_pick = p;
>   
> @@ -6333,6 +6331,7 @@ static void sched_core_cpu_starting(unsigned int cpu)
>   	sched_core_lock(cpu, &flags);
>   
>   	WARN_ON_ONCE(rq->core != rq);
> +	WARN_ON_ONCE(rq->cookied_count);
>   
>   	/* if we're the first, we'll be our own leader */
>   	if (cpumask_weight(smt_mask) == 1)
> @@ -6425,6 +6424,7 @@ static inline void sched_core_cpu_dying(unsigned int cpu)
>   {
>   	struct rq *rq = cpu_rq(cpu);
>   
> +	WARN_ON_ONCE(rq->cookied_count);
>   	if (rq->core != rq)
>   		rq->core = rq;
>   }
> @@ -9917,6 +9917,7 @@ void __init sched_init(void)
>   		rq->core = rq;
>   		rq->core_pick = NULL;
>   		rq->core_enabled = 0;
> +		rq->cookied_count = 0;
>   		rq->core_tree = RB_ROOT;
>   		rq->core_forceidle_count = 0;
>   		rq->core_forceidle_occupation = 0;
> diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
> index a57fd8f27498..70f424abcc2b 100644
> --- a/kernel/sched/core_sched.c
> +++ b/kernel/sched/core_sched.c
> @@ -56,6 +56,7 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
>   	unsigned long old_cookie;
>   	struct rq_flags rf;
>   	struct rq *rq;
> +	bool enqueued;
>   
>   	rq = task_rq_lock(p, &rf);
>   
> @@ -67,16 +68,14 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
>   	 */
>   	SCHED_WARN_ON((p->core_cookie || cookie) && !sched_core_enabled(rq));
>   
> -	if (sched_core_enqueued(p))
> +	enqueued = task_on_rq_queued(p);
> +	if (enqueued)
>   		sched_core_dequeue(rq, p, DEQUEUE_SAVE);
>   
>   	old_cookie = p->core_cookie;
>   	p->core_cookie = cookie;
>   
> -	/*
> -	 * Consider the cases: !prev_cookie and !cookie.
> -	 */
> -	if (cookie && task_on_rq_queued(p))
> +	if (enqueued)
>   		sched_core_enqueue(rq, p);
>   
>   	/*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3e8df6d31c1e..f5a0ee7fccae 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1148,6 +1148,7 @@ struct rq {
>   	unsigned int		core_task_seq;
>   	unsigned int		core_pick_seq;
>   	unsigned long		core_cookie;
> +	unsigned int		cookied_count;
>   	unsigned int		core_forceidle_count;
>   	unsigned int		core_forceidle_seq;
>   	unsigned int		core_forceidle_occupation;
