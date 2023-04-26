Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D416EF0D8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbjDZJOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239998AbjDZJMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:12:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C6E449D;
        Wed, 26 Apr 2023 02:12:36 -0700 (PDT)
X-UUID: 75c9b99ee41211edb6b9f13eb10bd0fe-20230426
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SZjevMFr3hN/VIx2NgbZTpSz9vi5eily31NZvHvjAig=;
        b=d/0MolekIkgFlmOmm5bJ2M+OSdPC9FkFyNk4pqDESxM3fzXAW3VpfN/vThpze4z6Y1vW4xCi3SRW1oRP3Pt+rqMQj0RA1q1nE/5McTeecgG9zg+WO7V9k1LMKny5P2fU7gNp03I5HP5lH1kaUCIhjZsw/enkTRS6mVG3QOkssrc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:8ff7d942-7733-4dff-9359-1927aa1ac090,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:120426c,CLOUDID:72bd34ec-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 75c9b99ee41211edb6b9f13eb10bd0fe-20230426
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1083764236; Wed, 26 Apr 2023 17:12:25 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 26 Apr 2023 17:12:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 26 Apr 2023 17:12:24 +0800
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
Subject: [PATCH v10 05/11] remoteproc: mediatek: Extract remoteproc initialization flow
Date:   Wed, 26 Apr 2023 17:12:05 +0800
Message-ID: <20230426091211.21557-6-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230426091211.21557-1-tinghan.shen@mediatek.com>
References: <20230426091211.21557-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the preparation for probing multi-core SCP. The remoteproc
initialization flow is similar on cores and is reused to avoid
redundant code.

The registers of config and l1tcm are shared for multi-core
SCP. Reuse the mapped addresses for all cores.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/remoteproc/mtk_scp.c | 69 ++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 2bf66b1a8d80..5e4982f4d5dc 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -23,6 +23,13 @@
 #define MAX_CODE_SIZE 0x500000
 #define SECTION_NAME_IPI_BUFFER ".ipi_buffer"
 
+struct mtk_scp_of_cluster {
+	void __iomem *reg_base;
+	void __iomem *l1tcm_base;
+	size_t l1tcm_size;
+	phys_addr_t l1tcm_phys;
+};
+
 /**
  * scp_get() - get a reference to SCP.
  *
@@ -855,10 +862,11 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
 	}
 }
 
-static int scp_probe(struct platform_device *pdev)
+static int scp_rproc_init(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	struct mtk_scp_of_cluster *of_cluster = platform_get_drvdata(pdev);
 	struct mtk_scp *scp;
 	struct rproc *rproc;
 	struct resource *res;
@@ -879,6 +887,11 @@ static int scp_probe(struct platform_device *pdev)
 	scp->data = of_device_get_match_data(dev);
 	platform_set_drvdata(pdev, scp);
 
+	scp->reg_base = of_cluster->reg_base;
+	scp->l1tcm_base = of_cluster->l1tcm_base;
+	scp->l1tcm_size = of_cluster->l1tcm_size;
+	scp->l1tcm_phys = of_cluster->l1tcm_phys;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
 	scp->sram_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(scp->sram_base))
@@ -888,24 +901,6 @@ static int scp_probe(struct platform_device *pdev)
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
@@ -957,6 +952,42 @@ static int scp_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int scp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_scp_of_cluster *of_cluster;
+	struct resource *res;
+	int ret;
+
+	of_cluster = devm_kzalloc(&pdev->dev, sizeof(*of_cluster), GFP_KERNEL);
+	if (!of_cluster)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+	of_cluster->reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(of_cluster->reg_base))
+		return dev_err_probe(dev, PTR_ERR(of_cluster->reg_base),
+				     "Failed to parse and map cfg memory\n");
+
+	/* l1tcm is an optional memory region */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "l1tcm");
+	of_cluster->l1tcm_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(of_cluster->l1tcm_base)) {
+		ret = PTR_ERR(of_cluster->l1tcm_base);
+		if (ret != -EINVAL)
+			return dev_err_probe(dev, ret, "Failed to map l1tcm memory\n");
+
+		of_cluster->l1tcm_base = NULL;
+	} else {
+		of_cluster->l1tcm_size = resource_size(res);
+		of_cluster->l1tcm_phys = res->start;
+	}
+
+	platform_set_drvdata(pdev, of_cluster);
+
+	return scp_rproc_init(pdev);
+}
+
 static int scp_remove(struct platform_device *pdev)
 {
 	struct mtk_scp *scp = platform_get_drvdata(pdev);
-- 
2.18.0

