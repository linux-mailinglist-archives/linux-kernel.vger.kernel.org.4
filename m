Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2BC6E30B3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjDOKlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjDOKl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:41:27 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C915B93;
        Sat, 15 Apr 2023 03:41:24 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-760c5522520so79413939f.2;
        Sat, 15 Apr 2023 03:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681555284; x=1684147284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtFFKmwY6AVZaivGUGeBXmlxV0WshHisjIf4olqGXlk=;
        b=oL6X1i8/kjCWm/1yiymDM94a0njyMbG9HTxP6ejrDG7ZtExirgBlCbJ0hJrZEL0w20
         nuhCPKvLwSDiQ14eICBJgwALXNAeZT404BHs1u9WKpHsUVZJyCeLHpCFthF0uiaFAnS2
         Zu7wBi42hG7hRgKlP9BwSgxVY/kX4j31smJWTVlmcL9KfbTR8RQvNNbIWus0nM47u0iL
         COZC6yOIDhepC15FBWAId35YzFu2uZt2gqEOLpfzvP0AwZ67Fk/XxaVh4m6j0SFP8F7m
         1BdnNafSJs1yK1VQnsmvS3G178egs+eeAie4bDJyPGXCZHTYRc/UdZ25dwN2bQiMFcGW
         IVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555284; x=1684147284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtFFKmwY6AVZaivGUGeBXmlxV0WshHisjIf4olqGXlk=;
        b=eJaFCMniBmhCukurqqromx9ZEpZgZb+rPvSwr6yenKzbM/7Rb2wJFwYrfXdJXJYtl5
         aayB1qfSZjuYPkkl0wqwiIdbPgGH3SKGl2bLntpNkFl3x6fh7PKdVKbO0V/8D3kwRCdh
         Vfe674/yHZGUKHmM206YuMuoQ5i0ozVZtTU4+3CQvF/JX0rq7I69E204Cpu7CSVAIcpE
         LxR+w+htVnfWHt5OeQ2ol7RqR7/rbPpMhZIzDshtqp0WsREZETmmZa/wP+dRtw/FW/wG
         dp4qE8Igqyx10aEn6dLsRfmZbySxm5O3UpUTT6aymBSrVqmkKWp7kqf7VEdQrCzhLbkz
         KNpw==
X-Gm-Message-State: AAQBX9fxkFVQKKYreMOIgZDL5GISxaCNcpINqA/rVsqTpC438uI/RYoF
        jnDAcUAl6vDLEzkDHi0QNfc=
X-Google-Smtp-Source: AKy350Zh2mdRrtm0rvTQDn/bkgIVArEkgFv6/4BKmvhP9tvea7MQ7QnqypAhJ6V3RS+W4k7NVOx5wA==
X-Received: by 2002:a92:d690:0:b0:326:2bb3:5f9a with SMTP id p16-20020a92d690000000b003262bb35f9amr6437030iln.6.1681555283888;
        Sat, 15 Apr 2023 03:41:23 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:40bb:6fe6:ddbc:cc9a])
        by smtp.gmail.com with ESMTPSA id bp11-20020a056638440b00b0040b38102b79sm246536jab.82.2023.04.15.03.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:41:23 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     m.szyprowski@samsung.com, marex@denx.de, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] drm: bridge: samsung-dsim: Support non-burst mode
Date:   Sat, 15 Apr 2023 05:41:02 -0500
Message-Id: <20230415104104.5537-5-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230415104104.5537-1-aford173@gmail.com>
References: <20230415104104.5537-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index c48db27adafe..5aa3a44f15ec 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -659,11 +659,21 @@ static unsigned long samsung_dsim_set_pll(struct samsung_dsim *dsi,
 
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
-- 
2.39.2

