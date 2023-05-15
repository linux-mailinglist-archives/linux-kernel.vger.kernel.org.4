Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF643704185
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 01:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245675AbjEOX5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 19:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjEOX52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 19:57:28 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54A57A99
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:57:27 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3319a6f989aso94368985ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684195047; x=1686787047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dygmSIeKyL1Qr6osm0gPJv6LRBfSTNTnVZ/IpsRKoBs=;
        b=ifiSs08y2MIXBn42MVs3fNmMJZNFceO8x5OBZxjHHuPseUh9GHHt2QVVxaJ1tjr0rH
         4lgxmX4/5PLmd3TS0m4VoQvGK0siotAuZaVUL57vq0Fr+x3Zxddw3A3lTreQhjcQxqNH
         tnGG9MYqlx8tz0qt9vIMxWNuiqR0XCqgIE3nTul09t7jYA3Ah59gZ4cEDExLcAGXScxB
         ciVkw5p668JwtFCQ3SI+dfCZYKEUZ0v9xU1L5iTLhd1y1DlxGg579Gx/Q4QUEIZ6GeII
         CHOCMUvoC7stPSQY2HtFkjcojT26Kq2ty1+wlzns4ijmz2vXBiY/KU5/MZ3UftgwI1SD
         x+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684195047; x=1686787047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dygmSIeKyL1Qr6osm0gPJv6LRBfSTNTnVZ/IpsRKoBs=;
        b=TsMz5siu/k9FgLfq2CMiTmewii1K3ipvh1X42qhBI3h0PUKGwk2pkuJLBYYSoY9Qn0
         ONgTBSl1fxLTGSCqUuztPnXUa6XwMZV7Hf4fZ+KmvSptN0RTNgxgLVpo0zoh8kRPHqM/
         DYGG9WCLiwWpYZskYY4KvVAvPtSknAjwCf71flfOUK9B8BhF9N/Mr9qoYFDPVLgr2bOs
         6t+j/utm9/hSvkmh7Nc0gs6P1y6PS1Wx8/vwTWmSD7Nn5fB0vRi91zTymS/uLxDo6uvu
         VgSSUtKsm3brXWJ5RmzImHtkzYPLZIEEHvbJ28e7RkiRPFoFagVhkMmGpx4RGkOCppx6
         7yEQ==
X-Gm-Message-State: AC+VfDwE/4M1QY/p1DslZasKVyI3Rf8GysdfeYu/yXt4U7EMv4xItvf/
        6ePTHbD0hJcrLxOUEQhQ13U=
X-Google-Smtp-Source: ACHHUZ6evfIxkAscIh79dMFR3cgzi0moXGEy9Fy4vlp+9hRCEen8qyXWbLURAPkFLQPKP8NXCqRz2w==
X-Received: by 2002:a92:d403:0:b0:326:3a39:89d0 with SMTP id q3-20020a92d403000000b003263a3989d0mr23300881ilm.1.1684195047045;
        Mon, 15 May 2023 16:57:27 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:61e0:9fee:1bca:ea3c])
        by smtp.gmail.com with ESMTPSA id f6-20020a056638112600b00411b5ea8576sm7427851jar.108.2023.05.15.16.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 16:57:26 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
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
Subject: [PATCH V6 1/6] drm: bridge: samsung-dsim: fix blanking packet size calculation
Date:   Mon, 15 May 2023 18:57:08 -0500
Message-Id: <20230515235713.232939-2-aford173@gmail.com>
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

From: Lucas Stach <l.stach@pengutronix.de>

Scale the blanking packet sizes to match the ratio between HS clock
and DPI interface clock. The controller seems to do internal scaling
to the number of active lanes, so we don't take those into account.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index e0a402a85787..2be3b58624c3 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -874,17 +874,29 @@ static void samsung_dsim_set_display_mode(struct samsung_dsim *dsi)
 	u32 reg;
 
 	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
+		int byte_clk_khz = dsi->burst_clk_rate / 1000 / 8;
+		int hfp = (m->hsync_start - m->hdisplay) * byte_clk_khz / m->clock;
+		int hbp = (m->htotal - m->hsync_end) * byte_clk_khz / m->clock;
+		int hsa = (m->hsync_end - m->hsync_start) * byte_clk_khz / m->clock;
+
+		/* remove packet overhead when possible */
+		hfp = max(hfp - 6, 0);
+		hbp = max(hbp - 6, 0);
+		hsa = max(hsa - 6, 0);
+
+		dev_dbg(dsi->dev, "calculated hfp: %u, hbp: %u, hsa: %u",
+			hfp, hbp, hsa);
+
 		reg = DSIM_CMD_ALLOW(0xf)
 			| DSIM_STABLE_VFP(m->vsync_start - m->vdisplay)
 			| DSIM_MAIN_VBP(m->vtotal - m->vsync_end);
 		samsung_dsim_write(dsi, DSIM_MVPORCH_REG, reg);
 
-		reg = DSIM_MAIN_HFP(m->hsync_start - m->hdisplay)
-			| DSIM_MAIN_HBP(m->htotal - m->hsync_end);
+		reg = DSIM_MAIN_HFP(hfp) | DSIM_MAIN_HBP(hbp);
 		samsung_dsim_write(dsi, DSIM_MHPORCH_REG, reg);
 
 		reg = DSIM_MAIN_VSA(m->vsync_end - m->vsync_start)
-			| DSIM_MAIN_HSA(m->hsync_end - m->hsync_start);
+			| DSIM_MAIN_HSA(hsa);
 		samsung_dsim_write(dsi, DSIM_MSYNC_REG, reg);
 	}
 	reg =  DSIM_MAIN_HRESOL(m->hdisplay, num_bits_resol) |
-- 
2.39.2

