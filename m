Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6357623CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiKJHim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbiKJHih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:38:37 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE37813D22;
        Wed,  9 Nov 2022 23:38:32 -0800 (PST)
X-UUID: ff047612e9274466b604365ac1fe41fb-20221110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=RgQcMA/Zefjcct9iZE5yJKR6dPZXi7BijeP60Ro8rQo=;
        b=Bic+BJbRytyYjsKviF7eMHzk3aHC+GiqKB1+2rJJfxfUaX48T3AG90tGZgtH2b3kxj3xKVk9zymlnW4Q7Fm36oAZE6tiL/c2rQoxzh3YGRRzTIiHE2EFki2b61stdQQ1E1scpDItj6Ag431IhRme8qVR+aevE+Kectj76UAMnc0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:3f92d1ef-7547-40c6-a151-8176f6da9419,IP:0,U
        RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:3d08e550-b7af-492d-8b40-b1032f90ce11,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,UR
        L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ff047612e9274466b604365ac1fe41fb-20221110
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <zhichao.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 490150736; Thu, 10 Nov 2022 15:38:25 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 10 Nov 2022 15:38:24 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 10 Nov 2022 15:38:23 +0800
From:   Zhichao Liu <zhichao.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <zhichao.liu@mediatek.com>
Subject: [PATCH] spi: mediatek: Fix DEVAPC Violation at KO Remove
Date:   Thu, 10 Nov 2022 15:28:39 +0800
Message-ID: <20221110072839.30961-1-zhichao.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A DEVAPC violation occurs when removing the module
due to accessing HW registers without base clock.
To fix this bug, the correct method is:
1. Call the runtime resume function to enable the
   clock;
2. Operate the registers to reset the HW;
3. Turn off the clocks and disable the device
   RPM mechanism.

Signed-off-by: Zhichao Liu <zhichao.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index a33c9a3de395..d6aff909fc36 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1273,8 +1273,11 @@ static int mtk_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	int ret;
 
-	pm_runtime_disable(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0)
+		return ret;
 
 	mtk_spi_reset(mdata);
 
@@ -1283,6 +1286,9 @@ static int mtk_spi_remove(struct platform_device *pdev)
 		clk_unprepare(mdata->spi_hclk);
 	}
 
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	return 0;
 }
 
-- 
2.18.0

