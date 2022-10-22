Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D616083B2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 04:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJVCrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 22:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJVCrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 22:47:05 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E1D428487C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 19:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Oydpo
        FCe9+Y0CII8gxzK+nMqaPhZXIic+yLDuWv+Suo=; b=ZsXsb73/Wl75+dVhKfVxN
        P3yF3IdJsm+Wn9rMJJiWhILq4h8/tilw7W5L8cPqOc6dUrW8CWrTLeoKgt5hXF8y
        Pr9aKYDoNV97ZMuV3jRlExhvswaypfsvazj/b3L3Em5hCvTNc2q7VD/9A/NjpjEf
        Ah071ZEfJkJ+11aZtY9qfQ=
Received: from localhost.localdomain (unknown [171.221.146.106])
        by smtp8 (Coremail) with SMTP id DMCowAAHqiRpWVNjXpmhjQ--.55403S4;
        Sat, 22 Oct 2022 10:46:19 +0800 (CST)
From:   Chen Lin <chen45464546@163.com>
To:     will@kernel.org
Cc:     robin.murphy@arm.com, joro@8bytes.org, treding@nvidia.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Chen Lin <chen.lin5@zte.com.cn>
Subject: [PATCH] iommu/arm-smmu: Warn once when the perfetcher errata patch fails to allpy
Date:   Sat, 22 Oct 2022 10:45:59 +0800
Message-Id: <20221022024559.4913-1-chen45464546@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAAHqiRpWVNjXpmhjQ--.55403S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw45XF4fKr43WF17tF4fZrb_yoWktFcEv3
        WrZrnrA34rArW7Ww1YqFySy3sYkr47ZrZ7Wr4Sv3s3Jr9rXFyrAanFqFn5Kw4xGFy0vFy7
        tF1YqayxJry7WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8nZ23UUUUU==
X-Originating-IP: [171.221.146.106]
X-CM-SenderInfo: hfkh0kqvuwkkiuw6il2tof0z/1tbiGhuinlaEDNVZLQAAsC
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Lin <chen.lin5@zte.com.cn>

Default reset value of secure banked register SMMU_sACR.cache_lock is 1.
If it is not been set to 0 by secure software(eg: atf), the non-secure 
linux cannot clear ARM_MMU500_ACTLR_CPRE bit. In this situation,
the prefetcher errata is not applied successfully, warn once.

Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
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

