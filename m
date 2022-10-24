Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC45E60AFB1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiJXPzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJXPyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:54:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7605ABD58
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:50:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 310CA21C84;
        Mon, 24 Oct 2022 13:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666618478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ImreeuArvuFlzuXHlMGqiwaDyxSqf0XmqLxafPgkXAg=;
        b=uuLF3WCH/7NgC82P+tGqqqYyZyJzBU9MMM821fTNsndm3pAlHRmvdiB2Pa+VO2dtyht2xQ
        tZjJEkY0QkQAPLUNFd1tfg9NcV6o/HmJxz+C/xpFZ2occ+Hzutwxp7WFioUC76WTO9lfmN
        712eA/coY7yiVCM8/d0Ui+5sGFKQ6kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666618478;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ImreeuArvuFlzuXHlMGqiwaDyxSqf0XmqLxafPgkXAg=;
        b=3/aBhi5XysuU7FCdVTiUZF4Opn5ocgshYqh0nk3ssWSNMKR4YLzlMTok8QLjGQDXrZw7EJ
        AwMkCirBOdjTP4AA==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DEA932C141;
        Mon, 24 Oct 2022 13:34:36 +0000 (UTC)
Date:   Mon, 24 Oct 2022 14:34:35 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/numa: Stop an exhastive search if an idle core
 is found
Message-ID: <20221024133435.e2kajx5k7jzznp25@suse.de>
References: <20221021061558.34767-1-jiahao.os@bytedance.com>
 <20221021061558.34767-2-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20221021061558.34767-2-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 02:15:57PM +0800, Hao Jia wrote:
> In update_numa_stats() we try to find an idle cpu on the NUMA node,
> preferably an idle core. When we find an idle core,
> we can stop searching.
> 
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> ---
>  kernel/sched/fair.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e4a0b8bd941c..b7cbec539c77 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1792,7 +1792,7 @@ static void update_numa_stats(struct task_numa_env *env,
>  		ns->nr_running += rq->cfs.h_nr_running;
>  		ns->compute_capacity += capacity_of(cpu);
>  
> -		if (find_idle && !rq->nr_running && idle_cpu(cpu)) {
> +		if (find_idle && idle_core < 0 && !rq->nr_running && idle_cpu(cpu)) {
>  			if (READ_ONCE(rq->numa_migrate_on) ||
>  			    !cpumask_test_cpu(cpu, env->p->cpus_ptr))
>  				continue;
> @@ -1801,6 +1801,9 @@ static void update_numa_stats(struct task_numa_env *env,
>  				ns->idle_cpu = cpu;
>  
>  			idle_core = numa_idle_core(idle_core, cpu);
> +			/* If we find an idle core, stop searching. */
> +			if (idle_core >= 0)
> +				ns->idle_cpu = idle_core;
>  		}
>  	}
>  	rcu_read_unlock();
> @@ -1808,9 +1811,6 @@ static void update_numa_stats(struct task_numa_env *env,
>  	ns->weight = cpumask_weight(cpumask_of_node(nid));
>  
>  	ns->node_type = numa_classify(env->imbalance_pct, ns);
> -
> -	if (idle_core >= 0)
> -		ns->idle_cpu = idle_core;
>  }
>  

Remove the change in the first hunk and call break in the second hunk
after updating ns->idle_cpu.

-- 
Mel Gorman
SUSE Labs
