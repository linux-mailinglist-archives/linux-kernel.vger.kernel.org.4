Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E9765D3E6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbjADNMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbjADNLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:11:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4CC3E0FA
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672837754; x=1704373754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6JspMSxf4tOO5N5gZs/+2wzcZApAr4SYcbdCKphs0Zg=;
  b=hgZ3FoRPHtl0CywouVL0CTVU3nF7zVOAUxzcBfOytbH9zGfPZqjhjTR1
   r+EUA25Oj/2Qj/czO+G1OjzdTX/VK2zgPlNOsuVznTiQtq0i97byRtRN/
   3LTQgv6VDXX4oyJTlA/4uhdT23WSQNFA9GPrm//kiNo9af1kdeK8usYoD
   Y/oJGTYeHXj9dkOTQzQ2tT9uNQGWw+1J+MDdJJclffK+OLw0lJ3jkAiIb
   utgMbF7I3HosGcLNUE8z7pRuftTdykT6sG8Gtd/bj4Nv/yj73RtzTxDGw
   4mkaup7QPR04k2URRW7pa+lGY+DZRT/B7U4Gm6pSFtDSKTY+uaxUqGWvU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="320640359"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="320640359"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 05:07:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="797529492"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="797529492"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2023 05:07:20 -0800
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
Subject: [PATCH v4 19/19] iommu: Remove detach_dev callback
Date:   Wed,  4 Jan 2023 20:57:25 +0800
Message-Id: <20230104125725.271850-20-baolu.lu@linux.intel.com>
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

The detach_dev callback of domain ops is not called in the IOMMU core.
Remove this callback to avoid dead code. The trace event for detaching
domain from device is removed accordingly.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h        |  2 --
 include/trace/events/iommu.h |  7 -------
 drivers/iommu/iommu-traces.c |  1 -
 drivers/iommu/iommu.c        | 29 +++++------------------------
 4 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0d10566b3cb2..a8063f26ff69 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -299,7 +299,6 @@ struct iommu_ops {
  * * EBUSY	- device is attached to a domain and cannot be changed
  * * ENODEV	- device specific errors, not able to be attached
  * * <others>	- treated as ENODEV by the caller. Use is discouraged
- * @detach_dev: detach an iommu domain from a device
  * @set_dev_pasid: set an iommu domain to a pasid of device
  * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
@@ -320,7 +319,6 @@ struct iommu_ops {
  */
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
-	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
 			     ioasid_t pasid);
 
diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
index 29096fe12623..70743db1fb75 100644
--- a/include/trace/events/iommu.h
+++ b/include/trace/events/iommu.h
@@ -76,13 +76,6 @@ DEFINE_EVENT(iommu_device_event, attach_device_to_domain,
 	TP_ARGS(dev)
 );
 
-DEFINE_EVENT(iommu_device_event, detach_device_from_domain,
-
-	TP_PROTO(struct device *dev),
-
-	TP_ARGS(dev)
-);
-
 TRACE_EVENT(map,
 
 	TP_PROTO(unsigned long iova, phys_addr_t paddr, size_t size),
diff --git a/drivers/iommu/iommu-traces.c b/drivers/iommu/iommu-traces.c
index 1e9ca7789de1..23416bf76df9 100644
--- a/drivers/iommu/iommu-traces.c
+++ b/drivers/iommu/iommu-traces.c
@@ -18,7 +18,6 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(remove_device_from_group);
 
 /* iommu_device_event */
 EXPORT_TRACEPOINT_SYMBOL_GPL(attach_device_to_domain);
-EXPORT_TRACEPOINT_SYMBOL_GPL(detach_device_from_domain);
 
 /* iommu_map_unmap */
 EXPORT_TRACEPOINT_SYMBOL_GPL(map);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c7bd8663f1f5..d2b3210170a8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2045,13 +2045,6 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 	return 0;
 }
 
-static void __iommu_detach_device(struct iommu_domain *domain,
-				  struct device *dev)
-{
-	domain->ops->detach_dev(domain, dev);
-	trace_detach_device_from_domain(dev);
-}
-
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_group *group;
@@ -2156,15 +2149,6 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_group);
 
-static int iommu_group_do_detach_device(struct device *dev, void *data)
-{
-	struct iommu_domain *domain = data;
-
-	__iommu_detach_device(domain, dev);
-
-	return 0;
-}
-
 static int iommu_group_do_set_platform_dma(struct device *dev, void *data)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
@@ -2185,19 +2169,16 @@ static int __iommu_group_set_domain(struct iommu_group *group,
 		return 0;
 
 	/*
-	 * New drivers should support default domains and so the detach_dev() op
-	 * will never be called. Otherwise the NULL domain represents some
+	 * New drivers should support default domains and so set_platform_dma()
+	 * op will never be called. Otherwise the NULL domain represents some
 	 * platform specific behavior.
 	 */
 	if (!new_domain) {
 		ret = __iommu_group_for_each_dev(group, NULL,
 				iommu_group_do_set_platform_dma);
-		if (ret) {
-			if (WARN_ON(!group->domain->ops->detach_dev))
-				return -EINVAL;
-			__iommu_group_for_each_dev(group, group->domain,
-				iommu_group_do_detach_device);
-		}
+		if (ret)
+			return ret;
+
 		group->domain = NULL;
 		return 0;
 	}
-- 
2.34.1

