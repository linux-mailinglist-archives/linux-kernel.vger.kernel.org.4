Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F7A6A6831
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCAHew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjCAHer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:34:47 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D803539B9A;
        Tue, 28 Feb 2023 23:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677656080; x=1709192080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IC4Krh/tkpVGXGBoGbbhsCsG+9lDFkR31NuApekcLbg=;
  b=zWo8bMb/BWmaNDlBI14ZImxUyLyNBVaKhR91EBLw2NXHeABK7ipDG8/I
   OgDTW3vGXXUzZTvzTImCCulhjj5aOoyYa32nSwsz/ycKM5QR0KSF9jT6O
   D7MnM6mfHYl1E4iHM1c9qlO5OmdO0vxesQwsCSAPIRrj2trKOweHyCxOM
   At6lKoIvtfnNLlw5CX3o4DEO4qeIIlP3SSJdJUoNRiXirNPBG5zsdWNUU
   BjUBd7/twr3LzsFSy2FtCTSh85NW/Rfh251bNd+36swZv0AYHc8Vx0QQj
   0mr+40Jw1CeOKwNUIAZ/70NVExYVK2lsVx3Tgdr5iEnWJxVVfiCGgpSS2
   A==;
X-IronPort-AV: E=Sophos;i="5.98,224,1673938800"; 
   d="scan'208";a="214162922"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2023 00:34:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Mar 2023 00:34:38 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 1 Mar 2023 00:34:33 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>
CC:     <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <shravan.chippa@microchip.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v12 1/5] media: i2c: imx334: replace __v4l2_ctrl_s_ctrl to __v4l2_ctrl_modify_range
Date:   Wed, 1 Mar 2023 13:04:08 +0530
Message-ID: <20230301073412.1204574-2-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301073412.1204574-1-shravan.chippa@microchip.com>
References: <20230301073412.1204574-1-shravan.chippa@microchip.com>
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

For evry mode we will get new set of values for hbalnk so use
__v4l2_ctrl_modify_range() to support multi modes for hblank.

The hblank value is readonly in the driver. because of this the function
returns error if we try to change. so added dumy return case in
imx334_set_ctrl function.

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Suggested-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 drivers/media/i2c/imx334.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
index 7b0a9086447d..ebacba3059b3 100644
--- a/drivers/media/i2c/imx334.c
+++ b/drivers/media/i2c/imx334.c
@@ -382,7 +382,8 @@ static int imx334_update_controls(struct imx334 *imx334,
 	if (ret)
 		return ret;
 
-	ret = __v4l2_ctrl_s_ctrl(imx334->hblank_ctrl, mode->hblank);
+	ret = __v4l2_ctrl_modify_range(imx334->hblank_ctrl, mode->hblank,
+				       mode->hblank, 1, mode->hblank);
 	if (ret)
 		return ret;
 
@@ -480,6 +481,9 @@ static int imx334_set_ctrl(struct v4l2_ctrl *ctrl)
 
 		pm_runtime_put(imx334->dev);
 
+		break;
+	case V4L2_CID_HBLANK:
+		ret = 0;
 		break;
 	default:
 		dev_err(imx334->dev, "Invalid control %d", ctrl->id);
-- 
2.34.1

