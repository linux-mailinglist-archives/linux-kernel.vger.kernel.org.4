Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAAE6FE0BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbjEJOr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237585AbjEJOry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:47:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D4691
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L7k9VT6KYuqnlmg9qb4u4oBWC9iTrwFoK42i1G5B6fE=; b=RvOToC8Jd7NGz1YjTlY+Sm8vBB
        n46EPCCVtCmhjiQRapkqiPrR+opiserOmzf+T+402v1q1Oih5aqju7jmNLNvK27Q+/nwzbJpDS92k
        eiGqLF5Aq8CVUlalG8RQBtoApC2vphIKvduv5dKi7LLfcOa0Y/wNuUkqj3Lb9ryYTEO2lqtoY0sbl
        wYZix7B0LsTk0Q3Bbi2yz5ibhtuwCeG4c+On0OLVPIxGgx0Xnua7c9vyC64f4ZOuBhDizwNkrfxG8
        anUgVx8ffz7u888/bUuHYQQBwUtP+KcnpxxSL2MA1gSGjd5JwrXrFsV5oVcX9tj5J1flyxrrM/xja
        r0rqqatA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pwl6D-007Tt7-36;
        Wed, 10 May 2023 14:47:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 80BF6300338;
        Wed, 10 May 2023 16:47:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 61BD5202EECBF; Wed, 10 May 2023 16:47:24 +0200 (CEST)
Date:   Wed, 10 May 2023 16:47:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sched/core: Fixed missing rq clock update before
 calling set_rq_offline()
Message-ID: <20230510144724.GN4253@hirez.programming.kicks-ass.net>
References: <20230510083450.62334-1-jiahao.os@bytedance.com>
 <20230510083450.62334-2-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510083450.62334-2-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 04:34:49PM +0800, Hao Jia wrote:
> This is triggered during cpu offline when CONFIG_CPU_FREQ is enabled:

I'm failing to see the relevance to CPU_FREQ...

> ------------[ cut here ]------------
> rq->clock_update_flags < RQCF_ACT_SKIP
> WARNING: CPU: 24 PID: 754 at kernel/sched/sched.h:1496
> enqueue_top_rt_rq+0x139/0x160
> Call Trace:
>  <TASK>
>  ? intel_pstate_update_util+0x3b0/0x3b0

AFAICT this is __disable_runtime() re-queueing throttled RT tasks

Your unwind is dodgy, what CONFIG_UNWINDER do you have?

>  rq_offline_rt+0x1b7/0x250
>  set_rq_offline.part.120+0x28/0x60
>  rq_attach_root+0xc4/0xd0
>  cpu_attach_domain+0x3dc/0x7f0
>  ? __schedule+0x65e/0x1310
>  partition_sched_domains_locked+0x2a5/0x3c0
>  rebuild_sched_domains_locked+0x477/0x830
>  ? percpu_rwsem_wait+0x140/0x140
>  rebuild_sched_domains+0x1b/0x30
>  cpuset_hotplug_workfn+0x2ca/0xc90
>  ? balance_push+0x56/0x120
>  ? _raw_spin_unlock+0x15/0x30
>  ? finish_task_switch+0x98/0x2f0
>  ? __switch_to+0x116/0x410
>  ? __schedule+0x65e/0x1310 ? internal_add_timer+0x42/0x60
>  ? _raw_spin_unlock_irqrestore+0x23/0x40
>  ? add_timer_on+0xd5/0x130
>  process_one_work+0x1bc/0x3d0
>  worker_thread+0x4c/0x380
>  ? preempt_count_add+0x56/0xa0
>  ? rescuer_thread+0x310/0x310
>  kthread+0xe6/0x110
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x1f/0x30
> 
> Before calling set_rq_offline() we need to update the rq clock to avoid
> using the old rq clock, and use rq_lock_irqsave()/rq_unlock_irqrestore()
> to replace raw_spin_rq_lock_irqsave()/raw_spin_rq_unlock_irqrestore() to
> ensure that rq->clock_update_flags are cleared before updating the rq
> clock.
> 
> Steps to reproduce:
> 1. Enable CONFIG_SMP and CONFIG_CPU_FREQ when compiling the kernel
> 2. echo 1 > /sys/kernel/debug/clear_warn_once
> 3. cpupower -c all frequency-set -g powersave
> 4. Run some rt tasks e.g. Create 5*n rt (100% running) tasks (on a
>    system with n CPUs)
> 5. Offline cpu one by one until the warninng is triggered
> 
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> ---
>  kernel/sched/topology.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 6682535e37c8..b89497696880 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -487,15 +487,17 @@ static void free_rootdomain(struct rcu_head *rcu)
>  void rq_attach_root(struct rq *rq, struct root_domain *rd)
>  {
>  	struct root_domain *old_rd = NULL;
> -	unsigned long flags;
> +	struct rq_flags rf;
>  
> -	raw_spin_rq_lock_irqsave(rq, flags);
> +	rq_lock_irqsave(rq, &rf);
>  
>  	if (rq->rd) {
>  		old_rd = rq->rd;
>  
> -		if (cpumask_test_cpu(rq->cpu, old_rd->online))
> +		if (cpumask_test_cpu(rq->cpu, old_rd->online)) {
> +			update_rq_clock(rq);
>  			set_rq_offline(rq);
> +		}
>  
>  		cpumask_clear_cpu(rq->cpu, old_rd->span);
>  
> @@ -515,7 +517,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
>  	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
>  		set_rq_online(rq);
>  
> -	raw_spin_rq_unlock_irqrestore(rq, flags);
> +	rq_unlock_irqrestore(rq, &rf);
>  
>  	if (old_rd)
>  		call_rcu(&old_rd->rcu, free_rootdomain);

The patch itself is good though; just the Changelog has me
confused.
