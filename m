Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE34618B53
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiKCWWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiKCWWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:22:22 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C11411F2FC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 15:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dAvGo
        8hUVnCJdOaOHwloI5JQG/uqE/A2irutxgEtJ8c=; b=OV3Xnbb6nUIdXSokE6oN9
        lip5QPVy2fijo9pjyjm3UtwYrIqar5X1+K4XjI6+XFjkB9gJAabjzO50uySICzbQ
        RW4x/D225ulsj9UVOeRpQU6wS8KVU5nY7C+g7F3oT0q65dZ9oKfcLT83Ozsi47H5
        /5Ms7VIZJuimlv4tF/Rmks=
Received: from localhost.localdomain (unknown [171.221.150.41])
        by smtp10 (Coremail) with SMTP id DsCowABnmznpPmRjRFnrKg--.58971S4;
        Fri, 04 Nov 2022 06:21:44 +0800 (CST)
From:   Chen Lin <chen45464546@163.com>
To:     will@kernel.org
Cc:     robin.murphy@arm.com, joro@8bytes.org, treding@nvidia.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Chen Lin <chen45464546@163.com>
Subject: [PATCH] iommu/arm-smmu: Warn once when the perfetcher errata patch fails to apply
Date:   Fri,  4 Nov 2022 06:21:21 +0800
Message-Id: <20221103222121.3051-1-chen45464546@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowABnmznpPmRjRFnrKg--.58971S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw45XF4fKr43WF1xXrW3Awb_yoWkCrcEv3
        Wru3srA34rArW7Ww1Yq3Way3s2kr47Zrn7Wr4Sq3s3JrnrXFyrAan2qF95Kw4xGFy0vFy2
        qF1Yg3yxJry7WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRNBTYUUUUUU==
X-Originating-IP: [171.221.150.41]
X-CM-SenderInfo: hfkh0kqvuwkkiuw6il2tof0z/xtbB2A+unmBHMc4a7wAAsK
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Default reset value of secure banked register SMMU_sACR.cache_lock is 1.
If it is not been set to 0 by secure software(eg: atf), the non-secure 
linux cannot clear ARM_MMU500_ACTLR_CPRE bit. In this situation,
the prefetcher errata is not applied successfully, warn once.

Signed-off-by: Chen Lin <chen45464546@163.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index 658f3cc83278..2d2252b3e518 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -136,6 +136,9 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu)
 		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
 		reg &= ~ARM_MMU500_ACTLR_CPRE;
 		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
+		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
+		if (reg & ARM_MMU500_ACTLR_CPRE)
+			dev_warn_once(smmu->dev, "Failed to alpply prefetcher errata patch, check SMMU_sACR.cache_lock\n");
 	}
 
 	return 0;
-- 
2.25.1

