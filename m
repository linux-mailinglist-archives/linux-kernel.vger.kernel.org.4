Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6E74E33D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjGKBQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjGKBQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:16:14 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5278BE74;
        Mon, 10 Jul 2023 18:15:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b89cfb4571so38559655ad.3;
        Mon, 10 Jul 2023 18:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038104; x=1691630104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDSgv+QtRHf/aR9BtEXLMutA1YdReMAbg2S/cOUC9WQ=;
        b=Yj0hBW8JCGmbbESq8y+AsA/i2KVudWBosfE/N0VK3QrTv+CE2kBOR21C7gfsta2TRm
         1b0ZmqOQLWdmUB+M0PBaE9b4XTzZVc3QllkzYhNlo5ax/k+G5YJ1HASEsj82zOg3pmG6
         wrFnbv/F1VkojYN4gIBzb8ZBoIeTOebt+J1BEdj+cfpU5Ly1lX/BqMgShr6JKeWMwnru
         ZxU9IaTv5IQcqHyxcaYOCe6wlzlHC2R8eNDnikXt5Hcn0qOnHwEQ476XprYBk4XDWlK0
         +8pueZIZThAh6Pld04jxfvD5ZhiQd+Q3hrlIqVniTXnDIZyYDqkSpquIrT4sEnj47YME
         Fqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038104; x=1691630104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BDSgv+QtRHf/aR9BtEXLMutA1YdReMAbg2S/cOUC9WQ=;
        b=AbUCcEjTKBDnpxs1H3O7PXbvBzxMPCv4kzBNEocvp5YUISNa76YE/g2AFl5d2P7Y91
         DLkSQwhh1KTE0MN8iSzI9LFXJmDfrBskxs+dPvo/NgUOP6RfBBrzwRNs/2BkTb6iawVf
         6y0dB+Ox/+kdEJQR+/yqFUPNGCZ/LF81I6DmhN5Ufkl5GAuTAmpionSprvqX/GdKnoEj
         86W18EA4eiKxi87Zh6EqthPZoZoWFoxPKuSpBEjQnJfqT1z09tWlKAcVopusddbo+LH0
         KM4qVw0terLSU7Oz/n0plfF2RIyxY7ifNGmlWeecTLoL4l9HqJj+WowBcwDJA/NW58BG
         eBvg==
X-Gm-Message-State: ABy/qLYuf+cWD5rF5pI+Rz1RluscmGlpakV83amQfU8jJC+JJkP3NS/u
        /oz2PWbwEYQKsnIahpZQalw=
X-Google-Smtp-Source: APBJJlHBhO0sD141m5MV8PoRYXuGQiiSYhj3P6FLv5KdHz+yaP0JMJ0G9g61/by4lgYEb/LpiQvAuw==
X-Received: by 2002:a17:902:bb93:b0:1b8:6cae:3570 with SMTP id m19-20020a170902bb9300b001b86cae3570mr13944259pls.11.1689038104260;
        Mon, 10 Jul 2023 18:15:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id bc1-20020a170902930100b001b3fb2f0296sm507382plb.120.2023.07.10.18.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:15:03 -0700 (PDT)
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
        kernel test robot <lkp@intel.com>,
        Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH 24/34] sched_ext: Add cgroup support
Date:   Mon, 10 Jul 2023 15:13:42 -1000
Message-ID: <20230711011412.100319-25-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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

v4: * Example schedulers moved into their own patches.

    * Fix build failure when !CONFIG_CGROUP_SCHED, reported by Andrea Righi.

v3: * Make scx_example_pair switch all tasks by default.

    * Convert to BPF inline iterators.

    * scx_bpf_task_cgroup() is added to determine the current cgroup from
      CPU controller's POV. This allows BPF schedulers to accurately track
      CPU cgroup membership.

    * scx_example_flatcg added. This demonstrates flattened hierarchy
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
Cc: Andrea Righi <andrea.righi@canonical.com>
---
 include/linux/sched/ext.h        | 100 +++++++-
 init/Kconfig                     |   5 +
 kernel/sched/core.c              |  70 +++++-
 kernel/sched/ext.c               | 395 ++++++++++++++++++++++++++++++-
 kernel/sched/ext.h               |  25 ++
 kernel/sched/sched.h             |  12 +-
 tools/sched_ext/scx_common.bpf.h |   1 +
 7 files changed, 586 insertions(+), 22 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index d2146cbbd9c2..2d6da27bdd74 100644
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
@@ -332,7 +349,8 @@ struct sched_ext_ops {
 	 * @p: task to enable BPF scheduling for
 	 * @args: enable arguments, see the struct definition
 	 *
-	 * Enable @p for BPF scheduling. @p will start running soon.
+	 * Enable @p for BPF scheduling. @p is now in the cgroup specified for
+	 * the preceding prep_enable() and will start running soon.
 	 */
 	void (*enable)(struct task_struct *p, struct scx_enable_args *args);
 
@@ -356,6 +374,79 @@ struct sched_ext_ops {
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
@@ -496,6 +587,9 @@ struct sched_ext_entity {
 
 	/* cold fields */
 	struct list_head	tasks_node;
+#ifdef CONFIG_EXT_GROUP_SCHED
+	struct cgroup		*cgrp_moving_from;
+#endif
 };
 
 void sched_ext_free(struct task_struct *p);
diff --git a/init/Kconfig b/init/Kconfig
index 32c24950c4ce..d4823d842f78 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1011,6 +1011,11 @@ config RT_GROUP_SCHED
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
index 30603331c2d7..77eb4ee4f759 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9987,6 +9987,9 @@ void __init sched_init(void)
 		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
 		init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
+#ifdef CONFIG_EXT_GROUP_SCHED
+		root_task_group.scx_weight = CGROUP_WEIGHT_DFL;
+#endif /* CONFIG_EXT_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
 		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
 		ptr += nr_cpu_ids * sizeof(void **);
@@ -10443,6 +10446,7 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!alloc_rt_sched_group(tg, parent))
 		goto err;
 
+	scx_group_set_weight(tg, CGROUP_WEIGHT_DFL);
 	alloc_uclamp_sched_group(tg, parent);
 
 	return tg;
@@ -10569,6 +10573,7 @@ void sched_move_task(struct task_struct *tsk)
 		put_prev_task(rq, tsk);
 
 	sched_change_group(tsk, group);
+	scx_move_task(tsk);
 
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
@@ -10609,6 +10614,11 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
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
@@ -10625,6 +10635,13 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
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
@@ -10642,9 +10659,10 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
 	sched_unregister_group(tg);
 }
 
-#ifdef CONFIG_RT_GROUP_SCHED
+#if defined(CONFIG_RT_GROUP_SCHED) || defined(CONFIG_EXT_GROUP_SCHED)
 static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 {
+#ifdef CONFIG_RT_GROUP_SCHED
 	struct task_struct *task;
 	struct cgroup_subsys_state *css;
 
@@ -10652,7 +10670,8 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 		if (!sched_rt_can_attach(css_tg(css), task))
 			return -EINVAL;
 	}
-	return 0;
+#endif
+	return scx_cgroup_can_attach(tset);
 }
 #endif
 
@@ -10663,8 +10682,17 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 
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
@@ -10846,9 +10874,15 @@ static int cpu_uclamp_max_show(struct seq_file *sf, void *v)
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
@@ -11312,11 +11346,15 @@ static int cpu_extra_stat_show(struct seq_file *sf,
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
@@ -11329,13 +11367,17 @@ static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
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
@@ -11360,7 +11402,7 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 				     struct cftype *cft, s64 nice)
 {
 	unsigned long weight;
-	int idx;
+	int idx, ret;
 
 	if (nice < MIN_NICE || nice > MAX_NICE)
 		return -ERANGE;
@@ -11369,7 +11411,11 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
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
 
@@ -11431,7 +11477,7 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 #endif
 
 struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1] = {
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_EXT_GROUP_SCHED)
 	[CPU_CFTYPE_WEIGHT] = {
 		.name = "weight",
 		.flags = CFTYPE_NOT_ON_ROOT,
@@ -11444,6 +11490,8 @@ struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1] = {
 		.read_s64 = cpu_weight_nice_read_s64,
 		.write_s64 = cpu_weight_nice_write_s64,
 	},
+#endif
+#ifdef CONFIG_FAIR_GROUP_SCHED
 	[CPU_CFTYPE_IDLE] = {
 		.name = "idle",
 		.flags = CFTYPE_NOT_ON_ROOT,
@@ -11485,13 +11533,17 @@ struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1] = {
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
index 490df7a43b70..5862e8290207 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1841,6 +1841,28 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
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
@@ -1850,7 +1872,9 @@ static int scx_ops_prepare_task(struct task_struct *p, struct task_group *tg)
 	p->scx.disallow = false;
 
 	if (SCX_HAS_OP(prep_enable)) {
-		struct scx_enable_args args = { };
+		struct scx_enable_args args = {
+			SCX_ENABLE_ARGS_INIT_CGROUP(tg)
+		};
 
 		ret = SCX_CALL_OP_RET(SCX_KF_SLEEPABLE, prep_enable, p, &args);
 		if (unlikely(ret)) {
@@ -1890,7 +1914,9 @@ static void scx_ops_enable_task(struct task_struct *p)
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_OPS_PREPPED));
 
 	if (SCX_HAS_OP(enable)) {
-		struct scx_enable_args args = { };
+		struct scx_enable_args args = {
+			SCX_ENABLE_ARGS_INIT_CGROUP(task_group(p))
+		};
 		SCX_CALL_OP_TASK(SCX_KF_REST, enable, p, &args);
 	}
 	p->scx.flags &= ~SCX_TASK_OPS_PREPPED;
@@ -1903,7 +1929,9 @@ static void scx_ops_disable_task(struct task_struct *p)
 
 	if (p->scx.flags & SCX_TASK_OPS_PREPPED) {
 		if (SCX_HAS_OP(cancel_enable)) {
-			struct scx_enable_args args = { };
+			struct scx_enable_args args = {
+				SCX_ENABLE_ARGS_INIT_CGROUP(task_group(p))
+			};
 			SCX_CALL_OP(SCX_KF_REST, cancel_enable, p, &args);
 		}
 		p->scx.flags &= ~SCX_TASK_OPS_PREPPED;
@@ -2073,6 +2101,166 @@ bool scx_can_stop_tick(struct rq *rq)
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
@@ -2202,6 +2390,131 @@ static void destroy_dsq(u64 dsq_id)
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
@@ -2346,9 +2659,10 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	static_branch_disable(&__scx_switched_all);
 	WRITE_ONCE(scx_switching_all, false);
 
-	/* avoid racing against fork */
+	/* avoid racing against fork and cgroup changes */
 	cpus_read_lock();
 	percpu_down_write(&scx_fork_rwsem);
+	scx_cgroup_lock();
 
 	spin_lock_irq(&scx_tasks_lock);
 	scx_task_iter_init(&sti);
@@ -2384,6 +2698,9 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
 	synchronize_rcu();
 
+	scx_cgroup_exit();
+
+	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 	cpus_read_unlock();
 
@@ -2422,6 +2739,8 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 
 	WARN_ON_ONCE(scx_ops_set_enable_state(SCX_OPS_DISABLED) !=
 		     SCX_OPS_DISABLING);
+
+	scx_cgroup_config_knobs();
 }
 
 static DEFINE_KTHREAD_WORK(scx_ops_disable_work, scx_ops_disable_workfn);
@@ -2567,10 +2886,11 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
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
@@ -2589,6 +2909,14 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
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
@@ -2671,6 +2999,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 
 	spin_unlock_irq(&scx_tasks_lock);
 	preempt_enable();
+	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 
 	if (!scx_ops_tryset_enable_state(SCX_OPS_ENABLED, SCX_OPS_ENABLING)) {
@@ -2684,6 +3013,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	cpus_read_unlock();
 	mutex_unlock(&scx_ops_enable_mutex);
 
+	scx_cgroup_config_knobs();
+
 	return 0;
 
 err_unlock:
@@ -2691,6 +3022,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	return ret;
 
 err_disable_unlock:
+	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 err_disable:
 	cpus_read_unlock();
@@ -2848,6 +3180,11 @@ static int bpf_scx_check_member(const struct btf_type *t,
 
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
@@ -2965,7 +3302,8 @@ void __init init_sched_ext_class(void)
 	 * definitions so that BPF scheduler implementations can use them
 	 * through the generated vmlinux.h.
 	 */
-	WRITE_ONCE(v, SCX_WAKE_EXEC | SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP);
+	WRITE_ONCE(v, SCX_WAKE_EXEC | SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP |
+		   SCX_TG_ONLINE);
 
 	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
 	init_dsq(&scx_dsq_global, SCX_DSQ_GLOBAL);
@@ -2986,6 +3324,7 @@ void __init init_sched_ext_class(void)
 
 	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
 	INIT_DELAYED_WORK(&scx_watchdog_work, scx_watchdog_workfn);
+	scx_cgroup_config_knobs();
 }
 
 
@@ -3027,8 +3366,8 @@ static const struct btf_kfunc_id_set scx_kfunc_set_init = {
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
@@ -3514,6 +3853,41 @@ s32 scx_bpf_task_cpu(const struct task_struct *p)
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
+#ifdef CONFIG_CGROUP_SCHED
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
+#endif
+
 BTF_SET8_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
@@ -3527,6 +3901,9 @@ BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
+#ifdef CONFIG_CGROUP_SCHED
+BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
+#endif
 BTF_SET8_END(scx_kfunc_ids_any)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 0953091750a6..c3404a0a7637 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -67,6 +67,11 @@ enum scx_kick_flags {
 	SCX_KICK_PREEMPT	= 1LLU << 0,	/* force scheduling on the CPU */
 };
 
+enum scx_tg_flags {
+	SCX_TG_ONLINE		= 1U << 0,
+	SCX_TG_INITED		= 1U << 1,
+};
+
 #ifdef CONFIG_SCHED_CLASS_EXT
 
 struct sched_enq_and_set_ctx {
@@ -183,3 +188,23 @@ static inline void scx_update_idle(struct rq *rq, bool idle)
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
index f79fa633e343..00bf33fdbd64 100644
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
@@ -3558,7 +3568,7 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
 
 #ifdef CONFIG_CGROUP_SCHED
 enum cpu_cftype_id {
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_EXT_GROUP_SCHED)
 	CPU_CFTYPE_WEIGHT,
 	CPU_CFTYPE_WEIGHT_NICE,
 	CPU_CFTYPE_IDLE,
diff --git a/tools/sched_ext/scx_common.bpf.h b/tools/sched_ext/scx_common.bpf.h
index 1a0184024eaf..4f8e447f66d3 100644
--- a/tools/sched_ext/scx_common.bpf.h
+++ b/tools/sched_ext/scx_common.bpf.h
@@ -69,6 +69,7 @@ void scx_bpf_put_idle_cpumask(const struct cpumask *cpumask) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
+struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym;
 
 #define BPF_STRUCT_OPS(name, args...)						\
 SEC("struct_ops/"#name)								\
-- 
2.41.0

