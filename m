Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C20063A198
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiK1GyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiK1GyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:54:16 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97024140F2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 22:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669618454; x=1701154454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z+afdRodACErnoYidPGbh7hMpmtegQAHzVqp7Lq5B/A=;
  b=PEVxGswz8WYVMfM1oFkC6rOxs1Mml/s7QXR9/d6Ai0KvG0Lw8NcKVX4p
   T9YObTNeWFmAHRa9nVZMzbk1GPH5Vgs9urtufb5Mp441YhyEzcA0t6Lq8
   JwJoUNBCkEHooiz3HSFIe4JwQOcy3NH/+GLBW0G1yX64qQ5/AAkeod/p9
   /WELCPcaZaFXgZGcSYE0pqViBPvgKl+oExFuyWdgT3irTY+P062s0qjEC
   3AF9zEIfgfxblb+cnqHNkf+gUwWFrOprOkJn5UGnKeLTR39k/xzRYKHSL
   ZLfRCTWw/NTgcBdTtDbxn5UijTQccEf/DmDguWcX/FdXKKcjnhN3rH5zp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="341672029"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="341672029"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:54:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="674120646"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="674120646"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2022 22:54:07 -0800
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
Subject: [PATCH v3 01/20] iommu/amd: Remove detach_dev callback
Date:   Mon, 28 Nov 2022 14:46:29 +0800
Message-Id: <20221128064648.1934720-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD IOMMU supports default domain, so the detach_dev op will never
be called. Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/amd/iommu.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5c381cc3658e..bd1970b4f48b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2126,31 +2126,6 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 	protection_domain_free(domain);
 }
 
-static void amd_iommu_detach_device(struct iommu_domain *dom,
-				    struct device *dev)
-{
-	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
-	struct amd_iommu *iommu;
-
-	if (!check_device(dev))
-		return;
-
-	if (dev_data->domain != NULL)
-		detach_device(dev);
-
-	iommu = rlookup_amd_iommu(dev);
-	if (!iommu)
-		return;
-
-#ifdef CONFIG_IRQ_REMAP
-	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
-	    (dom->type == IOMMU_DOMAIN_UNMANAGED))
-		dev_data->use_vapic = 0;
-#endif
-
-	iommu_completion_wait(iommu);
-}
-
 static int amd_iommu_attach_device(struct iommu_domain *dom,
 				   struct device *dev)
 {
@@ -2414,7 +2389,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.def_domain_type = amd_iommu_def_domain_type,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
-		.detach_dev	= amd_iommu_detach_device,
 		.map_pages	= amd_iommu_map_pages,
 		.unmap_pages	= amd_iommu_unmap_pages,
 		.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
-- 
2.34.1

