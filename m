Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5A36899EE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjBCNlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjBCNlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:41:23 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C0412F15;
        Fri,  3 Feb 2023 05:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675431680; x=1706967680;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3eYI3e/ZTu5G0g9in3jd2vyV9lR37cDnjIp0K+JxVrs=;
  b=hWyOFRHGSMoY0tkq8klcsGFLGDQM9wgmFuZ3/WwGaC5CbqPPCRlvMSNH
   S/McXtEEf2QFGnmytJyI0HRQO81ooOSO9rUKgOA3yh9bLwRLg7G8Zbp7y
   G8Pxlk07cfd+ZxEaNtj/25BOEhyVfID7kq/y4LfDNQ0UySJnjgNMwjVnV
   YDVUkc2tsJFCU1bU5+B1d2z6pnexYzKvxr2bPJVOnAqARsorzyG8MgVGp
   eY04X0Uyu5TZfsLyxkRKuyV9Mm80jEN32OEk0wjXyKmcFEnkyYKltSJZJ
   1XnZTlIwdUDKdlPnD2HEeexfx2TNQzKOonMdZvBGWDrcADnewmMzkumhr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="312403648"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="312403648"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 05:41:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="698071403"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="698071403"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.88])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 05:41:17 -0800
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@intel.com,
        hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajat.khandelwal@intel.com,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH v3] platform/x86/intel/pmc: core: Add support to show LTR-ignored components
Date:   Sat,  4 Feb 2023 19:13:27 +0530
Message-Id: <20230204134327.412086-1-rajat.khandelwal@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, 'ltr_ignore' sysfs attribute, when read, returns nothing, even
if there are components whose LTR values have been ignored.

This patch adds the feature to print out such components, if they exist.

Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
---

v3: Incorporated a mutex lock for accessing 'ltr_ignore_list'

v2: kmalloc -> devm_kmalloc

 drivers/platform/x86/intel/pmc/core.c | 56 +++++++++++++++++++++------
 drivers/platform/x86/intel/pmc/core.h |  2 +-
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 3a15d32d7644..31d649d8ce12 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -53,6 +53,17 @@ const struct pmc_bit_map msr_map[] = {
 	{}
 };
 
+/* Mutual exclusion to access the list of LTR-ignored components */
+static DEFINE_MUTEX(ltr_entry_mutex);
+
+struct ltr_entry {
+	u32 comp_index;
+	const char *comp_name;
+	struct list_head node;
+};
+
+static LIST_HEAD(ltr_ignore_list);
+
 static inline u32 pmc_core_reg_read(struct pmc_dev *pmcdev, int reg_offset)
 {
 	return readl(pmcdev->regbase + reg_offset);
@@ -435,27 +446,18 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
 
-int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
+void pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
 {
 	const struct pmc_reg_map *map = pmcdev->map;
 	u32 reg;
-	int err = 0;
 
 	mutex_lock(&pmcdev->lock);
 
-	if (value > map->ltr_ignore_max) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
-
 	reg = pmc_core_reg_read(pmcdev, map->ltr_ignore_offset);
 	reg |= BIT(value);
 	pmc_core_reg_write(pmcdev, map->ltr_ignore_offset, reg);
 
-out_unlock:
 	mutex_unlock(&pmcdev->lock);
-
-	return err;
 }
 
 static ssize_t pmc_core_ltr_ignore_write(struct file *file,
@@ -464,6 +466,8 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file,
 {
 	struct seq_file *s = file->private_data;
 	struct pmc_dev *pmcdev = s->private;
+	const struct pmc_reg_map *map = pmcdev->map;
+	struct ltr_entry *entry;
 	u32 buf_size, value;
 	int err;
 
@@ -473,13 +477,41 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file,
 	if (err)
 		return err;
 
-	err = pmc_core_send_ltr_ignore(pmcdev, value);
+	if (value > map->ltr_ignore_max)
+		return -EINVAL;
+
+	mutex_lock(&ltr_entry_mutex);
+
+	list_for_each_entry(entry, &ltr_ignore_list, node) {
+		if (entry->comp_index == value)
+			return -EEXIST;
+	}
+
+	entry = devm_kmalloc(&pmcdev->pdev->dev, sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->comp_name = map->ltr_show_sts[value].name;
+	entry->comp_index = value;
+	list_add_tail(&entry->node, &ltr_ignore_list);
 
-	return err == 0 ? count : err;
+	mutex_unlock(&ltr_entry_mutex);
+
+	pmc_core_send_ltr_ignore(pmcdev, value);
+
+	return count;
 }
 
 static int pmc_core_ltr_ignore_show(struct seq_file *s, void *unused)
 {
+	struct ltr_entry *entry;
+
+	mutex_lock(&ltr_entry_mutex);
+	list_for_each_entry(entry, &ltr_ignore_list, node) {
+		seq_printf(s, "%s\n", entry->comp_name);
+	}
+	mutex_unlock(&ltr_entry_mutex);
+
 	return 0;
 }
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 810204d758ab..da35b0fcbe6e 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -396,7 +396,7 @@ extern const struct pmc_reg_map adl_reg_map;
 extern const struct pmc_reg_map mtl_reg_map;
 
 extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
-extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
+extern void pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
 
 void spt_core_init(struct pmc_dev *pmcdev);
 void cnp_core_init(struct pmc_dev *pmcdev);
-- 
2.34.1

