Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F3B708C09
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 01:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjERXGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 19:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjERXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 19:06:48 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C2210E9
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:06:40 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-334f64c91aeso6782945ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684451200; x=1687043200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eat7ZZkvIgNO0d+Nb1ho7Qs2hgM0XyaATLA4vhm7AEo=;
        b=DE944Ib1ld+120uL+TpRFUQEUj6080i0PgE0CJljKz9AT6i5kL6jbS5vo+Ah3G3Y6Q
         5A1JNFqdHCind3nF0DuR3oKRPNTu1RxUEuYUDTkX1+xBVMZPnXBQ1G+7GPrdhsX+GoqS
         T3zCHFtXehuLBWscviMN4qwDbIgVkASo9Gke+noVwt/+OjXpd+qf1KVxAKH48lWwLbMQ
         lJHm2t3SHeoxm92FdGafsqeapPFYMsR5GAirsGd5fUHZysjBnjw17yGhij2oa/63kybo
         SqJPRjIP31NhhlmQLOTEsiycV0yBuMZZmW17Eayv17N0vhYIuxXAb6DHYG6WQ1O4p8lE
         6T+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684451200; x=1687043200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eat7ZZkvIgNO0d+Nb1ho7Qs2hgM0XyaATLA4vhm7AEo=;
        b=k/kIPERhgGf3eSpmJ6JZixsbd1maW1UaXVDWWAbSX5ZxzMHLIHxNjxNIVOzKr9NnZq
         s3OAjFCV8+h3N5s2F6Qn3y3MtbzNs6CbhttakpniXdcKuX/Nb8pcBQ4Mv2s/srE+djBc
         ZMfXAoXcOnTB7LTmZ9iVyObhgiqm8HU1teK1evj45ats0dMNdfzwXCVDUaUDKpN4Rb1u
         GqeN8LtvHizceOIrl8Vrp7E1dBdsTL7eC9Jlp7FdCaBwqTcPRkiY+w3UhHvOJjtAhLOe
         lEpGgi0LzctU/VF4E7lKXqKXd3sIkNyOc0c6hp6TNyQCd/23eZDRrLMoAczQYycxYag5
         tSUg==
X-Gm-Message-State: AC+VfDysCjOuL1mGcvNi3ZBXiXaTtWJvxO0+lcIXDAcAwYu037kG5MUL
        Yy0DbLazT7ozMu5pE94KMVk=
X-Google-Smtp-Source: ACHHUZ7k+Omw1YOkZhO0tjeAZNgxijvwDBeh4ZVTvPZ9gntUZInKMpBhWZ0XSLvpAnWgmUezU83HtA==
X-Received: by 2002:a92:c6cf:0:b0:332:b18a:7ba7 with SMTP id v15-20020a92c6cf000000b00332b18a7ba7mr5201843ilm.27.1684451199670;
        Thu, 18 May 2023 16:06:39 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:56b8:635c:4c7a:15b1])
        by smtp.gmail.com with ESMTPSA id z12-20020a92cd0c000000b003317ebbc426sm635897iln.47.2023.05.18.16.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 16:06:39 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
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
        Inki Dae <inki.dae@samsung.com>, Marek Vasut <marex@denx.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V7 1/6] drm: bridge: samsung-dsim: fix blanking packet size calculation
Date:   Thu, 18 May 2023 18:06:21 -0500
Message-Id: <20230518230626.404068-2-aford173@gmail.com>
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

From: Lucas Stach <l.stach@pengutronix.de>

Scale the blanking packet sizes to match the ratio between HS clock
and DPI interface clock. The controller seems to do internal scaling
to the number of active lanes, so we don't take those into account.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com> # imx8mm-icore
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

