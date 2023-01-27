Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E21E67E5ED
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjA0M75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjA0M7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:59:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181B13A85
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:59:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DFD461C15
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB304C433D2;
        Fri, 27 Jan 2023 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674824393;
        bh=mWDbsF9513Tiae0GfaxQPPyzCEIE+mYQxkRYeCAH+xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AEoXZYJGOWNnUAo1XPvvLzysv/Hi2vV9CRfPiZ5NJarf0tgJgAiMgourUO9aPZFIT
         QoMEGZ/xDo1rnGyRfkRrCKvLAWlARQXYehvPugS5AERZ8K5Qky/ah3hYbWquhXmJLW
         i7D/TfdjlKRiVFrzF1J6V+JNuKRa1ehwu//Mho5EZgstm53rMWsXFWv2yHkCbUgfY1
         I4mPKN15d//q5lSX9H7YP8Y6xOgvSLxtWYHdGywKWk0IvXUYe1BZbYwAHSfBlhH77g
         UPQ9cGtyxKlS/SanF7o49sA9jz3WaYbzezWsZaC/bDs6gW8tOYYwk7FdeCj5Gm6zyI
         aX3ghoqX+VkLA==
Date:   Fri, 27 Jan 2023 12:59:47 +0000
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched: Store restrict_cpus_allowed_ptr() call state
Message-ID: <20230127125946.GA30605@willie-the-truck>
References: <20230127015527.466367-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127015527.466367-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

On Thu, Jan 26, 2023 at 08:55:27PM -0500, Waiman Long wrote:
> The user_cpus_ptr field was originally added by commit b90ca8badbd1
> ("sched: Introduce task_struct::user_cpus_ptr to track requested
> affinity"). It was used only by arm64 arch due to possible asymmetric
> CPU setup.
> 
> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
> cpumask"), task_struct::user_cpus_ptr is repurposed to store user
> requested cpu affinity specified in the sched_setaffinity().
> 
> This results in a slight performance regression on an arm64
> system when booted with "allow_mismatched_32bit_el0"
> on the command-line.  The arch code will (amongst
> other things) calls force_compatible_cpus_allowed_ptr() and
> relax_compatible_cpus_allowed_ptr() when exec()'ing a 32-bit or a 64-bit
> task respectively. Now a call to relax_compatible_cpus_allowed_ptr()
> will always result in a __sched_setaffinity() call whether there is a
> previous force_compatible_cpus_allowed_ptr() call or not.
> 
> In order to fix this regression, a new scheduler flag
> task_struct::cpus_allowed_restricted is now added to track if
> force_compatible_cpus_allowed_ptr() has been called before or not. This
> patch also updates the comments in force_compatible_cpus_allowed_ptr()
> and relax_compatible_cpus_allowed_ptr() and handles their interaction
> with sched_setaffinity().
> 
> This patch also removes the task_user_cpus() helper. In the case of
> relax_compatible_cpus_allowed_ptr(), cpu_possible_mask as user_cpu_ptr
> masking will be performed within __sched_setaffinity() anyway.
> 
> Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
> Reported-by: Will Deacon <will@kernel.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/sched.h |  3 +++
>  kernel/sched/core.c   | 25 +++++++++++++++++--------
>  kernel/sched/sched.h  |  8 +-------
>  3 files changed, 21 insertions(+), 15 deletions(-)

So this doesn't even build...

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bb1ee6d7bdde..d7bc809c109e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2999,6 +2999,10 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>  	struct rq *rq;
>  
>  	rq = task_rq_lock(p, &rf);
> +
> +	if (ctx->flags & SCA_CLR_RESTRICT)
> +		p->cpus_allowed_restricted = 0;
> +
>  	/*
>  	 * Masking should be skipped if SCA_USER or any of the SCA_MIGRATE_*
>  	 * flags are set.
> @@ -3025,8 +3029,8 @@ EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
>  /*
>   * Change a given task's CPU affinity to the intersection of its current
>   * affinity mask and @subset_mask, writing the resulting mask to @new_mask.
> - * If user_cpus_ptr is defined, use it as the basis for restricting CPU
> - * affinity or use cpu_online_mask instead.
> + * The cpus_allowed_restricted bit is set to indicate to a later
> + * relax_compatible_cpus_allowed_ptr() call to relax the cpumask.
>   *
>   * If the resulting mask is empty, leave the affinity unchanged and return
>   * -EINVAL.
> @@ -3044,6 +3048,7 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
>  	int err;
>  
>  	rq = task_rq_lock(p, &rf);
> +	p->cpus_allowed_restricted = 1;
>  
>  	/*
>  	 * Forcefully restricting the affinity of a deadline task is
> @@ -3055,7 +3060,8 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
>  		goto err_unlock;
>  	}
>  
> -	if (!cpumask_and(new_mask, task_user_cpus(p), subset_mask)) {
> +	if (p->user_cpu_ptr &&
> +	    !cpumask_and(new_mask, p->user_cpu_ptr, subset_mask)) {

s/user_cpu_ptr/user_cpus_ptr/

>  		err = -EINVAL;
>  		goto err_unlock;
>  	}
> @@ -3069,9 +3075,8 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
>  
>  /*
>   * Restrict the CPU affinity of task @p so that it is a subset of
> - * task_cpu_possible_mask() and point @p->user_cpus_ptr to a copy of the
> - * old affinity mask. If the resulting mask is empty, we warn and walk
> - * up the cpuset hierarchy until we find a suitable mask.
> + * task_cpu_possible_mask(). If the resulting mask is empty, we warn
> + * and walk up the cpuset hierarchy until we find a suitable mask.
>   */
>  void force_compatible_cpus_allowed_ptr(struct task_struct *p)
>  {
> @@ -3125,11 +3130,15 @@ __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx);
>  void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
>  {
>  	struct affinity_context ac = {
> -		.new_mask  = task_user_cpus(p),
> -		.flags     = 0,
> +		.new_mask  = cpu_possible_mask;

s/;/,/

But even with those two things fixed, I'm seeing new failures in my
testing which I think are because restrict_cpus_allowed_ptr() is failing
unexpectedly when called by force_compatible_cpus_allowed_ptr().

For example, just running a 32-bit task on an asymmetric system results
in:

$ ./hello32
[ 1690.855341] Overriding affinity for process 580 (hello32) to CPUs 2-3

That then has knock-on effects such as losing track of the initial affinity
mask and not being able to restore it if the forcefully-affined 32-bit task
exec()s a 64-bit program.

Will
