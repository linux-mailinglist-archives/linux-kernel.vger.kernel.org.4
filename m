Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981DB6C764A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCXDhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCXDhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:37:32 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6452D12D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 20:37:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VeWDNUT_1679629046;
Received: from 30.97.48.251(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0VeWDNUT_1679629046)
          by smtp.aliyun-inc.com;
          Fri, 24 Mar 2023 11:37:27 +0800
Message-ID: <ab6e95da-2e17-5b17-9e3c-ba71aa951da0@linux.alibaba.com>
Date:   Fri, 24 Mar 2023 11:37:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] sched: push force idled core_pick task to another cpu
From:   cruzzhao <cruzzhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <1678106502-58189-1-git-send-email-CruzZhao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <1678106502-58189-1-git-send-email-CruzZhao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...
As core pick task is the max priority task, if it's forced
idle, it's better to find a suitable and idle cpu to run
rather than waiting for other cpus to steal. BTW, there's
no chance for uncookie'd tasks to be stolen.

Consider the following scenario:
Task A is cookie'd a, task B1 and B2 are cookie'd b.
A and B1 are running on core1, and B2 is running on core2
with sibling idle.
There's no chance for B1 to migrate to ht1 of B2 immidiately,
and will cause a lot of force idle.

	core1				core2
ht0		ht1		ht0		ht1
A		force idle	B2		real idle
force idle	B1		B2		real idle
A		force idle	B2		real idle
force idle	B1		B2		real idle

After applying this patch, B1 will be pushed immidiately, and
force idle will decrase.

在 2023/3/6 下午8:41, Cruz Zhao 写道:
> When a task with the max priority of its rq is force
> idled because of unmatched cookie, we'd better to find
> a suitable cpu for it to run as soon as possible, which
> is idle and cookie matched. In order to achieve this
> goal, we push the task in sched_core_balance(), after
> steal_cookie_task().
> 
> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> ---
>  kernel/sched/core.c  | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  kernel/sched/sched.h |  1 +
>  2 files changed, 72 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a3f5147..2a2005a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -246,6 +246,8 @@ void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
>  {
>  	rq->core->core_task_seq++;
>  
> +	if (p == rq->force_idled_core_pick)
> +		rq->force_idled_core_pick = NULL;
>  	if (sched_core_enqueued(p)) {
>  		rb_erase(&p->core_node, &rq->core_tree);
>  		RB_CLEAR_NODE(&p->core_node);
> @@ -346,9 +348,10 @@ static void __sched_core_flip(bool enabled)
>  
>  		sched_core_lock(cpu, &flags);
>  
> -		for_each_cpu(t, smt_mask)
> +		for_each_cpu(t, smt_mask) {
>  			cpu_rq(t)->core_enabled = enabled;
> -
> +			cpu_rq(t)->force_idled_core_pick = NULL;
> +		}
>  		cpu_rq(cpu)->core->core_forceidle_start = 0;
>  
>  		sched_core_unlock(cpu, &flags);
> @@ -6085,6 +6088,7 @@ static inline struct task_struct *pick_task(struct rq *rq)
>  		next = pick_task(rq);
>  		if (!next->core_cookie) {
>  			rq->core_pick = NULL;
> +			rq->force_idled_core_pick = NULL;
>  			/*
>  			 * For robustness, update the min_vruntime_fi for
>  			 * unconstrained picks as well.
> @@ -6135,6 +6139,8 @@ static inline struct task_struct *pick_task(struct rq *rq)
>  				p = idle_sched_class.pick_task(rq_i);
>  		}
>  
> +		if (p != rq_i->core_pick)
> +			rq_i->force_idled_core_pick = rq_i->core_pick;
>  		rq_i->core_pick = p;
>  
>  		if (p == rq_i->idle) {
> @@ -6288,10 +6294,61 @@ static bool steal_cookie_task(int cpu, struct sched_domain *sd)
>  	return false;
>  }
>  
> +static bool try_push_unmatch_task(struct task_struct *p, int this, int that)
> +{
> +	struct rq *src = cpu_rq(this), *dst = cpu_rq(that);
> +	bool success = false;
> +
> +	local_irq_disable();
> +	double_rq_lock(src, dst);
> +	if (!available_idle_cpu(that))
> +		goto unlock;
> +	if (!cpumask_test_cpu(that, &p->cpus_mask))
> +		goto unlock;
> +	if (!sched_cpu_cookie_match(dst, p))
> +		goto unlock;
> +	if (p->core_occupation > dst->idle->core_occupation)
> +		goto unlock;
> +
> +	deactivate_task(src, p, 0);
> +	set_task_cpu(p, that);
> +	src->force_idled_core_pick = NULL;
> +	activate_task(dst, p, 0);
> +
> +	resched_curr(dst);
> +
> +	success = true;
> +unlock:
> +	double_rq_unlock(src, dst);
> +	local_irq_enable();
> +
> +	return success;
> +}
> +
> +static bool push_unmatch_task(struct task_struct *p, int cpu, struct sched_domain *sd)
> +{
> +	int i;
> +	struct cpumask mask;
> +
> +	cpumask_and(&mask, sched_domain_span(sd), &p->cpus_mask);
> +	for_each_cpu_wrap(i, &mask, cpu) {
> +		if (i == cpu)
> +			continue;
> +
> +		if (need_resched())
> +			break;
> +
> +		if (try_push_unmatch_task(p, cpu, i))
> +			return true;
> +	}
> +	return false;
> +}
> +
>  static void sched_core_balance(struct rq *rq)
>  {
>  	struct sched_domain *sd;
>  	int cpu = cpu_of(rq);
> +	struct task_struct *p;
>  
>  	preempt_disable();
>  	rcu_read_lock();
> @@ -6303,6 +6360,18 @@ static void sched_core_balance(struct rq *rq)
>  		if (steal_cookie_task(cpu, sd))
>  			break;
>  	}
> +
> +	p = rq->force_idled_core_pick;	
> +	if (!p || p == rq->idle)
> +		goto unlock;
> +	for_each_domain(cpu, sd) {
> +		if (need_resched())
> +			break;
> +
> +		if (push_unmatch_task(p, cpu, sd))
> +			break;
> +	}
> +unlock:
>  	raw_spin_rq_lock_irq(rq);
>  	rcu_read_unlock();
>  	preempt_enable();
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3e8df6d..f9e7988 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1140,6 +1140,7 @@ struct rq {
>  	/* per rq */
>  	struct rq		*core;
>  	struct task_struct	*core_pick;
> +	struct task_struct	*force_idled_core_pick;
>  	unsigned int		core_enabled;
>  	unsigned int		core_sched_seq;
>  	struct rb_root		core_tree;
