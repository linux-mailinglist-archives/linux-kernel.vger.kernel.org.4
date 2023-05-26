Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD77711E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 05:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjEZDGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 23:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240695AbjEZDGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 23:06:20 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C89BB;
        Thu, 25 May 2023 20:06:17 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-77480507360so10014039f.3;
        Thu, 25 May 2023 20:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685070377; x=1687662377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOxHSlFkyb4mwah+dyNQcB4nfGc3lfT3QYX6cJG7ar4=;
        b=RgTVQrqsqAkkyPqG7wSBAaksSR/tRYcC5r5KOJz3opH6M1G7Ut3Pigop7ABGikNFoG
         yreUKt1kXcS94DtjgqVj4laiXxCr3UzgGMNvvZK/Kvil7BPjNXpiGDTKNXvh99uMBra7
         8WkB00JFZ8FewLZRjflAnUz0TfwWt2H7frtd39gsb6mW+FsoaAtEYXouh7ERLxU3OZDv
         KHncPCcr1ozUXo52hQpkZyhQOq5oQHJJEq9iLyWCCj74niF0RrEvo6Y5W0XsZa+qyvhZ
         lN10LL8OSekC5ZtYAX+PYYVxMr1zZdXpvUXFJ2F18HGsjZGSDF8XReiq7uUIL19HIKWl
         vqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685070377; x=1687662377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOxHSlFkyb4mwah+dyNQcB4nfGc3lfT3QYX6cJG7ar4=;
        b=YgSUtK7C4yJykzsVmJqeL6LWiq1QCA1RCIkFGECK5SAxKTRl5C1MMT1IwEtVm8LTyO
         21vWG5SUHFmiuld5i/RvTDIGXCk7njavnQ0VSbohnUaTPJrN4XIzB7ruBlicVshTTTKT
         lt14jh/1P32v9csJ6v6Y1gbc3uRibrUdFVRwO0idTFR+AETrZg3fTdarUTJCKDMR+STL
         +j2ET/sCr+auMn/NB2jfVPTRPGMLoMy57hJMpxWFXZqRk1gDuWeyQSpcLfvp2/30OB6H
         oOzTXtezYRFivMIipDOvv5tRSIW2FaYMuBxwK2gKzRsoR+H+Dcdrh3buzUyWZ3uBfsPP
         ELQw==
X-Gm-Message-State: AC+VfDxYy6G4WKkDmADDDvWfFGLFdCasPqaSYfFzMSJqGJyJv7XQUsAR
        fPoS5lGISHqfsiIywN4x6NY=
X-Google-Smtp-Source: ACHHUZ7W12qiZWPP5+wNKW3hAJIEv7+NyBUAX5t6V+myy39GQrL7duYXFMxnIYsYmeVXxNu7CkwuNg==
X-Received: by 2002:a6b:7b02:0:b0:76c:5513:8b00 with SMTP id l2-20020a6b7b02000000b0076c55138b00mr23791iop.21.1685070377124;
        Thu, 25 May 2023 20:06:17 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:3dd9:3f6c:9922:6420])
        by smtp.gmail.com with ESMTPSA id i2-20020a5e8502000000b007702f55116fsm363189ioj.38.2023.05.25.20.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 20:06:16 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Inki Dae <inki.dae@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 5/7] drm: bridge: samsung-dsim: Dynamically configure DPHY timing
Date:   Thu, 25 May 2023 22:05:57 -0500
Message-Id: <20230526030559.326566-6-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526030559.326566-1-aford173@gmail.com>
References: <20230526030559.326566-1-aford173@gmail.com>
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

The DPHY timings are currently hard coded. Since the input
clock can be variable, the phy timings need to be variable
too.  To facilitate this, we need to cache the hs_clock
based on what is generated from the PLL.

The phy_mipi_dphy_get_default_config_for_hsclk function
configures the DPHY timings in pico-seconds, and a small macro
converts those timings into clock cycles based on the hs_clk.

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Michael Walle <michael@walle.cc>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com> # imx8mm-icore
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 58 +++++++++++++++++++++++----
 include/drm/bridge/samsung-dsim.h     |  1 +
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 307f1c20cfb9..41f557fee29a 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -220,6 +220,8 @@
 
 #define OLD_SCLK_MIPI_CLK_NAME		"pll_clk"
 
+#define PS_TO_CYCLE(ps, hz) DIV64_U64_ROUND_CLOSEST(((ps) * (hz)), 1000000000000ULL)
+
 static const char *const clk_names[5] = {
 	"bus_clk",
 	"sclk_mipi",
@@ -658,6 +660,8 @@ static unsigned long samsung_dsim_set_pll(struct samsung_dsim *dsi,
 		reg = samsung_dsim_read(dsi, DSIM_STATUS_REG);
 	} while ((reg & DSIM_PLL_STABLE) == 0);
 
+	dsi->hs_clock = fout;
+
 	return fout;
 }
 
@@ -705,13 +709,47 @@ static void samsung_dsim_set_phy_ctrl(struct samsung_dsim *dsi)
 	const struct samsung_dsim_driver_data *driver_data = dsi->driver_data;
 	const unsigned int *reg_values = driver_data->reg_values;
 	u32 reg;
+	struct phy_configure_opts_mipi_dphy cfg;
+	int clk_prepare, lpx, clk_zero, clk_post, clk_trail;
+	int hs_exit, hs_prepare, hs_zero, hs_trail;
+	unsigned long long byte_clock = dsi->hs_clock / 8;
 
 	if (driver_data->has_freqband)
 		return;
 
+	phy_mipi_dphy_get_default_config_for_hsclk(dsi->hs_clock,
+						   dsi->lanes, &cfg);
+
+	/*
+	 * TODO:
+	 * The tech Applications Processor manuals for i.MX8M Mini, Nano,
+	 * and Plus don't state what the definition of the PHYTIMING
+	 * bits are beyond their address and bit position.
+	 * After reviewing NXP's downstream code, it appears
+	 * that the various PHYTIMING registers take the number
+	 * of cycles and use various dividers on them.  This
+	 * calculation does not result in an exact match to the
+	 * downstream code, but it is very close to the values
+	 * generated by their lookup table, and it appears
+	 * to sync at a variety of resolutions. If someone
+	 * can get a more accurate mathematical equation needed
+	 * for these registers, this should be updated.
+	 */
+
+	lpx = PS_TO_CYCLE(cfg.lpx, byte_clock);
+	hs_exit = PS_TO_CYCLE(cfg.hs_exit, byte_clock);
+	clk_prepare = PS_TO_CYCLE(cfg.clk_prepare, byte_clock);
+	clk_zero = PS_TO_CYCLE(cfg.clk_zero, byte_clock);
+	clk_post = PS_TO_CYCLE(cfg.clk_post, byte_clock);
+	clk_trail = PS_TO_CYCLE(cfg.clk_trail, byte_clock);
+	hs_prepare = PS_TO_CYCLE(cfg.hs_prepare, byte_clock);
+	hs_zero = PS_TO_CYCLE(cfg.hs_zero, byte_clock);
+	hs_trail = PS_TO_CYCLE(cfg.hs_trail, byte_clock);
+
 	/* B D-PHY: D-PHY Master & Slave Analog Block control */
 	reg = reg_values[PHYCTRL_ULPS_EXIT] | reg_values[PHYCTRL_VREG_LP] |
 		reg_values[PHYCTRL_SLEW_UP];
+
 	samsung_dsim_write(dsi, DSIM_PHYCTRL_REG, reg);
 
 	/*
@@ -719,7 +757,9 @@ static void samsung_dsim_set_phy_ctrl(struct samsung_dsim *dsi)
 	 * T HS-EXIT: Time that the transmitter drives LP-11 following a HS
 	 *	burst
 	 */
-	reg = reg_values[PHYTIMING_LPX] | reg_values[PHYTIMING_HS_EXIT];
+
+	reg  = DSIM_PHYTIMING_LPX(lpx) | DSIM_PHYTIMING_HS_EXIT(hs_exit);
+
 	samsung_dsim_write(dsi, DSIM_PHYTIMING_REG, reg);
 
 	/*
@@ -735,10 +775,11 @@ static void samsung_dsim_set_phy_ctrl(struct samsung_dsim *dsi)
 	 * T CLK-TRAIL: Time that the transmitter drives the HS-0 state after
 	 *	the last payload clock bit of a HS transmission burst
 	 */
-	reg = reg_values[PHYTIMING_CLK_PREPARE] |
-		reg_values[PHYTIMING_CLK_ZERO] |
-		reg_values[PHYTIMING_CLK_POST] |
-		reg_values[PHYTIMING_CLK_TRAIL];
+
+	reg = DSIM_PHYTIMING1_CLK_PREPARE(clk_prepare)	|
+	      DSIM_PHYTIMING1_CLK_ZERO(clk_zero)	|
+	      DSIM_PHYTIMING1_CLK_POST(clk_post)	|
+	      DSIM_PHYTIMING1_CLK_TRAIL(clk_trail);
 
 	samsung_dsim_write(dsi, DSIM_PHYTIMING1_REG, reg);
 
@@ -751,8 +792,11 @@ static void samsung_dsim_set_phy_ctrl(struct samsung_dsim *dsi)
 	 * T HS-TRAIL: Time that the transmitter drives the flipped differential
 	 *	state after last payload data bit of a HS transmission burst
 	 */
-	reg = reg_values[PHYTIMING_HS_PREPARE] | reg_values[PHYTIMING_HS_ZERO] |
-		reg_values[PHYTIMING_HS_TRAIL];
+
+	reg = DSIM_PHYTIMING2_HS_PREPARE(hs_prepare) |
+	      DSIM_PHYTIMING2_HS_ZERO(hs_zero) |
+	      DSIM_PHYTIMING2_HS_TRAIL(hs_trail);
+
 	samsung_dsim_write(dsi, DSIM_PHYTIMING2_REG, reg);
 }
 
diff --git a/include/drm/bridge/samsung-dsim.h b/include/drm/bridge/samsung-dsim.h
index 2c20b9460c9a..05100e91ecb9 100644
--- a/include/drm/bridge/samsung-dsim.h
+++ b/include/drm/bridge/samsung-dsim.h
@@ -93,6 +93,7 @@ struct samsung_dsim {
 
 	u32 pll_clk_rate;
 	u32 burst_clk_rate;
+	u32 hs_clock;
 	u32 esc_clk_rate;
 	u32 lanes;
 	u32 mode_flags;
-- 
2.39.2

