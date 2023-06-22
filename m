Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C24873A21C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjFVNo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjFVNoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:44:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9161721
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687441449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jIb6F13my9Jls20M1/cwj9JDB/gYbtkreFOTmrufbAw=;
        b=AoUOlFFcNoho9sxW77qtW9TBqkD2oqXev6/SIveflkiMJALY9yLC0USbz4UYhdQB6QtSxG
        zWZLGbHot6tGSg/CQrcVYL+lIaGRMbD1pYucjrpaB0FR2uWXU8a8YHsb/WEmaMGbXnF+Uc
        KOU4rwGTLavYWFo3jl4dIbNsbZ98a50=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-5bkVjlPIMYGLYIA_FoVAeA-1; Thu, 22 Jun 2023 09:44:04 -0400
X-MC-Unique: 5bkVjlPIMYGLYIA_FoVAeA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D71BD2999B3C;
        Thu, 22 Jun 2023 13:44:03 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.9.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C54740C2063;
        Thu, 22 Jun 2023 13:44:03 +0000 (UTC)
Date:   Thu, 22 Jun 2023 09:44:01 -0400
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] Sched/fair: Block nohz tick_stop when cfs bandwidth in
 use
Message-ID: <20230622134401.GC727646@lorien.usersys.redhat.com>
References: <20230622132751.2900081-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622132751.2900081-1-pauld@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 09:27:51AM -0400 Phil Auld wrote:
> CFS bandwidth limits and NOHZ full don't play well together.  Tasks
> can easily run well past their quotas before a remote tick does
> accounting.  This leads to long, multi-period stalls before such
> tasks can run again. Currentlyi, when presented with these conflicting
> requirements the scheduler is favoring nohz_full and letting the tick
> be stopped. However, nohz tick stopping is already best-effort, there
> are a number of conditions that can prevent it, whereas cfs runtime
> bandwidth is expected to be enforced.
> 
> Make the scheduler favor bandwidth over stopping the tick by setting
> TICK_DEP_BIT_SCHED when the only running task is a cfs task with
> runtime limit enabled.
> 
> Add sched_feat HZ_BW (off by default) to control this behavior.

This is instead of the previous HRTICK version. The problem addressed
is causing significant issues for conainterized telco systems so I'm
trying a different approach. Maybe it will get more traction.

This leaves the sched tick running, but won't require a full
pass through schedule().  As Ben pointed out the HRTICK version
would basically fire every 5ms so depending on your HZ value it
might not have bought much uninterrupted runtime anyway. 


Thanks for taking a look. 


Cheers,
Phil

> 
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Ben Segall <bsegall@google.com>
> ---
>  kernel/sched/fair.c     | 33 ++++++++++++++++++++++++++++++++-
>  kernel/sched/features.h |  2 ++
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 373ff5f55884..880eadfac330 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6139,6 +6139,33 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
>  	rcu_read_unlock();
>  }
>  
> +#ifdef CONFIG_NO_HZ_FULL
> +/* called from pick_next_task_fair() */
> +static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
> +{
> +	struct cfs_rq *cfs_rq = task_cfs_rq(p);
> +	int cpu = cpu_of(rq);
> +
> +	if (!sched_feat(HZ_BW) || !cfs_bandwidth_used())
> +		return;
> +
> +	if (!tick_nohz_full_cpu(cpu))
> +		return;
> +
> +	if (rq->nr_running != 1 || !sched_can_stop_tick(rq))
> +		return;
> +
> +	/*
> +	 *  We know there is only one task runnable and we've just picked it. The
> +	 *  normal enqueue path will have cleared TICK_DEP_BIT_SCHED if we will
> +	 *  be otherwise able to stop the tick. Just need to check if we are using
> +	 *  bandwidth control.
> +	 */
> +	if (cfs_rq->runtime_enabled)
> +		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
> +}
> +#endif
> +
>  #else /* CONFIG_CFS_BANDWIDTH */
>  
>  static inline bool cfs_bandwidth_used(void)
> @@ -6181,9 +6208,12 @@ static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
>  static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
>  static inline void update_runtime_enabled(struct rq *rq) {}
>  static inline void unthrottle_offline_cfs_rqs(struct rq *rq) {}
> -
>  #endif /* CONFIG_CFS_BANDWIDTH */
>  
> +#if !defined(CONFIG_CFS_BANDWIDTH) || !defined(CONFIG_NO_HZ_FULL)
> +static inline void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p) {}
> +#endif
> +
>  /**************************************************
>   * CFS operations on tasks:
>   */
> @@ -8097,6 +8127,7 @@ done: __maybe_unused;
>  		hrtick_start_fair(rq, p);
>  
>  	update_misfit_status(p, rq);
> +	sched_fair_update_stop_tick(rq, p);
>  
>  	return p;
>  
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index ee7f23c76bd3..6fdf1fdf6b17 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -101,3 +101,5 @@ SCHED_FEAT(LATENCY_WARN, false)
>  
>  SCHED_FEAT(ALT_PERIOD, true)
>  SCHED_FEAT(BASE_SLICE, true)
> +
> +SCHED_FEAT(HZ_BW, false)
> -- 
> 2.31.1
> 

-- 

