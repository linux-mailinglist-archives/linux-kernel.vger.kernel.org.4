Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58C072557C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbjFGHXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbjFGHWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:22:39 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC57173B;
        Wed,  7 Jun 2023 00:22:36 -0700 (PDT)
X-UUID: 0ce55268050411eeb20a276fd37b9834-20230607
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5NKxD9mELFEypwzYoUzbCsi3BBnNAKNkMuH30HSMTiY=;
        b=rHGB3zlnpfagUdDq9Vhq1CGtrRV5bHFf6zWTAfAOd2lEoCkREpwRaNGPkrUMYio31E97qNL9wibcN72TGqWPdfKBKL5d/RDYz7Algomq+uLx5r37fkEna/cMFsC3NluWzAymA19GZFlobP3KaQ7Z//jdbjZjcatVM6m6dbkQNus=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:e8e9ddb9-0bb4-4197-8eca-5576a59d0567,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.25,REQID:e8e9ddb9-0bb4-4197-8eca-5576a59d0567,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:d5b0ae3,CLOUDID:155cd63d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230607152227669MOYSH,BulkQuantity:0,Recheck:0,SF:28|17|19|48|38|29,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 0ce55268050411eeb20a276fd37b9834-20230607
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 44255136; Wed, 07 Jun 2023 15:22:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 15:22:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 15:22:24 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v13 05/11] remoteproc: mediatek: Introduce cluster on single-core SCP
Date:   Wed, 7 Jun 2023 15:22:16 +0800
Message-ID: <20230607072222.8628-6-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230607072222.8628-1-tinghan.shen@mediatek.com>
References: <20230607072222.8628-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the preliminary step for probing multi-core SCP.
The initialization procedure for remoteproc is similar for both
single-core and multi-core architectures and is reusing to avoid
redundant code.

Rewrite the probing flow of single-core SCP to adapt with the 'cluster'
concept needed by probing the multi-core SCP. The main differences
are,
- the SCP core object(s) is maintained at the cluster list instead of at
  the platofmr device driver data property.
- save the cluster information at the platofmr device driver data property.
- In order to keep the compatibility of exported SCP APIs which getting
  the SCP core object by SCP node phandle, move the SCP core object
  pointers to the platform device platform data property.

The registers of config and l1tcm are shared for multi-core
SCP. Reuse the mapped addresses for all cores.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_common.h |   2 +
 drivers/remoteproc/mtk_scp.c    | 151 +++++++++++++++++++++++---------
 2 files changed, 112 insertions(+), 41 deletions(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index c0905aec3b4b..56395e8664cb 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -128,6 +128,8 @@ struct mtk_scp {
 	size_t dram_size;
 
 	struct rproc_subdev *rpmsg_subdev;
+
+	struct list_head elem;
 };
 
 /**
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index d66822dad943..c8fc6b46f82b 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -23,6 +23,14 @@
 #define MAX_CODE_SIZE 0x500000
 #define SECTION_NAME_IPI_BUFFER ".ipi_buffer"
 
+struct mtk_scp_of_cluster {
+	void __iomem *reg_base;
+	void __iomem *l1tcm_base;
+	size_t l1tcm_size;
+	phys_addr_t l1tcm_phys;
+	struct list_head mtk_scp_list;
+};
+
 /**
  * scp_get() - get a reference to SCP.
  *
@@ -51,7 +59,7 @@ struct mtk_scp *scp_get(struct platform_device *pdev)
 		return NULL;
 	}
 
-	return platform_get_drvdata(scp_pdev);
+	return *(struct mtk_scp **)dev_get_platdata(&scp_pdev->dev);
 }
 EXPORT_SYMBOL_GPL(scp_get);
 
@@ -810,14 +818,14 @@ static void scp_unmap_memory_region(struct mtk_scp *scp)
 static int scp_register_ipi(struct platform_device *pdev, u32 id,
 			    ipi_handler_t handler, void *priv)
 {
-	struct mtk_scp *scp = platform_get_drvdata(pdev);
+	struct mtk_scp *scp = *(struct mtk_scp **)dev_get_platdata(&pdev->dev);
 
 	return scp_ipi_register(scp, id, handler, priv);
 }
 
 static void scp_unregister_ipi(struct platform_device *pdev, u32 id)
 {
-	struct mtk_scp *scp = platform_get_drvdata(pdev);
+	struct mtk_scp *scp = *(struct mtk_scp **)dev_get_platdata(&pdev->dev);
 
 	scp_ipi_unregister(scp, id);
 }
@@ -825,7 +833,7 @@ static void scp_unregister_ipi(struct platform_device *pdev, u32 id)
 static int scp_send_ipi(struct platform_device *pdev, u32 id, void *buf,
 			unsigned int len, unsigned int wait)
 {
-	struct mtk_scp *scp = platform_get_drvdata(pdev);
+	struct mtk_scp *scp = *(struct mtk_scp **)dev_get_platdata(&pdev->dev);
 
 	return scp_ipi_send(scp, id, buf, len, wait);
 }
@@ -855,7 +863,8 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
 	}
 }
 
-static int scp_probe(struct platform_device *pdev)
+static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
+				      struct mtk_scp_of_cluster *scp_cluster)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -867,52 +876,42 @@ static int scp_probe(struct platform_device *pdev)
 
 	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
 	if (ret < 0 && ret != -EINVAL)
-		return ret;
+		return ERR_PTR(ret);
 
 	rproc = devm_rproc_alloc(dev, np->name, &scp_ops, fw_name, sizeof(*scp));
-	if (!rproc)
-		return dev_err_probe(dev, -ENOMEM, "unable to allocate remoteproc\n");
+	if (!rproc) {
+		dev_err(dev, "unable to allocate remoteproc\n");
+		return ERR_PTR(-ENOMEM);
+	}
 
 	scp = rproc->priv;
 	scp->rproc = rproc;
 	scp->dev = dev;
 	scp->data = of_device_get_match_data(dev);
-	platform_set_drvdata(pdev, scp);
+	platform_device_add_data(pdev, &scp, sizeof(scp));
+
+	scp->reg_base = scp_cluster->reg_base;
+	scp->l1tcm_base = scp_cluster->l1tcm_base;
+	scp->l1tcm_size = scp_cluster->l1tcm_size;
+	scp->l1tcm_phys = scp_cluster->l1tcm_phys;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
 	scp->sram_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(scp->sram_base))
-		return dev_err_probe(dev, PTR_ERR(scp->sram_base),
-				     "Failed to parse and map sram memory\n");
+	if (IS_ERR(scp->sram_base)) {
+		dev_err(dev, "Failed to parse and map sram memory\n");
+		return ERR_PTR(PTR_ERR(scp->sram_base));
+	}
 
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
-		return ret;
+		return ERR_PTR(ret);
 
 	ret = scp_map_memory_region(scp);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
 
 	mutex_init(&scp->send_lock);
 	for (i = 0; i < SCP_IPI_MAX; i++)
@@ -939,11 +938,7 @@ static int scp_probe(struct platform_device *pdev)
 		goto remove_subdev;
 	}
 
-	ret = rproc_add(rproc);
-	if (ret)
-		goto remove_subdev;
-
-	return 0;
+	return scp;
 
 remove_subdev:
 	scp_remove_rpmsg_subdev(scp);
@@ -954,15 +949,13 @@ static int scp_probe(struct platform_device *pdev)
 		mutex_destroy(&scp->ipi_desc[i].lock);
 	mutex_destroy(&scp->send_lock);
 
-	return ret;
+	return ERR_PTR(ret);
 }
 
-static void scp_remove(struct platform_device *pdev)
+static void scp_free(struct mtk_scp *scp)
 {
-	struct mtk_scp *scp = platform_get_drvdata(pdev);
 	int i;
 
-	rproc_del(scp->rproc);
 	scp_remove_rpmsg_subdev(scp);
 	scp_ipi_unregister(scp, SCP_IPI_INIT);
 	scp_unmap_memory_region(scp);
@@ -971,6 +964,82 @@ static void scp_remove(struct platform_device *pdev)
 	mutex_destroy(&scp->send_lock);
 }
 
+static int scp_cluster_init(struct platform_device *pdev)
+{
+	struct mtk_scp_of_cluster *scp_cluster = platform_get_drvdata(pdev);
+	struct list_head *cluster = &scp_cluster->mtk_scp_list;
+	struct mtk_scp *scp;
+	int ret;
+
+	scp = scp_rproc_init(pdev, scp_cluster);
+	if (IS_ERR(scp))
+		return PTR_ERR(scp);
+
+	ret = rproc_add(scp->rproc);
+	if (ret) {
+		dev_err(dev, "Failed to add rproc\n");
+		scp_free(scp);
+		return ret;
+	}
+
+	list_add_tail(&scp->elem, cluster);
+
+	return 0;
+}
+
+static int scp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_scp_of_cluster *scp_cluster;
+	struct resource *res;
+	int ret;
+
+	scp_cluster = devm_kzalloc(dev, sizeof(*scp_cluster), GFP_KERNEL);
+	if (!scp_cluster)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+	scp_cluster->reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(scp_cluster->reg_base))
+		return dev_err_probe(dev, PTR_ERR(scp_cluster->reg_base),
+				     "Failed to parse and map cfg memory\n");
+
+	/* l1tcm is an optional memory region */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "l1tcm");
+	scp_cluster->l1tcm_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(scp_cluster->l1tcm_base)) {
+		ret = PTR_ERR(scp_cluster->l1tcm_base);
+		if (ret != -EINVAL)
+			return dev_err_probe(dev, ret, "Failed to map l1tcm memory\n");
+
+		scp_cluster->l1tcm_base = NULL;
+	} else {
+		scp_cluster->l1tcm_size = resource_size(res);
+		scp_cluster->l1tcm_phys = res->start;
+	}
+
+	INIT_LIST_HEAD(&scp_cluster->mtk_scp_list);
+	platform_set_drvdata(pdev, scp_cluster);
+
+	ret = scp_cluster_init(pdev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void scp_remove(struct platform_device *pdev)
+{
+	struct mtk_scp_of_cluster *scp_cluster = platform_get_drvdata(pdev);
+	struct mtk_scp *scp, *temp;
+
+	list_for_each_entry_safe_reverse(scp, temp, &scp_cluster->mtk_scp_list, elem) {
+		list_del(&scp->elem);
+		rproc_del(scp->rproc);
+		scp_free(scp);
+	}
+}
+
 static const struct mtk_scp_of_data mt8183_of_data = {
 	.scp_clk_get = mt8183_scp_clk_get,
 	.scp_before_load = mt8183_scp_before_load,
-- 
2.18.0

