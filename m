Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305A76F8D64
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjEFBKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjEFBJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:09:54 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B5C76A2
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:09:53 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-331333e6bf1so6076355ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 18:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683335392; x=1685927392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NisaWLzWuQ0RLSEQ949UB4sRB725O5JKOWjH/0XJDqY=;
        b=Np1rKEPbU7aa82z3Sb5nU58RP4e43ySPy3mQRqPzZICYad31TTute8Nn91XSsDTlj8
         hejh2NS3TPTsk990WiIBTXCaACA26iBJNlmF0noaxaUOzwn/ad0DEKDt2m8WZVIU3fLE
         U+hc1ghuV5M/fSOj5JgUwWcqPFIvSBy3v5qg43vsKEIJQa2y8LomY/NbwJfDKnhQdw9w
         RvK63f4m74sjdd3bhZ6dukBxHfZhPuuGbyoQu/G++dXbbJnrBTmp2RFBQlbwXrJDfdVv
         6KcpDyvDlTKhezV5gzZy7/KAawbWZJ5HmcJJJEVrzFqbS66cr6/hdLgdpGM7B7HcRHOc
         M7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683335392; x=1685927392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NisaWLzWuQ0RLSEQ949UB4sRB725O5JKOWjH/0XJDqY=;
        b=eoTUpuc6WxrINaOM2rEBtg65ZG1cCgVzfPuimWHs/aGGpfLIh3MzXesczrSpT2YER3
         HFRwWdom8MwLm72CqdrtTqoLorr14IfFpAeREF1ZoTf/ZkGrqWwlTkTVDFrpwKwkR9pE
         uSncmDP6WwyyRavqZjAzSLISHiTFjsjZlR7v3HFqHEMmTKfwXROD1WXkZMsIt/kORlF7
         weP4nO8mFoE29WrSP5eHglhTyFeU+5SsYXgwGYoCJVZVmuc8HIJAxWQptxrrJVec994b
         pF0UNpWF9qStEGQBFoTHjVPMLpYacaLXAACG5diMf8e81ZZstJL6MTOXibdxQbxSKwNX
         r39w==
X-Gm-Message-State: AC+VfDxoZ0XCjTe57fuZSSHOksaAhE0msssaAwI+KKGmYnP1JXCy0iXe
        RDXkZW5tFXirV1wXIV+fKuk=
X-Google-Smtp-Source: ACHHUZ6BC2SZ0HW2iiPkX1xIA2IyCU/D+31hzAOHllsssoB8rHA1toCbGsFQ9+d3F/rYpXA35SqcnA==
X-Received: by 2002:a5d:94c9:0:b0:769:bdaa:a4d9 with SMTP id y9-20020a5d94c9000000b00769bdaaa4d9mr1819301ior.12.1683335392457;
        Fri, 05 May 2023 18:09:52 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:34a2:3894:45cc:c002])
        by smtp.gmail.com with ESMTPSA id r11-20020a5e950b000000b00760ed929d0bsm335735ioj.2.2023.05.05.18.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 18:09:52 -0700 (PDT)
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
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 6/6] drm: bridge: samsung-dsim: Support non-burst mode
Date:   Fri,  5 May 2023 20:09:33 -0500
Message-Id: <20230506010933.170939-7-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230506010933.170939-1-aford173@gmail.com>
References: <20230506010933.170939-1-aford173@gmail.com>
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
rate is still required for those users.

Lastly, if the burst clock is 0, and the clock is set
from the pixel clock, cache the clock rate configured
from of samsung_dsim_set_pll in order to properly
calculate the blanking.

Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 21 +++++++++++++++++----
 include/drm/bridge/samsung-dsim.h     |  1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 1b98c4e040b0..b79db009c98b 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -654,16 +654,28 @@ static unsigned long samsung_dsim_set_pll(struct samsung_dsim *dsi,
 		reg = samsung_dsim_read(dsi, DSIM_STATUS_REG);
 	} while ((reg & DSIM_PLL_STABLE) == 0);
 
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
@@ -952,7 +964,7 @@ static void samsung_dsim_set_display_mode(struct samsung_dsim *dsi)
 	u32 reg;
 
 	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
-		int byte_clk_khz = dsi->burst_clk_rate / 1000 / 8;
+		int byte_clk_khz = dsi->hs_clock / 1000 / 8;
 		int hfp = (m->hsync_start - m->hdisplay) * byte_clk_khz / m->clock;
 		int hbp = (m->htotal - m->hsync_end) * byte_clk_khz / m->clock;
 		int hsa = (m->hsync_end - m->hsync_start) * byte_clk_khz / m->clock;
@@ -1801,10 +1813,11 @@ static int samsung_dsim_parse_dt(struct samsung_dsim *dsi)
 			return PTR_ERR(pll_clk);
 	}
 
+	/* If it doesn't exist, use pixel clock instead of failing */
 	ret = samsung_dsim_of_read_u32(node, "samsung,burst-clock-frequency",
 				       &dsi->burst_clk_rate);
 	if (ret < 0)
-		return ret;
+		dsi->burst_clk_rate = 0;
 
 	ret = samsung_dsim_of_read_u32(node, "samsung,esc-clock-frequency",
 				       &dsi->esc_clk_rate);
diff --git a/include/drm/bridge/samsung-dsim.h b/include/drm/bridge/samsung-dsim.h
index 76ea8a1720cc..14176e6e9040 100644
--- a/include/drm/bridge/samsung-dsim.h
+++ b/include/drm/bridge/samsung-dsim.h
@@ -94,6 +94,7 @@ struct samsung_dsim {
 
 	u32 pll_clk_rate;
 	u32 burst_clk_rate;
+	u32 hs_clock;
 	u32 esc_clk_rate;
 	u32 lanes;
 	u32 mode_flags;
-- 
2.39.2

