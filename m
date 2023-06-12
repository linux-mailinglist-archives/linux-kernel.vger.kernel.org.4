Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB88072C2F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbjFLLhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237809AbjFLLg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:36:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348B510E6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pl7chRYk/uyru+lQcBj9K0R9DWBsRbU5ZH1ZZl8pMdA=; b=IclETesgPyZyl+LdaUeoizqTxu
        ApimhlJ7qUFdXRHjSHXRsl+pcfSuzXDroVtLy4K5bHqU35+8IZ1isfITE6R8sXpNNCABqYuhy8QEJ
        QJU4vUAvv0U/Ulw4kMoiKKctKZ/b3n8wZq2uXmjTixK2xAaz12vRWrBa414QiX5BK5FVhEt/c2j2G
        qnq557qzlt1K3hW4yqDxvJ6JVLRrNZVjigxG1hu3vmiF1zfz1p+pPhSuLCD5Mme1CONrsohJOoqdK
        o+YcUSkISMTN6rPXMjtNgDjeiHXLtkoobufHre+WCyxBlHTyabZRHEp0f147urQRY7YHMnqUpbRZz
        QOMUwe1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8fUr-008mw5-0T;
        Mon, 12 Jun 2023 11:14:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D08C3002A9;
        Mon, 12 Jun 2023 13:13:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4130424513501; Mon, 12 Jun 2023 13:13:59 +0200 (CEST)
Date:   Mon, 12 Jun 2023 13:13:59 +0200
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
Subject: Re: [Patch v2 1/6] sched/fair: Determine active load balance for SMT
 sched groups
Message-ID: <20230612111359.GI4253@hirez.programming.kicks-ass.net>
References: <cover.1686263351.git.tim.c.chen@linux.intel.com>
 <253f5272200d3cec3f24427262bb4e95244f681c.1686263351.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253f5272200d3cec3f24427262bb4e95244f681c.1686263351.git.tim.c.chen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 03:32:27PM -0700, Tim Chen wrote:

> +/* One group has more than one SMT CPU while the other group does not */
> +static inline bool smt_vs_nonsmt_groups(struct sched_group *sg1,
> +				    struct sched_group *sg2)
> +{
> +	if (!sg1 || !sg2)
> +		return false;
> +
> +	return (sg1->flags & SD_SHARE_CPUCAPACITY) !=
> +		(sg2->flags & SD_SHARE_CPUCAPACITY);
> +}
> +
> +static inline bool smt_balance(struct lb_env *env, struct sg_lb_stats *sgs,
> +			       struct sched_group *group)
> +{
> +	if (env->idle == CPU_NOT_IDLE)
> +		return false;
> +
> +	/*
> +	 * For SMT source group, it is better to move a task
> +	 * to a CPU that doesn't have multiple tasks sharing its CPU capacity.
> +	 * Note that if a group has a single SMT, SD_SHARE_CPUCAPCITY
> +	 * will not be on.
> +	 */
> +	if (group->flags & SD_SHARE_CPUCAPACITY &&
> +	    sgs->sum_h_nr_running > 1)
> +		return true;

AFAICT this does the right thing for SMT>2

> +
> +	return false;
> +}
> +
>  static inline bool
>  sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
>  {

> @@ -9537,6 +9581,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  		break;
>  
>  	case group_has_spare:
> +		/*
> +		 * Do not pick sg with SMT CPUs over sg with pure CPUs,
> +		 * as we do not want to pull task off half empty SMT core
> +		 * and make the core idle.
> +		 */
> +		if (smt_vs_nonsmt_groups(sds->busiest, sg)) {
> +			if (sg->flags & SD_SHARE_CPUCAPACITY)
> +				return false;
> +			else
> +				return true;
> +		}

However, here I'm not at all sure. Consider SMT-4 with 2 active CPUs, we
still very much would like to pull one task off if we have an idle core
somewhere, no?

