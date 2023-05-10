Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9346FD749
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbjEJGil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbjEJGiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:38:13 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9C14696;
        Tue,  9 May 2023 23:38:09 -0700 (PDT)
X-UUID: 34970422eefd11ed9cb5633481061a41-20230510
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=A5w1Y9kKDf3ghriD/byaAXR4kdm7iJecw2YnA3oUPcg=;
        b=HI2wLeEIomoaL4aTadc41KxYF7EyLl8JpfTkjnyzSlVn17FL9F8mqM+y6ZKSgbE/yMqmR8Ha2LvxtRJvBQiiCYot2ra+QWDEoATixB1uLXOOR1flpaxKSZ9fv+Fw1vQrOpsv6ikc7zAjSb28CxoYmwAWwmP6MqNhkXfjAcYdUzg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:c3fbf7f4-74ad-4842-a7fa-83d241c69bfd,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:178d4d4,CLOUDID:c4d9b03a-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 34970422eefd11ed9cb5633481061a41-20230510
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1198008634; Wed, 10 May 2023 14:37:59 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.194) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 May 2023 14:37:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 May 2023 14:37:57 +0800
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
Subject: [PATCH v11 05/11] remoteproc: mediatek: Introduce cluster on single-core SCP
Date:   Wed, 10 May 2023 14:37:43 +0800
Message-ID: <20230510063749.5127-6-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230510063749.5127-1-tinghan.shen@mediatek.com>
References: <20230510063749.5127-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the preliminary step for probing multi-core SCP.
The initialization procedure for remoteproc is similar for both
single-core and multi-core architectures and is reusing to avoid
redundant code.

Adapt the probing flow of single-core SCP to incorporate the 'cluster'
concept required for probing multi-core SCP.The main differences are,

  - the SCP core object is maintained in the cluster list,
    instead of in the driver data property.
  - the cluster information is saved in the driver data property.
  - To maintain compatibility with exported SCP APIs that get
    the SCP core object by SCP node phandle, the SCP core object pointers
    are moved to the platform data property.

The registers of config and l1tcm are shared for multi-core
SCP. Reuse the mapped addresses for all cores.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_common.h |   2 +
 drivers/remoteproc/mtk_scp.c    | 143 ++++++++++++++++++++++----------
 2 files changed, 103 insertions(+), 42 deletions(-)

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
index d66822dad943..6c4da7332896 100644
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
+	struct list_head mtk_scp_cluster;
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
@@ -943,7 +942,7 @@ static int scp_probe(struct platform_device *pdev)
 	if (ret)
 		goto remove_subdev;
 
-	return 0;
+	return scp;
 
 remove_subdev:
 	scp_remove_rpmsg_subdev(scp);
@@ -954,21 +953,81 @@ static int scp_probe(struct platform_device *pdev)
 		mutex_destroy(&scp->ipi_desc[i].lock);
 	mutex_destroy(&scp->send_lock);
 
-	return ret;
+	return ERR_PTR(ret);
+}
+
+static int scp_cluster_init(struct platform_device *pdev)
+{
+	struct mtk_scp *scp;
+	struct mtk_scp_of_cluster *scp_cluster = platform_get_drvdata(pdev);
+	struct list_head *cluster = &scp_cluster->mtk_scp_cluster;
+
+	scp = scp_rproc_init(pdev, scp_cluster);
+	if (IS_ERR(scp))
+		return PTR_ERR(scp);
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
+	scp_cluster = devm_kzalloc(&pdev->dev, sizeof(*scp_cluster), GFP_KERNEL);
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
+	INIT_LIST_HEAD(&scp_cluster->mtk_scp_cluster);
+	platform_set_drvdata(pdev, scp_cluster);
+
+	ret = scp_cluster_init(pdev);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static void scp_remove(struct platform_device *pdev)
 {
-	struct mtk_scp *scp = platform_get_drvdata(pdev);
+	struct mtk_scp_of_cluster *scp_cluster = platform_get_drvdata(pdev);
+	struct mtk_scp *scp, *temp;
 	int i;
 
-	rproc_del(scp->rproc);
-	scp_remove_rpmsg_subdev(scp);
-	scp_ipi_unregister(scp, SCP_IPI_INIT);
-	scp_unmap_memory_region(scp);
-	for (i = 0; i < SCP_IPI_MAX; i++)
-		mutex_destroy(&scp->ipi_desc[i].lock);
-	mutex_destroy(&scp->send_lock);
+	list_for_each_entry_safe_reverse(scp, temp, &scp_cluster->mtk_scp_cluster, elem) {
+		list_del(&scp->elem);
+		rproc_del(scp->rproc);
+		scp_remove_rpmsg_subdev(scp);
+		scp_ipi_unregister(scp, SCP_IPI_INIT);
+		scp_unmap_memory_region(scp);
+		for (i = 0; i < SCP_IPI_MAX; i++)
+			mutex_destroy(&scp->ipi_desc[i].lock);
+		mutex_destroy(&scp->send_lock);
+	}
 }
 
 static const struct mtk_scp_of_data mt8183_of_data = {
-- 
2.18.0

