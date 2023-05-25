Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61447102AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 04:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbjEYCMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 22:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjEYCMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 22:12:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4171183;
        Wed, 24 May 2023 19:12:34 -0700 (PDT)
X-UUID: 99013928faa111edb20a276fd37b9834-20230525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OdwggkEa8lSS9goiK6yleetfpFnw+Us2e31mplTfjLk=;
        b=bvOO/SSixm9TwgEGtWk9Snx1o9vpGbNiGl/6Ys4kmgo0FFnTQQLxC5BrCCzfKzFbnrc6i9wqT/KQyLmZb/V7JlQiQnmu2snuiY2Pyz7ObnftmGNK7FZZk+GXApECYKQKR3/lrirW4V+4Mf0Kqht2Z84XJQS9rX4Gx5ujlUNYRBk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:06a8df93-f3aa-4a3e-9816-a75e8fceccb9,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:d5b0ae3,CLOUDID:e932ec6c-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 99013928faa111edb20a276fd37b9834-20230525
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 357888426; Thu, 25 May 2023 10:12:28 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 10:12:26 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 10:12:25 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Nathan Hebert <nhebert@chromium.org>
CC:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v5,6/8] media: mediatek: vcodec: Change dbgfs interface to support encode
Date:   Thu, 25 May 2023 10:12:17 +0800
Message-ID: <20230525021219.23638-7-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525021219.23638-1-yunfei.dong@mediatek.com>
References: <20230525021219.23638-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Extend dbgfs init interface to support encode and create encode
dbgfs file.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c    | 9 +++++++--
 .../media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h    | 4 ++--
 .../media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c  | 2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
index b2b69c3400d4..237d0dc8a1fc 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
@@ -158,11 +158,14 @@ void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dev *vcodec_dev, int ctx_id)
 }
 EXPORT_SYMBOL_GPL(mtk_vcodec_dbgfs_remove);
 
-void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev)
+void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev, bool is_encode)
 {
 	struct dentry *vcodec_root;
 
-	vcodec_dev->dbgfs.vcodec_root = debugfs_create_dir("vcodec-dec", NULL);
+	if (is_encode)
+		vcodec_dev->dbgfs.vcodec_root = debugfs_create_dir("vcodec-enc", NULL);
+	else
+		vcodec_dev->dbgfs.vcodec_root = debugfs_create_dir("vcodec-dec", NULL);
 	if (IS_ERR(vcodec_dev->dbgfs.vcodec_root))
 		dev_err(&vcodec_dev->plat_dev->dev, "create vcodec dir err:%d\n",
 			IS_ERR(vcodec_dev->dbgfs.vcodec_root));
@@ -172,6 +175,8 @@ void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev)
 	debugfs_create_x32("mtk_vcodec_dbg", 0644, vcodec_root, &mtk_vcodec_dbg);
 
 	vcodec_dev->dbgfs.inst_count = 0;
+	if (is_encode)
+		return;
 
 	INIT_LIST_HEAD(&vcodec_dev->dbgfs.dbgfs_head);
 	debugfs_create_file("vdec", 0200, vcodec_root, vcodec_dev, &vdec_fops);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
index b0bdb84a46df..ba43518d0fcb 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
@@ -50,7 +50,7 @@ struct mtk_vcodec_dbgfs {
 #if defined(CONFIG_DEBUG_FS)
 void mtk_vcodec_dbgfs_create(struct mtk_vcodec_ctx *ctx);
 void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dev *vcodec_dev, int ctx_id);
-void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev);
+void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev, bool is_encode);
 void mtk_vcodec_dbgfs_deinit(struct mtk_vcodec_dev *vcodec_dev);
 #else
 static inline void mtk_vcodec_dbgfs_create(struct mtk_vcodec_ctx *ctx)
@@ -61,7 +61,7 @@ static inline void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dev *vcodec_dev, in
 {
 }
 
-static inline void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev)
+static inline void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev, bool is_encode)
 {
 }
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index b25943ac3909..d41f2121b94f 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -424,7 +424,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		mtk_v4l2_debug(0, "media registered as /dev/media%d", vfd_dec->minor);
 	}
 
-	mtk_vcodec_dbgfs_init(dev);
+	mtk_vcodec_dbgfs_init(dev, false);
 	mtk_v4l2_debug(0, "decoder registered as /dev/video%d", vfd_dec->minor);
 
 	return 0;
-- 
2.25.1

