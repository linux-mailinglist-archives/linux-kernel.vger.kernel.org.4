Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E0666A168
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjAMSC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjAMSB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:01:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCC8627A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:55:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A792D1764;
        Fri, 13 Jan 2023 09:56:36 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C2A13F67D;
        Fri, 13 Jan 2023 09:55:52 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com
Subject: [PATCH v2 04/18] x86/resctrl: Move rmid allocation out of mkdir_rdt_prepare()
Date:   Fri, 13 Jan 2023 17:54:45 +0000
Message-Id: <20230113175459.14825-5-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230113175459.14825-1-james.morse@arm.com>
References: <20230113175459.14825-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RMID are allocated for each monitor or control group directory, because
each of these needs its own RMID. For control groups,
rdtgroup_mkdir_ctrl_mon() later goes on to allocate the CLOSID.

MPAM's equivalent of RMID are not an independent number, so can't be
allocated until the closid is known. An RMID allocation for one CLOSID
may fail, whereas another may succeed depending on how many monitor
groups a control group has.

The RMID allocation needs to move to be after the CLOSID has been
allocated.

Move the RMID allocation out of mkdir_rdt_prepare() to occur in its caller,
after the mkdir_rdt_prepare() call. This allows the RMID allocator to
know the CLOSID.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 29 +++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 841294ad6263..c67083a8a5f5 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2892,6 +2892,12 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 	return 0;
 }
 
+static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
+{
+	if (rdt_mon_capable)
+		free_rmid(rgrp->closid, rgrp->mon.rmid);
+}
+
 static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 			     const char *name, umode_t mode,
 			     enum rdt_group_type rtype, struct rdtgroup **r)
@@ -2957,10 +2963,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 		goto out_destroy;
 	}
 
-	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
-	if (ret)
-		goto out_destroy;
-
 	kernfs_activate(kn);
 
 	/*
@@ -2981,7 +2983,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
 {
 	kernfs_remove(rgrp->kn);
-	free_rmid(rgrp->closid, rgrp->mon.rmid);
 	rdtgroup_remove(rgrp);
 }
 
@@ -3003,12 +3004,19 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
 	prgrp = rdtgrp->mon.parent;
 	rdtgrp->closid = prgrp->closid;
 
+	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
+	if (ret) {
+		mkdir_rdt_prepare_clean(rdtgrp);
+		goto out_unlock;
+	}
+
 	/*
 	 * Add the rdtgrp to the list of rdtgrps the parent
 	 * ctrl_mon group has to track.
 	 */
 	list_add_tail(&rdtgrp->mon.crdtgrp_list, &prgrp->mon.crdtgrp_list);
 
+out_unlock:
 	rdtgroup_kn_unlock(parent_kn);
 	return ret;
 }
@@ -3039,10 +3047,15 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 	ret = 0;
 
 	rdtgrp->closid = closid;
-	ret = rdtgroup_init_alloc(rdtgrp);
-	if (ret < 0)
+
+	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
+	if (ret)
 		goto out_id_free;
 
+	ret = rdtgroup_init_alloc(rdtgrp);
+	if (ret < 0)
+		goto out_rmid_free;
+
 	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
 
 	if (rdt_mon_capable) {
@@ -3061,6 +3074,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 
 out_del_list:
 	list_del(&rdtgrp->rdtgroup_list);
+out_rmid_free:
+	mkdir_rdt_prepare_rmid_free(rdtgrp);
 out_id_free:
 	closid_free(closid);
 out_common_fail:
-- 
2.30.2

