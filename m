Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A118867A35E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbjAXTsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbjAXTsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:48:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3005F1115D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:48:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26A1C61320
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 19:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5104C433D2;
        Tue, 24 Jan 2023 19:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674589692;
        bh=F4gF1F3iz5i02PnKb+GE9T/ZCqrRA7tFJkyCVR5lEa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oElI71mzWtnW4cPlpZ2UwLLbzQwVw8NtcaqjwzStST57swmH25DMwOv8LfgU4hEtd
         Q0lqwX/KZrLXkb9Lz9o4m3fAf+oe04tgnto7ZifXK4trhvnLDyxdgfXkwH7W/7MYqd
         3KzfyOWoj3LgwE4rYJkqQGX1lYJPlNP5ebtkDRUZkjapkXE7jyB0/RxtrRafu38JKp
         68KXjU+j0XSYQJKRjTk9+P5jCxpAv/JLsqqDPh/S71jwRSWWijRpyevureWbr89TGL
         AP/1CyDzqFfyzSerXsbBWaTDOWt9TlkpbHVIyX9SkKGYRbBoHFPbaLvT+PsoHJm0jq
         j/oAZul+OyzXw==
Date:   Tue, 24 Jan 2023 19:48:05 +0000
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
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        regressions@leemhuis.info
Subject: Re: [PATCH v2] sched: Store restrict_cpus_allowed_ptr() call state
Message-ID: <20230124194805.GA27257@willie-the-truck>
References: <20230121021749.55313-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121021749.55313-1-longman@redhat.com>
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

[+Thorsten given where we are in the release cycle]

On Fri, Jan 20, 2023 at 09:17:49PM -0500, Waiman Long wrote:
> The user_cpus_ptr field was originally added by commit b90ca8badbd1
> ("sched: Introduce task_struct::user_cpus_ptr to track requested
> affinity"). It was used only by arm64 arch due to possible asymmetric
> CPU setup.
> 
> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
> cpumask"), task_struct::user_cpus_ptr is repurposed to store user
> requested cpu affinity specified in the sched_setaffinity().
> 
> This results in a performance regression in an arm64 system when booted
> with "allow_mismatched_32bit_el0" on the command-line. The arch code will
> (amongst other things) calls force_compatible_cpus_allowed_ptr() and
> relax_compatible_cpus_allowed_ptr() when exec()'ing a 32-bit or a 64-bit
> task respectively. Now a call to relax_compatible_cpus_allowed_ptr()
> will always result in a __sched_setaffinity() call whether there is a
> previous force_compatible_cpus_allowed_ptr() call or not.

I'd argue it's more than just a performance regression -- the affinity
masks are set incorrectly, which is a user visible thing
(i.e. sched_getaffinity() gives unexpected values).

> In order to fix this regression, a new scheduler flag
> task_struct::cpus_allowed_restricted is now added to track if
> force_compatible_cpus_allowed_ptr() has been called before or not. This
> patch also updates the comments in force_compatible_cpus_allowed_ptr()
> and relax_compatible_cpus_allowed_ptr() and handles their interaction
> with sched_setaffinity().
> 
> Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
> Reported-by: Will Deacon <will@kernel.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/sched.h |  3 +++
>  kernel/sched/core.c   | 46 ++++++++++++++++++++++++++++++++++---------
>  kernel/sched/sched.h  |  2 ++
>  3 files changed, 42 insertions(+), 9 deletions(-)

I find this pretty invasive, but I guess it's up to Peter and Ingo.
It also doesn't the whole problem for me; see below.

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 853d08f7562b..f93f62a1f858 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -886,6 +886,9 @@ struct task_struct {
>  	unsigned			sched_contributes_to_load:1;
>  	unsigned			sched_migrated:1;
>  
> +	/* restrict_cpus_allowed_ptr() bit, serialized by scheduler locks */
> +	unsigned			cpus_allowed_restricted:1;
> +
>  	/* Force alignment to the next boundary: */
>  	unsigned			:0;
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bb1ee6d7bdde..48234dc9005b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2999,15 +2999,40 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>  	struct rq *rq;
>  
>  	rq = task_rq_lock(p, &rf);
> +
> +	if (ctx->flags & (SCA_CLR_RESTRICT | SCA_SET_RESTRICT)) {
> +		p->cpus_allowed_restricted = 0;

I don't think this is ever called on the SCA_SET_RESTRICT path, as
restrict_cpus_allowed_ptr() calls __set_cpus_allowed_ptr_locked() directly.
In my testing, we see a failure in the following sequence:

  1. A 64-bit task has an affinity of 0xf
  2. It exec()s a 32-bit program and is forcefully restricted to the set
     of 32-bit-capable cores. Let's say that new mask is 0xc
  3. The 32-bit task now exec()s a 64-bit program again

And now we're still stuck with 0xc after step 3 whereas we should restore
0xf.

> +	} else if (p->cpus_allowed_restricted) {
> +		/*
> +		 * If force_compatible_cpus_allowed_ptr() has been called,
> +		 * we can't extend cpumask to beyond what is in cpus_mask.
> +		 */
> +		if (!cpumask_and(rq->scratch_mask, ctx->new_mask,
> +				 &p->cpus_mask)) {
> +			task_rq_unlock(rq, p, &rf);
> +			return -EINVAL;
> +		}

Why is this masking actually needed? __sched_setaffinity() already
takes into account the task_cpu_possible_mask(), which is why I asked you
before [1] about cases where the saved affinity is not simply a superset
of the effective affinity.

Thanks,

Will

[1] https://lore.kernel.org/r/20230120175931.GA22417@willie-the-truck
