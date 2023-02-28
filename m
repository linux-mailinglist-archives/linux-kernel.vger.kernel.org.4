Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E396A5C86
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjB1P4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjB1P4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:56:40 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE7531E36;
        Tue, 28 Feb 2023 07:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677599750; x=1709135750;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xLC5mKkE/LXMOQ1pQVWUc4onWv0C2ecP8VL2usU2Bnk=;
  b=GQg5860qQzLlNjz/8blzv67VR/mAfyRkEl79KwOnsjRsuDxD6UNspA+D
   9WEHoIJ6gzSFJ9k/Zmmr9CAIsz4XZ6qqxzm8zRYQkpavvFeHefXb1ABJR
   21iT53sx5lsU5yfhokGDhBw0qAl13ovBYYRjCpgHYa9cZ8PHdPwgXNQ/U
   EScHOCCeFf6LoTUb+7HwV3BW/nOKJUNynu8mHOZ1pr7YTvDpusqlMWbCm
   1/3xBn1VeviKlMYzkiDlHxw0mIvNiPXOZDAvVXkGQMNxKk5CvMm4ix/fn
   clFib4WeFbLW0wWt0ISEomq30Wh+WAS6FkyXEX4AunybDtpDeCm4rglFW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="317970801"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="317970801"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 07:55:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="848286518"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="848286518"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.88])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 07:55:37 -0800
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@intel.com,
        hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajat.khandelwal@intel.com,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH v6] platform/x86/intel/pmc: core: Add support to show LTR-ignored components
Date:   Wed,  1 Mar 2023 21:27:57 +0530
Message-Id: <20230301155757.1293131-1-rajat.khandelwal@linux.intel.com>
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

Make the sysfs attribute print out such components, if they exist, and
return EEXIST, if tried to set an already ignored component.

Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
---

v6: Description written in imperative sense

v5:
1. Ignore the LTR of the respective component after unlocking the mutex lock
2. Adding error code details to the commit message

v4: Mutex unlock during error conditions

v3: Incorporated a mutex lock for accessing 'ltr_ignore_list'

v2: kmalloc -> devm_kmalloc

 drivers/platform/x86/intel/pmc/core.c | 64 ++++++++++++++++++++++-----
 drivers/platform/x86/intel/pmc/core.h |  2 +-
 2 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 3a15d32d7644..16cf6c634db8 100644
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
 
@@ -473,13 +477,49 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file,
 	if (err)
 		return err;
 
-	err = pmc_core_send_ltr_ignore(pmcdev, value);
+	if (value > map->ltr_ignore_max)
+		return -EINVAL;
+
+	mutex_lock(&ltr_entry_mutex);
+
+	list_for_each_entry(entry, &ltr_ignore_list, node) {
+		if (entry->comp_index == value) {
+			err = -EEXIST;
+			goto out_unlock;
+		}
+	}
+
+	entry = devm_kmalloc(&pmcdev->pdev->dev, sizeof(*entry), GFP_KERNEL);
+	if (!entry) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	entry->comp_name = map->ltr_show_sts[value].name;
+	entry->comp_index = value;
+	list_add_tail(&entry->node, &ltr_ignore_list);
+
+out_unlock:
+	mutex_unlock(&ltr_entry_mutex);
+
+	if (err)
+		return err;
+
+	pmc_core_send_ltr_ignore(pmcdev, value);
 
-	return err == 0 ? count : err;
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

