Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593526E9E92
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjDTWGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDTWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:06:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4757F270C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682028407; x=1713564407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TX3utSJkvuG87gr/i0jCm7n2nnIrYB4p9WSinKZRLsI=;
  b=N1EzTJuu92cE7L979Zhqxd68LQQQ+ZId+6J9f3DFK8okBe9W7tUWnQof
   Sg8ENeCs5pl0h0YQeJZy9jzbVJyum3kf8nvSSS4SuoCA6UZ+rQ0H8vjGL
   liJnGmGb/nzN553Mo23N1P1GElEvTgt2mXg18PQ6QtvPmta+YOJ0A75ru
   QnwRvMbxuAeZ3QvKjYiwqh6cAays6HjVlVHLHRggUZl4zgXFxkVjj+iJO
   /szTx1OFdSxtUWmYqyIVgxEit/Z0keCWoKtBvXsUYS0nro8yMTK/XeGpl
   b8VBcM5nulXGNJaj5BLqijJD0k0UcIsqRDXoapUPPhHOHT1NWgwsYWTMh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="348650896"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="348650896"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 15:06:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="724583749"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="724583749"
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
Subject: [RFC PATCH 1/7] x86/resctrl: Add register/unregister functions for driver to hook into resctrl
Date:   Thu, 20 Apr 2023 15:06:30 -0700
Message-Id: <20230420220636.53527-2-tony.luck@intel.com>
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

Just one callback at the point for the driver to be notified when the
resctrl filesystem is mounted or unmounted. Virtually all drivers
will need this hook to enable/disable their feature(s) as part of
mount/unmount.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                | 13 +++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 50 ++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8334eeacfec5..78513edddca0 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -204,6 +204,19 @@ struct resctrl_schema {
 	u32				num_closid;
 };
 
+/**
+ * struct resctrl_driver - interface for driver to attach to resctrl
+ * @list:	List of registered drivers
+ * @mount:	Callback for mount/unmount
+ */
+struct resctrl_driver {
+	struct list_head	list;
+	void			(*mount)(bool mount);
+};
+
+int resctrl_register_driver(struct resctrl_driver *d);
+void resctrl_unregister_driver(struct resctrl_driver *d);
+
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6ad33f355861..3e6778bde427 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -51,6 +51,9 @@ static struct kernfs_node *kn_mongrp;
 /* Kernel fs node for "mon_data" directory under root */
 static struct kernfs_node *kn_mondata;
 
+static LIST_HEAD(drivers);
+static bool resctrl_is_mounted;
+
 static struct seq_buf last_cmd_status;
 static char last_cmd_status_buf[512];
 
@@ -2437,6 +2440,42 @@ static int schemata_list_create(void)
 	return ret;
 }
 
+static void driver_up(struct resctrl_driver *d)
+{
+	if (d->mount)
+		d->mount(true);
+}
+
+static void driver_down(struct resctrl_driver *d)
+{
+	if (d->mount)
+		d->mount(false);
+}
+
+int resctrl_register_driver(struct resctrl_driver *d)
+{
+	mutex_lock(&rdtgroup_mutex);
+	list_add(&d->list, &drivers);
+
+	if (resctrl_is_mounted)
+		driver_up(d);
+	mutex_unlock(&rdtgroup_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(resctrl_register_driver);
+
+void resctrl_unregister_driver(struct resctrl_driver *d)
+{
+	mutex_lock(&rdtgroup_mutex);
+	list_del(&d->list);
+
+	if (resctrl_is_mounted)
+		driver_down(d);
+	mutex_unlock(&rdtgroup_mutex);
+}
+EXPORT_SYMBOL_GPL(resctrl_unregister_driver);
+
 static void schemata_list_destroy(void)
 {
 	struct resctrl_schema *s, *tmp;
@@ -2450,6 +2489,7 @@ static void schemata_list_destroy(void)
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
+	struct resctrl_driver *d;
 	struct rdt_domain *dom;
 	struct rdt_resource *r;
 	int ret;
@@ -2516,6 +2556,10 @@ static int rdt_get_tree(struct fs_context *fc)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
 	}
 
+	list_for_each_entry(d, &drivers, list)
+		driver_up(d);
+	resctrl_is_mounted = true;
+
 	goto out;
 
 out_psl:
@@ -2761,6 +2805,7 @@ static void rmdir_all_sub(void)
 
 static void rdt_kill_sb(struct super_block *sb)
 {
+	struct resctrl_driver *d;
 	struct rdt_resource *r;
 
 	cpus_read_lock();
@@ -2780,6 +2825,11 @@ static void rdt_kill_sb(struct super_block *sb)
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
 	static_branch_disable_cpuslocked(&rdt_enable_key);
 	kernfs_kill_sb(sb);
+
+	list_for_each_entry(d, &drivers, list)
+		driver_down(d);
+	resctrl_is_mounted = false;
+
 	mutex_unlock(&rdtgroup_mutex);
 	cpus_read_unlock();
 }
-- 
2.39.2

