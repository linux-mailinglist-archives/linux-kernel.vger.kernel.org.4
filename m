Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1EE63A19E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiK1GzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiK1Gy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:54:58 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD7F15834
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 22:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669618495; x=1701154495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uC3pF7hOoVLbt48rw9NtRx8qdAPfr8OWtZGji1zKp8s=;
  b=AoeB/m0r+ZVUyRfIhIOyfPqfBZtwLfnwLXUp25Y2Yk0Ge/Rc0D0BM9i4
   oC4TPwtAzgdgRQtztaBQzcqcaoZtH4zdi9x29/HKmkkqRfR74lu9cKywv
   U1++ahsRmKZ05I8SD4XqsqCWVK8Pz07R8w0aQ5C84ZGy9de50x2o506k1
   QJnvGxu5T5roH6gE/26ms9aMBmwJmyETtMRsR7gTRXZiHhxo2SRR+ufJY
   cCnsp25lc82E3YhABU7CEiCQjLlCshFKkXqMUYDxkqTikFWIsE2/f+/t4
   9daOSWuG3cTS5NQ3mPOhA362E1Y6ZfBwTmUEdG6/2Hyf4Wz4oGUa2EpS5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="312395023"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="312395023"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:54:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="674120824"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="674120824"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2022 22:54:48 -0800
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
Subject: [PATCH v3 07/20] iommu/rockchip: Remove detach_dev callback
Date:   Mon, 28 Nov 2022 14:46:35 +0800
Message-Id: <20221128064648.1934720-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOMMU driver supports default domain, so the detach_dev op will never
be called. Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/rockchip-iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index a68eadd64f38..f30db22ea5d7 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1192,7 +1192,6 @@ static const struct iommu_ops rk_iommu_ops = {
 	.of_xlate = rk_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= rk_iommu_attach_device,
-		.detach_dev	= rk_iommu_detach_device,
 		.map		= rk_iommu_map,
 		.unmap		= rk_iommu_unmap,
 		.iova_to_phys	= rk_iommu_iova_to_phys,
-- 
2.34.1

