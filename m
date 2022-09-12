Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEE45B5683
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiILIok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiILIoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:44:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B988B6385
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:44:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9AC2113E;
        Mon, 12 Sep 2022 01:44:40 -0700 (PDT)
Received: from [172.16.16.241] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEF523F73D;
        Mon, 12 Sep 2022 01:44:32 -0700 (PDT)
Message-ID: <b85e608f-7293-9588-5e85-36b62f1fdbeb@arm.com>
Date:   Mon, 12 Sep 2022 10:44:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/4] sched/fair: make sure to try to detach at least one
 movable task
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc:     zhangqiao22@huawei.com
References: <20220825122726.20819-1-vincent.guittot@linaro.org>
 <20220825122726.20819-2-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220825122726.20819-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2022 14:27, Vincent Guittot wrote:

s/sched/fair: make/sched/fair: Make

> During load balance, we try at most env->loop_max time to move a task.
> But it can happen that the loop_max LRU tasks (ie tail of
> the cfs_tasks list) can't be moved to dst_cpu because of affinity.
> In this case, loop in the list until we found at least one.
> 
> The maximum of detached tasks remained the same as before.

Not sure how this relates to the patch? Isn't this given by the
`env->imbalance <= 0` check at the end of detach_tasks()?

> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index da388657d5ac..02b7b808e186 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8052,8 +8052,12 @@ static int detach_tasks(struct lb_env *env)
>  		p = list_last_entry(tasks, struct task_struct, se.group_node);
>  
>  		env->loop++;
> -		/* We've more or less seen every task there is, call it quits */
> -		if (env->loop > env->loop_max)
> +		/*
> +		 * We've more or less seen every task there is, call it quits

I never understood this `more or less`. Either we have seen all tasks or
not?

> +		 * unless we haven't found any movable task yet.
> +		 */
> +		if (env->loop > env->loop_max &&
> +		    !(env->flags & LBF_ALL_PINNED))
>  			break;
>  
>  		/* take a breather every nr_migrate tasks */
> @@ -10182,7 +10186,9 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  
>  		if (env.flags & LBF_NEED_BREAK) {
>  			env.flags &= ~LBF_NEED_BREAK;
> -			goto more_balance;
> +			/* Stop if we tried all running tasks */

Would say s/running/runnable but I see that we do use running/runnable
interchangeably.

> +			if (env.loop < busiest->nr_running)
> +				goto more_balance;
>  		}
>  
>  		/*

IMHO, there will be some interaction with the `All tasks on this
runqueue were pinned by CPU affinity` check at the end of load_balance()?
