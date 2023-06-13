Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D8772E415
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240722AbjFMN1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240668AbjFMN1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043AEE56
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686662788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/mfjHT7nuV4AfGG0oJKGlKVHxkxgF2g4IG6Spxt4sW8=;
        b=Qnzw5jDsE3jh9LnspAzsl492ValcOOhcd7ADS3+pDJCwHqRkFpYnL8GlHJOhDSzeMth5Ra
        3UuBvMxrlZHUyDWr/qoAYQBt9qwW7uKqh1A+qYvvsD0/nEx2mR4EMo23zPPIcN9j0MO2DV
        rYK3AW4ZouqO1JnOXxeqPA0Pt0Xo+iQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-ayrKN39cPACI0MHbCIFtNA-1; Tue, 13 Jun 2023 09:26:16 -0400
X-MC-Unique: ayrKN39cPACI0MHbCIFtNA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08704101B059;
        Tue, 13 Jun 2023 13:26:00 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.193.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C51140C20F5;
        Tue, 13 Jun 2023 13:25:53 +0000 (UTC)
Date:   Tue, 13 Jun 2023 09:25:50 -0400
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
Subject: Re: [RFC PATCH V3 2/6] sched/deadline: Collect sched_dl_entity
 initialization
Message-ID: <20230613132550.GD536267@lorien.usersys.redhat.com>
References: <cover.1686239016.git.bristot@kernel.org>
 <cb1e5f2fc80da2c7ef1017a2fee49be28fa07a94.1686239016.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb1e5f2fc80da2c7ef1017a2fee49be28fa07a94.1686239016.git.bristot@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 05:58:14PM +0200 Daniel Bristot de Oliveira wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Create a single function that initializes a sched_dl_entity.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Reviewed-by: Phil Auld <pauld@redhat.com>

> ---
>  kernel/sched/core.c     |  5 +----
>  kernel/sched/deadline.c | 22 +++++++++++++++-------
>  kernel/sched/sched.h    |  5 +----
>  3 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ac38225e6d09..e34b02cbe41f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4511,10 +4511,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>  	memset(&p->stats, 0, sizeof(p->stats));
>  #endif
>  
> -	RB_CLEAR_NODE(&p->dl.rb_node);
> -	init_dl_task_timer(&p->dl);
> -	init_dl_inactive_task_timer(&p->dl);
> -	__dl_clear_params(p);
> +	init_dl_entity(&p->dl);
>  
>  	INIT_LIST_HEAD(&p->rt.run_list);
>  	p->rt.timeout		= 0;
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 030e7c11607f..22e5e64812c9 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -333,6 +333,8 @@ static void dl_change_utilization(struct task_struct *p, u64 new_bw)
>  	__add_rq_bw(new_bw, &rq->dl);
>  }
>  
> +static void __dl_clear_params(struct sched_dl_entity *dl_se);
> +
>  /*
>   * The utilization of a task cannot be immediately removed from
>   * the rq active utilization (running_bw) when the task blocks.
> @@ -432,7 +434,7 @@ static void task_non_contending(struct task_struct *p)
>  			raw_spin_lock(&dl_b->lock);
>  			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
>  			raw_spin_unlock(&dl_b->lock);
> -			__dl_clear_params(p);
> +			__dl_clear_params(dl_se);
>  		}
>  
>  		return;
> @@ -1205,7 +1207,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
>  	return HRTIMER_NORESTART;
>  }
>  
> -void init_dl_task_timer(struct sched_dl_entity *dl_se)
> +static void init_dl_task_timer(struct sched_dl_entity *dl_se)
>  {
>  	struct hrtimer *timer = &dl_se->dl_timer;
>  
> @@ -1415,7 +1417,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
>  		raw_spin_lock(&dl_b->lock);
>  		__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
>  		raw_spin_unlock(&dl_b->lock);
> -		__dl_clear_params(p);
> +		__dl_clear_params(dl_se);
>  
>  		goto unlock;
>  	}
> @@ -1431,7 +1433,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
>  	return HRTIMER_NORESTART;
>  }
>  
> -void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
> +static void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
>  {
>  	struct hrtimer *timer = &dl_se->inactive_timer;
>  
> @@ -2974,10 +2976,8 @@ bool __checkparam_dl(const struct sched_attr *attr)
>  /*
>   * This function clears the sched_dl_entity static params.
>   */
> -void __dl_clear_params(struct task_struct *p)
> +static void __dl_clear_params(struct sched_dl_entity *dl_se)
>  {
> -	struct sched_dl_entity *dl_se = &p->dl;
> -
>  	dl_se->dl_runtime		= 0;
>  	dl_se->dl_deadline		= 0;
>  	dl_se->dl_period		= 0;
> @@ -2995,6 +2995,14 @@ void __dl_clear_params(struct task_struct *p)
>  #endif
>  }
>  
> +void init_dl_entity(struct sched_dl_entity *dl_se)
> +{
> +	RB_CLEAR_NODE(&dl_se->rb_node);
> +	init_dl_task_timer(dl_se);
> +	init_dl_inactive_task_timer(dl_se);
> +	__dl_clear_params(dl_se);
> +}
> +
>  bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr)
>  {
>  	struct sched_dl_entity *dl_se = &p->dl;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index da0cec2fc63a..fa6512070fa7 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -284,8 +284,6 @@ struct rt_bandwidth {
>  	unsigned int		rt_period_active;
>  };
>  
> -void __dl_clear_params(struct task_struct *p);
> -
>  static inline int dl_bandwidth_enabled(void)
>  {
>  	return sysctl_sched_rt_runtime >= 0;
> @@ -2390,8 +2388,7 @@ extern struct rt_bandwidth def_rt_bandwidth;
>  extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);
>  extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
>  
> -extern void init_dl_task_timer(struct sched_dl_entity *dl_se);
> -extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
> +extern void init_dl_entity(struct sched_dl_entity *dl_se);
>  
>  #define BW_SHIFT		20
>  #define BW_UNIT			(1 << BW_SHIFT)
> -- 
> 2.40.1
> 

-- 

