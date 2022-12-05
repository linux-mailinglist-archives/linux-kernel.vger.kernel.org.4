Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2309364233B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 07:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiLEG6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 01:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiLEG6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 01:58:18 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B767364F9;
        Sun,  4 Dec 2022 22:58:16 -0800 (PST)
X-UUID: dc9af5796c5a42848445a19d7073cb8b-20221205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eIBjEN/FPdq/8jwIM30UAE6rJrZxiQ0OkReuKlIIvFI=;
        b=UjLJzXj0LVG/V7jiiKY0FvJ7dGQtXKnHXb97DuezmFghQmS3qTpjLElJCuIZTYqfe8EUhSLNBnSlJqzqHYgOOmHmX+Nj9rsv91nN/4+cintMbRf9s8TEg+mNX32+/liwZaIvftXgq+g03EdQ6kpwU/7xlhi/dASlwY97JmUns7Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:89e77a85-dbf3-41ef-995e-e350c322fe12,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.14,REQID:89e77a85-dbf3-41ef-995e-e350c322fe12,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:dcaaed0,CLOUDID:7f3aae30-2938-482e-aafd-98d66723b8a9,B
        ulkID:221205145812ZHY4M186,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: dc9af5796c5a42848445a19d7073cb8b-20221205
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 138225994; Mon, 05 Dec 2022 14:58:12 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 5 Dec 2022 14:58:11 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 5 Dec 2022 14:58:10 +0800
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
        <benliang.zhao@mediatek.com>, <bin.zhang@mediatek.com>
Subject: [PATCH v2 3/9] spi: mtk-snfi: Add optional nfi_hclk which needed for MT7986
Date:   Mon, 5 Dec 2022 14:57:50 +0800
Message-ID: <20221205065756.26875-4-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
References: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional nfi_hclk which needed for MT7986.

Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
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

