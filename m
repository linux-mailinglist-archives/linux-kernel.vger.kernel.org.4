Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECEA66A166
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjAMSCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjAMSBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:01:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3315592348
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:55:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12C971763;
        Fri, 13 Jan 2023 09:56:34 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7ACE43F67D;
        Fri, 13 Jan 2023 09:55:49 -0800 (PST)
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
Subject: [PATCH v2 03/18] x86/resctrl: Create helper for RMID allocation and mondata dir creation
Date:   Fri, 13 Jan 2023 17:54:44 +0000
Message-Id: <20230113175459.14825-4-james.morse@arm.com>
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
allocated until the CLOSID is known. An RMID allocation for one CLOSID
may fail, whereas another may succeed depending on how many monitor
groups a control group has.

The RMID allocation needs to move to be after the CLOSID has been
allocated.

To make a subsequent change that does this easier to read, move the RMID
allocation and mondata dir creation to a helper.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 42 +++++++++++++++++---------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9ce4746778f4..841294ad6263 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2868,6 +2868,30 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 	return 0;
 }
 
+static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
+{
+	int ret;
+
+	if (!rdt_mon_capable)
+		return 0;
+
+	ret = alloc_rmid();
+	if (ret < 0) {
+		rdt_last_cmd_puts("Out of RMIDs\n");
+		return ret;
+	}
+	rdtgrp->mon.rmid = ret;
+
+	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
+	if (ret) {
+		rdt_last_cmd_puts("kernfs subdir error\n");
+		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 			     const char *name, umode_t mode,
 			     enum rdt_group_type rtype, struct rdtgroup **r)
@@ -2933,20 +2957,10 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 		goto out_destroy;
 	}
 
-	if (rdt_mon_capable) {
-		ret = alloc_rmid();
-		if (ret < 0) {
-			rdt_last_cmd_puts("Out of RMIDs\n");
-			goto out_destroy;
-		}
-		rdtgrp->mon.rmid = ret;
+	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
+	if (ret)
+		goto out_destroy;
 
-		ret = mkdir_mondata_all(kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
-		if (ret) {
-			rdt_last_cmd_puts("kernfs subdir error\n");
-			goto out_idfree;
-		}
-	}
 	kernfs_activate(kn);
 
 	/*
@@ -2954,8 +2968,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 	 */
 	return 0;
 
-out_idfree:
-	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 out_destroy:
 	kernfs_put(rdtgrp->kn);
 	kernfs_remove(rdtgrp->kn);
-- 
2.30.2

