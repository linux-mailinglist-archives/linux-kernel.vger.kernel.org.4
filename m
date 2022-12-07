Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF02D645F90
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLGRA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLGRAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:00:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C5496723B;
        Wed,  7 Dec 2022 09:00:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36A5D23A;
        Wed,  7 Dec 2022 09:00:58 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A349F3F73B;
        Wed,  7 Dec 2022 09:00:48 -0800 (PST)
Message-ID: <71a0f27d-68e0-f118-c117-bae48f5f1996@arm.com>
Date:   Wed, 7 Dec 2022 18:00:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 06/22] sched/fair: Collect load-balancing stats for IPC
 classes
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
 <20221128132100.30253-7-ricardo.neri-calderon@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20221128132100.30253-7-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 14:20, Ricardo Neri wrote:

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 224107278471..3a1d6c50a19b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9100,6 +9100,57 @@ group_type group_classify(unsigned int imbalance_pct,
>  	return group_has_spare;
>  }
>  
> +struct sg_lb_ipcc_stats {
> +	int min_score;	/* Min(score(rq->curr->ipcc)) */
> +	int min_ipcc;	/* Min(rq->curr->ipcc) */
> +	long sum_score; /* Sum(score(rq->curr->ipcc)) */
> +};

Wouldn't it be cleaner to put `min_score`, `min_ipcc` and `sum_score`
into `struct sg_lb_stats` next to `ipcc_score_{after, before}` under the
same #ifdef CONFIG_IPC_CLASSES?

Looks like those IPCC stats would only be needed in the specific
condition under which update_sg_lb_stats_scores() is called?

> +#ifdef CONFIG_IPC_CLASSES
> +static void init_rq_ipcc_stats(struct sg_lb_ipcc_stats *sgcs)
> +{
> +	*sgcs = (struct sg_lb_ipcc_stats) {
> +		.min_score = INT_MAX,
> +	};
> +}
> +
> +/** Called only if cpu_of(@rq) is not idle and has tasks running. */
> +static void update_sg_lb_ipcc_stats(struct sg_lb_ipcc_stats *sgcs,
> +				    struct rq *rq)
> +{
> +	struct task_struct *curr;
> +	unsigned short ipcc;
> +	int score;
> +
> +	if (!sched_ipcc_enabled())
> +		return;
> +
> +	curr = rcu_dereference(rq->curr);
> +	if (!curr || (curr->flags & PF_EXITING) || is_idle_task(curr))

So the Idle task is excluded but RT, DL, (Stopper) tasks are not. Looks
weird if non-CFS tasks could influence CFS load-balancing.
AFAICS, RT and DL tasks could have p->ipcc != IPC_CLASS_UNCLASSIFIED?

[...]
