Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0307E6B7066
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCMHwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCMHvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:51:41 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8937751CAA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:51:33 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTP id 32D7pAWJ066429;
        Mon, 13 Mar 2023 15:51:10 +0800 (+08)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from ubt.spreadtrum.com (10.0.74.87) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 13 Mar
 2023 15:51:07 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>
CC:     <iommu@lists.linux.dev>, Baolu Lu <baolu.lu@linux.intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Chunyan Zhang" <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 2/2] iommu: sprd: Add support for reattaching an existing domain
Date:   Mon, 13 Mar 2023 15:50:17 +0800
Message-ID: <20230313075017.668204-3-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230313075017.668204-1-chunyan.zhang@unisoc.com>
References: <20230313075017.668204-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.87]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 32D7pAWJ066429
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This IOMMU driver should allow a domain to be attached more than once.

If IOMMU is reattaching to the same domain which is attached, there's
nothing to be done.

If reattching to a previously-used domain, do not alloc DMA buffer
again which stores address mapping table to avoid memory leak.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/iommu/sprd-iommu.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 7df1f730c778..3513b2b108bf 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -62,6 +62,7 @@ enum sprd_iommu_version {
  * @eb: gate clock which controls IOMMU access
  */
 struct sprd_iommu_device {
+	struct sprd_iommu_domain	*dom;
 	enum sprd_iommu_version	ver;
 	u32			*prot_page_va;
 	dma_addr_t		prot_page_pa;
@@ -252,15 +253,27 @@ static int sprd_iommu_attach_device(struct iommu_domain *domain,
 	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
 	size_t pgt_size = sprd_iommu_pgt_size(domain);
 
-	if (dom->sdev)
-		return -EINVAL;
+	/* The device is attached to this domain */
+	if (sdev->dom == dom)
+		return 0;
 
-	dom->pgt_va = dma_alloc_coherent(sdev->dev, pgt_size, &dom->pgt_pa, GFP_KERNEL);
-	if (!dom->pgt_va)
-		return -ENOMEM;
+	/* The first time that domain is attaching to a device */
+	if (!dom->pgt_va) {
+		dom->pgt_va = dma_alloc_coherent(sdev->dev, pgt_size, &dom->pgt_pa, GFP_KERNEL);
+		if (!dom->pgt_va)
+			return -ENOMEM;
+
+		dom->sdev = sdev;
+	}
 
-	dom->sdev = sdev;
+	sdev->dom = dom;
 
+	/*
+	 * One sprd IOMMU serves one client device only, disabled it before
+	 * configure mapping table to avoid access conflict in case other
+	 * mapping table is stored in.
+	 */
+	sprd_iommu_hw_en(sdev, false);
 	sprd_iommu_first_ppn(dom);
 	sprd_iommu_first_vpn(dom);
 	sprd_iommu_vpn_range(dom);
-- 
2.25.1

