Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45B16E23D7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjDNM6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNM56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:57:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7032AAF35;
        Fri, 14 Apr 2023 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681477052; x=1713013052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ATUW5+6lA7JEaiWiCALRhiDD0rwS4uvrPrY5ePlmioU=;
  b=BPrcek03O8lal5dPZLJeCpyNRgAXyiriDa24xB0xOZpyRthLxoMJHfQm
   VnxS3W83NTXq5ktbH89B3WZbueLusrQmjGH3scMYQ/JPdEZVuauJ8L6CU
   mVUfiFslaqV3GWw9uutS0EZt9q/aSzaUvzNEx60+I1DYhRgL/3OIwBwtM
   n1xIwbsCyIAlZtotK2tQJZwUNrjZ77kMr8wt5AnIXObeASAgukPJhXHYN
   WoKj1mQEeQh4AO5xHL55Ed/6dJVQ4DsCyu6SE+v7l1jURTOQwxJ0TbjKj
   +WRE9lkpCRSxw501uWRO580Ru4ftn/CpYf3qk/3UUkKBn9ePIbqNiA8op
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,195,1677567600"; 
   d="scan'208";a="209087618"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Apr 2023 05:57:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 14 Apr 2023 05:33:26 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 14 Apr 2023 05:33:22 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>
CC:     <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <shravan.chippa@microchip.com>, Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v13 1/1] media: i2c: imx334: update pixel, hblank and link frequency
Date:   Fri, 14 Apr 2023 18:03:11 +0530
Message-ID: <20230414123311.23923-2-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414123311.23923-1-shravan.chippa@microchip.com>
References: <20230414123311.23923-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

Update pixel_rate and link frequency for 1920x1080@30
while changing mode.

Update vblank value while changing mode

Add support to handle multiple link frequencies.

Add dummy ctrl cases for pixel_rate and link frequency
to avoid error while changing the modes dynamically.

Update default link frequency from device tree max link
frequency value.

Update init_cfg() function to update the link frequency
menu_skip_mask value.

Suggested-by: Sakari Ailus <sakari.ailus@iki.fi>
Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 drivers/media/i2c/imx334.c | 62 +++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
index 309c706114d2..d4c9986aee59 100644
--- a/drivers/media/i2c/imx334.c
+++ b/drivers/media/i2c/imx334.c
@@ -49,7 +49,8 @@
 #define IMX334_INCLK_RATE	24000000
 
 /* CSI2 HW configuration */
-#define IMX334_LINK_FREQ	891000000
+#define IMX334_LINK_FREQ_891M	891000000
+#define IMX334_LINK_FREQ_445M	445500000
 #define IMX334_NUM_DATA_LANES	4
 
 #define IMX334_REG_MIN		0x00
@@ -139,12 +140,14 @@ struct imx334 {
 	u32 vblank;
 	const struct imx334_mode *cur_mode;
 	struct mutex mutex;
+	unsigned long menu_skip_mask;
 	u32 cur_code;
 	bool streaming;
 };
 
 static const s64 link_freq[] = {
-	IMX334_LINK_FREQ,
+	IMX334_LINK_FREQ_891M,
+	IMX334_LINK_FREQ_445M,
 };
 
 /* Sensor mode registers for 1920x1080@30fps */
@@ -468,7 +471,7 @@ static const struct imx334_mode supported_modes[] = {
 		.vblank_min = 45,
 		.vblank_max = 132840,
 		.pclk = 297000000,
-		.link_freq_idx = 0,
+		.link_freq_idx = 1,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_1920x1080_regs),
 			.regs = mode_1920x1080_regs,
@@ -598,13 +601,23 @@ static int imx334_update_controls(struct imx334 *imx334,
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
 		return ret;
 
-	return __v4l2_ctrl_modify_range(imx334->vblank_ctrl, mode->vblank_min,
+
+	ret =  __v4l2_ctrl_modify_range(imx334->vblank_ctrl, mode->vblank_min,
 					mode->vblank_max, 1, mode->vblank);
+	if (ret)
+		return ret;
+
+	return __v4l2_ctrl_s_ctrl(imx334->vblank_ctrl, mode->vblank);
 }
 
 /**
@@ -698,6 +711,8 @@ static int imx334_set_ctrl(struct v4l2_ctrl *ctrl)
 		pm_runtime_put(imx334->dev);
 
 		break;
+	case V4L2_CID_PIXEL_RATE:
+	case V4L2_CID_LINK_FREQ:
 	case V4L2_CID_HBLANK:
 		ret = 0;
 		break;
@@ -885,7 +900,17 @@ static int imx334_init_pad_cfg(struct v4l2_subdev *sd,
 	struct v4l2_subdev_format fmt = { 0 };
 
 	fmt.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE;
-	imx334_fill_pad_format(imx334, &supported_modes[0], &fmt);
+
+	mutex_lock(&imx334->mutex);
+
+	imx334_fill_pad_format(imx334, imx334->cur_mode, &fmt);
+
+	__v4l2_ctrl_modify_range(imx334->link_freq_ctrl, 0,
+				 __fls(imx334->menu_skip_mask),
+				 ~(imx334->menu_skip_mask),
+				 __ffs(imx334->menu_skip_mask));
+
+	mutex_unlock(&imx334->mutex);
 
 	return imx334_set_pad_format(sd, sd_state, &fmt);
 }
@@ -1046,8 +1071,8 @@ static int imx334_parse_hw_config(struct imx334 *imx334)
 	};
 	struct fwnode_handle *ep;
 	unsigned long rate;
+	unsigned int i, j;
 	int ret;
-	int i;
 
 	if (!fwnode)
 		return -ENXIO;
@@ -1097,11 +1122,20 @@ static int imx334_parse_hw_config(struct imx334 *imx334)
 		goto done_endpoint_free;
 	}
 
-	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++)
-		if (bus_cfg.link_frequencies[i] == IMX334_LINK_FREQ)
+	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++) {
+		for (j = 0; j < ARRAY_SIZE(link_freq); j++) {
+			if (bus_cfg.link_frequencies[i] == link_freq[j]) {
+				set_bit(j, &imx334->menu_skip_mask);
+				break;
+			}
+		}
+
+		if (j == ARRAY_SIZE(link_freq)) {
+			ret = dev_err_probe(imx334->dev, -EINVAL,
+					    "no supported link freq found\n");
 			goto done_endpoint_free;
-
-	ret = -EINVAL;
+		}
+	}
 
 done_endpoint_free:
 	v4l2_fwnode_endpoint_free(&bus_cfg);
@@ -1232,10 +1266,10 @@ static int imx334_init_controls(struct imx334 *imx334)
 	imx334->link_freq_ctrl = v4l2_ctrl_new_int_menu(ctrl_hdlr,
 							&imx334_ctrl_ops,
 							V4L2_CID_LINK_FREQ,
-							ARRAY_SIZE(link_freq) -
-							1,
-							mode->link_freq_idx,
+							__fls(imx334->menu_skip_mask),
+							__ffs(imx334->menu_skip_mask),
 							link_freq);
+
 	if (imx334->link_freq_ctrl)
 		imx334->link_freq_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
@@ -1302,7 +1336,7 @@ static int imx334_probe(struct i2c_client *client)
 	}
 
 	/* Set default mode to max resolution */
-	imx334->cur_mode = &supported_modes[0];
+	imx334->cur_mode = &supported_modes[__ffs(imx334->menu_skip_mask)];
 	imx334->cur_code = imx334_mbus_codes[0];
 	imx334->vblank = imx334->cur_mode->vblank;
 
-- 
2.34.1

