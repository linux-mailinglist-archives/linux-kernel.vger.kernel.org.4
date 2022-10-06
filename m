Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7465F653F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJFLfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJFLfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:35:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 424AB2182E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 04:35:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 145501042;
        Thu,  6 Oct 2022 04:35:08 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C26163F73B;
        Thu,  6 Oct 2022 04:34:59 -0700 (PDT)
Message-ID: <5c65740d-6f10-f8c5-94a9-a1af631f0c07@arm.com>
Date:   Thu, 6 Oct 2022 13:34:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] sched/fair: limit sched slice duration
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc:     zhangqiao22@huawei.com
References: <20221003122111.611-1-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20221003122111.611-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2022 14:21, Vincent Guittot wrote:
> In presence of a lot of small weight tasks like sched_idle tasks, normal
> or high weight tasks can see their ideal runtime (sched_slice) to increase
> to hundreds ms whereas it normally stays below sysctl_sched_latency.
> 
> 2 normal tasks running on a CPU will have a max sched_slice of 12ms
> (half of the sched_period). This means that they will make progress
> every sysctl_sched_latency period.
> 
> If we now add 1000 idle tasks on the CPU, the sched_period becomes
> 3006 ms and the ideal runtime of the normal tasks becomes 609 ms.
> It will even become 1500ms if the idle tasks belongs to an idle cgroup.
> This means that the scheduler will look for picking another waiting task
> after 609ms running time (1500ms respectively). The idle tasks change
> significantly the way the 2 normal tasks interleave their running time
> slot whereas they should have a small impact.
> 
> Such long sched_slice can delay significantly the release of resources
> as the tasks can wait hundreds of ms before the next running slot just
> because of idle tasks queued on the rq.
> 
> Cap the ideal_runtime to sysctl_sched_latency to make sure that tasks will
> regularly make progress and will not be significantly impacted by
> idle/background tasks queued on the rq.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> Change since v2:
> - Cap ideal_runtime from the beg as suggested by Peter
> 
>  kernel/sched/fair.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5ffec4370602..c309d57efb2c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4584,7 +4584,13 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  	struct sched_entity *se;
>  	s64 delta;
>  
> -	ideal_runtime = sched_slice(cfs_rq, curr);
> +	/*
> +	 * When many tasks blow up the sched_period; it is possible that
> +	 * sched_slice() reports unusually large results (when many tasks are
> +	 * very light for example). Therefore impose a maximum.
> +	 */
> +	ideal_runtime = min_t(u64, sched_slice(cfs_rq, curr), sysctl_sched_latency);
> +
>  	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
>  	if (delta_exec > ideal_runtime) {
>  		resched_curr(rq_of(cfs_rq));

Tested on 6 CPU system (sysctl_sched_latency=18ms,
sysctl_sched_min_granularity=2.25ms)

I start to see `slice > period` when I run:

(a) > ~50 idle tasks in '/' for an arbitrary nice=0 task

(b) > ~50 nice=0 tasks in '/A' w/ cpu.shares = max for se of '/A'

Essentially in moments in which cfs_rq->nr_running > sched_nr_latency
and se_weight is relatively high compared to cfs_rq_weight.

Tested-By: Dietmar Eggemann <dietmar.eggemann@arm.com>
