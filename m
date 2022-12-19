Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCCD65077D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiLSGQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiLSGP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:15:58 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4387C46;
        Sun, 18 Dec 2022 22:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671430553; x=1702966553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zlh+o5nICLTxuKGUQiTPG7BOp4qsCUFdozUMfdt2II8=;
  b=o5FBQNwu0VPHjzBThp6f4yu6QGyuwz7LgTZeHJ44xNy24Jw9EC8KtgkT
   ddpdzCPJ6xy5Ui/U7TIlFkFnqPwrLiGCoyWUpv002HnciEPrbVZxcQfzM
   La+8sunptnIue+Sul9yTXJUnTcKMmEjyBA7QUxgiF5jP6yEWJzdx1FqFF
   L31E1NCGnnKoRWS+J0FApFRJAXClutsXFtnsrLvbOV4IVgRAktruKpbqJ
   qj2nupCowREcYU7ZBUr0qFwJuM/jyQecoFbcbsbLJqtATFMvYLSkwdO4k
   bXpaeCCF/OKyQr29KcaVj3jeuKSelAsPVrclnPmgxRGk6eNQz9KxXzq8b
   g==;
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="192277833"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Dec 2022 23:15:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 18 Dec 2022 23:15:52 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Sun, 18 Dec 2022 23:15:49 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "shravan kumar" <shravan.chippa@microchip.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v7 5/5] media: i2c: imx334: update pixel and link frequency
Date:   Mon, 19 Dec 2022 11:45:26 +0530
Message-ID: <20221219061526.3169369-6-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219061526.3169369-1-shravan.chippa@microchip.com>
References: <20221219061526.3169369-1-shravan.chippa@microchip.com>
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
index e6c97e5c42d2..4335c73f4d5c 100644
--- a/drivers/media/i2c/imx334.c
+++ b/drivers/media/i2c/imx334.c
@@ -50,6 +50,7 @@
 
 /* CSI2 HW configuration */
 #define IMX334_LINK_FREQ	1782000000
+#define IMX334_LINK_FREQ_891M	891000000
 #define IMX334_NUM_DATA_LANES	4
 
 #define IMX334_REG_MIN		0x00
@@ -145,6 +146,7 @@ struct imx334 {
 
 static const s64 link_freq[] = {
 	IMX334_LINK_FREQ,
+	IMX334_LINK_FREQ_891M,
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

