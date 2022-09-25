Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AFA5E93B1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 16:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiIYOls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 10:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiIYOlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 10:41:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838622DABB
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 07:41:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t7so6667861wrm.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=o98Owo/cazdQCIpyZbsHknX+Bzko5QxNVdsJZAzn3+o=;
        b=JEfeEN3NoI1t9hP1zimNRatHAKYgiG2LcewfCuDPWKnmAa2d98GEb4u6ir+INOOq9S
         GSnPDj38YK0xAOMl6ARNoRJdSR0m8V6yKPNbEkjhIhzUNB5eebT70D4wQlnU4Jl24+Ml
         u/jKl6GU0ayXQ7YdGMLq+O1RoTTi/7g3OmSUHlddldFd7finCpJ16qLKhopu94PR4qKo
         nLz0t8ZYIOgtDkiFUlTC8bRMWWSSVRmDMGxCyHeIuOYmSQKrQ8k9s45CRVB/jUXKdQYc
         mQqpJtkQZJ5PPnTgRQsxhnBGexquCtMDU3RBm1fKzgSU+qPkaHNYd8VAydAQKkac4OvE
         keUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=o98Owo/cazdQCIpyZbsHknX+Bzko5QxNVdsJZAzn3+o=;
        b=7X1bc9pO+ms6jfpDZNV80tWd8DGzNE9EHfmw0NTqdgXcmHh9tVJEocooUnHezLXXYM
         Fc1+oOQFkLOmlOQgW+9QynZx9vzprsZZPQbLo+MlSeZ8Pl9o8ckbOp8Pg17334CvMoUL
         KSHfBNDy5qPG5MkUMqnZj/RskLeVBEgI6UGjOZYk+lDUHg7bI2b/d55DQfU7biDhDxCA
         1z3NeQhserFxKNjN1b81vCOY2e3kjySwZjBZTWXL4gsgXPZLvL+e64EpmCItl8i9lVTu
         eNFQdL60PF2eV+QYeYKZZYdWxZ04mW9lCCLBIkqd5hZxGRZDJG3DEb0a4P/vZImW7qZd
         djWg==
X-Gm-Message-State: ACrzQf29CCoN1KyPEOFNFBjpYv6PhSb20oxK1g2+s0b9koX/cUFd9AG8
        9zo+NHhBbU8UqT9UCKOCuYagGA==
X-Google-Smtp-Source: AMsMyM7Ncanlah9exUhnT80/ZanFQ7pPEX1lTu2dpg7wexA4/x1UQwdOajD3SQIVPMZ/oWliErGrFg==
X-Received: by 2002:a5d:6b49:0:b0:225:6e92:22f5 with SMTP id x9-20020a5d6b49000000b002256e9222f5mr10336647wrw.529.1664116881981;
        Sun, 25 Sep 2022 07:41:21 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003b47b913901sm20774761wms.1.2022.09.25.07.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 07:41:20 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 5/7] sched/fair: Add sched group latency support
Date:   Sun, 25 Sep 2022 16:39:06 +0200
Message-Id: <20220925143908.10846-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220925143908.10846-1-vincent.guittot@linaro.org>
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Task can set its latency priority with sched_setattr(), which is then used
to set the latency offset of its sched_entity, but sched group entities
still have the default latency offset value.

Add a latency.nice field in cpu cgroup controller to set the latency
priority of the group similarly to sched_setattr(). The latency priority
is then used to set the offset of the sched_entities of the group.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 Documentation/admin-guide/cgroup-v2.rst |  8 ++++
 kernel/sched/core.c                     | 53 +++++++++++++++++++++++++
 kernel/sched/fair.c                     | 33 +++++++++++++++
 kernel/sched/sched.h                    |  4 ++
 4 files changed, 98 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index be4a77baf784..d8ae7e411f9c 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1095,6 +1095,14 @@ All time durations are in microseconds.
         values similar to the sched_setattr(2). This maximum utilization
         value is used to clamp the task specific maximum utilization clamp.
 
+  cpu.latency.nice
+	A read-write single value file which exists on non-root
+	cgroups.  The default is "0".
+
+	The nice value is in the range [-20, 19].
+
+	This interface file allows reading and setting latency using the
+	same values used by sched_setattr(2).
 
 
 Memory
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 00fa2da12506..e8a1105bc87d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10890,6 +10890,48 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 {
 	return sched_group_set_idle(css_tg(css), idle);
 }
+
+static s64 cpu_latency_nice_read_s64(struct cgroup_subsys_state *css,
+				    struct cftype *cft)
+{
+	int last_delta = INT_MAX;
+	int prio, delta;
+	s64 weight;
+
+	weight = css_tg(css)->latency_offset * NICE_LATENCY_WEIGHT_MAX;
+	weight = div_s64(weight, sysctl_sched_latency);
+
+	/* Find the closest nice value to the current weight */
+	for (prio = 0; prio < ARRAY_SIZE(sched_latency_to_weight); prio++) {
+		delta = abs(sched_latency_to_weight[prio] - weight);
+		if (delta >= last_delta)
+			break;
+		last_delta = delta;
+	}
+
+	return LATENCY_TO_NICE(prio-1);
+}
+
+static int cpu_latency_nice_write_s64(struct cgroup_subsys_state *css,
+				     struct cftype *cft, s64 nice)
+{
+	s64 latency_offset;
+	long weight;
+	int idx;
+
+	if (nice < MIN_LATENCY_NICE || nice > MAX_LATENCY_NICE)
+		return -ERANGE;
+
+	idx = NICE_TO_LATENCY(nice);
+	idx = array_index_nospec(idx, LATENCY_NICE_WIDTH);
+	weight = sched_latency_to_weight[idx];
+
+	latency_offset = sysctl_sched_latency * weight;
+	latency_offset = div_s64(latency_offset, NICE_LATENCY_WEIGHT_MAX);
+
+	return sched_group_set_latency(css_tg(css), latency_offset);
+}
+
 #endif
 
 static struct cftype cpu_legacy_files[] = {
@@ -10904,6 +10946,11 @@ static struct cftype cpu_legacy_files[] = {
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
@@ -11121,6 +11168,12 @@ static struct cftype cpu_files[] = {
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
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c3f857630dcf..74e42d19c1ce 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11768,6 +11768,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		goto err;
 
 	tg->shares = NICE_0_LOAD;
+	tg->latency_offset = 0;
 
 	init_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
@@ -11866,6 +11867,9 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	}
 
 	se->my_q = cfs_rq;
+
+	se->latency_offset = tg->latency_offset;
+
 	/* guarantee group entities always have weight */
 	update_load_set(&se->load, NICE_0_LOAD);
 	se->parent = parent;
@@ -11996,6 +12000,35 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	return 0;
 }
 
+int sched_group_set_latency(struct task_group *tg, s64 latency)
+{
+	int i;
+
+	if (tg == &root_task_group)
+		return -EINVAL;
+
+	if (abs(latency) > sysctl_sched_latency)
+		return -EINVAL;
+
+	mutex_lock(&shares_mutex);
+
+	if (tg->latency_offset == latency) {
+		mutex_unlock(&shares_mutex);
+		return 0;
+	}
+
+	tg->latency_offset = latency;
+
+	for_each_possible_cpu(i) {
+		struct sched_entity *se = tg->se[i];
+
+		WRITE_ONCE(se->latency_offset, latency);
+	}
+
+	mutex_unlock(&shares_mutex);
+	return 0;
+}
+
 #else /* CONFIG_FAIR_GROUP_SCHED */
 
 void free_fair_sched_group(struct task_group *tg) { }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 80c4d2f5827f..a15fb955092c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -407,6 +407,8 @@ struct task_group {
 
 	/* A positive value indicates that this is a SCHED_IDLE group. */
 	int			idle;
+	/* latency constraint of the group. */
+	int			latency_offset;
 
 #ifdef	CONFIG_SMP
 	/*
@@ -517,6 +519,8 @@ extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
 
 extern int sched_group_set_idle(struct task_group *tg, long idle);
 
+extern int sched_group_set_latency(struct task_group *tg, s64 latency);
+
 #ifdef CONFIG_SMP
 extern void set_task_rq_fair(struct sched_entity *se,
 			     struct cfs_rq *prev, struct cfs_rq *next);
-- 
2.17.1

