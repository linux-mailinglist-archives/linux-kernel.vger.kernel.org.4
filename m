Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A094F6009DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJQJDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJQJC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:02:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF7AD2C8;
        Mon, 17 Oct 2022 02:02:50 -0700 (PDT)
X-UUID: 81731069ea9f428bba80afca5c5170b7-20221017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=gD7N/DSSbp1mar+/nG/ZYQKwg+fZQKRkhDobou7t55w=;
        b=i3x8AG2rgTxMncYCZkjdDDrPgOnhj1V7F17eFql8FdFiujyWPTd+cNmUixs7KrGXG1oYRsnpAFDqFwGyJmsfXHswiwfar5C7LUYzI4SFsUjj8yyms2XwnyG5+vv4x4BpuhhhAwFLCizYrWaLL0OkaGI9WwqNzv8F4WrfFJerhxA=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:e993502a-027b-4bfe-aa39-1365ebccd8ea,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:75
X-CID-INFO: VERSION:1.1.11,REQID:e993502a-027b-4bfe-aa39-1365ebccd8ea,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:75
X-CID-META: VersionHash:39a5ff1,CLOUDID:a0f097db-0379-47b3-a5dd-2ef5001d380a,B
        ulkID:221017170245IG1IMEOR,BulkQuantity:0,Recheck:0,SF:38|28|16|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 81731069ea9f428bba80afca5c5170b7-20221017
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1205390772; Mon, 17 Oct 2022 17:02:42 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 17 Oct 2022 17:02:41 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 17 Oct 2022 17:02:40 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH] media: mediatek: vcodec: fix h264 cavlc bitstream fail
Date:   Mon, 17 Oct 2022 17:02:08 +0800
Message-ID: <20221017090208.19041-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cavlc bistream will decode fail when the frame size is small than
20 bytes. Need to add pending data at the end of the bitstream.

For the size of mapped memory is at least one page, adding four bytes data
won't lead to access unknown virtual memory.

Fixes: 59fba9eed5a7 ("media: mediatek: vcodec: support stateless H.264 decoding for mt8192")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../vcodec/vdec/vdec_h264_req_multi_if.c      | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
index 4cc92700692b..c1583dddcb04 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
@@ -539,6 +539,24 @@ static int vdec_h264_slice_core_decode(struct vdec_lat_buf *lat_buf)
 	return 0;
 }
 
+static void vdec_h264_insert_startcode(struct mtk_vcodec_dev *vcodec_dev, unsigned char *buf,
+				       size_t *bs_size, struct mtk_h264_pps_param *pps)
+{
+	struct device *dev = &vcodec_dev->plat_dev->dev;
+
+	/* cavlc bitstream when entropy_coding_mode_flag is false. */
+	if (pps->entropy_coding_mode_flag || *bs_size > 20 ||
+	    !(of_device_is_compatible(dev->of_node, "mediatek,mt8192-vcodec-dec") ||
+	    of_device_is_compatible(dev->of_node, "mediatek,mt8195-vcodec-dec")))
+		return;
+
+	buf[*bs_size] = 0;
+	buf[*bs_size + 1] = 0;
+	buf[*bs_size + 2] = 1;
+	buf[*bs_size + 3] = 0xff;
+	(*bs_size) += 4;
+}
+
 static int vdec_h264_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 				      struct vdec_fb *fb, bool *res_chg)
 {
@@ -582,9 +600,6 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	}
 
 	inst->vsi->dec.nal_info = buf[nal_start_idx];
-	inst->vsi->dec.bs_buf_addr = (u64)bs->dma_addr;
-	inst->vsi->dec.bs_buf_size = bs->size;
-
 	lat_buf->src_buf_req = src_buf_info->m2m_buf.vb.vb2_buf.req_obj.req;
 	v4l2_m2m_buf_copy_metadata(&src_buf_info->m2m_buf.vb, &lat_buf->ts_info, true);
 
@@ -592,6 +607,12 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	if (err)
 		goto err_free_fb_out;
 
+	vdec_h264_insert_startcode(inst->ctx->dev, buf, &bs->size,
+				   &share_info->h264_slice_params.pps);
+
+	inst->vsi->dec.bs_buf_addr = (uint64_t)bs->dma_addr;
+	inst->vsi->dec.bs_buf_size = bs->size;
+
 	*res_chg = inst->resolution_changed;
 	if (inst->resolution_changed) {
 		mtk_vcodec_debug(inst, "- resolution changed -");
-- 
2.25.1

