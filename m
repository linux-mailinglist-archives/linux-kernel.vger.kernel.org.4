Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101386176E8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiKCGtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKCGs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:48:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396B46425;
        Wed,  2 Nov 2022 23:48:52 -0700 (PDT)
X-UUID: d62e288f1cb24bae8e3f0d4e90f5882d-20221103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yWxxd39ttsMQWZBaEK8xPGZhcb++nltg7v/g3I0QV+8=;
        b=S3/BcmSlqF/SKzDhB+PN7RYAISqDyjUIyTLu7kHAoZnjXc42O1ktbGik0drRAl8JMyZT4Pce1KxK9hU5PhCqBvhkkoe3SgiY9Rz569EO0UfUqlQmNTWjJWqnzYeh4WQ4LKUuHgcbgOZsdOKdk8ZMqExLWXnBEMxXDpfP8Lex2Bk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:0c9f434b-7bf7-4858-9f7c-07fda1f1fadf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.12,REQID:0c9f434b-7bf7-4858-9f7c-07fda1f1fadf,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:62cd327,CLOUDID:4dcf7d81-3116-4fbc-b86b-83475c3df513,B
        ulkID:2211031448480GWWYGBR,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d62e288f1cb24bae8e3f0d4e90f5882d-20221103
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1464955748; Thu, 03 Nov 2022 14:48:46 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 3 Nov 2022 14:48:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 3 Nov 2022 14:48:45 +0800
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
Subject: [PATCH v3 08/10] media: platform: mtk-mdp3: extend shared memory structure to 4-byte aligned
Date:   Thu, 3 Nov 2022 14:48:40 +0800
Message-ID: <20221103064842.12042-9-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221103064842.12042-1-moudy.ho@mediatek.com>
References: <20221103064842.12042-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
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

The common header "mtk-img-ipi.h" defines the input frame parameters used to
pass to SCP for components config calculations.

However, there is a 4-byte read limit in further SCP hardware, so the
data structure should be aligned.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mtk-img-ipi.h      | 50 +++++++++----------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h b/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
index 3e66ebaee2da..eabfa538325d 100644
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
@@ -123,14 +123,14 @@ struct img_sw_buffer {
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
 
@@ -147,15 +147,15 @@ struct img_comp_frame {
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

