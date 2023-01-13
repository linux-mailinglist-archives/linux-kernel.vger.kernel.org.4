Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988D166996F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241434AbjAMOEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbjAMOD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:03:27 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AA410FDF;
        Fri, 13 Jan 2023 06:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673618533; x=1705154533;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X8yP8ue7Mjwmum3hdTB2a0jxS4tJ1ITCtpEQuehUOg8=;
  b=YeoyMKE/sWguMTH9nDKeSlXsCU0HA9HMWEnsgmcmHBFbWjQ2aKG/nMUe
   lVw+9E5q353OLCJBhWCTK+iQdN0gt2kmPP2nUvBTvgUsSh8LVo/sK3XVB
   qaSKYvAE3oAXonq9XgWVFeZxTLcdE61dxNqLd5EFPqwot73f+ne8mCs8/
   jYrtgLAV9yA6uaGWmcJxMpiyTkjHyYWSaR8Jcr+MUEETgY8M8ZhSvWXek
   zxEfRwaQplOv8HPU0EsZBhHlF04+aSPEYIC6x/fOIwhZUqyVUcZShwL3R
   Q3J7bst04VWNmOgkQK5Gs4kefqKBhMkZEZ6VSdnypHrmTyVY67q9RSl/1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="388492989"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="388492989"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 06:02:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="987008075"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="987008075"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.88])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 06:02:09 -0800
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@intel.com,
        hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajat.khandelwal@intel.com,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH] platform/x86/intel/pmc: core: Add support to show LTR-ignored components
Date:   Fri, 13 Jan 2023 19:32:12 +0530
Message-Id: <20230113140212.3905361-1-rajat.khandelwal@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/platform/x86/intel/pmc/core.c | 47 ++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index a1fe1e0dcf4a..30fff4461807 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -129,6 +129,14 @@ static const struct pmc_bit_map *ext_spt_pfear_map[] = {
 	NULL
 };
 
+struct ltr_entry {
+	u32 comp_index;
+	const char *comp_name;
+	struct list_head node;
+};
+
+static LIST_HEAD(ltr_ignore_list);
+
 static const struct pmc_bit_map spt_ltr_show_map[] = {
 	{"SOUTHPORT_A",		SPT_PMC_LTR_SPA},
 	{"SOUTHPORT_B",		SPT_PMC_LTR_SPB},
@@ -1327,27 +1335,18 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
 
-static int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
+static void pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
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
@@ -1356,6 +1355,8 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file,
 {
 	struct seq_file *s = file->private_data;
 	struct pmc_dev *pmcdev = s->private;
+	const struct pmc_reg_map *map = pmcdev->map;
+	struct ltr_entry *entry;
 	u32 buf_size, value;
 	int err;
 
@@ -1365,13 +1366,35 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file,
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
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
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
 
-- 
2.34.1

