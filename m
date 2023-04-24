Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B916E5A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjDRHle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDRHlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:41:31 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7593272B9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:41:12 -0700 (PDT)
Received: (Authenticated sender: me@crly.cz)
        by mail.gandi.net (Postfix) with ESMTPSA id 4641AFF805;
        Tue, 18 Apr 2023 07:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crly.cz; s=gm1;
        t=1681803667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bD9KwDLg2m8+Br4YPFy4e8CxpYZb1W3wINLNprzhZeA=;
        b=TpUBaBiaC5tf4VO1i95NE7rND+kNTXJT7JJnu66BMubXOENUklh+VOe2pQPtF40+oMiKOn
        XBtPCgOl/7dN1I685LXwMzgha7yMdtuNzqNbnnvuqOIfDhuZ4gHww5aWRmizElEI8uH8oa
        fBL8vvtXmtKlkArXzihIcs6nm3jii9RTOOB5e23ak3PblPLGu8oZ3EhX5Yb6KaYowCQhT3
        HNmsrw+ro1BZllEogfKm5ynnk8LvlWSRmHCNpvM0Oz/KSeIwT65wxbmQ5jxPOUxAFIlPzS
        xr6RDbXq4DXYGStSDi++kZFiotyh25qTEaG5Fo6Ouv3A3hlHTU3AIBap/v5chQ==
From:   Roman Beranek <me@crly.cz>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Roman Beranek <me@crly.cz>, Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosp.io>, Ondrej Jirman <megi@xff.cz>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] drm: sun4i: rename sun4i_dotclock to sun4i_tcon_dclk
Date:   Tue, 18 Apr 2023 09:40:07 +0200
Message-Id: <20230418074008.69752-7-me@crly.cz>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20230418074008.69752-1-me@crly.cz>
References: <20230418074008.69752-1-me@crly.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the rate of TCON0's DCLK matches dotclock for parallel and LVDS
outputs, this doesn't hold for DSI. The 'D' in DCLK actually stands for
'Data' according to Allwinner's manuals. The clock is mostly referred to
as dclk throughout this driver already anyway, so stick with that.

Signed-off-by: Roman Beranek <me@crly.cz>
---
 drivers/gpu/drm/sun4i/Makefile                         |  2 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                     | 10 +++++-----
 .../drm/sun4i/{sun4i_dotclock.c => sun4i_tcon_dclk.c}  |  2 +-
 .../drm/sun4i/{sun4i_dotclock.h => sun4i_tcon_dclk.h}  |  0
 4 files changed, 7 insertions(+), 7 deletions(-)
 rename drivers/gpu/drm/sun4i/{sun4i_dotclock.c => sun4i_tcon_dclk.c} (99%)
 rename drivers/gpu/drm/sun4i/{sun4i_dotclock.h => sun4i_tcon_dclk.h} (100%)

diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index 0d04f2447b01..bad7497a0d11 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -19,7 +19,7 @@ sun8i-mixer-y			+= sun8i_mixer.o sun8i_ui_layer.o \
 				   sun8i_vi_scaler.o sun8i_csc.o
 
 sun4i-tcon-y			+= sun4i_crtc.o
-sun4i-tcon-y			+= sun4i_dotclock.o
+sun4i-tcon-y			+= sun4i_tcon_dclk.o
 sun4i-tcon-y			+= sun4i_lvds.o
 sun4i-tcon-y			+= sun4i_tcon.o
 sun4i-tcon-y			+= sun4i_rgb.o
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 523a6d787921..eec26b1faa4b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -31,12 +31,12 @@
 #include <uapi/drm/drm_mode.h>
 
 #include "sun4i_crtc.h"
-#include "sun4i_dotclock.h"
 #include "sun4i_drv.h"
 #include "sun4i_lvds.h"
 #include "sun4i_rgb.h"
 #include "sun4i_tcon.h"
 #include "sun6i_mipi_dsi.h"
+#include "sun4i_tcon_dclk.h"
 #include "sun8i_tcon_top.h"
 #include "sunxi_engine.h"
 
@@ -1237,14 +1237,14 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	ret = sun4i_tcon_init_irq(dev, tcon);
 	if (ret) {
 		dev_err(dev, "Couldn't init our TCON interrupts\n");
-		goto err_free_dotclock;
+		goto err_free_dclk;
 	}
 
 	tcon->crtc = sun4i_crtc_init(drm, engine, tcon);
 	if (IS_ERR(tcon->crtc)) {
 		dev_err(dev, "Couldn't create our CRTC\n");
 		ret = PTR_ERR(tcon->crtc);
-		goto err_free_dotclock;
+		goto err_free_dclk;
 	}
 
 	if (tcon->quirks->has_channel_0) {
@@ -1264,7 +1264,7 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 		of_node_put(remote);
 
 		if (ret < 0)
-			goto err_free_dotclock;
+			goto err_free_dclk;
 	}
 
 	if (tcon->quirks->needs_de_be_mux) {
@@ -1290,7 +1290,7 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 
 	return 0;
 
-err_free_dotclock:
+err_free_dclk:
 	if (tcon->quirks->has_channel_0)
 		sun4i_dclk_free(tcon);
 err_free_clocks:
diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_tcon_dclk.c
similarity index 99%
rename from drivers/gpu/drm/sun4i/sun4i_dotclock.c
rename to drivers/gpu/drm/sun4i/sun4i_tcon_dclk.c
index 417ade3d2565..03d7de1911cd 100644
--- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon_dclk.c
@@ -10,7 +10,7 @@
 #include <linux/regmap.h>
 
 #include "sun4i_tcon.h"
-#include "sun4i_dotclock.h"
+#include "sun4i_tcon_dclk.h"
 
 struct sun4i_dclk {
 	struct clk_hw		hw;
diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.h b/drivers/gpu/drm/sun4i/sun4i_tcon_dclk.h
similarity index 100%
rename from drivers/gpu/drm/sun4i/sun4i_dotclock.h
rename to drivers/gpu/drm/sun4i/sun4i_tcon_dclk.h
-- 
2.34.1


