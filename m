Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F16A68E776
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 06:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjBHFY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 00:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBHFYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 00:24:25 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D9535AE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 21:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675833864; x=1707369864;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dU7w0TBrSrIdIYJms8Qb9NuKI4fw5vUjPE8FdmU+g/s=;
  b=NINetG02ERaPJ6nKF9xPTQuAHtja4E+baS+iCh0XsAVbNbK29omQqy23
   st11CKcUACw22hllpTMfBikzk9LWbmsSVoBFSjAhJ4ibn5WNdCe7YvjLE
   qsQ5dST3mjQEAlAHamwvVDm5MnMLxh5oJr6eJP4q0HpjPvJV/DLNuln6F
   2QC5wVMFX3eka+eM5HyedG4ctn0U6OZNnaG7vdvKFr66K/E4H6zli2eYv
   qZxPW7Pzud9Fyw+LQQ9qnKJqLaaAPbFuhw1Q8ZStTUngVdYap+VHYcB73
   4EZNlx8wsO44AYlJrFHSsSq33fbnTbb3+a6QVdFM9HCztPcZwlw9/GuZx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="329741325"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="329741325"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 21:24:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="841045809"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="841045809"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 07 Feb 2023 21:24:22 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Fix error handling in sva enable/disable paths
Date:   Wed,  8 Feb 2023 13:15:59 +0800
Message-Id: <20230208051559.700109-1-baolu.lu@linux.intel.com>
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

Roll back all previous actions in error paths of intel_iommu_enable_sva()
and intel_iommu_disable_sva().

Fixes: d5b9e4bfe0d8 ("iommu/vt-d: Report prq to io-pgfault framework")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a049178cd9f8..36d1867159d7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4650,8 +4650,12 @@ static int intel_iommu_enable_sva(struct device *dev)
 		return -EINVAL;
 
 	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
-	if (!ret)
-		ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	if (ret)
+		return ret;
+
+	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	if (ret)
+		iopf_queue_remove_device(iommu->iopf_queue, dev);
 
 	return ret;
 }
@@ -4663,8 +4667,12 @@ static int intel_iommu_disable_sva(struct device *dev)
 	int ret;
 
 	ret = iommu_unregister_device_fault_handler(dev);
-	if (!ret)
-		ret = iopf_queue_remove_device(iommu->iopf_queue, dev);
+	if (ret)
+		return ret;
+
+	ret = iopf_queue_remove_device(iommu->iopf_queue, dev);
+	if (ret)
+		iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
 
 	return ret;
 }
-- 
2.34.1

