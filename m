Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133F86E3DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 05:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDQDTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 23:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDQDTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 23:19:04 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E60B1FC4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 20:19:02 -0700 (PDT)
Received: from wangchao.. ([10.12.190.56])
        (user=D202280639@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33H368pS014728-33H368pT014728
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Apr 2023 11:06:11 +0800
From:   Chao Wang <D202280639@hust.edu.cn>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <maz@kernel.org>, Olof Johansson <olof@lixom.net>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Chao Wang <D202280639@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: Fix unwind goto issue
Date:   Mon, 17 Apr 2023 03:04:21 +0000
Message-Id: <20230417030421.2777-1-D202280639@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: D202280639@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch complains that
drivers/iommu/rockchip-iommu.c:1306 rk_iommu_probe() warn: missing unwind goto?

The rk_iommu_probe function, after obtaining the irq value through
platform_get_irq, directly returns an error if the returned value
is negative, without releasing any resources.

Fix this by adding a new error handling label "err_pm_disable" and
use a goto statement to redirect to the error handling process. In
order to preserve the original semantics, set err to the value of irq.

Fixes: 1aa55ca9b14a ("iommu/rockchip: Move irq request past pm_runtime_enable")
Signed-off-by: Chao Wang <D202280639@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
This issue is found by static analysis and remains untested.
---
 drivers/iommu/rockchip-iommu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index f30db22ea5d7..31cd1e2929e9 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1302,20 +1302,22 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	for (i = 0; i < iommu->num_irq; i++) {
 		int irq = platform_get_irq(pdev, i);
 
-		if (irq < 0)
-			return irq;
+		if (irq < 0) {
+			err = irq;
+			goto err_pm_disable;
+		}
 
 		err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
 				       IRQF_SHARED, dev_name(dev), iommu);
-		if (err) {
-			pm_runtime_disable(dev);
-			goto err_remove_sysfs;
-		}
+		if (err)
+			goto err_pm_disable;
 	}
 
 	dma_set_mask_and_coherent(dev, rk_ops->dma_bit_mask);
 
 	return 0;
+err_pm_disable:
+	pm_runtime_disable(dev);
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
 err_put_group:
-- 
2.34.1

