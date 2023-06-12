Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF5A72C3A6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjFLMGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjFLMGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:06:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746E98F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qLyIfMrltQo4mx+ae3hm5XlMuKTGmLlbfut2SxtVFvk=; b=fzLkX0e9EKBajzlYWiZkh7t5p3
        l8+cv8j+JxAE5D1QOE2t+D64Ec1LiUYmn+n/e1FlcKWPbrZf1o+zbwzkD3Xx+jkE23Mlbbrpl/w9G
        nCtqVDrWDnKo4PrMQhmitGyrg8ZTfjYUbliSyHgUMWu5Z8CJ9dVDFBHJvXL+/Eq/MjuGmpwc/0ftg
        GDY7ByRlV/jdfcdpbt1R18OY6yhEBTt3WU3GZjcCrTB+DyN+lgItBxAw2TWK7D7jsh3MAMnIM4EyP
        nXSRm8yVikRiWgi9czm+tnQqrsTlhB16kXd7l9J7/b/0zsk1Bd3sXAEbCGpOn8o8cqO8zxm7r0O5/
        /zGvC9lA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8gId-002bUm-Uc; Mon, 12 Jun 2023 12:05:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 34568300322;
        Mon, 12 Jun 2023 14:05:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11C602451DA8E; Mon, 12 Jun 2023 14:05:29 +0200 (CEST)
Date:   Mon, 12 Jun 2023 14:05:28 +0200
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
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [Patch v2 3/6] sched/fair: Implement prefer sibling imbalance
 calculation between asymmetric groups
Message-ID: <20230612120528.GL4253@hirez.programming.kicks-ass.net>
References: <cover.1686263351.git.tim.c.chen@linux.intel.com>
 <ef2400ea29f0e00aed1e2d75c1a352e63349059e.1686263351.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef2400ea29f0e00aed1e2d75c1a352e63349059e.1686263351.git.tim.c.chen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 03:32:29PM -0700, Tim Chen wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 03573362274f..0b0904263d51 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9372,6 +9372,65 @@ static inline bool smt_balance(struct lb_env *env, struct sg_lb_stats *sgs,
>  	return false;
>  }
>  
> +static inline long sibling_imbalance(struct lb_env *env,
> +				    struct sd_lb_stats *sds,
> +				    struct sg_lb_stats *busiest,
> +				    struct sg_lb_stats *local)
> +{
> +	int ncores_busiest, ncores_local;
> +	long imbalance;
> +
> +	if (env->idle == CPU_NOT_IDLE)
> +		return 0;
> +
> +	ncores_busiest = sds->busiest->cores;
> +	ncores_local = sds->local->cores;
> +
> +	if (ncores_busiest == ncores_local &&
> +	    (!(env->sd->flags & SD_ASYM_PACKING) ||
> +	      sched_asym_equal(env->dst_cpu,
> +			      sds->busiest->asym_prefer_cpu))) {
> +		imbalance = busiest->sum_nr_running;
> +		lsub_positive(&imbalance, local->sum_nr_running);
> +		return imbalance;
> +	}
> +
> +	/* Balance such that nr_running/ncores ratio are same on both groups */
> +	imbalance = ncores_local * busiest->sum_nr_running;
> +	lsub_positive(&imbalance, ncores_busiest * local->sum_nr_running);
> +	/* Normalize imbalance to become tasks to be moved to restore balance */
> +	imbalance /= ncores_local + ncores_busiest;
> +
> +	if (env->sd->flags & SD_ASYM_PACKING) {
> +		int limit;
> +
> +		if (!busiest->sum_nr_running)
> +			goto out;

This seems out-of-place, shouldn't we have terminate sooner if busiest
is empty?

> +
> +		if (sched_asym_prefer(env->dst_cpu, sds->busiest->asym_prefer_cpu)) {
> +			/* Don't leave preferred core idle */
> +			if (imbalance == 0 && local->sum_nr_running < ncores_local)
> +				imbalance = 1;
> +			goto out;
> +		}
> +
> +		/* Limit tasks moved from preferred group, don't leave cores idle */
> +		limit = busiest->sum_nr_running;
> +		lsub_positive(&limit, ncores_busiest);
> +		if (imbalance > limit)
> +			imbalance = limit;

How does this affect the server parts that have larger than single core
turbo domains?

> +
> +		goto out;
> +	}
> +
> +	/* Take advantage of resource in an empty sched group */
> +	if (imbalance == 0 && local->sum_nr_running == 0 &&
> +	    busiest->sum_nr_running > 1)
> +		imbalance = 1;
> +out:
> +	return imbalance << 1;
> +}


But basically you have:

        LcBn - BcLn
  imb = -----------
           LcBc

Which makes sense, except you then return:

  imb * 2

which then made me wonder about rounding.

Do we want to to add (LcBc -1) or (LcBc/2) to resp. ceil() or round()
the thing before division? Because currently it uses floor().

If you evaludate it like:


        2 * (LcBn - BcLn)
  imb = -----------------
              LcBc

The result is different from what you have now.

What actual behaviour is desired in these low imbalance cases? and can
you write a comment as to why we do as we do etc..?
