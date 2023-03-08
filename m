Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0116B0855
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjCHNTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjCHNSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:18:32 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE52CB644
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:15:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x64-20020a25ce43000000b00ae6d5855d78so17677021ybe.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 05:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678281310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V2OWyyThXDzCsX5dfUI5J1YeLCRnmlzAhR0ONAX2q6c=;
        b=eTJmEafz02AisZ86AJ7inkOANlOT7YZR4TTp+I8VfysjvCRHGV5+hEnzifTlMdyGnd
         1OkVVwur8jZvZfVKIvD9VHxyoxfNZEWw1qiuj//mPyrwtI323ZqXudRxscC6NcGUtt9b
         GDzRFPzvXF0f2MuhwNCeMubC3iMwCqqYks0OA45nqs6alr9+UIhzN7PqRl0AuWDC1kxp
         ycCyhtGuklso+a7joCnePh3oGkgMoZo6lWkkVwoITX1ged6hCbxieBiPNl5k6yU0jsIk
         rlMQrW3UihIYZXRc4Z8pIymKbVqitmmzsBaf730S9iTB6LkkSdR2FLCe2X0Blqklm6FH
         oy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678281310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2OWyyThXDzCsX5dfUI5J1YeLCRnmlzAhR0ONAX2q6c=;
        b=7Kn2Qwpg9p6KvdDXS482GVbWPHPRDZ+iS8Q/hiK0PWPO4xX0WheQ68z5RoQIQ1cH32
         Wr4nnDCYKzmqA4ThW05BEHg7TThiXFdm9ObvMrCZVYA6gQDRgtTlyVpAt3mRTp4Vf7sA
         1Lxnxa4w+ikqNNEr7vCscJZLKSaF2hnSYVBhbIfe47vdnUgzpbL6b/6/Qym6sPjWqmtq
         ygZKIMVhGN4OYxdzqMcPwNrAh/thKUwWh5AqR90ISFdtKkFWAjgl7a6chO+ERceDP4th
         Km1FgKdnd4JoM4bDR22OaCUKwouvUjOqUwYWanJj77JbCteby8N7w8jTxgoXl+S3lqIS
         waZw==
X-Gm-Message-State: AO0yUKWNwUJ5gnHrPdxuOfkp8WJwNOa4UMuEVelM9+O3m+8RroRFhPud
        SMIXYbdgJoRobkKF4QkKRh9SOsmyXRKKM4AqLQ==
X-Google-Smtp-Source: AK7set/6qmn9wIbDfx0ImcoohQuAICMOE1jvQ6ifhqNtvO8ZFpPuQHE61BR9WQSwW4AxqU73e9kHkhqWwhOIWjTIeQ==
X-Received: from peternewman-vh.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:30cc])
 (user=peternewman job=sendgmr) by 2002:a05:6902:10e:b0:98e:6280:74ca with
 SMTP id o14-20020a056902010e00b0098e628074camr8955336ybh.1.1678281310581;
 Wed, 08 Mar 2023 05:15:10 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:14:52 +0100
In-Reply-To: <20230308131452.383914-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230308131452.383914-1-peternewman@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230308131452.383914-4-peternewman@google.com>
Subject: [PATCH v4 3/3] x86/resctrl: Implement rename op for mon groups
From:   Peter Newman <peternewman@google.com>
To:     reinette.chatre@intel.com, fenghua.yu@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, skodak@google.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org,
        Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To change the class of service for a large group of tasks, such as an
application container, a container manager must write all of the tasks'
IDs into the tasks file interface of the new control group.

If a container manager is tracking containers' bandwidth usage by
placing tasks from each into their own monitoring group, it must first
move the tasks to the default monitoring group of the new control group
before it can move the tasks into their new monitoring groups. This is
undesirable because it makes bandwidth usage during the move
unattributable to the correct tasks and resets monitoring event counters
and cache usage information for the group.

To address this, implement the rename operation for resctrlfs mon groups
to effect a change in CLOSID for a MON group while otherwise leaving the
monitoring group intact.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 127 +++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 84af23a29612..6d576013fc16 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3256,6 +3256,132 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 	return ret;
 }
 
+static bool mongrp_reparent_match(struct task_struct *t, struct rdtgroup *from)
+{
+	WARN_ON(from->type != RDTMON_GROUP);
+
+	/* RMID match implies CLOSID match. */
+	return is_rmid_match(t, from);
+}
+
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
+	list_del(&rdtgrp->mon.crdtgrp_list);
+
+	list_add_tail(&rdtgrp->mon.crdtgrp_list,
+		      &new_prdtgrp->mon.crdtgrp_list);
+	rdtgrp->mon.parent = new_prdtgrp;
+	rdtgrp->closid = new_prdtgrp->closid;
+
+	/* Propagate updated closid to all tasks in this group. */
+	rdt_move_group_tasks(rdtgrp, rdtgrp, cpus, mongrp_reparent_match);
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
+	/*
+	 * Don't allow kernfs_to_rdtgroup() to return a parent rdtgroup if
+	 * either kernfs_node is a file.
+	 */
+	if (kernfs_type(kn) != KERNFS_DIR ||
+	    kernfs_type(new_parent) != KERNFS_DIR)
+		return -EPERM;
+
+	rdtgrp = kernfs_to_rdtgroup(kn);
+	new_prdtgrp = kernfs_to_rdtgroup(new_parent);
+	if (!rdtgrp || !new_prdtgrp)
+		return -EPERM;
+
+	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
+		return -ENOMEM;
+
+	/* Release both kernfs active_refs before obtaining rdtgroup mutex. */
+	rdtgroup_kn_get(rdtgrp, kn);
+	rdtgroup_kn_get(new_prdtgrp, new_parent);
+
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	if ((rdtgrp->flags & RDT_DELETED) || (new_prdtgrp->flags & RDT_DELETED)) {
+		ret = -ESRCH;
+		goto out;
+	}
+
+	if (rdtgrp->type != RDTMON_GROUP || !kn->parent ||
+	    !is_mon_groups(kn->parent, kn->name)) {
+		rdt_last_cmd_puts("source must be a MON group\n");
+		ret = -EPERM;
+		goto out;
+	}
+
+	if (!is_mon_groups(new_parent, new_name)) {
+		rdt_last_cmd_puts("destination must be a mon_groups subdirectory\n");
+		ret = -EPERM;
+		goto out;
+	}
+
+	/*
+	 * If the MON group is monitoring CPUs, they must be assigned to the
+	 * current parent CTRL_MON group and therefore cannot be assigned to
+	 * the new parent, making the move illegal.
+	 */
+	if (!cpumask_empty(&rdtgrp->cpu_mask) &&
+	    (rdtgrp->mon.parent != new_prdtgrp)) {
+		rdt_last_cmd_puts("cannot move a MON group that monitors CPUs\n");
+		ret = -EPERM;
+		goto out;
+	}
+
+	/*
+	 * Perform all input validation needed to ensure mongrp_reparent() will
+	 * succeed before calling kernfs_rename(), otherwise it would be
+	 * necessary to revert this call if mongrp_reparent() failed.
+	 */
+	ret = kernfs_rename(kn, new_parent, new_name);
+	if (ret)
+		goto out;
+
+	mongrp_reparent(rdtgrp, new_prdtgrp, tmpmask);
+
+out:
+	mutex_unlock(&rdtgroup_mutex);
+	rdtgroup_kn_put(rdtgrp, kn);
+	rdtgroup_kn_put(new_prdtgrp, new_parent);
+	free_cpumask_var(tmpmask);
+	return ret;
+}
+
 static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 {
 	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
@@ -3273,6 +3399,7 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
 	.mkdir		= rdtgroup_mkdir,
 	.rmdir		= rdtgroup_rmdir,
+	.rename		= rdtgroup_rename,
 	.show_options	= rdtgroup_show_options,
 };
 
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

