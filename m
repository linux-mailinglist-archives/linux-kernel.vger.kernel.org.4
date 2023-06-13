Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8443172DC83
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbjFMIbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbjFMIbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:31:41 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F152BE5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:31:14 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-652a6bf4e6aso4133342b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686645074; x=1689237074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBLsYYCRK+M7QM1fm/1EP1IdQg+rYVQrvl5Ag66IbpI=;
        b=HPsDq4J5O/IKVFZpARKzG5/QUls0v9oZRVCTmifME+MK9AE55F2M7SB+GZNsB8rDHG
         ocPaiGHqBjD5ae3JA2OMHTxbfy66P+eY7aXN6oxhGT3s2+cAG7fpv2EChzWowamVjGsO
         QFYeEq9PXlJE6AuDyquEm6WHSs9bygWcxhT75Oiho9Wg4AJags64jfI+W7fPAOkvokO+
         yzUzTQ4uKkiPz/6nYiqNVnvWYF/bX9kE3N4AhTRXgSI4//nc1hHOt9hBtWCAs/WC4mrD
         EuH+eE17HN4KQl8h4bPNixBZYh8ePL0hfhG460SA8dMruNkY5jSRYXYiA+NuLHmml1gZ
         QnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686645074; x=1689237074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WBLsYYCRK+M7QM1fm/1EP1IdQg+rYVQrvl5Ag66IbpI=;
        b=Tw8mC9spxbLBmuqqu/+JWHdVzJRiM+0ZwPmYwSrSoFWGnh3d7laFhcSdx9N38WBRfq
         ZfkJjS7TWIWK+IrUtRNpa8abmGM/0f5A7ufRl9JL4KiyYrcSBQ4pYV2PSUuGPfxkz8U+
         5xYQVpkph2dJDMkEtpIZ5lAhQNS74dQxJ2Wo8lopTp3WI7FA01oJqXmDfV0cEqckKBc8
         pJJbqwmlNmfQ64/TR+ULyw5EQE9AWdv7FL7SrvmYY/J2mRKy9Bf8S+ubGXuDhvrtXxNm
         DwbEkf75X50xGK1NxxBpJ+2L8VTwDH31bBWQZ+3G0uDUpctbMyl/KdCW7CDOJ/1HVvbF
         nQ1w==
X-Gm-Message-State: AC+VfDxeHzth4KT0qvf3xcC8BOBv9Dnx1Feo3BXhK8ObThFMTw55i1dO
        22w42jlFhmgbu/9H7xPdmT5Axw==
X-Google-Smtp-Source: ACHHUZ7qf8zIFKTi1bB6s8QQYmm5o7Sw8fTDibk5ylPlVn27D5AdZxqRgTRX8cddfxUJbUm3+BFsCw==
X-Received: by 2002:a17:902:e747:b0:1b3:ec39:f40d with SMTP id p7-20020a170902e74700b001b3ec39f40dmr732878plf.50.1686645074457;
        Tue, 13 Jun 2023 01:31:14 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:11b7:189f:bf83:942e:7892? ([240e:694:e21:b::2])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902b69200b001ae59169f05sm9643163pls.182.2023.06.13.01.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 01:31:13 -0700 (PDT)
Message-ID: <c06dd33c-bc91-e0a9-096c-d135ce4fedcb@bytedance.com>
Date:   Tue, 13 Jun 2023 16:31:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/4] sched/core: Fixed missing rq clock update before
 calling set_rq_offline()
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org
References: <20230613082012.49615-1-jiahao.os@bytedance.com>
 <20230613082012.49615-2-jiahao.os@bytedance.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20230613082012.49615-2-jiahao.os@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/13 Hao Jia wrote:
> This is triggered during cpu offline when CONFIG_CPU_FREQ is enabled
> and cpufreq is set to powersave:
> ------------[ cut here ]------------
> rq->clock_update_flags < RQCF_ACT_SKIP
> WARNING: CPU: 24 PID: 754 at kernel/sched/sched.h:1496
> enqueue_top_rt_rq+0x139/0x160
> Call Trace:
>   <TASK>
>   ? intel_pstate_update_util+0x3b0/0x3b0
>   rq_offline_rt+0x1b7/0x250
>   set_rq_offline.part.120+0x28/0x60
>   rq_attach_root+0xc4/0xd0
>   cpu_attach_domain+0x3dc/0x7f0
>   ? __schedule+0x65e/0x1310
>   partition_sched_domains_locked+0x2a5/0x3c0
>   rebuild_sched_domains_locked+0x477/0x830
>   ? percpu_rwsem_wait+0x140/0x140
>   rebuild_sched_domains+0x1b/0x30
>   cpuset_hotplug_workfn+0x2ca/0xc90
>   ? balance_push+0x56/0x120
>   ? _raw_spin_unlock+0x15/0x30
>   ? finish_task_switch+0x98/0x2f0
>   ? __switch_to+0x116/0x410
>   ? __schedule+0x65e/0x1310 ? internal_add_timer+0x42/0x60
>   ? _raw_spin_unlock_irqrestore+0x23/0x40
>   ? add_timer_on+0xd5/0x130
>   process_one_work+0x1bc/0x3d0
>   worker_thread+0x4c/0x380
>   ? preempt_count_add+0x56/0xa0
>   ? rescuer_thread+0x310/0x310
>   kthread+0xe6/0x110
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x1f/0x30
> 
> More detailed key function call graph:
> rq_offline_rt()
>    __disable_runtime()
>      sched_rt_rq_enqueue()
>        enqueue_top_rt_rq()
>          cpufreq_update_util() <-- depends on CONFIG_CPU_FREQ
>            data->func(data, *rq_clock(rq)*, flags)
>              intel_pstate_update_util() <-- powersave policy callback function
> 
> Before calling rq_offline_rt() we need to update the rq clock to avoid
> using the old rq clock, So we add update_rq_clock() to set_rq_offline()
> to update rq clock. And we use rq_lock_irqsave()/rq_unlock_irqrestore()
> to replace raw_spin_rq_lock_irqsave()/raw_spin_rq_unlock_irqrestore()
> in rq_attach_root() to ensure that rq->clock_update_flags are cleared
> before updating the rq clock.
> 
> Steps to reproduce:
> 1. Enable CONFIG_SMP and CONFIG_CPU_FREQ when compiling the kernel
> 2. echo 1 > /sys/kernel/debug/clear_warn_once
> 3. cpupower -c all frequency-set -g powersave
> 4. Run some rt tasks e.g. Create 5*n rt (100% running) tasks (on a
>     system with n CPUs)
> 5. Offline cpu one by one until the warninng is triggered
> 
> Suggested-by: Ben Segall <bsegall@google.com>
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>

Hi Vincent,

   Benjamin Segall suggested adding update_rq_clock() to set_rq_offline()
instead of calling update_rq_clock() before set_rq_offline() runs.
The code of patch1 has changed, so I removed your tag "Reviewed-by". 
Please review again.

Thanks,
Hao

> ---
>   kernel/sched/core.c     | 2 +-
>   kernel/sched/topology.c | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a68d1276bab0..a8be5415daba 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9548,6 +9548,7 @@ void set_rq_offline(struct rq *rq)
>   	if (rq->online) {
>   		const struct sched_class *class;
>   
> +		update_rq_clock(rq);
>   		for_each_class(class) {
>   			if (class->rq_offline)
>   				class->rq_offline(rq);
> @@ -9689,7 +9690,6 @@ int sched_cpu_deactivate(unsigned int cpu)
>   
>   	rq_lock_irqsave(rq, &rf);
>   	if (rq->rd) {
> -		update_rq_clock(rq);
>   		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
>   		set_rq_offline(rq);
>   	}
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 6682535e37c8..52976eadfee9 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -487,9 +487,9 @@ static void free_rootdomain(struct rcu_head *rcu)
>   void rq_attach_root(struct rq *rq, struct root_domain *rd)
>   {
>   	struct root_domain *old_rd = NULL;
> -	unsigned long flags;
> +	struct rq_flags rf;
>   
> -	raw_spin_rq_lock_irqsave(rq, flags);
> +	rq_lock_irqsave(rq, &rf);
>   
>   	if (rq->rd) {
>   		old_rd = rq->rd;
> @@ -515,7 +515,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
>   	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
>   		set_rq_online(rq);
>   
> -	raw_spin_rq_unlock_irqrestore(rq, flags);
> +	rq_unlock_irqrestore(rq, &rf);
>   
>   	if (old_rd)
>   		call_rcu(&old_rd->rcu, free_rootdomain);
