Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D29705EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjEQEgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjEQEfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:35:47 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA1035AE;
        Tue, 16 May 2023 21:35:42 -0700 (PDT)
X-UUID: 43a80370f46c11edb20a276fd37b9834-20230517
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mJFf4UqkEPOcLYt3DLx8HtQsPAkilJL1hZbjwl0w82s=;
        b=WVLqJtF9cFoqmVcfsKUW3GptQbTKLqRNY93R2adOulu39PWz9hn2K6H9kLOFvIYFWR0mZFgZ1THLPcnHTOMp8Ykk/fLAW6k6EXQXRxAmvUUPQZt0X2RLHoiM+suUjQE5vj5GD8Dz9K02daILW8ncBOod35zBXLxzftu262hIReU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:908764d8-8d54-45bb-a7cb-5ed37705b5d3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.25,REQID:908764d8-8d54-45bb-a7cb-5ed37705b5d3,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:d5b0ae3,CLOUDID:03b618c1-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:230517123535Y6AFSH7Q,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 43a80370f46c11edb20a276fd37b9834-20230517
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1156253824; Wed, 17 May 2023 12:35:34 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 12:35:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 May 2023 12:35:34 +0800
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
Subject: [PATCH v12 07/11] remoteproc: mediatek: Control SCP core 1 by rproc subdevice
Date:   Wed, 17 May 2023 12:34:45 +0800
Message-ID: <20230517043449.26352-8-tinghan.shen@mediatek.com>
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

Register SCP core 1 as a subdevice of core 0 for the boot sequence
and watchdog timeout handling. The core 1 has to boot after core 0
because the SCP clock and SRAM power is controlled by SCP core 0.
As for watchdog timeout handling, the remoteproc framework helps to
stop/start subdevices automatically when SCP driver receives watchdog
timeout event.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/remoteproc/mtk_common.h |  9 ++++
 drivers/remoteproc/mtk_scp.c    | 88 +++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 56395e8664cb..85afed2e6928 100644
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
@@ -130,6 +137,8 @@ struct mtk_scp {
 	struct rproc_subdev *rpmsg_subdev;
 
 	struct list_head elem;
+	struct list_head *cluster;
+	struct mtk_scp_core_subdev *core_subdev;
 };
 
 /**
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index d644e232dfec..18534b1179b5 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -863,6 +863,60 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
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
 static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
 				      struct mtk_scp_of_cluster *scp_cluster,
 				      const struct mtk_scp_of_data *of_data)
@@ -957,6 +1011,7 @@ static void scp_free(struct mtk_scp *scp)
 {
 	int i;
 
+	scp_core_subdev_unregister(scp);
 	scp_remove_rpmsg_subdev(scp);
 	scp_ipi_unregister(scp, SCP_IPI_INIT);
 	scp_unmap_memory_region(scp);
@@ -989,6 +1044,15 @@ static int scp_add_single_core(struct platform_device *pdev)
 	return 0;
 }
 
+static void scp_rproc_boot_callback(const struct firmware *fw, void *context)
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
@@ -1029,6 +1093,20 @@ static int scp_add_multi_core(struct platform_device *pdev)
 			goto init_fail;
 		}
 
+		scp->cluster = cluster;
+		if (!list_empty(cluster)) {
+			ret = scp_core_subdev_register(scp);
+			if (ret) {
+				dev_err(dev, "Failed to register core %d as subdev\n", core_id);
+				of_node_put(child);
+				scp_free(scp);
+				goto init_fail;
+			}
+		}
+
+		/* boot after all cores finished rproc_add() */
+		scp->rproc->auto_boot = false;
+
 		ret = rproc_add(scp->rproc);
 		if (ret) {
 			dev_err(dev, "Failed to add rproc of core %d\n", core_id);
@@ -1041,6 +1119,16 @@ static int scp_add_multi_core(struct platform_device *pdev)
 		core_id++;
 	}
 
+	/* boot core 0, and other cores are booted following core 0 as subdevices */
+	scp = list_first_entry(cluster, struct mtk_scp, elem);
+	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
+				      scp->rproc->firmware, &scp->rproc->dev, GFP_KERNEL,
+				      scp->rproc, scp_rproc_boot_callback);
+	if (ret < 0) {
+		dev_err(dev, "request_firmware_nowait err: %d\n", ret);
+		goto init_fail;
+	}
+
 	return 0;
 
 init_fail:
-- 
2.18.0

