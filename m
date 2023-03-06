Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C406AB609
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 06:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjCFF2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 00:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCFF2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 00:28:05 -0500
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20411C7F4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 21:27:25 -0800 (PST)
Received: from SHSend.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTP id 3265QHdV017866;
        Mon, 6 Mar 2023 13:26:17 +0800 (+08)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from ubt.spreadtrum.com (10.0.74.87) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 6 Mar 2023
 13:26:15 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>
CC:     <iommu@lists.linux.dev>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] iommu: sprd: fix a dma buffer leak issue
Date:   Mon, 6 Mar 2023 13:26:13 +0800
Message-ID: <20230306052613.411400-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.87]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 3265QHdV017866
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA buffer used to store the address mpping table is alloced when
attaching device to a domain, and had been released in .detach_dev()
callback which will never be called since this driver supports default
domain, that will cause memory leak.

Move the dma buffer free before freeing sprd iommu domain to fix
this issue.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
V2: Modified commit message
---
 drivers/iommu/sprd-iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index ae94d74b73f4..4de2e79d2226 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -154,6 +154,17 @@ static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
 static void sprd_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+	size_t pgt_size = sprd_iommu_pgt_size(domain);
+	struct sprd_iommu_device *sdev = dom->sdev;
+
+	/*
+	 * If the domain has been attached to a device already,
+	 * free the dma buffer first.
+	 */
+	if (sdev) {
+		dma_free_coherent(sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
+		dom->sdev = NULL;
+	}
 
 	kfree(dom);
 }
-- 
2.25.1

