Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA362B305
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiKPF43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKPF41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:56:27 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2E821837;
        Tue, 15 Nov 2022 21:56:24 -0800 (PST)
X-UUID: c6593fea7943441485e5496de840b9cf-20221116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=q44V2KOaAYcD/N+xk+VWumpglKqAK6Nls/jOUYK03DQ=;
        b=vFGnSrW4nJV/bfqQNcxabBjTXcTUmPtijIvXK8SG1rLpoCjm6BjEcFKFLLxm5tIaLdBw6OaxVoKZg8Oe4oEQ34G3lVYyODCzYLkGspO1riVmBDx5A3G2H3AbX1qvBFLp+Z2aZUPsMPlaHcwVMUJf1f0lWgQYvTKK3qvgotaBEdE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:9d3af225-3a5a-427c-a451-6988505c6a19,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:75
X-CID-INFO: VERSION:1.1.12,REQID:9d3af225-3a5a-427c-a451-6988505c6a19,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:75
X-CID-META: VersionHash:62cd327,CLOUDID:7af24b28-7328-4d53-af97-37d3ca89e562,B
        ulkID:2211161356190S8IP0MV,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c6593fea7943441485e5496de840b9cf-20221116
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1930682219; Wed, 16 Nov 2022 13:56:17 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 16 Nov 2022 13:56:16 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 16 Nov 2022 13:56:15 +0800
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
Subject: [PATCH v3] media: mediatek: vcodec: fix h264 cavlc bitstream fail
Date:   Wed, 16 Nov 2022 13:56:13 +0800
Message-ID: <20221116055613.13991-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cavlc bistream will decode fail when the frame size is smaller than
20 bytes. Need to add pending data at the end of the bitstream.

For the minimum size of mapped memory is 256 bytes(16x16), adding four bytes data
won't lead to access unknown virtual memory.

Fixes: 59fba9eed5a7 ("media: mediatek: vcodec: support stateless H.264 decoding for mt8192")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
changed with v2:
- using flag to separate, not compatible name.
- replace small with smaller.
---
 .../vcodec/vdec/vdec_h264_req_multi_if.c      | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
index 2b7576265f48..0e7a70862525 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
@@ -150,6 +150,7 @@ struct vdec_h264_slice_share_info {
  * @dpb:		decoded picture buffer used to store reference
  *			buffer information
  *@is_field_bitstream:	is field bitstream
+ * @is_need_pending_data: add startcode for cavlc bistream when bs size is smaller than 20 bytes
  */
 struct vdec_h264_slice_inst {
 	unsigned int slice_dec_num;
@@ -169,6 +170,7 @@ struct vdec_h264_slice_inst {
 
 	struct v4l2_h264_dpb_entry dpb[16];
 	bool is_field_bitstream;
+	bool is_need_pending_data;
 };
 
 static int vdec_h264_slice_fill_decode_parameters(struct vdec_h264_slice_inst *inst,
@@ -395,6 +397,7 @@ static void vdec_h264_slice_get_crop_info(struct vdec_h264_slice_inst *inst,
 
 static int vdec_h264_slice_init(struct mtk_vcodec_ctx *ctx)
 {
+	struct device *dev = &ctx->dev->plat_dev->dev;
 	struct vdec_h264_slice_inst *inst;
 	int err, vsi_size;
 
@@ -423,6 +426,16 @@ static int vdec_h264_slice_init(struct mtk_vcodec_ctx *ctx)
 	inst->resolution_changed = true;
 	inst->realloc_mv_buf = true;
 
+	/* Need to add pending data at the end of bitstream when bs_sz is small than
+	 * 20 bytes for cavlc bitstream, or lat will decode fail. This pending data is
+	 * useful for mt8192 and mt8195 platform.
+	 *
+	 * cavlc bitstream when entropy_coding_mode_flag is false.
+	 */
+	if (of_device_is_compatible(dev->of_node, "mediatek,mt8192-vcodec-dec") ||
+	    of_device_is_compatible(dev->of_node, "mediatek,mt8195-vcodec-dec"))
+		inst->is_need_pending_data = true;
+
 	mtk_vcodec_debug(inst, "lat struct size = %d,%d,%d,%d vsi: %d\n",
 			 (int)sizeof(struct mtk_h264_sps_param),
 			 (int)sizeof(struct mtk_h264_pps_param),
@@ -545,6 +558,19 @@ static int vdec_h264_slice_core_decode(struct vdec_lat_buf *lat_buf)
 	return 0;
 }
 
+static void vdec_h264_insert_startcode(struct vdec_h264_slice_inst *inst, unsigned char *buf,
+				       size_t *bs_size, struct mtk_h264_pps_param *pps)
+{
+	if (!inst->is_need_pending_data || pps->entropy_coding_mode_flag || *bs_size > 20)
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
@@ -588,9 +614,6 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	}
 
 	inst->vsi->dec.nal_info = buf[nal_start_idx];
-	inst->vsi->dec.bs_buf_addr = (u64)bs->dma_addr;
-	inst->vsi->dec.bs_buf_size = bs->size;
-
 	lat_buf->src_buf_req = src_buf_info->m2m_buf.vb.vb2_buf.req_obj.req;
 	v4l2_m2m_buf_copy_metadata(&src_buf_info->m2m_buf.vb, &lat_buf->ts_info, true);
 
@@ -598,6 +621,10 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	if (err)
 		goto err_free_fb_out;
 
+	vdec_h264_insert_startcode(inst, buf, &bs->size, &share_info->h264_slice_params.pps);
+	inst->vsi->dec.bs_buf_addr = (uint64_t)bs->dma_addr;
+	inst->vsi->dec.bs_buf_size = bs->size;
+
 	*res_chg = inst->resolution_changed;
 	if (inst->resolution_changed) {
 		mtk_vcodec_debug(inst, "- resolution changed -");
-- 
2.18.0

