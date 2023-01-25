Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2490267A757
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjAYAGo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Jan 2023 19:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAYAGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:06:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8D993F7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:06:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C94661301
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4AAC4339B;
        Wed, 25 Jan 2023 00:06:39 +0000 (UTC)
Date:   Tue, 24 Jan 2023 19:06:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anuradha Weeraman <anuradha@debian.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Fix unused-const-variable W=1 warning and
 style issue
Message-ID: <20230124190638.124a1c7a@gandalf.local.home>
In-Reply-To: <20230119162233.887915-1-anuradha@debian.org>
References: <20230119162233.887915-1-anuradha@debian.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 21:52:32 +0530
Anuradha Weeraman <anuradha@debian.org> wrote:

> Compiler warning with W=1 due to unused constant in
>     kernel/sched/rt.c:9:18: warning: ‘max_rt_runtime’ defined but not used
> 
> Fix by wrapping the variable in an #if check for CONFIG_SYSCTL and
> CONFIG_RT_GROUP_SCHED, which are the only blocks where this variable
> is referenced from.
> 
> Also, fix style issue for "else should follow close brace '}'".
> 
> Signed-off-by: Anuradha Weeraman <anuradha@debian.org>
> ---
>  kernel/sched/rt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index ed2a47e4ddae..e46e76893a0c 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -5,8 +5,11 @@
>   */
>  
>  int sched_rr_timeslice = RR_TIMESLICE;
> +
> +#if defined(CONFIG_SYSCTL) || defined(CONFIG_RT_GROUP_SCHED)
>  /* More than 4 hours if BW_SHIFT equals 20. */
>  static const u64 max_rt_runtime = MAX_BW;

As keeping track of which config needs this can get difficult in the
future, why not just make it:

static const u64 __maybe_unused max_rt_runtime = MAX_BW;

?

-- Steve

> +#endif
>  
>  static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
>  
> @@ -604,8 +607,7 @@ static void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
>  		dequeue_top_rt_rq(rt_rq, rt_rq->rt_nr_running);
>  		/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
>  		cpufreq_update_util(rq_of_rt_rq(rt_rq), 0);
> -	}
> -	else if (on_rt_rq(rt_se))
> +	} else if (on_rt_rq(rt_se))
>  		dequeue_rt_entity(rt_se, 0);
>  }
>  

