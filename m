Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932CF65D3E3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjADNLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239444AbjADNLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:11:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9846B395C8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672837754; x=1704373754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=etvQ4VuCYjgoc+S/bXFKsFRT2trDWdnEQJZuwIpkWNE=;
  b=OKT1ire+nXckr3/1b5FzlbgR+jtyRi7WInoKH0G6q+fNyux906jxNBln
   qBieaUiQ7UKWI2KRaja6Yu4vFPjAB7h4nMqHGNYLihixsFv2LkQus+Rvx
   QOzqLVz//I0MoRx2V3Z73EAmSAyTNMoEDVsQNfiQbIu6OjyJApAeY6DwP
   2NJLHyNyBIw/AmGwfQK80VsCLFcaR++1ipdUGCbHj2cMySNoNRW9tdZh8
   tqSH5D0FOWEW/UfhlE7RCzE0d4yoyCS/XbfXWjh7rORaIThLjLzNhXukx
   gqcIiQRw94JiaUio51YeEkxakIEBfU3iHB5iCvHGLzoijzTA+dOBGuean
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="320640320"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="320640320"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 05:07:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="797529378"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="797529378"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2023 05:07:14 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
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
Subject: [PATCH v4 18/19] iommu: Remove deferred attach check from __iommu_detach_device()
Date:   Wed,  4 Jan 2023 20:57:24 +0800
Message-Id: <20230104125725.271850-19-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230104125725.271850-1-baolu.lu@linux.intel.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
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

From: Jason Gunthorpe <jgg@nvidia.com>

At the current moment, __iommu_detach_device() is only called via call
chains that are after the device driver is attached - eg via explicit
attach APIs called by the device driver.

Commit bd421264ed30 ("iommu: Fix deferred domain attachment") has removed
deferred domain attachment check from __iommu_attach_device() path, so it
should just unconditionally work in the __iommu_detach_device() path.

It actually looks like a bug that we were blocking detach on these paths
since the attach was unconditional and the caller is going to free the
(probably) UNAMANGED domain once this returns.

The only place we should be testing for deferred attach is during the
initial point the dma device is linked to the group, and then again
during the dma api calls.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h |  2 ++
 drivers/iommu/iommu.c | 70 ++++++++++++++++++++++---------------------
 2 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7b3e3775b069..0d10566b3cb2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -405,6 +405,7 @@ struct iommu_fault_param {
  * @iommu_dev:	 IOMMU device this device is linked to
  * @priv:	 IOMMU Driver private data
  * @max_pasids:  number of PASIDs this device can consume
+ * @attach_deferred: the dma domain attachment is deferred
  *
  * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
  *	struct iommu_group	*iommu_group;
@@ -417,6 +418,7 @@ struct dev_iommu {
 	struct iommu_device		*iommu_dev;
 	void				*priv;
 	u32				max_pasids;
+	u32				attach_deferred:1;
 };
 
 int iommu_device_register(struct iommu_device *iommu,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4e35a9f94873..c7bd8663f1f5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -371,6 +371,30 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	return ret;
 }
 
+static bool iommu_is_attach_deferred(struct device *dev)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+	if (ops->is_attach_deferred)
+		return ops->is_attach_deferred(dev);
+
+	return false;
+}
+
+static int iommu_group_do_dma_first_attach(struct device *dev, void *data)
+{
+	struct iommu_domain *domain = data;
+
+	lockdep_assert_held(&dev->iommu_group->mutex);
+
+	if (iommu_is_attach_deferred(dev)) {
+		dev->iommu->attach_deferred = 1;
+		return 0;
+	}
+
+	return __iommu_attach_device(domain, dev);
+}
+
 int iommu_probe_device(struct device *dev)
 {
 	const struct iommu_ops *ops;
@@ -401,7 +425,7 @@ int iommu_probe_device(struct device *dev)
 	 * attach the default domain.
 	 */
 	if (group->default_domain && !group->owner) {
-		ret = __iommu_attach_device(group->default_domain, dev);
+		ret = iommu_group_do_dma_first_attach(dev, group->default_domain);
 		if (ret) {
 			mutex_unlock(&group->mutex);
 			iommu_group_put(group);
@@ -947,16 +971,6 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 	return ret;
 }
 
-static bool iommu_is_attach_deferred(struct device *dev)
-{
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
-
-	if (ops->is_attach_deferred)
-		return ops->is_attach_deferred(dev);
-
-	return false;
-}
-
 /**
  * iommu_group_add_device - add a device to an iommu group
  * @group: the group into which to add the device (reference should be held)
@@ -1009,8 +1023,8 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
-	if (group->domain  && !iommu_is_attach_deferred(dev))
-		ret = __iommu_attach_device(group->domain, dev);
+	if (group->domain)
+		ret = iommu_group_do_dma_first_attach(dev, group->domain);
 	mutex_unlock(&group->mutex);
 	if (ret)
 		goto err_put_group;
@@ -1776,21 +1790,10 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 
 }
 
-static int iommu_group_do_dma_attach(struct device *dev, void *data)
-{
-	struct iommu_domain *domain = data;
-	int ret = 0;
-
-	if (!iommu_is_attach_deferred(dev))
-		ret = __iommu_attach_device(domain, dev);
-
-	return ret;
-}
-
-static int __iommu_group_dma_attach(struct iommu_group *group)
+static int __iommu_group_dma_first_attach(struct iommu_group *group)
 {
 	return __iommu_group_for_each_dev(group, group->default_domain,
-					  iommu_group_do_dma_attach);
+					  iommu_group_do_dma_first_attach);
 }
 
 static int iommu_group_do_probe_finalize(struct device *dev, void *data)
@@ -1855,7 +1858,7 @@ int bus_iommu_probe(struct bus_type *bus)
 
 		iommu_group_create_direct_mappings(group);
 
-		ret = __iommu_group_dma_attach(group);
+		ret = __iommu_group_dma_first_attach(group);
 
 		mutex_unlock(&group->mutex);
 
@@ -1987,9 +1990,11 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 		return -ENODEV;
 
 	ret = domain->ops->attach_dev(domain, dev);
-	if (!ret)
-		trace_attach_device_to_domain(dev);
-	return ret;
+	if (ret)
+		return ret;
+	dev->iommu->attach_deferred = 0;
+	trace_attach_device_to_domain(dev);
+	return 0;
 }
 
 /**
@@ -2034,7 +2039,7 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
 
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 {
-	if (iommu_is_attach_deferred(dev))
+	if (dev->iommu && dev->iommu->attach_deferred)
 		return __iommu_attach_device(domain, dev);
 
 	return 0;
@@ -2043,9 +2048,6 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
-	if (iommu_is_attach_deferred(dev))
-		return;
-
 	domain->ops->detach_dev(domain, dev);
 	trace_detach_device_from_domain(dev);
 }
-- 
2.34.1

