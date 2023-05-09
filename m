Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2066FD122
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbjEIVXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbjEIVV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:21:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334B2869A;
        Tue,  9 May 2023 14:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2016763767;
        Tue,  9 May 2023 21:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32960C433A1;
        Tue,  9 May 2023 21:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683667238;
        bh=9P7amgHesvZfXjhJMrNCC3wqHsnw+fBTnWXN96xdpOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hlikgHJGeLIVFggTu4fTCS0TiYgC5YJcVRlAlRQqk4y+kB3zny410fUN0oJxU97fA
         BUM6IuRfV9JGBkoYL15MoRyuFyEuFi5NLy9RZ6UT9pSIVEpunxx4ysH0VXS1edPLi8
         PUQTq1ao4cgviiTJjb60UDv/ENAbVMb4q3iUdBVoyPCpaaCwxkw//lfnPg1tIhdWw4
         RThzuejFCNUaL0mrOLDqsYxbuEV8RVkYn5/Fk32F//HYwyLwFD64dbkR1GGQ4M95yY
         NxcoWSNp37B7twQ5rkWx6emhMvfFV6DRQJRht2RUdOPGjPUDqPjKlkMKN9nAe7ILHW
         iiEWD5KW10Pxg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>, joro@8bytes.org,
        will@kernel.org, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 11/13] iommu/sprd: Release dma buffer to avoid memory leak
Date:   Tue,  9 May 2023 17:20:19 -0400
Message-Id: <20230509212023.22105-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509212023.22105-1-sashal@kernel.org>
References: <20230509212023.22105-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

[ Upstream commit 9afea57384d4ae7b2034593eac7fa76c7122762a ]

When attaching to a domain, the driver would alloc a DMA buffer which
is used to store address mapping table, and it need to be released
when the IOMMU domain is freed.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Link: https://lore.kernel.org/r/20230331033124.864691-2-zhang.lyra@gmail.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/sprd-iommu.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 27ac818b03544..723940e841612 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -151,13 +151,6 @@ static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
 	return &dom->domain;
 }
 
-static void sprd_iommu_domain_free(struct iommu_domain *domain)
-{
-	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
-
-	kfree(dom);
-}
-
 static void sprd_iommu_first_vpn(struct sprd_iommu_domain *dom)
 {
 	struct sprd_iommu_device *sdev = dom->sdev;
@@ -230,6 +223,28 @@ static void sprd_iommu_hw_en(struct sprd_iommu_device *sdev, bool en)
 	sprd_iommu_update_bits(sdev, reg_cfg, mask, 0, val);
 }
 
+static void sprd_iommu_cleanup(struct sprd_iommu_domain *dom)
+{
+	size_t pgt_size;
+
+	/* Nothing need to do if the domain hasn't been attached */
+	if (!dom->sdev)
+		return;
+
+	pgt_size = sprd_iommu_pgt_size(&dom->domain);
+	dma_free_coherent(dom->sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
+	dom->sdev = NULL;
+	sprd_iommu_hw_en(dom->sdev, false);
+}
+
+static void sprd_iommu_domain_free(struct iommu_domain *domain)
+{
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+
+	sprd_iommu_cleanup(dom);
+	kfree(dom);
+}
+
 static int sprd_iommu_attach_device(struct iommu_domain *domain,
 				    struct device *dev)
 {
-- 
2.39.2

