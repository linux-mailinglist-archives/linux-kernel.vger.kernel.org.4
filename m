Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369266D5A72
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbjDDILl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjDDILU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:11:20 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE7B1BE6;
        Tue,  4 Apr 2023 01:11:14 -0700 (PDT)
X-UUID: 40312e06d2c011edb6b9f13eb10bd0fe-20230404
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Mi6bDKZ6UsCy6bGsJ6TOr2TnUx3aUYpyfS8ZUumFnpE=;
        b=p7QStzpCpIlBttQuyparTiV5SB2UkkzYcPrYUapHF3yzUKIOIf15QRAIb72ZPKAiLs4XD8aM/SLrcLbiyfpv0fOzh9Vu3i+kCTXsl+tBl6MSfaeVbUXwXcl3HhON3mwwWMz1q+lfikiC8QMddZGKTPjDhbwDHhC4XEzawIXJ7Go=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:91a2093a-41c1-49cf-b5af-fb29e97ce0be,IP:0,U
        RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-55
X-CID-META: VersionHash:120426c,CLOUDID:e7b236b5-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
        L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 40312e06d2c011edb6b9f13eb10bd0fe-20230404
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 60458757; Tue, 04 Apr 2023 16:11:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 4 Apr 2023 16:11:05 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 4 Apr 2023 16:11:04 +0800
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
Subject: [PATCH v4,2/8] media: mediatek: vcodec: Add debug params to control different log level
Date:   Tue, 4 Apr 2023 16:10:56 +0800
Message-ID: <20230404081102.30713-3-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404081102.30713-1-yunfei.dong@mediatek.com>
References: <20230404081102.30713-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add parameter mtk_vcodec_dbg to open each codec log.
Add parameter mtk_v4l2_dbg_level to open each instance log according to
the parameter value.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../mediatek/vcodec/mtk_vcodec_dbgfs.c        |  2 ++
 .../mediatek/vcodec/mtk_vcodec_util.c         |  8 ++++++
 .../mediatek/vcodec/mtk_vcodec_util.h         | 26 ++++++++++++++++---
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
index fb9edd379af5..b5093e4e4aa2 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
@@ -20,6 +20,8 @@ void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev)
 			IS_ERR(vcodec_dev->dbgfs.vcodec_root));
 
 	vcodec_root = vcodec_dev->dbgfs.vcodec_root;
+	debugfs_create_x32("mtk_v4l2_dbg_level", 0644, vcodec_root, &mtk_v4l2_dbg_level);
+	debugfs_create_x32("mtk_vcodec_dbg", 0644, vcodec_root, &mtk_vcodec_dbg);
 }
 EXPORT_SYMBOL_GPL(mtk_vcodec_dbgfs_init);
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
index ace78c4b5b9e..f214e6f67005 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
@@ -13,6 +13,14 @@
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_util.h"
 
+#if defined(CONFIG_DEBUG_FS)
+int mtk_vcodec_dbg;
+EXPORT_SYMBOL(mtk_vcodec_dbg);
+
+int mtk_v4l2_dbg_level;
+EXPORT_SYMBOL(mtk_v4l2_dbg_level);
+#endif
+
 void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
 					unsigned int reg_idx)
 {
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
index 71956627a0e2..587aa817e7f4 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
@@ -35,15 +35,35 @@ struct mtk_vcodec_dev;
 	pr_err("[MTK_VCODEC][ERROR][%d]: " fmt "\n",		\
 	       ((struct mtk_vcodec_ctx *)(h)->ctx)->id, ##args)
 
+#if defined(CONFIG_DEBUG_FS)
+extern int mtk_v4l2_dbg_level;
+extern int mtk_vcodec_dbg;
 
-#define mtk_v4l2_debug(level, fmt, args...) pr_debug(fmt, ##args)
+#define mtk_v4l2_debug(level, fmt, args...)				\
+	do {								\
+		if (mtk_v4l2_dbg_level >= level)			\
+			pr_debug("[MTK_V4L2] %s, %d: " fmt "\n",        \
+				 __func__, __LINE__, ##args);	        \
+	} while (0)
 
-#define mtk_v4l2_debug_enter()  mtk_v4l2_debug(3, "+")
-#define mtk_v4l2_debug_leave()  mtk_v4l2_debug(3, "-")
+#define mtk_vcodec_debug(h, fmt, args...)				                      \
+	do {								                      \
+		if (mtk_vcodec_dbg)					                      \
+			dev_dbg(&(((struct mtk_vcodec_ctx *)(h)->ctx)->dev->plat_dev->dev),   \
+				"[MTK_VCODEC][%d]: %s, %d " fmt "\n",                         \
+				((struct mtk_vcodec_ctx *)(h)->ctx)->id,                      \
+				__func__, __LINE__, ##args);                                  \
+	} while (0)
+#else
+#define mtk_v4l2_debug(level, fmt, args...) pr_debug(fmt, ##args)
 
 #define mtk_vcodec_debug(h, fmt, args...)			\
 	pr_debug("[MTK_VCODEC][%d]: " fmt "\n",			\
 		((struct mtk_vcodec_ctx *)(h)->ctx)->id, ##args)
+#endif
+
+#define mtk_v4l2_debug_enter()  mtk_v4l2_debug(3, "+")
+#define mtk_v4l2_debug_leave()  mtk_v4l2_debug(3, "-")
 
 #define mtk_vcodec_debug_enter(h)  mtk_vcodec_debug(h, "+")
 #define mtk_vcodec_debug_leave(h)  mtk_vcodec_debug(h, "-")
-- 
2.18.0

