Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026F76E9E98
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjDTWHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjDTWGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:06:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5284935AA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682028409; x=1713564409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oyN/jlwNsbSH8AgIgVgPY6yTXuGt35RnjrIqFZ99+pY=;
  b=F0SR9pxxZufNPjK5UzsNZiGYStvN1cdS6uHsS1y8HXNnlo2YLXZhp4Ej
   vhdPCFBDwUs/97wiSjdZTHPEx1rDx3P3WtfU+/H9t6wsCdd8gXcMNdPDX
   FPz+xf1OyurP7LwbTqA6kY0+tErmInngzZ/29IKMm6PYNAdtURowvBZ1n
   hw0dYCSN2v6AoYRjCvBJoELlzL7aMKn6RerdoqDTAgO027KMqnFO/Ae9y
   YE+CXDHmQGQ11R7OcxJtgNXqbKsrRJTIENpEWCGDCFf9txUKtV3LUWUkz
   gq6tVDXDNcoCoTvJ1pYbPVynnGGvGvxT+8dgrOcnqAI8QkW72OkaGliv6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="348650928"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="348650928"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 15:06:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="724583761"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="724583761"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 15:06:45 -0700
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
Subject: [RFC PATCH 4/7] x86/resctrl: Add capability to driver registration to create control files
Date:   Thu, 20 Apr 2023 15:06:33 -0700
Message-Id: <20230420220636.53527-5-tony.luck@intel.com>
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

Add a control file to each ctrlmon directory. Hook into the mkdir()
functions to add the control file to any new directories that are
created.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                |  2 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 70 ++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 44dd811cb552..8668480cea51 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -217,6 +217,7 @@ struct resctrl_fileinfo {
  * @infodir:	Name of directory to create in resctrl/info.
  * @infofiles:	Array of files to create under infodir.
  * @rmdir:	Callback when a resctrl directory is removed.
+ * @ctrlfiles:	Array of files to create in ctrlmon directories.
  */
 struct resctrl_driver {
 	struct list_head	list;
@@ -224,6 +225,7 @@ struct resctrl_driver {
 	char			*infodir;
 	struct resctrl_fileinfo	*infofiles;
 	int			(*rmdir)(int oclos, int ormid, int nclos, int nrmid);
+	struct resctrl_fileinfo	*ctrlfiles;
 };
 
 int resctrl_register_driver(struct resctrl_driver *d);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 8ca3b17bd671..e2fdd5819336 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2466,6 +2466,18 @@ static int addfiles(struct kernfs_node *parent, struct resctrl_fileinfo *files,
 	return 0;
 }
 
+static void rmfiles(struct kernfs_node *parent, struct resctrl_fileinfo *files)
+{
+	struct resctrl_fileinfo *f;
+	struct kernfs_node *kn;
+
+	for (f = files; f->name; f++) {
+		kn = kernfs_find_and_get_ns(parent, f->name, NULL);
+		if (kn)
+			kernfs_remove(kn);
+	}
+}
+
 /*
  * Add or remove a directory from the resctrl/info directory
  */
@@ -2495,12 +2507,49 @@ static int rdtgroup_update_info_dir(char *name, struct resctrl_fileinfo *files)
 	return ret;
 }
 
+/*
+ * Create/remove a new control file in all current and future control and
+ * monitor groups.
+ */
+static void rdtgroup_update_ctrl_dir(struct resctrl_fileinfo *files, bool add)
+{
+	struct rdtgroup *rdtgrp;
+
+	if (!add) {
+		list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
+			struct rdtgroup *crg;
+
+			rmfiles(rdtgrp->kn, files);
+
+			list_for_each_entry(crg, &rdtgrp->mon.crdtgrp_list, mon.crdtgrp_list) {
+				rmfiles(crg->kn, files);
+			}
+		}
+
+		return;
+	}
+
+	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
+		unsigned long priv = (rdtgrp->closid << 16) | rdtgrp->mon.rmid;
+		struct rdtgroup *crg;
+
+		addfiles(rdtgrp->kn, files, F_PRIV | F_ACTIVATE, (void *)priv);
+
+		list_for_each_entry(crg, &rdtgrp->mon.crdtgrp_list, mon.crdtgrp_list) {
+			priv = (crg->closid << 16) | crg->mon.rmid;
+			addfiles(crg->kn, files, F_PRIV | F_ACTIVATE, (void *)priv);
+		}
+	}
+}
+
 static void driver_up(struct resctrl_driver *d)
 {
 	if (d->mount)
 		d->mount(true);
 	if (d->infodir)
 		rdtgroup_update_info_dir(d->infodir, d->infofiles);
+	if (d->ctrlfiles)
+		rdtgroup_update_ctrl_dir(d->ctrlfiles, true);
 }
 
 static void driver_down(struct resctrl_driver *d)
@@ -2509,6 +2558,8 @@ static void driver_down(struct resctrl_driver *d)
 		d->mount(false);
 	if (d->infodir)
 		rdtgroup_update_info_dir(d->infodir, NULL);
+	if (d->ctrlfiles)
+		rdtgroup_update_ctrl_dir(d->ctrlfiles, false);
 }
 
 int resctrl_register_driver(struct resctrl_driver *d)
@@ -3375,6 +3426,7 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
 			      const char *name, umode_t mode)
 {
 	struct rdtgroup *rdtgrp, *prgrp;
+	struct resctrl_driver *d;
 	int ret;
 
 	ret = mkdir_rdt_prepare(parent_kn, name, mode, RDTMON_GROUP, &rdtgrp);
@@ -3384,6 +3436,14 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
 	prgrp = rdtgrp->mon.parent;
 	rdtgrp->closid = prgrp->closid;
 
+	list_for_each_entry(d, &drivers, list) {
+		unsigned long priv = (rdtgrp->closid << 16) | rdtgrp->mon.rmid;
+
+		if (!d->ctrlfiles)
+			continue;
+		addfiles(rdtgrp->kn, d->ctrlfiles, F_PRIV | F_ACTIVATE, (void *)priv);
+	}
+
 	/*
 	 * Add the rdtgrp to the list of rdtgrps the parent
 	 * ctrl_mon group has to track.
@@ -3401,6 +3461,7 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
 static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 				   const char *name, umode_t mode)
 {
+	struct resctrl_driver *d;
 	struct rdtgroup *rdtgrp;
 	struct kernfs_node *kn;
 	u32 closid;
@@ -3426,6 +3487,15 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 
 	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
 
+	list_for_each_entry(d, &drivers, list) {
+		unsigned long priv = (rdtgrp->closid << 16) | rdtgrp->mon.rmid;
+
+		if (!d->ctrlfiles)
+			continue;
+
+		addfiles(kn, d->ctrlfiles, F_PRIV | F_ACTIVATE, (void *)priv);
+	}
+
 	if (rdt_mon_capable) {
 		/*
 		 * Create an empty mon_groups directory to hold the subset
-- 
2.39.2

