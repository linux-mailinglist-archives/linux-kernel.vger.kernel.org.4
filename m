Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33926705ED5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjEQEgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjEQEfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:35:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC1230FA;
        Tue, 16 May 2023 21:35:42 -0700 (PDT)
X-UUID: 43d2542cf46c11ed9cb5633481061a41-20230517
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CEveVxa65V9yiHQ1O3aqqq5fez2GB4dTHw/nJK1thn8=;
        b=lu4eiLvlA8T7TXU/QwQ2LVHVadSkj9vOJCkQCf8xpWzms8nnfkorbuwhdMlF7VPI72nFyvzuGesys8DSBjmfzAWCUquXctOEHK8qeva3Ye2axJeWTcFNqMXH3VdMmIHbdJGGqLFl3Ihvc64czMb47mOxWJf0TOaycAp+ll4qD2Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:1153359c-9ffb-46f8-9de0-8ab2d55bea84,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:27b618c1-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 43d2542cf46c11ed9cb5633481061a41-20230517
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 399646607; Wed, 17 May 2023 12:35:34 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 12:35:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 May 2023 12:35:33 +0800
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
Subject: [PATCH v12 04/11] remoteproc: mediatek: Add MT8195 SCP core 1 operations
Date:   Wed, 17 May 2023 12:34:42 +0800
Message-ID: <20230517043449.26352-5-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230517043449.26352-1-tinghan.shen@mediatek.com>
References: <20230517043449.26352-1-tinghan.shen@mediatek.com>
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

The SCP rproc driver has a set of chip dependent callbacks for
boot sequence and IRQ handling. Implement these callbacks for MT8195
SCP core 1.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/remoteproc/mtk_common.h |  9 ++++++
 drivers/remoteproc/mtk_scp.c    | 56 +++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index ea6fa1100a00..c0905aec3b4b 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -47,6 +47,7 @@
 #define MT8192_SCP2SPM_IPC_CLR		0x4094
 #define MT8192_GIPC_IN_SET		0x4098
 #define MT8192_HOST_IPC_INT_BIT		BIT(0)
+#define MT8195_CORE1_HOST_IPC_INT_BIT	BIT(4)
 
 #define MT8192_CORE0_SW_RSTN_CLR	0x10000
 #define MT8192_CORE0_SW_RSTN_SET	0x10004
@@ -56,6 +57,14 @@
 
 #define MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS		GENMASK(7, 4)
 
+#define MT8195_CPU1_SRAM_PD			0x1084
+#define MT8195_SSHUB2APMCU_IPC_SET		0x4088
+#define MT8195_SSHUB2APMCU_IPC_CLR		0x408C
+#define MT8195_CORE1_SW_RSTN_CLR		0x20000
+#define MT8195_CORE1_SW_RSTN_SET		0x20004
+#define MT8195_CORE1_MEM_ATT_PREDEF		0x20008
+#define MT8195_CORE1_WDT_CFG			0x20034
+
 #define SCP_FW_VER_LEN			32
 #define SCP_SHARE_BUFFER_SIZE		288
 
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index dcc94ee2458d..d66822dad943 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -176,6 +176,16 @@ static void mt8192_scp_reset_deassert(struct mtk_scp *scp)
 	writel(1, scp->reg_base + MT8192_CORE0_SW_RSTN_CLR);
 }
 
+static void mt8195_scp_c1_reset_assert(struct mtk_scp *scp)
+{
+	writel(1, scp->reg_base + MT8195_CORE1_SW_RSTN_SET);
+}
+
+static void mt8195_scp_c1_reset_deassert(struct mtk_scp *scp)
+{
+	writel(1, scp->reg_base + MT8195_CORE1_SW_RSTN_CLR);
+}
+
 static void mt8183_scp_irq_handler(struct mtk_scp *scp)
 {
 	u32 scp_to_host;
@@ -212,6 +222,18 @@ static void mt8192_scp_irq_handler(struct mtk_scp *scp)
 	}
 }
 
+static void mt8195_scp_c1_irq_handler(struct mtk_scp *scp)
+{
+	u32 scp_to_host;
+
+	scp_to_host = readl(scp->reg_base + MT8195_SSHUB2APMCU_IPC_SET);
+
+	if (scp_to_host & MT8192_SCP_IPC_INT_BIT)
+		scp_ipi_handler(scp);
+
+	writel(scp_to_host, scp->reg_base + MT8195_SSHUB2APMCU_IPC_CLR);
+}
+
 static irqreturn_t scp_irq_handler(int irq, void *priv)
 {
 	struct mtk_scp *scp = priv;
@@ -453,6 +475,19 @@ static int mt8195_scp_before_load(struct mtk_scp *scp)
 	return 0;
 }
 
+static int mt8195_scp_c1_before_load(struct mtk_scp *scp)
+{
+	scp_sram_power_on(scp->reg_base + MT8195_CPU1_SRAM_PD, 0);
+
+	/* hold SCP in reset while loading FW. */
+	scp->data->scp_reset_assert(scp);
+
+	/* enable MPU for all memory regions */
+	writel(0xff, scp->reg_base + MT8195_CORE1_MEM_ATT_PREDEF);
+
+	return 0;
+}
+
 static int scp_load(struct rproc *rproc, const struct firmware *fw)
 {
 	struct mtk_scp *scp = rproc->priv;
@@ -625,6 +660,15 @@ static void mt8195_scp_stop(struct mtk_scp *scp)
 	writel(0, scp->reg_base + MT8192_CORE0_WDT_CFG);
 }
 
+static void mt8195_scp_c1_stop(struct mtk_scp *scp)
+{
+	/* Power off CPU SRAM */
+	scp_sram_power_off(scp->reg_base + MT8195_CPU1_SRAM_PD, 0);
+
+	/* Disable SCP watchdog */
+	writel(0, scp->reg_base + MT8195_CORE1_WDT_CFG);
+}
+
 static int scp_stop(struct rproc *rproc)
 {
 	struct mtk_scp *scp = rproc->priv;
@@ -989,6 +1033,18 @@ static const struct mtk_scp_of_data mt8195_of_data = {
 	.host_to_scp_int_bit = MT8192_HOST_IPC_INT_BIT,
 };
 
+static const struct mtk_scp_of_data mt8195_of_data_c1 = {
+	.scp_clk_get = mt8195_scp_clk_get,
+	.scp_before_load = mt8195_scp_c1_before_load,
+	.scp_irq_handler = mt8195_scp_c1_irq_handler,
+	.scp_reset_assert = mt8195_scp_c1_reset_assert,
+	.scp_reset_deassert = mt8195_scp_c1_reset_deassert,
+	.scp_stop = mt8195_scp_c1_stop,
+	.scp_da_to_va = mt8192_scp_da_to_va,
+	.host_to_scp_reg = MT8192_GIPC_IN_SET,
+	.host_to_scp_int_bit = MT8195_CORE1_HOST_IPC_INT_BIT,
+};
+
 static const struct of_device_id mtk_scp_of_match[] = {
 	{ .compatible = "mediatek,mt8183-scp", .data = &mt8183_of_data },
 	{ .compatible = "mediatek,mt8186-scp", .data = &mt8186_of_data },
-- 
2.18.0

