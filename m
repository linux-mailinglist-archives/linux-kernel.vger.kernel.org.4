Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4953F745A1D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGCK01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCK0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:26:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E05B8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iTxxOeNUsimMPmX/cHsXm4j47p8TRYnXS2BDD+byQE8=; b=v59Gm5isube2eamYKYso7L6fNh
        FidiNM4uSwoD4sQQJ6ST5MRXEVF5IXwsc0bydXWw2wts/di/JsB85kMiTNBLFy1EEsc9E7kOz7wMw
        eJZMvCafqlOemjSOc3VXciZTEKh/HoAuMGiTeZtQzoPgvV/z51ZTI5tngFygUHR0f/0IsiPcikurF
        xRHCllW16tVO44Sjr4h1LCnbRhitm91zP+auhoHrjXt10uXsLzsGv66pDw31xuGY4J7jCl4GOMHnB
        7noFds20pIm+dpCit/lLDyxDTljCEJz7YqTdQwDccl9yuPLGREqaT4mqXWeUn9i7tpjgSQgH/lTEn
        UbvMdAoQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qGGkw-008927-Tr; Mon, 03 Jul 2023 10:26:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32A2730023F;
        Mon,  3 Jul 2023 12:26:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0AA5F202A2A17; Mon,  3 Jul 2023 12:26:05 +0200 (CEST)
Date:   Mon, 3 Jul 2023 12:26:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>
Subject: Re: [PATCH] sched/core: Use empty mask to reset cpumasks in
 sched_setaffinity()
Message-ID: <20230703102604.GC4253@hirez.programming.kicks-ass.net>
References: <20230628211637.1679348-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628211637.1679348-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 05:16:37PM -0400, Waiman Long wrote:
> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
> cpumask"), user provided CPU affinity via sched_setaffinity(2) is
> perserved even if the task is being moved to a different cpuset. However,
> that affinity is also being inherited by any subsequently created child
> processes which may not want or be aware of that affinity.
> 
> One way to solve this problem is to provide a way to back off from
> that user provided CPU affinity.  This patch implements such a scheme
> by using an empty cpumask to signal a reset of the cpumasks to the
> default as allowed by the current cpuset.
> 
> Before this patch, passing in an empty cpumask to sched_setaffinity(2)
> will return an EINVAL error. With this patch, an error will no longer
> be returned. Instead, the user_cpus_ptr that stores the user provided
> affinity, if set, will be cleared and the task's CPU affinity will be
> reset to that of the current cpuset. This reverts the cpumask change
> done by all the previous sched_setaffinity(2) calls.
> 

This is a user visible ABI change -- but with very limited motivation.
Why do we want this? Who will use this?

> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/sched/core.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c52c2eba7c73..f4806d969fc9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8317,7 +8317,12 @@ __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
>  	}
>  
>  	cpuset_cpus_allowed(p, cpus_allowed);
> -	cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
> +
> +	/* Default to cpus_allowed with NULL new_mask */
> +	if (ctx->new_mask)
> +		cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
> +	else
> +		cpumask_copy(new_mask, cpus_allowed);
>  
>  	ctx->new_mask = new_mask;
>  	ctx->flags |= SCA_CHECK;
> @@ -8366,6 +8371,7 @@ __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
>  
>  long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>  {
> +	bool reset_cpumasks = cpumask_empty(in_mask);
>  	struct affinity_context ac;
>  	struct cpumask *user_mask;
>  	struct task_struct *p;
> @@ -8403,13 +8409,23 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>  		goto out_put_task;
>  
>  	/*
> -	 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
> -	 * alloc_user_cpus_ptr() returns NULL.
> +	 * If an empty cpumask is passed in, clear user_cpus_ptr, if set,
> +	 * and reset the current cpu affinity to the default for the
> +	 * current cpuset.
>  	 */
> -	user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
> +	if (reset_cpumasks) {
> +		in_mask = NULL;	/* To be updated in __sched_setaffinity */
> +		user_mask = NULL;
> +	} else {
> +		/*
> +		 * With non-SMP configs, user_cpus_ptr/user_mask isn't used
> +		 * and alloc_user_cpus_ptr() returns NULL.
> +		 */
> +		user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
> +	}
>  	if (user_mask) {
>  		cpumask_copy(user_mask, in_mask);
> -	} else if (IS_ENABLED(CONFIG_SMP)) {
> +	} else if (!reset_cpumasks && IS_ENABLED(CONFIG_SMP)) {
>  		retval = -ENOMEM;
>  		goto out_put_task;
>  	}
> -- 
> 2.31.1
> 
