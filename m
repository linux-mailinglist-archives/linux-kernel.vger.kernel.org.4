Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5255E9D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiIZJQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiIZJPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:15:07 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC45E12;
        Mon, 26 Sep 2022 02:14:55 -0700 (PDT)
X-UUID: 1d2114130dad45feb09af0da48f009d1-20220926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UF+VNjd4uaAdIxTTkpN1cO5x+FEAhRA4p3U4l4HqJOM=;
        b=IdNeERCvvh9tKI4li+etELzRX9jd/VkrFQEqlzXoPiRWWQgTOlkcBJvRMAK7FtsnS4CctODvy9CT9t1H3GvKhw5WA3yIwLzkBWHFxxaPROX9cGzWTbOtUXvT4xtS5XdRkHG+TGqsZX2ImXRwhc80lqKfBBepXxaLdVhvz/ddJRs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:69c3fff4-286a-494b-8e9b-e0dfe1f7d078,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.11,REQID:69c3fff4-286a-494b-8e9b-e0dfe1f7d078,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:39a5ff1,CLOUDID:10e30707-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:2209261714531LE2BZ4X,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1d2114130dad45feb09af0da48f009d1-20220926
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1249763447; Mon, 26 Sep 2022 17:14:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 26 Sep 2022 17:14:51 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 26 Sep 2022 17:14:49 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>, <wenst@chromium.org>,
        kyrie wu <kyrie.wu@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <maoguang.meng@mediatek.com>, irui wang <irui.wang@mediatek.com>
Subject: [V15,11/15] media: mtk-jpegdec: add jpegdec timeout func interface
Date:   Mon, 26 Sep 2022 17:14:29 +0800
Message-ID: <20220926091433.18633-12-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926091433.18633-1-irui.wang@mediatek.com>
References: <20220926091433.18633-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: kyrie wu <kyrie.wu@mediatek.com>

Generalizes jpegdec timeout func interfaces to handle HW timeout.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
---
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  4 ++++
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  | 24 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
index dd974409ae5e..391c4ec25b2c 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
@@ -165,6 +165,8 @@ struct mtk_jpegenc_comp_dev {
  * @master_dev:			mtk_jpeg_dev device
  * @jdec_clk:			mtk_jpegdec_clk
  * @jpegdec_irq:		jpeg decode irq num
+ * @job_timeout_work:		decode timeout workqueue
+ * @hw_param:			jpeg decode hw parameters
  */
 struct mtk_jpegdec_comp_dev {
 	struct device *dev;
@@ -173,6 +175,8 @@ struct mtk_jpegdec_comp_dev {
 	struct mtk_jpeg_dev *master_dev;
 	struct mtk_jpegdec_clk jdec_clk;
 	int jpegdec_irq;
+	struct delayed_work job_timeout_work;
+	struct mtk_jpeg_hw_param hw_param;
 };
 
 /**
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
index bab50f750113..d65cc0a3b663 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
@@ -440,6 +440,25 @@ void mtk_jpeg_dec_set_config(void __iomem *base,
 }
 EXPORT_SYMBOL_GPL(mtk_jpeg_dec_set_config);
 
+static void mtk_jpegdec_timeout_work(struct work_struct *work)
+{
+	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
+	struct mtk_jpegdec_comp_dev *cjpeg =
+		container_of(work, struct mtk_jpegdec_comp_dev,
+			     job_timeout_work.work);
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
+
+	src_buf = cjpeg->hw_param.src_buffer;
+	dst_buf = cjpeg->hw_param.dst_buffer;
+	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
+
+	mtk_jpeg_dec_reset(cjpeg->reg_base);
+	clk_disable_unprepare(cjpeg->jdec_clk.clks->clk);
+	pm_runtime_put(cjpeg->dev);
+	v4l2_m2m_buf_done(src_buf, buf_state);
+	v4l2_m2m_buf_done(dst_buf, buf_state);
+}
+
 static irqreturn_t mtk_jpegdec_hw_irq_handler(int irq, void *priv)
 {
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
@@ -453,6 +472,8 @@ static irqreturn_t mtk_jpegdec_hw_irq_handler(int irq, void *priv)
 	struct mtk_jpegdec_comp_dev *jpeg = priv;
 	struct mtk_jpeg_dev *master_jpeg = jpeg->master_dev;
 
+	cancel_delayed_work(&jpeg->job_timeout_work);
+
 	irq_status = mtk_jpeg_dec_get_int_status(jpeg->reg_base);
 	dec_irq_ret = mtk_jpeg_dec_enum_result(irq_status);
 	if (dec_irq_ret >= MTK_JPEG_DEC_RESULT_UNDERFLOW)
@@ -538,6 +559,9 @@ static int mtk_jpegdec_hw_probe(struct platform_device *pdev)
 			master_dev->dec_hw_dev[i] = NULL;
 	}
 
+	INIT_DELAYED_WORK(&dev->job_timeout_work,
+			  mtk_jpegdec_timeout_work);
+
 	jpegdec_clk = &dev->jdec_clk;
 
 	jpegdec_clk->clk_num = devm_clk_bulk_get_all(&pdev->dev,
-- 
2.18.0

