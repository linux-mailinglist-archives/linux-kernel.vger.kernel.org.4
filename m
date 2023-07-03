Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F017453C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 04:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjGCCH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 22:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCCHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 22:07:55 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF17188
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 19:07:52 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4035dd6b349so3105311cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 19:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1688350072; x=1690942072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+NnINhqvfRXnJIdL2hBgvRljauFbXLj+yF4b2cm3b/E=;
        b=Kr9xN4nn5x1jphy0yYNW0NeOib0rvBIzfgGlT9gXEa14KJx9vBRWvhJ+3k3Cr+8sK5
         jrgjUKSOIY6VheWciYyoZPZ+Ee++IIOEHGNabq0y1YeLgAu+z2titzRkd/8HacGxlyYm
         ZHZzfC3K5xifj+CULAAKgLRMMIeE5sWmZ61Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688350072; x=1690942072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+NnINhqvfRXnJIdL2hBgvRljauFbXLj+yF4b2cm3b/E=;
        b=L/mYvhnc6m/UYq/bA2ABdIc1v6g9UmH99j82M6OdO2zHwSePCWHbDeytz/VbXMfiCY
         ZbsO7ebJT48bkckHKvbkMtGlQcos1vteYA9Pl4OlrJSaD5NJ4HC1p8dYX6TqMi0p+xWx
         gxMaGvqh2IWknNh2rGot3+4vJ6/pmIEuxPkb5xlakSdxOcFijRXkusLt5B/7/Ayd+wxf
         3a0cY6K2Ol4/T70mYU50m8NLNGYU51zDFTooZnKoHsilcp1nMT8nxjWgZ7TC4L071Bvd
         au7zyYk7TSltlQ03S3aB+t+CFg81dwO613JTn0FKPfScuk4wbwdjEFQEStfqvjIaaOKz
         yJyg==
X-Gm-Message-State: AC+VfDx/8QyWRJmbLdrE8yaZEM5nLufk7VqrEAmnV9ejlKW8D+1x7VRI
        VcFmwuAlLpzAtXD+os3WMIZ+FQ==
X-Google-Smtp-Source: ACHHUZ58VBYyJUbCNzd8mG8P9Txf2iGK6zR6PNsaUyTQFYo54Ya89fn5cjA5qRqy+pJxyt9oOC/HHQ==
X-Received: by 2002:a05:622a:24b:b0:400:98d4:78c6 with SMTP id c11-20020a05622a024b00b0040098d478c6mr11223957qtx.49.1688350071973;
        Sun, 02 Jul 2023 19:07:51 -0700 (PDT)
Received: from [10.5.0.2] ([45.85.145.152])
        by smtp.gmail.com with ESMTPSA id cf18-20020a05622a401200b003f9af049c55sm6122496qtb.18.2023.07.02.19.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 19:07:51 -0700 (PDT)
Message-ID: <7d372630-31cb-22c1-12f6-0d77fb0387c6@joelfernandes.org>
Date:   Sun, 2 Jul 2023 22:07:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] sched/core: introduce sched_core_idle_cpu()
Content-Language: en-US
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, boqun.feng@gmail.com,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang1.zhang@intel.com, jstultz@google.com,
        clingutla@codeaurora.org, nsaenzju@redhat.com, tglx@linutronix.de,
        frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1688011324-42406-1-git-send-email-CruzZhao@linux.alibaba.com>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <1688011324-42406-1-git-send-email-CruzZhao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/2023 12:02 AM, Cruz Zhao wrote:
> As core scheduling introduced, a new state of idle is defined as
> force idle, running idle task but nr_running greater than zero.
> 
> If a cpu is in force idle state, idle_cpu() will return zero. This
> result makes sense in some scenarios, e.g., load balance,
> showacpu when dumping, and judge the RCU boost kthread is starving.
> 
> But this will cause error in other scenarios, e.g., tick_irq_exit():
> When force idle, rq->curr == rq->idle but rq->nr_running > 0, results
> that idle_cpu() returns 0. In function tick_irq_exit(), if idle_cpu()
> is 0, tick_nohz_irq_exit() will not be called, and ts->idle_active will
> not become 1, which became 0 in tick_nohz_irq_enter().
> ts->idle_sleeptime won't update in function update_ts_time_stats(), if
> ts->idle_active is 0, which should be 1. And this bug will result that
> ts->idle_sleeptime is less than the actual value, and finally will
> result that the idle time in /proc/stat is less than the actual value.
> 
> To solve this problem, we introduce sched_core_idle_cpu(), which
> returns 1 when force idle. We audit all users of idle_cpu(), and
> change idle_cpu() into sched_core_idle_cpu() in function
> tick_irq_exit().

Reviewed-by: Joel Fernandes <joel@joelfernandes.org>

 - Joel


> 
> v2-->v3: Only replace idle_cpu() with sched_core_idle_cpu() in
> function tick_irq_exit(). And modify the corresponding commit log.
> 
> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> Reviewed-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Joel Fernandes <joel@joelfernandes.org>
> Link: https://lore.kernel.org/lkml/1687631295-126383-1-git-send-email-CruzZhao@linux.alibaba.com
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
