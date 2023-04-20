Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071626E9E94
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjDTWG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjDTWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:06:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEE32723
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682028407; x=1713564407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f6vRZH9J4bl0VYCw/gMa81FWWCa1ygl87qFy76CeLYY=;
  b=IufHl0839MtbMtaL7xi0+aeggMaFTrTZVHsRcZKuDDO0wFKBZDbCzX3O
   cFXD+vatn84mZ5U+rzqN42Ah06H85Kqp7BlkKJBW95SLJXJAljGNp8yuv
   ftV0ySNoI4CWL1zR0fd9oosrHsheBmGlVc91GlvciLKJQ7eh3xC5CeqbX
   t2K92R6xVXpbx0kZ1MvB6GRAUKviPk4NUjTCNQ8l/LOv9q8mUsCUaaGeo
   TgwVbnqLMDPAAbmISU++b0GoTzIvgLRRhY7H/zQnV0zgUuMKtO7pMlhd9
   9AB1iZCwpGpYBFrQ0d6jWiwIFEQDBUyTLPhOwQeAo6mB5710bbWgltg65
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="348650906"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="348650906"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 15:06:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="724583753"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="724583753"
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
Subject: [RFC PATCH 2/7] x86/resctrl: Add an interface to add/remove a new info/directory
Date:   Thu, 20 Apr 2023 15:06:31 -0700
Message-Id: <20230420220636.53527-3-tony.luck@intel.com>
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

Extend the resctrl_driver structure so that a driver may request
creation of a directory in the info/ hierarchy and populate it
with files.

Remove that info directory and contents when the resctrl file system is
unmounted, or the driver unregisters.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                | 10 +++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 59 ++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 78513edddca0..7847be48edae 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -204,14 +204,24 @@ struct resctrl_schema {
 	u32				num_closid;
 };
 
+struct resctrl_fileinfo {
+	char			*name;
+	struct kernfs_ops	*ops;
+	void			*priv;
+};
+
 /**
  * struct resctrl_driver - interface for driver to attach to resctrl
  * @list:	List of registered drivers
  * @mount:	Callback for mount/unmount
+ * @infodir:	Name of directory to create in resctrl/info.
+ * @infofiles:	Array of files to create under infodir.
  */
 struct resctrl_driver {
 	struct list_head	list;
 	void			(*mount)(bool mount);
+	char			*infodir;
+	struct resctrl_fileinfo	*infofiles;
 };
 
 int resctrl_register_driver(struct resctrl_driver *d);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3e6778bde427..4c662e827097 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2440,16 +2440,75 @@ static int schemata_list_create(void)
 	return ret;
 }
 
+#define F_ACTIVATE	BIT(0)
+#define F_PRIV		BIT(1)
+
+static int addfiles(struct kernfs_node *parent, struct resctrl_fileinfo *files,
+		    int flags, void *priv)
+{
+	struct resctrl_fileinfo *f;
+	struct kernfs_node *kn;
+	umode_t mode;
+	void *p;
+
+	for (f = files; f->name; f++) {
+		mode = (f->ops->write) ? 0644 : 0444;
+		p = (flags & F_PRIV) ? priv : f->priv;
+		kn = __kernfs_create_file(parent, f->name, mode,
+					  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
+					  f->ops, p, NULL, NULL);
+		if (IS_ERR(kn))
+			return PTR_ERR(kn);
+		if (flags & F_ACTIVATE)
+			kernfs_activate(kn);
+	}
+
+	return 0;
+}
+
+/*
+ * Add or remove a directory from the resctrl/info directory
+ */
+static int rdtgroup_update_info_dir(char *name, struct resctrl_fileinfo *files)
+{
+	struct kernfs_node *kn_subdir;
+	int ret;
+
+	if (!files) {
+		kn_subdir = kernfs_find_and_get_ns(kn_info, name, NULL);
+		if (kn_subdir)
+			kernfs_remove(kn_subdir);
+		return 0;
+	}
+
+	kn_subdir = kernfs_create_dir(kn_info, name, 0755, NULL);
+	if (IS_ERR(kn_subdir))
+		return PTR_ERR(kn_subdir);
+
+	ret = addfiles(kn_subdir, files, 0, 0);
+
+	if (ret)
+		kernfs_remove(kn_subdir);
+	else
+		kernfs_activate(kn_subdir);
+
+	return ret;
+}
+
 static void driver_up(struct resctrl_driver *d)
 {
 	if (d->mount)
 		d->mount(true);
+	if (d->infodir)
+		rdtgroup_update_info_dir(d->infodir, d->infofiles);
 }
 
 static void driver_down(struct resctrl_driver *d)
 {
 	if (d->mount)
 		d->mount(false);
+	if (d->infodir)
+		rdtgroup_update_info_dir(d->infodir, NULL);
 }
 
 int resctrl_register_driver(struct resctrl_driver *d)
-- 
2.39.2

