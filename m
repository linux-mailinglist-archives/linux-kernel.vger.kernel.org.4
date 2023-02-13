Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0448F693D12
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 04:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjBMDir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 22:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBMDiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 22:38:19 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB8FCC2C;
        Sun, 12 Feb 2023 19:38:15 -0800 (PST)
X-UUID: d2b4a426ab4f11eda06fc9ecc4dadd91-20230213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=b5t2Z+WOOYoxxipSNq6Ylw1/7XcqBaaI7oFa7Np+alo=;
        b=rjAgB3YGSLuMEnPx5REFRMvB3qTnvqRO2sWISi5PHcA+VYUHc9wGxRQG4Ghx7k0CDmiXUIba4RJnjuMCGSbwe70AfsnUJ4bxHMCGRlWxuMEBco6josFjwVzNnwUMkA1ki1KNaNwQXiQAdMlJowtZZMQQvMf/CxlwMdbWZOTsF20=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:df06b904-28ba-42ae-9338-115ac54220db,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.19,REQID:df06b904-28ba-42ae-9338-115ac54220db,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:885ddb2,CLOUDID:68823cf8-ff42-4fb0-b929-626456a83c14,B
        ulkID:2302131138079ABHDLGS,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: d2b4a426ab4f11eda06fc9ecc4dadd91-20230213
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1390800571; Mon, 13 Feb 2023 11:38:04 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 13 Feb 2023 11:38:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 13 Feb 2023 11:38:03 +0800
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
Subject: [PATCH v6 07/12] remoteproc: mediatek: Probe multi-core SCP
Date:   Mon, 13 Feb 2023 11:37:53 +0800
Message-ID: <20230213033758.16681-8-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230213033758.16681-1-tinghan.shen@mediatek.com>
References: <20230213033758.16681-1-tinghan.shen@mediatek.com>
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

The difference of single-core SCP and multi-core SCP device tree is
the presence of child device nodes described SCP cores. The SCP
driver populates the platform device and checks the child nodes
to identify whether it's a single-core SCP or a multi-core SCP.

The resource structure of the multi-core SCP is a list of remoteproc
instances which is different to the single-core SCP. The corresponding
resource releasing action is based on the type of SCP.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_common.h |   7 ++
 drivers/remoteproc/mtk_scp.c    | 177 +++++++++++++++++++++++++++++---
 2 files changed, 169 insertions(+), 15 deletions(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 3778894c96f3..635b17676de8 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -112,6 +112,10 @@ struct mtk_scp_of_data {
 	size_t ipi_buf_offset;
 };
 
+struct mtk_scp_cluster {
+	struct list_head cores;
+};
+
 struct mtk_scp {
 	struct device *dev;
 	struct rproc *rproc;
@@ -140,6 +144,9 @@ struct mtk_scp {
 	size_t dram_size;
 
 	struct rproc_subdev *rpmsg_subdev;
+
+	struct list_head elem;
+	struct mtk_scp_cluster *cluster;
 };
 
 /**
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 6270c388727a..fd054a06ea5b 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -862,7 +862,9 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
 }
 
 static int scp_rproc_init(struct platform_device *pdev,
-			  struct mtk_scp_of_regs *of_regs)
+			  struct mtk_scp_of_regs *of_regs,
+			  const struct mtk_scp_of_data *of_data,
+			  struct mtk_scp_cluster *cluster)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -883,7 +885,8 @@ static int scp_rproc_init(struct platform_device *pdev,
 	scp = (struct mtk_scp *)rproc->priv;
 	scp->rproc = rproc;
 	scp->dev = dev;
-	scp->data = of_device_get_match_data(dev);
+	scp->data = of_data;
+	scp->cluster = cluster;
 	platform_set_drvdata(pdev, scp);
 
 	scp->reg_base = of_regs->reg_base;
@@ -932,9 +935,13 @@ static int scp_rproc_init(struct platform_device *pdev,
 		goto remove_subdev;
 	}
 
-	ret = rproc_add(rproc);
-	if (ret)
-		goto remove_subdev;
+	if (scp->cluster) {
+		list_add_tail(&scp->elem, &scp->cluster->cores);
+	} else {
+		ret = rproc_add(rproc);
+		if (ret)
+			goto remove_subdev;
+	}
 
 	return 0;
 
@@ -950,11 +957,115 @@ static int scp_rproc_init(struct platform_device *pdev,
 	return ret;
 }
 
+static void scp_rproc_free(struct mtk_scp *scp)
+{
+	int i;
+
+	scp_remove_rpmsg_subdev(scp);
+	scp_ipi_unregister(scp, SCP_IPI_INIT);
+	scp_unmap_memory_region(scp);
+	for (i = 0; i < SCP_IPI_MAX; i++)
+		mutex_destroy(&scp->ipi_desc[i].lock);
+	mutex_destroy(&scp->send_lock);
+}
+
+static void scp_rproc_exit(struct platform_device *pdev)
+{
+	struct mtk_scp *scp = platform_get_drvdata(pdev);
+
+	rproc_del(scp->rproc);
+	scp_rproc_free(scp);
+}
+
+static int scp_cluster_init(struct platform_device *pdev,
+			    struct mtk_scp_of_regs *of_regs)
+{
+	struct mtk_scp_cluster *cluster = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev_of_node(dev);
+	struct platform_device *cpdev;
+	struct device_node *child;
+	const struct mtk_scp_of_data **cluster_of_data;
+	struct mtk_scp *scp, *temp;
+	int core_id, num_cores;
+	int ret;
+
+	cluster_of_data = (const struct mtk_scp_of_data **)of_device_get_match_data(dev);
+
+	for (num_cores = 0; cluster_of_data[num_cores]; num_cores++)
+		;
+
+	core_id = 0;
+	for_each_available_child_of_node(np, child) {
+		if (core_id >= num_cores) {
+			ret = -EINVAL;
+			dev_err(dev, "Not support core %d\n", core_id);
+			of_node_put(child);
+			goto init_fail;
+		}
+
+		cpdev = of_find_device_by_node(child);
+		if (!cpdev) {
+			ret = -ENODEV;
+			dev_err(dev, "Not found platform device for core %d\n", core_id);
+			of_node_put(child);
+			goto init_fail;
+		}
+
+		ret = scp_rproc_init(cpdev, of_regs, cluster_of_data[core_id], cluster);
+		put_device(&cpdev->dev);
+		if (ret) {
+			dev_err(dev, "Failed to initialize core %d rproc\n", core_id);
+			of_node_put(child);
+			goto init_fail;
+		}
+
+		of_node_put(child);
+		core_id++;
+	}
+
+	list_for_each_entry_safe_reverse(scp, temp, &cluster->cores, elem) {
+		ret = rproc_add(scp->rproc);
+		if (ret)
+			goto add_fail;
+	}
+
+	return 0;
+
+add_fail:
+	list_for_each_entry_continue(scp, &cluster->cores, elem) {
+		rproc_del(scp->rproc);
+	}
+init_fail:
+	list_for_each_entry_safe_reverse(scp, temp, &cluster->cores, elem) {
+		list_del(&scp->elem);
+		cpdev = to_platform_device(scp->dev);
+		scp_rproc_free(scp);
+	}
+	return ret;
+}
+
+static void scp_cluster_exit(struct platform_device *pdev)
+{
+	struct mtk_scp_cluster *cluster = platform_get_drvdata(pdev);
+	struct platform_device *cpdev;
+	struct mtk_scp *scp, *temp;
+
+	list_for_each_entry_safe_reverse(scp, temp, &cluster->cores, elem) {
+		list_del(&scp->elem);
+		cpdev = to_platform_device(scp->dev);
+		scp_rproc_exit(cpdev);
+	}
+}
+
 static int scp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *core_node;
 	struct resource *res;
 	struct mtk_scp_of_regs scp_regs;
+	struct mtk_scp_cluster *cluster;
 	int ret;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
@@ -975,21 +1086,50 @@ static int scp_probe(struct platform_device *pdev)
 		scp_regs.l1tcm_phys = res->start;
 	}
 
-	return scp_rproc_init(pdev, &scp_regs);
+	ret = devm_of_platform_populate(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to populate platform devices\n");
+
+	core_node = of_get_child_by_name(np, "scp");
+	of_node_put(core_node);
+
+	if (!core_node) {
+		dev_info(dev, "single-core scp\n");
+
+		ret = scp_rproc_init(pdev, &scp_regs, of_device_get_match_data(dev), NULL);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to initialize single-core scp\n");
+	} else {
+		dev_info(dev, "multi-core scp\n");
+
+		cluster = devm_kzalloc(dev, sizeof(*cluster), GFP_KERNEL);
+		if (!cluster)
+			return dev_err_probe(dev, -ENOMEM, "Unable to allocate scp cluster\n");
+
+		INIT_LIST_HEAD(&cluster->cores);
+		platform_set_drvdata(pdev, cluster);
+
+		ret = scp_cluster_init(pdev, &scp_regs);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to initialize scp cluster\n");
+	}
+
+	return 0;
 }
 
 static int scp_remove(struct platform_device *pdev)
 {
-	struct mtk_scp *scp = platform_get_drvdata(pdev);
-	int i;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *core_node;
 
-	rproc_del(scp->rproc);
-	scp_remove_rpmsg_subdev(scp);
-	scp_ipi_unregister(scp, SCP_IPI_INIT);
-	scp_unmap_memory_region(scp);
-	for (i = 0; i < SCP_IPI_MAX; i++)
-		mutex_destroy(&scp->ipi_desc[i].lock);
-	mutex_destroy(&scp->send_lock);
+	core_node = of_get_child_by_name(np, "scp");
+	of_node_put(core_node);
+
+	if (!core_node)
+		scp_rproc_exit(pdev);
+	else
+		scp_cluster_exit(pdev);
 
 	return 0;
 }
@@ -1068,12 +1208,19 @@ static const struct mtk_scp_of_data mt8195_of_data_c1 = {
 	.host_to_scp_int_bit = MT8195_CORE1_HOST_IPC_INT_BIT,
 };
 
+static const struct mtk_scp_of_data *mt8195_of_data_cores[] = {
+	&mt8195_of_data,
+	&mt8195_of_data_c1,
+	NULL
+};
+
 static const struct of_device_id mtk_scp_of_match[] = {
 	{ .compatible = "mediatek,mt8183-scp", .data = &mt8183_of_data },
 	{ .compatible = "mediatek,mt8186-scp", .data = &mt8186_of_data },
 	{ .compatible = "mediatek,mt8188-scp", .data = &mt8188_of_data },
 	{ .compatible = "mediatek,mt8192-scp", .data = &mt8192_of_data },
 	{ .compatible = "mediatek,mt8195-scp", .data = &mt8195_of_data },
+	{ .compatible = "mediatek,mt8195-scp-dual", .data = &mt8195_of_data_cores },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_scp_of_match);
-- 
2.18.0

