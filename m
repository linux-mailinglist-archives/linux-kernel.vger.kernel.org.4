Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A846CBD1B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjC1LH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjC1LHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:07:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492DA7ED2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RbXpNNyQy70ib4Jj0GWzgjHznjjhFi1aoqEifEGuN8w=; b=bcaKZK9KU3oB6IYT5WXTKlI6uY
        nhIrEwk4ky2Bsx2P9MgHGbx8TLr/cy9WBXS6VPyPHIIdiZeHAEhobzqb1AKB6pS/qB9aEw3BcIwbj
        Hgn1OMmBgxKngkS7LhzcyUMnJNv9dwyAgOsB4+HH+rHHV7diGwTiykEA/R/VYzxCw0comz1XhrjmP
        RrgCMtILKdOG7ZM5Pjhw+jXMErzo3BkgPLjyWK1N9rG8Sqw5f0ZxidNI0PS80EdrSuL7WWYjqLfQc
        PAcmD5dJgeNx6Gl8r7mq0o/JB4lc9jBFpmpp582ZwyzeWmNySVIp0DbjWuwrf6Uud9Ve66Z6hCrH2
        szMYaWjA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ph79l-006XUt-00;
        Tue, 28 Mar 2023 11:06:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC6E4300AFB;
        Tue, 28 Mar 2023 13:06:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AF23A2CB8CEBA; Tue, 28 Mar 2023 13:06:20 +0200 (CEST)
Message-ID: <20230328110353.779246960@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 28 Mar 2023 11:26:25 +0200
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
        joel@joelfernandes.org, efault@gmx.de
Subject: [PATCH 03/17] sched/fair: Add sched group latency support
References: <20230328092622.062917921@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>

Task can set its latency priority with sched_setattr(), which is then used
to set the latency offset of its sched_enity, but sched group entities
still have the default latency offset value.

Add a latency.nice field in cpu cgroup controller to set the latency
priority of the group similarly to sched_setattr(). The latency priority
is then used to set the offset of the sched_entities of the group.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lkml.kernel.org/r/20230224093454.956298-7-vincent.guittot@linaro.org
---
 Documentation/admin-guide/cgroup-v2.rst |   10 ++++++++++
 kernel/sched/core.c                     |   30 ++++++++++++++++++++++++++++++
 kernel/sched/fair.c                     |   32 ++++++++++++++++++++++++++++++++
 kernel/sched/sched.h                    |    4 ++++
 4 files changed, 76 insertions(+)

--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1121,6 +1121,16 @@ All time durations are in microseconds.
         values similar to the sched_setattr(2). This maximum utilization
         value is used to clamp the task specific maximum utilization clamp.
 
+  cpu.latency.nice
+	A read-write single value file which exists on non-root
+	cgroups.  The default is "0".
+
+	The nice value is in the range [-20, 19].
+
+	This interface file allows reading and setting latency using the
+	same values used by sched_setattr(2). The latency_nice of a group is
+	used to limit the impact of the latency_nice of a task outside the
+	group.
 
 
 Memory
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11068,6 +11068,25 @@ static int cpu_idle_write_s64(struct cgr
 {
 	return sched_group_set_idle(css_tg(css), idle);
 }
+
+static s64 cpu_latency_nice_read_s64(struct cgroup_subsys_state *css,
+				    struct cftype *cft)
+{
+	return PRIO_TO_NICE(css_tg(css)->latency_prio);
+}
+
+static int cpu_latency_nice_write_s64(struct cgroup_subsys_state *css,
+				     struct cftype *cft, s64 nice)
+{
+	int prio;
+
+	if (nice < MIN_NICE || nice > MAX_NICE)
+		return -ERANGE;
+
+	prio = NICE_TO_PRIO(nice);
+
+	return sched_group_set_latency(css_tg(css), prio);
+}
 #endif
 
 static struct cftype cpu_legacy_files[] = {
@@ -11082,6 +11101,11 @@ static struct cftype cpu_legacy_files[]
 		.read_s64 = cpu_idle_read_s64,
 		.write_s64 = cpu_idle_write_s64,
 	},
+	{
+		.name = "latency.nice",
+		.read_s64 = cpu_latency_nice_read_s64,
+		.write_s64 = cpu_latency_nice_write_s64,
+	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
@@ -11299,6 +11323,12 @@ static struct cftype cpu_files[] = {
 		.read_s64 = cpu_idle_read_s64,
 		.write_s64 = cpu_idle_write_s64,
 	},
+	{
+		.name = "latency.nice",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_s64 = cpu_latency_nice_read_s64,
+		.write_s64 = cpu_latency_nice_write_s64,
+	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12264,6 +12264,7 @@ int alloc_fair_sched_group(struct task_g
 		goto err;
 
 	tg->shares = NICE_0_LOAD;
+	tg->latency_prio = DEFAULT_PRIO;
 
 	init_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
@@ -12362,6 +12363,9 @@ void init_tg_cfs_entry(struct task_group
 	}
 
 	se->my_q = cfs_rq;
+
+	se->latency_offset = calc_latency_offset(tg->latency_prio - MAX_RT_PRIO);
+
 	/* guarantee group entities always have weight */
 	update_load_set(&se->load, NICE_0_LOAD);
 	se->parent = parent;
@@ -12490,6 +12494,34 @@ int sched_group_set_idle(struct task_gro
 
 	mutex_unlock(&shares_mutex);
 	return 0;
+}
+
+int sched_group_set_latency(struct task_group *tg, int prio)
+{
+	long latency_offset;
+	int i;
+
+	if (tg == &root_task_group)
+		return -EINVAL;
+
+	mutex_lock(&shares_mutex);
+
+	if (tg->latency_prio == prio) {
+		mutex_unlock(&shares_mutex);
+		return 0;
+	}
+
+	tg->latency_prio = prio;
+	latency_offset = calc_latency_offset(prio - MAX_RT_PRIO);
+
+	for_each_possible_cpu(i) {
+		struct sched_entity *se = tg->se[i];
+
+		WRITE_ONCE(se->latency_offset, latency_offset);
+	}
+
+	mutex_unlock(&shares_mutex);
+	return 0;
 }
 
 #else /* CONFIG_FAIR_GROUP_SCHED */
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -378,6 +378,8 @@ struct task_group {
 
 	/* A positive value indicates that this is a SCHED_IDLE group. */
 	int			idle;
+	/* latency priority of the group. */
+	int			latency_prio;
 
 #ifdef	CONFIG_SMP
 	/*
@@ -488,6 +490,8 @@ extern int sched_group_set_shares(struct
 
 extern int sched_group_set_idle(struct task_group *tg, long idle);
 
+extern int sched_group_set_latency(struct task_group *tg, int prio);
+
 #ifdef CONFIG_SMP
 extern void set_task_rq_fair(struct sched_entity *se,
 			     struct cfs_rq *prev, struct cfs_rq *next);


