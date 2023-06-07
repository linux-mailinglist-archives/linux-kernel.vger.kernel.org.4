Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D9D725570
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbjFGHWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbjFGHWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:22:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D8F198B;
        Wed,  7 Jun 2023 00:22:32 -0700 (PDT)
X-UUID: 0d679be2050411ee9cb5633481061a41-20230607
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xlE584fy39I0qBsOEWRrSmdIkj6DrWt65e882reYtWQ=;
        b=CEw0mrQpu9ipGGZvXs3lZDAsR5NP2SisPyV/tDxk/i+DwTDrgc2uqYFHkuuCPoZstkIF1qZs93JvImSP5gb/GT/DF0yDkXvnTaupnEPFviD0DUO2tDkO/W+knvK+rWI8sZxTCOEnwLGeMzIj2eSC7Xv5I+boGbiAvKrpgPALqBc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:eac62dd1-d9b4-4c58-a02f-4db2cb5a6491,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:3c5cd63d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 0d679be2050411ee9cb5633481061a41-20230607
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 138751005; Wed, 07 Jun 2023 15:22:25 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 15:22:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 15:22:24 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Tinghan Shen" <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v13 07/11] remoteproc: mediatek: Add scp_boot_peers and scp_shutdown_peers operations
Date:   Wed, 7 Jun 2023 15:22:18 +0800
Message-ID: <20230607072222.8628-8-tinghan.shen@mediatek.com>
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

Due to that SCP core 0 controls the SCP clock and SRAM power, add two
new mtk_scp_of_data operations, scp_boot_peers and scp_shutdown_peers,
to manage the boot sequence and watchdog timeout handling of SCP core 1.
It ensures that core 1 boots after or shuts down before core 0 for
maintaining the proper control flow over SCP core 1.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_common.h |  3 ++
 drivers/remoteproc/mtk_scp.c    | 55 +++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 56395e8664cb..0bfd242c41cc 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -93,6 +93,8 @@ struct mtk_scp_of_data {
 	void (*scp_reset_deassert)(struct mtk_scp *scp);
 	void (*scp_stop)(struct mtk_scp *scp);
 	void *(*scp_da_to_va)(struct mtk_scp *scp, u64 da, size_t len);
+	void (*scp_boot_peers)(struct mtk_scp *scp);
+	void (*scp_shutdown_peers)(struct mtk_scp *scp);
 
 	u32 host_to_scp_reg;
 	u32 host_to_scp_int_bit;
@@ -130,6 +132,7 @@ struct mtk_scp {
 	struct rproc_subdev *rpmsg_subdev;
 
 	struct list_head elem;
+	struct list_head *cluster;
 };
 
 /**
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index d644e232dfec..edbf71f4c21e 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -74,8 +74,21 @@ void scp_put(struct mtk_scp *scp)
 }
 EXPORT_SYMBOL_GPL(scp_put);
 
+static void mt8195_scp_shutdown_peers(struct mtk_scp *scp)
+{
+	struct mtk_scp *next_scp;
+
+	next_scp = list_next_entry(scp, elem);
+	list_for_each_entry_from(next_scp, scp->cluster, elem) {
+		rproc_shutdown(next_scp->rproc);
+	}
+}
+
 static void scp_wdt_handler(struct mtk_scp *scp, u32 scp_to_host)
 {
+	if (scp->data->scp_shutdown_peers)
+		scp->data->scp_shutdown_peers(scp);
+
 	dev_err(scp->dev, "SCP watchdog timeout! 0x%x", scp_to_host);
 	rproc_report_crash(scp->rproc, RPROC_WATCHDOG);
 }
@@ -539,6 +552,18 @@ static int scp_parse_fw(struct rproc *rproc, const struct firmware *fw)
 	return ret;
 }
 
+static void mt8195_scp_boot_peers(struct mtk_scp *scp)
+{
+	struct mtk_scp *next_scp;
+
+	if (scp->cluster && !list_empty(scp->cluster)) {
+		next_scp = list_next_entry(scp, elem);
+		list_for_each_entry_from(next_scp, scp->cluster, elem) {
+			rproc_boot(next_scp->rproc);
+		}
+	}
+}
+
 static int scp_start(struct rproc *rproc)
 {
 	struct mtk_scp *scp = rproc->priv;
@@ -574,6 +599,9 @@ static int scp_start(struct rproc *rproc)
 	clk_disable_unprepare(scp->clk);
 	dev_info(dev, "SCP is ready. FW version %s\n", run->fw_ver);
 
+	if (scp->data->scp_boot_peers)
+		scp->data->scp_boot_peers(scp);
+
 	return 0;
 
 stop:
@@ -977,6 +1005,8 @@ static int scp_add_single_core(struct platform_device *pdev)
 	if (IS_ERR(scp))
 		return PTR_ERR(scp);
 
+	scp->cluster = cluster;
+
 	ret = rproc_add(scp->rproc);
 	if (ret) {
 		dev_err(dev, "Failed to add rproc\n");
@@ -989,6 +1019,15 @@ static int scp_add_single_core(struct platform_device *pdev)
 	return 0;
 }
 
+static void scp_rproc_boot_core0(const struct firmware *fw, void *context)
+{
+	struct rproc *rproc = context;
+
+	rproc_boot(rproc);
+
+	release_firmware(fw);
+}
+
 static int scp_add_multi_core(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1029,6 +1068,10 @@ static int scp_add_multi_core(struct platform_device *pdev)
 			goto init_fail;
 		}
 
+		/* boot after all cores are discovered */
+		scp->rproc->auto_boot = false;
+		scp->cluster = cluster;
+
 		ret = rproc_add(scp->rproc);
 		if (ret) {
 			dev_err(dev, "Failed to add rproc of core %d\n", core_id);
@@ -1041,6 +1084,16 @@ static int scp_add_multi_core(struct platform_device *pdev)
 		core_id++;
 	}
 
+	/* boot core 0, and other cores are booted following core 0 */
+	scp = list_first_entry(cluster, struct mtk_scp, elem);
+	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
+				      scp->rproc->firmware, &scp->rproc->dev, GFP_KERNEL,
+				      scp->rproc, scp_rproc_boot_core0);
+	if (ret < 0) {
+		dev_err(dev, "request_firmware_nowait err: %d\n", ret);
+		goto init_fail;
+	}
+
 	return 0;
 
 init_fail:
@@ -1198,6 +1251,8 @@ static const struct mtk_scp_of_data mt8195_of_data = {
 	.scp_reset_deassert = mt8192_scp_reset_deassert,
 	.scp_stop = mt8195_scp_stop,
 	.scp_da_to_va = mt8192_scp_da_to_va,
+	.scp_boot_peers = mt8195_scp_boot_peers,
+	.scp_shutdown_peers = mt8195_scp_shutdown_peers,
 	.host_to_scp_reg = MT8192_GIPC_IN_SET,
 	.host_to_scp_int_bit = MT8192_HOST_IPC_INT_BIT,
 };
-- 
2.18.0

