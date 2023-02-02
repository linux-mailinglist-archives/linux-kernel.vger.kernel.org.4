Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82251687E08
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjBBM4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjBBM4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:56:33 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FA86A31D;
        Thu,  2 Feb 2023 04:56:26 -0800 (PST)
X-UUID: dc7e2970a2f611ed945fc101203acc17-20230202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=c+2MghKyEYKB7JtABJ5selabgEIfJGtw/SraCb8bSqQ=;
        b=tNg5A3xnCnvsTXLMuoCt8n5A3/ipZaqjgkC1bRvXISOlYG6/aBbXGRmJ6p27lxcaqkLI83jBobrd4T+SPGOdbXDD4O2W19ZlggyMnkAiwEy4PRjCyIz1ufM7oTC1DYlqLk8rZmZspNfBe2PvPRw/bnyFBY4zCvQAw/X9eh26HDc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:6694fca5-1df7-431e-9b13-795ba1e1445f,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:3ca2d6b,CLOUDID:1accb68d-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: dc7e2970a2f611ed945fc101203acc17-20230202
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1339436177; Thu, 02 Feb 2023 20:41:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 2 Feb 2023 20:41:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 2 Feb 2023 20:41:05 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>
CC:     Fan Chen <fan.chen@mediatek.com>, Roger Lu <roger.lu@mediatek.com>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v5 1/3] soc: mediatek: mtk-svs: use svs get efuse common function
Date:   Thu, 2 Feb 2023 20:41:02 +0800
Message-ID: <20230202124104.16504-2-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230202124104.16504-1-roger.lu@mediatek.com>
References: <20230202124104.16504-1-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SVS might need to read both svs efuse and thermal efuse on the probe flow.
Therefore, add a common efuse read function to remove the superfluous
codes.

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-svs.c | 71 ++++++++++++----------------------
 1 file changed, 25 insertions(+), 46 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index f26eb2f637d5..c9899f5df60a 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -1729,26 +1729,28 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
 	return 0;
 }
 
-static int svs_thermal_efuse_get_data(struct svs_platform *svsp)
+static int svs_get_efuse_data(struct svs_platform *svsp,
+			      const char *nvmem_cell_name,
+			      u32 **svsp_efuse, size_t *svsp_efuse_max)
 {
 	struct nvmem_cell *cell;
 
-	/* Thermal efuse parsing */
-	cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
+	cell = nvmem_cell_get(svsp->dev, nvmem_cell_name);
 	if (IS_ERR_OR_NULL(cell)) {
-		dev_err(svsp->dev, "no \"t-calibration-data\"? %ld\n", PTR_ERR(cell));
+		dev_err(svsp->dev, "no \"%s\"? %ld\n",
+			nvmem_cell_name, PTR_ERR(cell));
 		return PTR_ERR(cell);
 	}
 
-	svsp->tefuse = nvmem_cell_read(cell, &svsp->tefuse_max);
-	if (IS_ERR(svsp->tefuse)) {
-		dev_err(svsp->dev, "cannot read thermal efuse: %ld\n",
-			PTR_ERR(svsp->tefuse));
+	*svsp_efuse = nvmem_cell_read(cell, svsp_efuse_max);
+	if (IS_ERR(*svsp_efuse)) {
+		dev_err(svsp->dev, "cannot read \"%s\" efuse: %ld\n",
+			nvmem_cell_name, PTR_ERR(*svsp_efuse));
 		nvmem_cell_put(cell);
-		return PTR_ERR(svsp->tefuse);
+		return PTR_ERR(*svsp_efuse);
 	}
 
-	svsp->tefuse_max /= sizeof(u32);
+	*svsp_efuse_max /= sizeof(u32);
 	nvmem_cell_put(cell);
 
 	return 0;
@@ -1796,7 +1798,8 @@ static bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
 		svsb->vmax += svsb->dvt_fixed;
 	}
 
-	ret = svs_thermal_efuse_get_data(svsp);
+	ret = svs_get_efuse_data(svsp, "t-calibration-data",
+				 &svsp->tefuse, &svsp->tefuse_max);
 	if (ret)
 		return false;
 
@@ -1901,7 +1904,8 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 		}
 	}
 
-	ret = svs_thermal_efuse_get_data(svsp);
+	ret = svs_get_efuse_data(svsp, "t-calibration-data",
+				 &svsp->tefuse, &svsp->tefuse_max);
 	if (ret)
 		return false;
 
@@ -2003,32 +2007,6 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 	return true;
 }
 
-static bool svs_is_efuse_data_correct(struct svs_platform *svsp)
-{
-	struct nvmem_cell *cell;
-
-	/* Get svs efuse by nvmem */
-	cell = nvmem_cell_get(svsp->dev, "svs-calibration-data");
-	if (IS_ERR(cell)) {
-		dev_err(svsp->dev, "no \"svs-calibration-data\"? %ld\n",
-			PTR_ERR(cell));
-		return false;
-	}
-
-	svsp->efuse = nvmem_cell_read(cell, &svsp->efuse_max);
-	if (IS_ERR(svsp->efuse)) {
-		dev_err(svsp->dev, "cannot read svs efuse: %ld\n",
-			PTR_ERR(svsp->efuse));
-		nvmem_cell_put(cell);
-		return false;
-	}
-
-	svsp->efuse_max /= sizeof(u32);
-	nvmem_cell_put(cell);
-
-	return true;
-}
-
 static struct device *svs_get_subsys_device(struct svs_platform *svsp,
 					    const char *node_name)
 {
@@ -2364,8 +2342,9 @@ static int svs_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (!svs_is_efuse_data_correct(svsp)) {
-		dev_notice(svsp->dev, "efuse data isn't correct\n");
+	ret = svs_get_efuse_data(svsp, "svs-calibration-data",
+				 &svsp->efuse, &svsp->efuse_max);
+	if (ret) {
 		ret = -EPERM;
 		goto svs_probe_free_efuse;
 	}
@@ -2373,19 +2352,19 @@ static int svs_probe(struct platform_device *pdev)
 	if (!svsp_data->efuse_parsing(svsp)) {
 		dev_err(svsp->dev, "efuse data parsing failed\n");
 		ret = -EPERM;
-		goto svs_probe_free_resource;
+		goto svs_probe_free_tefuse;
 	}
 
 	ret = svs_bank_resource_setup(svsp);
 	if (ret) {
 		dev_err(svsp->dev, "svs bank resource setup fail: %d\n", ret);
-		goto svs_probe_free_resource;
+		goto svs_probe_free_tefuse;
 	}
 
 	svsp_irq = platform_get_irq(pdev, 0);
 	if (svsp_irq < 0) {
 		ret = svsp_irq;
-		goto svs_probe_free_resource;
+		goto svs_probe_free_tefuse;
 	}
 
 	svsp->main_clk = devm_clk_get(svsp->dev, "main");
@@ -2393,13 +2372,13 @@ static int svs_probe(struct platform_device *pdev)
 		dev_err(svsp->dev, "failed to get clock: %ld\n",
 			PTR_ERR(svsp->main_clk));
 		ret = PTR_ERR(svsp->main_clk);
-		goto svs_probe_free_resource;
+		goto svs_probe_free_tefuse;
 	}
 
 	ret = clk_prepare_enable(svsp->main_clk);
 	if (ret) {
 		dev_err(svsp->dev, "cannot enable main clk: %d\n", ret);
-		goto svs_probe_free_resource;
+		goto svs_probe_free_tefuse;
 	}
 
 	svsp->base = of_iomap(svsp->dev->of_node, 0);
@@ -2439,7 +2418,7 @@ static int svs_probe(struct platform_device *pdev)
 svs_probe_clk_disable:
 	clk_disable_unprepare(svsp->main_clk);
 
-svs_probe_free_resource:
+svs_probe_free_tefuse:
 	if (!IS_ERR_OR_NULL(svsp->tefuse))
 		kfree(svsp->tefuse);
 
-- 
2.18.0

