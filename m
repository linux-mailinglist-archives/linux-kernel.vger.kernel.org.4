Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA866E05BA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDMEHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjDMEGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:06:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566787AB5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358813; x=1712894813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zGpEfMgloBsWMUOjxE9fyxNifshGPev/lcFUTQ3YvYY=;
  b=jgUhg5ggWOmI+TMIKGAb8h6C1HH8IkbjOnMvgGjwABH80EWzpjYBWy+t
   O5xFVSdXTvxCYt4xiISU3TWa883tTr+apfZB7lJLZkiQ7zLqGHEH+CtzS
   Kq97mUDfg4TmHBKVPD08RjL7RjprFgTTUIvaxlrpmT+ATd9ceHK7TxKfu
   VEDwdJPrgh/YC7edgxJVpNEIfks2yrMVQCtoqI5vQzxKA7UC0Tts1M/V1
   IXSynZyK3DEPgkKICN4iOqaVZEO1rJuwa7p6nYsPMCB7R5i1rUS/5hylK
   VBtZ/3YXAbz9oriAsjfnIgWexyIjWzSIT/uTVHDB3DForCt5mpFrg4bq2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332786551"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332786551"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:06:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935360996"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935360996"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:06:50 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/17] iommu/vt-d: Move PRI handling to IOPF feature path
Date:   Thu, 13 Apr 2023 12:06:33 +0800
Message-Id: <20230413040645.46157-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413040645.46157-1-baolu.lu@linux.intel.com>
References: <20230413040645.46157-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PRI is only used for IOPF. With this move, the PCI/PRI feature could be
controlled by the device driver through iommu_dev_enable/disable_feature()
interfaces.

Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230324120234.313643-6-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 53 ++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6d77b4072fdd..cd3a3c4b5e64 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1415,11 +1415,6 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 	if (info->pasid_supported && !pci_enable_pasid(pdev, info->pasid_supported & ~1))
 		info->pasid_enabled = 1;
 
-	if (info->pri_supported &&
-	    (info->pasid_enabled ? pci_prg_resp_pasid_required(pdev) : 1)  &&
-	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, PRQ_DEPTH))
-		info->pri_enabled = 1;
-
 	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
 	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
@@ -1442,11 +1437,6 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
 		domain_update_iotlb(info->domain);
 	}
 
-	if (info->pri_enabled) {
-		pci_disable_pri(pdev);
-		info->pri_enabled = 0;
-	}
-
 	if (info->pasid_enabled) {
 		pci_disable_pasid(pdev);
 		info->pasid_enabled = 0;
@@ -4667,23 +4657,48 @@ static int intel_iommu_enable_sva(struct device *dev)
 
 static int intel_iommu_enable_iopf(struct device *dev)
 {
+	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
 	int ret;
 
-	if (!info || !info->ats_enabled || !info->pri_enabled)
+	if (!pdev || !info || !info->ats_enabled || !info->pri_supported)
 		return -ENODEV;
+
+	if (info->pri_enabled)
+		return -EBUSY;
+
 	iommu = info->iommu;
 	if (!iommu)
 		return -EINVAL;
 
+	/* PASID is required in PRG Response Message. */
+	if (info->pasid_enabled && !pci_prg_resp_pasid_required(pdev))
+		return -EINVAL;
+
+	ret = pci_reset_pri(pdev);
+	if (ret)
+		return ret;
+
 	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
 	if (ret)
 		return ret;
 
 	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
 	if (ret)
-		iopf_queue_remove_device(iommu->iopf_queue, dev);
+		goto iopf_remove_device;
+
+	ret = pci_enable_pri(pdev, PRQ_DEPTH);
+	if (ret)
+		goto iopf_unregister_handler;
+	info->pri_enabled = 1;
+
+	return 0;
+
+iopf_unregister_handler:
+	iommu_unregister_device_fault_handler(dev);
+iopf_remove_device:
+	iopf_queue_remove_device(iommu->iopf_queue, dev);
 
 	return ret;
 }
@@ -4694,6 +4709,20 @@ static int intel_iommu_disable_iopf(struct device *dev)
 	struct intel_iommu *iommu = info->iommu;
 	int ret;
 
+	if (!info->pri_enabled)
+		return -EINVAL;
+
+	/*
+	 * PCIe spec states that by clearing PRI enable bit, the Page
+	 * Request Interface will not issue new page requests, but has
+	 * outstanding page requests that have been transmitted or are
+	 * queued for transmission. This is supposed to be called after
+	 * the device driver has stopped DMA, all PASIDs have been
+	 * unbound and the outstanding PRQs have been drained.
+	 */
+	pci_disable_pri(to_pci_dev(dev));
+	info->pri_enabled = 0;
+
 	ret = iommu_unregister_device_fault_handler(dev);
 	if (ret)
 		return ret;
-- 
2.34.1

