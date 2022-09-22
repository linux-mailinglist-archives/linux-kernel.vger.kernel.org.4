Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3752A5E62D7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiIVMwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiIVMwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:52:49 -0400
X-Greylist: delayed 567 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Sep 2022 05:52:46 PDT
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0CCE11F7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:52:45 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MYFLs0F6WzMpvFw;
        Thu, 22 Sep 2022 14:43:17 +0200 (CEST)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MYFLr4bfzzx4;
        Thu, 22 Sep 2022 14:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1663850596;
        bh=rPRq0sZw9ssZ1DOgDKQ+DheMaamSeVNAcj9Urfa5r+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=di9Svk+N3G3GlNs89fp8R6/eavGQmIAwGU378ycae64rVgx19NkobiulRhs0LEygH
         saQe07et07Zon9c9xQjot48c90LT/vUeeyUt3YmEWJUrT9mM1Md7cVDf+1DZ9bjwkw
         vJ/MqjiihulFIcSCR/sVY1f6wGNvMA1faz7NJ4lA=
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
Subject: [PATCH 2/4] drm/bridge: lt8912b: set hdmi or dvi mode
Date:   Thu, 22 Sep 2022 14:43:04 +0200
Message-Id: <20220922124306.34729-3-dev@pschenker.ch>
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

The Lontium LT8912 does have a setting for DVI or HDMI. This patch reads
from EDID what the display needs and sets it accordingly.

Fixes: 30e2ae943c26 ("drm/bridge: Introduce LT8912B DSI to HDMI bridge")
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 drivers/gpu/drm/bridge/lontium-lt8912b.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 0fd3472e767c..6a4bb7422176 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -323,6 +323,8 @@ static int lt8912_video_setup(struct lt8912 *lt)
 				  vsync_activehigh ? BIT(0) : 0);
 	ret |= regmap_update_bits(lt->regmap[I2C_MAIN], 0xab, BIT(1),
 				  hsync_activehigh ? BIT(1) : 0);
+	ret |= regmap_update_bits(lt->regmap[I2C_MAIN], 0xb2, BIT(0),
+				  lt->connector.display_info.is_hdmi ? BIT(0) : 0);
 
 	return ret;
 }
-- 
2.37.3

