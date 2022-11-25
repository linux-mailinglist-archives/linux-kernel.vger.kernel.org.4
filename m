Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A47638361
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 06:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiKYFIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 00:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKYFIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 00:08:41 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7231128E1C;
        Thu, 24 Nov 2022 21:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669352920; x=1700888920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g8OBmYIK6Fvoc7i+MI8M2i9rEaNDQ9Z3VGMaSA83cJM=;
  b=GMvvG71FK+QVXIIRt+Z3hivGLSSO4z+Sbr7u9ha4f8LXk58qR3kBH+Ms
   cqyJrpQjvYz2xb5kYBcDjPtOfvBIm2ubuaej0oIbP/0LPBVKwYUKRnuQb
   ABiuqKaNVOYhRm3v3PxzU1wyCRSUOQ55+CGHNJ+NMkk8PI+xcb/wVPRLf
   u/09SowJBwkCGgUTiqNDC4VVSThx1RdNK2ByEEXc4zWMtQkS2tPqZV7CA
   MlbTbj9G9nfThr3zE5E0N1t1hsmDWR7TGBLi3yVvsN9LUWP0mk9motuk+
   /Vhww7uV40RtJ5lRsYeRNy6QNiTWCSK5D64L+QxdPR6hawuQFCXC7KDZy
   g==;
X-IronPort-AV: E=Sophos;i="5.96,192,1665471600"; 
   d="scan'208";a="188604162"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Nov 2022 22:08:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 24 Nov 2022 22:08:38 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 24 Nov 2022 22:08:36 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Shravan Chippa" <shravan.chippa@microchip.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v5 3/6] media: i2c: imx334: hblank set function modify
Date:   Fri, 25 Nov 2022 10:38:04 +0530
Message-ID: <20221125050807.1857479-4-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221125050807.1857479-1-shravan.chippa@microchip.com>
References: <20221125050807.1857479-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

-If we one modes hblank will not change and it is readonly
-If we have multipull modes and if we do mode switch, hblank value will
change and __v4l2_ctrl_s_ctrl() returns error, so modified
function from __v4l2_ctrl_s_ctrl() to __v4l2_ctrl_modify_range()
will updated all values max, min default it is not showing any error
while changing the mode and update value

Suggested-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 drivers/media/i2c/imx334.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
index acc9f9f15e47..d3bb62c162b3 100644
--- a/drivers/media/i2c/imx334.c
+++ b/drivers/media/i2c/imx334.c
@@ -382,7 +382,8 @@ static int imx334_update_controls(struct imx334 *imx334,
 	if (ret)
 		return ret;
 
-	ret = __v4l2_ctrl_s_ctrl(imx334->hblank_ctrl, mode->hblank);
+	ret = __v4l2_ctrl_modify_range(imx334->hblank_ctrl, IMX334_REG_MIN,
+				       IMX334_REG_MAX, 1, mode->hblank);
 	if (ret)
 		return ret;
 
-- 
2.34.1

