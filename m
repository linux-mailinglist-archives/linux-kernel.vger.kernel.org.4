Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5746F82C8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjEEMRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjEEMR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:17:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2621AEF8
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 05:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gJLRDNAR1F+aLGKRxOr/9uYw7UxjykTc11rSfQeoudE=; b=DRx3chfHxG0m6jR51c8HYrPNbF
        vXsg7EwMHsx7rLYVo0EXHBP3eMKfhp/4qHxMR9AElBFw7ZP9c64GnxHkwOZspbNSLTi6akaUx01/L
        Xu/P1W52mZ+44ii0G11E8alnhteZQOywT1Jwg/QuTvYYxebsBf/LqB6u/sKQ5cRgQ3IPAocTD3s+R
        pa78WfewHBvXwUlUag8pJzYOFlsM89npabM2IXppAVnIPfPvhn10N5Y8RL1ti7aRQVqu4pRhYyock
        Ns0qxbxKOXuEOO6gVrhiEWK+kIpL3Y8b+GshhTsfwBVQkfiuVRjIuNwom+OhR5eRM0u6CFbube64L
        R/FW9eAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puuMV-003F6j-0M;
        Fri, 05 May 2023 12:16:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A46C730049C;
        Fri,  5 May 2023 14:16:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 59B1720CCBEDB; Fri,  5 May 2023 14:16:31 +0200 (CEST)
Date:   Fri, 5 May 2023 14:16:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH 2/6] sched/fair: Check whether active load balance is
 needed in busiest group
Message-ID: <20230505121631.GF4253@hirez.programming.kicks-ass.net>
References: <cover.1683156492.git.tim.c.chen@linux.intel.com>
 <231cf298efb8627499bb42788588a6108c7b8f7c.1683156492.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <231cf298efb8627499bb42788588a6108c7b8f7c.1683156492.git.tim.c.chen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 09:09:52AM -0700, Tim Chen wrote:
> From: Tim C Chen <tim.c.chen@linux.intel.com>
> 
> In the busiest group, we need to consider whether active load balance
> to a local group is needed even when it is not overloaded.  For example,
> when the busiest group is a SMT group that's fully busy and the destination group
> is a cluster group with idle CPU.  Such condition is considered by
> asym_active_balance() in load balancing but not when looking for busiest
> group and load imbalance.  Add this consideration in find_busiest_group()
> and calculate_imbalance().
> 
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 87317634fab2..bde962aa160a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9433,6 +9433,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  				sgs->group_capacity;
>  }
>  
> +/* One group is SMT while the other group is not */
> +static inline bool asymmetric_groups(struct sched_group *sg1,
> +				    struct sched_group *sg2)
> +{
> +	if (!sg1 || !sg2)
> +		return false;
> +
> +	return (sg1->flags & SD_SHARE_CPUCAPACITY) !=
> +		(sg2->flags & SD_SHARE_CPUCAPACITY);
> +}
> +
>  /**
>   * update_sd_pick_busiest - return 1 on busiest group
>   * @env: The load balancing environment.
> @@ -10079,6 +10090,31 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  	update_idle_cpu_scan(env, sum_util);
>  }
>  
> +static inline bool asym_active_balance_busiest(struct lb_env *env, struct sd_lb_stats *sds)
> +{
> +	/*
> +	 * Don't balance to a group without spare capacity.
> +	 *
> +	 * Skip non asymmetric sched group balancing. That check
> +	 * is handled by code path handling imbalanced load between
> +	 * similar groups.
> +	 */
> +	if (env->idle == CPU_NOT_IDLE ||
> +	    sds->local_stat.group_type != group_has_spare ||
> +	    !asymmetric_groups(sds->local, sds->busiest))
> +		return false;
> +
> +	/*
> +	 * For SMT source group, pull when there are two or more
> +	 * tasks over-utilizing a core.
> +	 */
> +	if (sds->busiest->flags & SD_SHARE_CPUCAPACITY &&
> +	    sds->busiest_stat.sum_h_nr_running > 1)
> +		return true;
> +
> +	return false;
> +}

This all seems to be mixing two 'asymmetric' things in the 'asym'
namespace :/ One being the SD_ASYM_PACKING and then the above SMT/no-SMT
core thing.

> +
>  /**
>   * calculate_imbalance - Calculate the amount of imbalance present within the
>   *			 groups of a given sched_domain during load balance.
> @@ -10164,6 +10200,12 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  			return;
>  		}
>  
> +		if (asym_active_balance_busiest(env, sds)) {
> +			env->migration_type = migrate_task;
> +			env->imbalance = 1;
> +			return;
> +		}
> +
>  		if (busiest->group_weight == 1 || sds->prefer_sibling) {
>  			unsigned int nr_diff = busiest->sum_nr_running;
>  			/*
> @@ -10371,6 +10413,9 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  			 */
>  			goto out_balanced;
>  
> +		if (asym_active_balance_busiest(env, &sds))
> +			goto force_balance;
> +
>  		if (busiest->group_weight > 1 &&
>  		    local->idle_cpus <= (busiest->idle_cpus + 1))
>  			/*

All the cases here have a nice (CodingStyle busting) comment, perhaps
add the missing {} when hou add the comment?
