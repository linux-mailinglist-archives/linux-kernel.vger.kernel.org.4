Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CA0725C14
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbjFGKw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239007AbjFGKwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:52:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFB11BF9;
        Wed,  7 Jun 2023 03:52:13 -0700 (PDT)
Date:   Wed, 07 Jun 2023 10:52:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686135128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8VQRJNZ1ntC+pOot5N13hzW09+40RSkDjn4L8bCqVfE=;
        b=CZQaH5/Hoe7dZ9W7uz++fEm2ou/aQ8K15mjrufZKYAzXIe/bP2z4FZHRz+zemJkE/f/kc0
        KE9Z74cTjYYpXZQ5kXTC8+l1djFgKZdv0I4L6Z8bggbvfXuhWvsYrGV1MYGN2bsNCLfcmH
        y+rw5ZKcn58qnNBKukTsR7jO5B2Fi1Z74kiQA4UxwsZEM+DRTK2rZKf18CMFyrNzq9zhf+
        lpLvCB1PFlTqf8N5HqqVh3opYHL4ygJzNh8R2wjxOhetLWlaEq9v23Aq0RdbvM+FHR//aM
        YgKkVdjeZrg2hZtYZJcIJE+lVUseOFNWMZmq87Ca9/GNBhQMEDzZ7YfH0SQ77A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686135128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8VQRJNZ1ntC+pOot5N13hzW09+40RSkDjn4L8bCqVfE=;
        b=cA63HbIQ/Wm3ZmMTrna1fUJkxUGwiNiNJjovz0y/ASypziJUFRizKcDaYIQwmJrMixh/Cp
        7X+FjcwULJv4XEBQ==
From:   "tip-bot2 for Peter Newman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Implement rename op for mon groups
Cc:     Peter Newman <peternewman@google.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230419125015.693566-3-peternewman@google.com>
References: <20230419125015.693566-3-peternewman@google.com>
MIME-Version: 1.0
Message-ID: <168613512772.404.1065051587944677591.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     8da2b938eb7e2ef407b8ef99def12e3054a99645
Gitweb:        https://git.kernel.org/tip/8da2b938eb7e2ef407b8ef99def12e3054a99645
Author:        Peter Newman <peternewman@google.com>
AuthorDate:    Wed, 19 Apr 2023 14:50:14 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 07 Jun 2023 12:40:36 +02:00

x86/resctrl: Implement rename op for mon groups

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
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20230419125015.693566-3-peternewman@google.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 128 ++++++++++++++++++++++++-
 1 file changed, 128 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 653d258..7253440 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3518,6 +3518,133 @@ out:
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
@@ -3535,6 +3662,7 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
 	.mkdir		= rdtgroup_mkdir,
 	.rmdir		= rdtgroup_rmdir,
+	.rename		= rdtgroup_rename,
 	.show_options	= rdtgroup_show_options,
 };
 
