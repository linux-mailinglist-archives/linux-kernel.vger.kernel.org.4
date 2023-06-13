Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CD572E409
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbjFMN0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242442AbjFMN0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3DC1AA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686662723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JboUraAKvypGcrddtsolOxusyUZhs5znGcYYiSkF8MQ=;
        b=ijzYY7B/gZ1cOgTI6GvboHunvUvOW8Nl/rwedMGlyBmE0JJ4gdy2nqpCxzMrVH7vJO28fQ
        Rs5UC6gX04H7A18j3lawVsfm59wGSF/aD8U5crtuiAwsORQfDfs7seAYyVTf10ycB1tats
        ulJJEHacGyFdF+NgQFKCatXinAql0JU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-Md6wsI11P-OcTj7s-6zvRA-1; Tue, 13 Jun 2023 09:25:16 -0400
X-MC-Unique: Md6wsI11P-OcTj7s-6zvRA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E14C61022F09;
        Tue, 13 Jun 2023 13:25:03 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.193.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D233B2166B26;
        Tue, 13 Jun 2023 13:24:57 +0000 (UTC)
Date:   Tue, 13 Jun 2023 09:24:54 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH V3 1/6] sched: Unify runtime accounting across classes
Message-ID: <20230613132454.GC536267@lorien.usersys.redhat.com>
References: <cover.1686239016.git.bristot@kernel.org>
 <51ad657375206dac0f2609224babafa1c1486d4b.1686239016.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51ad657375206dac0f2609224babafa1c1486d4b.1686239016.git.bristot@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 05:58:13PM +0200 Daniel Bristot de Oliveira wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> All classes use sched_entity::exec_start to track runtime and have
> copies of the exact same code around to compute runtime.
> 
> Collapse all that.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Reviewed-by: Phil Auld <pauld@redhat.com>

> ---
>  include/linux/sched.h    |  2 +-
>  kernel/sched/deadline.c  | 15 +++--------
>  kernel/sched/fair.c      | 57 ++++++++++++++++++++++++++++++----------
>  kernel/sched/rt.c        | 15 +++--------
>  kernel/sched/sched.h     | 12 ++-------
>  kernel/sched/stop_task.c | 13 +--------
>  6 files changed, 53 insertions(+), 61 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 1292d38d66cc..26b1925a702a 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -521,7 +521,7 @@ struct sched_statistics {
>  	u64				block_max;
>  	s64				sum_block_runtime;
>  
> -	u64				exec_max;
> +	s64				exec_max;
>  	u64				slice_max;
>  
>  	u64				nr_migrations_cold;
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index f827067ad03b..030e7c11607f 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1301,9 +1301,8 @@ static void update_curr_dl(struct rq *rq)
>  {
>  	struct task_struct *curr = rq->curr;
>  	struct sched_dl_entity *dl_se = &curr->dl;
> -	u64 delta_exec, scaled_delta_exec;
> +	s64 delta_exec, scaled_delta_exec;
>  	int cpu = cpu_of(rq);
> -	u64 now;
>  
>  	if (!dl_task(curr) || !on_dl_rq(dl_se))
>  		return;
> @@ -1316,21 +1315,13 @@ static void update_curr_dl(struct rq *rq)
>  	 * natural solution, but the full ramifications of this
>  	 * approach need further study.
>  	 */
> -	now = rq_clock_task(rq);
> -	delta_exec = now - curr->se.exec_start;
> -	if (unlikely((s64)delta_exec <= 0)) {
> +	delta_exec = update_curr_common(rq);
> +	if (unlikely(delta_exec <= 0)) {
>  		if (unlikely(dl_se->dl_yielded))
>  			goto throttle;
>  		return;
>  	}
>  
> -	schedstat_set(curr->stats.exec_max,
> -		      max(curr->stats.exec_max, delta_exec));
> -
> -	trace_sched_stat_runtime(curr, delta_exec, 0);
> -
> -	update_current_exec_runtime(curr, now, delta_exec);
> -
>  	if (dl_entity_is_special(dl_se))
>  		return;
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6189d1a45635..fda67f05190d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -891,23 +891,17 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  }
>  #endif /* CONFIG_SMP */
>  
> -/*
> - * Update the current task's runtime statistics.
> - */
> -static void update_curr(struct cfs_rq *cfs_rq)
> +static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
>  {
> -	struct sched_entity *curr = cfs_rq->curr;
> -	u64 now = rq_clock_task(rq_of(cfs_rq));
> -	u64 delta_exec;
> -
> -	if (unlikely(!curr))
> -		return;
> +	u64 now = rq_clock_task(rq);
> +	s64 delta_exec;
>  
>  	delta_exec = now - curr->exec_start;
> -	if (unlikely((s64)delta_exec <= 0))
> -		return;
> +	if (unlikely(delta_exec <= 0))
> +		return delta_exec;
>  
>  	curr->exec_start = now;
> +	curr->sum_exec_runtime += delta_exec;
>  
>  	if (schedstat_enabled()) {
>  		struct sched_statistics *stats;
> @@ -917,8 +911,43 @@ static void update_curr(struct cfs_rq *cfs_rq)
>  				max(delta_exec, stats->exec_max));
>  	}
>  
> -	curr->sum_exec_runtime += delta_exec;
> -	schedstat_add(cfs_rq->exec_clock, delta_exec);
> +	return delta_exec;
> +}
> +
> +/*
> + * Used by other classes to account runtime.
> + */
> +s64 update_curr_common(struct rq *rq)
> +{
> +	struct task_struct *curr = rq->curr;
> +	s64 delta_exec;
> +
> +	delta_exec = update_curr_se(rq, &curr->se);
> +	if (unlikely(delta_exec <= 0))
> +		return delta_exec;
> +
> +	trace_sched_stat_runtime(curr, delta_exec, 0);
> +
> +	account_group_exec_runtime(curr, delta_exec);
> +	cgroup_account_cputime(curr, delta_exec);
> +
> +	return delta_exec;
> +}
> +
> +/*
> + * Update the current task's runtime statistics.
> + */
> +static void update_curr(struct cfs_rq *cfs_rq)
> +{
> +	struct sched_entity *curr = cfs_rq->curr;
> +	s64 delta_exec;
> +
> +	if (unlikely(!curr))
> +		return;
> +
> +	delta_exec = update_curr_se(rq_of(cfs_rq), curr);
> +	if (unlikely(delta_exec <= 0))
> +		return;
>  
>  	curr->vruntime += calc_delta_fair(delta_exec, curr);
>  	update_min_vruntime(cfs_rq);
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 00e0e5074115..efec4f3fef83 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1046,24 +1046,15 @@ static void update_curr_rt(struct rq *rq)
>  {
>  	struct task_struct *curr = rq->curr;
>  	struct sched_rt_entity *rt_se = &curr->rt;
> -	u64 delta_exec;
> -	u64 now;
> +	s64 delta_exec;
>  
>  	if (curr->sched_class != &rt_sched_class)
>  		return;
>  
> -	now = rq_clock_task(rq);
> -	delta_exec = now - curr->se.exec_start;
> -	if (unlikely((s64)delta_exec <= 0))
> +	delta_exec = update_curr_common(rq);
> +	if (unlikely(delta_exec <= 0))
>  		return;
>  
> -	schedstat_set(curr->stats.exec_max,
> -		      max(curr->stats.exec_max, delta_exec));
> -
> -	trace_sched_stat_runtime(curr, delta_exec, 0);
> -
> -	update_current_exec_runtime(curr, now, delta_exec);
> -
>  	if (!rt_bandwidth_enabled())
>  		return;
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 556496c77dc2..da0cec2fc63a 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2176,6 +2176,8 @@ struct affinity_context {
>  	unsigned int flags;
>  };
>  
> +extern s64 update_curr_common(struct rq *rq);
> +
>  struct sched_class {
>  
>  #ifdef CONFIG_UCLAMP_TASK
> @@ -3207,16 +3209,6 @@ extern int sched_dynamic_mode(const char *str);
>  extern void sched_dynamic_update(int mode);
>  #endif
>  
> -static inline void update_current_exec_runtime(struct task_struct *curr,
> -						u64 now, u64 delta_exec)
> -{
> -	curr->se.sum_exec_runtime += delta_exec;
> -	account_group_exec_runtime(curr, delta_exec);
> -
> -	curr->se.exec_start = now;
> -	cgroup_account_cputime(curr, delta_exec);
> -}
> -
>  #ifdef CONFIG_SCHED_MM_CID
>  
>  #define SCHED_MM_CID_PERIOD_NS	(100ULL * 1000000)	/* 100ms */
> diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
> index 85590599b4d6..7595494ceb6d 100644
> --- a/kernel/sched/stop_task.c
> +++ b/kernel/sched/stop_task.c
> @@ -70,18 +70,7 @@ static void yield_task_stop(struct rq *rq)
>  
>  static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
>  {
> -	struct task_struct *curr = rq->curr;
> -	u64 now, delta_exec;
> -
> -	now = rq_clock_task(rq);
> -	delta_exec = now - curr->se.exec_start;
> -	if (unlikely((s64)delta_exec < 0))
> -		delta_exec = 0;
> -
> -	schedstat_set(curr->stats.exec_max,
> -		      max(curr->stats.exec_max, delta_exec));
> -
> -	update_current_exec_runtime(curr, now, delta_exec);
> +	update_curr_common(rq);
>  }
>  
>  /*
> -- 
> 2.40.1
> 

-- 

