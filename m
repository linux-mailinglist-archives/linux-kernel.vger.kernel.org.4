Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6EE5E62DA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiIVMxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiIVMwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:52:49 -0400
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fa8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2D6E7C2E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:52:47 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MYFLs5Y7wzMpp4G;
        Thu, 22 Sep 2022 14:43:17 +0200 (CEST)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MYFLs37m5z3g;
        Thu, 22 Sep 2022 14:43:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1663850597;
        bh=txqoeLVu69b7SOW8ljUizaUSKTWyveLWsrFwR5lKTZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqXxNIlL6AAoK9a3rCfNjZFvJTXM3EeeCKG/LoCE4RdufGOn/vPayg6nQVe49HvJl
         Z/bsE+axEzj4hajsbXbHi6l4pzFUNCxYMfVmP+Tqd62wgbZpybTU/8eEnFPQRibe1x
         yR+jMUzfDnQTgZLF0ESsMRtggq/eurbjkk/cKXxQ=
From:   Philippe Schenker <dev@pschenker.ch>
To:     dri-devel@lists.freedesktop.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@linux.ie>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: [PATCH 4/4] drm/bridge: lt8912b: clarify lvds output status
Date:   Thu, 22 Sep 2022 14:43:06 +0200
Message-Id: <20220922124306.34729-5-dev@pschenker.ch>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922124306.34729-1-dev@pschenker.ch>
References: <20220922124306.34729-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add comments on the lt8912_write_lvds_config() config to document the
current settings and to make it clear that this is a hardcoded
configuration not relevant for the HDMI output (could be removed without
affecting the HDMI port).

No changes on the actual register writes.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 drivers/gpu/drm/bridge/lontium-lt8912b.c | 26 ++++++++++++++++--------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 5968f4af190b..3e870d45f881 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -165,24 +165,32 @@ static int lt8912_write_rxlogicres_config(struct lt8912 *lt)
 	return ret;
 };
 
+/* enable LVDS output with some hardcoded configuration, not required for the HDMI output */
 static int lt8912_write_lvds_config(struct lt8912 *lt)
 {
 	const struct reg_sequence seq[] = {
+		// lvds power up
 		{0x44, 0x30},
 		{0x51, 0x05},
-		{0x50, 0x24},
-		{0x51, 0x2d},
-		{0x52, 0x04},
-		{0x69, 0x0e},
+
+		// core pll bypass
+		{0x50, 0x24}, // cp=50uA
+		{0x51, 0x2d}, // Pix_clk as reference, second order passive LPF PLL
+		{0x52, 0x04}, // loopdiv=0, use second-order PLL
+		{0x69, 0x0e}, // CP_PRESET_DIV_RATIO
 		{0x69, 0x8e},
 		{0x6a, 0x00},
-		{0x6c, 0xb8},
+		{0x6c, 0xb8}, // RGD_CP_SOFT_K_EN,RGD_CP_SOFT_K[13:8]
 		{0x6b, 0x51},
-		{0x04, 0xfb},
+
+		{0x04, 0xfb}, // core pll reset
 		{0x04, 0xff},
-		{0x7f, 0x00},
-		{0xa8, 0x13},
-		{0x02, 0xf7},
+
+		// scaler bypass
+		{0x7f, 0x00}, // disable scaler
+		{0xa8, 0x13}, // 0x13: JEIDA, 0x33: VESA
+
+		{0x02, 0xf7}, // lvds pll reset
 		{0x02, 0xff},
 		{0x03, 0xcf},
 		{0x03, 0xff},
-- 
2.37.3

