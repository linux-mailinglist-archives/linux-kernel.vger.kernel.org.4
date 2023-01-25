Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683B967B2B5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbjAYMn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbjAYMnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:43:25 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131D72E0F9;
        Wed, 25 Jan 2023 04:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674650600; x=1706186600;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7xlAOKZg/CWOOSXfjkaPp3PCI9MEqMPNFAOGBRGha+A=;
  b=jlNfcB9HVaMIvyFt3dUYIWCivLS7Ttdc1BlXWGfJmGX+iq20b2Dh1CMp
   WlkYar9ThhHlBa8QqIa+Kujx1LfUU8Gq3fIbU28UsyehZo1enGCiBYFd7
   D/YjtaEKA9UlWZFA4TTnArdo5x1TNg+R7b7GphGd/LSwJbwm41QIenhJM
   3OVw5TfAkpq7iA/KVehMmHLb5NvCls8b6HNKT9Uidq0TFSmVVhZiRLpxu
   O4wNwrx91jOMho/xyW2UQibOceWRkUHY3gb23R7W/QWFNhAZi01b+Cq5m
   YYZ+JwFUStTen/FBP+C7VGl1YWTtxImA5GUIKXHeNMeYudOS/FG2rs11P
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="306894497"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="306894497"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 04:43:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="836334603"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="836334603"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.88])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 04:43:16 -0800
From:   Rajat Khandelwal <rajat.khandelwal@intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@intel.com,
        hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajat.khandelwal@intel.com,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH v2] platform/x86/intel/pmc: core: Add support to show LTR-ignored components
Date:   Wed, 25 Jan 2023 18:13:01 +0530
Message-Id: <20230125124301.1366990-1-rajat.khandelwal@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>

Currently, 'ltr_ignore' sysfs attribute, when read, returns nothing, even
if there are components whose LTR values have been ignored.

This patch adds the feature to print out such components, if they exist.

Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
---

v2: kmalloc -> devm_kmalloc

 drivers/platform/x86/intel/pmc/core.c | 47 ++++++++++++++++++++-------
 drivers/platform/x86/intel/pmc/core.h |  2 +-
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 3a15d32d7644..d4196b10b8af 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -53,6 +53,14 @@ const struct pmc_bit_map msr_map[] = {
 	{}
 };
 
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
@@ -435,27 +443,18 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
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
@@ -464,6 +463,8 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file,
 {
 	struct seq_file *s = file->private_data;
 	struct pmc_dev *pmcdev = s->private;
+	const struct pmc_reg_map *map = pmcdev->map;
+	struct ltr_entry *entry;
 	u32 buf_size, value;
 	int err;
 
@@ -473,13 +474,35 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file,
 	if (err)
 		return err;
 
-	err = pmc_core_send_ltr_ignore(pmcdev, value);
+	if (value > map->ltr_ignore_max)
+		return -EINVAL;
 
-	return err == 0 ? count : err;
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
+
+	pmc_core_send_ltr_ignore(pmcdev, value);
+
+	return count;
 }
 
 static int pmc_core_ltr_ignore_show(struct seq_file *s, void *unused)
 {
+	struct ltr_entry *entry;
+
+	list_for_each_entry(entry, &ltr_ignore_list, node) {
+		seq_printf(s, "%s\n", entry->comp_name);
+	}
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

