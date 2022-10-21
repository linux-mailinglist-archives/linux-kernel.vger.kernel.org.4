Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7120560755A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJUKs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiJUKsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:48:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803BE25F1F6;
        Fri, 21 Oct 2022 03:48:14 -0700 (PDT)
X-UUID: 4b89b2f80e294f5398cde5c5a1dfc8a0-20221021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hZCRyMhSQHJiAVv/Ib8uRPx8sr0buzVWMTHHhJy+Oyc=;
        b=XaqiOAyGWX3+jgeaD/6R9ZkwlcPANub5TWJ1sI4dO4K23/Ode1H3U78TFPXZddSQzmkqs71FcV2rGLFQF6BDZkymTk3oE0wJpKUQhPwP4BjlPzVPLwgT5ZTrdVCRaujBtoIqc2YRN7NQQXIEDdwOiAAqrNYkqwnkjDYMD/zgm88=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:c9240531-9284-4488-9f19-c39b8fb25797,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.12,REQID:c9240531-9284-4488-9f19-c39b8fb25797,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:62cd327,CLOUDID:d1be47c8-03ab-4171-989e-341ab5339257,B
        ulkID:221021184809IIE7JMR1,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4b89b2f80e294f5398cde5c5a1dfc8a0-20221021
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1027895078; Fri, 21 Oct 2022 18:48:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 21 Oct 2022 18:48:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 21 Oct 2022 18:48:06 +0800
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>
CC:     <runyang.chen@mediatek.com>, <miles.chen@mediatek.com>,
        <wenst@chromium.org>, <angelogioacchino.delregno@collabora.com>,
        <nfraprado@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v6 2/3] clk: mediatek: Add auxiliary bus support for sysclk reset
Date:   Fri, 21 Oct 2022 18:48:03 +0800
Message-ID: <20221021104804.21391-3-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221021104804.21391-1-rex-bc.chen@mediatek.com>
References: <20221021104804.21391-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To see the relationship in sysfs between devices and they're "real"
device drivers for the reset component of the device:

- Add auxiliary bus support for sysclk reset.
- Change to use the mtk_reset_controller_register() to register sysclk
  reset for mediatek clock drivers using device.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig               |  1 +
 drivers/clk/mediatek/clk-mt2701-eth.c      |  2 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c      |  2 +-
 drivers/clk/mediatek/clk-mt2701-hif.c      |  2 +-
 drivers/clk/mediatek/clk-mt2701.c          |  4 +-
 drivers/clk/mediatek/clk-mt2712.c          |  4 +-
 drivers/clk/mediatek/clk-mt6795-infracfg.c |  2 +-
 drivers/clk/mediatek/clk-mt6795-pericfg.c  |  2 +-
 drivers/clk/mediatek/clk-mt7622-eth.c      |  2 +-
 drivers/clk/mediatek/clk-mt7622-hif.c      |  4 +-
 drivers/clk/mediatek/clk-mt7622.c          |  4 +-
 drivers/clk/mediatek/clk-mt7629-eth.c      |  2 +-
 drivers/clk/mediatek/clk-mt7629-hif.c      |  4 +-
 drivers/clk/mediatek/clk-mt8183.c          |  2 +-
 drivers/clk/mediatek/clk-mt8192.c          |  2 +-
 drivers/clk/mediatek/clk-mtk.c             | 59 +++++++++++++++++++++-
 drivers/clk/mediatek/clk-mtk.h             |  3 ++
 17 files changed, 81 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index e372f145eada..bcd073ada0e9 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -9,6 +9,7 @@ config COMMON_CLK_MEDIATEK
 	tristate
 	select RESET_CONTROLLER
 	select RESET_MEDIATEK_SYSCLK
+	select AUXILIARY_BUS
 	help
 	  MediaTek SoCs' clock support.
 
diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 2106a147833a..2da95232e529 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -58,7 +58,7 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_reset_init_with_dev(&pdev->dev, "mt2701-eth-rst");
+	mtk_reset_controller_register(&pdev->dev, "mt2701-eth-rst");
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index c7bf42ade6f0..da43c422d452 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -52,7 +52,7 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_reset_init_with_dev(&pdev->dev, "mt2701-g3d-rst");
+	mtk_reset_controller_register(&pdev->dev, "mt2701-g3d-rst");
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 070bd2c9f006..2ecccf8fe16e 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -57,7 +57,7 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_reset_init_with_dev(&pdev->dev, "mt2701-hif-rst");
+	mtk_reset_controller_register(&pdev->dev, "mt2701-hif-rst");
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index f5c0af2f8743..b90f611a5b52 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -787,7 +787,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_reset_init_with_dev(&pdev->dev, "mt2701-infrasys-rst");
+	mtk_reset_controller_register(&pdev->dev, "mt2701-infrasys-rst");
 
 	return 0;
 }
@@ -910,7 +910,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_reset_init_with_dev(&pdev->dev, "mt2701-pericfg-rst");
+	mtk_reset_controller_register(&pdev->dev, "mt2701-pericfg-rst");
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index a13e9b35786c..bada923b60cf 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1361,7 +1361,7 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_reset_init_with_dev(&pdev->dev, "mt2712-infra-rst");
+	mtk_reset_controller_register(&pdev->dev, "mt2712-infra-rst");
 
 	return r;
 }
@@ -1383,7 +1383,7 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_reset_init_with_dev(&pdev->dev, "mt2712-peri-rst");
+	mtk_reset_controller_register(&pdev->dev, "mt2712-peri-rst");
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt6795-infracfg.c b/drivers/clk/mediatek/clk-mt6795-infracfg.c
index 8610ca86bfc2..725d17f95ed4 100644
--- a/drivers/clk/mediatek/clk-mt6795-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-infracfg.c
@@ -77,7 +77,7 @@ static int clk_mt6795_infracfg_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_reset_init_with_dev(&pdev->dev, "mt6795-ifa");
+	ret = mtk_reset_controller_register(&pdev->dev, "mt6795-ifa");
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt6795-pericfg.c b/drivers/clk/mediatek/clk-mt6795-pericfg.c
index 696b95b31157..db02e513d9f6 100644
--- a/drivers/clk/mediatek/clk-mt6795-pericfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-pericfg.c
@@ -87,7 +87,7 @@ static int clk_mt6795_pericfg_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_reset_init_with_dev(&pdev->dev, "mt6795-peri");
+	ret = mtk_reset_controller_register(&pdev->dev, "mt6795-peri");
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index 9a74ae83c38e..2e668ed78cd5 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -82,7 +82,7 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_reset_init_with_dev(&pdev->dev, "mt7622-eth-rst");
+	mtk_reset_controller_register(&pdev->dev, "mt7622-eth-rst");
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 7586e22499ec..0335d84b0043 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -93,7 +93,7 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_reset_init_with_dev(&pdev->dev, "mt7622-usb-rst");
+	mtk_reset_controller_register(&pdev->dev, "mt7622-usb-rst");
 
 	return r;
 }
@@ -115,7 +115,7 @@ static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_reset_init_with_dev(&pdev->dev, "mt7622-pcie-rst");
+	mtk_reset_controller_register(&pdev->dev, "mt7622-pcie-rst");
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 90dcca745555..ea4c21b9a6a0 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -663,7 +663,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_reset_init_with_dev(&pdev->dev, "mt7622-infrasys-rst");
+	mtk_reset_controller_register(&pdev->dev, "mt7622-infrasys-rst");
 
 	return 0;
 }
@@ -714,7 +714,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 
 	clk_prepare_enable(clk_data->hws[CLK_PERI_UART0_PD]->clk);
 
-	mtk_reset_init_with_dev(&pdev->dev, "mt7622-pericfg-rst");
+	mtk_reset_controller_register(&pdev->dev, "mt7622-pericfg-rst");
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index 2a19762b046e..dadc76da899b 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -92,7 +92,7 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_reset_init_with_dev(&pdev->dev, "mt7629-ethsys-rst");
+	mtk_reset_controller_register(&pdev->dev, "mt7629-ethsys-rst");
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index d62d343387b3..bd6fdfd97504 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -88,7 +88,7 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_reset_init_with_dev(&pdev->dev, "mt7629-usb-rst");
+	mtk_reset_controller_register(&pdev->dev, "mt7629-usb-rst");
 
 	return r;
 }
@@ -110,7 +110,7 @@ static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_reset_init_with_dev(&pdev->dev, "mt7629-pcie-rst");
+	mtk_reset_controller_register(&pdev->dev, "mt7629-pcie-rst");
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 3040572b8848..7e2be81e58d9 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1265,7 +1265,7 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_reset_init_with_dev(&pdev->dev, "mt8183-infra-rst");
+	mtk_reset_controller_register(&pdev->dev, "mt8183-infra-rst");
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index ab9e0686d2ac..11ca428030b8 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1112,7 +1112,7 @@ static int clk_mt8192_infra_probe(struct platform_device *pdev)
 	if (r)
 		goto free_clk_data;
 
-	r = mtk_reset_init_with_dev(&pdev->dev, "mt8192-infra-rst");
+	r = mtk_reset_controller_register(&pdev->dev, "mt8192-infra-rst");
 	if (r)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 74408849ed86..61b7ee23738a 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -444,6 +444,63 @@ void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_dividers);
 
+static void mtk_reset_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+}
+
+static void mtk_reset_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	auxiliary_device_uninit(adev);
+
+	kfree(adev);
+}
+
+static struct auxiliary_device *mtk_reset_adev_alloc(struct device *dev, const char *name)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return ERR_PTR(-ENOMEM);
+
+	adev->name = name;
+	adev->dev.parent = dev;
+	adev->dev.release = mtk_reset_adev_release;
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		kfree(adev);
+		return ERR_PTR(ret);
+	}
+
+	return adev;
+}
+
+int mtk_reset_controller_register(struct device *dev, const char *name)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = mtk_reset_adev_alloc(dev, name);
+	if (IS_ERR(adev))
+		return PTR_ERR(adev);
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(dev, mtk_reset_unregister_adev, adev);
+}
+EXPORT_SYMBOL_GPL(mtk_reset_controller_register);
+
 int mtk_clk_simple_probe(struct platform_device *pdev)
 {
 	const struct mtk_clk_desc *mcd;
@@ -471,7 +528,7 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, clk_data);
 
 	if (mcd->rst_name) {
-		r = mtk_reset_init_with_dev(&pdev->dev, mcd->rst_name);
+		r = mtk_reset_controller_register(&pdev->dev, mcd->rst_name);
 		if (r)
 			goto unregister_clks;
 	}
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 41183ac56b11..9578643ef5a2 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -7,6 +7,7 @@
 #ifndef __DRV_CLK_MTK_H
 #define __DRV_CLK_MTK_H
 
+#include <linux/auxiliary_bus.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -200,4 +201,6 @@ struct mtk_clk_desc {
 int mtk_clk_simple_probe(struct platform_device *pdev);
 int mtk_clk_simple_remove(struct platform_device *pdev);
 
+int mtk_reset_controller_register(struct device *dev, const char *name);
+
 #endif /* __DRV_CLK_MTK_H */
-- 
2.18.0

