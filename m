Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BF86DD220
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDKFyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDKFya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:54:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E621CE6A;
        Mon, 10 Apr 2023 22:54:22 -0700 (PDT)
X-UUID: 4bdcb97ed82d11edb6b9f13eb10bd0fe-20230411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hlzUNXvIMOQc13xK9X1uYOOly8rXvrRJ86fD7YnDQ/U=;
        b=Sg1Bfe8zvipETD43TMa8G9cAc0DlLJyY3dihZkmO8efWTESUiqQCDYD36MIZ9XhyZD6I+kK16feJpBIHHRlpYkueSJRl6BR0L5zzSNrn1MtaFJQLd3BNewIMNRbcUb+8u4IZMPvN70nBMxmlBTg6Yp4QrUzkGIXA5Ijuu2uMZzI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:37fdfbfb-d691-4357-9921-2041b2a9c00f,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:fe30a683-cd9c-45f5-8134-710979e3df0e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 4bdcb97ed82d11edb6b9f13eb10bd0fe-20230411
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 120522778; Tue, 11 Apr 2023 13:54:17 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 11 Apr 2023 13:54:16 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 11 Apr 2023 13:54:15 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <maoguang.meng@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>
Subject: [PATCH v2, 1/2] media: mediatek: vcodec: make sure array index is in valid range
Date:   Tue, 11 Apr 2023 13:54:12 +0800
Message-ID: <20230411055413.539-2-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230411055413.539-1-irui.wang@mediatek.com>
References: <20230411055413.539-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        MAY_BE_FORGED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CERT-C Characters and Strings:
dev->reg_base[dev->venc_pdata->core_id] evaluates to an address
that could be at negative offset of an array, check core id is
in valid range.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c         | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index 9095186d5495..125d5722d07b 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -89,16 +89,24 @@ static irqreturn_t mtk_vcodec_enc_irq_handler(int irq, void *priv)
 	struct mtk_vcodec_ctx *ctx;
 	unsigned long flags;
 	void __iomem *addr;
+	int core_id;
 
 	spin_lock_irqsave(&dev->irqlock, flags);
 	ctx = dev->curr_ctx;
 	spin_unlock_irqrestore(&dev->irqlock, flags);
 
-	mtk_v4l2_debug(1, "id=%d coreid:%d", ctx->id, dev->venc_pdata->core_id);
-	addr = dev->reg_base[dev->venc_pdata->core_id] +
-				MTK_VENC_IRQ_ACK_OFFSET;
+	core_id = dev->venc_pdata->core_id;
+	if (core_id < 0 || core_id >= NUM_MAX_VCODEC_REG_BASE) {
+		mtk_v4l2_err("Invalid core id: %d, ctx id: %d",
+			     core_id, ctx->id);
+		return IRQ_HANDLED;
+	}
+
+	mtk_v4l2_debug(1, "id: %d, core id: %d", ctx->id, core_id);
+
+	addr = dev->reg_base[core_id] + MTK_VENC_IRQ_ACK_OFFSET;
 
-	ctx->irq_status = readl(dev->reg_base[dev->venc_pdata->core_id] +
+	ctx->irq_status = readl(dev->reg_base[core_id] +
 				(MTK_VENC_IRQ_STATUS_OFFSET));
 
 	clean_irq_status(ctx->irq_status, addr);
-- 
2.18.0

