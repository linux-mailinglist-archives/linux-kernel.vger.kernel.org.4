Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311816E79FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjDSMu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjDSMux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:50:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1657695
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:50:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l124-20020a252582000000b00b8f5572bcdaso15868733ybl.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681908643; x=1684500643;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2VyinE+DDb/Q7Dr6L/ZifSAtwYa3P2xEDwWdnlneadk=;
        b=svjbIScMa28a4IqxeHSqZo7K9kjy2RdzU5ujfVKTAYQVvPZ9WYuAEpj3wnPqI9Srys
         YkqpOPCSqFQqVkLJ9eb8xlsqXM3qc5Y3GY8rGcXXHjyO+VxGuahJadcWV0aAnz9N1XtA
         6PuDQdV6eyq1DjZqy62QFRJ1pu+RAQqjQF73JkhPovFBaVddJ3wf9r5hVxvICinyyUnV
         9fpEHLxOWGIWVueEQRRKTp6F/M2zYS96qDGPYYezWJv0X8fwiZcWnhyyBkjCTYXogWPM
         SbXnWPh7SNOpOEN8qXdsDUIkMlXCOzSuFO2IYKtgtIndj19fiZrVvfDRog2H/uBBzOkw
         WejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681908643; x=1684500643;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2VyinE+DDb/Q7Dr6L/ZifSAtwYa3P2xEDwWdnlneadk=;
        b=C1PGVzwwgpav7/+df+D8A/VnOOEkqr9GaC0/gQqskEkhBNXDjuwa8e+J8779PPqk4S
         BuY7j/tWcNSbpfjX3Ab7UN5SgIsmOmcxYTnQiC3BIZlEbDrBFGLPxRewC+XT3AXqhclb
         XzBAZ/AV1w1n1U32p/ojwRDIyxEcApns2fWHn4w+vny9L8f0UbcQtGCx7MPyg3nsN0yu
         v5+Pm1ufRyRNmh91ElmUoe5m8nas7Ih3IVPG8gtlk4KLWi8nh3gzyubDvPsOaTb3DH1T
         KUWSzem4CTCNEop2jbykt7KMppSc8J032E0saXkkNij3CCyrc+rDPikCEQESpA63tdXO
         b2NA==
X-Gm-Message-State: AAQBX9fTiQrkKIzR4DQGhnEq7vFoSPQvM6efmVqQp1CJjHqwX+qhvngR
        RbPHA5GbkKCPJnKNqVUiiKIys6bwFJwde01UqA==
X-Google-Smtp-Source: AKy350ah+3rcWggCw0Iac5AVviXz9FaXW80vFYRnXbjCS4N8chgJDgp6D08LYnwHnek2bboP9DUm5T4VgBShDZbFBg==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:b36e:a25e:826d:b66a])
 (user=peternewman job=sendgmr) by 2002:a25:d1cc:0:b0:b95:65ad:4399 with SMTP
 id i195-20020a25d1cc000000b00b9565ad4399mr2913072ybg.8.1681908643819; Wed, 19
 Apr 2023 05:50:43 -0700 (PDT)
Date:   Wed, 19 Apr 2023 14:50:14 +0200
In-Reply-To: <20230419125015.693566-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230419125015.693566-1-peternewman@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230419125015.693566-3-peternewman@google.com>
Subject: [PATCH v6 2/3] x86/resctrl: Implement rename op for mon groups
From:   Peter Newman <peternewman@google.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, skodak@google.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org,
        Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To change the resources allocated to a large group of tasks, such as an
application container, a container manager must write all of the tasks'
IDs into the tasks file interface of the new control group. This is
challenging when the container's task list is always changing.

In addition, if the container manager is using monitoring groups to
separately track the bandwidth of containers assigned to the same
control group, when moving a container, it must first move the
container's tasks to the default monitoring group of the new control
group before it can move these tasks into the container's replacement
monitoring group under the destination control group. This is
undesirable because it makes bandwidth usage during the move
unattributable to the correct tasks and resets monitoring event counters
and cache usage information for the group.

Implement the rename operation only for resctrlfs monitor groups to
enable users to move a monitoring group from one control group to
another. This effects a change in resources allocated to all the tasks
in the monitoring group while otherwise leaving the monitoring data
intact.

Signed-off-by: Peter Newman <peternewman@google.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 128 +++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 51b869149e76..6a301233b9ef 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3514,6 +3514,133 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 	return ret;
 }
 
+/**
+ * mongrp_reparent() - replace parent CTRL_MON group of a MON group
+ * @rdtgrp:		the MON group whose parent should be replaced
+ * @new_prdtgrp:	replacement parent CTRL_MON group for @rdtgrp
+ * @cpus:		cpumask provided by the caller for use during this call
+ *
+ * Replaces the parent CTRL_MON group for a MON group, resulting in all member
+ * tasks' CLOSID immediately changing to that of the new parent group.
+ * Monitoring data for the group is unaffected by this operation.
+ */
+static void mongrp_reparent(struct rdtgroup *rdtgrp,
+			    struct rdtgroup *new_prdtgrp,
+			    cpumask_var_t cpus)
+{
+	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
+
+	WARN_ON(rdtgrp->type != RDTMON_GROUP);
+	WARN_ON(new_prdtgrp->type != RDTCTRL_GROUP);
+
+	/* Nothing to do when simply renaming a MON group. */
+	if (prdtgrp == new_prdtgrp)
+		return;
+
+	WARN_ON(list_empty(&prdtgrp->mon.crdtgrp_list));
+	list_move_tail(&rdtgrp->mon.crdtgrp_list,
+		       &new_prdtgrp->mon.crdtgrp_list);
+
+	rdtgrp->mon.parent = new_prdtgrp;
+	rdtgrp->closid = new_prdtgrp->closid;
+
+	/* Propagate updated closid to all tasks in this group. */
+	rdt_move_group_tasks(rdtgrp, rdtgrp, cpus);
+
+	update_closid_rmid(cpus, NULL);
+}
+
+static int rdtgroup_rename(struct kernfs_node *kn,
+			   struct kernfs_node *new_parent, const char *new_name)
+{
+	struct rdtgroup *new_prdtgrp;
+	struct rdtgroup *rdtgrp;
+	cpumask_var_t tmpmask;
+	int ret;
+
+	rdtgrp = kernfs_to_rdtgroup(kn);
+	new_prdtgrp = kernfs_to_rdtgroup(new_parent);
+	if (!rdtgrp || !new_prdtgrp)
+		return -ENOENT;
+
+	/* Release both kernfs active_refs before obtaining rdtgroup mutex. */
+	rdtgroup_kn_get(rdtgrp, kn);
+	rdtgroup_kn_get(new_prdtgrp, new_parent);
+
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	/*
+	 * Don't allow kernfs_to_rdtgroup() to return a parent rdtgroup if
+	 * either kernfs_node is a file.
+	 */
+	if (kernfs_type(kn) != KERNFS_DIR ||
+	    kernfs_type(new_parent) != KERNFS_DIR) {
+		rdt_last_cmd_puts("Source and destination must be directories");
+		ret = -EPERM;
+		goto out;
+	}
+
+	if ((rdtgrp->flags & RDT_DELETED) || (new_prdtgrp->flags & RDT_DELETED)) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	if (rdtgrp->type != RDTMON_GROUP || !kn->parent ||
+	    !is_mon_groups(kn->parent, kn->name)) {
+		rdt_last_cmd_puts("Source must be a MON group\n");
+		ret = -EPERM;
+		goto out;
+	}
+
+	if (!is_mon_groups(new_parent, new_name)) {
+		rdt_last_cmd_puts("Destination must be a mon_groups subdirectory\n");
+		ret = -EPERM;
+		goto out;
+	}
+
+	/*
+	 * If the MON group is monitoring CPUs, the CPUs must be assigned to the
+	 * current parent CTRL_MON group and therefore cannot be assigned to
+	 * the new parent, making the move illegal.
+	 */
+	if (!cpumask_empty(&rdtgrp->cpu_mask) &&
+	    rdtgrp->mon.parent != new_prdtgrp) {
+		rdt_last_cmd_puts("Cannot move a MON group that monitors CPUs\n");
+		ret = -EPERM;
+		goto out;
+	}
+
+	/*
+	 * Allocate the cpumask for use in mongrp_reparent() to avoid the
+	 * possibility of failing to allocate it after kernfs_rename() has
+	 * succeeded.
+	 */
+	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * Perform all input validation and allocations needed to ensure
+	 * mongrp_reparent() will succeed before calling kernfs_rename(),
+	 * otherwise it would be necessary to revert this call if
+	 * mongrp_reparent() failed.
+	 */
+	ret = kernfs_rename(kn, new_parent, new_name);
+	if (!ret)
+		mongrp_reparent(rdtgrp, new_prdtgrp, tmpmask);
+
+	free_cpumask_var(tmpmask);
+
+out:
+	mutex_unlock(&rdtgroup_mutex);
+	rdtgroup_kn_put(rdtgrp, kn);
+	rdtgroup_kn_put(new_prdtgrp, new_parent);
+	return ret;
+}
+
 static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 {
 	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
@@ -3531,6 +3658,7 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
 	.mkdir		= rdtgroup_mkdir,
 	.rmdir		= rdtgroup_rmdir,
+	.rename		= rdtgroup_rename,
 	.show_options	= rdtgroup_show_options,
 };
 
-- 
2.40.0.634.g4ca3ef3211-goog

