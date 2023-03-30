Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A5A6D0769
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjC3N4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjC3N4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:56:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F51A25D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:56:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3-20020a251103000000b00b732e362449so18678539ybr.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680184576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zUSjvVavoBhnwCV+A2EoFMdaaeZRtxo2g0qg4wUbJ74=;
        b=nFdvgINnXhDVlxrpogSpIYRXtjdRAXbnf98m/kRuK0EodxG5mqWMFnMpFcSH25JVGl
         Z26KpRi3NFGwWmA9HQDbA1ACoWItP92uCourv1Ebd7O6dnEL/y+kfdvI0W4rut6hpLEM
         vEPkUHtWrMb8nvj/yLpco1djR0W50o/oG8TGgORPshYudSPJT16BkvwHov5Qn0Xgeygj
         Qq8kAFtLYMHx/uK+Y0Md97BmZGw8keSkM59ndMeMJRIDTE624FRo+xvc2NlSusnp11OJ
         og214TR3Ix4mQocZSps+n19URYkCaiIeO5+MlpRGvsY7L8jiPnA0t5SXV0JFnHNo9L1S
         70pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680184576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUSjvVavoBhnwCV+A2EoFMdaaeZRtxo2g0qg4wUbJ74=;
        b=noEyJGo9bwj31tDqMLIZvHDS2yGa0hh9uRr7vvQpbZls9mw1Zqmb+foLEXOYqqaZ6A
         Pc70Ys4iw9JDZqbV1khRy768CE39Bl8NPQbzmGxUaAaPJHJJHEPZyLEEyKW95tL4wbK1
         LE39S7GW0jCEqTOgPL0i2Hc6t7WGn1qPKwUwW1ITl4bxtesfPHye85p5wcikyAKs/2ms
         hFW/bL8wHTm2MYo6GtnZPIQXwebyNkK4YcX0cDaHPJfRfTwYQ0QELvYkTgOKEvKLX77B
         CmXni6TFwskcnrwE65V70Bce+3gji38Ye1FNpBgE6fSs2+q4Zzf2UBtfqC/i7swr0V2O
         PiJQ==
X-Gm-Message-State: AAQBX9eT6QV8SR6s4GlZBfw9kSNt4OkK7ItJXh4BLbtMVSLRFzrvAeTT
        55NJJ6uS2c8Zw03dkAQ2msqhva5dCqLJVoiwYg==
X-Google-Smtp-Source: AKy350YQdbfyUH2mC0K7sidQEdaNrXG8HVZfulOEZPxxvrnYrj/VLDun/M/IjSpLxwds/actPAEoWcV0DGhDvUpnLA==
X-Received: from peternewman-vh.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:30cc])
 (user=peternewman job=sendgmr) by 2002:a81:9993:0:b0:544:bbd2:74be with SMTP
 id q141-20020a819993000000b00544bbd274bemr3549820ywg.4.1680184576236; Thu, 30
 Mar 2023 06:56:16 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:55:57 +0200
In-Reply-To: <20230330135558.1019658-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230330135558.1019658-1-peternewman@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230330135558.1019658-3-peternewman@google.com>
Subject: [PATCH v5 2/3] x86/resctrl: Implement rename op for mon groups
From:   Peter Newman <peternewman@google.com>
To:     reinette.chatre@intel.com, fenghua.yu@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, skodak@google.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org,
        Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To change the resources allocated to a large group of tasks, such as an
application container, a container manager must write all of the tasks'
IDs into the tasks file interface of the new control group.

If a container manager is additionally tracking containers' bandwidth
usage by placing tasks from each into their own monitoring group, it
must first move the tasks to the default monitoring group of the new
control group before it can move the tasks into their new monitoring
groups. This is undesirable because it makes bandwidth usage during the
move unattributable to the correct tasks and resets monitoring event
counters and cache usage information for the group.

Implement the rename operation only for resctrlfs monitor groups to
enable users to move a monitoring group from one control group to
another. This effects a change in resources allocated to all the tasks
in the monitoring group while otherwise leaving the monitoring data
intact.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 128 +++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 51b869149e76..86de22d8e23a 100644
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
+		rdt_last_cmd_puts("Source and destination must be group directories");
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
+	    (rdtgrp->mon.parent != new_prdtgrp)) {
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
2.40.0.348.gf938b09366-goog

