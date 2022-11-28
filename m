Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1D063A1A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiK1G4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiK1G4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:56:06 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C213815A24
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 22:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669618551; x=1701154551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ol98imkt/vwMTgfO5T+HiqA4V5Kbbou7eJPlJ+Hm468=;
  b=Dhy1gCw8prjGRJ01TcrFi5Hf0en3tS6ITPzY2SfsBU0n187tozSwNOqv
   DdPkdmbcMBkPr2XbJBkBgv0L7Ruv5VeCMgk+gSlEeKgdIygm2GtNWoGc4
   iItu0Uf9iAUUCNN+Vqfc12mTl3H9+c8Uu4QoRzAJDE/2mldcEp1uLa5ci
   HrzhrcjGqXwu1nteMdb4+HMkjq2rL59j6WGDjCEiHKOtqnt90hKOmVC03
   QnUAaYlvaZO9jsu7K/33zRZvUmxOVNvk3Xjv8EW1E8gTwf7PKt/X1Hmt+
   wge0QnX/6vBSRKF4sfGFm4O0ZFN/eoouB3xM1F86khYFgLkpeomuJq7k5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401050448"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="401050448"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:55:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="674121238"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="674121238"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2022 22:55:44 -0800
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
Subject: [PATCH v3 15/20] iommu/s390: Add set_platform_dma callback
Date:   Mon, 28 Nov 2022 14:46:43 +0800
Message-Id: <20221128064648.1934720-16-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
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

This IOMMU driver doesn't support default domain. Add the implementation
of set_platform_dma callback so that the IOMMU core could return the
DMA control.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/s390-iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index ed33c6cce083..507bbc2c9b58 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -179,6 +179,14 @@ static void s390_iommu_get_resv_regions(struct device *dev,
 	}
 }
 
+static void s390_iommu_set_platform_dma(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (domain)
+		s390_iommu_detach_device(domain, dev);
+}
+
 static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 {
 	struct zpci_dev *zdev;
@@ -435,6 +443,7 @@ static const struct iommu_ops s390_iommu_ops = {
 	.probe_device = s390_iommu_probe_device,
 	.release_device = s390_iommu_release_device,
 	.device_group = generic_device_group,
+	.set_platform_dma = s390_iommu_set_platform_dma,
 	.pgsize_bitmap = SZ_4K,
 	.get_resv_regions = s390_iommu_get_resv_regions,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-- 
2.34.1

