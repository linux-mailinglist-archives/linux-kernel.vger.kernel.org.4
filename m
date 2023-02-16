Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B522699581
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjBPNQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjBPNQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:16:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BACE3AF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676553404; x=1708089404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sEeJE3lb+SBSL58VtACxqpXosFpusquhp6qgy5s/iGw=;
  b=T1XUAA3MWPFDgdtiknMKjYTjsN67QMu1fm75Ss7Fo18F1unez2T5iiYf
   0Dwfu8Ql44DkonqeguWvUqWnsqh64swH4Lbqoj+6EK9oGdn4i/jSO7c0q
   qLlW4bW1Th5zV1dVi8IWmE4PtCur+a6E9QYbYBVj9WAXcGqJeb1u3XO9M
   TlFLt0o7weXbZ6Zz3GazEVRNySsxhnda+pXmkJ+LQwE4uKD2BUq0CeiXW
   JGrvwesUcJOPsrdY6fcFSsYBXZa2WjF2fMjP/bqwGV90HiyEdxMtM3XKV
   v9h96zAuXhT4AhhmHqxwFKkz5uZ5MWV+4ECLcrY2RZ3H5XnjxNb+tV/gG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333883295"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="333883295"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:16:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="647674924"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="647674924"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 16 Feb 2023 05:16:42 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iommu/vt-d: Fix error handling in sva enable/disable paths
Date:   Thu, 16 Feb 2023 21:08:13 +0800
Message-Id: <20230216130816.151824-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216130816.151824-1-baolu.lu@linux.intel.com>
References: <20230216130816.151824-1-baolu.lu@linux.intel.com>
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230208051559.700109-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 59df7e42fd53..994dffa1db57 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4642,8 +4642,12 @@ static int intel_iommu_enable_sva(struct device *dev)
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
@@ -4655,8 +4659,12 @@ static int intel_iommu_disable_sva(struct device *dev)
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

