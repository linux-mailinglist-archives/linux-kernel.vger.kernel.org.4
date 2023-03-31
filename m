Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16126D2103
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjCaM7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjCaM7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8F910E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680267501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5fILBd8Ie8vifDZ2uoOuBDeMd9GM+Op5sl/9xS/ZTbM=;
        b=crYWRbZop0tNs6fp7ty+T5oVDNpIWtJxlNk7H5R8feqrWQuWKNRw3BcEBYcsMtBFltezEv
        ucuUpdJZ7HXH/o5lpi6QCOLLiSKjJld2uHO9Fv/MQQo1UBhEWu/8zMa54oUUw4Lxz3nSQl
        fVLCcSlLWVrpZtrLUnmku/spkoTDseM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-yy8Nfhc6OKCZMSf5s-m6gg-1; Fri, 31 Mar 2023 08:58:18 -0400
X-MC-Unique: yy8Nfhc6OKCZMSf5s-m6gg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D89FD85A588;
        Fri, 31 Mar 2023 12:58:17 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.32.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BC0E4020C82;
        Fri, 31 Mar 2023 12:58:16 +0000 (UTC)
Date:   Fri, 31 Mar 2023 08:58:13 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/core: Adapt WARN_DOUBLE_CLOCK machinery for
 core-sched
Message-ID: <20230331125813.GA782283@lorien.usersys.redhat.com>
References: <20230330035827.16937-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330035827.16937-1-jiahao.os@bytedance.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 30, 2023 at 11:58:27AM +0800 Hao Jia wrote:
> When sched_core_enabled(), we sometimes need to call update_rq_clock()
> to update the rq clock of sibling CPUs on the same core, before that we
> need to clear RQCF_UPDATED of rq->clock_update_flags to avoid the
> WARN_DOUBLE_CLOCK warning. Because at this time the rq->clock_update_flags
> of sibling CPUs may be RQCF_UPDATED. If sched_core_enabled(), we will get
> a core wide rq->lock, so at this point we can safely clear RQCF_UPDATED of
> rq->clock_update_flags of all CPUs on this core to avoid the
> WARN_DOUBLE_CLOCK warning.
> 
> We sometimes use rq_pin_lock() and raw_spin_rq_lock() separately,
> For example newidle_balance() and _double_lock_balance(). We will
> temporarily give up core wide rq->lock, and then use raw_spin_rq_lock()
> to reacquire core wide rq->lock without rq_pin_lock(), so We can not
> clear RQCF_UPDATED of rq->clock_update_flags of other cpus on the
> same core in rq_pin_lock().
> 
> Steps to reproduce:
> 1. Enable CONFIG_SCHED_DEBUG and CONFIG_SCHED_CORE when compiling
>    the kernel
> 2. echo 1 > /sys/kernel/debug/clear_warn_once
>    echo "WARN_DOUBLE_CLOCK" > /sys/kernel/debug/sched/features
> 3. Run the linux/tools/testing/selftests/sched/cs_prctl_test test
> 
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>

I think this looks good. One small nit is that I think you might
replace "core wide" with "core-wide" everywhere.


Reviewed-by: Phil Auld <pauld@redhat.com>

> ---
> v2->v3:
>  - Modify the function name to sched_core_clear_rqcf_updated,
>    and add function comments.
>  - Modify commit information.
>  [v2] https://lore.kernel.org/all/20230215073927.97802-1-jiahao.os@bytedance.com
> 
> v1->v2:
>  - Adapt WARN_DOUBLE_CLOCK machinery for core-sched instead of clearing
>    WARN_DOUBLE_CLOCK warning one by one.
>  - Modify commit information
>  [v1] https://lore.kernel.org/all/20221206070550.31763-1-jiahao.os@bytedance.com
> 
>  kernel/sched/core.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0d18c3969f90..5e06da2f07cb 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -429,11 +429,32 @@ void sched_core_put(void)
>  		schedule_work(&_work);
>  }
>  
> +/*
> + * Now, we have obtained a core wide rq->lock, then we need to clear
> + * RQCF_UPDATED of rq->clock_update_flags of the sibiling CPU
> + * on this core to avoid the WARN_DOUBLE_CLOCK warning.
> + */
> +static inline void sched_core_clear_rqcf_updated(struct rq *rq)
> +{
> +#ifdef CONFIG_SCHED_DEBUG
> +	const struct cpumask *smt_mask;
> +	int i;
> +
> +	if (rq->core_enabled) {
> +		smt_mask = cpu_smt_mask(rq->cpu);
> +		for_each_cpu(i, smt_mask) {
> +			if (rq->cpu != i)
> +				cpu_rq(i)->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
> +		}
> +	}
> +#endif
> +}
>  #else /* !CONFIG_SCHED_CORE */
>  
>  static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
>  static inline void
>  sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
> +static inline void sched_core_clear_rqcf_updated(struct rq *rq) { }
>  
>  #endif /* CONFIG_SCHED_CORE */
>  
> @@ -548,6 +569,7 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
>  		if (likely(lock == __rq_lockp(rq))) {
>  			/* preempt_count *MUST* be > 1 */
>  			preempt_enable_no_resched();
> +			sched_core_clear_rqcf_updated(rq);
>  			return;
>  		}
>  		raw_spin_unlock(lock);
> -- 
> 2.37.0
> 

-- 

