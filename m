Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E8F74EB9F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjGKKTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjGKKS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:18:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835DCDB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vtPd+yN1U4IqTK91Y6Crv4zudJrwwIEUOH8XFLUTBIk=; b=hvSnWQcO6AvhXvooZhbMvXWvsD
        nvp9B+MHb11v440DDTeYLHOU6tgz3037srEf9cWGxMnaFWPe9iyvnR31Effg9zOFfvg67JpHoTNP7
        uLPgMxOwvbZYz7I4lEU4XTz+luagGQ12v5RAfAyCwtV63IwOgoGikK9mXfc6iPPmrTO9M7XnxLjeF
        yX+7V7VnIxskknxlXCXy1khl0hD8VLsPyAzEYaV2aExTAIaj/cabdW/dYVcEw1w76bpTGLde5t4JS
        tBYRP5PG94qiRTdOfuKEu8BitWE8Y/1ubwZvBm7t1CZh7gmxqd6qeiXQmWbt9WGXpv6mr+0UncX2H
        1nL7eIhg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJAS1-00FcUY-SJ; Tue, 11 Jul 2023 10:18:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 71A1E3002B1;
        Tue, 11 Jul 2023 12:18:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 587DB243429D0; Tue, 11 Jul 2023 12:18:32 +0200 (CEST)
Date:   Tue, 11 Jul 2023 12:18:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        gautham.shenoy@amd.com, kprateek.nayak@amd.com, aaron.lu@intel.com,
        clm@meta.com, tj@kernel.org, roman.gushchin@linux.dev,
        kernel-team@meta.com
Subject: Re: [PATCH v2 5/7] sched: Implement shared runqueue in CFS
Message-ID: <20230711101832.GF3062772@hirez.programming.kicks-ass.net>
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-6-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710200342.358255-6-void@manifault.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:03:40PM -0500, David Vernet wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1451f5aa82ac..3ad437d4ea3d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c

> @@ -9842,6 +9843,7 @@ void __init sched_init_smp(void)
>  
>  	init_sched_rt_class();
>  	init_sched_dl_class();
> +	init_sched_fair_class_late();
>  
>  	sched_smp_initialized = true;
>  }

> @@ -12854,3 +12999,34 @@ __init void init_sched_fair_class(void)
>  #endif /* SMP */
>  
>  }
> +
> +__init void init_sched_fair_class_late(void)
> +{
> +#ifdef CONFIG_SMP
> +	int i;
> +	struct shared_runq *shared_runq;
> +	struct rq *rq;
> +	struct rq *llc_rq;
> +
> +	for_each_possible_cpu(i) {
> +		if (per_cpu(sd_llc_id, i) == i) {
> +			llc_rq = cpu_rq(i);
> +
> +			shared_runq = kzalloc_node(sizeof(struct shared_runq),
> +					       GFP_KERNEL, cpu_to_node(i));
> +			INIT_LIST_HEAD(&shared_runq->list);
> +			spin_lock_init(&shared_runq->lock);
> +			llc_rq->cfs.shared_runq = shared_runq;
> +		}
> +	}
> +
> +	for_each_possible_cpu(i) {
> +		rq = cpu_rq(i);
> +		llc_rq = cpu_rq(per_cpu(sd_llc_id, i));
> +
> +		if (rq == llc_rq)
> +			continue;
> +		rq->cfs.shared_runq = llc_rq->cfs.shared_runq;
> +	}
> +#endif /* SMP */
> +}

I don't think this is right; the llc_id thing depends on the online
mask, not on possible mask. So if you boot with a number of CPUs offline
and late bring them online, you're screwy (IIRC this is actually a very
common thing in virt land).

Additionally, llc_id depends on the sched_domain tree, if someone were
to go create partitions, they can split an LLC and llc_id would split
right along with it.

I think you need to move this into sched/topology.c and handle hotplug /
domain (re) creation.

And yes, that's going to be a pain, because you might need to re-hash
existing lists.
