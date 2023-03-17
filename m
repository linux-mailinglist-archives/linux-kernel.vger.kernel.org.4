Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6946BF47B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjCQVi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjCQViY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:38:24 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC497B3AA;
        Fri, 17 Mar 2023 14:36:39 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so2140286pjl.4;
        Fri, 17 Mar 2023 14:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URop9Rwoa/oriNypEYg1VhPsA6VU2wwgSg2A31vlxYM=;
        b=LRGloDqLlMBpAyDFhtS/3PZY9eLMMd1VFQIIMdWCOeigwXF/02NVAMjqCxWqZp7LrC
         JoQM69cK1uhwm3PBNz3iVsxEAvJ5IrZzpX8L4tH5uGUDkSzeXfKqtpIuZM97wtcc2Z/v
         jMTJhtUhQC7ecXqi5hb07WAbZAGkTc08HZUpAOzCCI0hBgHacXf+FC5q63A9op+TBdPM
         Xp1q2fdDDqV+tr5+NLab4aXC45Xg4eLJUIrR4bFgF6L/uYERKosw6DFKEdmue4Sza5L0
         0pyGRAbHycp1ueSsmkeUTvoFy7/nZqmCkJcUUHV502NNHi/MSBv9EOUxTDSXRIPMq1La
         bKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=URop9Rwoa/oriNypEYg1VhPsA6VU2wwgSg2A31vlxYM=;
        b=C3NcyZ7+HDlGqD6/z5VC0C1eJfPu2iRqZlnBsnb6qa183Li/zkZOIUeYUazQ8NmJRW
         QbHc/pq0XrnToBXnAReyrYdHZOxdlu9Bw6ggLEBAtyByAQ1KtX2Alw8dISF6WDHQ40uK
         7XwO2VjHy53qAv6PJZ8Kx8+8DP+WCoAdi1lvIHgPgw1Xulyrm/bxuTK88fL2zFTQ8ZGg
         Hj+xXa+3qo2JjmOvGzNZ4uCLqHePPSDFw1dR9zsfIFbk/cHEKqyhjyT6O2HENqE5STJg
         PSmrUrpQMGwF4RUFRs6RMg1ZjquIXcbC5Gx/dyMtEEsb3rYYbRBBsSI/X4cADUmHW8wb
         QSjg==
X-Gm-Message-State: AO0yUKVuSRr8uDzLNzLzag3u3mmgXzJ88r4lvApA682qPT90Z7Dv+rvK
        FR57M/JY+SUrGqEa3XksJuc=
X-Google-Smtp-Source: AK7set9BqyHsSF2kXO9w+PggUDzFUVvl7PBxzXesdUdTGd9DlDUE6p81U3SzOu4hPRfOxVE1aZ6rSg==
X-Received: by 2002:a17:903:d1:b0:1a1:a273:1812 with SMTP id x17-20020a17090300d100b001a1a2731812mr3802401plc.45.1679088866928;
        Fri, 17 Mar 2023 14:34:26 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902759200b00194caf3e975sm1964703pll.208.2023.03.17.14.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:34:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 24/32] sched_ext: Add cgroup support
Date:   Fri, 17 Mar 2023 11:33:25 -1000
Message-Id: <20230317213333.2174969-25-tj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213333.2174969-1-tj@kernel.org>
References: <20230317213333.2174969-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sched_ext_ops operations to init/exit cgroups, and track task migrations
and config changes. Because different BPF schedulers may implement different
subsets of CPU control features, allow BPF schedulers to pick which cgroup
interface files to enable using SCX_OPS_CGROUP_KNOB_* flags. For now, only
the weight knobs are supported but adding more should be straightforward.

While a BPF scheduler is being enabled and disabled, relevant cgroup
operations are locked out using scx_cgroup_rwsem. This avoids situations
like task prep taking place while the task is being moved across cgroups,
making things easier for BPF schedulers.

This patch also adds scx_example_pair which implements a variant of core
scheduling where a hyperthread pair only run tasks from the same cgroup. The
BPF scheduler achieves this by putting tasks into per-cgroup queues,
time-slicing the cgroup to run for each pair first, and then scheduling
within the cgroup. See the header comment in scx_example_pair.bpf.c for more
details.

Note that scx_example_pair's cgroup-boundary guarantee breaks down for tasks
running in higher priority scheduler classes. This will be addressed by a
followup patch which implements a mechanism to track CPU preemption.

v3: * Make scx_example_pair switch all tasks by default.

    * Convert to BPF inline iterators.

    * scx_bpf_task_cgroup() is added to determine the current cgroup from
      CPU controller's POV. This allows BPF schedulers to accurately track
      CPU cgroup membership.

    * scx_exampl_flatcg added. This demonstrates flattened hierarchy
      implementation of CPU cgroup control and shows significant performance
      improvement when cgroups which are nested multiple levels are under
      competition.

v2: * Build fixes for different CONFIG combinations.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 include/linux/sched/ext.h                | 100 ++-
 init/Kconfig                             |   5 +
 kernel/sched/core.c                      |  70 +-
 kernel/sched/ext.c                       | 391 ++++++++++-
 kernel/sched/ext.h                       |  25 +
 kernel/sched/sched.h                     |  12 +-
 tools/sched_ext/.gitignore               |   2 +
 tools/sched_ext/Makefile                 |  14 +-
 tools/sched_ext/scx_common.bpf.h         |   1 +
 tools/sched_ext/scx_example_flatcg.bpf.c | 824 +++++++++++++++++++++++
 tools/sched_ext/scx_example_flatcg.c     | 228 +++++++
 tools/sched_ext/scx_example_flatcg.h     |  49 ++
 tools/sched_ext/scx_example_pair.bpf.c   | 536 +++++++++++++++
 tools/sched_ext/scx_example_pair.c       | 143 ++++
 tools/sched_ext/scx_example_pair.h       |  10 +
 15 files changed, 2386 insertions(+), 24 deletions(-)
 create mode 100644 tools/sched_ext/scx_example_flatcg.bpf.c
 create mode 100644 tools/sched_ext/scx_example_flatcg.c
 create mode 100644 tools/sched_ext/scx_example_flatcg.h
 create mode 100644 tools/sched_ext/scx_example_pair.bpf.c
 create mode 100644 tools/sched_ext/scx_example_pair.c
 create mode 100644 tools/sched_ext/scx_example_pair.h

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 1ed07b4bdb24..9e47e320369d 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -12,6 +12,8 @@
 #include <linux/rhashtable.h>
 #include <linux/llist.h>
 
+struct cgroup;
+
 enum scx_consts {
 	SCX_OPS_NAME_LEN	= 128,
 	SCX_EXIT_REASON_LEN	= 128,
@@ -108,14 +110,29 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_ENQ_EXITING	= 1LLU << 2,
 
+	/*
+	 * CPU cgroup knob enable flags
+	 */
+	SCX_OPS_CGROUP_KNOB_WEIGHT = 1LLU << 16,	/* cpu.weight */
+
 	SCX_OPS_ALL_FLAGS	= SCX_OPS_KEEP_BUILTIN_IDLE |
 				  SCX_OPS_ENQ_LAST |
-				  SCX_OPS_ENQ_EXITING,
+				  SCX_OPS_ENQ_EXITING |
+				  SCX_OPS_CGROUP_KNOB_WEIGHT,
 };
 
 /* argument container for ops.enable() and friends */
 struct scx_enable_args {
-	/* empty for now */
+#ifdef CONFIG_EXT_GROUP_SCHED
+	/* the cgroup the task is joining */
+	struct cgroup		*cgroup;
+#endif
+};
+
+/* argument container for ops->cgroup_init() */
+struct scx_cgroup_init_args {
+	/* the weight of the cgroup [1..10000] */
+	u32			weight;
 };
 
 /**
@@ -333,7 +350,8 @@ struct sched_ext_ops {
 	 * @p: task to enable BPF scheduling for
 	 * @args: enable arguments, see the struct definition
 	 *
-	 * Enable @p for BPF scheduling. @p will start running soon.
+	 * Enable @p for BPF scheduling. @p is now in the cgroup specified for
+	 * the preceding prep_enable() and will start running soon.
 	 */
 	void (*enable)(struct task_struct *p, struct scx_enable_args *args);
 
@@ -357,6 +375,79 @@ struct sched_ext_ops {
 	 */
 	void (*disable)(struct task_struct *p);
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+	/**
+	 * cgroup_init - Initialize a cgroup
+	 * @cgrp: cgroup being initialized
+	 * @args: init arguments, see the struct definition
+	 *
+	 * Either the BPF scheduler is being loaded or @cgrp created, initialize
+	 * @cgrp for sched_ext. This operation may block.
+	 *
+	 * Return 0 for success, -errno for failure. An error return while
+	 * loading will abort loading of the BPF scheduler. During cgroup
+	 * creation, it will abort the specific cgroup creation.
+	 */
+	s32 (*cgroup_init)(struct cgroup *cgrp,
+			   struct scx_cgroup_init_args *args);
+
+	/**
+	 * cgroup_exit - Exit a cgroup
+	 * @cgrp: cgroup being exited
+	 *
+	 * Either the BPF scheduler is being unloaded or @cgrp destroyed, exit
+	 * @cgrp for sched_ext. This operation my block.
+	 */
+	void (*cgroup_exit)(struct cgroup *cgrp);
+
+	/**
+	 * cgroup_prep_move - Prepare a task to be moved to a different cgroup
+	 * @p: task being moved
+	 * @from: cgroup @p is being moved from
+	 * @to: cgroup @p is being moved to
+	 *
+	 * Prepare @p for move from cgroup @from to @to. This operation may
+	 * block and can be used for allocations.
+	 *
+	 * Return 0 for success, -errno for failure. An error return aborts the
+	 * migration.
+	 */
+	s32 (*cgroup_prep_move)(struct task_struct *p,
+				struct cgroup *from, struct cgroup *to);
+
+	/**
+	 * cgroup_move - Commit cgroup move
+	 * @p: task being moved
+	 * @from: cgroup @p is being moved from
+	 * @to: cgroup @p is being moved to
+	 *
+	 * Commit the move. @p is dequeued during this operation.
+	 */
+	void (*cgroup_move)(struct task_struct *p,
+			    struct cgroup *from, struct cgroup *to);
+
+	/**
+	 * cgroup_cancel_move - Cancel cgroup move
+	 * @p: task whose cgroup move is being canceled
+	 * @from: cgroup @p was being moved from
+	 * @to: cgroup @p was being moved to
+	 *
+	 * @p was cgroup_prep_move()'d but failed before reaching cgroup_move().
+	 * Undo the preparation.
+	 */
+	void (*cgroup_cancel_move)(struct task_struct *p,
+				   struct cgroup *from, struct cgroup *to);
+
+	/**
+	 * cgroup_set_weight - A cgroup's weight is being changed
+	 * @cgrp: cgroup whose weight is being updated
+	 * @weight: new weight [1..10000]
+	 *
+	 * Update @tg's weight to @weight.
+	 */
+	void (*cgroup_set_weight)(struct cgroup *cgrp, u32 weight);
+#endif	/* CONFIG_CGROUPS */
+
 	/*
 	 * All online ops must come before ops.init().
 	 */
@@ -497,6 +588,9 @@ struct sched_ext_entity {
 
 	/* cold fields */
 	struct list_head	tasks_node;
+#ifdef CONFIG_EXT_GROUP_SCHED
+	struct cgroup		*cgrp_moving_from;
+#endif
 };
 
 void sched_ext_free(struct task_struct *p);
diff --git a/init/Kconfig b/init/Kconfig
index 1fb5f313d18f..375e9c6557b6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1039,6 +1039,11 @@ config RT_GROUP_SCHED
 	  realtime bandwidth for them.
 	  See Documentation/scheduler/sched-rt-group.rst for more information.
 
+config EXT_GROUP_SCHED
+	bool
+	depends on SCHED_CLASS_EXT && CGROUP_SCHED
+	default y
+
 endif #CGROUP_SCHED
 
 config SCHED_MM_CID
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a7e0725c2469..0780414f3c15 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9859,6 +9859,9 @@ void __init sched_init(void)
 		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
 		init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
+#ifdef CONFIG_EXT_GROUP_SCHED
+		root_task_group.scx_weight = CGROUP_WEIGHT_DFL;
+#endif /* CONFIG_EXT_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
 		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
 		ptr += nr_cpu_ids * sizeof(void **);
@@ -10315,6 +10318,7 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!alloc_rt_sched_group(tg, parent))
 		goto err;
 
+	scx_group_set_weight(tg, CGROUP_WEIGHT_DFL);
 	alloc_uclamp_sched_group(tg, parent);
 
 	return tg;
@@ -10418,6 +10422,7 @@ void sched_move_task(struct task_struct *tsk)
 	SCHED_CHANGE_BLOCK(rq, tsk,
 			   DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 		sched_change_group(tsk);
+		scx_move_task(tsk);
 	}
 
 	/*
@@ -10454,6 +10459,11 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct task_group *tg = css_tg(css);
 	struct task_group *parent = css_tg(css->parent);
+	int ret;
+
+	ret = scx_tg_online(tg);
+	if (ret)
+		return ret;
 
 	if (parent)
 		sched_online_group(tg, parent);
@@ -10470,6 +10480,13 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
 	return 0;
 }
 
+static void cpu_cgroup_css_offline(struct cgroup_subsys_state *css)
+{
+	struct task_group *tg = css_tg(css);
+
+	scx_tg_offline(tg);
+}
+
 static void cpu_cgroup_css_released(struct cgroup_subsys_state *css)
 {
 	struct task_group *tg = css_tg(css);
@@ -10487,9 +10504,10 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
 	sched_unregister_group(tg);
 }
 
-#ifdef CONFIG_RT_GROUP_SCHED
+#if defined(CONFIG_RT_GROUP_SCHED) || defined(CONFIG_EXT_GROUP_SCHED)
 static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 {
+#ifdef CONFIG_RT_GROUP_SCHED
 	struct task_struct *task;
 	struct cgroup_subsys_state *css;
 
@@ -10497,7 +10515,8 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 		if (!sched_rt_can_attach(css_tg(css), task))
 			return -EINVAL;
 	}
-	return 0;
+#endif
+	return scx_cgroup_can_attach(tset);
 }
 #endif
 
@@ -10508,8 +10527,17 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 
 	cgroup_taskset_for_each(task, css, tset)
 		sched_move_task(task);
+
+	scx_cgroup_finish_attach();
 }
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+static void cpu_cgroup_cancel_attach(struct cgroup_taskset *tset)
+{
+	scx_cgroup_cancel_attach(tset);
+}
+#endif
+
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 static void cpu_util_update_eff(struct cgroup_subsys_state *css)
 {
@@ -10691,9 +10719,15 @@ static int cpu_uclamp_max_show(struct seq_file *sf, void *v)
 static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cftype, u64 shareval)
 {
+	int ret;
+
 	if (shareval > scale_load_down(ULONG_MAX))
 		shareval = MAX_SHARES;
-	return sched_group_set_shares(css_tg(css), scale_load(shareval));
+	ret = sched_group_set_shares(css_tg(css), scale_load(shareval));
+	if (!ret)
+		scx_group_set_weight(css_tg(css),
+				     sched_weight_to_cgroup(shareval));
+	return ret;
 }
 
 static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
@@ -11157,11 +11191,15 @@ static int cpu_extra_stat_show(struct seq_file *sf,
 	return 0;
 }
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_EXT_GROUP_SCHED)
 
 static unsigned long tg_weight(struct task_group *tg)
 {
+#ifdef CONFIG_FAIR_GROUP_SCHED
 	return scale_load_down(tg->shares);
+#else
+	return sched_weight_from_cgroup(tg->scx_weight);
+#endif
 }
 
 static u64 cpu_weight_read_u64(struct cgroup_subsys_state *css,
@@ -11174,13 +11212,17 @@ static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cft, u64 cgrp_weight)
 {
 	unsigned long weight;
+	int ret;
 
 	if (cgrp_weight < CGROUP_WEIGHT_MIN || cgrp_weight > CGROUP_WEIGHT_MAX)
 		return -ERANGE;
 
 	weight = sched_weight_from_cgroup(cgrp_weight);
 
-	return sched_group_set_shares(css_tg(css), scale_load(weight));
+	ret = sched_group_set_shares(css_tg(css), scale_load(weight));
+	if (!ret)
+		scx_group_set_weight(css_tg(css), cgrp_weight);
+	return ret;
 }
 
 static s64 cpu_weight_nice_read_s64(struct cgroup_subsys_state *css,
@@ -11205,7 +11247,7 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 				     struct cftype *cft, s64 nice)
 {
 	unsigned long weight;
-	int idx;
+	int idx, ret;
 
 	if (nice < MIN_NICE || nice > MAX_NICE)
 		return -ERANGE;
@@ -11214,7 +11256,11 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 	idx = array_index_nospec(idx, 40);
 	weight = sched_prio_to_weight[idx];
 
-	return sched_group_set_shares(css_tg(css), scale_load(weight));
+	ret = sched_group_set_shares(css_tg(css), scale_load(weight));
+	if (!ret)
+		scx_group_set_weight(css_tg(css),
+				     sched_weight_to_cgroup(weight));
+	return ret;
 }
 #endif
 
@@ -11276,7 +11322,7 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 #endif
 
 struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1] = {
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_EXT_GROUP_SCHED)
 	[CPU_CFTYPE_WEIGHT] = {
 		.name = "weight",
 		.flags = CFTYPE_NOT_ON_ROOT,
@@ -11289,6 +11335,8 @@ struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1] = {
 		.read_s64 = cpu_weight_nice_read_s64,
 		.write_s64 = cpu_weight_nice_write_s64,
 	},
+#endif
+#ifdef CONFIG_FAIR_GROUP_SCHED
 	[CPU_CFTYPE_IDLE] = {
 		.name = "idle",
 		.flags = CFTYPE_NOT_ON_ROOT,
@@ -11330,13 +11378,17 @@ struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1] = {
 struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_alloc	= cpu_cgroup_css_alloc,
 	.css_online	= cpu_cgroup_css_online,
+	.css_offline	= cpu_cgroup_css_offline,
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
-#ifdef CONFIG_RT_GROUP_SCHED
+#if defined(CONFIG_RT_GROUP_SCHED) || defined(CONFIG_EXT_GROUP_SCHED)
 	.can_attach	= cpu_cgroup_can_attach,
 #endif
 	.attach		= cpu_cgroup_attach,
+#ifdef CONFIG_EXT_GROUP_SCHED
+	.cancel_attach	= cpu_cgroup_cancel_attach,
+#endif
 	.legacy_cftypes	= cpu_legacy_cftypes,
 	.dfl_cftypes	= cpu_cftypes,
 	.early_init	= true,
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ac7b2d57b656..736f764d0f62 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1813,6 +1813,28 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 		resched_curr(rq);
 }
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+static struct cgroup *tg_cgrp(struct task_group *tg)
+{
+	/*
+	 * If CGROUP_SCHED is disabled, @tg is NULL. If @tg is an autogroup,
+	 * @tg->css.cgroup is NULL. In both cases, @tg can be treated as the
+	 * root cgroup.
+	 */
+	if (tg && tg->css.cgroup)
+		return tg->css.cgroup;
+	else
+		return &cgrp_dfl_root.cgrp;
+}
+
+#define SCX_ENABLE_ARGS_INIT_CGROUP(tg)		.cgroup = tg_cgrp(tg),
+
+#else	/* CONFIG_EXT_GROUP_SCHED */
+
+#define SCX_ENABLE_ARGS_INIT_CGROUP(tg)
+
+#endif	/* CONFIG_EXT_GROUP_SCHED */
+
 static int scx_ops_prepare_task(struct task_struct *p, struct task_group *tg)
 {
 	int ret;
@@ -1822,7 +1844,9 @@ static int scx_ops_prepare_task(struct task_struct *p, struct task_group *tg)
 	p->scx.disallow = false;
 
 	if (SCX_HAS_OP(prep_enable)) {
-		struct scx_enable_args args = { };
+		struct scx_enable_args args = {
+			SCX_ENABLE_ARGS_INIT_CGROUP(tg)
+		};
 
 		ret = SCX_CALL_OP_RET(SCX_KF_SLEEPABLE, prep_enable, p, &args);
 		if (unlikely(ret)) {
@@ -1862,7 +1886,9 @@ static void scx_ops_enable_task(struct task_struct *p)
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_OPS_PREPPED));
 
 	if (SCX_HAS_OP(enable)) {
-		struct scx_enable_args args = { };
+		struct scx_enable_args args = {
+			SCX_ENABLE_ARGS_INIT_CGROUP(task_group(p))
+		};
 		SCX_CALL_OP_TASK(SCX_KF_REST, enable, p, &args);
 	}
 	p->scx.flags &= ~SCX_TASK_OPS_PREPPED;
@@ -1875,7 +1901,9 @@ static void scx_ops_disable_task(struct task_struct *p)
 
 	if (p->scx.flags & SCX_TASK_OPS_PREPPED) {
 		if (SCX_HAS_OP(cancel_enable)) {
-			struct scx_enable_args args = { };
+			struct scx_enable_args args = {
+				SCX_ENABLE_ARGS_INIT_CGROUP(task_group(p))
+			};
 			SCX_CALL_OP(SCX_KF_REST, cancel_enable, p, &args);
 		}
 		p->scx.flags &= ~SCX_TASK_OPS_PREPPED;
@@ -2032,6 +2060,166 @@ bool scx_can_stop_tick(struct rq *rq)
 }
 #endif
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+
+DEFINE_STATIC_PERCPU_RWSEM(scx_cgroup_rwsem);
+
+int scx_tg_online(struct task_group *tg)
+{
+	int ret = 0;
+
+	WARN_ON_ONCE(tg->scx_flags & (SCX_TG_ONLINE | SCX_TG_INITED));
+
+	percpu_down_read(&scx_cgroup_rwsem);
+
+	if (SCX_HAS_OP(cgroup_init)) {
+		struct scx_cgroup_init_args args = { .weight = tg->scx_weight };
+
+		ret = SCX_CALL_OP_RET(SCX_KF_SLEEPABLE, cgroup_init,
+				      tg->css.cgroup, &args);
+		if (!ret)
+			tg->scx_flags |= SCX_TG_ONLINE | SCX_TG_INITED;
+		else
+			ret = ops_sanitize_err("cgroup_init", ret);
+	} else {
+		tg->scx_flags |= SCX_TG_ONLINE;
+	}
+
+	percpu_up_read(&scx_cgroup_rwsem);
+	return ret;
+}
+
+void scx_tg_offline(struct task_group *tg)
+{
+	WARN_ON_ONCE(!(tg->scx_flags & SCX_TG_ONLINE));
+
+	percpu_down_read(&scx_cgroup_rwsem);
+
+	if (SCX_HAS_OP(cgroup_exit) && (tg->scx_flags & SCX_TG_INITED))
+		SCX_CALL_OP(SCX_KF_SLEEPABLE, cgroup_exit, tg->css.cgroup);
+	tg->scx_flags &= ~(SCX_TG_ONLINE | SCX_TG_INITED);
+
+	percpu_up_read(&scx_cgroup_rwsem);
+}
+
+int scx_cgroup_can_attach(struct cgroup_taskset *tset)
+{
+	struct cgroup_subsys_state *css;
+	struct task_struct *p;
+	int ret;
+
+	/* released in scx_finish/cancel_attach() */
+	percpu_down_read(&scx_cgroup_rwsem);
+
+	if (!scx_enabled())
+		return 0;
+
+	cgroup_taskset_for_each(p, css, tset) {
+		struct cgroup *from = tg_cgrp(task_group(p));
+
+		if (SCX_HAS_OP(cgroup_prep_move)) {
+			ret = SCX_CALL_OP_RET(SCX_KF_SLEEPABLE, cgroup_prep_move,
+					      p, from, css->cgroup);
+			if (ret)
+				goto err;
+		}
+
+		WARN_ON_ONCE(p->scx.cgrp_moving_from);
+		p->scx.cgrp_moving_from = from;
+	}
+
+	return 0;
+
+err:
+	cgroup_taskset_for_each(p, css, tset) {
+		if (!p->scx.cgrp_moving_from)
+			break;
+		if (SCX_HAS_OP(cgroup_cancel_move))
+			SCX_CALL_OP(SCX_KF_SLEEPABLE, cgroup_cancel_move, p,
+				    p->scx.cgrp_moving_from, css->cgroup);
+		p->scx.cgrp_moving_from = NULL;
+	}
+
+	percpu_up_read(&scx_cgroup_rwsem);
+	return ops_sanitize_err("cgroup_prep_move", ret);
+}
+
+void scx_move_task(struct task_struct *p)
+{
+	/*
+	 * We're called from sched_move_task() which handles both cgroup and
+	 * autogroup moves. Ignore the latter.
+	 */
+	if (task_group_is_autogroup(task_group(p)))
+		return;
+
+	if (!scx_enabled())
+		return;
+
+	if (SCX_HAS_OP(cgroup_move)) {
+		WARN_ON_ONCE(!p->scx.cgrp_moving_from);
+		SCX_CALL_OP_TASK(SCX_KF_UNLOCKED, cgroup_move, p,
+			p->scx.cgrp_moving_from, tg_cgrp(task_group(p)));
+	}
+	p->scx.cgrp_moving_from = NULL;
+}
+
+void scx_cgroup_finish_attach(void)
+{
+	percpu_up_read(&scx_cgroup_rwsem);
+}
+
+void scx_cgroup_cancel_attach(struct cgroup_taskset *tset)
+{
+	struct cgroup_subsys_state *css;
+	struct task_struct *p;
+
+	if (!scx_enabled())
+		goto out_unlock;
+
+	cgroup_taskset_for_each(p, css, tset) {
+		if (SCX_HAS_OP(cgroup_cancel_move)) {
+			WARN_ON_ONCE(!p->scx.cgrp_moving_from);
+			SCX_CALL_OP(SCX_KF_SLEEPABLE, cgroup_cancel_move, p,
+				    p->scx.cgrp_moving_from, css->cgroup);
+		}
+		p->scx.cgrp_moving_from = NULL;
+	}
+out_unlock:
+	percpu_up_read(&scx_cgroup_rwsem);
+}
+
+void scx_group_set_weight(struct task_group *tg, unsigned long weight)
+{
+	percpu_down_read(&scx_cgroup_rwsem);
+
+	if (tg->scx_weight != weight) {
+		if (SCX_HAS_OP(cgroup_set_weight))
+			SCX_CALL_OP(SCX_KF_SLEEPABLE, cgroup_set_weight,
+				    tg_cgrp(tg), weight);
+		tg->scx_weight = weight;
+	}
+
+	percpu_up_read(&scx_cgroup_rwsem);
+}
+
+static void scx_cgroup_lock(void)
+{
+	percpu_down_write(&scx_cgroup_rwsem);
+}
+
+static void scx_cgroup_unlock(void)
+{
+	percpu_up_write(&scx_cgroup_rwsem);
+}
+
+#else	/* CONFIG_EXT_GROUP_SCHED */
+
+static inline void scx_cgroup_lock(void) {}
+static inline void scx_cgroup_unlock(void) {}
+
+#endif	/* CONFIG_EXT_GROUP_SCHED */
+
 /*
  * Omitted operations:
  *
@@ -2161,6 +2349,131 @@ static void destroy_dsq(u64 dsq_id)
 	rcu_read_unlock();
 }
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+static void scx_cgroup_exit(void)
+{
+	struct cgroup_subsys_state *css;
+
+	percpu_rwsem_assert_held(&scx_cgroup_rwsem);
+
+	/*
+	 * scx_tg_on/offline() are excluded through scx_cgroup_rwsem. If we walk
+	 * cgroups and exit all the inited ones, all online cgroups are exited.
+	 */
+	rcu_read_lock();
+	css_for_each_descendant_post(css, &root_task_group.css) {
+		struct task_group *tg = css_tg(css);
+
+		if (!(tg->scx_flags & SCX_TG_INITED))
+			continue;
+		tg->scx_flags &= ~SCX_TG_INITED;
+
+		if (!scx_ops.cgroup_exit)
+			continue;
+
+		if (WARN_ON_ONCE(!css_tryget(css)))
+			continue;
+		rcu_read_unlock();
+
+		SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_exit, css->cgroup);
+
+		rcu_read_lock();
+		css_put(css);
+	}
+	rcu_read_unlock();
+}
+
+static int scx_cgroup_init(void)
+{
+	struct cgroup_subsys_state *css;
+	int ret;
+
+	percpu_rwsem_assert_held(&scx_cgroup_rwsem);
+
+	/*
+	 * scx_tg_on/offline() are excluded thorugh scx_cgroup_rwsem. If we walk
+	 * cgroups and init, all online cgroups are initialized.
+	 */
+	rcu_read_lock();
+	css_for_each_descendant_pre(css, &root_task_group.css) {
+		struct task_group *tg = css_tg(css);
+		struct scx_cgroup_init_args args = { .weight = tg->scx_weight };
+
+		if ((tg->scx_flags &
+		     (SCX_TG_ONLINE | SCX_TG_INITED)) != SCX_TG_ONLINE)
+			continue;
+
+		if (!scx_ops.cgroup_init) {
+			tg->scx_flags |= SCX_TG_INITED;
+			continue;
+		}
+
+		if (WARN_ON_ONCE(!css_tryget(css)))
+			continue;
+		rcu_read_unlock();
+
+		ret = SCX_CALL_OP_RET(SCX_KF_SLEEPABLE, cgroup_init,
+				      css->cgroup, &args);
+		if (ret) {
+			css_put(css);
+			return ret;
+		}
+		tg->scx_flags |= SCX_TG_INITED;
+
+		rcu_read_lock();
+		css_put(css);
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static void scx_cgroup_config_knobs(void)
+{
+	static DEFINE_MUTEX(cgintf_mutex);
+	DECLARE_BITMAP(mask, CPU_CFTYPE_CNT) = { };
+	u64 knob_flags;
+	int i;
+
+	/*
+	 * Called from both class switch and ops enable/disable paths,
+	 * synchronize internally.
+	 */
+	mutex_lock(&cgintf_mutex);
+
+	/* if fair is in use, all knobs should be shown */
+	if (!scx_switched_all()) {
+		bitmap_fill(mask, CPU_CFTYPE_CNT);
+		goto apply;
+	}
+
+	/*
+	 * On ext, only show the supported knobs. Otherwise, show all possible
+	 * knobs so that configuration attempts succeed and the states are
+	 * remembered while ops is not loaded.
+	 */
+	if (scx_enabled())
+		knob_flags = scx_ops.flags;
+	else
+		knob_flags = SCX_OPS_ALL_FLAGS;
+
+	if (knob_flags & SCX_OPS_CGROUP_KNOB_WEIGHT) {
+		__set_bit(CPU_CFTYPE_WEIGHT, mask);
+		__set_bit(CPU_CFTYPE_WEIGHT_NICE, mask);
+	}
+apply:
+	for (i = 0; i < CPU_CFTYPE_CNT; i++)
+		cgroup_show_cftype(&cpu_cftypes[i], test_bit(i, mask));
+
+	mutex_unlock(&cgintf_mutex);
+}
+
+#else
+static void scx_cgroup_exit(void) {}
+static int scx_cgroup_init(void) { return 0; }
+static void scx_cgroup_config_knobs(void) {}
+#endif
+
 /*
  * Used by sched_fork() and __setscheduler_prio() to pick the matching
  * sched_class. dl/rt are already handled.
@@ -2304,9 +2617,10 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	static_branch_disable(&__scx_switched_all);
 	WRITE_ONCE(scx_switching_all, false);
 
-	/* avoid racing against fork */
+	/* avoid racing against fork and cgroup changes */
 	cpus_read_lock();
 	percpu_down_write(&scx_fork_rwsem);
+	scx_cgroup_lock();
 
 	spin_lock_irq(&scx_tasks_lock);
 	scx_task_iter_init(&sti);
@@ -2343,6 +2657,9 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
 	synchronize_rcu();
 
+	scx_cgroup_exit();
+
+	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 	cpus_read_unlock();
 
@@ -2381,6 +2698,8 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 
 	WARN_ON_ONCE(scx_ops_set_enable_state(SCX_OPS_DISABLED) !=
 		     SCX_OPS_DISABLING);
+
+	scx_cgroup_config_knobs();
 }
 
 static DEFINE_KTHREAD_WORK(scx_ops_disable_work, scx_ops_disable_workfn);
@@ -2526,10 +2845,11 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 			   scx_watchdog_timeout / 2);
 
 	/*
-	 * Lock out forks before opening the floodgate so that they don't wander
-	 * into the operations prematurely.
+	 * Lock out forks, cgroup on/offlining and moves before opening the
+	 * floodgate so that they don't wander into the operations prematurely.
 	 */
 	percpu_down_write(&scx_fork_rwsem);
+	scx_cgroup_lock();
 
 	for (i = 0; i < SCX_NR_ONLINE_OPS; i++)
 		if (((void (**)(void))ops)[i])
@@ -2548,6 +2868,14 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 		static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
 	}
 
+	/*
+	 * All cgroups should be initialized before letting in tasks. cgroup
+	 * on/offlining and task migrations are already locked out.
+	 */
+	ret = scx_cgroup_init();
+	if (ret)
+		goto err_disable_unlock;
+
 	static_branch_enable_cpuslocked(&__scx_ops_enabled);
 
 	/*
@@ -2630,6 +2958,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 
 	spin_unlock_irq(&scx_tasks_lock);
 	preempt_enable();
+	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 
 	if (!scx_ops_tryset_enable_state(SCX_OPS_ENABLED, SCX_OPS_ENABLING)) {
@@ -2643,6 +2972,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	cpus_read_unlock();
 	mutex_unlock(&scx_ops_enable_mutex);
 
+	scx_cgroup_config_knobs();
+
 	return 0;
 
 err_unlock:
@@ -2650,6 +2981,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	return ret;
 
 err_disable_unlock:
+	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 err_disable:
 	cpus_read_unlock();
@@ -2813,6 +3145,11 @@ static int bpf_scx_check_member(const struct btf_type *t,
 
 	switch (moff) {
 	case offsetof(struct sched_ext_ops, prep_enable):
+#ifdef CONFIG_EXT_GROUP_SCHED
+	case offsetof(struct sched_ext_ops, cgroup_init):
+	case offsetof(struct sched_ext_ops, cgroup_exit):
+	case offsetof(struct sched_ext_ops, cgroup_prep_move):
+#endif
 	case offsetof(struct sched_ext_ops, init):
 	case offsetof(struct sched_ext_ops, exit):
 		break;
@@ -2911,7 +3248,8 @@ void __init init_sched_ext_class(void)
 	 * definitions so that BPF scheduler implementations can use them
 	 * through the generated vmlinux.h.
 	 */
-	WRITE_ONCE(v, SCX_WAKE_EXEC | SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP);
+	WRITE_ONCE(v, SCX_WAKE_EXEC | SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP |
+		   SCX_TG_ONLINE);
 
 	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
 	init_dsq(&scx_dsq_global, SCX_DSQ_GLOBAL);
@@ -2932,6 +3270,7 @@ void __init init_sched_ext_class(void)
 
 	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
 	INIT_DELAYED_WORK(&scx_watchdog_work, scx_watchdog_workfn);
+	scx_cgroup_config_knobs();
 }
 
 
@@ -2975,8 +3314,8 @@ static const struct btf_kfunc_id_set scx_kfunc_set_init = {
  * @dsq_id: DSQ to create
  * @node: NUMA node to allocate from
  *
- * Create a custom DSQ identified by @dsq_id. Can be called from ops.init() and
- * ops.prep_enable().
+ * Create a custom DSQ identified by @dsq_id. Can be called from ops.init(),
+ * ops.prep_enable(), ops.cgroup_init() and ops.cgroup_prep_move().
  */
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node)
 {
@@ -3419,6 +3758,39 @@ s32 scx_bpf_task_cpu(const struct task_struct *p)
 	return task_cpu(p);
 }
 
+/**
+ * scx_bpf_task_cgroup - Return the sched cgroup of a task
+ * @p: task of interest
+ *
+ * @p->sched_task_group->css.cgroup represents the cgroup @p is associated with
+ * from the scheduler's POV. SCX operations should use this function to
+ * determine @p's current cgroup as, unlike following @p->cgroups,
+ * @p->sched_task_group is protected by @p's rq lock and thus atomic w.r.t. all
+ * rq-locked operations. Can be called on the parameter tasks of rq-locked
+ * operations. The restriction guarantees that @p's rq is locked by the caller.
+ */
+struct cgroup *scx_bpf_task_cgroup(struct task_struct *p)
+{
+	struct task_group *tg = p->sched_task_group;
+	struct cgroup *cgrp = &cgrp_dfl_root.cgrp;
+
+	if (!scx_kf_allowed_on_arg_tasks(__SCX_KF_RQ_LOCKED, p))
+		goto out;
+
+	/*
+	 * A task_group may either be a cgroup or an autogroup. In the latter
+	 * case, @tg->css.cgroup is %NULL. A task_group can't become the other
+	 * kind once created.
+	 */
+	if (tg && tg->css.cgroup)
+		cgrp = tg->css.cgroup;
+	else
+		cgrp = &cgrp_dfl_root.cgrp;
+out:
+	cgroup_get(cgrp);
+	return cgrp;
+}
+
 BTF_SET8_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
@@ -3431,6 +3803,7 @@ BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 BTF_SET8_END(scx_kfunc_ids_any)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 9c9284f91e38..0c5a109e7e6d 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -59,6 +59,11 @@ enum scx_deq_flags {
 	SCX_DEQ_SLEEP		= DEQUEUE_SLEEP,
 };
 
+enum scx_tg_flags {
+	SCX_TG_ONLINE		= 1U << 0,
+	SCX_TG_INITED		= 1U << 1,
+};
+
 enum scx_kick_flags {
 	SCX_KICK_PREEMPT	= 1LLU << 0,	/* force scheduling on the CPU */
 };
@@ -162,3 +167,23 @@ static inline void scx_update_idle(struct rq *rq, bool idle)
 #else
 static inline void scx_update_idle(struct rq *rq, bool idle) {}
 #endif
+
+#ifdef CONFIG_CGROUP_SCHED
+#ifdef CONFIG_EXT_GROUP_SCHED
+int scx_tg_online(struct task_group *tg);
+void scx_tg_offline(struct task_group *tg);
+int scx_cgroup_can_attach(struct cgroup_taskset *tset);
+void scx_move_task(struct task_struct *p);
+void scx_cgroup_finish_attach(void);
+void scx_cgroup_cancel_attach(struct cgroup_taskset *tset);
+void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight);
+#else	/* CONFIG_EXT_GROUP_SCHED */
+static inline int scx_tg_online(struct task_group *tg) { return 0; }
+static inline void scx_tg_offline(struct task_group *tg) {}
+static inline int scx_cgroup_can_attach(struct cgroup_taskset *tset) { return 0; }
+static inline void scx_move_task(struct task_struct *p) {}
+static inline void scx_cgroup_finish_attach(void) {}
+static inline void scx_cgroup_cancel_attach(struct cgroup_taskset *tset) {}
+static inline void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight) {}
+#endif	/* CONFIG_EXT_GROUP_SCHED */
+#endif	/* CONFIG_CGROUP_SCHED */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e6dacf488a20..3571cfda62a3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -424,6 +424,11 @@ struct task_group {
 	struct rt_bandwidth	rt_bandwidth;
 #endif
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+	u32			scx_flags;	/* SCX_TG_* */
+	u32			scx_weight;
+#endif
+
 	struct rcu_head		rcu;
 	struct list_head	list;
 
@@ -528,6 +533,11 @@ extern void set_task_rq_fair(struct sched_entity *se,
 static inline void set_task_rq_fair(struct sched_entity *se,
 			     struct cfs_rq *prev, struct cfs_rq *next) { }
 #endif /* CONFIG_SMP */
+#else /* CONFIG_FAIR_GROUP_SCHED */
+static inline int sched_group_set_shares(struct task_group *tg, unsigned long shares)
+{
+	return 0;
+}
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #else /* CONFIG_CGROUP_SCHED */
@@ -3418,7 +3428,7 @@ static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *n
 
 #ifdef CONFIG_CGROUP_SCHED
 enum cpu_cftype_id {
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_EXT_GROUP_SCHED)
 	CPU_CFTYPE_WEIGHT,
 	CPU_CFTYPE_WEIGHT_NICE,
 	CPU_CFTYPE_IDLE,
diff --git a/tools/sched_ext/.gitignore b/tools/sched_ext/.gitignore
index 3d8ec46ca304..769bc6f35cc6 100644
--- a/tools/sched_ext/.gitignore
+++ b/tools/sched_ext/.gitignore
@@ -1,6 +1,8 @@
 scx_example_simple
 scx_example_qmap
 scx_example_central
+scx_example_pair
+scx_example_flatcg
 *.skel.h
 *.subskel.h
 /tools/
diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index bcec7c1fb7b1..8c7543bbff8d 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -115,7 +115,8 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
 	     -Wall -Wno-compare-distinct-pointer-types				\
 	     -O2 -mcpu=v3
 
-all: scx_example_simple scx_example_qmap scx_example_central
+all: scx_example_simple scx_example_qmap scx_example_central scx_example_pair	\
+     scx_example_flatcg
 
 # sort removes libbpf duplicates when not cross-building
 MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf		\
@@ -178,10 +179,19 @@ scx_example_central: scx_example_central.c scx_example_central.skel.h user_exit_
 	$(CC) $(CFLAGS) -c $< -o $@.o
 	$(CC) -o $@ $@.o $(HOST_BPFOBJ) $(LDFLAGS)
 
+scx_example_pair: scx_example_pair.c scx_example_pair.skel.h user_exit_info.h
+	$(CC) $(CFLAGS) -c $< -o $@.o
+	$(CC) -o $@ $@.o $(HOST_BPFOBJ) $(LDFLAGS)
+
+scx_example_flatcg: scx_example_flatcg.c scx_example_flatcg.skel.h user_exit_info.h
+	$(CC) $(CFLAGS) -c $< -o $@.o
+	$(CC) -o $@ $@.o $(HOST_BPFOBJ) $(LDFLAGS)
+
 clean:
 	rm -rf $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)
 	rm -f *.o *.bpf.o *.skel.h *.subskel.h
-	rm -f scx_example_simple scx_example_qmap scx_example_central
+	rm -f scx_example_simple scx_example_qmap scx_example_central		\
+	      scx_example_pair scx_example_flatcg
 
 .PHONY: all clean
 
diff --git a/tools/sched_ext/scx_common.bpf.h b/tools/sched_ext/scx_common.bpf.h
index e6f6171edf3c..3f58737d80b1 100644
--- a/tools/sched_ext/scx_common.bpf.h
+++ b/tools/sched_ext/scx_common.bpf.h
@@ -67,6 +67,7 @@ void scx_bpf_put_idle_cpumask(const struct cpumask *cpumask) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
+struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym;
 
 #define BPF_STRUCT_OPS(name, args...)						\
 SEC("struct_ops/"#name)								\
diff --git a/tools/sched_ext/scx_example_flatcg.bpf.c b/tools/sched_ext/scx_example_flatcg.bpf.c
new file mode 100644
index 000000000000..9632bab7f164
--- /dev/null
+++ b/tools/sched_ext/scx_example_flatcg.bpf.c
@@ -0,0 +1,824 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A demo sched_ext flattened cgroup hierarchy scheduler. It implements
+ * hierarchical weight-based cgroup CPU control by flattening the cgroup
+ * hierarchy into a single layer by compounding the active weight share at each
+ * level. Consider the following hierarchy with weights in parentheses:
+ *
+ * R + A (100) + B (100)
+ *   |         \ C (100)
+ *   \ D (200)
+ *
+ * Ignoring the root and threaded cgroups, only B, C and D can contain tasks.
+ * Let's say all three have runnable tasks. The total share that each of these
+ * three cgroups is entitled to can be calculated by compounding its share at
+ * each level.
+ *
+ * For example, B is competing against C and in that competition its share is
+ * 100/(100+100) == 1/2. At its parent level, A is competing against D and A's
+ * share in that competition is 200/(200+100) == 1/3. B's eventual share in the
+ * system can be calculated by multiplying the two shares, 1/2 * 1/3 == 1/6. C's
+ * eventual shaer is the same at 1/6. D is only competing at the top level and
+ * its share is 200/(100+200) == 2/3.
+ *
+ * So, instead of hierarchically scheduling level-by-level, we can consider it
+ * as B, C and D competing each other with respective share of 1/6, 1/6 and 2/3
+ * and keep updating the eventual shares as the cgroups' runnable states change.
+ *
+ * This flattening of hierarchy can bring a substantial performance gain when
+ * the cgroup hierarchy is nested multiple levels. in a simple benchmark using
+ * wrk[8] on apache serving a CGI script calculating sha1sum of a small file, it
+ * outperforms CFS by ~3% with CPU controller disabled and by ~10% with two
+ * apache instances competing with 2:1 weight ratio nested four level deep.
+ *
+ * However, the gain comes at the cost of not being able to properly handle
+ * thundering herd of cgroups. For example, if many cgroups which are nested
+ * behind a low priority parent cgroup wake up around the same time, they may be
+ * able to consume more CPU cycles than they are entitled to. In many use cases,
+ * this isn't a real concern especially given the performance gain. Also, there
+ * are ways to mitigate the problem further by e.g. introducing an extra
+ * scheduling layer on cgroup delegation boundaries.
+ */
+#include "scx_common.bpf.h"
+#include "user_exit_info.h"
+#include "scx_example_flatcg.h"
+
+char _license[] SEC("license") = "GPL";
+
+const volatile u32 nr_cpus = 32;	/* !0 for veristat, set during init */
+const volatile u64 cgrp_slice_ns = SCX_SLICE_DFL;
+const volatile bool switch_partial;
+
+u64 cvtime_now;
+struct user_exit_info uei;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__type(key, u32);
+	__type(value, u64);
+	__uint(max_entries, FCG_NR_STATS);
+} stats SEC(".maps");
+
+static void stat_inc(enum fcg_stat_idx idx)
+{
+	u32 idx_v = idx;
+
+	u64 *cnt_p = bpf_map_lookup_elem(&stats, &idx_v);
+	if (cnt_p)
+		(*cnt_p)++;
+}
+
+struct fcg_cpu_ctx {
+	u64			cur_cgid;
+	u64			cur_at;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__type(key, u32);
+	__type(value, struct fcg_cpu_ctx);
+	__uint(max_entries, 1);
+} cpu_ctx SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct fcg_cgrp_ctx);
+} cgrp_ctx SEC(".maps");
+
+struct cgv_node {
+	struct bpf_rb_node	rb_node;
+	__u64			cvtime;
+	__u64			cgid;
+};
+
+private(CGV_TREE) struct bpf_spin_lock cgv_tree_lock;
+private(CGV_TREE) struct bpf_rb_root cgv_tree __contains(cgv_node, rb_node);
+
+struct cgv_node_stash {
+	struct cgv_node __kptr *node;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 16384);
+	__type(key, __u64);
+	__type(value, struct cgv_node_stash);
+} cgv_node_stash SEC(".maps");
+
+struct fcg_task_ctx {
+	u64		bypassed_at;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct fcg_task_ctx);
+} task_ctx SEC(".maps");
+
+/* gets inc'd on weight tree changes to expire the cached hweights */
+unsigned long hweight_gen = 1;
+
+static u64 div_round_up(u64 dividend, u64 divisor)
+{
+	return (dividend + divisor - 1) / divisor;
+}
+
+static bool vtime_before(u64 a, u64 b)
+{
+	return (s64)(a - b) < 0;
+}
+
+static bool cgv_node_less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct cgv_node *cgc_a, *cgc_b;
+
+	cgc_a = container_of(a, struct cgv_node, rb_node);
+	cgc_b = container_of(b, struct cgv_node, rb_node);
+
+	return cgc_a->cvtime < cgc_b->cvtime;
+}
+
+static struct fcg_cpu_ctx *find_cpu_ctx(void)
+{
+	struct fcg_cpu_ctx *cpuc;
+	u32 idx = 0;
+
+	cpuc = bpf_map_lookup_elem(&cpu_ctx, &idx);
+	if (!cpuc) {
+		scx_bpf_error("cpu_ctx lookup failed");
+		return NULL;
+	}
+	return cpuc;
+}
+
+static struct fcg_cgrp_ctx *find_cgrp_ctx(struct cgroup *cgrp)
+{
+	struct fcg_cgrp_ctx *cgc;
+
+	cgc = bpf_cgrp_storage_get(&cgrp_ctx, cgrp, 0, 0);
+	if (!cgc) {
+		scx_bpf_error("cgrp_ctx lookup failed for cgid %llu", cgrp->kn->id);
+		return NULL;
+	}
+	return cgc;
+}
+
+static struct fcg_cgrp_ctx *find_ancestor_cgrp_ctx(struct cgroup *cgrp, int level)
+{
+	struct fcg_cgrp_ctx *cgc;
+
+	cgrp = bpf_cgroup_ancestor(cgrp, level);
+	if (!cgrp) {
+		scx_bpf_error("ancestor cgroup lookup failed");
+		return NULL;
+	}
+
+	cgc = find_cgrp_ctx(cgrp);
+	if (!cgc)
+		scx_bpf_error("ancestor cgrp_ctx lookup failed");
+	bpf_cgroup_release(cgrp);
+	return cgc;
+}
+
+static void cgrp_refresh_hweight(struct cgroup *cgrp, struct fcg_cgrp_ctx *cgc)
+{
+	int level;
+
+	if (!cgc->nr_active) {
+		stat_inc(FCG_STAT_HWT_SKIP);
+		return;
+	}
+
+	if (cgc->hweight_gen == hweight_gen) {
+		stat_inc(FCG_STAT_HWT_CACHE);
+		return;
+	}
+
+	stat_inc(FCG_STAT_HWT_UPDATES);
+	bpf_for(level, 0, cgrp->level + 1) {
+		struct fcg_cgrp_ctx *cgc;
+		bool is_active;
+
+		cgc = find_ancestor_cgrp_ctx(cgrp, level);
+		if (!cgc)
+			break;
+
+		if (!level) {
+			cgc->hweight = FCG_HWEIGHT_ONE;
+			cgc->hweight_gen = hweight_gen;
+		} else {
+			struct fcg_cgrp_ctx *pcgc;
+
+			pcgc = find_ancestor_cgrp_ctx(cgrp, level - 1);
+			if (!pcgc)
+				break;
+
+			/*
+			 * We can be oppotunistic here and not grab the
+			 * cgv_tree_lock and deal with the occasional races.
+			 * However, hweight updates are already cached and
+			 * relatively low-frequency. Let's just do the
+			 * straightforward thing.
+			 */
+			bpf_spin_lock(&cgv_tree_lock);
+			is_active = cgc->nr_active;
+			if (is_active) {
+				cgc->hweight_gen = pcgc->hweight_gen;
+				cgc->hweight =
+					div_round_up(pcgc->hweight * cgc->weight,
+						     pcgc->child_weight_sum);
+			}
+			bpf_spin_unlock(&cgv_tree_lock);
+
+			if (!is_active) {
+				stat_inc(FCG_STAT_HWT_RACE);
+				break;
+			}
+		}
+	}
+}
+
+static void cgrp_cap_budget(struct cgv_node *cgv_node, struct fcg_cgrp_ctx *cgc)
+{
+	u64 delta, cvtime, max_budget;
+
+	/*
+	 * A node which is on the rbtree can't be pointed to from elsewhere yet
+	 * and thus can't be updated and repositioned. Instead, we collect the
+	 * vtime deltas separately and apply it asynchronously here.
+	 */
+	delta = cgc->cvtime_delta;
+	__sync_fetch_and_sub(&cgc->cvtime_delta, delta);
+	cvtime = cgv_node->cvtime + delta;
+
+	/*
+	 * Allow a cgroup to carry the maximum budget proportional to its
+	 * hweight such that a full-hweight cgroup can immediately take up half
+	 * of the CPUs at the most while staying at the front of the rbtree.
+	 */
+	max_budget = (cgrp_slice_ns * nr_cpus * cgc->hweight) /
+		(2 * FCG_HWEIGHT_ONE);
+	if (vtime_before(cvtime, cvtime_now - max_budget))
+		cvtime = cvtime_now - max_budget;
+
+	cgv_node->cvtime = cvtime;
+}
+
+static void cgrp_enqueued(struct cgroup *cgrp, struct fcg_cgrp_ctx *cgc)
+{
+	struct cgv_node_stash *stash;
+	struct cgv_node *cgv_node;
+	u64 cgid = cgrp->kn->id;
+
+	/* paired with cmpxchg in try_pick_next_cgroup() */
+	if (__sync_val_compare_and_swap(&cgc->queued, 0, 1)) {
+		stat_inc(FCG_STAT_ENQ_SKIP);
+		return;
+	}
+
+	stash = bpf_map_lookup_elem(&cgv_node_stash, &cgid);
+	if (!stash) {
+		scx_bpf_error("cgv_node lookup failed for cgid %llu", cgid);
+		return;
+	}
+
+	/* NULL if the node is already on the rbtree */
+	cgv_node = bpf_kptr_xchg(&stash->node, NULL);
+	if (!cgv_node) {
+		stat_inc(FCG_STAT_ENQ_RACE);
+		return;
+	}
+
+	bpf_spin_lock(&cgv_tree_lock);
+	cgrp_cap_budget(cgv_node, cgc);
+	bpf_rbtree_add(&cgv_tree, &cgv_node->rb_node, cgv_node_less);
+	bpf_spin_unlock(&cgv_tree_lock);
+}
+
+void BPF_STRUCT_OPS(fcg_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct fcg_task_ctx *taskc;
+	struct cgroup *cgrp;
+	struct fcg_cgrp_ctx *cgc;
+
+	taskc = bpf_task_storage_get(&task_ctx, p, 0, 0);
+	if (!taskc) {
+		scx_bpf_error("task_ctx lookup failed");
+		return;
+	}
+
+	/*
+	 * If select_cpu_dfl() is recommending local enqueue, the target CPU is
+	 * idle. Follow it and charge the cgroup later in fcg_stopping() after
+	 * the fact. Use the same mechanism to deal with tasks with custom
+	 * affinities so that we don't have to worry about per-cgroup dq's
+	 * containing tasks that can't be executed from some CPUs.
+	 */
+	if ((enq_flags & SCX_ENQ_LOCAL) || p->nr_cpus_allowed != nr_cpus) {
+		/*
+		 * Tell fcg_stopping() that this bypassed the regular scheduling
+		 * path and should be force charged to the cgroup. 0 is used to
+		 * indicate that the task isn't bypassing, so if the current
+		 * runtime is 0, go back by one nanosecond.
+		 */
+		taskc->bypassed_at = p->se.sum_exec_runtime ?: (u64)-1;
+
+		/*
+		 * The global dq is deprioritized as we don't want to let tasks
+		 * to boost themselves by constraining its cpumask. The
+		 * deprioritization is rather severe, so let's not apply that to
+		 * per-cpu kernel threads. This is ham-fisted. We probably wanna
+		 * implement per-cgroup fallback dq's instead so that we have
+		 * more control over when tasks with custom cpumask get issued.
+		 */
+		if ((enq_flags & SCX_ENQ_LOCAL) ||
+		    (p->nr_cpus_allowed == 1 && (p->flags & PF_KTHREAD))) {
+			stat_inc(FCG_STAT_LOCAL);
+			scx_bpf_dispatch(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
+		} else {
+			stat_inc(FCG_STAT_GLOBAL);
+			scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+		}
+		return;
+	}
+
+	cgrp = scx_bpf_task_cgroup(p);
+	cgc = find_cgrp_ctx(cgrp);
+	if (!cgc)
+		goto out_release;
+
+	scx_bpf_dispatch(p, cgrp->kn->id, SCX_SLICE_DFL, enq_flags);
+
+	cgrp_enqueued(cgrp, cgc);
+out_release:
+	bpf_cgroup_release(cgrp);
+}
+
+/*
+ * Walk the cgroup tree to update the active weight sums as tasks wake up and
+ * sleep. The weight sums are used as the base when calculating the proportion a
+ * given cgroup or task is entitled to at each level.
+ */
+static void update_active_weight_sums(struct cgroup *cgrp, bool runnable)
+{
+	struct fcg_cgrp_ctx *cgc;
+	bool updated = false;
+	int idx;
+
+	cgc = find_cgrp_ctx(cgrp);
+	if (!cgc)
+		return;
+
+	/*
+	 * In most cases, a hot cgroup would have multiple threads going to
+	 * sleep and waking up while the whole cgroup stays active. In leaf
+	 * cgroups, ->nr_runnable which is updated with __sync operations gates
+	 * ->nr_active updates, so that we don't have to grab the cgv_tree_lock
+	 * repeatedly for a busy cgroup which is staying active.
+	 */
+	if (runnable) {
+		if (__sync_fetch_and_add(&cgc->nr_runnable, 1))
+			return;
+		stat_inc(FCG_STAT_ACT);
+	} else {
+		if (__sync_sub_and_fetch(&cgc->nr_runnable, 1))
+			return;
+		stat_inc(FCG_STAT_DEACT);
+	}
+
+	/*
+	 * If @cgrp is becoming runnable, its hweight should be refreshed after
+	 * it's added to the weight tree so that enqueue has the up-to-date
+	 * value. If @cgrp is becoming quiescent, the hweight should be
+	 * refreshed before it's removed from the weight tree so that the usage
+	 * charging which happens afterwards has access to the latest value.
+	 */
+	if (!runnable)
+		cgrp_refresh_hweight(cgrp, cgc);
+
+	/* propagate upwards */
+	bpf_for(idx, 0, cgrp->level) {
+		int level = cgrp->level - idx;
+		struct fcg_cgrp_ctx *cgc, *pcgc = NULL;
+		bool propagate = false;
+
+		cgc = find_ancestor_cgrp_ctx(cgrp, level);
+		if (!cgc)
+			break;
+		if (level) {
+			pcgc = find_ancestor_cgrp_ctx(cgrp, level - 1);
+			if (!pcgc)
+				break;
+		}
+
+		/*
+		 * We need the propagation protected by a lock to synchronize
+		 * against weight changes. There's no reason to drop the lock at
+		 * each level but bpf_spin_lock() doesn't want any function
+		 * calls while locked.
+		 */
+		bpf_spin_lock(&cgv_tree_lock);
+
+		if (runnable) {
+			if (!cgc->nr_active++) {
+				updated = true;
+				if (pcgc) {
+					propagate = true;
+					pcgc->child_weight_sum += cgc->weight;
+				}
+			}
+		} else {
+			if (!--cgc->nr_active) {
+				updated = true;
+				if (pcgc) {
+					propagate = true;
+					pcgc->child_weight_sum -= cgc->weight;
+				}
+			}
+		}
+
+		bpf_spin_unlock(&cgv_tree_lock);
+
+		if (!propagate)
+			break;
+	}
+
+	if (updated)
+		__sync_fetch_and_add(&hweight_gen, 1);
+
+	if (runnable)
+		cgrp_refresh_hweight(cgrp, cgc);
+}
+
+void BPF_STRUCT_OPS(fcg_runnable, struct task_struct *p, u64 enq_flags)
+{
+	struct cgroup *cgrp;
+
+	cgrp = scx_bpf_task_cgroup(p);
+	update_active_weight_sums(cgrp, true);
+	bpf_cgroup_release(cgrp);
+}
+
+void BPF_STRUCT_OPS(fcg_stopping, struct task_struct *p, bool runnable)
+{
+	struct fcg_task_ctx *taskc;
+	struct cgroup *cgrp;
+	struct fcg_cgrp_ctx *cgc;
+
+	taskc = bpf_task_storage_get(&task_ctx, p, 0, 0);
+	if (!taskc) {
+		scx_bpf_error("task_ctx lookup failed");
+		return;
+	}
+
+	if (!taskc->bypassed_at)
+		return;
+
+	cgrp = scx_bpf_task_cgroup(p);
+	cgc = find_cgrp_ctx(cgrp);
+	if (cgc) {
+		__sync_fetch_and_add(&cgc->cvtime_delta,
+				     p->se.sum_exec_runtime - taskc->bypassed_at);
+		taskc->bypassed_at = 0;
+	}
+	bpf_cgroup_release(cgrp);
+}
+
+void BPF_STRUCT_OPS(fcg_quiescent, struct task_struct *p, u64 deq_flags)
+{
+	struct cgroup *cgrp;
+
+	cgrp = scx_bpf_task_cgroup(p);
+	update_active_weight_sums(cgrp, false);
+	bpf_cgroup_release(cgrp);
+}
+
+void BPF_STRUCT_OPS(fcg_cgroup_set_weight, struct cgroup *cgrp, u32 weight)
+{
+	struct fcg_cgrp_ctx *cgc, *pcgc = NULL;
+
+	cgc = find_cgrp_ctx(cgrp);
+	if (!cgc)
+		return;
+
+	if (cgrp->level) {
+		pcgc = find_ancestor_cgrp_ctx(cgrp, cgrp->level - 1);
+		if (!pcgc)
+			return;
+	}
+
+	bpf_spin_lock(&cgv_tree_lock);
+	if (pcgc && cgc->nr_active)
+		pcgc->child_weight_sum += (s64)weight - cgc->weight;
+	cgc->weight = weight;
+	bpf_spin_unlock(&cgv_tree_lock);
+}
+
+static bool try_pick_next_cgroup(u64 *cgidp)
+{
+	struct bpf_rb_node *rb_node;
+	struct cgv_node_stash *stash;
+	struct cgv_node *cgv_node;
+	struct fcg_cgrp_ctx *cgc;
+	struct cgroup *cgrp;
+	u64 cgid;
+
+	/* pop the front cgroup and wind cvtime_now accordingly */
+	bpf_spin_lock(&cgv_tree_lock);
+
+	rb_node = bpf_rbtree_first(&cgv_tree);
+	if (!rb_node) {
+		bpf_spin_unlock(&cgv_tree_lock);
+		stat_inc(FCG_STAT_PNC_NO_CGRP);
+		*cgidp = 0;
+		return true;
+	}
+
+	rb_node = bpf_rbtree_remove(&cgv_tree, rb_node);
+	bpf_spin_unlock(&cgv_tree_lock);
+
+	cgv_node = container_of(rb_node, struct cgv_node, rb_node);
+	cgid = cgv_node->cgid;
+
+	if (vtime_before(cvtime_now, cgv_node->cvtime))
+		cvtime_now = cgv_node->cvtime;
+
+	/*
+	 * If lookup fails, the cgroup's gone. Free and move on. See
+	 * fcg_cgroup_exit().
+	 */
+	cgrp = bpf_cgroup_from_id(cgid);
+	if (!cgrp) {
+		stat_inc(FCG_STAT_PNC_GONE);
+		goto out_free;
+	}
+
+	cgc = bpf_cgrp_storage_get(&cgrp_ctx, cgrp, 0, 0);
+	if (!cgc) {
+		bpf_cgroup_release(cgrp);
+		stat_inc(FCG_STAT_PNC_GONE);
+		goto out_free;
+	}
+
+	if (!scx_bpf_consume(cgid)) {
+		bpf_cgroup_release(cgrp);
+		stat_inc(FCG_STAT_PNC_EMPTY);
+		goto out_stash;
+	}
+
+	/*
+	 * Successfully consumed from the cgroup. This will be our current
+	 * cgroup for the new slice. Refresh its hweight.
+	 */
+	cgrp_refresh_hweight(cgrp, cgc);
+
+	bpf_cgroup_release(cgrp);
+
+	/*
+	 * As the cgroup may have more tasks, add it back to the rbtree. Note
+	 * that here we charge the full slice upfront and then exact later
+	 * according to the actual consumption. This prevents lowpri thundering
+	 * herd from saturating the machine.
+	 */
+	bpf_spin_lock(&cgv_tree_lock);
+	cgv_node->cvtime += cgrp_slice_ns * FCG_HWEIGHT_ONE / (cgc->hweight ?: 1);
+	cgrp_cap_budget(cgv_node, cgc);
+	bpf_rbtree_add(&cgv_tree, &cgv_node->rb_node, cgv_node_less);
+	bpf_spin_unlock(&cgv_tree_lock);
+
+	*cgidp = cgid;
+	stat_inc(FCG_STAT_PNC_NEXT);
+	return true;
+
+out_stash:
+	stash = bpf_map_lookup_elem(&cgv_node_stash, &cgid);
+	if (!stash) {
+		stat_inc(FCG_STAT_PNC_GONE);
+		goto out_free;
+	}
+
+	/*
+	 * Paired with cmpxchg in cgrp_enqueued(). If they see the following
+	 * transition, they'll enqueue the cgroup. If they are earlier, we'll
+	 * see their task in the dq below and requeue the cgroup.
+	 */
+	__sync_val_compare_and_swap(&cgc->queued, 1, 0);
+
+	if (scx_bpf_dsq_nr_queued(cgid)) {
+		bpf_spin_lock(&cgv_tree_lock);
+		bpf_rbtree_add(&cgv_tree, &cgv_node->rb_node, cgv_node_less);
+		bpf_spin_unlock(&cgv_tree_lock);
+	} else {
+		cgv_node = bpf_kptr_xchg(&stash->node, cgv_node);
+		if (cgv_node) {
+			scx_bpf_error("unexpected !NULL cgv_node stash");
+			goto out_free;
+		}
+	}
+
+	return false;
+
+out_free:
+	bpf_obj_drop(cgv_node);
+	return false;
+}
+
+void BPF_STRUCT_OPS(fcg_dispatch, s32 cpu, struct task_struct *prev)
+{
+	struct fcg_cpu_ctx *cpuc;
+	struct fcg_cgrp_ctx *cgc;
+	struct cgroup *cgrp;
+	u64 now = bpf_ktime_get_ns();
+
+	cpuc = find_cpu_ctx();
+	if (!cpuc)
+		return;
+
+	if (!cpuc->cur_cgid)
+		goto pick_next_cgroup;
+
+	if (vtime_before(now, cpuc->cur_at + cgrp_slice_ns)) {
+		if (scx_bpf_consume(cpuc->cur_cgid)) {
+			stat_inc(FCG_STAT_CNS_KEEP);
+			return;
+		}
+		stat_inc(FCG_STAT_CNS_EMPTY);
+	} else {
+		stat_inc(FCG_STAT_CNS_EXPIRE);
+	}
+
+	/*
+	 * The current cgroup is expiring. It was already charged a full slice.
+	 * Calculate the actual usage and accumulate the delta.
+	 */
+	cgrp = bpf_cgroup_from_id(cpuc->cur_cgid);
+	if (!cgrp) {
+		stat_inc(FCG_STAT_CNS_GONE);
+		goto pick_next_cgroup;
+	}
+
+	cgc = bpf_cgrp_storage_get(&cgrp_ctx, cgrp, 0, 0);
+	if (cgc) {
+		/*
+		 * We want to update the vtime delta and then look for the next
+		 * cgroup to execute but the latter needs to be done in a loop
+		 * and we can't keep the lock held. Oh well...
+		 */
+		bpf_spin_lock(&cgv_tree_lock);
+		__sync_fetch_and_add(&cgc->cvtime_delta,
+				     (cpuc->cur_at + cgrp_slice_ns - now) *
+				     FCG_HWEIGHT_ONE / (cgc->hweight ?: 1));
+		bpf_spin_unlock(&cgv_tree_lock);
+	} else {
+		stat_inc(FCG_STAT_CNS_GONE);
+	}
+
+	bpf_cgroup_release(cgrp);
+
+pick_next_cgroup:
+	cpuc->cur_at = now;
+
+	if (scx_bpf_consume(SCX_DSQ_GLOBAL)) {
+		cpuc->cur_cgid = 0;
+		return;
+	}
+
+	bpf_repeat(BPF_MAX_LOOPS) {
+		if (try_pick_next_cgroup(&cpuc->cur_cgid))
+			break;
+	}
+}
+
+s32 BPF_STRUCT_OPS(fcg_prep_enable, struct task_struct *p,
+		   struct scx_enable_args *args)
+{
+	struct fcg_task_ctx *taskc;
+
+	/*
+	 * @p is new. Let's ensure that its task_ctx is available. We can sleep
+	 * in this function and the following will automatically use GFP_KERNEL.
+	 */
+	taskc = bpf_task_storage_get(&task_ctx, p, 0,
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!taskc)
+		return -ENOMEM;
+
+	taskc->bypassed_at = 0;
+	return 0;
+}
+
+int BPF_STRUCT_OPS_SLEEPABLE(fcg_cgroup_init, struct cgroup *cgrp,
+			     struct scx_cgroup_init_args *args)
+{
+	struct fcg_cgrp_ctx *cgc;
+	struct cgv_node *cgv_node;
+	struct cgv_node_stash empty_stash = {}, *stash;
+	u64 cgid = cgrp->kn->id;
+	int ret;
+
+	/*
+	 * Technically incorrect as cgroup ID is full 64bit while dq ID is
+	 * 63bit. Should not be a problem in practice and easy to spot in the
+	 * unlikely case that it breaks.
+	 */
+	ret = scx_bpf_create_dsq(cgid, -1);
+	if (ret)
+		return ret;
+
+	cgc = bpf_cgrp_storage_get(&cgrp_ctx, cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!cgc) {
+		ret = -ENOMEM;
+		goto err_destroy_dsq;
+	}
+
+	cgc->weight = args->weight;
+	cgc->hweight = FCG_HWEIGHT_ONE;
+
+	ret = bpf_map_update_elem(&cgv_node_stash, &cgid, &empty_stash,
+				  BPF_NOEXIST);
+	if (ret) {
+		if (ret != -ENOMEM)
+			scx_bpf_error("unexpected stash creation error (%d)",
+				      ret);
+		goto err_destroy_dsq;
+	}
+
+	stash = bpf_map_lookup_elem(&cgv_node_stash, &cgid);
+	if (!stash) {
+		scx_bpf_error("unexpected cgv_node stash lookup failure");
+		ret = -ENOENT;
+		goto err_destroy_dsq;
+	}
+
+	cgv_node = bpf_obj_new(struct cgv_node);
+	if (!cgv_node) {
+		ret = -ENOMEM;
+		goto err_del_cgv_node;
+	}
+
+	cgv_node->cgid = cgid;
+	cgv_node->cvtime = cvtime_now;
+
+	cgv_node = bpf_kptr_xchg(&stash->node, cgv_node);
+	if (cgv_node) {
+		scx_bpf_error("unexpected !NULL cgv_node stash");
+		ret = -EBUSY;
+		goto err_drop;
+	}
+
+	return 0;
+
+err_drop:
+	bpf_obj_drop(cgv_node);
+err_del_cgv_node:
+	bpf_map_delete_elem(&cgv_node_stash, &cgid);
+err_destroy_dsq:
+	scx_bpf_destroy_dsq(cgid);
+	return ret;
+}
+
+void BPF_STRUCT_OPS(fcg_cgroup_exit, struct cgroup *cgrp)
+{
+	u64 cgid = cgrp->kn->id;
+
+	/*
+	 * For now, there's no way find and remove the cgv_node if it's on the
+	 * cgv_tree. Let's drain them in the dispatch path as they get popped
+	 * off the front of the tree.
+	 */
+	bpf_map_delete_elem(&cgv_node_stash, &cgid);
+	scx_bpf_destroy_dsq(cgid);
+}
+
+s32 BPF_STRUCT_OPS(fcg_init)
+{
+	if (!switch_partial)
+		scx_bpf_switch_all();
+	return 0;
+}
+
+void BPF_STRUCT_OPS(fcg_exit, struct scx_exit_info *ei)
+{
+	uei_record(&uei, ei);
+}
+
+SEC(".struct_ops")
+struct sched_ext_ops flatcg_ops = {
+	.enqueue		= (void *)fcg_enqueue,
+	.dispatch		= (void *)fcg_dispatch,
+	.runnable		= (void *)fcg_runnable,
+	.stopping		= (void *)fcg_stopping,
+	.quiescent		= (void *)fcg_quiescent,
+	.prep_enable		= (void *)fcg_prep_enable,
+	.cgroup_set_weight	= (void *)fcg_cgroup_set_weight,
+	.cgroup_init		= (void *)fcg_cgroup_init,
+	.cgroup_exit		= (void *)fcg_cgroup_exit,
+	.init			= (void *)fcg_init,
+	.exit			= (void *)fcg_exit,
+	.flags			= SCX_OPS_CGROUP_KNOB_WEIGHT | SCX_OPS_ENQ_EXITING,
+	.name			= "flatcg",
+};
diff --git a/tools/sched_ext/scx_example_flatcg.c b/tools/sched_ext/scx_example_flatcg.c
new file mode 100644
index 000000000000..150f7e16996e
--- /dev/null
+++ b/tools/sched_ext/scx_example_flatcg.c
@@ -0,0 +1,228 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <signal.h>
+#include <unistd.h>
+#include <limits.h>
+#include <fcntl.h>
+#include <time.h>
+#include <assert.h>
+#include <bpf/bpf.h>
+#include "user_exit_info.h"
+#include "scx_example_flatcg.h"
+#include "scx_example_flatcg.skel.h"
+
+#ifndef FILEID_KERNFS
+#define FILEID_KERNFS		0xfe
+#endif
+
+const char help_fmt[] =
+"A flattened cgroup hierarchy sched_ext scheduler.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s [-s SLICE_US] [-i INTERVAL] [-p]\n"
+"\n"
+"  -s SLICE_US   Override slice duration\n"
+"  -i INTERVAL   Report interval\n"
+"  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
+"  -h            Display this help and exit\n";
+
+static volatile int exit_req;
+
+static void sigint_handler(int dummy)
+{
+	exit_req = 1;
+}
+
+static float read_cpu_util(__u64 *last_sum, __u64 *last_idle)
+{
+	FILE *fp;
+	char buf[4096];
+	char *line, *cur = NULL, *tok;
+	__u64 sum = 0, idle = 0;
+	__u64 delta_sum, delta_idle;
+	int idx;
+
+	fp = fopen("/proc/stat", "r");
+	if (!fp) {
+		perror("fopen(\"/proc/stat\")");
+		return 0.0;
+	}
+
+	if (!fgets(buf, sizeof(buf), fp)) {
+		perror("fgets(\"/proc/stat\")");
+		fclose(fp);
+		return 0.0;
+	}
+	fclose(fp);
+
+	line = buf;
+	for (idx = 0; (tok = strtok_r(line, " \n", &cur)); idx++) {
+		char *endp = NULL;
+		__u64 v;
+
+		if (idx == 0) {
+			line = NULL;
+			continue;
+		}
+		v = strtoull(tok, &endp, 0);
+		if (!endp || *endp != '\0') {
+			fprintf(stderr, "failed to parse %dth field of /proc/stat (\"%s\")\n",
+				idx, tok);
+			continue;
+		}
+		sum += v;
+		if (idx == 4)
+			idle = v;
+	}
+
+	delta_sum = sum - *last_sum;
+	delta_idle = idle - *last_idle;
+	*last_sum = sum;
+	*last_idle = idle;
+
+	return delta_sum ? (float)(delta_sum - delta_idle) / delta_sum : 0.0;
+}
+
+static void fcg_read_stats(struct scx_example_flatcg *skel, __u64 *stats)
+{
+	__u64 cnts[FCG_NR_STATS][skel->rodata->nr_cpus];
+	__u32 idx;
+
+	memset(stats, 0, sizeof(stats[0]) * FCG_NR_STATS);
+
+	for (idx = 0; idx < FCG_NR_STATS; idx++) {
+		int ret, cpu;
+
+		ret = bpf_map_lookup_elem(bpf_map__fd(skel->maps.stats),
+					  &idx, cnts[idx]);
+		if (ret < 0)
+			continue;
+		for (cpu = 0; cpu < skel->rodata->nr_cpus; cpu++)
+			stats[idx] += cnts[idx][cpu];
+	}
+}
+
+int main(int argc, char **argv)
+{
+	struct scx_example_flatcg *skel;
+	struct bpf_link *link;
+	struct timespec intv_ts = { .tv_sec = 2, .tv_nsec = 0 };
+	bool dump_cgrps = false;
+	__u64 last_cpu_sum = 0, last_cpu_idle = 0;
+	__u64 last_stats[FCG_NR_STATS] = {};
+	unsigned long seq = 0;
+	s32 opt;
+
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+
+	skel = scx_example_flatcg__open();
+	if (!skel) {
+		fprintf(stderr, "Failed to open: %s\n", strerror(errno));
+		return 1;
+	}
+
+	skel->rodata->nr_cpus = libbpf_num_possible_cpus();
+
+	while ((opt = getopt(argc, argv, "s:i:dfph")) != -1) {
+		double v;
+
+		switch (opt) {
+		case 's':
+			v = strtod(optarg, NULL);
+			skel->rodata->cgrp_slice_ns = v * 1000;
+			break;
+		case 'i':
+			v = strtod(optarg, NULL);
+			intv_ts.tv_sec = v;
+			intv_ts.tv_nsec = (v - (float)intv_ts.tv_sec) * 1000000000;
+			break;
+		case 'd':
+			dump_cgrps = true;
+			break;
+		case 'p':
+			skel->rodata->switch_partial = true;
+			break;
+		case 'h':
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	printf("slice=%.1lfms intv=%.1lfs dump_cgrps=%d",
+	       (double)skel->rodata->cgrp_slice_ns / 1000000.0,
+	       (double)intv_ts.tv_sec + (double)intv_ts.tv_nsec / 1000000000.0,
+	       dump_cgrps);
+
+	if (scx_example_flatcg__load(skel)) {
+		fprintf(stderr, "Failed to load: %s\n", strerror(errno));
+		return 1;
+	}
+
+	link = bpf_map__attach_struct_ops(skel->maps.flatcg_ops);
+	if (!link) {
+		fprintf(stderr, "Failed to attach_struct_ops: %s\n",
+			strerror(errno));
+		return 1;
+	}
+
+	while (!exit_req && !uei_exited(&skel->bss->uei)) {
+		__u64 acc_stats[FCG_NR_STATS];
+		__u64 stats[FCG_NR_STATS];
+		float cpu_util;
+		int i;
+
+		cpu_util = read_cpu_util(&last_cpu_sum, &last_cpu_idle);
+
+		fcg_read_stats(skel, acc_stats);
+		for (i = 0; i < FCG_NR_STATS; i++)
+			stats[i] = acc_stats[i] - last_stats[i];
+
+		memcpy(last_stats, acc_stats, sizeof(acc_stats));
+
+		printf("\n[SEQ %6lu cpu=%5.1lf hweight_gen=%lu]\n",
+		       seq++, cpu_util * 100.0, skel->data->hweight_gen);
+		printf("       act:%6llu  deact:%6llu local:%6llu global:%6llu\n",
+		       stats[FCG_STAT_ACT],
+		       stats[FCG_STAT_DEACT],
+		       stats[FCG_STAT_LOCAL],
+		       stats[FCG_STAT_GLOBAL]);
+		printf("HWT   skip:%6llu   race:%6llu cache:%6llu update:%6llu\n",
+		       stats[FCG_STAT_HWT_SKIP],
+		       stats[FCG_STAT_HWT_RACE],
+		       stats[FCG_STAT_HWT_CACHE],
+		       stats[FCG_STAT_HWT_UPDATES]);
+		printf("ENQ   skip:%6llu   race:%6llu\n",
+		       stats[FCG_STAT_ENQ_SKIP],
+		       stats[FCG_STAT_ENQ_RACE]);
+		printf("CNS   keep:%6llu expire:%6llu empty:%6llu   gone:%6llu\n",
+		       stats[FCG_STAT_CNS_KEEP],
+		       stats[FCG_STAT_CNS_EXPIRE],
+		       stats[FCG_STAT_CNS_EMPTY],
+		       stats[FCG_STAT_CNS_GONE]);
+		printf("PNC nocgrp:%6llu   next:%6llu empty:%6llu   gone:%6llu\n",
+		       stats[FCG_STAT_PNC_NO_CGRP],
+		       stats[FCG_STAT_PNC_NEXT],
+		       stats[FCG_STAT_PNC_EMPTY],
+		       stats[FCG_STAT_PNC_GONE]);
+		printf("BAD remove:%6llu\n",
+		       acc_stats[FCG_STAT_BAD_REMOVAL]);
+
+		nanosleep(&intv_ts, NULL);
+	}
+
+	bpf_link__destroy(link);
+	uei_print(&skel->bss->uei);
+	scx_example_flatcg__destroy(skel);
+	return 0;
+}
diff --git a/tools/sched_ext/scx_example_flatcg.h b/tools/sched_ext/scx_example_flatcg.h
new file mode 100644
index 000000000000..490758ed41f0
--- /dev/null
+++ b/tools/sched_ext/scx_example_flatcg.h
@@ -0,0 +1,49 @@
+#ifndef __SCX_EXAMPLE_FLATCG_H
+#define __SCX_EXAMPLE_FLATCG_H
+
+enum {
+	FCG_HWEIGHT_ONE		= 1LLU << 16,
+};
+
+enum fcg_stat_idx {
+	FCG_STAT_ACT,
+	FCG_STAT_DEACT,
+	FCG_STAT_LOCAL,
+	FCG_STAT_GLOBAL,
+
+	FCG_STAT_HWT_UPDATES,
+	FCG_STAT_HWT_CACHE,
+	FCG_STAT_HWT_SKIP,
+	FCG_STAT_HWT_RACE,
+
+	FCG_STAT_ENQ_SKIP,
+	FCG_STAT_ENQ_RACE,
+
+	FCG_STAT_CNS_KEEP,
+	FCG_STAT_CNS_EXPIRE,
+	FCG_STAT_CNS_EMPTY,
+	FCG_STAT_CNS_GONE,
+
+	FCG_STAT_PNC_NO_CGRP,
+	FCG_STAT_PNC_NEXT,
+	FCG_STAT_PNC_EMPTY,
+	FCG_STAT_PNC_GONE,
+
+	FCG_STAT_BAD_REMOVAL,
+
+	FCG_NR_STATS,
+};
+
+struct fcg_cgrp_ctx {
+	u32			nr_active;
+	u32			nr_runnable;
+	u32			queued;
+	u32			weight;
+	u32			hweight;
+	u64			child_weight_sum;
+	u64			hweight_gen;
+	s64			cvtime_delta;
+	u64			tvtime_now;
+};
+
+#endif /* __SCX_EXAMPLE_FLATCG_H */
diff --git a/tools/sched_ext/scx_example_pair.bpf.c b/tools/sched_ext/scx_example_pair.bpf.c
new file mode 100644
index 000000000000..e5ff39083181
--- /dev/null
+++ b/tools/sched_ext/scx_example_pair.bpf.c
@@ -0,0 +1,536 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A demo sched_ext core-scheduler which always makes every sibling CPU pair
+ * execute from the same CPU cgroup.
+ *
+ * This scheduler is a minimal implementation and would need some form of
+ * priority handling both inside each cgroup and across the cgroups to be
+ * practically useful.
+ *
+ * Each CPU in the system is paired with exactly one other CPU, according to a
+ * "stride" value that can be specified when the BPF scheduler program is first
+ * loaded. Throughout the runtime of the scheduler, these CPU pairs guarantee
+ * that they will only ever schedule tasks that belong to the same CPU cgroup.
+ *
+ * Scheduler Initialization
+ * ------------------------
+ *
+ * The scheduler BPF program is first initialized from user space, before it is
+ * enabled. During this initialization process, each CPU on the system is
+ * assigned several values that are constant throughout its runtime:
+ *
+ * 1. *Pair CPU*: The CPU that it synchronizes with when making scheduling
+ *		  decisions. Paired CPUs always schedule tasks from the same
+ *		  CPU cgroup, and synchronize with each other to guarantee
+ *		  that this constraint is not violated.
+ * 2. *Pair ID*:  Each CPU pair is assigned a Pair ID, which is used to access
+ *		  a struct pair_ctx object that is shared between the pair.
+ * 3. *In-pair-index*: An index, 0 or 1, that is assigned to each core in the
+ *		       pair. Each struct pair_ctx has an active_mask field,
+ *		       which is a bitmap used to indicate whether each core
+ *		       in the pair currently has an actively running task.
+ *		       This index specifies which entry in the bitmap corresponds
+ *		       to each CPU in the pair.
+ *
+ * During this initialization, the CPUs are paired according to a "stride" that
+ * may be specified when invoking the user space program that initializes and
+ * loads the scheduler. By default, the stride is 1/2 the total number of CPUs.
+ *
+ * Tasks and cgroups
+ * -----------------
+ *
+ * Every cgroup in the system is registered with the scheduler using the
+ * pair_cgroup_init() callback, and every task in the system is associated with
+ * exactly one cgroup. At a high level, the idea with the pair scheduler is to
+ * always schedule tasks from the same cgroup within a given CPU pair. When a
+ * task is enqueued (i.e. passed to the pair_enqueue() callback function), its
+ * cgroup ID is read from its task struct, and then a corresponding queue map
+ * is used to FIFO-enqueue the task for that cgroup.
+ *
+ * If you look through the implementation of the scheduler, you'll notice that
+ * there is quite a bit of complexity involved with looking up the per-cgroup
+ * FIFO queue that we enqueue tasks in. For example, there is a cgrp_q_idx_hash
+ * BPF hash map that is used to map a cgroup ID to a globally unique ID that's
+ * allocated in the BPF program. This is done because we use separate maps to
+ * store the FIFO queue of tasks, and the length of that map, per cgroup. This
+ * complexity is only present because of current deficiencies in BPF that will
+ * soon be addressed. The main point to keep in mind is that newly enqueued
+ * tasks are added to their cgroup's FIFO queue.
+ *
+ * Dispatching tasks
+ * -----------------
+ *
+ * This section will describe how enqueued tasks are dispatched and scheduled.
+ * Tasks are dispatched in pair_dispatch(), and at a high level the workflow is
+ * as follows:
+ *
+ * 1. Fetch the struct pair_ctx for the current CPU. As mentioned above, this is
+ *    the structure that's used to synchronize amongst the two pair CPUs in their
+ *    scheduling decisions. After any of the following events have occurred:
+ *
+ * - The cgroup's slice run has expired, or
+ * - The cgroup becomes empty, or
+ * - Either CPU in the pair is preempted by a higher priority scheduling class
+ *
+ * The cgroup transitions to the draining state and stops executing new tasks
+ * from the cgroup.
+ *
+ * 2. If the pair is still executing a task, mark the pair_ctx as draining, and
+ *    wait for the pair CPU to be preempted.
+ *
+ * 3. Otherwise, if the pair CPU is not running a task, we can move onto
+ *    scheduling new tasks. Pop the next cgroup id from the top_q queue.
+ *
+ * 4. Pop a task from that cgroup's FIFO task queue, and begin executing it.
+ *
+ * Note again that this scheduling behavior is simple, but the implementation
+ * is complex mostly because this it hits several BPF shortcomings and has to
+ * work around in often awkward ways. Most of the shortcomings are expected to
+ * be resolved in the near future which should allow greatly simplifying this
+ * scheduler.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include "scx_common.bpf.h"
+#include "scx_example_pair.h"
+
+char _license[] SEC("license") = "GPL";
+
+const volatile bool switch_partial;
+
+/* !0 for veristat, set during init */
+const volatile u32 nr_cpu_ids = 64;
+
+/* a pair of CPUs stay on a cgroup for this duration */
+const volatile u32 pair_batch_dur_ns = SCX_SLICE_DFL;
+
+/* cpu ID -> pair cpu ID */
+const volatile s32 pair_cpu[MAX_CPUS] = { [0 ... MAX_CPUS - 1] = -1 };
+
+/* cpu ID -> pair_id */
+const volatile u32 pair_id[MAX_CPUS];
+
+/* CPU ID -> CPU # in the pair (0 or 1) */
+const volatile u32 in_pair_idx[MAX_CPUS];
+
+struct pair_ctx {
+	struct bpf_spin_lock	lock;
+
+	/* the cgroup the pair is currently executing */
+	u64			cgid;
+
+	/* the pair started executing the current cgroup at */
+	u64			started_at;
+
+	/* whether the current cgroup is draining */
+	bool			draining;
+
+	/* the CPUs that are currently active on the cgroup */
+	u32			active_mask;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, MAX_CPUS / 2);
+	__type(key, u32);
+	__type(value, struct pair_ctx);
+} pair_ctx SEC(".maps");
+
+/* queue of cgrp_q's possibly with tasks on them */
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	/*
+	 * Because it's difficult to build strong synchronization encompassing
+	 * multiple non-trivial operations in BPF, this queue is managed in an
+	 * opportunistic way so that we guarantee that a cgroup w/ active tasks
+	 * is always on it but possibly multiple times. Once we have more robust
+	 * synchronization constructs and e.g. linked list, we should be able to
+	 * do this in a prettier way but for now just size it big enough.
+	 */
+	__uint(max_entries, 4 * MAX_CGRPS);
+	__type(value, u64);
+} top_q SEC(".maps");
+
+/* per-cgroup q which FIFOs the tasks from the cgroup */
+struct cgrp_q {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, MAX_QUEUED);
+	__type(value, u32);
+};
+
+/*
+ * Ideally, we want to allocate cgrp_q and cgrq_q_len in the cgroup local
+ * storage; however, a cgroup local storage can only be accessed from the BPF
+ * progs attached to the cgroup. For now, work around by allocating array of
+ * cgrp_q's and then allocating per-cgroup indices.
+ *
+ * Another caveat: It's difficult to populate a large array of maps statically
+ * or from BPF. Initialize it from userland.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, MAX_CGRPS);
+	__type(key, s32);
+	__array(values, struct cgrp_q);
+} cgrp_q_arr SEC(".maps");
+
+static u64 cgrp_q_len[MAX_CGRPS];
+
+/*
+ * This and cgrp_q_idx_hash combine into a poor man's IDR. This likely would be
+ * useful to have as a map type.
+ */
+static u32 cgrp_q_idx_cursor;
+static u64 cgrp_q_idx_busy[MAX_CGRPS];
+
+/*
+ * All added up, the following is what we do:
+ *
+ * 1. When a cgroup is enabled, RR cgroup_q_idx_busy array doing cmpxchg looking
+ *    for a free ID. If not found, fail cgroup creation with -EBUSY.
+ *
+ * 2. Hash the cgroup ID to the allocated cgrp_q_idx in the following
+ *    cgrp_q_idx_hash.
+ *
+ * 3. Whenever a cgrp_q needs to be accessed, first look up the cgrp_q_idx from
+ *    cgrp_q_idx_hash and then access the corresponding entry in cgrp_q_arr.
+ *
+ * This is sadly complicated for something pretty simple. Hopefully, we should
+ * be able to simplify in the future.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, MAX_CGRPS);
+	__uint(key_size, sizeof(u64));		/* cgrp ID */
+	__uint(value_size, sizeof(s32));	/* cgrp_q idx */
+} cgrp_q_idx_hash SEC(".maps");
+
+/* statistics */
+u64 nr_total, nr_dispatched, nr_missing, nr_kicks, nr_preemptions;
+u64 nr_exps, nr_exp_waits, nr_exp_empty;
+u64 nr_cgrp_next, nr_cgrp_coll, nr_cgrp_empty;
+
+struct user_exit_info uei;
+
+static bool time_before(u64 a, u64 b)
+{
+	return (s64)(a - b) < 0;
+}
+
+void BPF_STRUCT_OPS(pair_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct cgroup *cgrp;
+	struct cgrp_q *cgq;
+	s32 pid = p->pid;
+	u64 cgid;
+	u32 *q_idx;
+	u64 *cgq_len;
+
+	__sync_fetch_and_add(&nr_total, 1);
+
+	cgrp = scx_bpf_task_cgroup(p);
+	cgid = cgrp->kn->id;
+	bpf_cgroup_release(cgrp);
+
+	/* find the cgroup's q and push @p into it */
+	q_idx = bpf_map_lookup_elem(&cgrp_q_idx_hash, &cgid);
+	if (!q_idx) {
+		scx_bpf_error("failed to lookup q_idx for cgroup[%llu]", cgid);
+		return;
+	}
+
+	cgq = bpf_map_lookup_elem(&cgrp_q_arr, q_idx);
+	if (!cgq) {
+		scx_bpf_error("failed to lookup q_arr for cgroup[%llu] q_idx[%u]",
+			      cgid, *q_idx);
+		return;
+	}
+
+	if (bpf_map_push_elem(cgq, &pid, 0)) {
+		scx_bpf_error("cgroup[%llu] queue overflow", cgid);
+		return;
+	}
+
+	/* bump q len, if going 0 -> 1, queue cgroup into the top_q */
+	cgq_len = MEMBER_VPTR(cgrp_q_len, [*q_idx]);
+	if (!cgq_len) {
+		scx_bpf_error("MEMBER_VTPR malfunction");
+		return;
+	}
+
+	if (!__sync_fetch_and_add(cgq_len, 1) &&
+	    bpf_map_push_elem(&top_q, &cgid, 0)) {
+		scx_bpf_error("top_q overflow");
+		return;
+	}
+}
+
+static int lookup_pairc_and_mask(s32 cpu, struct pair_ctx **pairc, u32 *mask)
+{
+	u32 *vptr;
+
+	vptr = (u32 *)MEMBER_VPTR(pair_id, [cpu]);
+	if (!vptr)
+		return -EINVAL;
+
+	*pairc = bpf_map_lookup_elem(&pair_ctx, vptr);
+	if (!(*pairc))
+		return -EINVAL;
+
+	vptr = (u32 *)MEMBER_VPTR(in_pair_idx, [cpu]);
+	if (!vptr)
+		return -EINVAL;
+
+	*mask = 1U << *vptr;
+
+	return 0;
+}
+
+static int try_dispatch(s32 cpu)
+{
+	struct pair_ctx *pairc;
+	struct bpf_map *cgq_map;
+	struct task_struct *p;
+	u64 now = bpf_ktime_get_ns();
+	bool kick_pair = false;
+	bool expired;
+	u32 *vptr, in_pair_mask;
+	s32 pid, q_idx;
+	u64 cgid;
+	int ret;
+
+	ret = lookup_pairc_and_mask(cpu, &pairc, &in_pair_mask);
+	if (ret) {
+		scx_bpf_error("failed to lookup pairc and in_pair_mask for cpu[%d]",
+			      cpu);
+		return -ENOENT;
+	}
+
+	bpf_spin_lock(&pairc->lock);
+	pairc->active_mask &= ~in_pair_mask;
+
+	expired = time_before(pairc->started_at + pair_batch_dur_ns, now);
+	if (expired || pairc->draining) {
+		u64 new_cgid = 0;
+
+		__sync_fetch_and_add(&nr_exps, 1);
+
+		/*
+		 * We're done with the current cgid. An obvious optimization
+		 * would be not draining if the next cgroup is the current one.
+		 * For now, be dumb and always expire.
+		 */
+		pairc->draining = true;
+
+		if (pairc->active_mask) {
+			/*
+			 * The other CPU is still active We want to wait until
+			 * this cgroup expires.
+			 *
+			 * If the pair controls its CPU, and the time already
+			 * expired, kick.  When the other CPU arrives at
+			 * dispatch and clears its active mask, it'll push the
+			 * pair to the next cgroup and kick this CPU.
+			 */
+			__sync_fetch_and_add(&nr_exp_waits, 1);
+			bpf_spin_unlock(&pairc->lock);
+			if (expired)
+				kick_pair = true;
+			goto out_maybe_kick;
+		}
+
+		bpf_spin_unlock(&pairc->lock);
+
+		/*
+		 * Pick the next cgroup. It'd be easier / cleaner to not drop
+		 * pairc->lock and use stronger synchronization here especially
+		 * given that we'll be switching cgroups significantly less
+		 * frequently than tasks. Unfortunately, bpf_spin_lock can't
+		 * really protect anything non-trivial. Let's do opportunistic
+		 * operations instead.
+		 */
+		bpf_repeat(BPF_MAX_LOOPS) {
+			u32 *q_idx;
+			u64 *cgq_len;
+
+			if (bpf_map_pop_elem(&top_q, &new_cgid)) {
+				/* no active cgroup, go idle */
+				__sync_fetch_and_add(&nr_exp_empty, 1);
+				return 0;
+			}
+
+			q_idx = bpf_map_lookup_elem(&cgrp_q_idx_hash, &new_cgid);
+			if (!q_idx)
+				continue;
+
+			/*
+			 * This is the only place where empty cgroups are taken
+			 * off the top_q.
+			 */
+			cgq_len = MEMBER_VPTR(cgrp_q_len, [*q_idx]);
+			if (!cgq_len || !*cgq_len)
+				continue;
+
+			/*
+			 * If it has any tasks, requeue as we may race and not
+			 * execute it.
+			 */
+			bpf_map_push_elem(&top_q, &new_cgid, 0);
+			break;
+		}
+
+		bpf_spin_lock(&pairc->lock);
+
+		/*
+		 * The other CPU may already have started on a new cgroup while
+		 * we dropped the lock. Make sure that we're still draining and
+		 * start on the new cgroup.
+		 */
+		if (pairc->draining && !pairc->active_mask) {
+			__sync_fetch_and_add(&nr_cgrp_next, 1);
+			pairc->cgid = new_cgid;
+			pairc->started_at = now;
+			pairc->draining = false;
+			kick_pair = true;
+		} else {
+			__sync_fetch_and_add(&nr_cgrp_coll, 1);
+		}
+	}
+
+	cgid = pairc->cgid;
+	pairc->active_mask |= in_pair_mask;
+	bpf_spin_unlock(&pairc->lock);
+
+	/* again, it'd be better to do all these with the lock held, oh well */
+	vptr = bpf_map_lookup_elem(&cgrp_q_idx_hash, &cgid);
+	if (!vptr) {
+		scx_bpf_error("failed to lookup q_idx for cgroup[%llu]", cgid);
+		return -ENOENT;
+	}
+	q_idx = *vptr;
+
+	/* claim one task from cgrp_q w/ q_idx */
+	bpf_repeat(BPF_MAX_LOOPS) {
+		u64 *cgq_len, len;
+
+		cgq_len = MEMBER_VPTR(cgrp_q_len, [q_idx]);
+		if (!cgq_len || !(len = *(volatile u64 *)cgq_len)) {
+			/* the cgroup must be empty, expire and repeat */
+			__sync_fetch_and_add(&nr_cgrp_empty, 1);
+			bpf_spin_lock(&pairc->lock);
+			pairc->draining = true;
+			pairc->active_mask &= ~in_pair_mask;
+			bpf_spin_unlock(&pairc->lock);
+			return -EAGAIN;
+		}
+
+		if (__sync_val_compare_and_swap(cgq_len, len, len - 1) != len)
+			continue;
+
+		break;
+	}
+
+	cgq_map = bpf_map_lookup_elem(&cgrp_q_arr, &q_idx);
+	if (!cgq_map) {
+		scx_bpf_error("failed to lookup cgq_map for cgroup[%llu] q_idx[%d]",
+			      cgid, q_idx);
+		return -ENOENT;
+	}
+
+	if (bpf_map_pop_elem(cgq_map, &pid)) {
+		scx_bpf_error("cgq_map is empty for cgroup[%llu] q_idx[%d]",
+			      cgid, q_idx);
+		return -ENOENT;
+	}
+
+	p = bpf_task_from_pid(pid);
+	if (p) {
+		__sync_fetch_and_add(&nr_dispatched, 1);
+		scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+		bpf_task_release(p);
+	} else {
+		/* we don't handle dequeues, retry on lost tasks */
+		__sync_fetch_and_add(&nr_missing, 1);
+		return -EAGAIN;
+	}
+
+out_maybe_kick:
+	if (kick_pair) {
+		s32 *pair = (s32 *)MEMBER_VPTR(pair_cpu, [cpu]);
+		if (pair) {
+			__sync_fetch_and_add(&nr_kicks, 1);
+			scx_bpf_kick_cpu(*pair, SCX_KICK_PREEMPT);
+		}
+	}
+	return 0;
+}
+
+void BPF_STRUCT_OPS(pair_dispatch, s32 cpu, struct task_struct *prev)
+{
+	bpf_repeat(BPF_MAX_LOOPS) {
+		if (try_dispatch(cpu) != -EAGAIN)
+			break;
+	}
+}
+
+s32 BPF_STRUCT_OPS(pair_cgroup_init, struct cgroup *cgrp)
+{
+	u64 cgid = cgrp->kn->id;
+	s32 i, q_idx;
+
+	bpf_for(i, 0, MAX_CGRPS) {
+		q_idx = __sync_fetch_and_add(&cgrp_q_idx_cursor, 1) % MAX_CGRPS;
+		if (!__sync_val_compare_and_swap(&cgrp_q_idx_busy[q_idx], 0, 1))
+			break;
+	}
+	if (i == MAX_CGRPS)
+		return -EBUSY;
+
+	if (bpf_map_update_elem(&cgrp_q_idx_hash, &cgid, &q_idx, BPF_ANY)) {
+		u64 *busy = MEMBER_VPTR(cgrp_q_idx_busy, [q_idx]);
+		if (busy)
+			*busy = 0;
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(pair_cgroup_exit, struct cgroup *cgrp)
+{
+	u64 cgid = cgrp->kn->id;
+	s32 *q_idx;
+
+	q_idx = bpf_map_lookup_elem(&cgrp_q_idx_hash, &cgid);
+	if (q_idx) {
+		u64 *busy = MEMBER_VPTR(cgrp_q_idx_busy, [*q_idx]);
+		if (busy)
+			*busy = 0;
+		bpf_map_delete_elem(&cgrp_q_idx_hash, &cgid);
+	}
+}
+
+s32 BPF_STRUCT_OPS(pair_init)
+{
+	if (!switch_partial)
+		scx_bpf_switch_all();
+	return 0;
+}
+
+void BPF_STRUCT_OPS(pair_exit, struct scx_exit_info *ei)
+{
+	uei_record(&uei, ei);
+}
+
+SEC(".struct_ops")
+struct sched_ext_ops pair_ops = {
+	.enqueue		= (void *)pair_enqueue,
+	.dispatch		= (void *)pair_dispatch,
+	.cgroup_init		= (void *)pair_cgroup_init,
+	.cgroup_exit		= (void *)pair_cgroup_exit,
+	.init			= (void *)pair_init,
+	.exit			= (void *)pair_exit,
+	.name			= "pair",
+};
diff --git a/tools/sched_ext/scx_example_pair.c b/tools/sched_ext/scx_example_pair.c
new file mode 100644
index 000000000000..18e032bbc173
--- /dev/null
+++ b/tools/sched_ext/scx_example_pair.c
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <assert.h>
+#include <libgen.h>
+#include <bpf/bpf.h>
+#include "user_exit_info.h"
+#include "scx_example_pair.h"
+#include "scx_example_pair.skel.h"
+
+const char help_fmt[] =
+"A demo sched_ext core-scheduler which always makes every sibling CPU pair\n"
+"execute from the same CPU cgroup.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s [-S STRIDE] [-p]\n"
+"\n"
+"  -S STRIDE     Override CPU pair stride (default: nr_cpus_ids / 2)\n"
+"  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
+"  -h            Display this help and exit\n";
+
+static volatile int exit_req;
+
+static void sigint_handler(int dummy)
+{
+	exit_req = 1;
+}
+
+int main(int argc, char **argv)
+{
+	struct scx_example_pair *skel;
+	struct bpf_link *link;
+	u64 seq = 0;
+	s32 stride, i, opt, outer_fd;
+
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+
+	skel = scx_example_pair__open();
+	assert(skel);
+
+	skel->rodata->nr_cpu_ids = libbpf_num_possible_cpus();
+
+	/* pair up the earlier half to the latter by default, override with -s */
+	stride = skel->rodata->nr_cpu_ids / 2;
+
+	while ((opt = getopt(argc, argv, "S:ph")) != -1) {
+		switch (opt) {
+		case 'S':
+			stride = strtoul(optarg, NULL, 0);
+			break;
+		case 'p':
+			skel->rodata->switch_partial = true;
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	for (i = 0; i < skel->rodata->nr_cpu_ids; i++) {
+		if (skel->rodata->pair_cpu[i] < 0) {
+			skel->rodata->pair_cpu[i] = i + stride;
+			skel->rodata->pair_cpu[i + stride] = i;
+			skel->rodata->pair_id[i] = i;
+			skel->rodata->pair_id[i + stride] = i;
+			skel->rodata->in_pair_idx[i] = 0;
+			skel->rodata->in_pair_idx[i + stride] = 1;
+		}
+	}
+
+	assert(!scx_example_pair__load(skel));
+
+	/*
+	 * Populate the cgrp_q_arr map which is an array containing per-cgroup
+	 * queues. It'd probably be better to do this from BPF but there are too
+	 * many to initialize statically and there's no way to dynamically
+	 * populate from BPF.
+	 */
+	outer_fd = bpf_map__fd(skel->maps.cgrp_q_arr);
+	assert(outer_fd >= 0);
+
+	printf("Initializing");
+        for (i = 0; i < MAX_CGRPS; i++) {
+		s32 inner_fd;
+
+		if (exit_req)
+			break;
+
+		inner_fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0,
+					  sizeof(u32), MAX_QUEUED, NULL);
+		assert(inner_fd >= 0);
+		assert(!bpf_map_update_elem(outer_fd, &i, &inner_fd, BPF_ANY));
+		close(inner_fd);
+
+		if (!(i % 10))
+			printf(".");
+		fflush(stdout);
+        }
+	printf("\n");
+
+	/*
+	 * Fully initialized, attach and run.
+	 */
+	link = bpf_map__attach_struct_ops(skel->maps.pair_ops);
+	assert(link);
+
+	while (!exit_req && !uei_exited(&skel->bss->uei)) {
+		printf("[SEQ %lu]\n", seq++);
+		printf(" total:%10lu dispatch:%10lu   missing:%10lu\n",
+		       skel->bss->nr_total,
+		       skel->bss->nr_dispatched,
+		       skel->bss->nr_missing);
+		printf(" kicks:%10lu preemptions:%7lu\n",
+		       skel->bss->nr_kicks,
+		       skel->bss->nr_preemptions);
+		printf("   exp:%10lu exp_wait:%10lu exp_empty:%10lu\n",
+		       skel->bss->nr_exps,
+		       skel->bss->nr_exp_waits,
+		       skel->bss->nr_exp_empty);
+		printf("cgnext:%10lu   cgcoll:%10lu   cgempty:%10lu\n",
+		       skel->bss->nr_cgrp_next,
+		       skel->bss->nr_cgrp_coll,
+		       skel->bss->nr_cgrp_empty);
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	uei_print(&skel->bss->uei);
+	scx_example_pair__destroy(skel);
+	return 0;
+}
diff --git a/tools/sched_ext/scx_example_pair.h b/tools/sched_ext/scx_example_pair.h
new file mode 100644
index 000000000000..f60b824272f7
--- /dev/null
+++ b/tools/sched_ext/scx_example_pair.h
@@ -0,0 +1,10 @@
+#ifndef __SCX_EXAMPLE_PAIR_H
+#define __SCX_EXAMPLE_PAIR_H
+
+enum {
+	MAX_CPUS		= 4096,
+	MAX_QUEUED		= 4096,
+	MAX_CGRPS		= 4096,
+};
+
+#endif /* __SCX_EXAMPLE_PAIR_H */
-- 
2.39.2

