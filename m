Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4B0629DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiKOPqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238351AbiKOPp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:45:59 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1012DA90
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:45:53 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id l1-20020adfa381000000b0024184dfcb5eso1611497wrb.21
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pjQjIGRt7ZTx9YZ7YrUkwZQipfJByQX3G269/cjvZtQ=;
        b=RElAvdrEvhQXywsCTL33Q2ew+AwuTN9EMLviv1irsM11oZ4YRyyHcuapjihI39FsfW
         EPyG5jK0EqQ4+wnHrp2zS5KNv4AeGZG2xlh81eoQtXrr4dZGm0UH5c6+vxP5eV5G1tX7
         IYPoQg9tfGBwhG7m6yNJYQTjlCvUxz38e4KJdjtJcr8IysWl5rhL/RyWVPfhdMNo48Pb
         6fut/qFgpCy1JqDDLXS1rmXaN+KI0fxvMaD6p5cb2XfrNSEy8kaN/az0t6R52ns9c+Zs
         wvURAsgYvTkFNGhi9nJqX2FltgByeBsCNT34sZbBQFBIJBb5I+5NjF6LDUHt5Q5nUbjm
         iJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pjQjIGRt7ZTx9YZ7YrUkwZQipfJByQX3G269/cjvZtQ=;
        b=YBQMVkbPG4RUIE7Vpw0vzjBzY/JFZq+Su/B8gVFCavUVd//jafe9HTaNpjsUxY7b67
         J/oEGTK69ragfKgMd/rGhD6vXLCdQrNGREx/teNhCl6R09oad2UfuCGwkMs38/89cnoQ
         +1CIiDXknwFFFG7DhE5+PGc1zDlhiEDj4gsNtMu4dSWVuzBLJh4v3Qqp0uR2xUIc0Qjo
         lLAd8fZrs3RNONFC4Fz2qGLVLw7/UxjM0RgrFqLSnyO8rY+YGYN1zIKcVgl8R/2h6vNA
         lEG21crfyw+YivgFcLQTsx4SgCkW8eO4W2tdxkKbDAqprISDJQKmyERAmYgv2AhRWLr9
         ss/g==
X-Gm-Message-State: ANoB5pktjFoXmDAZwnyy/vhh1AVYqPvfWXFkMJalRwQimPQn9AxP4uwK
        4SBgP9eEYJNtVvpo9NtiCyjmiMzR1GLhBtNN9A==
X-Google-Smtp-Source: AA0mqf79iBLZBaNMtO/mGoswYa4jB6Grysw1HaPUANxn5SAY907wURE+53QRCbI6ojTvQgZpZvFPvkdoEJ4DV4qWzQ==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:fe62:9ede:ae13:6fda])
 (user=peternewman job=sendgmr) by 2002:a05:600c:3b19:b0:3cf:7514:a80d with
 SMTP id m25-20020a05600c3b1900b003cf7514a80dmr375420wms.0.1668527151450; Tue,
 15 Nov 2022 07:45:51 -0800 (PST)
Date:   Tue, 15 Nov 2022 16:45:15 +0100
In-Reply-To: <20221115154515.952783-1-peternewman@google.com>
Mime-Version: 1.0
References: <20221115154515.952783-1-peternewman@google.com>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
Message-ID: <20221115154515.952783-3-peternewman@google.com>
Subject: [PATCH v1 2/2] x86/resctrl: Implement rename op for mon groups
From:   Peter Newman <peternewman@google.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Gaurang Upasani <gupasani@google.com>,
        Babu Moger <Babu.Moger@amd.com>, linux-kernel@vger.kernel.org,
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

Implement the rename operation for resctrlfs mon groups to effect a
change in CLOSID for a MON group while otherwise leaving the group
intact.

This operation is useful as a solution to changing the class of service
of a running container without impacting its resource usage counters on
systems which do not implement enough CLOSIDs to give every container
it's own CTRL_MON group. Previously, on such systems, it would have been
necessary to move every task individually to a new CTRL_MON group using
the tasks file. This approach races with the creation of new tasks in
the group, making it practically unusable.

It's important to note that this solution relies on the fact that Intel
and AMD hardware allow the RMID to be assigned independently of the
CLOSID. Without this, this operation may not be as useful.

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
2.38.1.493.g58b659f92b-goog

