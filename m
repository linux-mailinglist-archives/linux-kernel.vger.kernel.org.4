Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD9063A1A7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiK1G4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiK1G4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:56:11 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687F114D0E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 22:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669618558; x=1701154558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r5xbh896pHOm4nF0J2WHqkUdwYnD0sIQJbuduyaVUB4=;
  b=MQvKTmw4fi1bVD4F0Llp7FCeAuuyMKDHlH6zbPIssTfPjNgCvsbiHb5q
   +468s1Wly9RIstmGULcNN0Ta9XFsdD8S9ZVUTQPu0eisJRYrHFhUK2MgR
   wSDOqwT7XqzF/K9C970FyEzveGoH67Wsch9ayqF3tu+RwOoRcIWWcuHUt
   MAMoVWeFMYskCv8ueJSddEx8cd0HvvEmT95x4/tjFSHl8t3TZcCd+7KT2
   3NfckKSb5pseNQsLeHw4P5QPQWDyMXIQf2M7Jwak9EKKedFt5ZOYkIq8E
   wG039RIf4JZNvA4+Uk3OhlJmxHeYrb645BofIb4deYNwxII1pOzAokTH6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="294462659"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="294462659"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:55:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="674121259"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="674121259"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2022 22:55:51 -0800
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
Subject: [PATCH v3 16/20] iommu/gart: Add set_platform_dma callback
Date:   Mon, 28 Nov 2022 14:46:44 +0800
Message-Id: <20221128064648.1934720-17-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This IOMMU driver doesn't support default domain. Add the implementation
of set_platform_dma callback so that the IOMMU core could return the
DMA control.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/tegra-gart.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index ed53279d1106..f56e40b5c47a 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -141,6 +141,14 @@ static void gart_iommu_detach_dev(struct iommu_domain *domain,
 	spin_unlock(&gart->dom_lock);
 }
 
+static void gart_iommu_set_platform_dma(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (domain)
+		gart_iommu_detach_dev(domain, dev);
+}
+
 static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 {
 	struct iommu_domain *domain;
@@ -270,6 +278,7 @@ static const struct iommu_ops gart_iommu_ops = {
 	.domain_alloc	= gart_iommu_domain_alloc,
 	.probe_device	= gart_iommu_probe_device,
 	.device_group	= generic_device_group,
+	.set_platform_dma = gart_iommu_set_platform_dma,
 	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
 	.of_xlate	= gart_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-- 
2.34.1

