Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D131D715D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjE3LdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjE3LdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:33:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1723DB0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WB+yIqgigjsMJU+pmIJhr0L5/N01D3S4/hmCXl95j2w=; b=Ok5AOcmXDveW4ul2r2wvht3ODo
        m8IurmHuSCIwNHChjXeUSH0OhSfbxMg30gsWqF8dgXHU8zQnNZzthRpSzuBm5j6/yLtyhOhp5wYLW
        Yg00SSCvKD8Xlj5poqNQM0EOzAOUtCqPT0rzQsiQA1fJwv81OqvhI+VOD0R+EzoL9HcoDx8iOjEX3
        EPqtVQFajziFcRdHGOCNORTJnJKpZ+Hex0SwOv13LzSPJYlLzUeyTEDXuR/oQ06c4rs96NylBrhPz
        L35gqkLVATQ5each8vR5w/V5J8g1h1XiijEbCpy15RDXIkNZz4MVNP1q4w2couzqtzgdzjkJoN55J
        Hke4m/NQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q3xat-00DhiJ-0e;
        Tue, 30 May 2023 11:32:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44FF8300454;
        Tue, 30 May 2023 13:32:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29AEE24AEF73C; Tue, 30 May 2023 13:32:49 +0200 (CEST)
Date:   Tue, 30 May 2023 13:32:49 +0200
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
Message-ID: <20230530113249.GA156198@hirez.programming.kicks-ass.net>
References: <20230519001709.2563-1-tj@kernel.org>
 <20230523111818.GH4253@hirez.programming.kicks-ass.net>
 <ZHAHjXL1e-H1PCqQ@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHAHjXL1e-H1PCqQ@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 03:12:45PM -1000, Tejun Heo wrote:

> CONCLUSION
> ==========
> 
> With the SIS_NODE enabled, there's no downside to CACHE. It always
> outperforms or matches SYSTEM. It's possible that the overhead of searching
> further for an idle CPU is more pronounced on bigger machines but most
> likely so will be the gains. This looks like a no brainer improvement to me.

OK, looking at it again, I think it can be done a little simpler, but it
should be mostly the same.

I'll go queue the below in sched/core, we'll see if anything comes up
negative.

---
Subject: sched/fair: Multi-LLC select_idle_sibling()
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue May 30 13:20:46 CEST 2023

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
---
 kernel/sched/fair.c     |   38 ++++++++++++++++++++++++++++++++++++++
 kernel/sched/features.h |    1 +
 2 files changed, 39 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7028,6 +7028,38 @@ static int select_idle_cpu(struct task_s
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
+		struct sched_domain *sd_child;
+
+		sd_child = per_cpu(sd_llc, cpu);
+		if (sd_child != sd) {
+			int i = select_idle_cpu(p, sd_child, test_idle_cores(cpu), cpu);
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
@@ -7199,6 +7231,12 @@ static int select_idle_sibling(struct ta
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
 
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
  */
 SCHED_FEAT(SIS_PROP, false)
 SCHED_FEAT(SIS_UTIL, true)
+SCHED_FEAT(SIS_NODE, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
