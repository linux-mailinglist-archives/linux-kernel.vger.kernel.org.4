Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB872715F79
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjE3Ma3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjE3M3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:29:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8AFF9;
        Tue, 30 May 2023 05:29:40 -0700 (PDT)
X-UUID: 97b4fdaafee511edb20a276fd37b9834-20230530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7j+9YZRWKGzMU0DwBT53uBWfSm9LyfwuPLRQUzjWZw4=;
        b=KXh2uPTohXXjui52w9L8i8vugXsvCTY91Li5WQ2F3/j64boBlZcIdmtMwi32ihlunDzmrvJweF9Il1IkPjaiaXFuFDhWTA21k7Zqu+7HFdYFffLaa+/SNIzTdpC4VhzZhSRhUQx/7P+ZCfa+pzYlNSiU6LfVaDNf5Ban3kqE4Gk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:4497a3a4-1c97-4696-9e78-a7e3bbc8beba,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.25,REQID:4497a3a4-1c97-4696-9e78-a7e3bbc8beba,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:d5b0ae3,CLOUDID:47f5d13c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230530202919ROX6W98X,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48|38,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 97b4fdaafee511edb20a276fd37b9834-20230530
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 905355422; Tue, 30 May 2023 20:29:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 May 2023 20:29:14 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 May 2023 20:29:13 +0800
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
Subject: [PATCH v6,4/8] media: mediatek: vcodec: Get each context resolution information
Date:   Tue, 30 May 2023 20:29:04 +0800
Message-ID: <20230530122908.19267-5-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530122908.19267-1-yunfei.dong@mediatek.com>
References: <20230530122908.19267-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will store the string to temp buffer like "echo -picinfo > vdec" when
user want to get needed information.

Then getting debug information using command 'cat vdec' calling mtk_vdec_dbgfs_read
to analysis the temp buffer.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../mediatek/vcodec/mtk_vcodec_dbgfs.c        | 42 +++++++++++++++++++
 .../mediatek/vcodec/mtk_vcodec_dbgfs.h        |  8 ++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
index 70286088cce8..5b6bd4c4de3b 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
@@ -26,9 +26,51 @@ static ssize_t mtk_vdec_dbgfs_write(struct file *filp, const char __user *ubuf,
 	return dbgfs->buf_size;
 }
 
+static ssize_t mtk_vdec_dbgfs_read(struct file *filp, char __user *ubuf,
+				   size_t count, loff_t *ppos)
+{
+	struct mtk_vcodec_dev *vcodec_dev = filp->private_data;
+	struct mtk_vcodec_dbgfs *dbgfs = &vcodec_dev->dbgfs;
+	struct mtk_vcodec_dbgfs_inst *dbgfs_inst;
+	struct mtk_vcodec_ctx *ctx;
+	int total_len = 200 * (dbgfs->inst_count == 0 ? 1 : dbgfs->inst_count);
+	int used_len = 0, curr_len, ret;
+	bool dbgfs_index[MTK_VDEC_DBGFS_MAX] = {0};
+	char *buf = kmalloc(total_len, GFP_KERNEL);
+
+	if (!buf)
+		return -ENOMEM;
+
+	if (strstr(dbgfs->dbgfs_buf, "-picinfo"))
+		dbgfs_index[MTK_VDEC_DBGFS_PICINFO] = true;
+
+	mutex_lock(&dbgfs->dbgfs_lock);
+	list_for_each_entry(dbgfs_inst, &dbgfs->dbgfs_head, node) {
+		ctx = dbgfs_inst->vcodec_ctx;
+
+		curr_len = snprintf(buf + used_len, total_len - used_len,
+				    "inst[%d]:\n ", ctx->id);
+		used_len += curr_len;
+
+		if (dbgfs_index[MTK_VDEC_DBGFS_PICINFO]) {
+			curr_len = snprintf(buf + used_len, total_len - used_len,
+					    "\treal(%dx%d)=>align(%dx%d)\n",
+					    ctx->picinfo.pic_w, ctx->picinfo.pic_h,
+					    ctx->picinfo.buf_w, ctx->picinfo.buf_h);
+			used_len += curr_len;
+		}
+	}
+	mutex_unlock(&dbgfs->dbgfs_lock);
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, buf, used_len);
+	kfree(buf);
+	return ret;
+}
+
 static const struct file_operations vdec_fops = {
 	.open = simple_open,
 	.write = mtk_vdec_dbgfs_write,
+	.read = mtk_vdec_dbgfs_read,
 };
 
 void mtk_vcodec_dbgfs_create(struct mtk_vcodec_ctx *ctx)
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
index a563e656f42e..30d956b7227f 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
@@ -10,6 +10,14 @@
 struct mtk_vcodec_dev;
 struct mtk_vcodec_ctx;
 
+/*
+ * enum mtk_vdec_dbgfs_log_index  - used to get different debug information
+ */
+enum mtk_vdec_dbgfs_log_index {
+	MTK_VDEC_DBGFS_PICINFO,
+	MTK_VDEC_DBGFS_MAX,
+};
+
 /**
  * struct mtk_vcodec_dbgfs_inst  - debugfs information for each inst
  * @node:       list node for each inst
-- 
2.18.0

