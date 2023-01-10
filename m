Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A1E663798
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 04:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbjAJDC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 22:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjAJDCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 22:02:21 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1436101F4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 19:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673319740; x=1704855740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Tijr/4QI/5wm5a8OGrbuYSXtQlU7vZNbvtCrm37JhA=;
  b=a7iRSMAYGR6w1X1A1mqz00umRy7EKj7+BqztFirhMqJl8K16oxN44pUG
   9rEQq1Klj69kFXDKB7KJm7TbEWFDk2+DH6PH7yGHQTja8U57rNXcf0PYv
   SRH9Qil0cMRCvtDOmikPd/3X+6UxfuzBCX6kzjSNWQmANI9npJpcoOHHB
   DTHZbpBj02lk2CUftIF+EyRMD8crxXCKWZi0ExroMr1SXJNi2fNjt924L
   SRSY+wUwHl7OM67IdhmQ8Sbr98xG7ltA4jqYBReVjYux7hyNagC7YKj0N
   bV1xzmD3gBfz+z8r+1AXuh34odcCTkv3tZ3x2NRqwmyhRdSu1gTRirXYS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="324289114"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="324289114"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 19:02:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="830841929"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="830841929"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2023 19:02:13 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 2/5] iommu: Add set_platform_dma_ops iommu ops
Date:   Tue, 10 Jan 2023 10:54:05 +0800
Message-Id: <20230110025408.667767-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110025408.667767-1-baolu.lu@linux.intel.com>
References: <20230110025408.667767-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When VFIO finishes assigning a device to user space and calls
iommu_group_release_dma_owner() to return the device to kernel, the IOMMU
core will attach the default domain to the device. Unfortunately, some
IOMMU drivers don't support default domain, hence in the end, the core
calls .detach_dev instead.

This adds set_platform_dma_ops iommu ops to make it clear that what it
does is returning control back to the platform DMA ops.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h |  4 ++++
 drivers/iommu/iommu.c | 28 ++++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 46e1347bfa22..7b3e3775b069 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -228,6 +228,9 @@ struct iommu_iotlb_gather {
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
  *                  group and attached to the groups domain
+ * @set_platform_dma_ops: Returning control back to the platform DMA ops. This op
+ *                        is to support old IOMMU drivers, new drivers should use
+ *                        default domains, and the common IOMMU DMA ops.
  * @device_group: find iommu group for a particular device
  * @get_resv_regions: Request list of reserved regions for a device
  * @of_xlate: add OF master IDs to iommu grouping
@@ -256,6 +259,7 @@ struct iommu_ops {
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
 	void (*probe_finalize)(struct device *dev);
+	void (*set_platform_dma_ops)(struct device *dev);
 	struct iommu_group *(*device_group)(struct device *dev);
 
 	/* Request/Free a list of reserved regions for a device */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index de91dd88705b..1c8b2c7678f7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2163,6 +2163,16 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
 	return 0;
 }
 
+static int iommu_group_do_set_platform_dma(struct device *dev, void *data)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+	if (!WARN_ON(!ops->set_platform_dma_ops))
+		ops->set_platform_dma_ops(dev);
+
+	return 0;
+}
+
 static int __iommu_group_set_domain(struct iommu_group *group,
 				    struct iommu_domain *new_domain)
 {
@@ -2177,10 +2187,20 @@ static int __iommu_group_set_domain(struct iommu_group *group,
 	 * platform specific behavior.
 	 */
 	if (!new_domain) {
-		if (WARN_ON(!group->domain->ops->detach_dev))
-			return -EINVAL;
-		__iommu_group_for_each_dev(group, group->domain,
-					   iommu_group_do_detach_device);
+		struct group_device *grp_dev;
+
+		grp_dev = list_first_entry(&group->devices,
+					   struct group_device, list);
+
+		if (dev_iommu_ops(grp_dev->dev)->set_platform_dma_ops)
+			__iommu_group_for_each_dev(group, NULL,
+					iommu_group_do_set_platform_dma);
+		else if (group->domain->ops->detach_dev)
+			__iommu_group_for_each_dev(group, group->domain,
+					iommu_group_do_detach_device);
+		else
+			WARN_ON_ONCE(1);
+
 		group->domain = NULL;
 		return 0;
 	}
-- 
2.34.1

