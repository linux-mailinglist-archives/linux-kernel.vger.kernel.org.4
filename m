Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA6669CF2A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjBTOQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjBTOQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:16:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FA11B331
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tswCs6QGW2PJsdj58gWPreczQVCqth+ZmacoRRbhVcA=; b=Rd2V7nu45GyjKqn/6TRmKF/TUV
        fKIQ7I1JVP8xs+WzjIs0rltUDdfSLZr+i0RKheD9vqw1yhpy+4E8E6CkviNyWQre3xzEzJI3qBF7H
        3A6v7dLa8N2uYvdcXooExP1aNVALeQgaklpW8av+e//aINQi+TcBBpEEANi409EpwVFXI4ETYduTB
        8uHmUMAz8+VDb3SiLDZhbwYPUyoDDCphyOrX1i3bJfXwTEXiNZC4JY8y+CCKVGbQ0dRITRxJC+/2S
        KAD/dCjrUPgVFjbYYlb5r3k7RaGlfAUKDIXY5JOY5XKQM9L8A8OKj1GVwyaNUPKTOVZggkQLzHkTL
        T4Uf0Slw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pU6xd-00BmdW-3W; Mon, 20 Feb 2023 14:16:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 288533001E7;
        Mon, 20 Feb 2023 15:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D1C92029FD42; Mon, 20 Feb 2023 13:46:07 +0100 (CET)
Date:   Mon, 20 Feb 2023 13:46:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/core: Adapt WARN_DOUBLE_CLOCK machinery for
 core-sched
Message-ID: <Y/Nrj4zdEPDxcc3+@hirez.programming.kicks-ass.net>
References: <20230215073927.97802-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215073927.97802-1-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 03:39:27PM +0800, Hao Jia wrote:
> When sched_core_enabled(), we sometimes need to call update_rq_clock()
> to update the rq clock of sibling CPUs on the same core, before that we
> need to clear RQCF_UPDATED of rq->clock_update_flags to avoid the
> WARN_DOUBLE_CLOCK warning. Because at this time the rq->clock_update_flags
> of sibling CPUs may be RQCF_UPDATED. If sched_core_enabled(), we will get
> a core wide rq->lock, so at this point we can safely clear RQCF_UPDATED of
> rq->clock_update_flags of all CPUs on this core to avoid the
> WARN_DOUBLE_CLOCK warning.
> 
> We cannot clear rq->clock_update_flags of other cpus on the same core in
> rq_pin_lock(). Because in some functions, we will temporarily give up
> core wide rq->lock, and then use raw_spin_rq_lock() to obtain core wide
> rq->lock, such as newidle_balance() and _double_lock_balance().
> 
> Steps to reproduce:
> 1. Enable CONFIG_SCHED_DEBUG and CONFIG_SCHED_CORE when compiling
>    the kernel
> 2. echo 1 > /sys/kernel/debug/clear_warn_once
>    echo "WARN_DOUBLE_CLOCK" > /sys/kernel/debug/sched/features
> 3. Run the linux/tools/testing/selftests/sched/cs_prctl_test test
> 
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> ---
>  - Adapt WARN_DOUBLE_CLOCK machinery for core-sched instead of clearing
>    WARN_DOUBLE_CLOCK warning one by one.
>  - Modify commit information
>  [v1] https://lore.kernel.org/all/20221206070550.31763-1-jiahao.os@bytedance.com
> 
>  kernel/sched/core.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e838feb6adc5..16a33e5adb77 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -427,11 +427,27 @@ void sched_core_put(void)
>  		schedule_work(&_work);
>  }
>  
> +static inline void sched_core_rq_clock_clear_update(struct rq *rq)
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

So sort of ok, but that function name.... so long :/

> +}
>  #else /* !CONFIG_SCHED_CORE */
>  
>  static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
>  static inline void
>  sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
> +static inline void sched_core_rq_clock_clear_update(struct rq *rq) { }
>  
>  #endif /* CONFIG_SCHED_CORE */
>  
> @@ -546,6 +562,7 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
>  		if (likely(lock == __rq_lockp(rq))) {
>  			/* preempt_count *MUST* be > 1 */
>  			preempt_enable_no_resched();
> +			sched_core_rq_clock_clear_update(rq);
>  			return;
>  		}
>  		raw_spin_unlock(lock);

This otoh don't make much sense. Why put it here and not extend
rq_pin_lock()?

That is, what's wrong with something like so?

---

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 771f8ddb7053..c1a92eced930 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1571,11 +1571,18 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 	rf->cookie = lockdep_pin_lock(__rq_lockp(rq));
 
 #ifdef CONFIG_SCHED_DEBUG
-	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
-	rf->clock_update_flags = 0;
 #ifdef CONFIG_SMP
 	SCHED_WARN_ON(rq->balance_callback && rq->balance_callback != &balance_push_callback);
 #endif
+	rf->clock_update_flags = 0;
+	if (sched_core_enabled()) {
+		int i;
+
+		for_each_cpu(i, cpu_smt_mask(rq->cpu))
+			cpu_rq(i)->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+	} else {
+		rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+	}
 #endif
 }
 
