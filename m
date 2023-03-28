Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2207F6CB414
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjC1C2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjC1C2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:28:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE47196;
        Mon, 27 Mar 2023 19:28:04 -0700 (PDT)
X-UUID: 26742d66cd1011edb6b9f13eb10bd0fe-20230328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5fc5VKu5pwtacTmVqJcZvafVocVzGr7YjsffATNdVkU=;
        b=t9iPDRM9YKRANIUbiFrjcJnbUOCobyXsxMhUpfilASEn2YOuGt7fddFEbxq6JT34iUKNkGXdZEjGW2eL1hJf54ylIpe5hLqII151rR4TFBt8Y0o6sbLqqedNgjAs/VSYWkxMNfu/cKLodw7UgW/AebVXz8jeeG3QGoVM/Yw12bw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:570fa70e-7af1-4f64-a8e4-39d2b7510589,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.22,REQID:570fa70e-7af1-4f64-a8e4-39d2b7510589,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:120426c,CLOUDID:e19a1bf7-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:230328102759EWVX0FV7,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 26742d66cd1011edb6b9f13eb10bd0fe-20230328
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2075299968; Tue, 28 Mar 2023 10:27:56 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 28 Mar 2023 10:27:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 28 Mar 2023 10:27:55 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v9 07/11] remoteproc: mediatek: Control SCP core 1 by rproc subdevice
Date:   Tue, 28 Mar 2023 10:27:29 +0800
Message-ID: <20230328022733.29910-8-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230328022733.29910-1-tinghan.shen@mediatek.com>
References: <20230328022733.29910-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register SCP core 1 as a subdevice of core 0 for the boot sequence
and watchdog timeout handling. The core 1 has to boot after core 0
because the SCP clock and SRAM power is controlled by SCP core 0.
As for watchdog timeout handling, the remoteproc framework helps to
stop/start subdevices automatically when SCP driver receives watchdog
timeout event.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/remoteproc/mtk_common.h |  9 +++++
 drivers/remoteproc/mtk_scp.c    | 66 +++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index b73b60c22ea1..f1a021ad7f66 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -100,6 +100,13 @@ struct mtk_scp_of_data {
 	size_t ipi_buf_offset;
 };
 
+struct mtk_scp_core_subdev {
+	struct rproc_subdev subdev;
+	struct mtk_scp *scp;
+};
+
+#define to_core_subdev(d) container_of(d, struct mtk_scp_core_subdev, subdev)
+
 struct mtk_scp {
 	struct device *dev;
 	struct rproc *rproc;
@@ -131,6 +138,8 @@ struct mtk_scp {
 
 	struct list_head elem;
 	struct list_head *cluster;
+
+	struct mtk_scp_core_subdev *core_subdev;
 };
 
 /**
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 71882ed31e16..ba931d550c1e 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -864,6 +864,60 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
 	}
 }
 
+static int scp_core_subdev_start(struct rproc_subdev *subdev)
+{
+	struct mtk_scp_core_subdev *core_subdev = to_core_subdev(subdev);
+	struct mtk_scp *scp = core_subdev->scp;
+
+	rproc_boot(scp->rproc);
+
+	return 0;
+}
+
+static void scp_core_subdev_stop(struct rproc_subdev *subdev, bool crashed)
+{
+	struct mtk_scp_core_subdev *core_subdev = to_core_subdev(subdev);
+	struct mtk_scp *scp = core_subdev->scp;
+
+	rproc_shutdown(scp->rproc);
+}
+
+static int scp_core_subdev_register(struct mtk_scp *scp)
+{
+	struct device *dev = scp->dev;
+	struct mtk_scp_core_subdev *core_subdev;
+	struct mtk_scp *scp_c0;
+
+	scp_c0 = list_first_entry(scp->cluster, struct mtk_scp, elem);
+	if (!scp_c0)
+		return -ENODATA;
+
+	core_subdev = devm_kzalloc(dev, sizeof(*core_subdev), GFP_KERNEL);
+	if (!core_subdev)
+		return -ENOMEM;
+
+	core_subdev->scp = scp;
+	core_subdev->subdev.start = scp_core_subdev_start;
+	core_subdev->subdev.stop = scp_core_subdev_stop;
+
+	scp->core_subdev = core_subdev;
+	rproc_add_subdev(scp_c0->rproc, &scp->core_subdev->subdev);
+
+	return 0;
+}
+
+static void scp_core_subdev_unregister(struct mtk_scp *scp)
+{
+	struct mtk_scp *scp_c0;
+
+	if (scp->core_subdev) {
+		scp_c0 = list_first_entry(scp->cluster, struct mtk_scp, elem);
+		rproc_remove_subdev(scp_c0->rproc, &scp->core_subdev->subdev);
+		devm_kfree(scp->dev, scp->core_subdev);
+		scp->core_subdev = NULL;
+	}
+}
+
 static int scp_rproc_init(struct platform_device *pdev,
 			  struct mtk_scp_of_regs *of_regs,
 			  const struct mtk_scp_of_data *of_data)
@@ -955,6 +1009,7 @@ static void scp_rproc_free(struct mtk_scp *scp)
 {
 	int i;
 
+	scp_core_subdev_unregister(scp);
 	scp_remove_rpmsg_subdev(scp);
 	scp_ipi_unregister(scp, SCP_IPI_INIT);
 	scp_unmap_memory_region(scp);
@@ -1034,6 +1089,17 @@ static int scp_cluster_init(struct platform_device *pdev,
 	}
 
 	list_for_each_entry_safe_reverse(scp, temp, cluster, elem) {
+		if (!list_is_first(&scp->elem, cluster)) {
+			ret = scp_core_subdev_register(scp);
+			if (ret) {
+				dev_err_probe(scp->dev, ret, "Failed to register as subdev\n");
+				goto add_fail;
+			}
+
+			/* sub cores are booted as subdevices of core 0 */
+			scp->rproc->auto_boot = false;
+		}
+
 		ret = rproc_add(scp->rproc);
 		if (ret)
 			goto add_fail;
-- 
2.18.0

