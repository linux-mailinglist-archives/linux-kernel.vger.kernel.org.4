Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D8E736235
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjFTDhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjFTDhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:37:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCE110C2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 20:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687232232; x=1718768232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pK1VeDOjkDkrNAELAM1rtg3Vev/TmJI42Cl4S2Jok0g=;
  b=ITj7E/NgzGWA3PzIrwouHHozUCuviJ9BXfZdtCxKCtznnj/NINT7Y8uY
   dZ36sMCgXOSFDQXfMgrl/8Salpe1XC7BRP6O6DRkUCiGojEWG/oetIy+1
   GXAFzFkD7dOYLw4Z14COZzsZjhBljtZX+VvK5UQtjkjwUeiV8h2fKnSQW
   LmrbmJ7R+Fr53DzoXZyEPi1KMgDhj6LaMQ8roHyjyHdNrvEax5Pf6qhzz
   QBEBWceBkrk7hEnXgCayBYmQiDnk717XVGl+j4Y9RVF7FKApu6cdxuYQv
   X2IHOqkqF6L0XdNdUTM4SDwgLTk8vKHvhXBkHKJYXATbMBViOWD1XlE4j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="344501394"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="344501394"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 20:37:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="717079118"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="717079118"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 20:37:09 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     James Morse <james.morse@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Peter Newman <peternewman@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, aricciardi@baylibre.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH 1/2] resctrl2: Add all the generic code
Date:   Mon, 19 Jun 2023 20:37:01 -0700
Message-Id: <20230620033702.33344-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620033702.33344-1-tony.luck@intel.com>
References: <20230620033702.33344-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic resctrly code is responsible for:

0) Mounting and unmounting /sys/fs/resctrl
1) Creating and removing groups
2) Associating tasks with groups
3) Associating CPUs with groups
4) Context switch, calling architecture code to begin control/monitor
   for the nex task based on which groups it is in, and which CPU it
   is running on.
5) Registering and unregistering architecture modules for all control
   and monitor functions.

N.B. Much of this code is just the old resctrl code with a bunch of
renaming and refactoring.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h | 107 ++++++++++++++
 include/linux/sched.h   |   3 +
 fs/resctrl2/internal.h  | 110 ++++++++++++++
 fs/resctrl2/cpu.c       | 315 ++++++++++++++++++++++++++++++++++++++++
 fs/resctrl2/directory.c | 295 +++++++++++++++++++++++++++++++++++++
 fs/resctrl2/domain.c    |  99 +++++++++++++
 fs/resctrl2/info.c      |  99 +++++++++++++
 fs/resctrl2/kernfs.c    |  58 ++++++++
 fs/resctrl2/locking.c   |  52 +++++++
 fs/resctrl2/resources.c |  85 +++++++++++
 fs/resctrl2/root.c      | 173 ++++++++++++++++++++++
 fs/resctrl2/schemata.c  | 110 ++++++++++++++
 fs/resctrl2/tasks.c     | 193 ++++++++++++++++++++++++
 fs/Kconfig              |   1 +
 fs/Makefile             |   1 +
 fs/resctrl2/Kconfig     |   5 +
 fs/resctrl2/Makefile    |  14 ++
 17 files changed, 1720 insertions(+)
 create mode 100644 fs/resctrl2/internal.h
 create mode 100644 fs/resctrl2/cpu.c
 create mode 100644 fs/resctrl2/directory.c
 create mode 100644 fs/resctrl2/domain.c
 create mode 100644 fs/resctrl2/info.c
 create mode 100644 fs/resctrl2/kernfs.c
 create mode 100644 fs/resctrl2/locking.c
 create mode 100644 fs/resctrl2/resources.c
 create mode 100644 fs/resctrl2/root.c
 create mode 100644 fs/resctrl2/schemata.c
 create mode 100644 fs/resctrl2/tasks.c
 create mode 100644 fs/resctrl2/Kconfig
 create mode 100644 fs/resctrl2/Makefile

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8334eeacfec5..889d9c65d8d9 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -2,6 +2,8 @@
 #ifndef _RESCTRL_H
 #define _RESCTRL_H
 
+#ifdef CONFIG_X86_CPU_RESCTRL
+
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/pid.h>
@@ -264,4 +266,109 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d);
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
+#endif /* CONFIG_X86_CPU_RESCTRL */
+
+#ifdef CONFIG_RESCTRL2_FS
+
+#include <linux/sched.h>
+#include <linux/jump_label.h>
+
+bool arch_check_resctrl_support(void);
+void arch_resctrl_apply_ids(u64 resctrl_ids);
+extern u64 arch_resctrl_default_ids;
+
+DECLARE_STATIC_KEY_FALSE(resctrl_enable_key);
+
+struct resctrl_per_cpu_state {
+	u64	cached_resctrl_ids;
+	u64	default_resctrl_ids;
+};
+
+DECLARE_PER_CPU(struct resctrl_per_cpu_state, resctrl_per_cpu_state);
+
+static inline void resctrl_sched_in(struct task_struct *tsk)
+{
+	struct resctrl_per_cpu_state *state;
+	u64 new_resctrl_ids;
+
+	if (!static_branch_likely(&resctrl_enable_key))
+		return;
+
+	state = this_cpu_ptr(&resctrl_per_cpu_state);
+	new_resctrl_ids = state->default_resctrl_ids;
+
+	if (tsk->resctrl_ids != arch_resctrl_default_ids)
+		new_resctrl_ids = tsk->resctrl_ids;
+
+	if (new_resctrl_ids != state->cached_resctrl_ids) {
+		state->cached_resctrl_ids = new_resctrl_ids;
+		arch_resctrl_apply_ids(new_resctrl_ids);
+	}
+}
+
+/* Unclear if this is still useful */
+static inline void resctrl_cpu_detect(struct cpuinfo_x86 *c) {}
+
+enum resctrl_type {
+	RESCTRL_CONTROL,
+	RESCTRL_MONITOR,
+};
+
+enum resctrl_scope {
+	RESCTRL_CORE,
+	RESCTRL_L2CACHE,
+	RESCTRL_L3CACHE,
+	RESCTRL_SOCKET,
+};
+
+enum resctrl_domain_update {
+	RESCTRL_DOMAIN_ADD,
+	RESCTRL_DOMAIN_ADD_CPU,
+	RESCTRL_DOMAIN_DELETE_CPU,
+	RESCTRL_DOMAIN_DELETE,
+};
+
+struct resctrl_domain {
+	struct list_head	list;
+	struct cpumask		cpu_mask;
+	int			id;
+};
+
+struct resctrl_fileinfo {
+	char			*name;
+	struct kernfs_ops	*ops;
+	void			*priv;
+};
+
+struct resctrl_resource {
+	char			*name;
+	int			archtag;
+	struct list_head	list;
+	int			type;
+	enum resctrl_scope	scope;
+	size_t			domain_size;
+	struct list_head	domains;
+	void			(*domain_update)(struct resctrl_resource *r, int what, int cpu, struct resctrl_domain *d);
+
+	char			*infodir;
+	struct resctrl_fileinfo	*infofiles;
+
+	// bits for control resources
+	int			num_alloc_ids;
+	void			(*show)(struct resctrl_resource *r, struct seq_file *m, u64 resctrl_ids);
+	void			(*resetstaging)(struct resctrl_resource *r, u64 resctrl_ids);
+	int			(*parse)(struct resctrl_resource *r, char *tok, u64 resctrl_ids);
+	void			(*applychanges)(struct resctrl_resource *r, u64 resctrl_ids);
+
+	// bits for monitor resources
+	char			*mon_domain_dir;
+	char			*mon_domain_file;
+	struct kernfs_ops	*mod_domain_ops;
+	int			mon_event;
+};
+
+int resctrl_register_ctrl_resource(struct resctrl_resource *r);
+void resctrl_unregister_ctrl_resource(struct resctrl_resource *r);
+
+#endif /* CONFIG_RESCTRL2_FS */
 #endif /* _RESCTRL_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index eed5d65b8d1f..ab5e861bcb80 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1228,6 +1228,9 @@ struct task_struct {
 	u32				closid;
 	u32				rmid;
 #endif
+#ifdef CONFIG_RESCTRL2_FS
+	u64				resctrl_ids;
+#endif
 #ifdef CONFIG_FUTEX
 	struct robust_list_head __user	*robust_list;
 #ifdef CONFIG_COMPAT
diff --git a/fs/resctrl2/internal.h b/fs/resctrl2/internal.h
new file mode 100644
index 000000000000..8b56f23e95b8
--- /dev/null
+++ b/fs/resctrl2/internal.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include <linux/cpu.h>
+#include <linux/kernfs.h>
+#include <linux/resctrl.h>
+#include <linux/seq_buf.h>
+#include <linux/seq_file.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "resctrl2: " fmt
+
+enum directory_type {
+	DIR_ROOT,
+	DIR_CTRL_MON,
+	DIR_MONGROUP,
+	DIR_MONDATA,
+	DIR_MON,
+	DIR_INFO,
+};
+
+struct resctrl_group {
+	enum directory_type	type;
+	atomic_t		waitcount;
+
+	struct kernfs_node	*kn;
+	u32			flags;
+	u64			resctrl_ids;
+	struct list_head	list;
+
+	struct resctrl_group	*parent;
+	struct list_head	child_list;
+	struct kernfs_node	*mondata;
+
+	struct cpumask		cpu_mask;
+};
+
+#include <asm/resctrl.h>
+
+extern struct resctrl_group resctrl_default;
+
+/* resctrl_group.flags */
+#define RESCTRL_DELETED	1
+
+#define for_each_resource(r)						\
+	list_for_each_entry(r, &resctrl_all_resources, list)
+
+#define for_each_control_resource(r)					\
+	list_for_each_entry(r, &resctrl_all_resources, list)		\
+		if (r->type == RESCTRL_CONTROL)
+
+#define for_each_monitor_resource(r)					\
+	list_for_each_entry(r, &resctrl_all_resources, list)		\
+		if (r->type == RESCTRL_MONITOR)
+
+// cpu.c
+int resctrl_cpu_init(void);
+void resctrl_cpu_exit(void);
+bool resctrl_add_cpus_file(struct kernfs_node *parent_kn);
+void update_resctrl_ids(const struct cpumask *cpu_mask, struct resctrl_group *r);
+
+// directory.c
+int resctrl_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode);
+int resctrl_rmdir(struct kernfs_node *kn);
+void resctrl_rmdir_all_sub(void);
+bool resctrl_populate_dir(struct kernfs_node *parent_kn, struct resctrl_group *rg);
+void resctrl_create_domain_files(struct kernfs_node *parent_kn, struct resctrl_resource *r,
+				 struct resctrl_group *rg);
+void resctrl_remove_domain_files(struct kernfs_node *parent_kn, struct resctrl_resource *r,
+				 struct resctrl_group *rg);
+void resctrl_group_remove(struct resctrl_group *rg);
+
+// domain.c
+void resctrl_domain_add_cpu(unsigned int cpu, struct resctrl_resource *r);
+void resctrl_domain_remove_cpu(unsigned int cpu, struct resctrl_resource *r);
+
+// info.c
+bool resctrl_add_info_dir(struct kernfs_node *parent_kn);
+void resctrl_addinfofiles(char *name, struct resctrl_fileinfo *files);
+void resctrl_delinfofiles(char *name);
+void resctrl_last_cmd_clear(void);
+void resctrl_last_cmd_puts(const char *s);
+void resctrl_last_cmd_printf(const char *fmt, ...);
+
+// kernfs.c
+struct kernfs_node *resctrl_add_file(struct kernfs_node *parent_kn, char *name, umode_t mode,
+				     const struct kernfs_ops *ops, void *priv);
+struct kernfs_node *resctrl_add_dir(struct kernfs_node *parent_kn, const char *name,
+				    void *priv);
+
+// locking.c
+struct resctrl_group *resctrl_group_kn_lock_live(struct kernfs_node *kn);
+void resctrl_group_kn_unlock(struct kernfs_node *kn);
+struct resctrl_group *kernfs_to_resctrl_group(struct kernfs_node *kn);
+
+extern struct mutex resctrl_mutex;
+
+// resources.c
+extern struct list_head resctrl_all_resources;
+
+// root.c
+extern struct list_head all_ctrl_groups;
+
+// schemata.c
+bool resctrl_add_schemata_file(struct kernfs_node *parent_kn);
+
+// tasks.c
+bool resctrl_add_task_file(struct kernfs_node *parent_kn);
+void resctrl_move_group_tasks(struct resctrl_group *from, struct resctrl_group *to,
+			      struct cpumask *mask);
diff --git a/fs/resctrl2/cpu.c b/fs/resctrl2/cpu.c
new file mode 100644
index 000000000000..576f5c62fc4d
--- /dev/null
+++ b/fs/resctrl2/cpu.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include <linux/cpuhotplug.h>
+
+#include "internal.h"
+
+static int cpu_seq_show(struct seq_file *m, void *arg)
+{
+	struct kernfs_open_file *of = m->private;
+	struct resctrl_group *rg;
+	int ret = 0;
+
+	rg = resctrl_group_kn_lock_live(of->kn);
+	if (rg) {
+		seq_printf(m, of->kn->priv ? "%*pb\n" : "%*pbl\n",
+			   cpumask_pr_args(&rg->cpu_mask));
+	} else {
+		ret = -ENOENT;
+	}
+
+	resctrl_group_kn_unlock(of->kn);
+
+	return ret;
+}
+
+/*
+ * This is safe against resctrl_sched_in() called from __switch_to()
+ * because __switch_to() is executed with interrupts disabled. A local call
+ * from update_resctrl_ids() is protected against __switch_to() because
+ * preemption is disabled.
+ */
+static void update_cpu_resctrl_ids(void *info)
+{
+	struct resctrl_group *r = info;
+
+	if (r)
+		this_cpu_write(resctrl_per_cpu_state.default_resctrl_ids, r->resctrl_ids);
+
+	/*
+	 * Re-use the context switch code, current running
+	 * task may have its own reasctrl_ids selected.
+	 */
+	resctrl_sched_in(current);
+}
+
+/*
+ * Update the resctrl_ids on all cpus in @cpu_mask.
+ * Per task resctrl_ids must have been set up before calling this function.
+ */
+void update_resctrl_ids(const struct cpumask *cpu_mask, struct resctrl_group *r)
+{
+	on_each_cpu_mask(cpu_mask, update_cpu_resctrl_ids, r, 1);
+}
+
+static void cpumask_resctrl_group_clear(struct resctrl_group *r, struct cpumask *m)
+{
+	struct resctrl_group *crgrp;
+
+	cpumask_andnot(&r->cpu_mask, &r->cpu_mask, m);
+	/* update the child mon group masks as well*/
+	list_for_each_entry(crgrp, &r->child_list, list)
+		cpumask_and(&crgrp->cpu_mask, &r->cpu_mask, &crgrp->cpu_mask);
+}
+
+static int cpus_ctrl_write(struct resctrl_group *rg, cpumask_var_t newmask,
+			   cpumask_var_t tmpmask, cpumask_var_t tmpmask1)
+{
+	struct resctrl_group *r, *crgrp;
+	struct list_head *head;
+
+	/* Check whether cpus are dropped from this group */
+	cpumask_andnot(tmpmask, &rg->cpu_mask, newmask);
+	if (!cpumask_empty(tmpmask)) {
+		/* Can't drop from default group */
+		if (rg->type == DIR_ROOT) {
+			resctrl_last_cmd_puts("Can't drop CPUs from default group\n");
+			return -EINVAL;
+		}
+
+		/* Give any dropped cpus to resctrl_default */
+		cpumask_or(&resctrl_default.cpu_mask,
+			   &resctrl_default.cpu_mask, tmpmask);
+		update_resctrl_ids(tmpmask, &resctrl_default);
+	}
+
+	/*
+	 * If we added cpus, remove them from previous group and
+	 * the prev group's child groups that owned them
+	 * and update per-cpu resctrl_ids.
+	 */
+	cpumask_andnot(tmpmask, newmask, &rg->cpu_mask);
+	if (!cpumask_empty(tmpmask)) {
+		list_for_each_entry(r, &all_ctrl_groups, list) {
+			if (r == rg)
+				continue;
+			cpumask_and(tmpmask1, &r->cpu_mask, tmpmask);
+			if (!cpumask_empty(tmpmask1))
+				cpumask_resctrl_group_clear(r, tmpmask1);
+		}
+		update_resctrl_ids(tmpmask, rg);
+	}
+
+	/* Done pushing/pulling - update this group with new mask */
+	cpumask_copy(&rg->cpu_mask, newmask);
+
+	/*
+	 * Clear child mon group masks since there is a new parent mask
+	 * now and update the resctrl_ids for the cpus the child lost.
+	 */
+	head = &rg->child_list;
+	list_for_each_entry(crgrp, head, list) {
+		cpumask_and(tmpmask, &rg->cpu_mask, &crgrp->cpu_mask);
+		update_resctrl_ids(tmpmask, rg);
+		cpumask_clear(&crgrp->cpu_mask);
+	}
+
+	return 0;
+}
+
+static int cpus_mon_write(struct resctrl_group *rg, cpumask_var_t newmask,
+			  cpumask_var_t tmpmask)
+{
+	struct resctrl_group *prgrp = rg->parent, *crgrp;
+	struct list_head *head;
+
+	/* Check whether cpus belong to parent ctrl group */
+	cpumask_andnot(tmpmask, newmask, &prgrp->cpu_mask);
+	if (!cpumask_empty(tmpmask)) {
+		resctrl_last_cmd_puts("Can only add CPUs to mongroup that belong to parent\n");
+		return -EINVAL;
+	}
+
+	/* Check whether cpus are dropped from this group */
+	cpumask_andnot(tmpmask, &rg->cpu_mask, newmask);
+	if (!cpumask_empty(tmpmask)) {
+		/* Give any dropped cpus to parent group */
+		cpumask_or(&prgrp->cpu_mask, &prgrp->cpu_mask, tmpmask);
+		update_resctrl_ids(tmpmask, prgrp);
+	}
+
+	/*
+	 * If we added cpus, remove them from previous group that owned them
+	 * and update per-cpu resctrl_ids
+	 */
+	cpumask_andnot(tmpmask, newmask, &rg->cpu_mask);
+	if (!cpumask_empty(tmpmask)) {
+		head = &prgrp->child_list;
+		list_for_each_entry(crgrp, head, list) {
+			if (crgrp == rg)
+				continue;
+			cpumask_andnot(&crgrp->cpu_mask, &crgrp->cpu_mask,
+				       tmpmask);
+		}
+		update_resctrl_ids(tmpmask, rg);
+	}
+
+	/* Done pushing/pulling - update this group with new mask */
+	cpumask_copy(&rg->cpu_mask, newmask);
+
+	return 0;
+}
+
+static ssize_t cpu_write(struct kernfs_open_file *of, char *buf,
+			 size_t nbytes, loff_t off)
+{
+	cpumask_var_t tmpmask, newmask, tmpmask1;
+	struct resctrl_group *rg;
+	int ret;
+
+	if (!buf)
+		return -EINVAL;
+
+	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
+		return -ENOMEM;
+	if (!zalloc_cpumask_var(&newmask, GFP_KERNEL)) {
+		free_cpumask_var(tmpmask);
+		return -ENOMEM;
+	}
+	if (!zalloc_cpumask_var(&tmpmask1, GFP_KERNEL)) {
+		free_cpumask_var(tmpmask);
+		free_cpumask_var(newmask);
+		return -ENOMEM;
+	}
+
+	rg = resctrl_group_kn_lock_live(of->kn);
+	if (!rg) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	if (of->kn->priv)
+		ret = cpumask_parse(buf, newmask);
+	else
+		ret = cpulist_parse(buf, newmask);
+
+	if (ret) {
+		resctrl_last_cmd_puts("Bad CPU list/mask\n");
+		goto unlock;
+	}
+
+	/* check that user didn't specify any offline cpus */
+	cpumask_andnot(tmpmask, newmask, cpu_online_mask);
+	if (!cpumask_empty(tmpmask)) {
+		ret = -EINVAL;
+		resctrl_last_cmd_puts("Can only assign online CPUs\n");
+		goto unlock;
+	}
+
+	if (rg->type == DIR_ROOT || rg->type == DIR_CTRL_MON)
+		ret = cpus_ctrl_write(rg, newmask, tmpmask, tmpmask1);
+	else if (rg->type == DIR_MON)
+		ret = cpus_mon_write(rg, newmask, tmpmask);
+	else
+		ret = -EINVAL;
+
+unlock:
+	resctrl_group_kn_unlock(of->kn);
+	free_cpumask_var(tmpmask);
+	free_cpumask_var(newmask);
+	free_cpumask_var(tmpmask1);
+
+	return ret ?: nbytes;
+}
+
+static const struct kernfs_ops cpu_ops = {
+	.atomic_write_len	= PAGE_SIZE,
+	.write			= cpu_write,
+	.seq_show		= cpu_seq_show,
+};
+
+bool resctrl_add_cpus_file(struct kernfs_node *parent_kn)
+{
+	struct kernfs_node *kn;
+
+	kn = resctrl_add_file(parent_kn, "cpus", 0644, &cpu_ops, (void *)1);
+	if (IS_ERR(kn))
+		return false;
+
+	kn = resctrl_add_file(parent_kn, "cpus_list", 0644, &cpu_ops, (void *)0);
+	if (IS_ERR(kn))
+		return false;
+
+	return true;
+}
+
+static void reset_resctrl_ids(void)
+{
+	struct resctrl_per_cpu_state *state = this_cpu_ptr(&resctrl_per_cpu_state);
+
+	state->cached_resctrl_ids = arch_resctrl_default_ids;
+	state->default_resctrl_ids = arch_resctrl_default_ids;
+
+	arch_resctrl_apply_ids(arch_resctrl_default_ids);
+}
+
+static int resctrl_online_cpu(unsigned int cpu)
+{
+	struct resctrl_resource *r;
+
+	mutex_lock(&resctrl_mutex);
+	for_each_control_resource(r)
+		resctrl_domain_add_cpu(cpu, r);
+	/* The cpu is set in default group after online. */
+	cpumask_set_cpu(cpu, &resctrl_default.cpu_mask);
+	reset_resctrl_ids();
+	mutex_unlock(&resctrl_mutex);
+
+	return 0;
+}
+
+static void clear_childcpus(struct resctrl_group *rg, unsigned int cpu)
+{
+	struct resctrl_group *crg;
+
+	list_for_each_entry(crg, &rg->child_list, list) {
+		if (cpumask_test_and_clear_cpu(cpu, &crg->cpu_mask))
+			break;
+	}
+}
+
+static int resctrl_offline_cpu(unsigned int cpu)
+{
+	struct resctrl_resource *r;
+	struct resctrl_group *rg;
+
+	mutex_lock(&resctrl_mutex);
+	for_each_control_resource(r)
+		resctrl_domain_remove_cpu(cpu, r);
+	list_for_each_entry(rg, &all_ctrl_groups, list) {
+		if (cpumask_test_and_clear_cpu(cpu, &rg->cpu_mask)) {
+			clear_childcpus(rg, cpu);
+			break;
+		}
+	}
+	reset_resctrl_ids();
+	mutex_unlock(&resctrl_mutex);
+
+	return 0;
+}
+
+static enum cpuhp_state cpu_hp_state;
+
+int resctrl_cpu_init(void)
+{
+	cpu_hp_state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+					 "resctrl2/cpu:online",
+					 resctrl_online_cpu, resctrl_offline_cpu);
+	return cpu_hp_state;
+}
+
+void resctrl_cpu_exit(void)
+{
+	cpuhp_remove_state(cpu_hp_state);
+}
diff --git a/fs/resctrl2/directory.c b/fs/resctrl2/directory.c
new file mode 100644
index 000000000000..b8b2c13faaec
--- /dev/null
+++ b/fs/resctrl2/directory.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include "internal.h"
+
+static struct resctrl_group mongroup_header = {
+	.type = DIR_MONGROUP
+};
+
+static struct resctrl_group mondata_header = {
+	.type = DIR_MONDATA
+};
+
+void resctrl_create_domain_files(struct kernfs_node *parent_kn, struct resctrl_resource *r,
+				 struct resctrl_group *rg)
+{
+	struct resctrl_domain *d;
+	struct kernfs_node *kn;
+	char name[20];
+
+	list_for_each_entry(d, &r->domains, list) {
+		sprintf(name, r->mon_domain_dir, d->id);
+		kn = kernfs_find_and_get_ns(parent_kn, name, NULL);
+		if (!kn)
+			kn = resctrl_add_dir(parent_kn, name, (void *)(long)d->id);
+		resctrl_add_file(kn, r->mon_domain_file, 0444, r->mod_domain_ops,
+				 (void *)rg->resctrl_ids);
+	}
+	kernfs_activate(parent_kn);
+}
+
+void resctrl_remove_domain_files(struct kernfs_node *parent_kn, struct resctrl_resource *r,
+				 struct resctrl_group *rg)
+{
+	struct resctrl_domain *d;
+	struct kernfs_node *kn;
+	char name[20];
+
+	list_for_each_entry(d, &r->domains, list) {
+		sprintf(name, r->mon_domain_dir, d->id);
+		kn = kernfs_find_and_get_ns(parent_kn, name, NULL);
+		kn = kernfs_find_and_get_ns(kn, r->mon_domain_file, NULL);
+		kernfs_remove(kn);
+	}
+}
+
+bool resctrl_populate_dir(struct kernfs_node *parent_kn, struct resctrl_group *rg)
+{
+	struct resctrl_resource *r;
+	struct kernfs_node *kn;
+
+	if (!resctrl_add_task_file(parent_kn))
+		return false;
+
+	if ((rg->type == DIR_ROOT || rg->type == DIR_CTRL_MON) &&
+	    !resctrl_add_schemata_file(parent_kn))
+		return false;
+
+	if (!resctrl_add_cpus_file(parent_kn))
+		return false;
+
+	if (!resctrl_add_dir(parent_kn, "mon_groups", &mongroup_header))
+		return false;
+
+	kn = resctrl_add_dir(parent_kn, "mon_data", &mondata_header);
+	if (!kn)
+		return false;
+	rg->mondata = kn;
+
+	for_each_monitor_resource(r)
+		if (r->mon_domain_dir)
+			resctrl_create_domain_files(rg->mondata, r, rg);
+
+	return true;
+}
+
+void resctrl_group_remove(struct resctrl_group *rg)
+{
+	kernfs_put(rg->kn);
+	kfree(rg);
+}
+
+int resctrl_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
+{
+	struct resctrl_group *rg, *prg;
+	struct kernfs_node *kn;
+	int ret = 0;
+
+	if (strchr(name, '\n'))
+		return -EINVAL;
+
+	rg = kzalloc(sizeof(*rg), GFP_KERNEL);
+	if (!rg)
+		return -ENOMEM;
+
+	prg = resctrl_group_kn_lock_live(parent_kn);
+	if (!prg) {
+		kfree(rg);
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	switch (prg->type) {
+	case DIR_ROOT:
+		rg->type = DIR_CTRL_MON;
+		rg->parent = kernfs_to_resctrl_group(parent_kn);
+		if (!arch_alloc_resctrl_ids(rg)) {
+			kfree(rg);
+			ret = -ENOSPC;
+			goto unlock;
+		}
+		list_add(&rg->list, &all_ctrl_groups);
+		INIT_LIST_HEAD(&rg->child_list);
+		break;
+	case DIR_MONGROUP:
+		rg->type = DIR_MON;
+		rg->parent = kernfs_to_resctrl_group(parent_kn->parent);
+		if (!arch_alloc_resctrl_ids(rg)) {
+			kfree(rg);
+			ret = -ENOSPC;
+			goto unlock;
+		}
+		list_add(&rg->list, &rg->parent->child_list);
+		break;
+	default:
+		kfree(rg);
+		ret = -EPERM;
+		goto unlock;
+	}
+
+	kn = resctrl_add_dir(parent_kn, name, rg);
+	if (!kn) {
+		list_del(&rg->list);
+		kfree(rg);
+		ret = -EINVAL;
+		goto unlock;
+	}
+	rg->kn = kn;
+	kernfs_get(kn);
+
+	resctrl_populate_dir(kn, rg);
+
+	kernfs_activate(kn);
+unlock:
+	resctrl_group_kn_unlock(parent_kn);
+
+	return ret;
+}
+
+static void free_all_child_resctrlgrp(struct resctrl_group *rg)
+{
+	struct resctrl_group *sentry, *stmp;
+	struct list_head *head;
+
+	head = &rg->child_list;
+	list_for_each_entry_safe(sentry, stmp, head, list) {
+		arch_free_resctrl_ids(sentry);
+		list_del(&sentry->list);
+
+		if (atomic_read(&sentry->waitcount) != 0)
+			sentry->flags = RESCTRL_DELETED;
+		else
+			resctrl_group_remove(sentry);
+	}
+}
+
+static void resctrl_rmdir_ctrl(struct resctrl_group *rg, struct cpumask *mask)
+{
+	int cpu;
+
+	/* Give any tasks back to the default group */
+	resctrl_move_group_tasks(rg, rg->parent, mask);
+
+	/* Give any CPUs back to the default group */
+	cpumask_or(&resctrl_default.cpu_mask,
+		   &resctrl_default.cpu_mask, &rg->cpu_mask);
+
+	/* Update resctrl_ids of the moved CPUs first */
+	for_each_cpu(cpu, &rg->cpu_mask)
+		per_cpu(resctrl_per_cpu_state.default_resctrl_ids, cpu) = arch_resctrl_default_ids;
+
+	/*
+	 * Update the MSR on moved CPUs and CPUs which have moved
+	 * task running on them.
+	 */
+	cpumask_or(mask, mask, &rg->cpu_mask);
+	update_resctrl_ids(mask, NULL);
+
+	/*
+	 * Free all the child monitor groups.
+	 */
+	free_all_child_resctrlgrp(rg);
+
+	arch_free_resctrl_ids(rg);
+	list_del(&rg->list);
+
+	rg->flags = RESCTRL_DELETED;
+	kernfs_remove(rg->kn);
+}
+
+static void resctrl_rmdir_mon(struct resctrl_group *rg, struct cpumask *mask)
+{
+	struct resctrl_group *prg = rg->parent;
+	int cpu;
+
+	/* Give any tasks back to the parent group */
+	resctrl_move_group_tasks(rg, prg, mask);
+
+	/* Update per cpu resctrl_ids of the moved CPUs first */
+	for_each_cpu(cpu, &rg->cpu_mask)
+		per_cpu(resctrl_per_cpu_state.default_resctrl_ids, cpu) = prg->resctrl_ids;
+	/*
+	 * Update the MSR on moved CPUs and CPUs which have moved
+	 * task running on them.
+	 */
+	cpumask_or(mask, mask, &rg->cpu_mask);
+	update_resctrl_ids(mask, NULL);
+
+	rg->flags = RESCTRL_DELETED;
+	arch_free_resctrl_ids(rg);
+
+	/*
+	 * Remove the group from parent's list of children
+	 */
+	WARN_ON(list_empty(&prg->child_list));
+	list_del(&rg->list);
+
+	kernfs_remove(rg->kn);
+}
+
+int resctrl_rmdir(struct kernfs_node *kn)
+{
+	struct resctrl_group *rg;
+	cpumask_var_t tmpmask;
+	int ret = 0;
+
+	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
+		return -ENOMEM;
+	rg = resctrl_group_kn_lock_live(kn);
+	if (!rg || (rg->type != DIR_CTRL_MON && rg->type != DIR_MON)) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	if (rg->type == DIR_CTRL_MON)
+		resctrl_rmdir_ctrl(rg, tmpmask);
+	else
+		resctrl_rmdir_mon(rg, tmpmask);
+
+out:
+	resctrl_group_kn_unlock(kn);
+	free_cpumask_var(tmpmask);
+
+	return ret;
+}
+
+void resctrl_rmdir_all_sub(void)
+{
+	struct resctrl_group *rg, *tmp;
+
+	list_for_each_entry_safe(rg, tmp, &all_ctrl_groups, list) {
+		/* Free any child resource ids */
+		free_all_child_resctrlgrp(rg);
+
+		/* Remove each group other than root */
+		if (rg->type == DIR_ROOT)
+			continue;
+
+		/*
+		 * Give any CPUs back to the default group. We cannot copy
+		 * cpu_online_mask because a CPU might have executed the
+		 * offline callback already, but is still marked online.
+		 */
+		cpumask_or(&resctrl_default.cpu_mask,
+			   &resctrl_default.cpu_mask, &rg->cpu_mask);
+
+		arch_free_resctrl_ids(rg);
+
+		kernfs_remove(rg->kn);
+		list_del(&rg->list);
+
+		if (atomic_read(&rg->waitcount) != 0)
+			rg->flags = RESCTRL_DELETED;
+		else
+			resctrl_group_remove(rg);
+	}
+	/* Notify online CPUs to update per cpu storage and PQR_ASSOC MSR */
+	update_resctrl_ids(cpu_online_mask, &resctrl_default);
+
+#if 0
+	kernfs_remove(kn_info);
+	kernfs_remove(kn_mongrp);
+	kernfs_remove(kn_mondata);
+#endif
+}
diff --git a/fs/resctrl2/domain.c b/fs/resctrl2/domain.c
new file mode 100644
index 000000000000..51eec5f41e61
--- /dev/null
+++ b/fs/resctrl2/domain.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include <linux/cacheinfo.h>
+#include "internal.h"
+
+/*
+ * find_domain - Find a domain in a resource that matches input resource id
+ *
+ * Search resource r's domain list to find the resource id. If the resource
+ * id is found in a domain, return the domain. Otherwise, if requested by
+ * caller, return the first domain whose id is bigger than the input id.
+ * The domain list is sorted by id in ascending order.
+ */
+static struct resctrl_domain *find_domain(struct resctrl_resource *r, int id,
+					  struct list_head **pos)
+{
+	struct resctrl_domain *d;
+	struct list_head *l;
+
+	if (id < 0)
+		return ERR_PTR(-ENODEV);
+
+	list_for_each(l, &r->domains) {
+		d = list_entry(l, struct resctrl_domain, list);
+		/* When id is found, return its domain. */
+		if (id == d->id)
+			return d;
+		/* Stop searching when finding id's position in sorted list. */
+		if (id < d->id)
+			break;
+	}
+
+	if (pos)
+		*pos = l;
+
+	return NULL;
+}
+
+static int get_domain_id(unsigned int cpu, enum resctrl_scope scope)
+{
+	switch (scope) {
+	case RESCTRL_CORE: return topology_core_id(cpu);
+	case RESCTRL_L2CACHE: return get_cpu_cacheinfo_id(cpu, 2);
+	case RESCTRL_L3CACHE: return get_cpu_cacheinfo_id(cpu, 3);
+	case RESCTRL_SOCKET: return topology_physical_package_id(cpu);
+	}
+	return -1;
+}
+
+void resctrl_domain_add_cpu(unsigned int cpu, struct resctrl_resource *r)
+{
+	int id = get_domain_id(cpu, r->scope);
+	struct list_head *add_pos = NULL;
+	struct resctrl_domain *d;
+
+	d = find_domain(r, id, &add_pos);
+	if (IS_ERR(d)) {
+		pr_warn("Couldn't find domain id for CPU %d\n", cpu);
+		return;
+	}
+
+	if (d) {
+		cpumask_set_cpu(cpu, &d->cpu_mask);
+		r->domain_update(r, RESCTRL_DOMAIN_ADD_CPU, cpu, d);
+		return;
+	}
+
+	d = kzalloc_node(r->domain_size, GFP_KERNEL, cpu_to_node(cpu));
+	if (!d)
+		return;
+
+	d->id = id;
+	cpumask_set_cpu(cpu, &d->cpu_mask);
+	r->domain_update(r, RESCTRL_DOMAIN_ADD, cpu, d);
+
+	list_add_tail(&d->list, add_pos);
+}
+
+void resctrl_domain_remove_cpu(unsigned int cpu, struct resctrl_resource *r)
+{
+	int id = get_domain_id(cpu, r->scope);
+	struct resctrl_domain *d;
+
+	d = find_domain(r, id, NULL);
+	if (IS_ERR_OR_NULL(d)) {
+		pr_warn("Couldn't find domain id for CPU %d\n", cpu);
+		return;
+	}
+
+	cpumask_clear_cpu(cpu, &d->cpu_mask);
+	if (cpumask_empty(&d->cpu_mask)) {
+		r->domain_update(r, RESCTRL_DOMAIN_DELETE, cpu, d);
+		list_del(&d->list);
+		kfree(d);
+	} else {
+		r->domain_update(r, RESCTRL_DOMAIN_DELETE_CPU, cpu, d);
+	}
+}
diff --git a/fs/resctrl2/info.c b/fs/resctrl2/info.c
new file mode 100644
index 000000000000..043c2dcd4dd7
--- /dev/null
+++ b/fs/resctrl2/info.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include "internal.h"
+
+static struct kernfs_node *kn_info;
+
+static struct resctrl_group info_header = {
+	.type = DIR_INFO
+};
+
+static struct seq_buf last_cmd_status;
+static char last_cmd_status_buf[512];
+
+void resctrl_last_cmd_clear(void)
+{
+	seq_buf_clear(&last_cmd_status);
+}
+
+void resctrl_last_cmd_puts(const char *s)
+{
+	seq_buf_puts(&last_cmd_status, s);
+}
+
+void resctrl_last_cmd_printf(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	seq_buf_vprintf(&last_cmd_status, fmt, ap);
+	va_end(ap);
+}
+
+static int last_cmd_status_seq_show(struct seq_file *m, void *arg)
+{
+	struct kernfs_open_file *of = m->private;
+	int len;
+
+	resctrl_group_kn_lock_live(of->kn);
+	len = seq_buf_used(&last_cmd_status);
+	if (len)
+		seq_printf(m, "%.*s", len, last_cmd_status_buf);
+	else
+		seq_puts(m, "ok\n");
+
+	resctrl_group_kn_unlock(of->kn);
+
+	return 0;
+}
+
+static struct kernfs_ops cmd_status_ops = {
+	.seq_show = last_cmd_status_seq_show,
+};
+
+bool resctrl_add_info_dir(struct kernfs_node *parent_kn)
+{
+	struct kernfs_node *kn;
+
+	seq_buf_init(&last_cmd_status, last_cmd_status_buf,
+		     sizeof(last_cmd_status_buf));
+
+	kn_info = resctrl_add_dir(parent_kn, "info", &info_header);
+	if (!kn_info)
+		return false;
+
+	kn = resctrl_add_file(kn_info, "last_cmd_status", 0444, &cmd_status_ops, NULL);
+	if (!kn)
+		return false;
+
+	return true;
+}
+
+void resctrl_addinfofiles(char *name, struct resctrl_fileinfo *files)
+{
+	struct resctrl_fileinfo *f;
+	struct kernfs_node *pkn, *kn;
+	umode_t mode;
+
+	pkn = resctrl_add_dir(kn_info, name, NULL);
+	if (!pkn)
+		return;
+
+	for (f = files; f->name; f++) {
+		mode = (f->ops->write) ? 0644 : 0444;
+		kn = resctrl_add_file(pkn, f->name, mode, f->ops, NULL);
+		if (!kn)
+			return;
+	}
+	kernfs_activate(pkn);
+}
+
+void resctrl_delinfofiles(char *name)
+{
+	struct kernfs_node *kn;
+
+	kn = kernfs_find_and_get_ns(kn_info, name, NULL);
+	if (kn)
+		kernfs_remove(kn);
+}
diff --git a/fs/resctrl2/kernfs.c b/fs/resctrl2/kernfs.c
new file mode 100644
index 000000000000..b22d75332339
--- /dev/null
+++ b/fs/resctrl2/kernfs.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include "internal.h"
+
+/* Set uid and gid of dirs and files to that of the creator */
+static int kn_set_ugid(struct kernfs_node *kn)
+{
+	struct iattr iattr = { .ia_valid = ATTR_UID | ATTR_GID,
+				.ia_uid = current_fsuid(),
+				.ia_gid = current_fsgid(), };
+
+	if (uid_eq(iattr.ia_uid, GLOBAL_ROOT_UID) &&
+	    gid_eq(iattr.ia_gid, GLOBAL_ROOT_GID))
+		return 0;
+
+	return kernfs_setattr(kn, &iattr);
+}
+
+struct kernfs_node *resctrl_add_file(struct kernfs_node *parent_kn, char *name, umode_t mode,
+				     const struct kernfs_ops *ops, void *priv)
+{
+	struct kernfs_node *kn;
+	int ret;
+
+	kn = __kernfs_create_file(parent_kn, name, mode,
+				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				  0, ops, priv, NULL, NULL);
+	if (IS_ERR(kn))
+		return NULL;
+
+	ret = kn_set_ugid(kn);
+	if (ret) {
+		kernfs_remove(kn);
+		return NULL;
+	}
+
+	return kn;
+}
+
+struct kernfs_node *resctrl_add_dir(struct kernfs_node *parent_kn, const char *name,
+				    void *priv)
+{
+	struct kernfs_node *kn;
+	int ret;
+
+	kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, priv);
+	if (IS_ERR(kn))
+		return NULL;
+
+	ret = kn_set_ugid(kn);
+	if (ret) {
+		kernfs_remove(kn);
+		return NULL;
+	}
+
+	return kn;
+}
diff --git a/fs/resctrl2/locking.c b/fs/resctrl2/locking.c
new file mode 100644
index 000000000000..ef948b243f13
--- /dev/null
+++ b/fs/resctrl2/locking.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include "internal.h"
+
+/* Mutex to protect resctrl group access. */
+DEFINE_MUTEX(resctrl_mutex);
+
+struct resctrl_group *kernfs_to_resctrl_group(struct kernfs_node *kn)
+{
+	if (kernfs_type(kn) == KERNFS_DIR)
+		return kn->priv;
+	else
+		return kn->parent->priv;
+}
+
+struct resctrl_group *resctrl_group_kn_lock_live(struct kernfs_node *kn)
+{
+	struct resctrl_group *rg = kernfs_to_resctrl_group(kn);
+
+	if (!rg)
+		return NULL;
+
+	atomic_inc(&rg->waitcount);
+	kernfs_break_active_protection(kn);
+
+	mutex_lock(&resctrl_mutex);
+
+	/* Was this group deleted while we waited? */
+	if (rg->flags & RESCTRL_DELETED)
+		return NULL;
+
+	return rg;
+}
+
+void resctrl_group_kn_unlock(struct kernfs_node *kn)
+{
+	struct resctrl_group *rg = kernfs_to_resctrl_group(kn);
+
+	if (!rg)
+		return;
+
+	mutex_unlock(&resctrl_mutex);
+
+	if (atomic_dec_and_test(&rg->waitcount) &&
+	    (rg->flags & RESCTRL_DELETED)) {
+		kernfs_unbreak_active_protection(kn);
+		resctrl_group_remove(rg);
+	} else {
+		kernfs_unbreak_active_protection(kn);
+	}
+}
diff --git a/fs/resctrl2/resources.c b/fs/resctrl2/resources.c
new file mode 100644
index 000000000000..ccac4a85dcfe
--- /dev/null
+++ b/fs/resctrl2/resources.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include "internal.h"
+
+LIST_HEAD(resctrl_all_resources);
+
+int resctrl_register_ctrl_resource(struct resctrl_resource *r)
+{
+	struct resctrl_resource *t;
+	struct resctrl_group *rg, *crg;
+	int cpu, ret = 0;
+
+	cpus_read_lock();
+	mutex_lock(&resctrl_mutex);
+
+	if (r->type == RESCTRL_CONTROL) {
+		for_each_resource(t) {
+			if (r->archtag == t->archtag) {
+				ret = -EEXIST;
+				goto out;
+			}
+		}
+		if (r->num_alloc_ids) {
+			if (!arch_init_alloc_ids(r)) {
+				ret = -ENOSPC;
+				goto out;
+			}
+		}
+	}
+
+	if (r->domain_size)
+		for_each_online_cpu(cpu)
+			resctrl_domain_add_cpu(cpu, r);
+	if (r->infodir)
+		resctrl_addinfofiles(r->infodir, r->infofiles);
+
+	if (r->type == RESCTRL_MONITOR) {
+		if (r->mon_domain_dir) {
+			list_for_each_entry(rg, &all_ctrl_groups, list) {
+				resctrl_create_domain_files(rg->mondata, r, rg);
+				list_for_each_entry(crg, &rg->child_list, list)
+					resctrl_create_domain_files(crg->mondata, r, crg);
+			}
+		}
+		if (r->mon_domain_file)
+			arch_add_monitor(r->mon_event);
+	}
+
+	list_add(&r->list, &resctrl_all_resources);
+out:
+	mutex_unlock(&resctrl_mutex);
+	cpus_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(resctrl_register_ctrl_resource);
+
+void resctrl_unregister_ctrl_resource(struct resctrl_resource *r)
+{
+	struct resctrl_group *rg, *crg;
+	int cpu;
+
+	cpus_read_lock();
+	mutex_lock(&resctrl_mutex);
+	if (r->type == RESCTRL_MONITOR && r->mon_domain_file)
+		arch_del_monitor(r->mon_event);
+
+	if (r->mon_domain_dir) {
+		list_for_each_entry(rg, &all_ctrl_groups, list) {
+			resctrl_remove_domain_files(rg->mondata, r, rg);
+			list_for_each_entry(crg, &rg->child_list, list)
+				resctrl_remove_domain_files(crg->mondata, r, crg);
+		}
+	}
+	if (r->infodir)
+		resctrl_delinfofiles(r->infodir);
+	if (r->domain_size)
+		for_each_online_cpu(cpu)
+			resctrl_domain_remove_cpu(cpu, r);
+	list_del(&r->list);
+	mutex_unlock(&resctrl_mutex);
+	cpus_read_unlock();
+}
+EXPORT_SYMBOL_GPL(resctrl_unregister_ctrl_resource);
diff --git a/fs/resctrl2/root.c b/fs/resctrl2/root.c
new file mode 100644
index 000000000000..2784f50c2dfa
--- /dev/null
+++ b/fs/resctrl2/root.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/fs_context.h>
+#include <linux/user_namespace.h>
+#include <linux/fs_parser.h>
+#include <linux/resctrl.h>
+
+#include "internal.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)       KBUILD_MODNAME ": " fmt
+
+#define RESCTRL_SUPER_MAGIC 0x4145474C
+
+static struct kernfs_root *resctrl_root;
+
+struct resctrl_fs_context {
+	struct kernfs_fs_context kfc;
+};
+
+LIST_HEAD(all_ctrl_groups);
+
+struct resctrl_group resctrl_default;
+
+static void resctrl_fs_context_free(struct fs_context *fc)
+{
+	struct kernfs_fs_context *kfc = fc->fs_private;
+	struct resctrl_fs_context *ctx = container_of(kfc, struct resctrl_fs_context, kfc);
+
+	kernfs_free_fs_context(fc);
+	kfree(ctx);
+}
+
+static const struct fs_parameter_spec resctrl_fs_parameters[] = {
+	{}
+};
+
+static int resctrl_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	return 0;
+}
+
+static int resctrl_get_tree(struct fs_context *fc)
+{
+	int ret;
+
+	cpus_read_lock();
+	mutex_lock(&resctrl_mutex);
+	ret = kernfs_get_tree(fc);
+	static_branch_enable_cpuslocked(&resctrl_enable_key);
+	mutex_unlock(&resctrl_mutex);
+	cpus_read_unlock();
+	return ret;
+}
+
+static const struct fs_context_operations resctrl_fs_context_ops = {
+	.free		= resctrl_fs_context_free,
+	.parse_param	= resctrl_parse_param,
+	.get_tree	= resctrl_get_tree,
+};
+
+static struct kernfs_syscall_ops resctrl_kf_syscall_ops = {
+	.mkdir	= resctrl_mkdir,
+	.rmdir	= resctrl_rmdir,
+};
+
+static int resctrl_init_fs_context(struct fs_context *fc)
+{
+	struct resctrl_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->kfc.root = resctrl_root;
+	ctx->kfc.magic = RESCTRL_SUPER_MAGIC;
+	fc->fs_private = &ctx->kfc;
+	fc->ops = &resctrl_fs_context_ops;
+	put_user_ns(fc->user_ns);
+	fc->user_ns = get_user_ns(&init_user_ns);
+	fc->global = true;
+
+	return 0;
+}
+
+static void resctrl_kill_sb(struct super_block *sb)
+{
+	cpus_read_lock();
+	mutex_lock(&resctrl_mutex);
+
+	resctrl_move_group_tasks(NULL, &resctrl_default, NULL);
+	resctrl_rmdir_all_sub();
+	static_branch_disable_cpuslocked(&resctrl_enable_key);
+	kernfs_kill_sb(sb);
+
+	mutex_unlock(&resctrl_mutex);
+	cpus_read_unlock();
+}
+
+static struct file_system_type resctrl_fs_type = {
+	.name			= "resctrl",
+	.init_fs_context	= resctrl_init_fs_context,
+	.parameters		= resctrl_fs_parameters,
+	.kill_sb		= resctrl_kill_sb,
+};
+
+static int __init resctrl_setup_root(void)
+{
+	resctrl_root = kernfs_create_root(&resctrl_kf_syscall_ops,
+					  KERNFS_ROOT_CREATE_DEACTIVATED |
+					  KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
+					  &resctrl_default);
+	if (IS_ERR(resctrl_root))
+		return PTR_ERR(resctrl_root);
+
+	resctrl_default.resctrl_ids = arch_resctrl_default_ids;
+	resctrl_default.kn = kernfs_root_to_node(resctrl_root);
+	resctrl_default.type = DIR_ROOT;
+	INIT_LIST_HEAD(&resctrl_default.child_list);
+
+	list_add(&resctrl_default.list, &all_ctrl_groups);
+
+	if (!resctrl_add_info_dir(resctrl_default.kn) ||
+	    !resctrl_populate_dir(resctrl_default.kn, &resctrl_default)) {
+		// TODO cleanup
+		return -EINVAL;
+	}
+
+	kernfs_activate(resctrl_default.kn);
+
+	return 0;
+}
+
+static int resctrl_init(void)
+{
+	int ret;
+
+	if (!arch_check_resctrl_support())
+		return -EINVAL;
+
+	if (resctrl_cpu_init() < 0)
+		return -ENOTTY;
+
+	ret = resctrl_setup_root();
+	if (ret)
+		goto cpu_exit;
+
+	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
+	if (ret)
+		goto cleanup_root;
+
+	ret = register_filesystem(&resctrl_fs_type);
+	if (ret)
+		goto cleanup_mountpoint;
+
+	return 0;
+
+cleanup_mountpoint:
+	sysfs_remove_mount_point(fs_kobj, "resctrl");
+cleanup_root:
+	kernfs_destroy_root(resctrl_root);
+cpu_exit:
+	resctrl_cpu_exit();
+
+	return ret;
+}
+
+fs_initcall(resctrl_init);
+
+MODULE_LICENSE("GPL");
diff --git a/fs/resctrl2/schemata.c b/fs/resctrl2/schemata.c
new file mode 100644
index 000000000000..8c4addf1428f
--- /dev/null
+++ b/fs/resctrl2/schemata.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include "internal.h"
+
+static ssize_t schemata_write(struct kernfs_open_file *of, char *buf,
+			      size_t nbytes, loff_t off)
+{
+	struct resctrl_resource *r;
+	struct resctrl_group *rg;
+	char *tok, *resname;
+	bool foundresource;
+	int ret = 0;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+	buf[nbytes - 1] = '\0';
+
+	cpus_read_lock();
+	rg = resctrl_group_kn_lock_live(of->kn);
+	if (!rg) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	resctrl_last_cmd_clear();
+
+	for_each_control_resource(r)
+		r->resetstaging(r, rg->resctrl_ids);
+
+	while ((tok = strsep(&buf, "\n")) != NULL) {
+		resname = strim(strsep(&tok, ":"));
+		if (!tok) {
+			resctrl_last_cmd_puts("Missing ':'\n");
+			ret = -EINVAL;
+			goto out;
+		}
+		if (tok[0] == '\0') {
+			resctrl_last_cmd_printf("Missing '%s' value\n", resname);
+			ret = -EINVAL;
+			goto out;
+		}
+		foundresource = false;
+		for_each_control_resource(r) {
+			if (!strcmp(resname, r->name)) {
+				ret = r->parse(r, tok, rg->resctrl_ids);
+				if (ret < 0)
+					goto out;
+				foundresource = true;
+				break;
+			}
+		}
+		if (!foundresource) {
+			resctrl_last_cmd_printf("Unknown resource '%s'\n", resname);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	for_each_control_resource(r)
+		r->applychanges(r, rg->resctrl_ids);
+out:
+	for_each_control_resource(r)
+		r->resetstaging(r, rg->resctrl_ids);
+
+	resctrl_group_kn_unlock(of->kn);
+	cpus_read_unlock();
+	return ret ?: nbytes;
+}
+
+static int schemata_seq_show(struct seq_file *m, void *arg)
+{
+	struct kernfs_open_file *of = m->private;
+	struct resctrl_resource *r;
+	struct resctrl_group *rg;
+	int ret = 0;
+
+	rg = resctrl_group_kn_lock_live(of->kn);
+	if (!rg) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	for_each_control_resource(r) {
+		seq_printf(m, "%s: ", r->name);
+		r->show(r, m, rg->resctrl_ids);
+	}
+
+out:
+	resctrl_group_kn_unlock(of->kn);
+	return ret;
+}
+
+static const struct kernfs_ops schemata_ops = {
+	.atomic_write_len	= PAGE_SIZE,
+	.write			= schemata_write,
+	.seq_show		= schemata_seq_show,
+};
+
+bool resctrl_add_schemata_file(struct kernfs_node *parent_kn)
+{
+	struct kernfs_node *schemata;
+
+	schemata = resctrl_add_file(parent_kn, "schemata", 0644, &schemata_ops, NULL);
+	if (IS_ERR(schemata))
+		return false;
+
+	return true;
+}
diff --git a/fs/resctrl2/tasks.c b/fs/resctrl2/tasks.c
new file mode 100644
index 000000000000..40dbb1167f99
--- /dev/null
+++ b/fs/resctrl2/tasks.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include "internal.h"
+
+/*
+ * Interrupt running tasks to make sure that update to
+ * new alloc/monitor ids.
+ */
+static void resctrl_kick_task(struct task_struct *t)
+{
+	// TODO
+}
+
+/*
+ * Move tasks from one to the other group. If @from is NULL, then all tasks
+ * in the systems are moved unconditionally (used for teardown).
+ *
+ * If @mask is not NULL the cpus on which moved tasks are running are set
+ * in that mask so the update smp function call is restricted to affected
+ * cpus.
+ */
+void resctrl_move_group_tasks(struct resctrl_group *from, struct resctrl_group *to,
+			      struct cpumask *mask)
+{
+	struct task_struct *p, *t;
+
+	read_lock(&tasklist_lock);
+	for_each_process_thread(p, t) {
+		if (!from || arch_is_resctrl_id_match(t, from)) {
+			/* Change ID in task structure first */
+			arch_set_task_ids(t, to);
+
+			/* Ensure above update is visible */
+			smp_mb();
+
+			/*
+			 * If the task is on a CPU, set the CPU in the mask.
+			 * The detection is inaccurate as tasks might move or
+			 * schedule before the smp function call takes place.
+			 * In such a case the function call is pointless, but
+			 * there is no other side effect.
+			 */
+			if (IS_ENABLED(CONFIG_SMP) && mask && task_curr(t))
+				cpumask_set_cpu(task_cpu(t), mask);
+		}
+	}
+	read_unlock(&tasklist_lock);
+}
+
+static int __resctrl_move_task(struct task_struct *tsk,
+			       struct resctrl_group *rg)
+{
+	/* If the task is already in group, no need to move the task. */
+	if (tsk->resctrl_ids == rg->resctrl_ids)
+		return 0;
+
+	/* Change ID in task structure first */
+	if (!arch_set_task_ids(tsk, rg))
+		return -EINVAL;
+
+	/* Ensure above update is visible before kicking task */
+	smp_mb();
+
+	/*
+	 * By now, the task's resctrl ids are set. If the task is current
+	 * on a CPU, need to kick the task to make the ids take effect.
+	 * If the task is not current, the update will happen when the
+	 * task is scheduled in.
+	 */
+	resctrl_kick_task(tsk);
+
+	return 0;
+}
+
+static int resctrl_task_write_permission(struct task_struct *task,
+					 struct kernfs_open_file *of)
+{
+	const struct cred *tcred = get_task_cred(task);
+	const struct cred *cred = current_cred();
+	int ret = 0;
+
+	/*
+	 * Even if we're attaching all tasks in the thread group, we only
+	 * need to check permissions on one of them.
+	 */
+	if (!uid_eq(cred->euid, GLOBAL_ROOT_UID) &&
+	    !uid_eq(cred->euid, tcred->uid) &&
+	    !uid_eq(cred->euid, tcred->suid)) {
+		resctrl_last_cmd_printf("No permission to move task %d\n", task->pid);
+		ret = -EPERM;
+	}
+
+	put_cred(tcred);
+	return ret;
+}
+
+static void show_resctrl_tasks(struct resctrl_group *rg, struct seq_file *s)
+{
+	struct task_struct *p, *t;
+
+	rcu_read_lock();
+	for_each_process_thread(p, t)
+		if (arch_is_resctrl_id_match(t, rg))
+			seq_printf(s, "%d\n", t->pid);
+	rcu_read_unlock();
+}
+
+static int resctrl_move_task(pid_t pid, struct resctrl_group *rg, struct kernfs_open_file *of)
+{
+	struct task_struct *tsk;
+	int ret;
+
+	rcu_read_lock();
+	if (pid) {
+		tsk = find_task_by_vpid(pid);
+		if (!tsk) {
+			rcu_read_unlock();
+			resctrl_last_cmd_printf("No task %d\n", pid);
+			return -ESRCH;
+		}
+	} else {
+		tsk = current;
+	}
+
+	get_task_struct(tsk);
+	rcu_read_unlock();
+
+	ret = resctrl_task_write_permission(tsk, of);
+	if (!ret)
+		ret = __resctrl_move_task(tsk, rg);
+
+	put_task_struct(tsk);
+	return ret;
+}
+
+static ssize_t tasks_write(struct kernfs_open_file *of, char *buf,
+			   size_t nbytes, loff_t off)
+{
+	struct resctrl_group *rg;
+	int ret = 0;
+	pid_t pid;
+
+	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
+		return -EINVAL;
+	rg = resctrl_group_kn_lock_live(of->kn);
+	if (!rg) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	resctrl_last_cmd_clear();
+
+	ret = resctrl_move_task(pid, rg, of);
+
+unlock:
+	resctrl_group_kn_unlock(of->kn);
+
+	return ret ?: nbytes;
+}
+
+static int tasks_seq_show(struct seq_file *m, void *arg)
+{
+	struct kernfs_open_file *of = m->private;
+	struct resctrl_group *rg;
+	int ret = 0;
+
+	rg = resctrl_group_kn_lock_live(of->kn);
+	if (rg)
+		show_resctrl_tasks(rg, m);
+	else
+		ret = -ENOENT;
+	resctrl_group_kn_unlock(of->kn);
+
+	return ret;
+}
+
+static const struct kernfs_ops task_ops = {
+	.atomic_write_len	= PAGE_SIZE,
+	.write			= tasks_write,
+	.seq_show		= tasks_seq_show,
+};
+
+bool resctrl_add_task_file(struct kernfs_node *parent_kn)
+{
+	struct kernfs_node *tasks;
+
+	tasks = resctrl_add_file(parent_kn, "tasks", 0644, &task_ops, NULL);
+	if (IS_ERR(tasks))
+		return false;
+
+	return true;
+}
diff --git a/fs/Kconfig b/fs/Kconfig
index 18d034ec7953..f4ebf8f5204b 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -45,6 +45,7 @@ source "fs/btrfs/Kconfig"
 source "fs/nilfs2/Kconfig"
 source "fs/f2fs/Kconfig"
 source "fs/zonefs/Kconfig"
+source "fs/resctrl2/Kconfig"
 
 endif # BLOCK
 
diff --git a/fs/Makefile b/fs/Makefile
index 5bfdbf0d7037..0aab615ceb4d 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -135,3 +135,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-$(CONFIG_RESCTRL2_FS)	+= resctrl2/
diff --git a/fs/resctrl2/Kconfig b/fs/resctrl2/Kconfig
new file mode 100644
index 000000000000..6ee9162b96c1
--- /dev/null
+++ b/fs/resctrl2/Kconfig
@@ -0,0 +1,5 @@
+#
+# Architectures that support resource control will select this
+#
+config RESCTRL2_FS
+	bool
diff --git a/fs/resctrl2/Makefile b/fs/resctrl2/Makefile
new file mode 100644
index 000000000000..debf91ebcb6a
--- /dev/null
+++ b/fs/resctrl2/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_RESCTRL2_FS) += cpu.o
+obj-$(CONFIG_RESCTRL2_FS) += directory.o
+obj-$(CONFIG_RESCTRL2_FS) += domain.o
+obj-$(CONFIG_RESCTRL2_FS) += info.o
+obj-$(CONFIG_RESCTRL2_FS) += kernfs.o
+obj-$(CONFIG_RESCTRL2_FS) += locking.o
+obj-$(CONFIG_RESCTRL2_FS) += resources.o
+obj-$(CONFIG_RESCTRL2_FS) += root.o
+obj-$(CONFIG_RESCTRL2_FS) += schemata.o
+obj-$(CONFIG_RESCTRL2_FS) += tasks.o
+
+obj-$(CONFIG_X86_CPU_RESCTRL2) += arch/x86/
-- 
2.40.1

