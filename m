Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564FA6DD362
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjDKGts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjDKGtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:49:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED093C00
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195734; x=1712731734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sDMJTalig0nzuhTIrI4QQ+mFyR3+Py8XwH5/FAztKD8=;
  b=PX8tR4A/a6qiofo1J0yikA1lOt+pphZCIffvIeq4NNrjm/tJp2gXgRWt
   nyWSSpp95c71fiwGa5SxdPQBlhoCnHhcejSPhstpLR9HSj4GyUEK88tGm
   40R3Ux91WJlMpSLYPPbd+DjmCpUUBHDGH60AlLAKcazVakckggKodhpD1
   gQ9hVyi+XCnsUhiirj4mp8MItk9lLBAdkU6w/v8LZRN7/xV18O5BSW3cM
   bsOUduwx309ZKUe+P8NYZOE1XZucmaHvbC0cZ/rtC4kPxLd+N2Ux0LWLF
   hwUcyBWkKef4522qWX9DH+0ra4VM1OKWfys7YmT4r+y2txI1K95VcebtI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028540"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028540"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256574"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256574"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:22 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/17] iommu/vt-d: Remove unnecessary checks in iopf disabling path
Date:   Tue, 11 Apr 2023 14:48:04 +0800
Message-Id: <20230411064815.31456-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411064815.31456-1-baolu.lu@linux.intel.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu_unregister_device_fault_handler() and iopf_queue_remove_device()
are called after device has stopped issuing new page falut requests and
all outstanding page requests have been drained. They should never fail.
Trigger a warning if it happens unfortunately.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230324120234.313643-7-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cd3a3c4b5e64..c771233d6f2a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4707,7 +4707,6 @@ static int intel_iommu_disable_iopf(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
-	int ret;
 
 	if (!info->pri_enabled)
 		return -EINVAL;
@@ -4723,15 +4722,15 @@ static int intel_iommu_disable_iopf(struct device *dev)
 	pci_disable_pri(to_pci_dev(dev));
 	info->pri_enabled = 0;
 
-	ret = iommu_unregister_device_fault_handler(dev);
-	if (ret)
-		return ret;
-
-	ret = iopf_queue_remove_device(iommu->iopf_queue, dev);
-	if (ret)
-		iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	/*
+	 * With PRI disabled and outstanding PRQs drained, unregistering
+	 * fault handler and removing device from iopf queue should never
+	 * fail.
+	 */
+	WARN_ON(iommu_unregister_device_fault_handler(dev));
+	WARN_ON(iopf_queue_remove_device(iommu->iopf_queue, dev));
 
-	return ret;
+	return 0;
 }
 
 static int
-- 
2.34.1

