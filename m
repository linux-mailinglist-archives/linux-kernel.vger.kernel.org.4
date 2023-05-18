Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1834708A94
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjERVaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjERVag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:30:36 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1CA10CE
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:30:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2533d3acd5fso2382275a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684445345; x=1687037345;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gUs0af9C73jq+Y86TfHOZGrFqYnwI0Eo33zojlWwKOI=;
        b=hvJNTLOHrqPiY+ZGpOSV8JM1hojmzY6py4YEROc1UlmEvwbdV1cIwEaj4L3ctHfZ/+
         inW19FBmpn0MNF4LQpOH6g+g2Mbg6FVccDTHMq2muTywrviUIjTZppPWS2iPghzNwwJ6
         7AH609jOggWyqQybZIqyVl59UP+Qqvg6uVbeML82ycSmAUKj3boZrnzqkXoWZ6lTV6A9
         rGEE9DP3g9AIdg9Cgf4aS8GQoArvL4krHO58YHXnUdGbEwdORwhuU/y13eAMbStiysrB
         sH0f+5mxG+F1g0vONXCsy28OSCYGKZ7EvRZCN4XiNA0yyqKFiWCwFHLt8THvV2dol6pe
         YXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684445345; x=1687037345;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUs0af9C73jq+Y86TfHOZGrFqYnwI0Eo33zojlWwKOI=;
        b=Jl35X49BSuXUhiSx+/rm1hfTIW+zgHFWwU9b95tTm4Weq1wa5m9fD7OvZUd8AYrm5M
         R0+PCflnkpwFmCUtOrLV1IZ5QJ8DEsWZrAbOtF6AMlKyZn8wygGfNmUfJAmTKDio2PU1
         dnDdQm+WrVx7VxD2f8fMZYhx451JlXanc9Hky4diDrw5U0G/0gtmknNO+LrpjfQi2Weh
         Z2cJSIsdSMA/1yY1DUGdU6YGFL+C8YImr6FgQM/fK9CD4LtvkSrD0QT8/tNfZcXqRjzR
         PlprBVEbeqc48uxi3lv5cwRwrZRaR6+xtR8ZCW1xzgvKuVJoxA7E+JjSEeDA4p++qpyR
         oX3A==
X-Gm-Message-State: AC+VfDwnvKiFJPtx2wSWNpRohgerkuYkhN9bfNQKzNj+aI6k1W1vPg5y
        SCQHs16ZJZ4HDzROPZBOCopsyg==
X-Google-Smtp-Source: ACHHUZ70NvNdvic4h50guzeE/gFEQ3csxu6pNOndpJjtA/5hsplIN53N4/LXS58BvVXtcJ3aJ+aDzA==
X-Received: by 2002:a17:90a:2946:b0:247:eae:1787 with SMTP id x6-20020a17090a294600b002470eae1787mr4122751pjf.36.1684445345380;
        Thu, 18 May 2023 14:29:05 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id kw4-20020a17090b220400b002532d74fb59sm135843pjb.22.2023.05.18.14.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 14:29:05 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH RESEND] sched/nohz: Add HRTICK_BW for using cfs
 bandwidth with nohz_full
References: <20230518132038.3534728-1-pauld@redhat.com>
Date:   Thu, 18 May 2023 14:29:04 -0700
In-Reply-To: <20230518132038.3534728-1-pauld@redhat.com> (Phil Auld's message
        of "Thu, 18 May 2023 09:20:38 -0400")
Message-ID: <xm26353twcpr.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Auld <pauld@redhat.com> writes:

> CFS bandwidth limits and NOHZ full don't play well together.  Tasks
> can easily run well past their quotas before a remote tick does
> accounting.  This leads to long, multi-period stalls before such
> tasks can run again.  Use the hrtick mechanism to set a sched
> tick to fire at remaining_runtime in the future if we are on
> a nohz full cpu, if the task has quota and if we are likely to
> disable the tick (nr_running == 1).  This allows for bandwidth
> accounting before tasks go too far over quota.
>
> A number of container workloads use a dynamic number of real
> nohz tasks but also have other work that is limited which ends
> up running on the "spare" nohz cpus.  This is an artifact of
> having to specify nohz_full cpus at boot. Adding this hrtick
> resolves the issue of long stalls on these tasks.
>
> Add the sched_feat HRTICK_BW off by default to allow users to
> enable this only when needed.
>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Suggested-by: Juri Lelli <jlelli@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Ben Segall <bsegall@google.com>
> ---
>
> Resend with LKML address instead of rh list...
>
>  kernel/sched/core.c     |  2 +-
>  kernel/sched/fair.c     | 20 ++++++++++++++++++++
>  kernel/sched/features.h |  1 +
>  kernel/sched/sched.h    | 12 ++++++++++++
>  4 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a68d1276bab0..76425c377245 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6562,7 +6562,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>  
>  	schedule_debug(prev, !!sched_mode);
>  
> -	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
> +	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL) || sched_feat(HRTICK_BW))
>  		hrtick_clear(rq);
>  
>  	local_irq_disable();
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 373ff5f55884..0dd1f6a874bc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5309,6 +5309,22 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>  	return ret;
>  }
>  
> +#if defined(CONFIG_SCHED_HRTICK) && defined(CONFIG_NO_HZ_FULL)
> +static void start_hrtick_cfs_bw(struct rq *rq, struct cfs_rq *cfs_rq)
> +{
> +	if (!tick_nohz_full_cpu(rq->cpu) || !cfs_bandwidth_used() || !cfs_rq->runtime_enabled)
> +		return;
> +
> +	/* runtime_remaining should never be negative here but just in case */
> +	if (rq->nr_running == 1 && cfs_rq->runtime_remaining > 0)
> +		hrtick_start(rq, cfs_rq->runtime_remaining);
> +}
> +#else
> +static void start_hrtick_cfs_bw(struct rq *rq, struct cfs_rq *cfs_rq)
> +{
> +}
> +#endif
> +
>  static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
>  {
>  	/* dock delta_exec before expiring quota (as it could span periods) */
> @@ -5481,6 +5497,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>  	 */
>  	cfs_rq->throttled = 1;
>  	cfs_rq->throttled_clock = rq_clock(rq);
> +
>  	return true;
>  }
>  
> @@ -8096,6 +8113,9 @@ done: __maybe_unused;
>  	if (hrtick_enabled_fair(rq))
>  		hrtick_start_fair(rq, p);
>  
> +	if (hrtick_enabled_bw(rq))
> +		start_hrtick_cfs_bw(rq, task_cfs_rq(p));
> +
>  	update_misfit_status(p, rq);

Implementation-wise this winds up with a tick of
sysctl_sched_cfs_bandwidth_slice, which I suppose the admin could _also_
configure depending on how much NOHZ benefit vs cfsb issues they want.

It's not great that this implementation winds up going all the way
through schedule() for each 5ms-default tick, though.
