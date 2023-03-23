Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D536C6211
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjCWIkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjCWIjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:39:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0097012BE6;
        Thu, 23 Mar 2023 01:38:23 -0700 (PDT)
X-UUID: 0d57358ec95611edb6b9f13eb10bd0fe-20230323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NJcNAlsmBP8ajxbJLlshcvTja5PdCGJYpyuZW/mV0zg=;
        b=SFsSgoDOzpwhzNvn2YlczMXgWjd/W/QSiONnTZJUG7dTlNh5ixf5jOkLomnTvX39X+JYSWBNLn7HAliQlv8MchVA+kw6fZ4nrbYia2Oh/8LWT8Pjyv++XjSgRv4fDWwuSwMLPAgw3JK5RWWiU35F1mgEJTUncaHYLB0IXyA4dmE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:2e8a60e1-c5d1-494e-9c62-0b8a381178d8,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.22,REQID:2e8a60e1-c5d1-494e-9c62-0b8a381178d8,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:120426c,CLOUDID:0974aff6-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:230323163816TTGHMBG2,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 0d57358ec95611edb6b9f13eb10bd0fe-20230323
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1136355085; Thu, 23 Mar 2023 16:38:14 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 23 Mar 2023 16:38:13 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 23 Mar 2023 16:38:12 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Yong Wu <yong.wu@mediatek.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 2/2] media: mediatek: vcodec: Remove encoder 'dma-ranges' conditon when set dma mask
Date:   Thu, 23 Mar 2023 16:38:10 +0800
Message-ID: <20230323083810.21912-2-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323083810.21912-1-yunfei.dong@mediatek.com>
References: <20230323083810.21912-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit f1ad5338a4d5("of: Fix "dma-ranges" handling for bus controllers"),
the dma-ranges is not allowed in encoder dts node. But the driver still need
to set dma mask, remove "dma-ranges" condition in prob function.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
Reference series:
[1]: v5 of this series is present by Yong Wu.
     20230307023507.13306-1-yong.wu@mediatek.com
---
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c      | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index 6961f66b5693..dda669d04c05 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -83,6 +83,21 @@ static void clean_irq_status(unsigned int irq_status, void __iomem *addr)
 		writel(MTK_VENC_IRQ_STATUS_FRM, addr);
 
 }
+
+static int mtk_vcodec_enc_set_dma_mask(struct device *dev)
+{
+	int ret = 0;
+
+	return !(of_device_is_compatible(dev->of_node, "mediatek,mt8173-vcodec-dec") ||
+	       of_device_is_compatible(dev->of_node, "mediatek,mt8183-vcodec-dec"));
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(34));
+	if (ret)
+		mtk_v4l2_err("Failed to set enc mask");
+
+	return ret;
+}
+
 static irqreturn_t mtk_vcodec_enc_irq_handler(int irq, void *priv)
 {
 	struct mtk_vcodec_dev *dev = priv;
@@ -344,8 +359,9 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		goto err_event_workq;
 	}
 
-	if (of_get_property(pdev->dev.of_node, "dma-ranges", NULL))
-		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
+	ret = mtk_vcodec_enc_set_dma_mask(&pdev->dev);
+	if (ret)
+		goto err_event_workq;
 
 	ret = video_register_device(vfd_enc, VFL_TYPE_VIDEO, -1);
 	if (ret) {
-- 
2.18.0

