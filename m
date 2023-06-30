Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F927743E47
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjF3PHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjF3PHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:07:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61998E68
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ScEt9DiAzd+hsgUAGDc7rzKKhqHbIw5WsqFtP88mfTg=; b=ION21A1Qdt5lVgXthxTwG4DG5c
        U+tk1C/OfAls/3ZtGmKjBmI/07z9AJ7pjB+mqnLe2N8XIpHKUsP5qpaSnwwTO6Qf4U4vILjfWrnxa
        Zd7n6JIyIRWpNki/hRbL76wDVA/rssZcPOoBQwd4JGLI0BCzgWnnn0DijYbQ/JrI8TsfuZvW85HTD
        UgV3ohlYvUunqXID15ynAX3fR2hSsLJA2vwLktsyH+lZIleSgTwypbxWeMYHwOczyvc6WpSpwjSdH
        3HAwW9J8jiVCMRIqb2Fu0xIgdaniqpucnN9Hzx5yVQ+1tPRAB2ryS5xwxoc6d9Zs6o+bUQq5DSPvp
        W6qyfPJw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qFFhr-005nWB-Dg; Fri, 30 Jun 2023 15:06:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 091E63002E1;
        Fri, 30 Jun 2023 17:06:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E22E524810097; Fri, 30 Jun 2023 17:06:41 +0200 (CEST)
Date:   Fri, 30 Jun 2023 17:06:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4] Sched/fair: Block nohz tick_stop when cfs bandwidth
 in use
Message-ID: <20230630150641.GH2533791@hirez.programming.kicks-ass.net>
References: <20230630135714.1018434-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630135714.1018434-1-pauld@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 09:57:14AM -0400, Phil Auld wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a68d1276bab0..2685373e12f1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1229,6 +1229,16 @@ bool sched_can_stop_tick(struct rq *rq)
>  	if (rq->nr_running > 1)
>  		return false;
>  
> +	/*
> +	 * If there is one task and it has CFS runtime bandwidth constraints
> +	 * and it's on the cpu now we don't want to stop the tick.
> +	 */
> +	if (sched_feat(HZ_BW) && rq->nr_running == 1 && rq->curr
> +	    && rq->curr->sched_class == &fair_sched_class && task_on_rq_queued(rq->curr)) {

&& goes at the end of the previous line

rq->curr is never NULL

But surely you can find a saner way to write this?

> +		if (sched_cfs_bandwidth_active(rq->curr))
> +			return false;
> +	}
> +
>  	return true;
>  }
>  #endif /* CONFIG_NO_HZ_FULL */
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 373ff5f55884..125b1ec4476f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6139,6 +6139,50 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
>  	rcu_read_unlock();
>  }
>  
> +#ifdef CONFIG_NO_HZ_FULL
> +static inline bool cfs_se_bandwidth_enabled(struct sched_entity *se)
> +{
> +	int ret = 0;
> +
> +	for_each_sched_entity(se)
> +		ret += cfs_rq_of(se)->runtime_enabled;
> +
> +	return ret != 0;
> +}
> +
> +bool sched_cfs_bandwidth_active(struct task_struct *p)
> +{
> +	if (cfs_bandwidth_used() && cfs_se_bandwidth_enabled(&p->se))
> +		return true;
> +
> +	return false;
> +}
> +
> +/* called from pick_next_task_fair() */
> +static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
> +{
> +	int cpu = cpu_of(rq);
> +
> +	if (!sched_feat(HZ_BW) || !cfs_bandwidth_used())
> +		return;
> +
> +	if (!tick_nohz_full_cpu(cpu))
> +		return;
> +
> +	if (rq->nr_running != 1)
> +		return;
> +
> +	/*
> +	 *  We know there is only one task runnable and we've just picked it. The
> +	 *  normal enqueue path will have cleared TICK_DEP_BIT_SCHED if we will
> +	 *  be otherwise able to stop the tick. Just need to check if we are using
> +	 *  bandwidth control.
> +	 */
> +	if (cfs_se_bandwidth_enabled(&p->se))
> +		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
> +}

Yeah, I think not; pick_next_task_fair() just walked the cgroup
hierarchy and now you do it again.

Also, why does this code exist at all? Both enqueue/dequeue already end
up in sched_update_tick_depenency() and should be able to handle the
nr_running==1 with bandwidth crap, no?
