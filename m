Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C8F691AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjBJJAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjBJI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:59:50 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3FA1556B;
        Fri, 10 Feb 2023 00:59:43 -0800 (PST)
X-UUID: 3db3fb7ca92111ed945fc101203acc17-20230210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=H68qhvncPP+HdKEnCKvBBC0ghvXSNegsYN2bO0sXAqU=;
        b=jV3XI9j6mWzOuOcB90wclW0OcTnHld6GuDRetU4YAjFWxLOElhxjdUpYTGSdPxS0w1nI7cPtegjBo4cHSQMHIHje0OZtkQ+5zfCHLmMLLbKHLcuuE/bRecZwTZPfyGqX/Fk+RlVX3HeyOA70C2L8VAzQA7h+Ylk5hz24d7YV8S0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:e638d8c7-a7f0-4a60-9d28-86f5b0c01d10,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:885ddb2,CLOUDID:c5a6808e-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 3db3fb7ca92111ed945fc101203acc17-20230210
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2102634611; Fri, 10 Feb 2023 16:59:35 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 10 Feb 2023 16:59:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 10 Feb 2023 16:59:34 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v5 06/12] remoteproc: mediatek: Extract remoteproc initialization flow
Date:   Fri, 10 Feb 2023 16:59:25 +0800
Message-ID: <20230210085931.8941-7-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230210085931.8941-1-tinghan.shen@mediatek.com>
References: <20230210085931.8941-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
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

This is the preparation for probing multi-core SCP. The remoteproc
initialization flow is similar on cores and is reuesd to avoid
redundant code.

The registers of config and l1tcm are shared for multi-core
SCP. Reuse the mapped addresses for all cores.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_common.h |  7 +++++
 drivers/remoteproc/mtk_scp.c    | 55 +++++++++++++++++++++------------
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 3778894c96f3..20c1a90be77d 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -112,6 +112,13 @@ struct mtk_scp_of_data {
 	size_t ipi_buf_offset;
 };
 
+struct mtk_scp_of_regs {
+	void __iomem *reg_base;
+	void __iomem *l1tcm_base;
+	size_t l1tcm_size;
+	phys_addr_t l1tcm_phys;
+};
+
 struct mtk_scp {
 	struct device *dev;
 	struct rproc *rproc;
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index b92274067522..898039879142 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -854,7 +854,8 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
 	}
 }
 
-static int scp_probe(struct platform_device *pdev)
+static int scp_rproc_init(struct platform_device *pdev,
+			  struct mtk_scp_of_regs *of_regs)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -878,6 +879,11 @@ static int scp_probe(struct platform_device *pdev)
 	scp->data = of_device_get_match_data(dev);
 	platform_set_drvdata(pdev, scp);
 
+	scp->reg_base = of_regs->reg_base;
+	scp->l1tcm_base = of_regs->l1tcm_base;
+	scp->l1tcm_size = of_regs->l1tcm_size;
+	scp->l1tcm_phys = of_regs->l1tcm_phys;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
 	scp->sram_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(scp->sram_base))
@@ -887,24 +893,6 @@ static int scp_probe(struct platform_device *pdev)
 	scp->sram_size = resource_size(res);
 	scp->sram_phys = res->start;
 
-	/* l1tcm is an optional memory region */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "l1tcm");
-	scp->l1tcm_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(scp->l1tcm_base)) {
-		ret = PTR_ERR(scp->l1tcm_base);
-		if (ret != -EINVAL) {
-			return dev_err_probe(dev, ret, "Failed to map l1tcm memory\n");
-		}
-	} else {
-		scp->l1tcm_size = resource_size(res);
-		scp->l1tcm_phys = res->start;
-	}
-
-	scp->reg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
-	if (IS_ERR(scp->reg_base))
-		return dev_err_probe(dev, PTR_ERR(scp->reg_base),
-				     "Failed to parse and map cfg memory\n");
-
 	ret = scp->data->scp_clk_get(scp);
 	if (ret)
 		return ret;
@@ -932,7 +920,6 @@ static int scp_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0), NULL,
 					scp_irq_handler, IRQF_ONESHOT,
 					pdev->name, scp);
-
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
 		goto remove_subdev;
@@ -956,6 +943,34 @@ static int scp_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int scp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct mtk_scp_of_regs scp_regs;
+	int ret;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+	scp_regs.reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(scp_regs.reg_base))
+		return dev_err_probe(dev, PTR_ERR(scp_regs.reg_base),
+				     "Failed to parse and map cfg memory\n");
+
+	/* l1tcm is an optional memory region */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "l1tcm");
+	scp_regs.l1tcm_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(scp_regs.l1tcm_base)) {
+		ret = PTR_ERR(scp_regs.l1tcm_base);
+		if (ret != -EINVAL)
+			return dev_err_probe(dev, ret, "Failed to map l1tcm memory\n");
+	} else {
+		scp_regs.l1tcm_size = resource_size(res);
+		scp_regs.l1tcm_phys = res->start;
+	}
+
+	return scp_rproc_init(pdev, &scp_regs);
+}
+
 static int scp_remove(struct platform_device *pdev)
 {
 	struct mtk_scp *scp = platform_get_drvdata(pdev);
-- 
2.18.0

