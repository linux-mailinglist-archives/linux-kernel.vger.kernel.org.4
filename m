Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D515BA7C0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiIPIEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiIPIDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:03:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E53A50F8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:03:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g3so13801654wrq.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=tKt+6OFmIt3Z0xnB+vzUXObwuSdNapz5e2blq4g9QGQ=;
        b=Ll/VfUsKJx+YkFaTpFXyr99e2u1OICPXG8rEdBFbQDJKr8bNQ1ueCKgydggbMunYWJ
         RqP8wtXW2t5/JjF0yGqNWPD+Jp++VCePswHtCWvCpPTzQf9j+fP24sGKek8GTyhcFdKi
         /L+3GLrMRW0knpkuYvqBZ5L8G1DpAAK3yZd6GUyAaMfHE5P930wOl1SJAW5wkS7NKEL/
         bfGDkw6xOBXeqbifbweMxb2ch3umYwe8MlcsiyQU2V0V/V1TmuUFoMsbyqKGel48rAXD
         Jeala/WM9kmOaCFS/PRIHgWQXfsQZSb/e4opsbQMLrGs0poFpmqNQR/6R4R1uYS/KXzo
         i/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tKt+6OFmIt3Z0xnB+vzUXObwuSdNapz5e2blq4g9QGQ=;
        b=JXeJWg/aonnnX8hAz2J+f0LKQElrs5/YRsxhP0Uwj5+6jDgy1pgqm+aKi1pWQefZij
         5XptZbr2vMkVzu1GxpQFs+YNkQIkarZ8NQIc2ldXa2lYbmRPJiblqqgs+s3ahsaHT0RA
         AoPmNElFjKNTU7VgACRcb+1EE05PKQtqNQVo/3UwBLLLADB4IO7gOQbUV6jEG7NNA2dl
         SVIYYo/M45nIj+E0QwVc4RpK79g0JGcjv+EVNmLFJ7KZtqqv3LFTdQan9YJ8qrv0HCVO
         StkgP6/CQi+pGLDPOk3t/ATlG7V/vSgMJQvN/RrBivuJ6vhbOBS4Eimw5OPJTJ/J1l+E
         Lxxg==
X-Gm-Message-State: ACrzQf0Fy55BdK3HQmrXWr4kFnBnx0NWEo+/cy6DQPEv7zHbgLv6NHXt
        N04JApK1vqNPNIuBbR217IryHQ==
X-Google-Smtp-Source: AMsMyM5544La3lNG4clTsASzgNQneqKZeBHDPi4P3eVPIU9yTe8oxohxpPwShzUCgoMKf73he/YFGg==
X-Received: by 2002:a05:6000:10d2:b0:228:d60b:6d5a with SMTP id b18-20020a05600010d200b00228d60b6d5amr1932207wrx.146.1663315404718;
        Fri, 16 Sep 2022 01:03:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9ab:1164:827a:1548])
        by smtp.gmail.com with ESMTPSA id c9-20020adffb49000000b00228dbf15072sm4418116wrs.62.2022.09.16.01.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 01:03:23 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 6/8] sched/fair: Add sched group latency support
Date:   Fri, 16 Sep 2022 10:03:03 +0200
Message-Id: <20220916080305.29574-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220916080305.29574-1-vincent.guittot@linaro.org>
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Task can set its latency priority, which is then used to decide to preempt
the current running entity of the cfs, but sched group entities still have
the default latency offset.

Add a latency field in task group to set the latency offset of the
sched_eneities of the group, which will be used against other entities in
the parent cfs when deciding which entity to schedule first.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  | 24 ++++++++++++++++++++++++
 kernel/sched/fair.c  | 33 +++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  4 ++++
 3 files changed, 61 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 13cf794708ee..bfea862a3588 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10860,6 +10860,19 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 {
 	return sched_group_set_idle(css_tg(css), idle);
 }
+
+static s64 cpu_latency_read_s64(struct cgroup_subsys_state *css,
+			       struct cftype *cft)
+{
+	return css_tg(css)->latency_offset;
+}
+
+static int cpu_latency_write_s64(struct cgroup_subsys_state *css,
+				struct cftype *cft, s64 latency)
+{
+	return sched_group_set_latency(css_tg(css), latency);
+}
+
 #endif
 
 static struct cftype cpu_legacy_files[] = {
@@ -10874,6 +10887,11 @@ static struct cftype cpu_legacy_files[] = {
 		.read_s64 = cpu_idle_read_s64,
 		.write_s64 = cpu_idle_write_s64,
 	},
+	{
+		.name = "latency",
+		.read_s64 = cpu_latency_read_s64,
+		.write_s64 = cpu_latency_write_s64,
+	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
@@ -11091,6 +11109,12 @@ static struct cftype cpu_files[] = {
 		.read_s64 = cpu_idle_read_s64,
 		.write_s64 = cpu_idle_write_s64,
 	},
+	{
+		.name = "latency",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_s64 = cpu_latency_read_s64,
+		.write_s64 = cpu_latency_write_s64,
+	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a20eadb0af97..6cc4f2a9725d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11769,6 +11769,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		goto err;
 
 	tg->shares = NICE_0_LOAD;
+	tg->latency_offset = 0;
 
 	init_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
@@ -11867,6 +11868,9 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	}
 
 	se->my_q = cfs_rq;
+
+	se->latency_offset = tg->latency_offset;
+
 	/* guarantee group entities always have weight */
 	update_load_set(&se->load, NICE_0_LOAD);
 	se->parent = parent;
@@ -11997,6 +12001,35 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	return 0;
 }
 
+int sched_group_set_latency(struct task_group *tg, long latency)
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
index a4cb8058f1b2..619132f4f480 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -406,6 +406,8 @@ struct task_group {
 
 	/* A positive value indicates that this is a SCHED_IDLE group. */
 	int			idle;
+	/* latency constraint of the group. */
+	int			latency_offset;
 
 #ifdef	CONFIG_SMP
 	/*
@@ -519,6 +521,8 @@ extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
 
 extern int sched_group_set_idle(struct task_group *tg, long idle);
 
+extern int sched_group_set_latency(struct task_group *tg, long latency);
+
 #ifdef CONFIG_SMP
 extern void set_task_rq_fair(struct sched_entity *se,
 			     struct cfs_rq *prev, struct cfs_rq *next);
-- 
2.17.1

