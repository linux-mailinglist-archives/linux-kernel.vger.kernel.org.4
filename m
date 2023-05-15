Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A452F704191
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 01:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343581AbjEOX55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 19:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343583AbjEOX5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 19:57:37 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE0C8683
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:57:36 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3352b8b9b70so3415375ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684195055; x=1686787055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovbw8AumwPiLWq+zBHYUpvMjo6L0EGPwO8D40xqglMs=;
        b=Y/xVZWoMeKLvaUjKKOlqlLtSuFhyOzZV5XSuVhc7tkwffp5mveZCk7b3wFNbZcNRN0
         1nMBv4WAGKD0CCENHTpSxL6+4gV0IiwsETt6cZAlIe1SWqvhqj0GQacc4k9CSiUJofuS
         LTg+y/GiaOkdfXIoinq4FJBL9eY78l0EgFZffNCDYdpxzB7Z+KVHrtPRAPhkCXgHuoB5
         c/Jh9q0a7+hxYI5sxqKtIuHvXt6LAhTY2IVGTLqAImd9ET4uU8qVDybAWYB+CNuhu/wj
         jyzNg6t2oS02XdyK5Ziv+hyqSSm8//FAmHHCBs73sVAbaRCCK6DqR8oOHdrVKj5Cwbc1
         yAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684195055; x=1686787055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovbw8AumwPiLWq+zBHYUpvMjo6L0EGPwO8D40xqglMs=;
        b=fok3lKMTnJz3Sj28HFgsI7RxE9plruqmMVqfHGbOci+1qMfjdgoQAaAhQcpPonleNN
         XVD2ySBZrbiBHuS7w/orkSUdPwAb/Y5CCFY3sZlb5f0JTeKAho1j8UwaHeWW8WWbNczu
         zA4xTLm+Q3rPB8DdTcyinGfmIK5bRyJSXsv7ArGhlF5llg1NaO7XIUV31EBLMTMfqbGf
         VPFQGeFIx1xtvkyFWbKQc+u7mRntPaZ9H0zp+AsguBjDLIdcxTSHbqpzO++L3F2ypZqF
         Icv2dWSw8kTxVDOktpOAlPmfuixIuk7PE5NYJi/fEnHkVaqDzVKeewhnPz6fH65DwkhY
         TDRQ==
X-Gm-Message-State: AC+VfDx+jxx7CoiFOBhSmU2kBlfOYQRvxxfwokxhuhMuXmEjGvUWev7T
        0C0ashZbudqpdMOS0b2kOpw=
X-Google-Smtp-Source: ACHHUZ45lCBw9rFJYhG42QxG/AJhVx4fpB6psZfhjY8kqb4BMP082fH/sIZMTiis4dIyLlyJuvneLA==
X-Received: by 2002:a92:c548:0:b0:337:6d3b:d42f with SMTP id a8-20020a92c548000000b003376d3bd42fmr5190345ilj.13.1684195055527;
        Mon, 15 May 2023 16:57:35 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:61e0:9fee:1bca:ea3c])
        by smtp.gmail.com with ESMTPSA id f6-20020a056638112600b00411b5ea8576sm7427851jar.108.2023.05.15.16.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 16:57:35 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH V6 6/6] drm: bridge: samsung-dsim: Support non-burst mode
Date:   Mon, 15 May 2023 18:57:13 -0500
Message-Id: <20230515235713.232939-7-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515235713.232939-1-aford173@gmail.com>
References: <20230515235713.232939-1-aford173@gmail.com>
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
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 3944b7cfbbdf..03b21d13f067 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -655,16 +655,28 @@ static unsigned long samsung_dsim_set_pll(struct samsung_dsim *dsi,
 
 	dsi->hs_clock = fout;
 
+	dsi->hs_clock = fout;
+
 	return fout;
 }
 
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
@@ -935,7 +947,7 @@ static void samsung_dsim_set_display_mode(struct samsung_dsim *dsi)
 	u32 reg;
 
 	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
-		int byte_clk_khz = dsi->burst_clk_rate / 1000 / 8;
+		int byte_clk_khz = dsi->hs_clock / 1000 / 8;
 		int hfp = (m->hsync_start - m->hdisplay) * byte_clk_khz / m->clock;
 		int hbp = (m->htotal - m->hsync_end) * byte_clk_khz / m->clock;
 		int hsa = (m->hsync_end - m->hsync_start) * byte_clk_khz / m->clock;
@@ -1785,10 +1797,13 @@ static int samsung_dsim_parse_dt(struct samsung_dsim *dsi)
 			return PTR_ERR(pll_clk);
 	}
 
+	/* If it doesn't exist, use pixel clock instead of failing */
 	ret = samsung_dsim_of_read_u32(node, "samsung,burst-clock-frequency",
-				       &dsi->burst_clk_rate, 0);
-	if (ret < 0)
-		return ret;
+				       &dsi->burst_clk_rate, 1);
+	if (ret < 0) {
+		dev_info(dev, "Using pixel clock for HS clock frequency\n");
+		dsi->burst_clk_rate = 0;
+	}
 
 	ret = samsung_dsim_of_read_u32(node, "samsung,esc-clock-frequency",
 				       &dsi->esc_clk_rate, 0);
-- 
2.39.2

