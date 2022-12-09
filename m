Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F736648A21
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiLIVgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiLIVgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:36:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC220AC6F9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:36:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C94E9B828ED
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 21:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA23C433F0;
        Fri,  9 Dec 2022 21:36:08 +0000 (UTC)
Date:   Fri, 9 Dec 2022 16:36:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Add pid and comm when RT throttling activated
Message-ID: <20221209163606.53a2370e@gandalf.local.home>
In-Reply-To: <20221206083641.103832-1-yajun.deng@linux.dev>
References: <20221206083641.103832-1-yajun.deng@linux.dev>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Dec 2022 16:36:41 +0800
Yajun Deng <yajun.deng@linux.dev> wrote:

> It is difficult to know which process consumes time when RT throttling
> activated.
> 
> So add pid and comm for this case.
> 

Unfortunately, that only shows the process that "broke the camel's
back"[1]. The things is, it is the amount of time *all* RT tasks use to
trigger throttling. You are only printing the task that the throttling
occurred on.

Try running https://rostedt.org/code/migrate.c . It will create a bunch of
RT tasks, and they all will throttle once it hits 950ms ever second.

  trace-cmd record -e sched_switch ./migrate
  kernelshark

Then plot all the migrate tasks.

The above will demonstrate it very well.

-- Steve


[1] https://en.wikipedia.org/wiki/Straw_that_broke_the_camel%27s_back

> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  kernel/sched/rt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index ed2a47e4ddae..1f267ab1b59a 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1012,6 +1012,7 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
>  
>  	if (rt_rq->rt_time > runtime) {
>  		struct rt_bandwidth *rt_b = sched_rt_bandwidth(rt_rq);
> +		struct task_struct *curr = rq_of_rt_rq(rt_rq)->curr;
>  
>  		/*
>  		 * Don't actually throttle groups that have no runtime assigned
> @@ -1019,7 +1020,8 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
>  		 */
>  		if (likely(rt_b->rt_runtime)) {
>  			rt_rq->rt_throttled = 1;
> -			printk_deferred_once("sched: RT throttling activated\n");
> +			printk_deferred_once("pid: %d, comm: %s, sched: RT throttling activated\n",
> +					     curr->pid, curr->comm);
>  		} else {
>  			/*
>  			 * In case we did anyway, make it go away,

