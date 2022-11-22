Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411E36336ED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiKVIXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiKVIXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:23:47 -0500
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB3D29351
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:23:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5C2D4BFCC8;
        Tue, 22 Nov 2022 09:23:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1669105422; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=HF/dQ7k7L9EVK7uPaLgIE5BOxzPXAihnaMZPR/UT1nM=;
        b=C7hrUPVl5EI4C4/6K7jCUsTQ4eKq9V2kKy+XeTx1e/lWQQdMGQErEC+cP3zm1LhiM5vu82
        Ij6+ujbbTpSGVgKedvZYIToLbyCH2cK9CRi/uDRhnpsqhALmVNwKE35GmyOVW35oxMfPu5
        2cDOprgQy7jTqapK+aTZ8scjkYhA7SZOgHOsLewhOmkF+xxc8j0RhpG1K6M6AAqHzlsUYS
        1WUet/2/i9ftPmd2Z7suQuZyEdJcu4x34ps++NvTPg0ADASSxR6cMmmCYyhIMewPEMTe1u
        okf0LOem1UHOCsInXIx6xyUQKrsd30wrUcSyI9djo19I61vVNe5c1B9mZ5h5zQ==
From:   Frieder Schrempf <frieder@fris.de>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH] drm/bridge: ti-sn65dsi83: Fix delay after reset deassert to match spec
Date:   Tue, 22 Nov 2022 09:12:18 +0100
Message-Id: <20221122081219.20143-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The datasheet specifies a delay of 10 milliseconds, but the current
driver only waits for 1 ms. Fix this to make sure the initialization
sequence meets the spec.

Fixes: ceb515ba29ba ("drm/bridge: ti-sn65dsi83: Add TI SN65DSI83 and SN65DSI84 driver")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 7ba9467fff12..047c14ddbbf1 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -346,7 +346,7 @@ static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
 
 	/* Deassert reset */
 	gpiod_set_value_cansleep(ctx->enable_gpio, 1);
-	usleep_range(1000, 1100);
+	usleep_range(10000, 11000);
 
 	/* Get the LVDS format from the bridge state. */
 	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
-- 
2.38.1

