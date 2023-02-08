Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F3868EA9F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjBHJJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjBHJJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:09:17 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55D145BF1;
        Wed,  8 Feb 2023 01:09:08 -0800 (PST)
X-UUID: 3883ce58a79011eda06fc9ecc4dadd91-20230208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5dmmAN53knGP8A38vOJ+8chP7YSe5P6lPPiDtcUaDnc=;
        b=ackzU80UetfWsnTwPin9CGR6eXZJw1y711GdFysAMpjEIfuL5MHBg4JQAIQ2EdZHnMtj3nzv70EBohKHheVk/P5pu+/w1+nSXeguqRB5szjcp9SCnu5bPH77XDTMdpjvv5Rslny2uifeQR4HS7G79GJH1aqvOiLBP5PNA1RQktw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:913110f6-27e4-4d91-9d35-5e74cb636fa5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:0033d4f7-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 3883ce58a79011eda06fc9ecc4dadd91-20230208
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2101256463; Wed, 08 Feb 2023 17:08:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 8 Feb 2023 17:08:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 8 Feb 2023 17:08:56 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v6 01/12] media: platform: mtk-mdp3: fix potential frame size overflow in mdp_try_fmt_mplane()
Date:   Wed, 8 Feb 2023 17:08:44 +0800
Message-ID: <20230208090855.18934-2-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230208090855.18934-1-moudy.ho@mediatek.com>
References: <20230208090855.18934-1-moudy.ho@mediatek.com>
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

Fix overflow risk when setting certain formats whose frame size exceeds
a RGB24 with 7723x7723 resolution.

For example, a 7723x7724 RGB24 frame:
    1. bpl (byte per line) = 7723 * 3.
    2. Overflow occurs when bpl * 7724 * depth.

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
index 4e84a37ecdfc..36336d169bd9 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
@@ -4,6 +4,7 @@
  * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
  */
 
+#include <linux/math64.h>
 #include <media/v4l2-common.h>
 #include <media/videobuf2-v4l2.h>
 #include <media/videobuf2-dma-contig.h>
@@ -428,14 +429,15 @@ const struct mdp_format *mdp_try_fmt_mplane(struct v4l2_format *f,
 		u32 bpl = pix_mp->plane_fmt[i].bytesperline;
 		u32 min_si, max_si;
 		u32 si = pix_mp->plane_fmt[i].sizeimage;
+		u64 di;
 
 		bpl = clamp(bpl, min_bpl, max_bpl);
 		pix_mp->plane_fmt[i].bytesperline = bpl;
 
-		min_si = (bpl * pix_mp->height * fmt->depth[i]) /
-			 fmt->row_depth[i];
-		max_si = (bpl * s.max_height * fmt->depth[i]) /
-			 fmt->row_depth[i];
+		di = (u64)bpl * pix_mp->height * fmt->depth[i];
+		min_si = (u32)div_u64(di, fmt->row_depth[i]);
+		di = (u64)bpl * s.max_height * fmt->depth[i];
+		max_si = (u32)div_u64(di, fmt->row_depth[i]);
 
 		si = clamp(si, min_si, max_si);
 		pix_mp->plane_fmt[i].sizeimage = si;
-- 
2.18.0

