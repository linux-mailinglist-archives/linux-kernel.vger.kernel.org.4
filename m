Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5926FD0D7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbjEIVUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbjEIVTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:19:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8C049E7;
        Tue,  9 May 2023 14:19:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4F81634E7;
        Tue,  9 May 2023 21:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65DCC4339B;
        Tue,  9 May 2023 21:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683667188;
        bh=+vRrwIe1+/o1cUB17pTvCBZYLyydI8RuSE2s+ReV9AA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UN/t1eNlOVAMDfOpZz2i1p2ZytbUSdnYjy96S3tnv+wYWTJL6dNLffZiLTFTHYaMM
         3tjbZB/vLXd+AGISuCc97+FaGMzAyzNCRXf79KGuMuqGtXMDjI3yy835EwxEIrRYEC
         W2vqPS/lpPJrxix4qPy5dGCojXYj2/0uH3CP8NqxTukgeohTV4OtZ2tc18d/ASCUxC
         N8di2Auo1alDnKCCBgrTGWSsllnPfZKZ2lZJAq6FaqQB8pbWHpjI4oMriFuWBMuoFk
         FpgdAFxMPXaictDywjzA0wUlWOCX4gT1WlaMUjhdjmUO3GPNh3Au7quYCM7cAJxbHJ
         CDJSglWBXmFNg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>, will@kernel.org,
        joro@8bytes.org, baolu.lu@linux.intel.com, jgg@ziepe.ca,
        robh@kernel.org, jon@solid-run.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.3 12/18] iommu/arm-smmu: Drop if with an always false condition
Date:   Tue,  9 May 2023 17:19:20 -0400
Message-Id: <20230509211928.21010-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509211928.21010-1-sashal@kernel.org>
References: <20230509211928.21010-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit a2972cb89935160bfe515b15d28a77694723ac06 ]

The remove and shutdown callback are only called after probe completed
successfully. In this case platform_set_drvdata() was called with a
non-NULL argument and so smmu is never NULL. Other functions in this
driver also don't check for smmu being non-NULL before using it.

Also note that returning an error code from a remove callback doesn't
result in the device staying bound. It's still removed and devm allocated
resources are freed (among others *smmu and the register mapping). So
after an early exit to iommu device stayed around and using it probably
oopses.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/20230321084125.337021-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 2ff7a72cf3772..f4a36533ae478 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2195,9 +2195,6 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
-	if (!smmu)
-		return;
-
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_notice(&pdev->dev, "disabling translation\n");
 
@@ -2218,9 +2215,6 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
-	if (!smmu)
-		return -ENODEV;
-
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
 
-- 
2.39.2

