Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAF56248A4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiKJRu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiKJRuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:50:40 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734BC45A3D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:50:30 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a14so3370628wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1+roSIgbqvGq/+OOlHqHUt+Rf8MwdSQP0WyWz8JU2fs=;
        b=wALwYXKWKLKsnMyjlz7MkUR91OBeeuRK1zURuBDKEIjHgmCPt+UjBYKledjkp882qA
         cnUMY/+SWT4HR1VMK9IKylvlgVF/VAsJ1OHakTPcgExBTPL5TLF9v9lejWdfjWvWaHPN
         FhmD5zSgXODtQemZ/VqMh2bDy2YVsvW/UXwEsOtoIBImcz11xQgtBdCeOkFfkB8IHO2Z
         6ifJ7vlBq0qHXXlslPirV/ZBg39TAxvsH/1mZSa/TuPoPfYdV0VkMZBUdtk2FRYIG/L3
         X0eQjn5gwnWchXIx9Zrxal4Vx6MS3+WbP3Ib49WLmPYsPm/KbJeBkLsEqErNQ/BZ+WK7
         I8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+roSIgbqvGq/+OOlHqHUt+Rf8MwdSQP0WyWz8JU2fs=;
        b=A09fmT99khLr2OcbNWvHj/+y0FQXQs2YNjNcUJLyL24KbaHxEneuXkZzaK66vmuzeC
         3uBUM18Ov7wijTXACICL3KoDHHAtCdVNX+hUEbdysOKGrb9GrUQ10kZZ+YUTxYd5cIrj
         uz8YxOxNo0pVEnhDqj6oYqOsuK+s5LyxZt3BH5bq5qUFWNqlFotQj/m5Bn2IceHg04GF
         KzUZ8B7z+6HDefghzGa0ATS3qIHRwLx4iO7r0RAqWP3iHoVIC/LEPNQCuuE3+aFu2s2T
         i0HRKr890PLGi6IlkBMT38Eg7nZhnnKKxMU1eYdgIlXepNkYg/RpA/grqr8N1wTLQOjm
         jGLw==
X-Gm-Message-State: ACrzQf2ZEYt2gXiRw2Cpch4FifPgGEyoH7F3TBD4eFc9CkiGzAVy6yQX
        Rt03bfORdQvYCm53kv7NLw+2SQ==
X-Google-Smtp-Source: AMsMyM5go1cx7YyaTmY5BAo/mkt3v8H+Ctv2Nsl5z3LkdfVOmg7nUa10hvHR7Xqe2bofqlwCEBTyVw==
X-Received: by 2002:adf:fc05:0:b0:236:63fa:c792 with SMTP id i5-20020adffc05000000b0023663fac792mr1046633wrr.476.1668102628909;
        Thu, 10 Nov 2022 09:50:28 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:342a:468f:562a:9cc4])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c4e8600b003cfc02ab8basm6514677wmq.33.2022.11.10.09.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:50:27 -0800 (PST)
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
Subject: [PATCH v8 6/9] sched/fair: Add sched group latency support
Date:   Thu, 10 Nov 2022 18:50:06 +0100
Message-Id: <20221110175009.18458-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221110175009.18458-1-vincent.guittot@linaro.org>
References: <20221110175009.18458-1-vincent.guittot@linaro.org>
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
index be4a77baf784..a4866cd4e58c 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1095,6 +1095,16 @@ All time durations are in microseconds.
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
+       used to limit the impact of the latency_nice of a task outside the
+       group.
 
 
 Memory
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index caf54e54a74f..3f42b1f61a7e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10890,6 +10890,47 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
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
+	weight = div_s64(weight, get_sched_latency(false));
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
+	latency_offset = weight * get_sched_latency(false);
+	latency_offset = div_s64(latency_offset, NICE_LATENCY_WEIGHT_MAX);
+
+	return sched_group_set_latency(css_tg(css), latency_offset);
+}
+
 #endif
 
 static struct cftype cpu_legacy_files[] = {
@@ -10904,6 +10945,11 @@ static struct cftype cpu_legacy_files[] = {
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
@@ -11121,6 +11167,12 @@ static struct cftype cpu_files[] = {
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
index 4299d5108dc7..9583936ce30c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11764,6 +11764,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		goto err;
 
 	tg->shares = NICE_0_LOAD;
+	tg->latency_offset = 0;
 
 	init_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
@@ -11862,6 +11863,9 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	}
 
 	se->my_q = cfs_rq;
+
+	se->latency_offset = tg->latency_offset;
+
 	/* guarantee group entities always have weight */
 	update_load_set(&se->load, NICE_0_LOAD);
 	se->parent = parent;
@@ -11992,6 +11996,35 @@ int sched_group_set_idle(struct task_group *tg, long idle)
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
index 99f10b4dc230..95d4be4f3af6 100644
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

