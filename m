Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6969D74E2FE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjGKBJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjGKBJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:09:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D9D1BC;
        Mon, 10 Jul 2023 18:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689037735; x=1720573735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HDO/3SJrjs+J31UeSjn79Qj5Ue9JvEOiFH2FjTHY2ts=;
  b=i4Pl+QTkVVwXGp4WyejyWSMcw82NkZBlcgEKRyidW5J+B+Q9ki8JIbpU
   BhOoQlgSj7W3BtT6Aso7QCEkZFaokUi25glkOn7U7tZRESTdRsM1aMbj5
   ItG4KFk/QbzsmKivPVVUWd9ODNHtcu60fBDxVxICBgYy0i38wnULl6gFM
   lz71j3YNpN6uHM7bVsHhuhZU2pgri5PBqHmYnMTlS5rdu0uS0faIO3csO
   VzTzozOMDnHQf7EtOQykwc2eKx4rc2HhRUXMEH3RvAabv8HTEKiL8/yBW
   dt/jClzZPasPoA85VP9xpFIoFICKVzoD5Zwf9HVKUDgTzATSm8TmqUxyA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="344816109"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="344816109"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 18:08:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="810999890"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="810999890"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2023 18:08:51 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 5/9] iommu: Make fault_param generic
Date:   Tue, 11 Jul 2023 09:06:38 +0800
Message-Id: <20230711010642.19707-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711010642.19707-1-baolu.lu@linux.intel.com>
References: <20230711010642.19707-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu faults, including recoverable faults (IO page faults) and
unrecoverable faults (DMA faults), are generic to all devices. The
iommu faults could possibly be triggered for every device.

The fault_param pointer under struct dev_iommu is the per-device fault
data. Therefore, the fault_param pointer should be allocated during
iommu device probe and freed when the device is released.

With this done, the individual iommu drivers that support iopf have no
need to call iommu_[un]register_device_fault_handler() any more.
This will make it easier for the iommu drivers to support iopf, and it
will also make the fault_param allocation and free simpler.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 13 +------------
 drivers/iommu/intel/iommu.c                    | 18 ++++--------------
 drivers/iommu/iommu.c                          | 14 ++++++++++++++
 3 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a5a63b1c947e..fa8ab9d413f8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -437,7 +437,6 @@ bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master)
 
 static int arm_smmu_master_sva_enable_iopf(struct arm_smmu_master *master)
 {
-	int ret;
 	struct device *dev = master->dev;
 
 	/*
@@ -450,16 +449,7 @@ static int arm_smmu_master_sva_enable_iopf(struct arm_smmu_master *master)
 	if (!master->iopf_enabled)
 		return -EINVAL;
 
-	ret = iopf_queue_add_device(master->smmu->evtq.iopf, dev);
-	if (ret)
-		return ret;
-
-	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
-	if (ret) {
-		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
-		return ret;
-	}
-	return 0;
+	return iopf_queue_add_device(master->smmu->evtq.iopf, dev);
 }
 
 static void arm_smmu_master_sva_disable_iopf(struct arm_smmu_master *master)
@@ -469,7 +459,6 @@ static void arm_smmu_master_sva_disable_iopf(struct arm_smmu_master *master)
 	if (!master->iopf_enabled)
 		return;
 
-	iommu_unregister_device_fault_handler(dev);
 	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 }
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5c8c5cdc36cf..22e43db20252 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4594,23 +4594,14 @@ static int intel_iommu_enable_iopf(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
-	if (ret)
-		goto iopf_remove_device;
-
 	ret = pci_enable_pri(pdev, PRQ_DEPTH);
-	if (ret)
-		goto iopf_unregister_handler;
+	if (ret) {
+		iopf_queue_remove_device(iommu->iopf_queue, dev);
+		return ret;
+	}
 	info->pri_enabled = 1;
 
 	return 0;
-
-iopf_unregister_handler:
-	iommu_unregister_device_fault_handler(dev);
-iopf_remove_device:
-	iopf_queue_remove_device(iommu->iopf_queue, dev);
-
-	return ret;
 }
 
 static int intel_iommu_disable_iopf(struct device *dev)
@@ -4637,7 +4628,6 @@ static int intel_iommu_disable_iopf(struct device *dev)
 	 * fault handler and removing device from iopf queue should never
 	 * fail.
 	 */
-	WARN_ON(iommu_unregister_device_fault_handler(dev));
 	WARN_ON(iopf_queue_remove_device(iommu->iopf_queue, dev));
 
 	return 0;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 65895b987e22..8d1f0935ea71 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -299,7 +299,15 @@ static int dev_iommu_get(struct device *dev)
 		return -ENOMEM;
 
 	mutex_init(&param->lock);
+	param->fault_param = kzalloc(sizeof(*param->fault_param), GFP_KERNEL);
+	if (!param->fault_param) {
+		kfree(param);
+		return -ENOMEM;
+	}
+	mutex_init(&param->fault_param->lock);
+	INIT_LIST_HEAD(&param->fault_param->faults);
 	dev->iommu = param;
+
 	return 0;
 }
 
@@ -312,6 +320,12 @@ static void dev_iommu_free(struct device *dev)
 		fwnode_handle_put(param->fwspec->iommu_fwnode);
 		kfree(param->fwspec);
 	}
+	/*
+	 * All pending faults should have been drained before
+	 * device release.
+	 */
+	WARN_ON_ONCE(!list_empty(&param->fault_param->faults));
+	kfree(param->fault_param);
 	kfree(param);
 }
 
-- 
2.34.1

