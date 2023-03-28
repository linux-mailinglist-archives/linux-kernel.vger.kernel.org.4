Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A726CB40B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjC1C2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjC1C2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:28:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770F0DD;
        Mon, 27 Mar 2023 19:28:04 -0700 (PDT)
X-UUID: 26b5f6f6cd1011eda9a90f0bb45854f4-20230328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PWifEkb0OIatmNEx/6KTrWcEBReepHuUz42K0jTyRHM=;
        b=g6aW9+IQcVd34roWCvZzXr292FoeSd46iuDmX62nfIeS6qkks2xAXUwCtU0uJDpxNtdS+jM5sl+nUZDB19xNW63Tj9OIPPAA0ZH9Bh61XFaWD/rBay1fgWpZbKr6oZiPbUbV3er1ftXM6UBE8gP6eU1UaE7a7tcFeGGZjMJwPH4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:9e5f9078-dae7-4ec9-978c-1d98cb8ef596,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.22,REQID:9e5f9078-dae7-4ec9-978c-1d98cb8ef596,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:120426c,CLOUDID:7dc8ac29-564d-42d9-9875-7c868ee415ec,B
        ulkID:230328102759H1WIPOQG,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 26b5f6f6cd1011eda9a90f0bb45854f4-20230328
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1608841717; Tue, 28 Mar 2023 10:27:57 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 28 Mar 2023 10:27:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 28 Mar 2023 10:27:55 +0800
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
Subject: [PATCH v9 06/11] remoteproc: mediatek: Probe multi-core SCP
Date:   Tue, 28 Mar 2023 10:27:28 +0800
Message-ID: <20230328022733.29910-7-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230328022733.29910-1-tinghan.shen@mediatek.com>
References: <20230328022733.29910-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The difference of single-core SCP and multi-core SCP device tree is
the presence of child device nodes described SCP cores. The SCP
driver populates the platform device and checks the child nodes
to identify whether it's a single-core SCP or a multi-core SCP.

Add the remoteproc instances for single-core SCP and multi-core SCP to
the new added SCP cluster list. When the SCP driver is removed, it
cleanup resources by walking through the cluster list.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_common.h |   3 +
 drivers/remoteproc/mtk_scp.c    | 150 ++++++++++++++++++++++++++++----
 2 files changed, 137 insertions(+), 16 deletions(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index c0905aec3b4b..b73b60c22ea1 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -128,6 +128,9 @@ struct mtk_scp {
 	size_t dram_size;
 
 	struct rproc_subdev *rpmsg_subdev;
+
+	struct list_head elem;
+	struct list_head *cluster;
 };
 
 /**
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 32ecd1450c6f..71882ed31e16 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -30,6 +30,8 @@ struct mtk_scp_of_regs {
 	phys_addr_t l1tcm_phys;
 };
 
+static struct list_head cluster_cores;
+
 /**
  * scp_get() - get a reference to SCP.
  *
@@ -863,7 +865,8 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
 }
 
 static int scp_rproc_init(struct platform_device *pdev,
-			  struct mtk_scp_of_regs *of_regs)
+			  struct mtk_scp_of_regs *of_regs,
+			  const struct mtk_scp_of_data *of_data)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -884,7 +887,7 @@ static int scp_rproc_init(struct platform_device *pdev,
 	scp = (struct mtk_scp *)rproc->priv;
 	scp->rproc = rproc;
 	scp->dev = dev;
-	scp->data = of_device_get_match_data(dev);
+	scp->data = of_data;
 	platform_set_drvdata(pdev, scp);
 
 	scp->reg_base = of_regs->reg_base;
@@ -934,10 +937,6 @@ static int scp_rproc_init(struct platform_device *pdev,
 		goto remove_subdev;
 	}
 
-	ret = rproc_add(rproc);
-	if (ret)
-		goto remove_subdev;
-
 	return 0;
 
 remove_subdev:
@@ -952,6 +951,109 @@ static int scp_rproc_init(struct platform_device *pdev,
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
+static int scp_cluster_init(struct platform_device *pdev,
+			    struct mtk_scp_of_regs *of_regs)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev_of_node(dev);
+	struct platform_device *cpdev;
+	struct device_node *child;
+	const struct mtk_scp_of_data **cluster_of_data;
+	struct list_head *cluster = &cluster_cores;
+	struct mtk_scp *scp, *temp;
+	int core_id = 0, num_cores;
+	int ret;
+
+	child = of_get_next_available_child(np, NULL);
+	if (!child)
+		return dev_err_probe(dev, -ENODEV, "No child node\n");
+
+	of_node_put(child);
+	if (of_node_name_eq(child, "cros-ec-rpmsg")) {
+		dev_dbg(dev, "single-core scp\n");
+
+		ret = scp_rproc_init(pdev, of_regs, of_device_get_match_data(dev));
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to initialize single-core scp\n");
+
+		/* the single-core drvdata is intended to be the mtk_scp object.
+		 * the mtk_scp object is used by APIs in mtk_scp_rpmsg_info.
+		 */
+		scp = platform_get_drvdata(pdev);
+		list_add_tail(&scp->elem, cluster);
+		scp->cluster = cluster;
+	} else {
+		dev_dbg(dev, "multi-core scp\n");
+
+		cluster_of_data = (const struct mtk_scp_of_data **)of_device_get_match_data(dev);
+
+		num_cores = of_get_available_child_count(np);
+
+		for_each_available_child_of_node(np, child) {
+			if (core_id >= num_cores || !cluster_of_data[core_id]) {
+				ret = -EINVAL;
+				dev_err(dev, "Not support core %d\n", core_id);
+				of_node_put(child);
+				goto init_fail;
+			}
+
+			cpdev = of_find_device_by_node(child);
+			if (!cpdev) {
+				ret = -ENODEV;
+				dev_err(dev, "Not found platform device for core %d\n", core_id);
+				of_node_put(child);
+				goto init_fail;
+			}
+
+			ret = scp_rproc_init(cpdev, of_regs, cluster_of_data[core_id]);
+			if (ret) {
+				dev_err(dev, "Failed to initialize core %d rproc\n", core_id);
+				put_device(&cpdev->dev);
+				of_node_put(child);
+				goto init_fail;
+			}
+			scp = platform_get_drvdata(cpdev);
+			list_add_tail(&scp->elem, cluster);
+			scp->cluster = cluster;
+			put_device(&cpdev->dev);
+
+			core_id++;
+		}
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
+	list_for_each_entry_safe_reverse(scp, temp, cluster, elem) {
+		list_del(&scp->elem);
+		scp_rproc_free(scp);
+	}
+
+	return ret;
+}
+
 static int scp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -980,21 +1082,30 @@ static int scp_probe(struct platform_device *pdev)
 		scp_regs.l1tcm_phys = res->start;
 	}
 
-	return scp_rproc_init(pdev, &scp_regs);
+	ret = devm_of_platform_populate(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to populate platform devices\n");
+
+	INIT_LIST_HEAD(&cluster_cores);
+	platform_set_drvdata(pdev, &cluster_cores);
+
+	ret = scp_cluster_init(pdev, &scp_regs);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize scp cluster\n");
+
+	return 0;
 }
 
 static int scp_remove(struct platform_device *pdev)
 {
-	struct mtk_scp *scp = platform_get_drvdata(pdev);
-	int i;
+	struct list_head *cluster = &cluster_cores;
+	struct mtk_scp *scp, *temp;
 
-	rproc_del(scp->rproc);
-	scp_remove_rpmsg_subdev(scp);
-	scp_ipi_unregister(scp, SCP_IPI_INIT);
-	scp_unmap_memory_region(scp);
-	for (i = 0; i < SCP_IPI_MAX; i++)
-		mutex_destroy(&scp->ipi_desc[i].lock);
-	mutex_destroy(&scp->send_lock);
+	list_for_each_entry_safe_reverse(scp, temp, cluster, elem) {
+		list_del(&scp->elem);
+		rproc_del(scp->rproc);
+		scp_rproc_free(scp);
+	}
 
 	return 0;
 }
@@ -1073,12 +1184,19 @@ static const struct mtk_scp_of_data mt8195_of_data_c1 = {
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

