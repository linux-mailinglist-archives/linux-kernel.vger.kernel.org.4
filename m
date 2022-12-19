Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD33B650686
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 03:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiLSClE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 21:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiLSCkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 21:40:51 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6AE1174;
        Sun, 18 Dec 2022 18:40:47 -0800 (PST)
X-UUID: 8dbf98ac0a254ebeafd5ffbf96937221-20221219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FNzZA4Rvah6EiOVCThpkNxdRZy233GREfbroF6vG1AY=;
        b=HQlfjJJGWjZUcauMyHHVc/gAOrKu859IKaH/zhydxvEfrrJ8vBMhucqY3gXMsbYMrOUGie4I8wDNVY1DhZSPr2gwdkPfwgEXrItYMvnv4LSVgauXIJSsxr++9exloMehb0lBtBAvJ7k8Jdrw0Z/SK5DtUBFCdQVVnKK/tD57L/c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:cdb25efa-2f8e-4bd1-b119-ffd873e9415f,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:fcd61952-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8dbf98ac0a254ebeafd5ffbf96937221-20221219
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 520766023; Mon, 19 Dec 2022 10:40:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 19 Dec 2022 10:40:40 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 19 Dec 2022 10:40:39 +0800
From:   Xiangsheng Hou <xiangsheng.hou@mediatek.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
CC:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <benliang.zhao@mediatek.com>, <bin.zhang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v5 02/10] spi: mtk-snfi: Add optional nfi_hclk which is needed for MT7986
Date:   Mon, 19 Dec 2022 10:40:11 +0800
Message-ID: <20221219024019.31974-3-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219024019.31974-1-xiangsheng.hou@mediatek.com>
References: <20221219024019.31974-1-xiangsheng.hou@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional nfi_hclk which is needed for MT7986.

Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-mtk-snfi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index 719fc6f53ab1..85644308df23 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -297,6 +297,7 @@ struct mtk_snand {
 	struct device *dev;
 	struct clk *nfi_clk;
 	struct clk *pad_clk;
+	struct clk *nfi_hclk;
 	void __iomem *nfi_base;
 	int irq;
 	struct completion op_done;
@@ -1339,7 +1340,16 @@ static int mtk_snand_enable_clk(struct mtk_snand *ms)
 		dev_err(ms->dev, "unable to enable pad clk\n");
 		goto err1;
 	}
+	ret = clk_prepare_enable(ms->nfi_hclk);
+	if (ret) {
+		dev_err(ms->dev, "unable to enable nfi hclk\n");
+		goto err2;
+	}
+
 	return 0;
+
+err2:
+	clk_disable_unprepare(ms->pad_clk);
 err1:
 	clk_disable_unprepare(ms->nfi_clk);
 	return ret;
@@ -1347,6 +1357,7 @@ static int mtk_snand_enable_clk(struct mtk_snand *ms)
 
 static void mtk_snand_disable_clk(struct mtk_snand *ms)
 {
+	clk_disable_unprepare(ms->nfi_hclk);
 	clk_disable_unprepare(ms->pad_clk);
 	clk_disable_unprepare(ms->nfi_clk);
 }
@@ -1401,6 +1412,13 @@ static int mtk_snand_probe(struct platform_device *pdev)
 		goto release_ecc;
 	}
 
+	ms->nfi_hclk = devm_clk_get_optional(&pdev->dev, "nfi_hclk");
+	if (IS_ERR(ms->nfi_hclk)) {
+		ret = PTR_ERR(ms->nfi_hclk);
+		dev_err(&pdev->dev, "unable to get nfi_hclk, err = %d\n", ret);
+		goto release_ecc;
+	}
+
 	ret = mtk_snand_enable_clk(ms);
 	if (ret)
 		goto release_ecc;
-- 
2.25.1

