Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32E5718046
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbjEaMtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbjEaMs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:48:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC56E41
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=u3VdHODagUcuhecPEM096ZQQiQ+UGylL9VNtBc1yvAs=; b=Q+A/Qhlx4B3kLfqcrDZlOjwFq8
        O8gkyzEhIEd8ORhr2Whn3Fqe4UY0syT85g2dKRIViHBw88XiFbqawPJVzdMibqupkUe4hpxh1eO/U
        V17hEgz+zzQ0k8jwq9ZVkPlJojvW2BJeDamjRirFA5w1aKZ8dhFBHkTFWIpXbqE5o+okMFeSDRxL5
        NWdYCxzQb/Evx26YWpLjZBW+RcktcrrF1HzzUlfCClL/F6qFr3vHPh+OlRkh4iOJ0C8vjBS+oKmm/
        A5cXmyWJu6TTReOhv4b9zNsjLbYa/j0MPra8o4rxAhQLxRwvsCCJx3WtuBn39IPJhHzJ0DFm/erGS
        KZh5P6pQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4LEp-00FSLD-2z;
        Wed, 31 May 2023 12:47:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 838AC300C0E;
        Wed, 31 May 2023 14:47:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0AF2B22BA645A; Wed, 31 May 2023 14:47:34 +0200 (CEST)
Message-ID: <20230531124604.205287511@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 31 May 2023 13:58:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: [PATCH 09/15] sched/debug: Rename min_granularity to base_slice
References: <20230531115839.089944915@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EEVDF uses this tunable as the base request/slice -- make sure the
name reflects this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |    2 +-
 kernel/sched/debug.c |    4 ++--
 kernel/sched/fair.c  |   12 ++++++------
 kernel/sched/sched.h |    2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4464,7 +4464,7 @@ static void __sched_fork(unsigned long c
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
 	p->se.vlag			= 0;
-	p->se.slice			= sysctl_sched_min_granularity;
+	p->se.slice			= sysctl_sched_base_slice;
 	INIT_LIST_HEAD(&p->se.group_node);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -347,7 +347,7 @@ static __init int sched_init_debug(void)
 	debugfs_create_file("preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
 #endif
 
-	debugfs_create_u32("min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_min_granularity);
+	debugfs_create_u32("base_slice_ns", 0644, debugfs_sched, &sysctl_sched_base_slice);
 
 	debugfs_create_u32("latency_warn_ms", 0644, debugfs_sched, &sysctl_resched_latency_warn_ms);
 	debugfs_create_u32("latency_warn_once", 0644, debugfs_sched, &sysctl_resched_latency_warn_once);
@@ -862,7 +862,7 @@ static void sched_debug_header(struct se
 	SEQ_printf(m, "  .%-40s: %Ld\n", #x, (long long)(x))
 #define PN(x) \
 	SEQ_printf(m, "  .%-40s: %Ld.%06ld\n", #x, SPLIT_NS(x))
-	PN(sysctl_sched_min_granularity);
+	PN(sysctl_sched_base_slice);
 	P(sysctl_sched_child_runs_first);
 	P(sysctl_sched_features);
 #undef PN
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -75,8 +75,8 @@ unsigned int sysctl_sched_tunable_scalin
  *
  * (default: 0.75 msec * (1 + ilog(ncpus)), units: nanoseconds)
  */
-unsigned int sysctl_sched_min_granularity			= 750000ULL;
-static unsigned int normalized_sysctl_sched_min_granularity	= 750000ULL;
+unsigned int sysctl_sched_base_slice			= 750000ULL;
+static unsigned int normalized_sysctl_sched_base_slice	= 750000ULL;
 
 /*
  * After fork, child runs first. If set to 0 (default) then
@@ -237,7 +237,7 @@ static void update_sysctl(void)
 
 #define SET_SYSCTL(name) \
 	(sysctl_##name = (factor) * normalized_sysctl_##name)
-	SET_SYSCTL(sched_min_granularity);
+	SET_SYSCTL(sched_base_slice);
 #undef SET_SYSCTL
 }
 
@@ -943,7 +943,7 @@ int sched_update_scaling(void)
 
 #define WRT_SYSCTL(name) \
 	(normalized_sysctl_##name = sysctl_##name / (factor))
-	WRT_SYSCTL(sched_min_granularity);
+	WRT_SYSCTL(sched_base_slice);
 #undef WRT_SYSCTL
 
 	return 0;
@@ -964,9 +964,9 @@ static void update_deadline(struct cfs_r
 	/*
 	 * For EEVDF the virtual time slope is determined by w_i (iow.
 	 * nice) while the request time r_i is determined by
-	 * sysctl_sched_min_granularity.
+	 * sysctl_sched_base_slice.
 	 */
-	se->slice = sysctl_sched_min_granularity;
+	se->slice = sysctl_sched_base_slice;
 
 	/*
 	 * EEVDF: vd_i = ve_i + r_i / w_i
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2479,7 +2479,7 @@ extern void check_preempt_curr(struct rq
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
-extern unsigned int sysctl_sched_min_granularity;
+extern unsigned int sysctl_sched_base_slice;
 
 #ifdef CONFIG_SCHED_DEBUG
 extern int sysctl_resched_latency_warn_ms;


