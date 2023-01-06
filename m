Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBF065FBF3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 08:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjAFHaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 02:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjAFHaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 02:30:00 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F9D6F943;
        Thu,  5 Jan 2023 23:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1672990199; x=1704526199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DffC9CPOpTvTI4x91/PB9XTl2Oj+dLxT5MUVwREgeSs=;
  b=B20JRYT8GB2SSwUINvmP3dLitHDPovckdxTgJQUiw5b9vPqrk2HfOdvw
   VYCVHTnTbO4k3+gTj+8BAwIrdj0lkKB3XVZ1D+QKFZRxL8yLeHSDWvj1r
   VBALeGbwkENlsz/De9OjPCeMzRBMiqJ06EG7f3kPHsvrcRzvw0S7kmdyy
   qszvEy8P7CbiqN4ZWXCQtv7EK7jhtHb/cGgnfaW8MpTyhGbBYpNgAEIne
   8+eExpcH7uAMkflyFL0fQylsW3zxsknd4ERRFY5BbhcxkWNju+nU2XqVc
   KwBZsu6D9xj5RismjYyL+VidWDBa59uDvof1Txl1QEDz6QGI9WfUQyn3d
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="206640385"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jan 2023 00:29:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 00:29:58 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 6 Jan 2023 00:29:56 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "shravan kumar" <shravan.chippa@microchip.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v8 4/4] media: i2c: imx334: update pixel and link frequency
Date:   Fri, 6 Jan 2023 12:59:31 +0530
Message-ID: <20230106072931.2317597-5-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106072931.2317597-1-shravan.chippa@microchip.com>
References: <20230106072931.2317597-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

Update pixel_rate and link frequency for 1920x1080@30
while changing mode.

Add dummy ctrl cases for pixel_rate and link frequency
to avoid error while changing the modes dynamically

Suggested-by: Sakari Ailus <sakari.ailus@iki.fi>
Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 drivers/media/i2c/imx334.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
index 0315e1c9541d..8c3ba660abae 100644
--- a/drivers/media/i2c/imx334.c
+++ b/drivers/media/i2c/imx334.c
@@ -50,6 +50,7 @@
 
 /* CSI2 HW configuration */
 #define IMX334_LINK_FREQ	891000000
+#define IMX334_LINK_FREQ_445M	445500000
 #define IMX334_NUM_DATA_LANES	4
 
 #define IMX334_REG_MIN		0x00
@@ -145,6 +146,7 @@ struct imx334 {
 
 static const s64 link_freq[] = {
 	IMX334_LINK_FREQ,
+	IMX334_LINK_FREQ_445M,
 };
 
 /* Sensor mode registers */
@@ -468,7 +470,7 @@ static const struct imx334_mode supported_modes[] = {
 		.vblank_min = 90,
 		.vblank_max = 132840,
 		.pclk = 74250000,
-		.link_freq_idx = 0,
+		.link_freq_idx = 1,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_1920x1080_regs),
 			.regs = mode_1920x1080_regs,
@@ -598,6 +600,11 @@ static int imx334_update_controls(struct imx334 *imx334,
 	if (ret)
 		return ret;
 
+	ret = __v4l2_ctrl_modify_range(imx334->pclk_ctrl, mode->pclk,
+				       mode->pclk, 1, mode->pclk);
+	if (ret)
+		return ret;
+
 	ret = __v4l2_ctrl_modify_range(imx334->hblank_ctrl, mode->hblank,
 				       mode->hblank, 1, mode->hblank);
 	if (ret)
@@ -698,6 +705,8 @@ static int imx334_set_ctrl(struct v4l2_ctrl *ctrl)
 		pm_runtime_put(imx334->dev);
 
 		break;
+	case V4L2_CID_PIXEL_RATE:
+	case V4L2_CID_LINK_FREQ:
 	case V4L2_CID_HBLANK:
 		ret = 0;
 		break;
-- 
2.34.1

