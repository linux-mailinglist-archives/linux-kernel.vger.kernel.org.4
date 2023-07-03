Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8A0745C60
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjGCMjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGCMjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:39:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C28BC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n+xmNRbY63Wj+K265vLukbDhB9n1gvo5j9X5rHDYiko=; b=KMT3tbKvXmeXqfsFUoPjz2G7M7
        gzz1JetiPWOuSU2CDSTYknij0kF8bWEUZLe0KV4cWtbobmD6nTk8N3xXKokLbHQ/16VIsjU7kgHzQ
        gwefmNky/EV6pnwvCfXSlWvibHBM8KO6dF36RWTfYwzFaJVg8/U4UNAoe1BRw1naB0YSSanIkEFrI
        d3qRFBiN2mffycgmT1QPAWdZoDFhCUWhBGeu4NL4vBDdPsq6GmLbNOZm1TY7XaPOiyWTxAHtPMkda
        rbI3AsUANb/+V7w/2NQEMjZxUnrMfAAPFWnQjJRW4SyshV3Yzp2JL2AyL6BDquAOO6GemM6IqFg9R
        GhYTAVew==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGIpf-00A5HE-2J;
        Mon, 03 Jul 2023 12:39:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A695930012F;
        Mon,  3 Jul 2023 14:39:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 59E99202A2A17; Mon,  3 Jul 2023 14:39:02 +0200 (CEST)
Date:   Mon, 3 Jul 2023 14:39:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        judy.chenhui@huawei.com, zhangqiao22@huawei.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/rt: Fix possible warn when push_rt_task
Message-ID: <20230703123902.GI4253@hirez.programming.kicks-ass.net>
References: <20230624092130.174409-1-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624092130.174409-1-tanghui20@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 05:21:30PM +0800, Hui Tang wrote:
> A warn may be triggered during reboot, as follows:
> 
> reboot
>   ->kernel_restart
>     ->machine_restart
>       ->smp_send_stop --- ipi handler set_cpu_online(cpu, false)
> 
> balance_callback
> -> __balance_callback
>   ->push_rt_task
>     -> find_lock_lowest_rq  --- offline cpu in vec->mask not be cleared
>       -> find_lowest_rq
>         -> cpupri_find
>           -> cpupri_find_fitness
>             -> __cpupri_find [cpumask_and(..., vec->mask)]
>     -> set_task_cpu(next_task, lowest_rq->cpu) --- WARN_ON(!oneline(cpu)
> 
> So add !cpu_online(lowest_rq->cpu) check before set_task_cpu().
> The fix does not completely fix the problem, since cpu_online_mask may
> be cleared after check.

This is tinkering.. at best. I'm sure there's a score of other issues,
not in the least the very same issue in deadline.c. But since this
doesn't actually fix anything, this clearly isn't the right way.

> Fixes: 4ff9083b8a9a8 ("sched/core: WARN() when migrating to an offline CPU")
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> ---
>  kernel/sched/rt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 00e0e5074115..852ef18b6a50 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2159,6 +2159,9 @@ static int push_rt_task(struct rq *rq, bool pull)
>  		goto retry;
>  	}
>  
> +	if (unlikely(!cpu_online(lowest_rq->cpu)))
> +		goto out;
> +
>  	deactivate_task(rq, next_task, 0);
>  	set_task_cpu(next_task, lowest_rq->cpu);
>  	activate_task(lowest_rq, next_task, 0);
> -- 
> 2.17.1
> 
