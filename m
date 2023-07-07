Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6680174AA89
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjGGF1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjGGF0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:26:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFE7171D;
        Thu,  6 Jul 2023 22:26:27 -0700 (PDT)
X-UUID: cbe7c3fa1c8611eeb20a276fd37b9834-20230707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=D1lXYdyfOfRoaAcdJsP+/taOV2FLC2+fVs+lIM1Csuw=;
        b=Bz+j3YXqag27mf/JBj8XOhH5nAMUaYReRNt8phFWvkyYX871IqGsDUT47QFW2K8enKjZrAgDu9vz7hLX5pz8DiuuXUbjyRLymxlmlfdhdw973YS3nobEM+uakI+aVToznrOYg9WIIxaDp06x570AUJqSNMma3yfm6e2OCVr595s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:e7fab1c8-0590-43aa-a74e-9b1ba804826a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:e06caa0d-26a8-467f-b838-f99719a9c083,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cbe7c3fa1c8611eeb20a276fd37b9834-20230707
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1886057916; Fri, 07 Jul 2023 13:26:16 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 7 Jul 2023 13:26:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 7 Jul 2023 13:26:15 +0800
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
Subject: [PATCH v14 07/12] remoteproc: mediatek: Remove dependency of MT8195 SCP L2TCM power control on dual-core SCP
Date:   Fri, 7 Jul 2023 13:26:07 +0800
Message-ID: <20230707052612.27521-8-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230707052612.27521-1-tinghan.shen@mediatek.com>
References: <20230707052612.27521-1-tinghan.shen@mediatek.com>
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

Previously, SCP core 0 controlled the power of L2TCM and dictated that
SCP core 1 could only boot after SCP core 0. To address this constraint,
extracted the power control flow of L2TCM and made it shared
between both cores, enabling support of arbitrary boot order.

The flow for controlling L2TCM power has been incorporated into the
mt8195_scp_before_load() and mt8195_scp_stop() APIs, which are
respectively invoked during the rproc->ops->start() and
rproc->ops->stop() operations. These APIs effectively serve the same
purpose as the rproc prepare()/unprepare() APIs."

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_common.h |  1 +
 drivers/remoteproc/mtk_scp.c    | 80 ++++++++++++++++++++++++++-------
 2 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 56395e8664cb..41e1b4732b75 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -130,6 +130,7 @@ struct mtk_scp {
 	struct rproc_subdev *rpmsg_subdev;
 
 	struct list_head elem;
+	struct platform_device *cluster_pdev;
 };
 
 /**
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 3349488e5f21..94602272c05f 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -29,6 +29,10 @@ struct mtk_scp_of_cluster {
 	size_t l1tcm_size;
 	phys_addr_t l1tcm_phys;
 	struct list_head mtk_scp_list;
+
+	/* Prevent concurrent operations of L2TCM power control. */
+	struct mutex l2tcm_lock;
+	u32 l2tcm_refcnt;
 };
 
 /**
@@ -449,7 +453,7 @@ static int mt8192_scp_before_load(struct mtk_scp *scp)
 
 	writel(1, scp->reg_base + MT8192_CORE0_SW_RSTN_SET);
 
-	/* enable SRAM clock */
+	/* enable SRAM power */
 	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
 	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
 	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
@@ -462,19 +466,38 @@ static int mt8192_scp_before_load(struct mtk_scp *scp)
 	return 0;
 }
 
-static int mt8195_scp_before_load(struct mtk_scp *scp)
+static int mt8195_scp_l2tcm_on(struct mtk_scp *scp)
 {
-	/* clear SPM interrupt, SCP2SPM_IPC_CLR */
-	writel(0xff, scp->reg_base + MT8192_SCP2SPM_IPC_CLR);
+	struct mtk_scp_of_cluster *scp_cluster = platform_get_drvdata(scp->cluster_pdev);
+
+	mutex_lock(&scp_cluster->l2tcm_lock);
+
+	if (scp_cluster->l2tcm_refcnt == 0) {
+		/* clear SPM interrupt, SCP2SPM_IPC_CLR */
+		writel(0xff, scp->reg_base + MT8192_SCP2SPM_IPC_CLR);
+
+		/* Power on L2TCM */
+		scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
+		scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
+		scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
+		scp_sram_power_on(scp->reg_base + MT8192_L1TCM_SRAM_PDN,
+				  MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
+	}
+
+	scp_cluster->l2tcm_refcnt += 1;
 
+	mutex_unlock(&scp_cluster->l2tcm_lock);
+
+	return 0;
+}
+
+static int mt8195_scp_before_load(struct mtk_scp *scp)
+{
 	writel(1, scp->reg_base + MT8192_CORE0_SW_RSTN_SET);
 
+	mt8195_scp_l2tcm_on(scp);
+
 	/* enable SRAM clock */
-	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
-	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
-	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
-	scp_sram_power_on(scp->reg_base + MT8192_L1TCM_SRAM_PDN,
-			  MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
 	scp_sram_power_on(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
 
 	/* enable MPU for all memory regions */
@@ -487,6 +510,8 @@ static int mt8195_scp_c1_before_load(struct mtk_scp *scp)
 {
 	scp->data->scp_reset_assert(scp);
 
+	mt8195_scp_l2tcm_on(scp);
+
 	scp_sram_power_on(scp->reg_base + MT8195_CPU1_SRAM_PD, 0);
 
 	/* enable MPU for all memory regions */
@@ -653,14 +678,30 @@ static void mt8192_scp_stop(struct mtk_scp *scp)
 	writel(0, scp->reg_base + MT8192_CORE0_WDT_CFG);
 }
 
+static void mt8195_scp_l2tcm_off(struct mtk_scp *scp)
+{
+	struct mtk_scp_of_cluster *scp_cluster = platform_get_drvdata(scp->cluster_pdev);
+
+	mutex_lock(&scp_cluster->l2tcm_lock);
+
+	scp_cluster->l2tcm_refcnt -= 1;
+
+	if (scp_cluster->l2tcm_refcnt == 0) {
+		/* Power off L2TCM */
+		scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
+		scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
+		scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
+		scp_sram_power_off(scp->reg_base + MT8192_L1TCM_SRAM_PDN, 0);
+		scp_sram_power_off(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
+	}
+
+	mutex_unlock(&scp_cluster->l2tcm_lock);
+}
+
 static void mt8195_scp_stop(struct mtk_scp *scp)
 {
-	/* Disable SRAM clock */
-	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
-	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
-	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
-	scp_sram_power_off(scp->reg_base + MT8192_L1TCM_SRAM_PDN,
-			   MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
+	mt8195_scp_l2tcm_off(scp);
+
 	scp_sram_power_off(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
 
 	/* Disable SCP watchdog */
@@ -669,6 +710,8 @@ static void mt8195_scp_stop(struct mtk_scp *scp)
 
 static void mt8195_scp_c1_stop(struct mtk_scp *scp)
 {
+	mt8195_scp_l2tcm_off(scp);
+
 	/* Power off CPU SRAM */
 	scp_sram_power_off(scp->reg_base + MT8195_CPU1_SRAM_PD, 0);
 
@@ -976,6 +1019,8 @@ static int scp_add_single_core(struct platform_device *pdev)
 	if (IS_ERR(scp))
 		return PTR_ERR(scp);
 
+	scp->cluster_pdev = pdev;
+
 	ret = rproc_add(scp->rproc);
 	if (ret) {
 		dev_err(dev, "Failed to add rproc\n");
@@ -1028,6 +1073,8 @@ static int scp_add_multi_core(struct platform_device *pdev)
 			goto init_fail;
 		}
 
+		scp->cluster_pdev = pdev;
+
 		ret = rproc_add(scp->rproc);
 		if (ret) {
 			dev_err(dev, "Failed to add rproc of core %d\n", core_id);
@@ -1114,6 +1161,7 @@ static int scp_probe(struct platform_device *pdev)
 	}
 
 	INIT_LIST_HEAD(&scp_cluster->mtk_scp_list);
+	mutex_init(&scp_cluster->l2tcm_lock);
 	platform_set_drvdata(pdev, scp_cluster);
 
 	ret = devm_of_platform_populate(dev);
@@ -1137,6 +1185,8 @@ static void scp_remove(struct platform_device *pdev)
 		rproc_del(scp->rproc);
 		scp_free(scp);
 	}
+
+	mutex_destroy(&scp_cluster->l2tcm_lock);
 }
 
 static const struct mtk_scp_of_data mt8183_of_data = {
-- 
2.18.0

