Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7757A719AC2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjFALNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjFALNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:13:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CA0136;
        Thu,  1 Jun 2023 04:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u627Q3DYgVjbWnZL6tHn86ZYBA0xduCF0AtpCOTzLc4=; b=eX4Vcsvaj1F4TlXNDIlie0qxhI
        xu5KyF2b8XW2Ryva3L8G3+tSx46RLmV2fB1602gYJiT78E3+xWofRFrZRghA9s6FqUgDuKie0GiJX
        MjV7qYLG2CiaeaRdC9+li3IbxfH4GBCt+srpWzhfXkTjJ2v5s7bREkYPW9ytYj/i2ECCXjypjillI
        jAFTL3ymCGty4zS0f74+sb70cKpfJWBVnXf0Dm9xL4BN0rbV6/DsLjOWYzY1OtcS/vVzr3DkNEtt3
        AX3SHUiVCDhug8lMjZcRYx3syy6kJoRC+D/rEgdFjf9z6hVkD3HRok5e3M+dLbyKl9fSghHz1L7fR
        tKK/eIOg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4gFD-008JMw-AL; Thu, 01 Jun 2023 11:13:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E49583002F0;
        Thu,  1 Jun 2023 13:13:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA06D21484ABC; Thu,  1 Jun 2023 13:13:26 +0200 (CEST)
Date:   Thu, 1 Jun 2023 13:13:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <20230601111326.GV4253@hirez.programming.kicks-ass.net>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 03:03:39PM +0530, K Prateek Nayak wrote:
> Hello Peter, 
> 
> Sharing some initial benchmark results with the patch below.
> 
> tl;dr
> 
> - Hackbench starts off well but performance drops as the number of groups
>   increases.
> 
> - schbench (old), tbench, netperf see improvement but there is a band of
>   outlier results when system is fully loaded or slightly overloaded.
> 
> - Stream and ycsb-mongodb are don't mind the extra search.
> 
> - SPECjbb (with default scheduler tunables) and DeathStarBench are not
>   very happy.

Figures :/ Every time something like this is changed someone gets to be
sad..

> Tests were run on a dual socket 3rd Generation EPYC server(2 x64C/128T)
> running in NPS1 mode. Following it the simplified machine topology:

Right, Zen3 8 cores / LLC, 64 cores total give 8 LLC per node.

> ~~~~~~~~~~~~~~~~~~~~~~~
> ~ SPECjbb - Multi-JVM ~
> ~~~~~~~~~~~~~~~~~~~~~~~
> 
> o NPS1
> 
> - Default Scheduler Tunables
> 
> kernel			max-jOPS		critical-jOPS
> tip			100.00%			100.00%
> peter-next-level	 94.45% (-5.55%)	 98.25% (-1.75%)
> 
> - Modified Scheduler Tunables
> 
> kernel			max-jOPS		critical-jOPS
> tip			100.00%			100.00%
> peter-next-level	100.00% (0.00%)		102.41% (2.41%)

I'm slightly confused, either the default or the tuned is better. Given
it's counting ops, I'm thinking higher is more better, so isn't this an
improvement in the tuned case?

> ~~~~~~~~~~~~~~~~~~
> ~ DeathStarBench ~
> ~~~~~~~~~~~~~~~~~~
> 
> Pinning   Scaling	tip		peter-next-level
> 1 CCD     1             100.00%      	100.30% (%diff:  0.30%)
> 2 CCD     2             100.00%      	100.17% (%diff:  0.17%)
> 4 CCD     4             100.00%      	 99.60% (%diff: -0.40%)
> 8 CCD     8             100.00%      	 92.05% (%diff: -7.95%)	*

Right, so that's a definite loss.

> I wonder if extending SIS_UTIL for SIS_NODE would help some of these
> cases but I've not tried tinkering with it yet. I'll continue
> testing on other NPS modes which would decrease the search scope.
> I'll also try running the same bunch of workloads on an even larger
> 4th Generation EPYC server to see if the behavior there is similar.

> >  /*
> > + * For the multiple-LLC per node case, make sure to try the other LLC's if the
> > + * local LLC comes up empty.
> > + */
> > +static int
> > +select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
> > +{
> > +	struct sched_domain *parent = sd->parent;
> > +	struct sched_group *sg;
> > +
> > +	/* Make sure to not cross nodes. */
> > +	if (!parent || parent->flags & SD_NUMA)
> > +		return -1;
> > +
> > +	sg = parent->groups;
> > +	do {
> > +		int cpu = cpumask_first(sched_group_span(sg));
> > +		struct sched_domain *sd_child;
> > +
> > +		sd_child = per_cpu(sd_llc, cpu);
> > +		if (sd_child != sd) {
> > +			int i = select_idle_cpu(p, sd_child, test_idle_cores(cpu), cpu);

Given how SIS_UTIL is inside select_idle_cpu() it should already be
effective here, no?

> > +			if ((unsigned)i < nr_cpumask_bits)
> > +				return i;
> > +		}
> > +
> > +		sg = sg->next;
> > +	} while (sg != parent->groups);
> > +
> > +	return -1;
> > +}

This DeathStarBench thing seems to suggest that scanning up to 4 CCDs
isn't too much of a bother; so perhaps something like so?

(on top of tip/sched/core from just a few hours ago, as I had to 'fix'
this patch and force pushed the thing)

And yeah, random hacks and heuristics here :/ Does there happen to be
additional topology that could aid us here? Does the CCD fabric itself
have a distance metric we can use?

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 22e0a249e0a8..f1d6ed973410 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7036,6 +7036,7 @@ select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	struct sched_domain *parent = sd->parent;
 	struct sched_group *sg;
+	int nr = 4;
 
 	/* Make sure to not cross nodes. */
 	if (!parent || parent->flags & SD_NUMA)
@@ -7050,6 +7051,9 @@ select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
 						test_idle_cores(cpu), cpu);
 			if ((unsigned)i < nr_cpumask_bits)
 				return i;
+
+			if (!--nr)
+				return -1;
 		}
 
 		sg = sg->next;
