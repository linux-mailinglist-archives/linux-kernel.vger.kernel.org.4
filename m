Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766A262A022
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiKORUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiKORTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:19:18 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A10D28E06
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:19:12 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id y16so25429168wrt.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ykXig/7XYkSW6Dkf0nyYluv6HE0QJzXE3P7uP1TrGB4=;
        b=wyOX2yEa2/MbyLgnbvcqOW23Zx89ycJpBs4987F8pDWadxSSrwJZWacT0K4X+6RenJ
         vVTOqRrn1zdMc9PynswpdGXTxQqRhJNT/xlDbhJSBjxP8I1Ad4g9ckwYjfV/d2vGyBwm
         1SBL1F2I2BirHq7WO+3/CtUkKBnp10TAcw22IGGeu+wwrA+a2Rso7hpcmOhUlyoP69rf
         bhwRGif9HhYCLGbjKXlOt1+X2XLP9nRBgbDS/f8JVOlXUCsUUszwLwd4NHaRyjidGc0m
         n5n/O2R3YyUaEnqOI/PUFpglQ4G04g1T7getnbftyaW7+CGo+vFJTne59NyxTFCa74/h
         liCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykXig/7XYkSW6Dkf0nyYluv6HE0QJzXE3P7uP1TrGB4=;
        b=qj4kRadcKUX8lQvDHc2G9+rNN7KQ5Tg38LW8iY1zn6rOhJturno9K+YlWHRbngTgcL
         ZXvc02iAzpfuBeV0FFQ0odQhvCX0gtcKN/skCBOviqcHfAak0LXMbbYLLCGQhhbYH3I4
         +zjhkM4z/ids0JauFClkjGRa76Wm7tQcJlktCttmIMshoJwngc5n9Qw6CEaK5TB1eZkY
         UzIiOIC7oG9dYF6YIlIdoWg6JCFx+qfn6NRccBkS2/HbhPf4lxyhKXgAOi7X/wruKUTS
         haSO/sPRqa94zKFBnBNGDmxVkAkNZdyqs04jxEyFIvxpHWxeHkvyKOnGVOyG222l8jg2
         b1gQ==
X-Gm-Message-State: ANoB5plS6EhcAdjF6QKfKQKz3WlJbMpwiWinFQE/aqpBEdOVKBBO1WbQ
        vsCEvB0H4eU547V48cQ3PC8/sy+smQZBkg==
X-Google-Smtp-Source: AA0mqf4oFfok5jL+YpUZVWqvut8Le0wvdvUkCNuknFwDnQvsdheDgjSQN25NVOA2tzxLigrimAtiDg==
X-Received: by 2002:adf:e4c1:0:b0:236:4ba1:fb2d with SMTP id v1-20020adfe4c1000000b002364ba1fb2dmr11855364wrm.570.1668532751530;
        Tue, 15 Nov 2022 09:19:11 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:91c8:7496:8b73:811f])
        by smtp.gmail.com with ESMTPSA id bg40-20020a05600c3ca800b003cf78aafdd7sm16846461wmb.39.2022.11.15.09.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 09:19:10 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v9 6/9] sched/fair: Add sched group latency support
Date:   Tue, 15 Nov 2022 18:18:48 +0100
Message-Id: <20221115171851.835-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221115171851.835-1-vincent.guittot@linaro.org>
References: <20221115171851.835-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Task can set its latency priority with sched_setattr(), which is then used
to set the latency offset of its sched_enity, but sched group entities
still have the default latency offset value.

Add a latency.nice field in cpu cgroup controller to set the latency
priority of the group similarly to sched_setattr(). The latency priority
is then used to set the offset of the sched_entities of the group.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 Documentation/admin-guide/cgroup-v2.rst | 10 +++++
 kernel/sched/core.c                     | 52 +++++++++++++++++++++++++
 kernel/sched/fair.c                     | 33 ++++++++++++++++
 kernel/sched/sched.h                    |  4 ++
 4 files changed, 99 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index dc254a3cb956..93a73663a5f7 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1118,6 +1118,16 @@ All time durations are in microseconds.
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
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b2b8cb6c08cd..9f6700f812ea 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10967,6 +10967,47 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 {
 	return sched_group_set_idle(css_tg(css), idle);
 }
+
+static s64 cpu_latency_nice_read_s64(struct cgroup_subsys_state *css,
+				    struct cftype *cft)
+{
+	int prio, delta, last_delta = INT_MAX;
+	s64 weight;
+
+	weight = css_tg(css)->latency_offset * NICE_LATENCY_WEIGHT_MAX;
+	weight = div_s64(weight, get_sleep_latency(false));
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
+	latency_offset = weight * get_sleep_latency(false);
+	latency_offset = div_s64(latency_offset, NICE_LATENCY_WEIGHT_MAX);
+
+	return sched_group_set_latency(css_tg(css), latency_offset);
+}
+
 #endif
 
 static struct cftype cpu_legacy_files[] = {
@@ -10981,6 +11022,11 @@ static struct cftype cpu_legacy_files[] = {
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
@@ -11198,6 +11244,12 @@ static struct cftype cpu_files[] = {
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
index 0e80e65113bd..75c0a8d203c3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12158,6 +12158,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		goto err;
 
 	tg->shares = NICE_0_LOAD;
+	tg->latency_offset = 0;
 
 	init_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
@@ -12256,6 +12257,9 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	}
 
 	se->my_q = cfs_rq;
+
+	se->latency_offset = tg->latency_offset;
+
 	/* guarantee group entities always have weight */
 	update_load_set(&se->load, NICE_0_LOAD);
 	se->parent = parent;
@@ -12386,6 +12390,35 @@ int sched_group_set_idle(struct task_group *tg, long idle)
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
index 7292652731d0..c3735a34d394 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -383,6 +383,8 @@ struct task_group {
 
 	/* A positive value indicates that this is a SCHED_IDLE group. */
 	int			idle;
+	/* latency constraint of the group. */
+	int			latency_offset;
 
 #ifdef	CONFIG_SMP
 	/*
@@ -493,6 +495,8 @@ extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
 
 extern int sched_group_set_idle(struct task_group *tg, long idle);
 
+extern int sched_group_set_latency(struct task_group *tg, s64 latency);
+
 #ifdef CONFIG_SMP
 extern void set_task_rq_fair(struct sched_entity *se,
 			     struct cfs_rq *prev, struct cfs_rq *next);
-- 
2.17.1

