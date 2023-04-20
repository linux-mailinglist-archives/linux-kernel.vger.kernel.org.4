Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551366E9E96
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjDTWHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjDTWGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:06:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB9B30F2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682028409; x=1713564409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JvSi0JTqnA0+W3DiLgdLyG89ldY/9UClUErFaxrrnJs=;
  b=jqGi6I1Y8Tnc89MVEDaQvpTsz0fFHMi20pFwVP2JFEpauN/xstqWSSOw
   gvdjApAw1mrP+FVdTIp6paferz49rQ8Mn0mXKJKtgSL7E4pjSsxJBKJN3
   5pGbfcq/EKlXE020/eU4D2IPzATk7RAiqmbqyBBzT2/QnAn5z6nOwD6xb
   r+Cxo165bZtAvhrrwufn+nVPrHq/L8FH4hxHziwff0cxxDiGeNzdhM1iG
   3J6MUM1dWwHrzGMyunXS0hxBg06m3fMMUNcgIdTfwOO1Y1YZLSF8pKVZ9
   RdA48jXWB1tblfSz72jLpwI03uXvCHP8uDKKrnvu2H4RXrfG3PVFiRqWs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="348650917"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="348650917"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 15:06:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="724583758"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="724583758"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 15:06:44 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH 3/7] x86/resctrl: Add driver callback when directories are removed
Date:   Thu, 20 Apr 2023 15:06:32 -0700
Message-Id: <20230420220636.53527-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420220636.53527-1-tony.luck@intel.com>
References: <20230420220636.53527-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a resctrl directory is removed, entities attached to that
directory are reassigned with the CLOSID and RMID of the parent
directory.

Add a callback function so a driver can reset the CLOSID and RMID
of any resources attached to the removed directory.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 7847be48edae..44dd811cb552 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -216,12 +216,14 @@ struct resctrl_fileinfo {
  * @mount:	Callback for mount/unmount
  * @infodir:	Name of directory to create in resctrl/info.
  * @infofiles:	Array of files to create under infodir.
+ * @rmdir:	Callback when a resctrl directory is removed.
  */
 struct resctrl_driver {
 	struct list_head	list;
 	void			(*mount)(bool mount);
 	char			*infodir;
 	struct resctrl_fileinfo	*infofiles;
+	int			(*rmdir)(int oclos, int ormid, int nclos, int nrmid);
 };
 
 int resctrl_register_driver(struct resctrl_driver *d);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 4c662e827097..8ca3b17bd671 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3495,11 +3495,18 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
 static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 {
 	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
+	struct resctrl_driver *d;
 	int cpu;
 
 	/* Give any tasks back to the parent group */
 	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
 
+	list_for_each_entry(d, &drivers, list) {
+		if (d->rmdir)
+			d->rmdir(rdtgrp->closid, rdtgrp->mon.rmid,
+				 prdtgrp->closid, prdtgrp->mon.rmid);
+	}
+
 	/* Update per cpu rmid of the moved CPUs first */
 	for_each_cpu(cpu, &rdtgrp->cpu_mask)
 		per_cpu(pqr_state.default_rmid, cpu) = prdtgrp->mon.rmid;
@@ -3535,6 +3542,7 @@ static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
 
 static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 {
+	struct resctrl_driver *d;
 	int cpu;
 
 	/* Give any tasks back to the default group */
@@ -3544,6 +3552,11 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	cpumask_or(&rdtgroup_default.cpu_mask,
 		   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
 
+	list_for_each_entry(d, &drivers, list) {
+		if (d->rmdir)
+			d->rmdir(rdtgrp->closid, rdtgrp->mon.rmid, 0, 0);
+	}
+
 	/* Update per cpu closid and rmid of the moved CPUs first */
 	for_each_cpu(cpu, &rdtgrp->cpu_mask) {
 		per_cpu(pqr_state.default_closid, cpu) = rdtgroup_default.closid;
-- 
2.39.2

