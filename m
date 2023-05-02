Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9E46F3BB6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 03:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjEBBIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 21:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjEBBIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 21:08:24 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276943C05
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 18:08:20 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-760f8ffb27fso54745639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 18:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682989699; x=1685581699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jt34JDLxnLF4emWyf1lG0eNX4wErgdNt3MF2LAiRUok=;
        b=ba5k0haqGFBpnokW2fsW6cgx1k8UVFRl+YUYNzTh2wXKxm2MLB3RAtLueTHIHh4LQ9
         PSLpTchmXnh/Y4tH4whjgc/o4VOcBkIBMM7FVAeVsWA2hbUPx2es/pvK7V/3AXf+a2TG
         HfwGAxePidTEls0Mae/BiVjq8y7qOk1S1x3OgVwfIO/eWyTB5ghXh5FU262qwuX6y+OC
         N9XJqm+ns40tTiHnvvwPFkVC4bUSjCBt9h/LXszU34Z+L3jJZykXGqg0m5O6/GPHvpyk
         W8SS4hQidzh8KbRm74hZZlJ2bL/MK7DBojMxOzHBaF7I7Umw4rcCpXEfhxEqA7XaUVN6
         oQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682989699; x=1685581699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jt34JDLxnLF4emWyf1lG0eNX4wErgdNt3MF2LAiRUok=;
        b=GY7LkQe04hX/hLfolw52h67faIQdDzDgT8PJz6gWfORMDXx1iF517lY86OUw/NtO2p
         FJAalWmd7TmO+BRGoFZfsM28bhNbuKCi+YzaSFv/xVyV6BE/Tf/e3milUJQkXQNmLaAe
         DCJQP4Gr3USALCCdMyTk3iiy0MSM6NLXEeoFlCku/HlX6HGxUhDyQ8nibU8CO4IaqPEw
         J9OvW41Ei6YMia8l8F8AcJgNKbQ6gp1MZGW1E30CBe1mlQwnCaS261T77CkjHEjFwXaB
         b1jRpWgKI2fd94pNcealYC0YZFh9JLvkD2HEH2RwEeb6WclAfe/0mJEWbV34ivpCWom6
         Sjeg==
X-Gm-Message-State: AC+VfDwWg7v1RwNaOVwd2P0gklGKS0AVy+1/cWbDAjrt5NxuNEvpBYKO
        znD2vf9BuelGBR647R+RMZk=
X-Google-Smtp-Source: ACHHUZ7m/eXYG5H16OfNIrIbiJbKernXBlESGdRLz4ThO5RZogp1NpcrJG2OGRFK/xeJ0Zy7SGbN3g==
X-Received: by 2002:a5d:97d7:0:b0:763:d799:cbd1 with SMTP id k23-20020a5d97d7000000b00763d799cbd1mr9065795ios.16.1682989699336;
        Mon, 01 May 2023 18:08:19 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:8257:a536:d7fc:1919])
        by smtp.gmail.com with ESMTPSA id f16-20020a056638329000b0040fb5d5429fsm4836329jav.131.2023.05.01.18.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 18:08:18 -0700 (PDT)
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
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 7/7] drm: bridge: samsung-dsim: Let blanking calcuation work in non-burst mode
Date:   Mon,  1 May 2023 20:07:59 -0500
Message-Id: <20230502010759.17282-8-aford173@gmail.com>
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

The blanking calculation currently uses burst_clk_rate for calculating
the settings. Since it's possible to use this in non-burst mode, it's
possible that where won't be burst_clk_rate.  Instead, cache the
clock rate configured from of samsung_dsim_set_pll and use it instead.

Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 4 +++-
 include/drm/bridge/samsung-dsim.h     | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 53099461cdc2..1dc913db2cb3 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -652,6 +652,8 @@ static unsigned long samsung_dsim_set_pll(struct samsung_dsim *dsi,
 		reg = samsung_dsim_read(dsi, DSIM_STATUS_REG);
 	} while ((reg & DSIM_PLL_STABLE) == 0);
 
+	dsi->hs_clock = fout;
+
 	return fout;
 }
 
@@ -960,7 +962,7 @@ static void samsung_dsim_set_display_mode(struct samsung_dsim *dsi)
 	u32 reg;
 
 	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
-		int byte_clk_khz = dsi->burst_clk_rate / 1000 / 8;
+		int byte_clk_khz = dsi->hs_clock / 1000 / 8;
 		int hfp = (m->hsync_start - m->hdisplay) * byte_clk_khz / m->clock;
 		int hbp = (m->htotal - m->hsync_end) * byte_clk_khz / m->clock;
 		int hsa = (m->hsync_end - m->hsync_start) * byte_clk_khz / m->clock;
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

