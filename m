Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D40735653
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjFSL6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFSL6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:58:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BDFB3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 04:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oanGpIVnmNDJ42HG0BJHoWH2TaXRJrMbzL5szTBJMgg=; b=hGJgEy8kj060xYe6Pm1j1/K7ll
        WzLUiWXGSiFSEL5uvsajrYxFb5skntJP3xhRG7nxH+qucknA+ZQUDMvvzxwRK6HVX/Pw8sXzNNNIu
        LLBYTp4LQ+4Fr6myzI+w5DhUP4d+v3bxqC2Pg+Nyo03P25gdvrPiU0b3NU06YdSoXbUgt9bLQmz4g
        kWCQD+qbXgCk6kXiDn9YQSY1rkRyO/OWaeNt6PrqBlgq4Qnar8zjJ9rk0xNiA/loV6E8LlUdqsJ2G
        E8aIldL/fLcL2i/KAuZzomLFsWT/VbMvL5EtSxHaOPJxL7FSAOGm8RT7ACpLKV298oh/sak2t090V
        AavpKYeg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBDWd-00EiRH-2I;
        Mon, 19 Jun 2023 11:58:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E5D7300322;
        Mon, 19 Jun 2023 13:58:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2DE9D24653290; Mon, 19 Jun 2023 13:58:26 +0200 (CEST)
Date:   Mon, 19 Jun 2023 13:58:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, nsaenzju@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: fix inaccurate idle stat in /proc/stat when
 force idle
Message-ID: <20230619115826.GN4253@hirez.programming.kicks-ass.net>
References: <1687107760-111340-1-git-send-email-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687107760-111340-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 01:02:40AM +0800, Cruz Zhao wrote:
> When force idle, rq->curr == rq->idle but rq->nr_running > 0, results
> that idle_cpu() returns 0. In function tick_irq_exit(), if idle_cpu()
> is 0, tick_nohz_irq_exit() will not be called, and ts->idle_active will
> not become 1, which became 0 in tick_nohz_irq_enter().
> ts->idle_sleeptime won't update in function update_ts_time_stats(), if
> ts->idle_active is 0, which should be 1. And this bug will result that
> ts->idle_sleeptime is less than the actual value, and finally will
> result that the idle time in /proc/stat is less than the actual value.
> 
> To fix this problem, we introduce sched_core_idle_cpu(), which returns
> true when force idle, and we change the judgment criteria from
> idle_cpu() to sched_core_idle_cpu() in function tick_irq_exit().
> 
> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> ---
>  include/linux/sched.h |  2 ++
>  kernel/sched/core.c   | 13 +++++++++++++
>  kernel/softirq.c      |  2 +-
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index b09a83bfad8b..73e61c0f10a7 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2430,9 +2430,11 @@ extern void sched_core_free(struct task_struct *tsk);
>  extern void sched_core_fork(struct task_struct *p);
>  extern int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
>  				unsigned long uaddr);
> +extern int sched_core_idle_cpu(int cpu);
>  #else
>  static inline void sched_core_free(struct task_struct *tsk) { }
>  static inline void sched_core_fork(struct task_struct *p) { }
> +static inline int sched_core_idle_cpu(int cpu) { return idle_cpu(cpu); }
>  #endif
>  
>  extern void sched_set_stop_task(int cpu, struct task_struct *stop);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 71c1a0f232b4..c80088956987 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7286,6 +7286,19 @@ struct task_struct *idle_task(int cpu)
>  	return cpu_rq(cpu)->idle;
>  }
>  
> +#ifdef CONFIG_SCHED_CORE
> +int sched_core_idle_cpu(int cpu)
> +{
> +	struct rq *rq = cpu_rq(cpu);
> +
> +	if (sched_core_enabled(rq) && rq->curr == rq->idle)
> +		return 1;
> +
> +	return idle_cpu(cpu);
> +}
> +
> +#endif
> +
>  #ifdef CONFIG_SMP
>  /*
>   * This function computes an effective utilization for the given CPU, to be
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index c8a6913c067d..98b98991ce45 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -630,7 +630,7 @@ static inline void tick_irq_exit(void)
>  	int cpu = smp_processor_id();
>  
>  	/* Make sure that timer wheel updates are propagated */
> -	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
> +	if ((sched_core_idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
>  		if (!in_hardirq())
>  			tick_nohz_irq_exit();
>  	}

Urgh...

did you audit all idle_cpu() users?

Or so we want something like so instead?

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..b0a1cd184b1b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7303,6 +7303,11 @@ int idle_cpu(int cpu)
 	if (rq->curr != rq->idle)
 		return 0;
 
+#ifdef CONFIG_SCHED_CORE
+	if (sched_core_enabled() && rq->core->core_forceidle_count)
+		return 1;
+#endif
+
 	if (rq->nr_running)
 		return 0;
 
