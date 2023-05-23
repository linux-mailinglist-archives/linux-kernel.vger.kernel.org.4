Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9048870DB5B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbjEWLSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEWLSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:18:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3216BC4
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=V1J0Y/GZcMpx8weVZkJ4F9rLuT21EnsgcCTnK29Bs7w=; b=KvWE3zEQEaAJ93p+ygeu5nw84r
        cq5bmfhrq/P3sikIYToafCdmBFun/j1H8mERDMVf9A5geE2aVokt6PennG69yvO1RHXTisEXn1fi1
        NqkgJik0Z1nNsTdDfF5Z3I7HONO1EV4kYH5Lz2wnTTDK9k0SWSFsCVhL2XldWxsR+NQFygdBQAPJS
        6PzjOxGmDjWBtSkYhLlTl9q3MwW4bMtfUS4pX8Y5TKgd0M3sIUK0mY5pwuvidscbmfnw6uJhgLidS
        CG8c4vHMN/FhthpLr4ek/zAHOCUBBOfXLfdRgY53fOpAq4nekfTRueJIdVzCZV0p0IhSHQULOerfd
        uXfcdSUQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1Q1z-003Unp-2J;
        Tue, 23 May 2023 11:18:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A5BF5300338;
        Tue, 23 May 2023 13:18:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F9332012158D; Tue, 23 May 2023 13:18:18 +0200 (CEST)
Date:   Tue, 23 May 2023 13:18:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, gautham.shenoy@amd.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
Message-ID: <20230523111818.GH4253@hirez.programming.kicks-ass.net>
References: <20230519001709.2563-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519001709.2563-1-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 02:16:45PM -1000, Tejun Heo wrote:

> Most of the patchset are workqueue internal plumbing and probably aren't
> terribly interesting. Howver, the performance picture turned out less
> straight-forward than I had hoped, mostly likely due to loss of
> work-conservation from scheduler in high fan-out scenarios. I'll describe it
> in this cover letter. Please read on.

> Here's the relevant part of the experiment setup.
> 
> * Ryzen 9 3900x - 12 cores / 24 threads spread across 4 L3 caches.
>   Core-to-core latencies across L3 caches are ~2.6x worse than within each
>   L3 cache. ie. it's worse but not hugely so. This means that the impact of
>   L3 cache locality is noticeable in these experiments but may be subdued
>   compared to other setups.

*blink*, 12 cores with 4 LLCs ? that's a grand total of 3 cores / 6
threads per LLC. That's puny.

/me goes google a bit.. So these are Zen2 things which nominally have 4
cores per CCX which has 16M of L3, but these must binned parts with only
3 functional cores per CCX.

Zen3 then went to 8 cores per CCX with double the L3.

> 2. MED: Fewer issuers, enough work for saturation
> 
>                   Bandwidth (MiBps)    CPU util (%)    vs. SYSTEM BW (%)
>   ----------------------------------------------------------------------
>   SYSTEM             1155.40  ±0.89     97.41 ±0.05                 0.00
>   CACHE              1154.40  ±1.14     96.15 ±0.09                -0.09
>   CACHE+STRICT       1112.00  ±4.64     93.26 ±0.35                -3.76
>   SYSTEM+LOCAL       1066.80  ±2.17     86.70 ±0.10                -7.67
>   CACHE+LOCAL        1034.60  ±1.52     83.00 ±0.07               -10.46
> 
> There are still eight issuers and plenty of work to go around. However, now,
> depending on the configuration, we're starting to see a significant loss of
> work-conservation where CPUs sit idle while there's work to do.
> 
> * CACHE is doing okay. It's just a bit slower. Further testing may be needed
>   to definitively confirm the bandwidth gap but the CPU util difference
>   seems real, so while minute, it did lose a bit of work-conservation.
>   Comparing it to CACHE+STRICT, it's starting to show the benefits of
>   non-strict scopes.

So wakeup based placement is mostly all about LLC, and given this thing
has dinky small LLCs it will pile up on the one LLC you target and leave
the others idle until the regular idle balancer decides to make an
appearance and move some around.

But if these are fairly short running tasks, I can well see that not
going to help much.


Much of this was tuned back when there was 1 L3 per Node; something
which is still more or less true for Intel but clearly not for these
things.


The below is a bit crude and completely untested, but it might help. The
flip side of that coin is of course that people are going to complain
about how selecting a CPU is more expensive now and how this hurts their
performance :/

Basically it will try and iterate all L3s in a node; wakeup will still
refuse to cross node boundaries.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 48b6f0ca13ac..ddb7f16a07a9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7027,6 +7027,33 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	return idle_cpu;
 }
 
+static int
+select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
+{
+	struct sched_domain *sd_node = rcu_dereference(per_cpu(sd_node, target));
+	struct sched_group *sg;
+
+	if (!sd_node || sd_node == sd)
+		return -1;
+
+	sg = sd_node->groups;
+	do {
+		int cpu = cpumask_first(sched_group_span(sg));
+		struct sched_domain *sd_child;
+
+		sd_child = per_cpu(sd_llc, cpu);
+		if (sd_child != sd) {
+			int i = select_idle_cpu(p, sd_child, test_idle_cores(cpu), cpu);
+			if ((unsigned int)i < nr_cpumask_bits)
+				return i;
+		}
+
+		sg = sg->next;
+	} while (sg != sd_node->groups);
+
+	return -1;
+}
+
 /*
  * Scan the asym_capacity domain for idle CPUs; pick the first idle one on which
  * the task fits. If no CPU is big enough, but there are idle ones, try to
@@ -7199,6 +7226,12 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
+	if (sched_feat(SIS_NODE)) {
+		i = select_idle_node(p, sd, target);
+		if ((unsigned)i < nr_cpumask_bits)
+			return i;
+	}
+
 	return target;
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..f965cd4a981e 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
  */
 SCHED_FEAT(SIS_PROP, false)
 SCHED_FEAT(SIS_UTIL, true)
+SCHED_FEAT(SIS_NODE, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 678446251c35..d2e0e2e496a6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1826,6 +1826,7 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
 DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_node);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ca4472281c28..d94cbc2164ca 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -667,6 +667,7 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
 DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_node);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
@@ -691,6 +692,18 @@ static void update_top_cache_domain(int cpu)
 	per_cpu(sd_llc_id, cpu) = id;
 	rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
 
+	while (sd && sd->parent) {
+		/*
+		 * SD_NUMA is the first domain spanning nodes, therefore @sd
+		 * must be the domain that spans a single node.
+		 */
+		if (sd->parent->flags & SD_NUMA)
+			break;
+
+		sd = sd->parent;
+	}
+	rcu_assign_pointer(per_cpu(sd_node, cpu), sd);
+
 	sd = lowest_flag_domain(cpu, SD_NUMA);
 	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
 
