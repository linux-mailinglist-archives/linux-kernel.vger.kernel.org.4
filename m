Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C7A6E05BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDMEHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjDMEGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:06:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E14676A2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358813; x=1712894813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UfvO6KWRpB3fInOz1odZU3ajkyQZJiVnPHFd0TJPDQ4=;
  b=l57rlOs4lRXdO8U3cFcRXOpN3juonVwGIYlnaqQochJOL0cfNxK/qesi
   lmwbTbgmuFtDAffyN399FPFUUiFf6K3LCStyl6praJgpDe5WeDYTVgnJQ
   aFf12M08OKQ877p1CTPCL+NYZAsZb/TeU1gd/0IHaG3s5loA3V4a8Gfc4
   To+aM1L7jwlwqAvA10ZieEsLLA/eyBjUX+IYZMoNzyD+PFbp4SXwYtFSQ
   JMZUng2TxL1VV99+jGZhK6neAR30ltSAT5Rsl5lxVYC5Pv+KpJsR4N7Rh
   +6WgV2SxvgPk6u1dZ1igUv8c84CB6bCWrLqMybRZceZCwMSoVOw2k+gcy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323702324"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="323702324"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:06:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935360963"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935360963"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:06:43 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/17] dmaengine: idxd: Add enable/disable device IOPF feature
Date:   Thu, 13 Apr 2023 12:06:29 +0800
Message-Id: <20230413040645.46157-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413040645.46157-1-baolu.lu@linux.intel.com>
References: <20230413040645.46157-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu subsystem requires IOMMU_DEV_FEAT_IOPF must be enabled before
and disabled after IOMMU_DEV_FEAT_SVA, if device's I/O page faults rely
on the IOMMU. Add explicit IOMMU_DEV_FEAT_IOPF enabling/disabling in this
driver.

At present, missing IOPF enabling/disabling doesn't cause any real issue,
because the IOMMU driver places the IOPF enabling/disabling in the path
of SVA feature handling. But this may change.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230324120234.313643-2-baolu.lu@linux.intel.com
---
 drivers/dma/idxd/init.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 640d3048368e..09ef62aa0635 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -516,6 +516,27 @@ static void idxd_disable_system_pasid(struct idxd_device *idxd)
 	idxd->sva = NULL;
 }
 
+static int idxd_enable_sva(struct pci_dev *pdev)
+{
+	int ret;
+
+	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
+	if (ret)
+		return ret;
+
+	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
+	if (ret)
+		iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
+
+	return ret;
+}
+
+static void idxd_disable_sva(struct pci_dev *pdev)
+{
+	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
+	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
+}
+
 static int idxd_probe(struct idxd_device *idxd)
 {
 	struct pci_dev *pdev = idxd->pdev;
@@ -530,7 +551,7 @@ static int idxd_probe(struct idxd_device *idxd)
 	dev_dbg(dev, "IDXD reset complete\n");
 
 	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
-		if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA)) {
+		if (idxd_enable_sva(pdev)) {
 			dev_warn(dev, "Unable to turn on user SVA feature.\n");
 		} else {
 			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
@@ -578,21 +599,19 @@ static int idxd_probe(struct idxd_device *idxd)
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
 	if (device_user_pasid_enabled(idxd))
-		iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
+		idxd_disable_sva(pdev);
 	return rc;
 }
 
 static void idxd_cleanup(struct idxd_device *idxd)
 {
-	struct device *dev = &idxd->pdev->dev;
-
 	perfmon_pmu_remove(idxd);
 	idxd_cleanup_interrupts(idxd);
 	idxd_cleanup_internals(idxd);
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
 	if (device_user_pasid_enabled(idxd))
-		iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
+		idxd_disable_sva(idxd->pdev);
 }
 
 static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -710,7 +729,7 @@ static void idxd_remove(struct pci_dev *pdev)
 	pci_free_irq_vectors(pdev);
 	pci_iounmap(pdev, idxd->reg_base);
 	if (device_user_pasid_enabled(idxd))
-		iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
+		idxd_disable_sva(pdev);
 	pci_disable_device(pdev);
 	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
-- 
2.34.1

