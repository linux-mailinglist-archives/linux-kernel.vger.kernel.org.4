Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302BB6EA7EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjDUKJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjDUKJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:09:20 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC00AAF0E;
        Fri, 21 Apr 2023 03:09:14 -0700 (PDT)
X-UUID: 8dfe2bece02c11edb6b9f13eb10bd0fe-20230421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iQxj2f8v6Hq2mM43K9p34deiZ+cOeCScETZMUSLPaL4=;
        b=TAHXT6EKxkG5r3ZqX3XbKNAeEaJItHF/6m/4qEw+1+931Z6ldgLUHLI36prVlGlCOCmKj3GiRol2Qi+Q/xweuHzLkq9sVuiby1et1N2IW9oGpeJ++yB9/hQD9z5dUXDMouJF5q/5ePsNCjmCU/a1EoG7w1kYYafALzumqoEvDKY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:e721951a-d945-43c9-a737-55832a4aba0d,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:120426c,CLOUDID:4148d284-cd9c-45f5-8134-710979e3df0e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 8dfe2bece02c11edb6b9f13eb10bd0fe-20230421
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2002886661; Fri, 21 Apr 2023 18:09:08 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 21 Apr 2023 18:09:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 21 Apr 2023 18:09:07 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 5/7] ASoC: mediatek: mt8188: combine afe component registration
Date:   Fri, 21 Apr 2023 18:09:03 +0800
Message-ID: <20230421100905.28045-6-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230421100905.28045-1-trevor.wu@mediatek.com>
References: <20230421100905.28045-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no benefit to separate two components for AFE, so DAI driver
registration is moved to dev_snd_soc_register_component to merge these
two components.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c | 37 ++--------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
index e5f9373bed56..fecc891f892d 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
@@ -1898,10 +1898,6 @@ static const struct snd_kcontrol_new mt8188_memif_controls[] = {
 			    MT8188_AFE_MEMIF_UL10),
 };
 
-static const struct snd_soc_component_driver mt8188_afe_pcm_dai_component = {
-	.name = "mt8188-afe-pcm-dai",
-};
-
 static const struct mtk_base_memif_data memif_data[MT8188_AFE_MEMIF_NUM] = {
 	[MT8188_AFE_MEMIF_DL2] = {
 		.name = "DL2",
@@ -3142,9 +3138,8 @@ static int mt8188_afe_pcm_dev_probe(struct platform_device *pdev)
 	struct mtk_base_afe *afe;
 	struct mt8188_afe_private *afe_priv;
 	struct device *dev;
-	int i, irq_id, ret;
-	struct snd_soc_component *component;
 	struct reset_control *rstc;
+	int i, irq_id, ret;
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(33));
 	if (ret)
@@ -3280,34 +3275,12 @@ static int mt8188_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* register component */
 	ret = devm_snd_soc_register_component(dev, &mt8188_afe_component,
-					      NULL, 0);
+					      afe->dai_drivers, afe->num_dai_drivers);
 	if (ret) {
 		dev_warn(dev, "err_platform\n");
 		goto err_pm_put;
 	}
 
-	component = devm_kzalloc(&pdev->dev, sizeof(*component), GFP_KERNEL);
-	if (!component) {
-		ret = -ENOMEM;
-		goto err_pm_put;
-	}
-
-	ret = snd_soc_component_initialize(component,
-					   &mt8188_afe_pcm_dai_component,
-					   &pdev->dev);
-	if (ret)
-		goto err_pm_put;
-#ifdef CONFIG_DEBUG_FS
-	component->debugfs_prefix = "pcm";
-#endif
-	ret = snd_soc_add_component(component,
-				    afe->dai_drivers,
-				    afe->num_dai_drivers);
-	if (ret) {
-		dev_warn(dev, "err_add_component\n");
-		goto err_pm_put;
-	}
-
 	mt8188_afe_init_registers(afe);
 
 	pm_runtime_put_sync(&pdev->dev);
@@ -3323,11 +3296,6 @@ static int mt8188_afe_pcm_dev_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void mt8188_afe_pcm_dev_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_component(&pdev->dev);
-}
-
 static const struct of_device_id mt8188_afe_pcm_dt_match[] = {
 	{ .compatible = "mediatek,mt8188-afe", },
 	{},
@@ -3346,7 +3314,6 @@ static struct platform_driver mt8188_afe_pcm_driver = {
 		   .pm = &mt8188_afe_pm_ops,
 	},
 	.probe = mt8188_afe_pcm_dev_probe,
-	.remove_new = mt8188_afe_pcm_dev_remove,
 };
 
 module_platform_driver(mt8188_afe_pcm_driver);
-- 
2.18.0

