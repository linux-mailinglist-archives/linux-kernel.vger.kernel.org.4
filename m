Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADBB63BFA8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbiK2MDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiK2MCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:02:35 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44DD27CD9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:02:31 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id c10-20020a7bc84a000000b003cf81c2d3efso4645781wml.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKHD6wXDRdVXZxjkYVmrFb70YBOLbGxKyjWRVFbAlzA=;
        b=hYkv/K0ASciWH84SBcV9WPJD17R0/VCj2CNuTj9xT5CdEWa23xEjclQBK6KFwoX8R/
         K512drFXtNeGer0JVnaxY6CJRD7iWwj8+2zJs1yFb1tl7IrWPBKJ8zt2HdzuGrgJxBDr
         TPzIQbwBRacET/yI8gUzujmDswkrqFLMbzkyzkiDbDA6WiIlnhg9Q2J/gA3LMB+GAAbI
         A+ns2pLy1tD1vPJg9f4yoUu5l3ZS5PJ4KQTkyArOO+Ktz7ykyvlE2ujdutECJnwv0Mur
         ThAWkDp8T1k4Z6VTenwTSXVk7jgpwME8WaKao94Hk08qf3Rvqagc1QuUMA2+eA9tLGpZ
         1yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKHD6wXDRdVXZxjkYVmrFb70YBOLbGxKyjWRVFbAlzA=;
        b=WR5ypbvfXZSYqrJM4PW2aq1u1pd/6KwVl+KiQkRdG1A5MTMkPc89ZNMW9syGTeUcN7
         CykDVV0ajsCDHzFJSLYTbAC8rC/ChE8TSgTU7tEjtUm9tpIU4kbk6idA9SNNG4mR/ra1
         4+cGGCtpKlVsio+pSO0T2Js5n8b8nXa5oQ8v80zSfkJnDQlfcwAQYd0sdoEWUhpKodqb
         OQfgk6+HJxRoGcqM7O5XdWkGC9xPvR7zYA7h/F3KBTCk1CB17bh7lG+g4SYBn5AHe2Xd
         QEI8HB6y8EQ8ddKz5HoZFqeX8lxatBdEUF1d3vLufkQTFJcB4jQLbUKCRdfgjw/16X8t
         8lLw==
X-Gm-Message-State: ANoB5pkO+6CslZlEUwregTz9JgEE1vqIrDFaE5tNuq4xkU/AYPR/u+Ge
        ofGEHwcfGJtbPhlmqcnRjdXHXelj/+ToqV7+Og==
X-Google-Smtp-Source: AA0mqf7Hu4FblZ/mDtpcqVvgEiX4+Grk4PfFepL1Xs7R/h4nlXvH0Wx4k7HXz+zPNElZ4LDGU3F4Gb8S/H8BRcKMaw==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:e398:2261:c909:b359])
 (user=peternewman job=sendgmr) by 2002:a05:600c:1da2:b0:3cf:147d:ad9a with
 SMTP id p34-20020a05600c1da200b003cf147dad9amr29113630wms.33.1669723349842;
 Tue, 29 Nov 2022 04:02:29 -0800 (PST)
Date:   Tue, 29 Nov 2022 13:01:49 +0100
In-Reply-To: <20221129120149.1035444-1-peternewman@google.com>
Mime-Version: 1.0
References: <20221129120149.1035444-1-peternewman@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221129120149.1035444-3-peternewman@google.com>
Subject: [PATCH v2 2/2] x86/resctrl: Implement rename op for mon groups
From:   Peter Newman <peternewman@google.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
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

It's important to note that this solution relies on the fact that Intel
and AMD hardware allow the RMID to be assigned independently of the
CLOSID. Without this, the operation may not be as useful.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 66 ++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 03b51543c26d..d6562d98b816 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3230,6 +3230,71 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 	return ret;
 }
 
+static void mongrp_move(struct rdtgroup *rdtgrp, struct rdtgroup *new_prdtgrp)
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
+			WRITE_ONCE(t->closid, new_prdtgrp->closid);
+	}
+	read_unlock(&tasklist_lock);
+
+	update_closid_rmid(cpu_online_mask, NULL);
+}
+
+static int rdtgroup_rename(struct kernfs_node *kn,
+			   struct kernfs_node *new_parent, const char *new_name)
+{
+	struct rdtgroup *new_prdtgrp;
+	struct rdtgroup *rdtgrp;
+	int ret;
+
+	rdtgrp = kernfs_to_rdtgroup(kn);
+	new_prdtgrp = kernfs_to_rdtgroup(new_parent);
+	if (!rdtgrp || !new_prdtgrp)
+		return -EPERM;
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
+	mongrp_move(rdtgrp, new_prdtgrp);
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
@@ -3247,6 +3312,7 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
 	.mkdir		= rdtgroup_mkdir,
 	.rmdir		= rdtgroup_rmdir,
+	.rename		= rdtgroup_rename,
 	.show_options	= rdtgroup_show_options,
 };
 
-- 
2.38.1.584.g0f3c55d4c2-goog

