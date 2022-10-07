Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B2A5F761F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJGJWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJGJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:22:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E77DDED36;
        Fri,  7 Oct 2022 02:22:36 -0700 (PDT)
X-UUID: def0848e360a41c698660df597356fec-20221007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NrsOOHJKQckev5SMzUy0VhCEQURlG7/SyAHua25KXPY=;
        b=R/4P/+7oWI2hZO2wphliEmgVUXfJh9niBAAX/344tSM9n04BK4x9Dz0UpbjiPUPzhAttRIj53mpE+2KIr1ICTvQAsEqyN+k2DyywDj0J2JtiIbB+cU4vFowZOtJSPt4F1waG1TgmHnftjnwrlt0t+/Yy0QBf2TlNEBQw+Qvb9gI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:5344445b-dd21-474b-960c-1f20d3a55603,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:951cd7b8-daef-48a8-8c50-40026d6a74c2,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: def0848e360a41c698660df597356fec-20221007
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 249068420; Fri, 07 Oct 2022 17:22:32 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 7 Oct 2022 17:22:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 Oct 2022 17:22:31 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v1 2/2] media: platform: mtk-mdp3: extend shared memory structure to 4-byte aligned
Date:   Fri, 7 Oct 2022 17:22:30 +0800
Message-ID: <20221007092230.11893-3-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221007092230.11893-1-moudy.ho@mediatek.com>
References: <20221007092230.11893-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_CSS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The communication between MDP3 kernel driver and SCP is pass through
a shared memory, and the data structure is defined in the "mtk-img-ipi.h".
However, there is a 4-byte read limit in further SCP hardware, so the
data structure should be in 4-byte aligned.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mtk-img-ipi.h      | 76 +++++++++----------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h b/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
index 3e66ebaee2da..c7f231f8ea3e 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
@@ -51,14 +51,14 @@ struct img_sw_addr {
 
 struct img_plane_format {
 	u32 size;
-	u16 stride;
+	u32 stride;
 } __packed;
 
 struct img_pix_format {
-	u16 width;
-	u16 height;
+	u32 width;
+	u32 height;
 	u32 colorformat; /* enum mdp_color */
-	u16 ycbcr_prof; /* enum mdp_ycbcr_profile */
+	u32 ycbcr_prof; /* enum mdp_ycbcr_profile */
 	struct img_plane_format plane_fmt[IMG_MAX_PLANES];
 } __packed;
 
@@ -72,10 +72,10 @@ struct img_image_buffer {
 #define IMG_SUBPIXEL_SHIFT	20
 
 struct img_crop {
-	s16 left;
-	s16 top;
-	u16 width;
-	u16 height;
+	s32 left;
+	s32 top;
+	u32 width;
+	u32 height;
 	u32 left_subpix;
 	u32 top_subpix;
 	u32 width_subpix;
@@ -90,24 +90,24 @@ struct img_crop {
 
 struct img_input {
 	struct img_image_buffer buffer;
-	u16 flags; /* HDR, DRE, dither */
+	u32 flags; /* HDR, DRE, dither */
 } __packed;
 
 struct img_output {
 	struct img_image_buffer buffer;
 	struct img_crop crop;
-	s16 rotation;
-	u16 flags; /* H-flip, sharpness, dither */
+	s32 rotation;
+	u32 flags; /* H-flip, sharpness, dither */
 } __packed;
 
 struct img_ipi_frameparam {
 	u32 index;
 	u32 frame_no;
 	struct img_timeval timestamp;
-	u8 type; /* enum mdp_stream_type */
-	u8 state;
-	u8 num_inputs;
-	u8 num_outputs;
+	u32 type; /* enum mdp_stream_type */
+	u32 state;
+	u32 num_inputs;
+	u32 num_outputs;
 	u64 drv_data;
 	struct img_input inputs[IMG_MAX_HW_INPUTS];
 	struct img_output outputs[IMG_MAX_HW_OUTPUTS];
@@ -123,51 +123,51 @@ struct img_sw_buffer {
 } __packed;
 
 struct img_ipi_param {
-	u8 usage;
+	u32 usage;
 	struct img_sw_buffer frm_param;
 } __packed;
 
 struct img_frameparam {
 	struct list_head list_entry;
 	struct img_ipi_frameparam frameparam;
-};
+} __packed;
 
 /* ISP-MDP generic output information */
 
 struct img_comp_frame {
-	u32 output_disable:1;
-	u32 bypass:1;
-	u16 in_width;
-	u16 in_height;
-	u16 out_width;
-	u16 out_height;
+	u32 output_disable;
+	u32 bypass;
+	u32 in_width;
+	u32 in_height;
+	u32 out_width;
+	u32 out_height;
 	struct img_crop crop;
-	u16 in_total_width;
-	u16 out_total_width;
+	u32 in_total_width;
+	u32 out_total_width;
 } __packed;
 
 struct img_region {
-	s16 left;
-	s16 right;
-	s16 top;
-	s16 bottom;
+	s32 left;
+	s32 right;
+	s32 top;
+	s32 bottom;
 } __packed;
 
 struct img_offset {
-	s16 left;
-	s16 top;
+	s32 left;
+	s32 top;
 	u32 left_subpix;
 	u32 top_subpix;
 } __packed;
 
 struct img_comp_subfrm {
-	u32 tile_disable:1;
+	u32 tile_disable;
 	struct img_region in;
 	struct img_region out;
 	struct img_offset luma;
 	struct img_offset chroma;
-	s16 out_vertical; /* Output vertical index */
-	s16 out_horizontal; /* Output horizontal index */
+	s32 out_vertical; /* Output vertical index */
+	s32 out_horizontal; /* Output horizontal index */
 } __packed;
 
 #define IMG_MAX_SUBFRAMES	14
@@ -250,8 +250,8 @@ struct isp_data {
 } __packed;
 
 struct img_compparam {
-	u16 type; /* enum mdp_comp_type */
-	u16 id; /* enum mtk_mdp_comp_id */
+	u32 type; /* enum mdp_comp_id */
+	u32 id; /* engine alias_id */
 	u32 input;
 	u32 outputs[IMG_MAX_HW_OUTPUTS];
 	u32 num_outputs;
@@ -273,12 +273,12 @@ struct img_mux {
 	u32 reg;
 	u32 value;
 	u32 subsys_id;
-};
+} __packed;
 
 struct img_mmsys_ctrl {
 	struct img_mux sets[IMG_MAX_COMPONENTS * 2];
 	u32 num_sets;
-};
+} __packed;
 
 struct img_config {
 	struct img_compparam components[IMG_MAX_COMPONENTS];
-- 
2.18.0

