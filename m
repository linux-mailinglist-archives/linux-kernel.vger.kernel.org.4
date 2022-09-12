Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4775B568A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiILIqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiILIqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:46:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C9052A70D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:46:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2645F113E;
        Mon, 12 Sep 2022 01:46:35 -0700 (PDT)
Received: from [172.16.16.241] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EFB33F73D;
        Mon, 12 Sep 2022 01:46:26 -0700 (PDT)
Message-ID: <1138228c-f26a-d968-4c92-9ea9c8c85c6f@arm.com>
Date:   Mon, 12 Sep 2022 10:46:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/4] sched/fair: move call to list_last_entry() in
 detach_tasks
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc:     zhangqiao22@huawei.com
References: <20220825122726.20819-1-vincent.guittot@linaro.org>
 <20220825122726.20819-4-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220825122726.20819-4-vincent.guittot@linaro.org>
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

s/sched/fair: move/sched/fair: Move
s/detach_tasks/detach_tasks()

> Move the call to list_last_entry() in detach_tasks() after testing
> loop_max and loop_break.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6972a1a29a48..260a55ac462f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8047,8 +8047,6 @@ static int detach_tasks(struct lb_env *env)
>  		if (env->idle != CPU_NOT_IDLE && env->src_rq->nr_running <= 1)
>  			break;
>  
> -		p = list_last_entry(tasks, struct task_struct, se.group_node);
> -
>  		env->loop++;
>  		/*
>  		 * We've more or less seen every task there is, call it quits
> @@ -8065,6 +8063,8 @@ static int detach_tasks(struct lb_env *env)
>  			break;
>  		}
>  
> +		p = list_last_entry(tasks, struct task_struct, se.group_node);
> +
>  		if (!can_migrate_task(p, env))
>  			goto next;
>  

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
