Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6D26C46DA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCVJqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjCVJqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:46:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708C05DCB2;
        Wed, 22 Mar 2023 02:46:30 -0700 (PDT)
X-UUID: 689a4708c89611edb6b9f13eb10bd0fe-20230322
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NN3IX4VhJe8xsbI8aOswJ8E24INvALh8nBv+h/C9/oQ=;
        b=fy5zz04yBEvNoBYb119DheJ2lJZH00udQ9lGz+U10MFBN5KEArMTfUb/r5ofzNHhUS11M0Z0n5w7+Fuq7qSHfY9HzRSQ/4ZNZp/ATIp2ZMjkdx4jKDegs7SQzA4RBCLR+a87JaXUsOFgfSR9Fv4OX3nckovxBvI6ekQgUGt0XWA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:78ef8227-ae93-46ce-bcf8-18a9cf30c99f,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:0b1693f6-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 689a4708c89611edb6b9f13eb10bd0fe-20230322
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 510898661; Wed, 22 Mar 2023 17:46:24 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 22 Mar 2023 17:46:23 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 22 Mar 2023 17:46:22 +0800
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
Subject: [PATCH v2,3/7] media: mediatek: vcodec: Add a debugfs file to get different useful information
Date:   Wed, 22 Mar 2023 17:46:13 +0800
Message-ID: <20230322094617.19410-4-yunfei.dong@mediatek.com>
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

In oder to get each instance information according to test command, adding
one file node "vdec".

Can use echo command to set different string value as 'echo -picinfo > vdec'.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../mediatek/vcodec/mtk_vcodec_dbgfs.c        | 64 +++++++++++++++++++
 .../mediatek/vcodec/mtk_vcodec_dbgfs.h        | 32 ++++++++++
 .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |  2 +
 3 files changed, 98 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
index b5093e4e4aa2..49f0891e4923 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
@@ -10,6 +10,64 @@
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_util.h"
 
+static ssize_t mtk_vdec_dbgfs_write(struct file *filp, const char __user *ubuf,
+				    size_t count, loff_t *ppos)
+{
+	struct mtk_vcodec_dev *vcodec_dev = filp->private_data;
+	struct mtk_vcodec_dbgfs *dbgfs = &vcodec_dev->dbgfs;
+	int len;
+
+	mutex_lock(&dbgfs->dbgfs_lock);
+	len = simple_write_to_buffer(dbgfs->dbgfs_buf, sizeof(dbgfs->dbgfs_buf) - 1,
+				     ppos, ubuf, count);
+	mutex_unlock(&dbgfs->dbgfs_lock);
+	if (len > 0)
+		return count;
+
+	return len;
+}
+
+static const struct file_operations vdec_fops = {
+	.open = simple_open,
+	.write = mtk_vdec_dbgfs_write,
+};
+
+void mtk_vcodec_dbgfs_create(struct mtk_vcodec_ctx *ctx)
+{
+	struct mtk_vcodec_dbgfs_inst *dbgfs_inst;
+	struct mtk_vcodec_dev *vcodec_dev = ctx->dev;
+
+	dbgfs_inst = kzalloc(sizeof(*dbgfs_inst), GFP_KERNEL);
+	if (!dbgfs_inst)
+		return;
+
+	list_add_tail(&dbgfs_inst->node, &vcodec_dev->dbgfs.dbgfs_head);
+
+	vcodec_dev->dbgfs.inst_count++;
+
+	dbgfs_inst->inst_id = ctx->id;
+	dbgfs_inst->vcodec_ctx = ctx;
+}
+EXPORT_SYMBOL_GPL(mtk_vcodec_dbgfs_create);
+
+void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dev *vcodec_dev, int ctx_id)
+{
+	struct mtk_vcodec_dbgfs_inst *dbgfs_inst;
+
+	list_for_each_entry(dbgfs_inst, &vcodec_dev->dbgfs.dbgfs_head, node) {
+		if (dbgfs_inst && dbgfs_inst->inst_id == ctx_id) {
+			vcodec_dev->dbgfs.inst_count--;
+			break;
+		}
+	}
+
+	if (dbgfs_inst) {
+		list_del(&dbgfs_inst->node);
+		kfree(dbgfs_inst);
+	}
+}
+EXPORT_SYMBOL_GPL(mtk_vcodec_dbgfs_remove);
+
 void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev)
 {
 	struct dentry *vcodec_root;
@@ -22,6 +80,12 @@ void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev)
 	vcodec_root = vcodec_dev->dbgfs.vcodec_root;
 	debugfs_create_x32("mtk_v4l2_dbg_level", 0644, vcodec_root, &mtk_v4l2_dbg_level);
 	debugfs_create_x32("mtk_vcodec_dbg", 0644, vcodec_root, &mtk_vcodec_dbg);
+
+	vcodec_dev->dbgfs.inst_count = 0;
+
+	INIT_LIST_HEAD(&vcodec_dev->dbgfs.dbgfs_head);
+	debugfs_create_file("vdec", 0200, vcodec_root, vcodec_dev, &vdec_fops);
+	mutex_init(&vcodec_dev->dbgfs.dbgfs_lock);
 }
 EXPORT_SYMBOL_GPL(mtk_vcodec_dbgfs_init);
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
index 5eec2211cbbe..47c0a986877d 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
@@ -8,19 +8,51 @@
 #define __MTK_VCODEC_DBGFS_H__
 
 struct mtk_vcodec_dev;
+struct mtk_vcodec_ctx;
+
+/**
+ * struct mtk_vcodec_dbgfs_inst  - debugfs informatiaoin for each inst
+ * @node: list node for each inst
+ * @vcodec_ctx: struct mtk_vcodec_ctx
+ * @inst_id: index of the context that the same with ctx->id
+ */
+struct mtk_vcodec_dbgfs_inst {
+	struct list_head node;
+	struct mtk_vcodec_ctx *vcodec_ctx;
+	int inst_id;
+};
 
 /**
  * struct mtk_vcodec_dbgfs  - dbgfs information
+ * @dbgfs_head: list head used to link each instance
  * @vcodec_root: vcodec dbgfs entry
+ * @dbgfs_lock: dbgfs lock used to protect dbgfs_buf
+ * @dbgfs_buf: dbgfs buf used to store dbgfs cmd
+ * @inst_count: the count of total instance
  */
 struct mtk_vcodec_dbgfs {
+	struct list_head dbgfs_head;
 	struct dentry *vcodec_root;
+	/* dbgfs lock used to protect dbgfs_buf */
+	struct mutex dbgfs_lock;
+	char dbgfs_buf[1024];
+	int inst_count;
 };
 
 #if defined(CONFIG_DEBUG_FS)
+void mtk_vcodec_dbgfs_create(struct mtk_vcodec_ctx *ctx);
+void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dev *vcodec_dev, int ctx_id);
 void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev);
 void mtk_vcodec_dbgfs_deinit(struct mtk_vcodec_dev *vcodec_dev);
 #else
+static inline void mtk_vcodec_dbgfs_create(struct mtk_vcodec_ctx *ctx)
+{
+}
+
+static inline void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dev *vcodec_dev, int ctx_id)
+{
+}
+
 static inline void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev)
 {
 }
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index de29b1fb0436..8c2443a18f5e 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -215,6 +215,7 @@ static int fops_vcodec_open(struct file *file)
 	ctx->dev->vdec_pdata->init_vdec_params(ctx);
 
 	list_add(&ctx->list, &dev->ctx_list);
+	mtk_vcodec_dbgfs_create(ctx);
 
 	mutex_unlock(&dev->dev_mutex);
 	mtk_v4l2_debug(0, "%s decoder [%d]", dev_name(&dev->plat_dev->dev),
@@ -256,6 +257,7 @@ static int fops_vcodec_release(struct file *file)
 	v4l2_fh_exit(&ctx->fh);
 	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
 
+	mtk_vcodec_dbgfs_remove(dev, ctx->id);
 	list_del_init(&ctx->list);
 	kfree(ctx);
 	mutex_unlock(&dev->dev_mutex);
-- 
2.18.0

