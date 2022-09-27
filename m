Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AA25EC060
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiI0LDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiI0LC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:02:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30A75B05B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wYhiq2/Za/de0IEl5LhlGi70WgQaMWWx/ATEKmG1PWU=; b=QJ1Hq7/hcmtvhS9BDeKIkGYVYb
        g0ULCQ4QLTgW2qPHtwe4OXju8ssrE8ArhQmuJf5JAyYoatdddt9BCq/aLQ1kdvSKnkUfVYARtUK9P
        +bYSIxTBYtrfNV/esromWGfdA1ksfa7NNTrw0ubdtgQwY1IenS2oP+7wnypD/Eizv1gxjh8J6z1Ry
        CZ0ozMfS9BUIfP9+YIVZVFlQ0QEAe45KQhah5o78RsMoBKKCTc470SBxoBBui1J/vRLEMK4l/FU++
        CqORrWeebBbQfWmQf2ra/lLn8dMOojfc2LhX2ahH5yzg9Q4brNYDl+D9zEWhuXCc3fLn1puV8qlst
        IExeE9tg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1od8LG-00GGo7-Pb; Tue, 27 Sep 2022 11:01:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5CC2A300205;
        Tue, 27 Sep 2022 13:01:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 123062BDDA85A; Tue, 27 Sep 2022 13:01:33 +0200 (CEST)
Date:   Tue, 27 Sep 2022 13:01:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 09/23] sched/fair: Use task-class performance score
 to pick the busiest group
Message-ID: <YzLYDPU+upHeUG65@hirez.programming.kicks-ass.net>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-10-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909231205.14009-10-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 04:11:51PM -0700, Ricardo Neri wrote:
> update_sd_pick_busiest() keeps on selecting as the busiest group scheduling
> groups of identical priority. Since both groups have the same priority,
> either group is a good choice. The classes of tasks in the scheduling
> groups can break this tie.
> 
> Pick as busiest the scheduling group that yields a higher task-class
> performance score after load balancing.

> +/**
> + * sched_asym_class_pick - Select a sched group based on classes of tasks
> + * @a:		A scheduling group
> + * @b:		A second scheduling group
> + * @a_stats:	Load balancing statistics of @a
> + * @b_stats:	Load balancing statistics of @b
> + *
> + * Returns: true if @a has the same priority and @a has classes of tasks that
> + * yield higher overall throughput after load balance. Returns false otherwise.
> + */
> +static bool sched_asym_class_pick(struct sched_group *a,
> +				  struct sched_group *b,
> +				  struct sg_lb_stats *a_stats,
> +				  struct sg_lb_stats *b_stats)
> +{
> +	/*
> +	 * Only use the class-specific preference selection if both sched
> +	 * groups have the same priority.
> +	 */
> +	if (arch_asym_cpu_priority(a->asym_prefer_cpu) !=
> +	    arch_asym_cpu_priority(b->asym_prefer_cpu))
> +		return false;
> +
> +	return sched_asym_class_prefer(a_stats, b_stats);
> +}
> +
>  #else /* CONFIG_SCHED_TASK_CLASSES */
>  static void update_rq_task_classes_stats(struct sg_lb_task_class_stats *class_sgs,
>  					 struct rq *rq)

> @@ -9049,6 +9111,12 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  		/* Prefer to move from lowest priority CPU's work */
>  		if (sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
>  			return false;
> +
> +		/* @sg and @sds::busiest have the same priority. */
> +		if (sched_asym_class_pick(sds->busiest, sg, &sds->busiest_stat, sgs))
> +			return false;
> +
> +		/* @sg has lower priority than @sds::busiest. */
>  		break;
>  
>  	case group_misfit_task:

So why does only this one instance of asym_prefer() require tie
breaking?

I must also re-iterate how much I hate having two different means of
dealing with big-little topologies.

And while looking through this, I must ask about the comment that goes
with sched_set_itmt_core_prio() vs the sg->asym_prefer_cpu assignment in
init_sched_groups_capacity(), what-up ?!


