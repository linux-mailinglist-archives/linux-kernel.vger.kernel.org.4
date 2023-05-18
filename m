Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98256708C10
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 01:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjERXHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 19:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjERXGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 19:06:52 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB18EE66
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:06:48 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3354760df57so654335ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684451208; x=1687043208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecbFuD3QxPryZIrTro3PTU8NirrT9CMhiKMvVewbmus=;
        b=DRlxu1K3ekyZ0+ZqWmJVHzlHiDTU/lo4ajzaQcfzIQ9w1xTidojcidM1YQuCK2BO3F
         tqm+ZiwKQY+HABU4Gtw4HBJqm1lPIhMSRQVWSSfHI0TfIILXKQfiTma7bcZcKU4cpe1T
         b/THWyOPH0DhPnmIn4G7LUBvawe7uAdL0LPUXnLKqFZaCVLBIJSV2og0thMmAsYuxC2P
         3Hyyq5OWSb23+2Sl5QlQpW9fo4ESjElOEK1y0WYt26MJIW1+/sdM+FwA6K7xozxPAY3D
         RqhIyb5DLxH8L94aYNtw9AiqseUpIkFPBmnUqaFcRAM9cna6safTrKkf3sUlV4SoOoj1
         JdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684451208; x=1687043208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecbFuD3QxPryZIrTro3PTU8NirrT9CMhiKMvVewbmus=;
        b=D/5pUz0AaWkMIXG8sH0yHoaWxKaIE4lfFZMWghWd2anPacxoWGLzxKeOQ/WEaYGv2o
         3O7P8qGKbe//q6d0cmCeIMHqezNK8utiJpmiNuUIL3fw8Kzv1L7p/LXf6sw1m3SwMktx
         A1ncOjzWXlAfe0JdS/7YFZm8BhyJdtIJiSEUQBUZKjfaAOBQZmjf2XoB9QJwAb+Pz/pT
         S6RpHevYUEZcTV343eh2U2NunpA/Cb2m3slw3fSV3IBPE15P8LaRhmXopHYR4Z9tU58T
         akvdSTtLixOxyqvgRmSElxNv/OX1b7QyEiTZOLx+muqJTb+Vxq/GTgb0mQTo+Sn8+1iJ
         ucHQ==
X-Gm-Message-State: AC+VfDzUvXRZxXykQ7vbu4S7wpaQrxmQ7Nw/e8VfMGlrxttpTZtM5ZNz
        rFOV6WVkrv4D8k9NGKBJcWI=
X-Google-Smtp-Source: ACHHUZ7xxlTDd296VQu9FJNR9Sswd4fc/CWekUdUKsFWsPmNwCOk9oswNovfBbTnLqqMQbRGdIkIRg==
X-Received: by 2002:a92:ac11:0:b0:334:fa57:e670 with SMTP id r17-20020a92ac11000000b00334fa57e670mr4397461ilh.0.1684451207938;
        Thu, 18 May 2023 16:06:47 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:56b8:635c:4c7a:15b1])
        by smtp.gmail.com with ESMTPSA id z12-20020a92cd0c000000b003317ebbc426sm635897iln.47.2023.05.18.16.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 16:06:47 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V7 6/6] drm: bridge: samsung-dsim: Support non-burst mode
Date:   Thu, 18 May 2023 18:06:26 -0500
Message-Id: <20230518230626.404068-7-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518230626.404068-1-aford173@gmail.com>
References: <20230518230626.404068-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The high-speed clock is hard-coded to the burst-clock
frequency specified in the device tree.  However, when
using devices like certain bridge chips without burst mode
and varying resolutions and refresh rates, it may be
necessary to set the high-speed clock dynamically based
on the desired pixel clock for the connected device.

This also removes the need to set a clock speed from
the device tree for non-burst mode operation, since the
pixel clock rate is the rate requested from the attached
device like a bridge chip.  This should have no impact
for people using burst-mode and setting the burst clock
rate is still required for those users.  If the burst
clock is not present, change the error message to
dev_info indicating the clock use the pixel clock.

Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com> # imx8mm-icore
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index e67e501c9d49..9eda8ecc4151 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -660,11 +660,21 @@ static unsigned long samsung_dsim_set_pll(struct samsung_dsim *dsi,
 
 static int samsung_dsim_enable_clock(struct samsung_dsim *dsi)
 {
-	unsigned long hs_clk, byte_clk, esc_clk;
+	unsigned long hs_clk, byte_clk, esc_clk, pix_clk;
 	unsigned long esc_div;
 	u32 reg;
+	struct drm_display_mode *m = &dsi->mode;
+	int bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
+
+	/* m->clock is in KHz */
+	pix_clk = m->clock * 1000;
+
+	/* Use burst_clk_rate if available, otherwise use the pix_clk */
+	if (dsi->burst_clk_rate)
+		hs_clk = samsung_dsim_set_pll(dsi, dsi->burst_clk_rate);
+	else
+		hs_clk = samsung_dsim_set_pll(dsi, DIV_ROUND_UP(pix_clk * bpp, dsi->lanes));
 
-	hs_clk = samsung_dsim_set_pll(dsi, dsi->burst_clk_rate);
 	if (!hs_clk) {
 		dev_err(dsi->dev, "failed to configure DSI PLL\n");
 		return -EFAULT;
@@ -936,7 +946,7 @@ static void samsung_dsim_set_display_mode(struct samsung_dsim *dsi)
 	u32 reg;
 
 	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
-		int byte_clk_khz = dsi->burst_clk_rate / 1000 / 8;
+		int byte_clk_khz = dsi->hs_clock / 1000 / 8;
 		int hfp = (m->hsync_start - m->hdisplay) * byte_clk_khz / m->clock;
 		int hbp = (m->htotal - m->hsync_end) * byte_clk_khz / m->clock;
 		int hsa = (m->hsync_end - m->hsync_start) * byte_clk_khz / m->clock;
@@ -1786,10 +1796,13 @@ static int samsung_dsim_parse_dt(struct samsung_dsim *dsi)
 			return PTR_ERR(pll_clk);
 	}
 
+	/* If it doesn't exist, use pixel clock instead of failing */
 	ret = samsung_dsim_of_read_u32(node, "samsung,burst-clock-frequency",
-				       &dsi->burst_clk_rate, 0);
-	if (ret < 0)
-		return ret;
+				       &dsi->burst_clk_rate, 1);
+	if (ret < 0) {
+		dev_dbg(dev, "Using pixel clock for HS clock frequency\n");
+		dsi->burst_clk_rate = 0;
+	}
 
 	ret = samsung_dsim_of_read_u32(node, "samsung,esc-clock-frequency",
 				       &dsi->esc_clk_rate, 0);
-- 
2.39.2

