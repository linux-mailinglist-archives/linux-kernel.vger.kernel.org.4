Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B296F3BB5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 03:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjEBBId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 21:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjEBBIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 21:08:19 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C75D40D0
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 18:08:18 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3310e9368eeso5471105ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 18:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682989698; x=1685581698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LILHGDPu6PO8q8DSVW+PJ0k8lNeferhINno8wB3FCRc=;
        b=ODN1m4Vvr99jSc5D+ktc9kqN9l0wREObKD2jZ82mb/T09ybjsKvdPnQKZgSEPzg+Wr
         cOWG1i4r7WnsFgctCGcr1iSXJoKN9/VP2RBn16nAyUywLVzHJ20PenJI0V2ZTzbcFRQh
         9fi3c5cuq/hK6u0xwonLVbDTkZiKPJJzzOdkD+Hssd0ATZR1083DUs6YZwlPZuT8OhpC
         bWf+ZBz1Rcx3WHiF+XNgKiaW7jH5x+wBZbvEkAvoPQNXVGUaRnh4rbjF4H+llZ/7fYkT
         7BXa3Mcywh2PLAhyHhiVQmY+994phYiq7SoEWAQjoInFTpomEIJZrBW6byMPnRXdRL1m
         uUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682989698; x=1685581698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LILHGDPu6PO8q8DSVW+PJ0k8lNeferhINno8wB3FCRc=;
        b=dFMlpsq8DLWtaTvJhbNcdhCxGh9r05n+pOeqUdMlibRmbH1PjkfZU15SCFNjNqyjnJ
         E6W6J0MHdts3XFswjVcDKRS0fVbTXkvL0z74XevBsQ+E14boKulE+yV6dwSrG01dGT+b
         7fkSEleOyFJogPRbdJE0YC9zJe7uKUigUSgMKcB1KWu6JJBPx4ilJhovqY99mP915IFC
         YqqfoexEV0zwEMhbQsq6xw7N1eCT+c5QRq7LIL7TVjZLWsFVViU7QpDxONCZesd6Ev4r
         7mc2vi7CDmfVcTD6aD06H7fO9S0GgmYBJtl3F6DZ3X/U/8CYrGO783upzllgvr5PjWPT
         40hg==
X-Gm-Message-State: AC+VfDx28+vXZ2+tzMJh1+1bVsgL2ndr7VPkogzAIe4b51rdsk6Oo10s
        aj43CjB2R9ZzZ2u0aoa4IA4=
X-Google-Smtp-Source: ACHHUZ4FJUXKa+bW+vrwgDvkvQRTJ4p11bch6fOmM9Fp4+QmSSWor7Ek7oQqKCbAkFachRJ5gpYQOw==
X-Received: by 2002:a92:c94c:0:b0:329:3f00:79e1 with SMTP id i12-20020a92c94c000000b003293f0079e1mr9698503ilq.18.1682989697613;
        Mon, 01 May 2023 18:08:17 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:8257:a536:d7fc:1919])
        by smtp.gmail.com with ESMTPSA id f16-20020a056638329000b0040fb5d5429fsm4836329jav.131.2023.05.01.18.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 18:08:17 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     marex@denx.de, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
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
Subject: [PATCH V3 6/7] drm: bridge: samsung-dsim: Support non-burst mode
Date:   Mon,  1 May 2023 20:07:58 -0500
Message-Id: <20230502010759.17282-7-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230502010759.17282-1-aford173@gmail.com>
References: <20230502010759.17282-1-aford173@gmail.com>
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
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 99642230a54a..53099461cdc2 100644
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
+	/* Use burst_clk_rate if available, otherwise use the pix_clk */
+	if (dsi->burst_clk_rate)
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

