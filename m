Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D4C748396
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjGEL5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjGEL5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:57:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED4A198C;
        Wed,  5 Jul 2023 04:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qWOXZoOwtdv2FTUEyab7Ca0ycVEr64BN5CCvi3RnzVY=; b=cT31V9jF0tfm4rnAxYjuHtnWGy
        rhUW9thkhku4AnYgcBEsmh4hV9JOfiaD7nDNIdS37kFzrIgy9n8arX0jwrSchI3xcooZixM8ZoFMc
        +7kzvem+apw+5OZwQuOiTUUVbZ/hqa2hI+ll5JqKL5UF8FVYcfMw66633lEn58QgB70pQTMKpn46b
        4yiNPGBLZLlaGkyO/jDsPSwGIL2snOGLD5Icaxhz6qrrfIdm4PuAVkcUv8PyvUUW2KLQ2uhmjAcgS
        84aOtf/FtuQMk8CXhjzhjwKD6ZUXSxHQzvOU0o2GyAOv6BONzscCA+ql/XbogjQW+2excN5DR3wWn
        eKuSG1uQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qH184-00A2sW-7U; Wed, 05 Jul 2023 11:57:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA9543001E7;
        Wed,  5 Jul 2023 13:57:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE617200E5EA2; Wed,  5 Jul 2023 13:57:02 +0200 (CEST)
Date:   Wed, 5 Jul 2023 13:57:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <20230705115702.GY4253@hirez.programming.kicks-ass.net>
References: <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
 <20230601111326.GV4253@hirez.programming.kicks-ass.net>
 <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601144706.GA559454@hirez.programming.kicks-ass.net>
 <7bee9860-2d2a-067b-adea-04012516095c@amd.com>
 <20230602065438.GB620383@hirez.programming.kicks-ass.net>
 <bd083d8d-023a-698e-701b-725f1b15766e@amd.com>
 <20230613082536.GI83892@hirez.programming.kicks-ass.net>
 <f212f491-cd3f-6eee-20d7-8f9ab8937902@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f212f491-cd3f-6eee-20d7-8f9ab8937902@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 12:04:48PM +0530, K Prateek Nayak wrote:

> [2] https://lore.kernel.org/all/3402dcc4-d52f-d99f-e6ce-b435478a5a59@amd.com/

With the crucial bit being:

 		per_cpu(cpu_llc_id, cpu) = c->apicid >> 3;
+		per_cpu(cpu_mc_id, cpu) = c->apicid >> 4;

Would need some adjustments for <Zen3 I would think, because this simply
groups two LLCs, but those chips have a 4 core LLC and might be better
off with something like >> 5 instead.

> Conclusion seems to be that most workloads would like to run on an idle
> thread as quickly as possible, however, once the system becomes
> overloaded, even iterating over the groups to find an idle CPU outside
> of the target group can affect the workload performance. TOPOEXT is a
> clean way to limit search (as long as marking the boundaries can be
> done in a clean way) but there are concerns about the load balancing
> jitters the new domain will introduce. There will also be an increase
> in amount of C2C transfers as some of the shared data structures are
> accessed and modified (for example sched_domain_shared->has_idle_cores
> updates).

So per the parent of all this, I do think we want something like
SIS_NODE, at the very least for the desktop parts, doubly so for the
<Zen3 parts that have super dinky LLCs (like TJs desktop).

It's just that your big-ass chips need a little 'help' and in that
regard the TOPOEXT thing does look the most reasonable of the bunch.

One variant I did consider was to make SIS_NODE a domain flag, that
way the architecture can decide and we run less risk of randomly
regressing other archs that might not want this.

(did not yet test the SD flag version below)

---
Subject: sched/fair: Multi-LLC select_idle_sibling()

Tejun reported that when he targets workqueues towards a specific LLC
on his Zen2 machine with 3 cores / LLC and 4 LLCs in total, he gets
significant idle time.

This is, of course, because of how select_idle_sibling() will not
consider anything outside of the local LLC, and since all these tasks
are short running the periodic idle load balancer is ineffective.

And while it is good to keep work cache local, it is better to not
have significant idle time. Therefore, have select_idle_sibling() try
other LLCs inside the same node when the local one comes up empty.

Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/168560901866.404.8439301702539997013.tip-bot2@tip-bot2
---
 arch/x86/kernel/smpboot.c      |    2 +-
 include/linux/sched/sd_flags.h |    7 +++++++
 kernel/sched/fair.c            |   38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -596,7 +596,7 @@ static inline int x86_sched_itmt_flags(v
 #ifdef CONFIG_SCHED_MC
 static int x86_core_flags(void)
 {
-	return cpu_core_flags() | x86_sched_itmt_flags();
+	return cpu_core_flags() | x86_sched_itmt_flags() | SD_IDLE_SIBLING;
 }
 #endif
 #ifdef CONFIG_SCHED_SMT
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -161,3 +161,10 @@ SD_FLAG(SD_OVERLAP, SDF_SHARED_PARENT |
  * NEEDS_GROUPS: No point in preserving domain if it has a single group.
  */
 SD_FLAG(SD_NUMA, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
+
+/*
+ * Search for idle CPUs in sibling groups
+ *
+ * NEEDS_GROUPS: Load balancing flag.
+ */
+SD_FLAG(SD_IDLE_SIBLING, SDF_NEEDS_GROUPS)
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7046,6 +7046,38 @@ static int select_idle_cpu(struct task_s
 }
 
 /*
+ * For the multiple-LLC per node case, make sure to try the other LLC's if the
+ * local LLC comes up empty.
+ */
+static int
+select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
+{
+	struct sched_domain *parent = sd->parent;
+	struct sched_group *sg;
+
+	/* Make sure to not cross nodes. */
+	if (!parent || parent->flags & SD_NUMA)
+		return -1;
+
+	sg = parent->groups;
+	do {
+		int cpu = cpumask_first(sched_group_span(sg));
+		struct sched_domain *sd_child = per_cpu(sd_llc, cpu);
+
+		if (!cpus_share_cache(cpu, target) && sd_child) {
+			int i = select_idle_cpu(p, sd_child,
+						test_idle_cores(cpu), cpu);
+			if ((unsigned)i < nr_cpumask_bits)
+				return i;
+		}
+
+		sg = sg->next;
+	} while (sg != parent->groups);
+
+	return -1;
+}
+
+/*
  * Scan the asym_capacity domain for idle CPUs; pick the first idle one on which
  * the task fits. If no CPU is big enough, but there are idle ones, try to
  * maximize capacity.
@@ -7217,6 +7249,12 @@ static int select_idle_sibling(struct ta
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
+	if (sd->flags & SD_IDLE_SIBLING) {
+		i = select_idle_node(p, sd, target);
+		if ((unsigned)i < nr_cpumask_bits)
+			return i;
+	}
+
 	return target;
 }
 
