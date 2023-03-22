Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2136C46DE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjCVJqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjCVJqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:46:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0095DCB2;
        Wed, 22 Mar 2023 02:46:33 -0700 (PDT)
X-UUID: 6ade84a2c89611eda9a90f0bb45854f4-20230322
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=US96CU8gwOlQDNGnB1czPTrVjQZwc8zoh0dPgirX9Jo=;
        b=lB445nTnCanSQQMflsKKhjjN1c4h49BsglPjE1GcuwmiIYO3XdqLkUOqHFeT+wLU3TOOErH6mX3bAPAo+8bID8xf3AdtzzgE5MtBkA+alTC8lxHkiMIYKqvyKRZv+6WErpFtzARO1x4DAI9CEPJXhd6CHkMPnHxJtPvws9XNq7k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:8b089333-8413-4f80-bb6f-3c91fdc53af2,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.22,REQID:8b089333-8413-4f80-bb6f-3c91fdc53af2,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:120426c,CLOUDID:1e8005b4-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230322174629W1R8T42K,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 6ade84a2c89611eda9a90f0bb45854f4-20230322
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 427927871; Wed, 22 Mar 2023 17:46:28 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 22 Mar 2023 17:46:26 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 22 Mar 2023 17:46:26 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
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
Subject: [PATCH v2,7/7] media: mediatek: vcodec: Add encode to support dbgfs
Date:   Wed, 22 Mar 2023 17:46:17 +0800
Message-ID: <20230322094617.19410-8-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322094617.19410-1-yunfei.dong@mediatek.com>
References: <20230322094617.19410-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add encode to support dbgfs.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index 9095186d5495..6961f66b5693 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -353,6 +353,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		goto err_enc_reg;
 	}
 
+	mtk_vcodec_dbgfs_init(dev, true);
 	mtk_v4l2_debug(0, "encoder %d registered as /dev/video%d",
 		       dev->venc_pdata->core_id, vfd_enc->num);
 
@@ -463,6 +464,7 @@ static int mtk_vcodec_enc_remove(struct platform_device *pdev)
 	if (dev->vfd_enc)
 		video_unregister_device(dev->vfd_enc);
 
+	mtk_vcodec_dbgfs_deinit(dev);
 	v4l2_device_unregister(&dev->v4l2_dev);
 	pm_runtime_disable(dev->pm.dev);
 	mtk_vcodec_fw_release(dev->fw_handler);
-- 
2.18.0

