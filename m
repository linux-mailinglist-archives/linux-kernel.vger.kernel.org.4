Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5131D72C321
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjFLLjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjFLLiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:38:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069937EF8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MZfdnj2p3ESjPjuAdt5qtqvlnJmptetaTLnWFGztx/8=; b=D7nzu/Oha8FGLyzs6OSF1OsnfV
        i0DBF6E8rGU0fCy7dAJmVne83GbD51uCJ5xJc/+2tOcgd2xfwEfBLenRIBkkZm1uHyaqqrKBDVy76
        QxcETJzzYiWQDfM2yQqBF3wmxsCY0SN+9+gAuPg0VQEIuIZZeePyqaHFGvYJkSPqfX4lScc7U2SnU
        B54qr01ET7O0Y2zT5MljOSKBp8DNgljVhLdBtKM1GYr+OczwOk32OhAEj2vA4Q+G75u4rYc4PltQk
        skTES9MyK3ZYAPIZFJZ79VFzr2RP5qEbdxyBNxs+3EVxFg1IwgpRdqKoNgQOLyXY0cjFMgJny7MJL
        YZKYU4Og==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8fk3-008nFj-04;
        Mon, 12 Jun 2023 11:29:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78D21300195;
        Mon, 12 Jun 2023 13:29:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5285124513501; Mon, 12 Jun 2023 13:29:45 +0200 (CEST)
Date:   Mon, 12 Jun 2023 13:29:45 +0200
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
Subject: Re: [Patch v2 2/6] sched/topology: Record number of cores in sched
 group
Message-ID: <20230612112945.GK4253@hirez.programming.kicks-ass.net>
References: <cover.1686263351.git.tim.c.chen@linux.intel.com>
 <a8acc91631a1c044ee16081bc80c1b044827c7b2.1686263351.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8acc91631a1c044ee16081bc80c1b044827c7b2.1686263351.git.tim.c.chen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 03:32:28PM -0700, Tim Chen wrote:
> From: Tim C Chen <tim.c.chen@linux.intel.com>
> 
> When balancing sibling domains that have different number of cores,
> tasks in respective sibling domain should be proportional to the number
> of cores in each domain. In preparation of implementing such a policy,
> record the number of tasks in a scheduling group.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/sched.h    |  1 +
>  kernel/sched/topology.c | 10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3d0eb36350d2..5f7f36e45b87 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1860,6 +1860,7 @@ struct sched_group {
>  	atomic_t		ref;
>  
>  	unsigned int		group_weight;
> +	unsigned int		cores;
>  	struct sched_group_capacity *sgc;
>  	int			asym_prefer_cpu;	/* CPU of highest priority in group */
>  	int			flags;
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 6d5628fcebcf..6b099dbdfb39 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1275,14 +1275,22 @@ build_sched_groups(struct sched_domain *sd, int cpu)
>  static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
>  {
>  	struct sched_group *sg = sd->groups;
> +	struct cpumask *mask = sched_domains_tmpmask2;
>  
>  	WARN_ON(!sg);
>  
>  	do {
> -		int cpu, max_cpu = -1;
> +		int cpu, cores = 0, max_cpu = -1;
>  
>  		sg->group_weight = cpumask_weight(sched_group_span(sg));
>  
> +		cpumask_copy(mask, sched_group_span(sg));
> +		for_each_cpu(cpu, mask) {
> +			cores++;
> +			cpumask_andnot(mask, mask, cpu_smt_mask(cpu));
> +		}
> +		sg->cores = cores;
> +
>  		if (!(sd->flags & SD_ASYM_PACKING))
>  			goto next;

Just a note; not sure we want or can do anything about this, but
consider someone doing partitions like:

	[0,1] [2,3] [3,6]
	[------] [------]

That is, 3 SMT cores, and 2 partitions splitting an SMT core in two.

Then the domain trees will see either 2 or 3 but not the fully core.

I'm perfectly fine with saying: don't do that then.
