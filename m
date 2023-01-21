Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A336762F8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 03:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjAUCPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 21:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjAUCPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 21:15:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B16812866
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 18:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674267290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mbvSrgAjDzwyk4T7c1UcWU45O6TxTbnj58RbBOEUDHo=;
        b=MHCVAvTGG4Ee2a2ahEGqF+QfpUR0hjenDvvpr2CKEUMKeUhEyminijfFSxt7OPN/gkGioX
        E20iNa+aMxteslrJb9bOz83nb/ajg39WUHbP24CXRWtZ2FMTzJh8XNbiUa4lnYpIqF91Jj
        3X8ftO05spaBs6cDGui/6/tpSye6leU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-355-4ymr7LGPMbemBmnNTr-fwA-1; Fri, 20 Jan 2023 21:14:45 -0500
X-MC-Unique: 4ymr7LGPMbemBmnNTr-fwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCE691C05B11;
        Sat, 21 Jan 2023 02:14:44 +0000 (UTC)
Received: from [10.22.17.220] (unknown [10.22.17.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01A202166B2A;
        Sat, 21 Jan 2023 02:14:43 +0000 (UTC)
Message-ID: <b5ebf7e2-19ee-962c-d580-dae717d1c977@redhat.com>
Date:   Fri, 20 Jan 2023 21:14:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] sched: Store restrict_cpus_allowed_ptr() call state
Content-Language: en-US
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>
Cc:     Phil Auld <pauld@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20230120210809.20075-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230120210809.20075-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 16:08, Waiman Long wrote:
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
>
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
>   include/linux/sched.h |  3 +++
>   kernel/sched/core.c   | 55 ++++++++++++++++++++++++++++++++++++-------
>   kernel/sched/sched.h  |  2 ++
>   3 files changed, 51 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 853d08f7562b..f93f62a1f858 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -886,6 +886,9 @@ struct task_struct {
>   	unsigned			sched_contributes_to_load:1;
>   	unsigned			sched_migrated:1;
>   
> +	/* restrict_cpus_allowed_ptr() bit, serialized by scheduler locks */
> +	unsigned			cpus_allowed_restricted:1;
> +
>   	/* Force alignment to the next boundary: */
>   	unsigned			:0;
>   
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bb1ee6d7bdde..c334c1971e81 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2999,15 +2999,49 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>   	struct rq *rq;
>   
>   	rq = task_rq_lock(p, &rf);
> +
> +	if (ctx->flags & (SCA_CLR_RESTRICT | SCA_SET_RESTRICT)) {
> +		p->cpus_allowed_restricted = 0;
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
> +
> +		/*
> +		 * In the unlikely event that sched_setaffinity() has been
> +		 * called on a cpu with cpus_allowed_restricted flag set,
> +		 * we have to store in user_cpus_ptr a restricted version
> +		 * of cpu affinity mask that won't be restored when
> +		 * relax_compatible_cpus_allowed_ptr() is called.
> +		 *
> +		 * Note that we don't need to do further user_cpus_ptr
> +		 * masking below as cpus_mask should be a subset of
> +		 * user_cpus_ptr if set.
> +		 */
> +		if (ctx->flags & SCA_USER)
> +			cpumask_copy((struct cpumask *)ctx->new_mask, rq->scratch_mask);

Sorry, that part is wrong. I forgot there were two masks in ctx. Will 
send out a v2.

Cheers,
Longman

> +		else
> +			ctx->new_mask = rq->scratch_mask;
> +	}
> +
>   	/*
>   	 * Masking should be skipped if SCA_USER or any of the SCA_MIGRATE_*
> -	 * flags are set.
> +	 * flags are set or when cpus_allowed_restricted flag has been set.
>   	 */
> -	if (p->user_cpus_ptr &&
> +	if (p->user_cpus_ptr && !p->cpus_allowed_restricted &&
>   	    !(ctx->flags & (SCA_USER | SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) &&
>   	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr))
>   		ctx->new_mask = rq->scratch_mask;
>   
> +	if (ctx->flags & SCA_SET_RESTRICT)
> +		p->cpus_allowed_restricted = 1;
> +
>   	return __set_cpus_allowed_ptr_locked(p, ctx, rq, &rf);
>   }
>   
> @@ -3025,8 +3059,8 @@ EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
>   /*
>    * Change a given task's CPU affinity to the intersection of its current
>    * affinity mask and @subset_mask, writing the resulting mask to @new_mask.
> - * If user_cpus_ptr is defined, use it as the basis for restricting CPU
> - * affinity or use cpu_online_mask instead.
> + * The cpus_allowed_restricted bit is set to indicate to a later
> + * relax_compatible_cpus_allowed_ptr() call to relax the cpumask.
>    *
>    * If the resulting mask is empty, leave the affinity unchanged and return
>    * -EINVAL.
> @@ -3037,7 +3071,7 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
>   {
>   	struct affinity_context ac = {
>   		.new_mask  = new_mask,
> -		.flags     = 0,
> +		.flags     = SCA_SET_RESTRICT,
>   	};
>   	struct rq_flags rf;
>   	struct rq *rq;
> @@ -3069,9 +3103,8 @@ static int restrict_cpus_allowed_ptr(struct task_struct *p,
>   
>   /*
>    * Restrict the CPU affinity of task @p so that it is a subset of
> - * task_cpu_possible_mask() and point @p->user_cpus_ptr to a copy of the
> - * old affinity mask. If the resulting mask is empty, we warn and walk
> - * up the cpuset hierarchy until we find a suitable mask.
> + * task_cpu_possible_mask(). If the resulting mask is empty, we warn
> + * and walk up the cpuset hierarchy until we find a suitable mask.
>    */
>   void force_compatible_cpus_allowed_ptr(struct task_struct *p)
>   {
> @@ -3126,10 +3159,14 @@ void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
>   {
>   	struct affinity_context ac = {
>   		.new_mask  = task_user_cpus(p),
> -		.flags     = 0,
> +		.flags     = SCA_CLR_RESTRICT,
>   	};
>   	int ret;
>   
> +	/* Return if no previous force_compatible_cpus_allowed_ptr() call */
> +	if (!data_race(p->cpus_allowed_restricted))
> +		return;
> +
>   	/*
>   	 * Try to restore the old affinity mask with __sched_setaffinity().
>   	 * Cpuset masking will be done there too.
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 771f8ddb7053..adcef29d5479 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2293,6 +2293,8 @@ extern struct task_struct *pick_next_task_idle(struct rq *rq);
>   #define SCA_MIGRATE_DISABLE	0x02
>   #define SCA_MIGRATE_ENABLE	0x04
>   #define SCA_USER		0x08
> +#define SCA_CLR_RESTRICT	0x10
> +#define SCA_SET_RESTRICT	0x20
>   
>   #ifdef CONFIG_SMP
>   

