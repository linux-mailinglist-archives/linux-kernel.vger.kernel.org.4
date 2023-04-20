Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AE26E9E95
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjDTWHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjDTWGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:06:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9363C270C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682028409; x=1713564409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=snGRPrZmk44dmEkOaizzRRz9f19/ahGzyDW4YNPDoy4=;
  b=Ad8T2j2NRVzZJ4nxk2QZ3RrW0ESgxe/hBRCZwi0NGAucyLN4r30qUYp/
   VjSpc4+/5siiKcxA1KityOcfUMwTdn0u0Uij/rG2OlkRX86NzWoZSpcn/
   V0JsKbxpWkZIlEyEfU+ixQ5D1xTEsIqx9dIs+YQp0AEJeiVtsjxMeL9Aw
   yAAiR0lwYfHX2cucZtpfiYQeqfvQdk7ZeodnIOtfu2fWVWSc6kDwGOP6D
   aJ0arnx+eD7fAhOMzv9Dc/dHBuKKNgzzNMT4wr9t81IPkRno4hqYami0S
   H3ofb3IZ8tz5RLsNW5UEUMGMcQdfR/DGlYS/ducGs7tMw6DWXsbR7yFwz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="348650938"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="348650938"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 15:06:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="724583766"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="724583766"
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
Subject: [RFC PATCH 5/7] x86/resctrl: Enhance driver registration to hook into schemata files
Date:   Thu, 20 Apr 2023 15:06:34 -0700
Message-Id: <20230420220636.53527-6-tony.luck@intel.com>
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

Add a new configuration type "DRIVER" for lines in the schemata files
with a show() and update() callback functions to the driver to maintain
these lines.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                   |  6 ++++++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 17 ++++++++++++++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 16 ++++++++++++++++
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8668480cea51..691805214f41 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -23,11 +23,13 @@ int proc_resctrl_show(struct seq_file *m,
  * @CDP_NONE:	No prioritisation, both code and data are controlled or monitored.
  * @CDP_CODE:	Configuration applies to instruction fetches.
  * @CDP_DATA:	Configuration applies to reads and writes.
+ * @DRIVER:	Resource managed by driver.
  */
 enum resctrl_conf_type {
 	CDP_NONE,
 	CDP_CODE,
 	CDP_DATA,
+	DRIVER,
 };
 
 #define CDP_NUM_TYPES	(CDP_DATA + 1)
@@ -201,6 +203,8 @@ struct resctrl_schema {
 	char				name[8];
 	enum resctrl_conf_type		conf_type;
 	struct rdt_resource		*res;
+	void				(*show)(struct seq_file *s, int closid);
+	int				(*update)(char *s, int closid);
 	u32				num_closid;
 };
 
@@ -218,6 +222,7 @@ struct resctrl_fileinfo {
  * @infofiles:	Array of files to create under infodir.
  * @rmdir:	Callback when a resctrl directory is removed.
  * @ctrlfiles:	Array of files to create in ctrlmon directories.
+ * @schema:	Driver supplied to manage a line in schemata file.
  */
 struct resctrl_driver {
 	struct list_head	list;
@@ -226,6 +231,7 @@ struct resctrl_driver {
 	struct resctrl_fileinfo	*infofiles;
 	int			(*rmdir)(int oclos, int ormid, int nclos, int nrmid);
 	struct resctrl_fileinfo	*ctrlfiles;
+	struct resctrl_schema	schema;
 };
 
 int resctrl_register_driver(struct resctrl_driver *d);
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index b44c487727d4..7a59d6eab576 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -356,8 +356,12 @@ static int rdtgroup_parse_resource(char *resname, char *tok,
 	struct resctrl_schema *s;
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
-		if (!strcmp(resname, s->name) && rdtgrp->closid < s->num_closid)
-			return parse_line(tok, s, rdtgrp);
+		if (!strcmp(resname, s->name) && rdtgrp->closid < s->num_closid) {
+			if (s->conf_type == DRIVER)
+				return s->update(tok, rdtgrp->closid);
+			else
+				return parse_line(tok, s, rdtgrp);
+		}
 	}
 	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
 	return -EINVAL;
@@ -419,10 +423,11 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 		r = s->res;
 
 		/*
+		 * Resources controlled by a driver are updated by that driver.
 		 * Writes to mba_sc resources update the software controller,
 		 * not the control MSR.
 		 */
-		if (is_mba_sc(r))
+		if (s->conf_type == DRIVER || is_mba_sc(r))
 			continue;
 
 		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
@@ -464,6 +469,12 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 	u32 ctrl_val;
 
 	seq_printf(s, "%*s:", max_name_width, schema->name);
+
+	if (schema->conf_type == DRIVER) {
+		schema->show(s, closid);
+		return;
+	}
+
 	list_for_each_entry(dom, &r->domains, list) {
 		if (sep)
 			seq_puts(s, ";");
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e2fdd5819336..cc2292a7435b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2043,6 +2043,8 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 
 	/* loop over enabled controls, these are all alloc_capable */
 	list_for_each_entry(s, &resctrl_schema_all, list) {
+		if (s->conf_type == DRIVER)
+			continue;
 		r = s->res;
 		fflags =  r->fflags | RF_CTRL_INFO;
 		ret = rdtgroup_mkdir_info_resdir(s, s->name, fflags);
@@ -2390,6 +2392,9 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
 	case CDP_NONE:
 		suffix = "";
 		break;
+	case DRIVER:
+		kfree(s);
+		return -EINVAL;
 	}
 
 	ret = snprintf(s->name, sizeof(s->name), "%s%s", r->name, suffix);
@@ -2567,6 +2572,9 @@ int resctrl_register_driver(struct resctrl_driver *d)
 	mutex_lock(&rdtgroup_mutex);
 	list_add(&d->list, &drivers);
 
+	if (d->schema.name[0])
+		list_add(&d->schema.list, &resctrl_schema_all);
+
 	if (resctrl_is_mounted)
 		driver_up(d);
 	mutex_unlock(&rdtgroup_mutex);
@@ -2578,8 +2586,12 @@ EXPORT_SYMBOL_GPL(resctrl_register_driver);
 void resctrl_unregister_driver(struct resctrl_driver *d)
 {
 	mutex_lock(&rdtgroup_mutex);
+
 	list_del(&d->list);
 
+	if (d->schema.name[0])
+		list_del(&d->schema.list);
+
 	if (resctrl_is_mounted)
 		driver_down(d);
 	mutex_unlock(&rdtgroup_mutex);
@@ -2591,6 +2603,8 @@ static void schemata_list_destroy(void)
 	struct resctrl_schema *s, *tmp;
 
 	list_for_each_entry_safe(s, tmp, &resctrl_schema_all, list) {
+		if (s->conf_type == DRIVER)
+			continue;
 		list_del(&s->list);
 		kfree(s);
 	}
@@ -3285,6 +3299,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 	rdt_staged_configs_clear();
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
+		if (s->conf_type == DRIVER)
+			continue;
 		r = s->res;
 		if (r->rid == RDT_RESOURCE_MBA ||
 		    r->rid == RDT_RESOURCE_SMBA) {
-- 
2.39.2

