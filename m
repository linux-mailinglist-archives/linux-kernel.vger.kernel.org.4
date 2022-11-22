Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2247F633165
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiKVAhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiKVAg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:36:56 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFBFC6BDC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669077415; x=1700613415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y5vGwIPPwSenb40glub36iuftmDSZwrpt1MHtGFliyk=;
  b=hvn3AI0IIBrqZDbB93amfkxjq29cYMgANVkVu4Sy7qMMFNqqwj51CkNM
   Wfk+GZV5SWc/Ue+xhA9SKUt3A3KUT5D2nExfUTfkVnIJof2bViInxXTrT
   ea7V7lLMssmHUp5hNYwjrr6ZB2HHBddFKQOfGythntbyG0UtX0lPL5iet
   aUIN4ATQBtt/TICw3Zc4AzJiPmfuXU+Hru9eK76a672i7sBOWKv0/OiUB
   6xowp9WAJ6pksY7II8YDHMzA+Q1Q6PjGXuMWdo6r/jCB0IauMfG+uQ6DB
   2omxNLuzB+JSa8J95R1UjpjlxIoDiKLzy6V6hiEbpHH83rLZwV/E5q7Gu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="315516471"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="315516471"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 16:36:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="619018415"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="619018415"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 21 Nov 2022 16:36:54 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] iommu/vt-d: Allocate pasid table in device probe path
Date:   Tue, 22 Nov 2022 08:29:43 +0800
Message-Id: <20221122002949.148140-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221122002949.148140-1-baolu.lu@linux.intel.com>
References: <20221122002949.148140-1-baolu.lu@linux.intel.com>
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

Whether or not a domain is attached to the device, the pasid table should
always be valid as long as it has been probed. This moves the pasid table
allocation from the domain attaching device path to device probe path and
frees it in the device release path.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20221118132451.114406-2-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a122f5b84ad4..dea0190acc86 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2475,13 +2475,6 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
-		ret = intel_pasid_alloc_table(dev);
-		if (ret) {
-			dev_err(dev, "PASID table allocation failed\n");
-			dmar_remove_one_dev_info(dev);
-			return ret;
-		}
-
 		/* Setup the PASID entry for requests without PASID: */
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
@@ -4106,7 +4099,6 @@ static void dmar_remove_one_dev_info(struct device *dev)
 
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(info);
-		intel_pasid_free_table(info->dev);
 	}
 
 	spin_lock_irqsave(&domain->lock, flags);
@@ -4464,6 +4456,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	struct device_domain_info *info;
 	struct intel_iommu *iommu;
 	u8 bus, devfn;
+	int ret;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu || !iommu->iommu.ops)
@@ -4507,6 +4500,16 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	dev_iommu_priv_set(dev, info);
 
+	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
+		ret = intel_pasid_alloc_table(dev);
+		if (ret) {
+			dev_err(dev, "PASID table allocation failed\n");
+			dev_iommu_priv_set(dev, NULL);
+			kfree(info);
+			return ERR_PTR(ret);
+		}
+	}
+
 	return &iommu->iommu;
 }
 
@@ -4515,6 +4518,7 @@ static void intel_iommu_release_device(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
 	dmar_remove_one_dev_info(dev);
+	intel_pasid_free_table(dev);
 	dev_iommu_priv_set(dev, NULL);
 	kfree(info);
 	set_dma_ops(dev, NULL);
-- 
2.34.1

