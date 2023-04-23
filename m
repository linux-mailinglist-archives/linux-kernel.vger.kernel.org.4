Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9746EBF44
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 14:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjDWMNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 08:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjDWMND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 08:13:03 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C13173F
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 05:13:01 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3294eacb2f6so8967745ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 05:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682251981; x=1684843981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uP5A249OQ9d1hnlbDG91vSMCtNc8nZw97HXYyMZltzg=;
        b=NHoYXla5QQRCzeCeKvqnyvDRj+E/EbypCZcBf27+BvrVTYZ2ZGaarw/oTuCMzCqZIT
         I0mgmnYkyFY9pPAeFeymeqyrBhX++4bb9SsPtkfhRyrcAKtXzBN1oaBgy42z3KprSMRq
         hLzErKioeH5tknsM9DsinGZ/a8C05Cp2ZMCDNh0hwNK5Kn08pXtHDB9BKAqM8HWeM6zP
         cLLp7QYh9IalQBf4oiWFs2/uhYdbD5UWcOYfdnr5mpskC4R4AWyvUbOA0Mawc959WNLa
         l7jO0aGjRvnHPV0wgmGYkqtT7MWSvEZ0ai1wWVMg0H4eKfo8IIYytGD7otd4JRCn4opN
         1n2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682251981; x=1684843981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uP5A249OQ9d1hnlbDG91vSMCtNc8nZw97HXYyMZltzg=;
        b=hZ9RAQeyCxL8LjBJht3k135EdF4QrPbSkN71nUBrzEBGxsb0tm+bucCbRinobbaciW
         cz110fdE4NtL3r6x/F86Z1GK7rMA0FKatuhNIZz7/RteMyZXUVWF7wqm+OmDyK7uKNtv
         /9c6/iMmk2lgK7/R1d5jYP+S8hzMpj3pphjxukwo8YYR1mcr0QXQjTRZ4ukFZwrqpiX3
         GcV5hDai9V2LRtVuhlFgsEBDs+91B6VxByBD7Id+55TrGPd4Pl7NXq8d2/5Q4WW6PV55
         02gQuBeBV+u6WRwyZExnNl3CX9AmUMIvUzxaOHKy5Kq5a6sjbYFnzIEPSpUgp30uTM8/
         O+Lg==
X-Gm-Message-State: AAQBX9d6apA6XQYC7Vc9qj4LKE/YuSy1xLcZJxE3E9wMfu3tiyyGV9+r
        2C/17qUE27jzRKLdFW0BbS0=
X-Google-Smtp-Source: AKy350YMNdxeTgrCAbQoe17aHXe2grAjCrKzYgpyraU0dzHLlsUOk/L401w0XPTTPmOa20kMjGROMw==
X-Received: by 2002:a5e:8e06:0:b0:761:ac61:3162 with SMTP id a6-20020a5e8e06000000b00761ac613162mr3689827ion.1.1682251980759;
        Sun, 23 Apr 2023 05:13:00 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:b473:5d7c:4c2:75d7])
        by smtp.gmail.com with ESMTPSA id u11-20020a02230b000000b00411a1373aa5sm1612155jau.155.2023.04.23.05.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 05:13:00 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     m.szyprowski@samsung.com, aford@beaconembedded.com,
        dario.binacchi@amarulasolutions.com, l.stach@pengutronix.de,
        Adam Ford <aford173@gmail.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/6] drm: bridge: samsung-dsim: Support non-burst mode
Date:   Sun, 23 Apr 2023 07:12:31 -0500
Message-Id: <20230423121232.1345909-6-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230423121232.1345909-1-aford173@gmail.com>
References: <20230423121232.1345909-1-aford173@gmail.com>
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
device like an HDMI bridge chip.  This should have no
impact for people using burst-mode and setting the burst
clock rate is still required for those users.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index f165483d5044..cea847b8e23c 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -657,11 +657,21 @@ static unsigned long samsung_dsim_set_pll(struct samsung_dsim *dsi,
 
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
+	/* Use burst_clk_rate for burst mode, otherwise use the pix_clk */
+	if ((dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) && dsi->burst_clk_rate)
+		hs_clk = samsung_dsim_set_pll(dsi, dsi->burst_clk_rate);
+	else
+		hs_clk = samsung_dsim_set_pll(dsi, DIV_ROUND_UP(pix_clk * bpp, dsi->lanes));
 
-	hs_clk = samsung_dsim_set_pll(dsi, dsi->burst_clk_rate);
 	if (!hs_clk) {
 		dev_err(dsi->dev, "failed to configure DSI PLL\n");
 		return -EFAULT;
@@ -1800,10 +1810,11 @@ static int samsung_dsim_parse_dt(struct samsung_dsim *dsi)
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
-- 
2.39.2

