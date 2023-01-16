Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FDD66BC3F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjAPKyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjAPKxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:53:21 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BD5196B2;
        Mon, 16 Jan 2023 02:53:15 -0800 (PST)
X-UUID: f74acf9c958b11ed945fc101203acc17-20230116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4G8Y0ViVJzXb6BsOeFBPQvk3DHX0QfUnX0ejt3ACyfU=;
        b=kzEtSVn8Hu+INqkYtPtHDQ84mcUFru8ZQY4cxOv92Vqa6UWd0+OxRSpEFlYeHAbw0ZIeNiU8seI8zAokpPIEBbz1lSpH7zX6ct3IrOUZ7I+x9PqFEoFC4Y59a7FuUsYtUcSpFC0DpujVOqpVS5qRmYBo0xNX5FnFCmlIcgmC+pM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:07ba01da-45e7-47bd-b518-c0bbed90f295,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.18,REQID:07ba01da-45e7-47bd-b518-c0bbed90f295,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:3ca2d6b,CLOUDID:75a2c854-dd49-462e-a4be-2143a3ddc739,B
        ulkID:2301161853114L1JMK7F,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: f74acf9c958b11ed945fc101203acc17-20230116
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 886985106; Mon, 16 Jan 2023 18:53:10 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 16 Jan 2023 18:53:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 16 Jan 2023 18:53:08 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-watchdog@vger.kernel.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 2/2] watchdog: mtk_wdt: Add reset_by_toprgu support
Date:   Mon, 16 Jan 2023 18:53:05 +0800
Message-ID: <20230116105305.31818-3-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230116105305.31818-1-allen-kh.cheng@mediatek.com>
References: <20230116105305.31818-1-allen-kh.cheng@mediatek.com>
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

In some cases, the MediaTek watchdog requires the toprgu to reset
timer after system resets.

Provide a reset_by_toprgu parameter for configuration.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 drivers/watchdog/mtk_wdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 3e6212591e69..a9c437598e7e 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -50,6 +50,7 @@
 #define WDT_MODE_IRQ_EN		(1 << 3)
 #define WDT_MODE_AUTO_START	(1 << 4)
 #define WDT_MODE_DUAL_EN	(1 << 6)
+#define WDT_MODE_CNT_SEL	(1 << 8)
 #define WDT_MODE_KEY		0x22000000
 
 #define WDT_SWRST		0x14
@@ -70,6 +71,7 @@ struct mtk_wdt_dev {
 	spinlock_t lock; /* protects WDT_SWSYSRST reg */
 	struct reset_controller_dev rcdev;
 	bool disable_wdt_extrst;
+	bool reset_by_toprgu;
 };
 
 struct mtk_wdt_data {
@@ -279,6 +281,8 @@ static int mtk_wdt_start(struct watchdog_device *wdt_dev)
 		reg &= ~(WDT_MODE_IRQ_EN | WDT_MODE_DUAL_EN);
 	if (mtk_wdt->disable_wdt_extrst)
 		reg &= ~WDT_MODE_EXRST_EN;
+	if (mtk_wdt->reset_by_toprgu)
+		reg |= WDT_MODE_CNT_SEL;
 	reg |= (WDT_MODE_EN | WDT_MODE_KEY);
 	iowrite32(reg, wdt_base + WDT_MODE);
 
@@ -408,6 +412,9 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 	mtk_wdt->disable_wdt_extrst =
 		of_property_read_bool(dev->of_node, "mediatek,disable-extrst");
 
+	mtk_wdt->reset_by_toprgu =
+		of_property_read_bool(dev->of_node, "mediatek,reset-by-toprgu");
+
 	return 0;
 }
 
-- 
2.18.0

