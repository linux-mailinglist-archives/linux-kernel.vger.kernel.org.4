Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0329650779
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiLSGPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiLSGPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:15:41 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB1E10D;
        Sun, 18 Dec 2022 22:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671430542; x=1702966542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qsJvK2VpBu4Gb2ZvUzYx5074zsrdEggN0+SM/yXO0po=;
  b=0fec5J4Hmmpe1ku4XyKHGoJ6JuCuQtmRp5K19PzyfYJO8/pi7BNpJLKs
   F4EiYIHTW4CcSxGV49D7xaGimrVx7aNtnUQZOMOeZiaTwCMeg39cMTZbE
   J6+1NvImLiZ8HB2gyefyIMHHtU0aBQK/GqonDNMc+EKBo0DUkddL8xzSf
   saqwHavV+BMEvosHjbWyTVjaaTKv1pApjCiKg/T2aVQTsiEZPcGv6z2ue
   y+dQoGXnc+3gyj3Oqnyvc0g2ep1vNkyTf423RBQAUrzgwk6m4ni+2U/I9
   owXiY+u1HA92Mu0EhQlHJKjgX2Kgv4O998weoy6TtQVvH39kAREz5Ro6w
   g==;
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="193603883"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Dec 2022 23:15:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 18 Dec 2022 23:15:40 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Sun, 18 Dec 2022 23:15:37 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "shravan kumar" <shravan.chippa@microchip.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v7 2/5] media: i2c: imx334: replace __v4l2_ctrl_s_ctrl to __v4l2_ctrl_modify_range
Date:   Mon, 19 Dec 2022 11:45:23 +0530
Message-ID: <20221219061526.3169369-3-shravan.chippa@microchip.com>
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

For evry mode we will get new set of values for hbalnk so use
__v4l2_ctrl_modify_range() to support multi modes for hblank.

The hblank value is readonly in the driver. because of this the function
returns error if we try to change. so added dumy return case in
imx334_set_ctrl function

Suggested-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 drivers/media/i2c/imx334.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
index acc9f9f15e47..a742b60ea3b0 100644
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

