Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BF25EB830
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiI0DAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiI0C7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:59:09 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B756A6C50;
        Mon, 26 Sep 2022 19:56:39 -0700 (PDT)
X-UUID: 6b46273be5ae43a78bd0021e48d18f9a-20220927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=57HiwZHwI8xdSXKdKLB2V8JxOaDVDwgTdPhCY4HBtBw=;
        b=qdl/dpVnHrSfB2tOjyj69/ccBCJOs20TMBK22635a+eOM0XqgFUuogZAVeisbHbIF+mm9u3QQ0MJDYvuIb30EZ+3kfj5YBFSgjkm0Zl6v5GifbZdt/c5Tq7BrNJ+KHT3CsDpzPkprFPAwk0sswnKVePDo1YEByHDiv5WtqLeMdY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:5238dd4e-4afc-4e5a-90d4-f80f4219299f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:5238dd4e-4afc-4e5a-90d4-f80f4219299f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:47612aa3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:2209271056309CTTLI63,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0
X-UUID: 6b46273be5ae43a78bd0021e48d18f9a-20220927
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 492392601; Tue, 27 Sep 2022 10:56:27 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 27 Sep 2022 10:56:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 27 Sep 2022 10:56:26 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        "Andrew-CT Chen" <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
Subject: [PATCH v3 08/11] remoteproc: mediatek: Control SCP core 1 boot by rproc subdevice
Date:   Tue, 27 Sep 2022 10:56:03 +0800
Message-ID: <20220927025606.26673-9-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220927025606.26673-1-tinghan.shen@mediatek.com>
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register SCP core 1 as a subdevice of core 0 to control the boot sequence
and watchdog handling. The core 1 has to boot after core 0 because the
SCP clock and SRAM power is controlled by SCP core 0.
When SCP core 0 reports a watchdog timeout event, the SRAM is emptied
before rebooting the SCP core 0, forcing the reload of the SCP core 1 image.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_common.h |  8 ++++
 drivers/remoteproc/mtk_scp.c    | 71 +++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 54265c515315..dcde25f8bbf9 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -95,6 +95,13 @@ struct scp_ipi_desc {
 	void *priv;
 };
 
+struct scp_subdev_core {
+	struct rproc_subdev subdev;
+	struct mtk_scp *scp;
+};
+
+#define to_subdev_core(d) container_of(d, struct scp_subdev_core, subdev)
+
 struct mtk_scp;
 
 struct mtk_scp_of_data {
@@ -142,6 +149,7 @@ struct mtk_scp {
 	struct rproc_subdev *rpmsg_subdev;
 
 	struct mtk_scp *main_scp;
+	struct rproc_subdev *core_subdev;
 };
 
 /**
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index f7b738743ba9..2d43338b96da 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -871,6 +871,54 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
 	}
 }
 
+static int scp_core_subdev_start(struct rproc_subdev *subdev)
+{
+	struct scp_subdev_core *subdev_core = to_subdev_core(subdev);
+	struct mtk_scp *scp = subdev_core->scp;
+
+	rproc_boot(scp->rproc);
+
+	return 0;
+}
+
+static void scp_core_subdev_stop(struct rproc_subdev *subdev, bool crashed)
+{
+	struct scp_subdev_core *subdev_core = to_subdev_core(subdev);
+	struct mtk_scp *scp = subdev_core->scp;
+
+	rproc_shutdown(scp->rproc);
+}
+
+static int scp_core_subdev_register(struct mtk_scp *scp)
+{
+	struct device *dev = scp->dev;
+	struct scp_subdev_core *subdev_core;
+
+	subdev_core = devm_kzalloc(dev, sizeof(*subdev_core), GFP_KERNEL);
+	if (!subdev_core) {
+		scp->core_subdev = NULL;
+		return -ENOMEM;
+	}
+
+	subdev_core->scp = scp;
+	subdev_core->subdev.start = scp_core_subdev_start;
+	subdev_core->subdev.stop = scp_core_subdev_stop;
+
+	scp->core_subdev = &subdev_core->subdev;
+	rproc_add_subdev(scp->main_scp->rproc, scp->core_subdev);
+
+	return 0;
+}
+
+static void scp_core_subdev_unregister(struct mtk_scp *scp)
+{
+	if (scp->core_subdev) {
+		rproc_remove_subdev(scp->main_scp->rproc, scp->core_subdev);
+		devm_kfree(scp->dev, to_subdev_core(scp->core_subdev));
+		scp->core_subdev = NULL;
+	}
+}
+
 static int scp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -974,6 +1022,23 @@ static int scp_probe(struct platform_device *pdev)
 		goto remove_subdev;
 	}
 
+	if (of_device_is_compatible(np, "mediatek,mt8195-scp-core")) {
+		ret = scp_core_subdev_register(scp);
+		if (ret) {
+			dev_err_probe(dev, ret, "Failed to register subdev\n");
+			goto remove_subdev;
+		}
+
+		/* sub cores are booted as subdevices of main core. */
+		rproc->auto_boot = false;
+	} else {
+		ret = devm_of_platform_populate(dev);
+		if (ret) {
+			dev_err_probe(dev, ret, "Failed to probe sub cores\n");
+			goto remove_subdev;
+		}
+	}
+
 	ret = rproc_add(rproc);
 	if (ret)
 		goto remove_subdev;
@@ -981,6 +1046,7 @@ static int scp_probe(struct platform_device *pdev)
 	return 0;
 
 remove_subdev:
+	scp_core_subdev_unregister(scp);
 	scp_remove_rpmsg_subdev(scp);
 	scp_ipi_unregister(scp, SCP_IPI_INIT);
 release_dev_mem:
@@ -997,6 +1063,11 @@ static int scp_remove(struct platform_device *pdev)
 	struct mtk_scp *scp = platform_get_drvdata(pdev);
 	int i;
 
+	if (of_device_is_compatible(scp->dev->of_node, "mediatek,mt8195-scp-core"))
+		scp_core_subdev_unregister(scp);
+	else
+		devm_of_platform_depopulate(scp->dev);
+
 	rproc_del(scp->rproc);
 	scp_remove_rpmsg_subdev(scp);
 	scp_ipi_unregister(scp, SCP_IPI_INIT);
-- 
2.18.0

