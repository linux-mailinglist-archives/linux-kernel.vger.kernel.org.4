Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9092B668E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240847AbjAMG5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240858AbjAMG4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:56:07 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE80471FC5;
        Thu, 12 Jan 2023 22:41:15 -0800 (PST)
X-UUID: 427bdc80930d11eda06fc9ecc4dadd91-20230113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NbPBO3XofCZnvE8MJ00/ODH8w117f7m9bV8bhNWeOD8=;
        b=aTrAa+uVOc16KcJLFXcR6qhGlww3DNdXZHY0jaqHiWJHnZ0+pVeRg4rcs/A1HfU8vA9ZQ3FqzlUoJ5KZyip34fR7NARG3VG4kQlo7+m9SfoOsPCsNU1JgQvWMd8mI0uNR3NBoDQEDpCjOPhAed2J2wye4TLEpL629paSLyQgnxs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:bf605422-778d-4a8f-815f-a9abc7867dcb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.17,REQID:bf605422-778d-4a8f-815f-a9abc7867dcb,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:543e81c,CLOUDID:1b1b8c54-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230113144110F21JYNHE,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:1,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0,NGT
X-UUID: 427bdc80930d11eda06fc9ecc4dadd91-20230113
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 976527856; Fri, 13 Jan 2023 14:41:07 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 13 Jan 2023 14:41:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 13 Jan 2023 14:41:06 +0800
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
Subject: [PATCH v5 08/12] media: platform: mtk-mdp3: extend mdp_color format for compressed mode
Date:   Fri, 13 Jan 2023 14:41:00 +0800
Message-ID: <20230113064104.22402-9-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230113064104.22402-1-moudy.ho@mediatek.com>
References: <20230113064104.22402-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to future support for hardware compression formats, the MDP3
internal color format expression needs to be extended.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mtk-mdp3-regs.h    | 205 +++++++++---------
 1 file changed, 103 insertions(+), 102 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h
index 8e91bcb094e0..e9ab8ac2c0e8 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h
@@ -18,11 +18,12 @@
  * V-subsample: 0, 1
  * Color group: 0-RGB, 1-YUV, 2-raw
  */
-#define MDP_COLOR(PACKED, LOOSE, VIDEO, PLANE, HF, VF, BITS, GROUP, SWAP, ID)\
-	(((PACKED) << 27) | ((LOOSE) << 26) | ((VIDEO) << 23) |\
+#define MDP_COLOR(COMPRESS, PACKED, LOOSE, VIDEO, PLANE, HF, VF, BITS, GROUP, SWAP, ID)\
+	(((COMPRESS) << 29) | ((PACKED) << 27) | ((LOOSE) << 26) | ((VIDEO) << 23) |\
 	 ((PLANE) << 21) | ((HF) << 19) | ((VF) << 18) | ((BITS) << 8) |\
 	 ((GROUP) << 6) | ((SWAP) << 5) | ((ID) << 0))
 
+#define MDP_COLOR_IS_COMPRESS(c)        ((0x20000000 & (c)) >> 29)
 #define MDP_COLOR_IS_10BIT_PACKED(c)	((0x08000000 & (c)) >> 27)
 #define MDP_COLOR_IS_10BIT_LOOSE(c)	(((0x0c000000 & (c)) >> 26) == 1)
 #define MDP_COLOR_IS_10BIT_TILE(c)	(((0x0c000000 & (c)) >> 26) == 3)
@@ -44,144 +45,144 @@
 enum mdp_color {
 	MDP_COLOR_UNKNOWN	= 0,
 
-	//MDP_COLOR_FULLG8,
-	MDP_COLOR_FULLG8_RGGB	= MDP_COLOR(0, 0, 0, 1, 0, 0,  8, 2,  0, 21),
-	MDP_COLOR_FULLG8_GRBG	= MDP_COLOR(0, 0, 0, 1, 0, 1,  8, 2,  0, 21),
-	MDP_COLOR_FULLG8_GBRG	= MDP_COLOR(0, 0, 0, 1, 1, 0,  8, 2,  0, 21),
-	MDP_COLOR_FULLG8_BGGR	= MDP_COLOR(0, 0, 0, 1, 1, 1,  8, 2,  0, 21),
+	/* MDP_COLOR_FULLG8 */
+	MDP_COLOR_FULLG8_RGGB	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0,  8, 2,  0, 21),
+	MDP_COLOR_FULLG8_GRBG	= MDP_COLOR(0, 0, 0, 0, 1, 0, 1,  8, 2,  0, 21),
+	MDP_COLOR_FULLG8_GBRG	= MDP_COLOR(0, 0, 0, 0, 1, 1, 0,  8, 2,  0, 21),
+	MDP_COLOR_FULLG8_BGGR	= MDP_COLOR(0, 0, 0, 0, 1, 1, 1,  8, 2,  0, 21),
 	MDP_COLOR_FULLG8	= MDP_COLOR_FULLG8_BGGR,
 
-	//MDP_COLOR_FULLG10,
-	MDP_COLOR_FULLG10_RGGB	= MDP_COLOR(0, 0, 0, 1, 0, 0, 10, 2,  0, 21),
-	MDP_COLOR_FULLG10_GRBG	= MDP_COLOR(0, 0, 0, 1, 0, 1, 10, 2,  0, 21),
-	MDP_COLOR_FULLG10_GBRG	= MDP_COLOR(0, 0, 0, 1, 1, 0, 10, 2,  0, 21),
-	MDP_COLOR_FULLG10_BGGR	= MDP_COLOR(0, 0, 0, 1, 1, 1, 10, 2,  0, 21),
+	/* MDP_COLOR_FULLG10 */
+	MDP_COLOR_FULLG10_RGGB	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 10, 2,  0, 21),
+	MDP_COLOR_FULLG10_GRBG	= MDP_COLOR(0, 0, 0, 0, 1, 0, 1, 10, 2,  0, 21),
+	MDP_COLOR_FULLG10_GBRG	= MDP_COLOR(0, 0, 0, 0, 1, 1, 0, 10, 2,  0, 21),
+	MDP_COLOR_FULLG10_BGGR	= MDP_COLOR(0, 0, 0, 0, 1, 1, 1, 10, 2,  0, 21),
 	MDP_COLOR_FULLG10	= MDP_COLOR_FULLG10_BGGR,
 
-	//MDP_COLOR_FULLG12,
-	MDP_COLOR_FULLG12_RGGB	= MDP_COLOR(0, 0, 0, 1, 0, 0, 12, 2,  0, 21),
-	MDP_COLOR_FULLG12_GRBG	= MDP_COLOR(0, 0, 0, 1, 0, 1, 12, 2,  0, 21),
-	MDP_COLOR_FULLG12_GBRG	= MDP_COLOR(0, 0, 0, 1, 1, 0, 12, 2,  0, 21),
-	MDP_COLOR_FULLG12_BGGR	= MDP_COLOR(0, 0, 0, 1, 1, 1, 12, 2,  0, 21),
+	/* MDP_COLOR_FULLG12 */
+	MDP_COLOR_FULLG12_RGGB	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 12, 2,  0, 21),
+	MDP_COLOR_FULLG12_GRBG	= MDP_COLOR(0, 0, 0, 0, 1, 0, 1, 12, 2,  0, 21),
+	MDP_COLOR_FULLG12_GBRG	= MDP_COLOR(0, 0, 0, 0, 1, 1, 0, 12, 2,  0, 21),
+	MDP_COLOR_FULLG12_BGGR	= MDP_COLOR(0, 0, 0, 0, 1, 1, 1, 12, 2,  0, 21),
 	MDP_COLOR_FULLG12	= MDP_COLOR_FULLG12_BGGR,
 
-	//MDP_COLOR_FULLG14,
-	MDP_COLOR_FULLG14_RGGB	= MDP_COLOR(0, 0, 0, 1, 0, 0, 14, 2,  0, 21),
-	MDP_COLOR_FULLG14_GRBG	= MDP_COLOR(0, 0, 0, 1, 0, 1, 14, 2,  0, 21),
-	MDP_COLOR_FULLG14_GBRG	= MDP_COLOR(0, 0, 0, 1, 1, 0, 14, 2,  0, 21),
-	MDP_COLOR_FULLG14_BGGR	= MDP_COLOR(0, 0, 0, 1, 1, 1, 14, 2,  0, 21),
+	/* MDP_COLOR_FULLG14 */
+	MDP_COLOR_FULLG14_RGGB	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 14, 2,  0, 21),
+	MDP_COLOR_FULLG14_GRBG	= MDP_COLOR(0, 0, 0, 0, 1, 0, 1, 14, 2,  0, 21),
+	MDP_COLOR_FULLG14_GBRG	= MDP_COLOR(0, 0, 0, 0, 1, 1, 0, 14, 2,  0, 21),
+	MDP_COLOR_FULLG14_BGGR	= MDP_COLOR(0, 0, 0, 0, 1, 1, 1, 14, 2,  0, 21),
 	MDP_COLOR_FULLG14	= MDP_COLOR_FULLG14_BGGR,
 
-	MDP_COLOR_UFO10		= MDP_COLOR(0, 0, 0, 1, 0, 0, 10, 2,  0, 24),
+	MDP_COLOR_UFO10		= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 10, 2,  0, 24),
 
-	//MDP_COLOR_BAYER8,
-	MDP_COLOR_BAYER8_RGGB	= MDP_COLOR(0, 0, 0, 1, 0, 0,  8, 2,  0, 20),
-	MDP_COLOR_BAYER8_GRBG	= MDP_COLOR(0, 0, 0, 1, 0, 1,  8, 2,  0, 20),
-	MDP_COLOR_BAYER8_GBRG	= MDP_COLOR(0, 0, 0, 1, 1, 0,  8, 2,  0, 20),
-	MDP_COLOR_BAYER8_BGGR	= MDP_COLOR(0, 0, 0, 1, 1, 1,  8, 2,  0, 20),
+	/* MDP_COLOR_BAYER8 */
+	MDP_COLOR_BAYER8_RGGB	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0,  8, 2,  0, 20),
+	MDP_COLOR_BAYER8_GRBG	= MDP_COLOR(0, 0, 0, 0, 1, 0, 1,  8, 2,  0, 20),
+	MDP_COLOR_BAYER8_GBRG	= MDP_COLOR(0, 0, 0, 0, 1, 1, 0,  8, 2,  0, 20),
+	MDP_COLOR_BAYER8_BGGR	= MDP_COLOR(0, 0, 0, 0, 1, 1, 1,  8, 2,  0, 20),
 	MDP_COLOR_BAYER8	= MDP_COLOR_BAYER8_BGGR,
 
-	//MDP_COLOR_BAYER10,
-	MDP_COLOR_BAYER10_RGGB	= MDP_COLOR(0, 0, 0, 1, 0, 0, 10, 2,  0, 20),
-	MDP_COLOR_BAYER10_GRBG	= MDP_COLOR(0, 0, 0, 1, 0, 1, 10, 2,  0, 20),
-	MDP_COLOR_BAYER10_GBRG	= MDP_COLOR(0, 0, 0, 1, 1, 0, 10, 2,  0, 20),
-	MDP_COLOR_BAYER10_BGGR	= MDP_COLOR(0, 0, 0, 1, 1, 1, 10, 2,  0, 20),
+	/* MDP_COLOR_BAYER10 */
+	MDP_COLOR_BAYER10_RGGB	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 10, 2,  0, 20),
+	MDP_COLOR_BAYER10_GRBG	= MDP_COLOR(0, 0, 0, 0, 1, 0, 1, 10, 2,  0, 20),
+	MDP_COLOR_BAYER10_GBRG	= MDP_COLOR(0, 0, 0, 0, 1, 1, 0, 10, 2,  0, 20),
+	MDP_COLOR_BAYER10_BGGR	= MDP_COLOR(0, 0, 0, 0, 1, 1, 1, 10, 2,  0, 20),
 	MDP_COLOR_BAYER10	= MDP_COLOR_BAYER10_BGGR,
 
-	//MDP_COLOR_BAYER12,
-	MDP_COLOR_BAYER12_RGGB	= MDP_COLOR(0, 0, 0, 1, 0, 0, 12, 2,  0, 20),
-	MDP_COLOR_BAYER12_GRBG	= MDP_COLOR(0, 0, 0, 1, 0, 1, 12, 2,  0, 20),
-	MDP_COLOR_BAYER12_GBRG	= MDP_COLOR(0, 0, 0, 1, 1, 0, 12, 2,  0, 20),
-	MDP_COLOR_BAYER12_BGGR	= MDP_COLOR(0, 0, 0, 1, 1, 1, 12, 2,  0, 20),
+	/* MDP_COLOR_BAYER12 */
+	MDP_COLOR_BAYER12_RGGB	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 12, 2,  0, 20),
+	MDP_COLOR_BAYER12_GRBG	= MDP_COLOR(0, 0, 0, 0, 1, 0, 1, 12, 2,  0, 20),
+	MDP_COLOR_BAYER12_GBRG	= MDP_COLOR(0, 0, 0, 0, 1, 1, 0, 12, 2,  0, 20),
+	MDP_COLOR_BAYER12_BGGR	= MDP_COLOR(0, 0, 0, 0, 1, 1, 1, 12, 2,  0, 20),
 	MDP_COLOR_BAYER12	= MDP_COLOR_BAYER12_BGGR,
 
-	//MDP_COLOR_BAYER14,
-	MDP_COLOR_BAYER14_RGGB	= MDP_COLOR(0, 0, 0, 1, 0, 0, 14, 2,  0, 20),
-	MDP_COLOR_BAYER14_GRBG	= MDP_COLOR(0, 0, 0, 1, 0, 1, 14, 2,  0, 20),
-	MDP_COLOR_BAYER14_GBRG	= MDP_COLOR(0, 0, 0, 1, 1, 0, 14, 2,  0, 20),
-	MDP_COLOR_BAYER14_BGGR	= MDP_COLOR(0, 0, 0, 1, 1, 1, 14, 2,  0, 20),
+	/* MDP_COLOR_BAYER14 */
+	MDP_COLOR_BAYER14_RGGB	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 14, 2,  0, 20),
+	MDP_COLOR_BAYER14_GRBG	= MDP_COLOR(0, 0, 0, 0, 1, 0, 1, 14, 2,  0, 20),
+	MDP_COLOR_BAYER14_GBRG	= MDP_COLOR(0, 0, 0, 0, 1, 1, 0, 14, 2,  0, 20),
+	MDP_COLOR_BAYER14_BGGR	= MDP_COLOR(0, 0, 0, 0, 1, 1, 1, 14, 2,  0, 20),
 	MDP_COLOR_BAYER14	= MDP_COLOR_BAYER14_BGGR,
 
-	MDP_COLOR_RGB48		= MDP_COLOR(0, 0, 0, 1, 0, 0, 48, 0,  0, 23),
+	MDP_COLOR_RGB48		= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 48, 0,  0, 23),
 	/* For bayer+mono raw-16 */
-	MDP_COLOR_RGB565_RAW	= MDP_COLOR(0, 0, 0, 1, 0, 0, 16, 2,  0, 0),
+	MDP_COLOR_RGB565_RAW	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 16, 2,  0, 0),
 
-	MDP_COLOR_BAYER8_UNPAK	= MDP_COLOR(0, 0, 0, 1, 0, 0,  8, 2,  0, 22),
-	MDP_COLOR_BAYER10_UNPAK	= MDP_COLOR(0, 0, 0, 1, 0, 0, 10, 2,  0, 22),
-	MDP_COLOR_BAYER12_UNPAK	= MDP_COLOR(0, 0, 0, 1, 0, 0, 12, 2,  0, 22),
-	MDP_COLOR_BAYER14_UNPAK	= MDP_COLOR(0, 0, 0, 1, 0, 0, 14, 2,  0, 22),
+	MDP_COLOR_BAYER8_UNPAK	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0,  8, 2,  0, 22),
+	MDP_COLOR_BAYER10_UNPAK	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 10, 2,  0, 22),
+	MDP_COLOR_BAYER12_UNPAK	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 12, 2,  0, 22),
+	MDP_COLOR_BAYER14_UNPAK	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 14, 2,  0, 22),
 
 	/* Unified formats */
-	MDP_COLOR_GREY		= MDP_COLOR(0, 0, 0, 1, 0, 0,  8, 1,  0, 7),
-
-	MDP_COLOR_RGB565	= MDP_COLOR(0, 0, 0, 1, 0, 0, 16, 0,  0, 0),
-	MDP_COLOR_BGR565	= MDP_COLOR(0, 0, 0, 1, 0, 0, 16, 0,  1, 0),
-	MDP_COLOR_RGB888	= MDP_COLOR(0, 0, 0, 1, 0, 0, 24, 0,  1, 1),
-	MDP_COLOR_BGR888	= MDP_COLOR(0, 0, 0, 1, 0, 0, 24, 0,  0, 1),
-	MDP_COLOR_RGBA8888	= MDP_COLOR(0, 0, 0, 1, 0, 0, 32, 0,  1, 2),
-	MDP_COLOR_BGRA8888	= MDP_COLOR(0, 0, 0, 1, 0, 0, 32, 0,  0, 2),
-	MDP_COLOR_ARGB8888	= MDP_COLOR(0, 0, 0, 1, 0, 0, 32, 0,  1, 3),
-	MDP_COLOR_ABGR8888	= MDP_COLOR(0, 0, 0, 1, 0, 0, 32, 0,  0, 3),
-
-	MDP_COLOR_UYVY		= MDP_COLOR(0, 0, 0, 1, 1, 0, 16, 1,  0, 4),
-	MDP_COLOR_VYUY		= MDP_COLOR(0, 0, 0, 1, 1, 0, 16, 1,  1, 4),
-	MDP_COLOR_YUYV		= MDP_COLOR(0, 0, 0, 1, 1, 0, 16, 1,  0, 5),
-	MDP_COLOR_YVYU		= MDP_COLOR(0, 0, 0, 1, 1, 0, 16, 1,  1, 5),
-
-	MDP_COLOR_I420		= MDP_COLOR(0, 0, 0, 3, 1, 1,  8, 1,  0, 8),
-	MDP_COLOR_YV12		= MDP_COLOR(0, 0, 0, 3, 1, 1,  8, 1,  1, 8),
-	MDP_COLOR_I422		= MDP_COLOR(0, 0, 0, 3, 1, 0,  8, 1,  0, 9),
-	MDP_COLOR_YV16		= MDP_COLOR(0, 0, 0, 3, 1, 0,  8, 1,  1, 9),
-	MDP_COLOR_I444		= MDP_COLOR(0, 0, 0, 3, 0, 0,  8, 1,  0, 10),
-	MDP_COLOR_YV24		= MDP_COLOR(0, 0, 0, 3, 0, 0,  8, 1,  1, 10),
-
-	MDP_COLOR_NV12		= MDP_COLOR(0, 0, 0, 2, 1, 1,  8, 1,  0, 12),
-	MDP_COLOR_NV21		= MDP_COLOR(0, 0, 0, 2, 1, 1,  8, 1,  1, 12),
-	MDP_COLOR_NV16		= MDP_COLOR(0, 0, 0, 2, 1, 0,  8, 1,  0, 13),
-	MDP_COLOR_NV61		= MDP_COLOR(0, 0, 0, 2, 1, 0,  8, 1,  1, 13),
-	MDP_COLOR_NV24		= MDP_COLOR(0, 0, 0, 2, 0, 0,  8, 1,  0, 14),
-	MDP_COLOR_NV42		= MDP_COLOR(0, 0, 0, 2, 0, 0,  8, 1,  1, 14),
+	MDP_COLOR_GREY		= MDP_COLOR(0, 0, 0, 0, 1, 0, 0,  8, 1,  0, 7),
+
+	MDP_COLOR_RGB565	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 16, 0,  0, 0),
+	MDP_COLOR_BGR565	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 16, 0,  1, 0),
+	MDP_COLOR_RGB888	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 24, 0,  1, 1),
+	MDP_COLOR_BGR888	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 24, 0,  0, 1),
+	MDP_COLOR_RGBA8888	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 32, 0,  1, 2),
+	MDP_COLOR_BGRA8888	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 32, 0,  0, 2),
+	MDP_COLOR_ARGB8888	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 32, 0,  1, 3),
+	MDP_COLOR_ABGR8888	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 32, 0,  0, 3),
+
+	MDP_COLOR_UYVY		= MDP_COLOR(0, 0, 0, 0, 1, 1, 0, 16, 1,  0, 4),
+	MDP_COLOR_VYUY		= MDP_COLOR(0, 0, 0, 0, 1, 1, 0, 16, 1,  1, 4),
+	MDP_COLOR_YUYV		= MDP_COLOR(0, 0, 0, 0, 1, 1, 0, 16, 1,  0, 5),
+	MDP_COLOR_YVYU		= MDP_COLOR(0, 0, 0, 0, 1, 1, 0, 16, 1,  1, 5),
+
+	MDP_COLOR_I420		= MDP_COLOR(0, 0, 0, 0, 3, 1, 1,  8, 1,  0, 8),
+	MDP_COLOR_YV12		= MDP_COLOR(0, 0, 0, 0, 3, 1, 1,  8, 1,  1, 8),
+	MDP_COLOR_I422		= MDP_COLOR(0, 0, 0, 0, 3, 1, 0,  8, 1,  0, 9),
+	MDP_COLOR_YV16		= MDP_COLOR(0, 0, 0, 0, 3, 1, 0,  8, 1,  1, 9),
+	MDP_COLOR_I444		= MDP_COLOR(0, 0, 0, 0, 3, 0, 0,  8, 1,  0, 10),
+	MDP_COLOR_YV24		= MDP_COLOR(0, 0, 0, 0, 3, 0, 0,  8, 1,  1, 10),
+
+	MDP_COLOR_NV12		= MDP_COLOR(0, 0, 0, 0, 2, 1, 1,  8, 1,  0, 12),
+	MDP_COLOR_NV21		= MDP_COLOR(0, 0, 0, 0, 2, 1, 1,  8, 1,  1, 12),
+	MDP_COLOR_NV16		= MDP_COLOR(0, 0, 0, 0, 2, 1, 0,  8, 1,  0, 13),
+	MDP_COLOR_NV61		= MDP_COLOR(0, 0, 0, 0, 2, 1, 0,  8, 1,  1, 13),
+	MDP_COLOR_NV24		= MDP_COLOR(0, 0, 0, 0, 2, 0, 0,  8, 1,  0, 14),
+	MDP_COLOR_NV42		= MDP_COLOR(0, 0, 0, 0, 2, 0, 0,  8, 1,  1, 14),
 
 	/* MediaTek proprietary formats */
 	/* UFO encoded block mode */
-	MDP_COLOR_420_BLK_UFO	= MDP_COLOR(0, 0, 5, 2, 1, 1, 256, 1, 0, 12),
+	MDP_COLOR_420_BLK_UFO	= MDP_COLOR(0, 0, 0, 5, 2, 1, 1, 256, 1, 0, 12),
 	/* Block mode */
-	MDP_COLOR_420_BLK	= MDP_COLOR(0, 0, 1, 2, 1, 1, 256, 1, 0, 12),
+	MDP_COLOR_420_BLK	= MDP_COLOR(0, 0, 0, 1, 2, 1, 1, 256, 1, 0, 12),
 	/* Block mode + field mode */
-	MDP_COLOR_420_BLKI	= MDP_COLOR(0, 0, 3, 2, 1, 1, 256, 1, 0, 12),
+	MDP_COLOR_420_BLKI	= MDP_COLOR(0, 0, 0, 3, 2, 1, 1, 256, 1, 0, 12),
 	/* Block mode */
-	MDP_COLOR_422_BLK	= MDP_COLOR(0, 0, 1, 1, 1, 0, 512, 1, 0, 4),
+	MDP_COLOR_422_BLK	= MDP_COLOR(0, 0, 0, 1, 1, 1, 0, 512, 1, 0, 4),
 
-	MDP_COLOR_IYU2		= MDP_COLOR(0, 0, 0, 1, 0, 0, 24,  1, 0, 25),
-	MDP_COLOR_YUV444	= MDP_COLOR(0, 0, 0, 1, 0, 0, 24,  1, 0, 30),
+	MDP_COLOR_IYU2		= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 24,  1, 0, 25),
+	MDP_COLOR_YUV444	= MDP_COLOR(0, 0, 0, 0, 1, 0, 0, 24,  1, 0, 30),
 
 	/* Packed 10-bit formats */
-	MDP_COLOR_RGBA1010102	= MDP_COLOR(1, 0, 0, 1, 0, 0, 32,  0, 1, 2),
-	MDP_COLOR_BGRA1010102	= MDP_COLOR(1, 0, 0, 1, 0, 0, 32,  0, 0, 2),
+	MDP_COLOR_RGBA1010102	= MDP_COLOR(0, 1, 0, 0, 1, 0, 0, 32,  0, 1, 2),
+	MDP_COLOR_BGRA1010102	= MDP_COLOR(0, 1, 0, 0, 1, 0, 0, 32,  0, 0, 2),
 	/* Packed 10-bit UYVY */
-	MDP_COLOR_UYVY_10P	= MDP_COLOR(1, 0, 0, 1, 1, 0, 20,  1, 0, 4),
+	MDP_COLOR_UYVY_10P	= MDP_COLOR(0, 1, 0, 0, 1, 1, 0, 20,  1, 0, 4),
 	/* Packed 10-bit NV21 */
-	MDP_COLOR_NV21_10P	= MDP_COLOR(1, 0, 0, 2, 1, 1, 10,  1, 1, 12),
+	MDP_COLOR_NV21_10P	= MDP_COLOR(0, 1, 0, 0, 2, 1, 1, 10,  1, 1, 12),
 	/* 10-bit block mode */
-	MDP_COLOR_420_BLK_10_H	= MDP_COLOR(1, 0, 1, 2, 1, 1, 320, 1, 0, 12),
+	MDP_COLOR_420_BLK_10_H	= MDP_COLOR(0, 1, 0, 1, 2, 1, 1, 320, 1, 0, 12),
 	/* 10-bit HEVC tile mode */
-	MDP_COLOR_420_BLK_10_V	= MDP_COLOR(1, 1, 1, 2, 1, 1, 320, 1, 0, 12),
+	MDP_COLOR_420_BLK_10_V	= MDP_COLOR(0, 1, 1, 1, 2, 1, 1, 320, 1, 0, 12),
 	/* UFO encoded 10-bit block mode */
-	MDP_COLOR_420_BLK_U10_H	= MDP_COLOR(1, 0, 5, 2, 1, 1, 320, 1, 0, 12),
+	MDP_COLOR_420_BLK_U10_H	= MDP_COLOR(0, 1, 0, 5, 2, 1, 1, 320, 1, 0, 12),
 	/* UFO encoded 10-bit HEVC tile mode */
-	MDP_COLOR_420_BLK_U10_V	= MDP_COLOR(1, 1, 5, 2, 1, 1, 320, 1, 0, 12),
+	MDP_COLOR_420_BLK_U10_V	= MDP_COLOR(0, 1, 1, 5, 2, 1, 1, 320, 1, 0, 12),
 
 	/* Loose 10-bit formats */
-	MDP_COLOR_UYVY_10L	= MDP_COLOR(0, 1, 0, 1, 1, 0, 20,  1, 0, 4),
-	MDP_COLOR_VYUY_10L	= MDP_COLOR(0, 1, 0, 1, 1, 0, 20,  1, 1, 4),
-	MDP_COLOR_YUYV_10L	= MDP_COLOR(0, 1, 0, 1, 1, 0, 20,  1, 0, 5),
-	MDP_COLOR_YVYU_10L	= MDP_COLOR(0, 1, 0, 1, 1, 0, 20,  1, 1, 5),
-	MDP_COLOR_NV12_10L	= MDP_COLOR(0, 1, 0, 2, 1, 1, 10,  1, 0, 12),
-	MDP_COLOR_NV21_10L	= MDP_COLOR(0, 1, 0, 2, 1, 1, 10,  1, 1, 12),
-	MDP_COLOR_NV16_10L	= MDP_COLOR(0, 1, 0, 2, 1, 0, 10,  1, 0, 13),
-	MDP_COLOR_NV61_10L	= MDP_COLOR(0, 1, 0, 2, 1, 0, 10,  1, 1, 13),
-	MDP_COLOR_YV12_10L	= MDP_COLOR(0, 1, 0, 3, 1, 1, 10,  1, 1, 8),
-	MDP_COLOR_I420_10L	= MDP_COLOR(0, 1, 0, 3, 1, 1, 10,  1, 0, 8),
+	MDP_COLOR_UYVY_10L	= MDP_COLOR(0, 0, 1, 0, 1, 1, 0, 20,  1, 0, 4),
+	MDP_COLOR_VYUY_10L	= MDP_COLOR(0, 0, 1, 0, 1, 1, 0, 20,  1, 1, 4),
+	MDP_COLOR_YUYV_10L	= MDP_COLOR(0, 0, 1, 0, 1, 1, 0, 20,  1, 0, 5),
+	MDP_COLOR_YVYU_10L	= MDP_COLOR(0, 0, 1, 0, 1, 1, 0, 20,  1, 1, 5),
+	MDP_COLOR_NV12_10L	= MDP_COLOR(0, 0, 1, 0, 2, 1, 1, 10,  1, 0, 12),
+	MDP_COLOR_NV21_10L	= MDP_COLOR(0, 0, 1, 0, 2, 1, 1, 10,  1, 1, 12),
+	MDP_COLOR_NV16_10L	= MDP_COLOR(0, 0, 1, 0, 2, 1, 0, 10,  1, 0, 13),
+	MDP_COLOR_NV61_10L	= MDP_COLOR(0, 0, 1, 0, 2, 1, 0, 10,  1, 1, 13),
+	MDP_COLOR_YV12_10L	= MDP_COLOR(0, 0, 1, 0, 3, 1, 1, 10,  1, 1, 8),
+	MDP_COLOR_I420_10L	= MDP_COLOR(0, 0, 1, 0, 3, 1, 1, 10,  1, 0, 8),
 };
 
 static inline bool MDP_COLOR_IS_UV_COPLANE(enum mdp_color c)
-- 
2.18.0

