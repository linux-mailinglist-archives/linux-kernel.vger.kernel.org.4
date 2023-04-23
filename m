Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0733A6EBF45
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 14:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjDWMNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 08:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDWMNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 08:13:04 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7631733
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 05:13:03 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7606d443bb2so106169639f.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 05:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682251982; x=1684843982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ym0X1edkE/8UZRdqtYyBbFIXdvNOteOPtajDW+FAJfU=;
        b=LlWcnTgzBJhYGrMJdnKIHgclJpniEDVvXYWQLVonuhkOvJsDe2+G9yYhVk2m6ttSJa
         OOpZGVTjpcWBojyy5qs91Qa1VPUpAOLJtoHto+ZZQ+HsnplUSmR8wQEoZSHiD6b0Q/UJ
         1VfnEhTApbX6fXCjjD4Acqe1rfmwWMUOaonJKd80AESenriv4tk316jixFGpqmeRs8/n
         X2s52+ODTatwP0Q8KJ5HMFVepqd34Mu2QMqeITHboJlYhH25I3c8TCxOKcr39uTlW5Nw
         kgrBJZwTtuJZElvxV5m+VuYa/E45IClXmQFS+/48r2i1gR3gp2ZUrzoheUdA4HHYssPU
         /XFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682251982; x=1684843982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ym0X1edkE/8UZRdqtYyBbFIXdvNOteOPtajDW+FAJfU=;
        b=CJ3HRK5BZHJ+jGOAS+nFYq6wmGAPXITm0JRmxHQUQq8OP1hjUkxILAnx/VKm0M/HlK
         u2NqUs4eGDP0Z91gqXN24dV06GXHsTn4ta3fPUkOM+ic0MLqYYVAWDr20BJ8jZ5kGA7N
         4iq8NlcoAua0CuCgE3js5dnBNIn7GbXhzJ/7EBq4SpvdVs+DRiPch5NXG0UWrpE6eXo1
         Ngi53yogWL6sMehFky5bSuEWsRGYGIPG9KFtIbWttPT2L3R3GOJuAHAJh+a2w/UAru42
         GPf1Shy/Ms5YUV9SFvP/pb2xxRF3ex6w9c++h/jL+5/19qy1L2YDktgkPB8fc6LqmLRh
         ztTA==
X-Gm-Message-State: AAQBX9ctY7JM9eWFqM92l5FJX39NXM8SnmbBNikrw4ZYq+ifnLPvdsWI
        lzyE71+QlXwYHYKwVwIYplc=
X-Google-Smtp-Source: AKy350ZAeHpGUCdXlHdLQDMy+jjT5vSKjYSBKLPVnHj7nLodSXrgByyuFW5RSUr1YJawiRV3O/hw6A==
X-Received: by 2002:a5d:8a0c:0:b0:760:eaf6:59c6 with SMTP id w12-20020a5d8a0c000000b00760eaf659c6mr3331658iod.11.1682251982457;
        Sun, 23 Apr 2023 05:13:02 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:b473:5d7c:4c2:75d7])
        by smtp.gmail.com with ESMTPSA id u11-20020a02230b000000b00411a1373aa5sm1612155jau.155.2023.04.23.05.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 05:13:02 -0700 (PDT)
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
        Daniel Vetter <daniel@ffwll.ch>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 6/6] drm: bridge: samsung-dsim: Let blanking calcuation work in non-burst mode
Date:   Sun, 23 Apr 2023 07:12:32 -0500
Message-Id: <20230423121232.1345909-7-aford173@gmail.com>
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

The blanking calculation currently uses burst_clk_rate for calculating
the settings. Since it's possible to use this in non-burst mode, it's
possible that where won't be burst_clk_rate.  Instead, cache the
clock rate configured from of samsung_dsim_set_pll and use it instead.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 4 +++-
 include/drm/bridge/samsung-dsim.h     | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index cea847b8e23c..8c69d22a57b7 100644
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
index 25475d78adb3..41cbae00cd7e 100644
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

