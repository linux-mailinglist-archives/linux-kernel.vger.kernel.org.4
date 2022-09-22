Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107E05E62D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiIVMxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiIVMwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:52:49 -0400
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3161E7C18
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:52:46 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MYFLr4H9vzMpvbT;
        Thu, 22 Sep 2022 14:43:16 +0200 (CEST)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MYFLr1mgZzx4;
        Thu, 22 Sep 2022 14:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1663850596;
        bh=E4CXD4d3Xn+bPdqQlu5YfOTpM5v82SNMUk19vcUlzSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UigWODTfq0hnHtkrn8jCupkr83Ls8C7bR4EE9i16Us3KHcqRTYNIqaTw05VxST2RP
         kwRTrtRtnStmHNfU9Sr8kCo8Gz7V2zvBqZ4AVgF5e/XC7xFxRcf94B2czKkbMtSoPV
         9fBxlD+/KdPjsJ42zTGbq0QNwDxkNNSPRDp75Xqg=
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
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: [PATCH 1/4] drm/bridge: lt8912b: add vsync hsync
Date:   Thu, 22 Sep 2022 14:43:03 +0200
Message-Id: <20220922124306.34729-2-dev@pschenker.ch>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922124306.34729-1-dev@pschenker.ch>
References: <20220922124306.34729-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Currently the bridge driver does not take care whether or not the display
needs positive/negative vertical/horizontal syncs. Pass these two flags
to the bridge from the EDID that was read out from the display.

Fixes: 30e2ae943c26 ("drm/bridge: Introduce LT8912B DSI to HDMI bridge")
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 drivers/gpu/drm/bridge/lontium-lt8912b.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 28bad30dc4e5..0fd3472e767c 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -268,7 +268,7 @@ static int lt8912_video_setup(struct lt8912 *lt)
 	u32 hactive, h_total, hpw, hfp, hbp;
 	u32 vactive, v_total, vpw, vfp, vbp;
 	u8 settle = 0x08;
-	int ret;
+	int ret, hsync_activehigh, vsync_activehigh;
 
 	if (!lt)
 		return -EINVAL;
@@ -278,12 +278,14 @@ static int lt8912_video_setup(struct lt8912 *lt)
 	hpw = lt->mode.hsync_len;
 	hbp = lt->mode.hback_porch;
 	h_total = hactive + hfp + hpw + hbp;
+	hsync_activehigh = lt->mode.flags & DISPLAY_FLAGS_HSYNC_HIGH;
 
 	vactive = lt->mode.vactive;
 	vfp = lt->mode.vfront_porch;
 	vpw = lt->mode.vsync_len;
 	vbp = lt->mode.vback_porch;
 	v_total = vactive + vfp + vpw + vbp;
+	vsync_activehigh = lt->mode.flags & DISPLAY_FLAGS_VSYNC_HIGH;
 
 	if (vactive <= 600)
 		settle = 0x04;
@@ -317,6 +319,11 @@ static int lt8912_video_setup(struct lt8912 *lt)
 	ret |= regmap_write(lt->regmap[I2C_CEC_DSI], 0x3e, hfp & 0xff);
 	ret |= regmap_write(lt->regmap[I2C_CEC_DSI], 0x3f, hfp >> 8);
 
+	ret |= regmap_update_bits(lt->regmap[I2C_MAIN], 0xab, BIT(0),
+				  vsync_activehigh ? BIT(0) : 0);
+	ret |= regmap_update_bits(lt->regmap[I2C_MAIN], 0xab, BIT(1),
+				  hsync_activehigh ? BIT(1) : 0);
+
 	return ret;
 }
 
-- 
2.37.3

