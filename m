Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3F66E05BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjDMEHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDMEG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:06:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEF16EB7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358814; x=1712894814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sDMJTalig0nzuhTIrI4QQ+mFyR3+Py8XwH5/FAztKD8=;
  b=U1jC3xrlnqfu5MAydoz4vItj8kYmboqqc720XumjJJN5MsClA7SwueWD
   KcfWOEhcwa2beHway58KVBZUjDN7u8xlZ3nxPEFOIvPQCvbPJTZv8XFJl
   IqHo4v1vxrZpDR7XrEQmTbT0Oy5dhrfwKz+5cVuc7MjFrF9bmWk30bNKB
   FIEVYxq/Z6tlhhI6aZP+ct008e64oqtLqmGLpMmV3Tg14VFHnjWTzJU47
   Jeq26kQe4CFAVNR+0o5SbK8J/cuOgF0TZ+L7EF01ecWrIYPH+VVTKFV2Z
   FHfsSBcosa4bhP3xXJT/l9KWWKReWyj+UrcE0fYlEmE7izU0DTOyeJ3Z4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332786564"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332786564"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:06:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935361006"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935361006"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:06:52 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/17] iommu/vt-d: Remove unnecessary checks in iopf disabling path
Date:   Thu, 13 Apr 2023 12:06:34 +0800
Message-Id: <20230413040645.46157-7-baolu.lu@linux.intel.com>
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

