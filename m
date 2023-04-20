Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FE06E9E99
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjDTWHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDTWG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:06:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49F340CA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682028410; x=1713564410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vE1A0+aVMvRyEXkILJnKwNrogCJkhjI/aeL766efMHE=;
  b=IlRVFUrAp+S/rdewxqmrObH5a42HGCBtWPIDhywjtnryRmEUZ/cAqQuZ
   /bl6EYoN8goW8ijyVS3l8UCZ6uJSoBMOBdBO8ph1Fmx6NLA74LymmN6LJ
   9hVXhUy/k2mmE+GU4LsMKEV1B0H4DUYOMlh++FD/S64U615WGuBwOzU8Q
   zHxdEqA+W1Hk7/IE2NR3xYCxP6aOrQLTv50kkAuB7d9Zc4q/zHYm02L7U
   enIerfkRkG0ggySKYKahMCKV+hkpH5hhfXdfwLQlyKDXNXJDxZBlTxx1H
   Tr0hbQiCJudYK8MDXdjaQAZM7cxwn3Fzh/o6aCw/J0PE7rHDyLSWUPiCR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="348650948"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="348650948"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 15:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="724583770"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="724583770"
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
Subject: [RFC PATCH 6/7] x86/resctrl: Allow a device to override an existing schemata entry
Date:   Thu, 20 Apr 2023 15:06:35 -0700
Message-Id: <20230420220636.53527-7-tony.luck@intel.com>
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

Remove that entry from the resctrl_schema_all list when driver
is loaded. Put it back again when driver is unloaded.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                |  4 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 691805214f41..246644f53bde 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -223,6 +223,8 @@ struct resctrl_fileinfo {
  * @rmdir:	Callback when a resctrl directory is removed.
  * @ctrlfiles:	Array of files to create in ctrlmon directories.
  * @schema:	Driver supplied to manage a line in schemata file.
+ * @schema_override: Name of resource in schemata to override.
+ * @save_schema: List to save overridden schema while driver loaded
  */
 struct resctrl_driver {
 	struct list_head	list;
@@ -232,6 +234,8 @@ struct resctrl_driver {
 	int			(*rmdir)(int oclos, int ormid, int nclos, int nrmid);
 	struct resctrl_fileinfo	*ctrlfiles;
 	struct resctrl_schema	schema;
+	char			*schema_override;
+	struct list_head	save_schema;
 };
 
 int resctrl_register_driver(struct resctrl_driver *d);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cc2292a7435b..4fc12ad56843 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2547,6 +2547,19 @@ static void rdtgroup_update_ctrl_dir(struct resctrl_fileinfo *files, bool add)
 	}
 }
 
+static void driver_override(struct resctrl_driver *d)
+{
+	struct resctrl_schema *rs;
+
+	list_for_each_entry(rs, &resctrl_schema_all, list) {
+		if (strncmp(d->schema_override, rs->name, sizeof(rs->name)))
+			continue;
+		INIT_LIST_HEAD(&d->save_schema);
+		list_move(&rs->list, &d->save_schema);
+		break;
+	}
+}
+
 static void driver_up(struct resctrl_driver *d)
 {
 	if (d->mount)
@@ -2575,6 +2588,9 @@ int resctrl_register_driver(struct resctrl_driver *d)
 	if (d->schema.name[0])
 		list_add(&d->schema.list, &resctrl_schema_all);
 
+	if (d->schema_override)
+		driver_override(d);
+
 	if (resctrl_is_mounted)
 		driver_up(d);
 	mutex_unlock(&rdtgroup_mutex);
@@ -2592,6 +2608,9 @@ void resctrl_unregister_driver(struct resctrl_driver *d)
 	if (d->schema.name[0])
 		list_del(&d->schema.list);
 
+	if (d->schema_override && !list_empty(&d->save_schema))
+		list_move(d->save_schema.next, &resctrl_schema_all);
+
 	if (resctrl_is_mounted)
 		driver_down(d);
 	mutex_unlock(&rdtgroup_mutex);
-- 
2.39.2

