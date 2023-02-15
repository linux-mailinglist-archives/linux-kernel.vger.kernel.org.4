Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5107C697545
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjBOEOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjBOEN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:13:26 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1179C32E56;
        Tue, 14 Feb 2023 20:13:11 -0800 (PST)
X-UUID: 08781a3cace711eda06fc9ecc4dadd91-20230215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wLykTSuS4LOn7yeT2/ovRf1YfA33Qvph81779tT4mJ8=;
        b=GRg+eakD0zL8HHat4tklzxv20CIxm+Qg92EFkyrVlAaTdqxt+vbiqW1gHg/XbjTGMWoL1BVL/PTd54GFPTWSXBWziFDe4WfZ7n/kNSU5czWZTidBhyMUkI62b+9v604+Vt/C6/kk0zVYhzpc3eZzIKPF+cXrS6JgHhAttDR9RaE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:8ab1ad58-db48-462d-81c9-73e32d0e4726,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:885ddb2,CLOUDID:397709f3-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 08781a3cace711eda06fc9ecc4dadd91-20230215
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 146572363; Wed, 15 Feb 2023 12:12:59 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 15 Feb 2023 12:12:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 15 Feb 2023 12:12:59 +0800
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
Subject: [PATCH v7 07/12] remoteproc: mediatek: Probe multi-core SCP
Date:   Wed, 15 Feb 2023 12:12:52 +0800
Message-ID: <20230215041257.14548-8-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230215041257.14548-1-tinghan.shen@mediatek.com>
References: <20230215041257.14548-1-tinghan.shen@mediatek.com>
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
 drivers/remoteproc/mtk_common.h |   4 +
 drivers/remoteproc/mtk_scp.c    | 179 +++++++++++++++++++++++++++++---
 2 files changed, 168 insertions(+), 15 deletions(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 3778894c96f3..7821cb15d6fd 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -140,6 +140,10 @@ struct mtk_scp {
 	size_t dram_size;
 
 	struct rproc_subdev *rpmsg_subdev;
+
+	struct list_head elem;
+	struct list_head cluster_cores;
+	struct list_head *cluster;
 };
 
 /**
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 6270c388727a..6588e5acb159 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -862,7 +862,9 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
 }
 
 static int scp_rproc_init(struct platform_device *pdev,
-			  struct mtk_scp_of_regs *of_regs)
+			  struct mtk_scp_of_regs *of_regs,
+			  const struct mtk_scp_of_data *of_data,
+			  bool is_multi_core)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -883,7 +885,7 @@ static int scp_rproc_init(struct platform_device *pdev,
 	scp = (struct mtk_scp *)rproc->priv;
 	scp->rproc = rproc;
 	scp->dev = dev;
-	scp->data = of_device_get_match_data(dev);
+	scp->data = of_data;
 	platform_set_drvdata(pdev, scp);
 
 	scp->reg_base = of_regs->reg_base;
@@ -932,9 +934,11 @@ static int scp_rproc_init(struct platform_device *pdev,
 		goto remove_subdev;
 	}
 
-	ret = rproc_add(rproc);
-	if (ret)
-		goto remove_subdev;
+	if (!is_multi_core) {
+		ret = rproc_add(rproc);
+		if (ret)
+			goto remove_subdev;
+	}
 
 	return 0;
 
@@ -950,9 +954,125 @@ static int scp_rproc_init(struct platform_device *pdev,
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
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev_of_node(dev);
+	struct platform_device *cpdev;
+	struct device_node *child;
+	const struct mtk_scp_of_data **cluster_of_data;
+	struct list_head *cluster;
+	struct mtk_scp *scp, *temp;
+	int core_id, num_cores;
+	int ret;
+
+	cluster_of_data = (const struct mtk_scp_of_data **)of_device_get_match_data(dev);
+
+	for (num_cores = 0; cluster_of_data[num_cores]; num_cores++)
+		;
+
+	cluster = NULL;
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
+		ret = scp_rproc_init(cpdev, of_regs, cluster_of_data[core_id], true);
+		if (ret) {
+			dev_err(dev, "Failed to initialize core %d rproc\n", core_id);
+			put_device(&cpdev->dev);
+			of_node_put(child);
+			goto init_fail;
+		}
+
+		scp = platform_get_drvdata(cpdev);
+		put_device(&cpdev->dev);
+		if (core_id == 0) {
+			INIT_LIST_HEAD(&scp->cluster_cores);
+			cluster = &scp->cluster_cores;
+			platform_set_drvdata(pdev, cluster);
+		}
+
+		list_add_tail(&scp->elem, cluster);
+		scp->cluster = cluster;
+
+		of_node_put(child);
+		core_id++;
+	}
+
+	list_for_each_entry_safe_reverse(scp, temp, cluster, elem) {
+		ret = rproc_add(scp->rproc);
+		if (ret)
+			goto add_fail;
+	}
+
+	return 0;
+
+add_fail:
+	list_for_each_entry_continue(scp, cluster, elem) {
+		rproc_del(scp->rproc);
+	}
+init_fail:
+	if (cluster) {
+		list_for_each_entry_safe_reverse(scp, temp, cluster, elem) {
+			list_del(&scp->elem);
+			scp_rproc_free(scp);
+		}
+	}
+	return ret;
+}
+
+static void scp_cluster_exit(struct platform_device *pdev)
+{
+	struct list_head *cluster = platform_get_drvdata(pdev);
+	struct platform_device *cpdev;
+	struct mtk_scp *scp, *temp;
+
+	list_for_each_entry_safe_reverse(scp, temp, cluster, elem) {
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
 	int ret;
@@ -975,21 +1095,43 @@ static int scp_probe(struct platform_device *pdev)
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
+		ret = scp_rproc_init(pdev, &scp_regs, of_device_get_match_data(dev), false);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to initialize single-core scp\n");
+	} else {
+		dev_info(dev, "multi-core scp\n");
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
@@ -1068,12 +1210,19 @@ static const struct mtk_scp_of_data mt8195_of_data_c1 = {
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

