Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C241C67AF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbjAYKOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbjAYKOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:14:02 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0306A13502
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:13:54 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4cddba76f55so185675157b3.23
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tFANQsplcfYmN7Cu3ZOpiMje75MfpJ9o5dr0Y/I/sbo=;
        b=O8VIBCPkSHVXBUTdp+6dObEdarVkoyg8VZeXFQryzghwGEbgSgaG51+9JdcnG5iYBg
         MUfKU4+EXidCxnEa0lc1wn6DDGQzCx9pwBFR6nufNT3tbXnavgu8XFN3j5y+R0clCaQJ
         RkmcsXkJVg7j5ytpKWgXYWxvyjwHcRIdfMFDUHZC8xMV7Z5baskFowkjOHxfzh4PzrhQ
         OTNhAtUBiE78GJUyrieidEbeN/NLfKPNOsAhO9It64x87uTm+NgA9D3gAA2NGWyOObGq
         pR9/yyvDIcWntbPuWjso3LfIXtTTtNxCJZTCOcbsbkj0w8HBwKbz1XUxtOovk3Lj4R7D
         B2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFANQsplcfYmN7Cu3ZOpiMje75MfpJ9o5dr0Y/I/sbo=;
        b=JUamtVDqNByxvm4NNgTBAR/g4gvEBpqCZBA+KurhthlGVFYzXZU/ZM2A7bpu1damo0
         YcH82Z8/uCPkCH5UzvfEQ9n2rfrAgGWVCTBvhNpsK+U3WSmACQqNSoyTT0QJxn/56C00
         1FEG9RKOj/wYqIBifEeLNdloSWGQxKHH6hF1S7Sw61MimnZfJwCdpGfhn6X/W+AUcYzc
         qNabXjuXABywUd8OwVz5hMy4pknBb+mV3Pv0sfcuqPDbvE/RoYy5QDsWsZcYF7puwTGX
         gETYKN1Le6gzNx8NY/0377VqaZ1zvZ81Etud2xCEmCFuhxSA9BL2wp5LuuDTEVgKPaWF
         pk8g==
X-Gm-Message-State: AFqh2krfCynZyXWl9Uee3W6Ednm/p3LEpx+7fPoqi17B2N6VbdupHFCx
        okaA4lgZMem5I/ITeCbzMbm510bcRQylKAjY+g==
X-Google-Smtp-Source: AMrXdXvbMiMlKu7l9hIH1fZHjaDDMz4AvhGXnONYnRYQ53bXwlAEBNtSV8VQ6r4o1fwkupH9GV0y0WZZHn3EPED07A==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:e533:80e6:38fe:22c])
 (user=peternewman job=sendgmr) by 2002:a25:7dc7:0:b0:766:2e0a:55ff with SMTP
 id y190-20020a257dc7000000b007662e0a55ffmr3693462ybc.325.1674641633188; Wed,
 25 Jan 2023 02:13:53 -0800 (PST)
Date:   Wed, 25 Jan 2023 11:13:34 +0100
In-Reply-To: <20230125101334.1069060-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230125101334.1069060-1-peternewman@google.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230125101334.1069060-4-peternewman@google.com>
Subject: [PATCH v3 3/3] x86/resctrl: Implement rename op for mon groups
From:   Peter Newman <peternewman@google.com>
To:     reinette.chatre@intel.com, fenghua.yu@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, skodak@google.com, tony.luck@intel.com,
        tglx@linutronix.de, x86@kernel.org,
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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 75 ++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b2081bc1bbfd..595f83a517c6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3238,6 +3238,80 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 	return ret;
 }
 
+static void mongrp_move(struct rdtgroup *rdtgrp, struct rdtgroup *new_prdtgrp,
+			cpumask_var_t cpus)
+{
+	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
+	struct task_struct *p, *t;
+
+	WARN_ON(list_empty(&prdtgrp->mon.crdtgrp_list));
+	list_del(&rdtgrp->mon.crdtgrp_list);
+
+	list_add_tail(&rdtgrp->mon.crdtgrp_list,
+		      &new_prdtgrp->mon.crdtgrp_list);
+	rdtgrp->mon.parent = new_prdtgrp;
+
+	read_lock(&tasklist_lock);
+	for_each_process_thread(p, t) {
+		if (is_closid_match(t, prdtgrp) && is_rmid_match(t, rdtgrp))
+			rdt_move_one_task(t, new_prdtgrp->closid, t->rmid,
+					  cpus);
+	}
+	read_unlock(&tasklist_lock);
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
+	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
+		return -ENOMEM;
+
+	rdtgrp = kernfs_to_rdtgroup(kn);
+	new_prdtgrp = kernfs_to_rdtgroup(new_parent);
+	if (!rdtgrp || !new_prdtgrp) {
+		free_cpumask_var(tmpmask);
+		return -EPERM;
+	}
+
+	/* Release both kernfs active_refs before obtaining rdtgroup mutex. */
+	rdtgroup_kn_get(rdtgrp, kn);
+	rdtgroup_kn_get(new_prdtgrp, new_parent);
+
+	mutex_lock(&rdtgroup_mutex);
+
+	if ((rdtgrp->flags & RDT_DELETED) || (new_prdtgrp->flags & RDT_DELETED)) {
+		ret = -ESRCH;
+		goto out;
+	}
+
+	/* Only a mon group can be moved to a new mon_groups directory. */
+	if (rdtgrp->type != RDTMON_GROUP ||
+	    !is_mon_groups(new_parent, kn->name)) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	ret = kernfs_rename(kn, new_parent, new_name);
+	if (ret)
+		goto out;
+
+	mongrp_move(rdtgrp, new_prdtgrp, tmpmask);
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
@@ -3255,6 +3329,7 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
 	.mkdir		= rdtgroup_mkdir,
 	.rmdir		= rdtgroup_rmdir,
+	.rename		= rdtgroup_rename,
 	.show_options	= rdtgroup_show_options,
 };
 
-- 
2.39.1.405.gd4c25cc71f-goog

