Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ABD6EBF3D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 14:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjDWMND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 08:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDWMM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 08:12:57 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0BC10C9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 05:12:54 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-763c3429aa6so28890939f.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 05:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682251974; x=1684843974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTAw7F03HuAr0OI8IRjYA7Odta6kZ/yszj+u/BSAuPo=;
        b=REgwWBSRFUiIEK9qwudRmoDNqt33mzgWRpmSeTuO2i/B46etyi8vK2RjYE9C13aKph
         ZyKhanQ0+t1Z8fBqUULDvdIolx+0Fxu8moCOZsKPN5GgUj5g1viY7TQiMiwUA5v1Shwr
         5tfFcNnPlsA+19dAYi5OAxfGbC53Oedw2SC09NpWcmDpQ4Vste76HhxFcxE9QVh4xNcp
         xl26AtEqF+gEmpzevyNYf2RE5yEx3g9g1RdErKJbwGG4tw86WWFFHyZfzm0wpdw0HhTS
         Otc5B5oJZ0pHrEVL7mOkHAVWvPhV4zL+UvE96ikTJo92Wnjw1sR3QGnl63CHt1w0M0DF
         TlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682251974; x=1684843974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTAw7F03HuAr0OI8IRjYA7Odta6kZ/yszj+u/BSAuPo=;
        b=C+cFyASwnxmAFk2wpWZXB+dXPCHTFaW6OObSRRuvDu8ey9cxYcz7zsLOGTbiWdyTvu
         XYN0rbGi4vCtrJeihF8g8BWiws9X9SRGXtdQDA8xKGPEm9oFE1ajN2UJLV6MHyo3plKE
         MJ8e2YxgbyaVHPkZ2jgPO/8BlA+IC3ubeXtqYKns6zMgLx3gCe+bf5tt1pniqEIsTHGs
         D9b7MJOUoGke4IdetMdIFqgWZDhqQZ/Yf9saDhtMTvvMCO4LgZi0ri9fOubY1+8GPdSn
         HePdD+ug0rNwIukNnIvXBr6CCXvQB4s1zk+HxyVlZARL5GW0WcDqOn+ozHGoG/lqOujG
         WU1w==
X-Gm-Message-State: AAQBX9cTds6DYtBAqITtcfEZBogsPqzie+ZswTzc1kG6Oj4h6XQnFvBb
        pYzwFm44eBhFGBGTsK5+izo=
X-Google-Smtp-Source: AKy350b4IsmOmc2kdOlEa4VZcUd9HynWDxOz89lLecHxdvuNlqnpR4ecObEj/S+7bd3uBqX33WJ1vw==
X-Received: by 2002:a6b:7617:0:b0:74d:771:6ed5 with SMTP id g23-20020a6b7617000000b0074d07716ed5mr3107823iom.21.1682251974106;
        Sun, 23 Apr 2023 05:12:54 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:b473:5d7c:4c2:75d7])
        by smtp.gmail.com with ESMTPSA id u11-20020a02230b000000b00411a1373aa5sm1612155jau.155.2023.04.23.05.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 05:12:53 -0700 (PDT)
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
Subject: [PATCH V2 1/6] drm: bridge: samsung-dsim: fix blanking packet size calculation
Date:   Sun, 23 Apr 2023 07:12:27 -0500
Message-Id: <20230423121232.1345909-2-aford173@gmail.com>
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

From: Lucas Stach <l.stach@pengutronix.de>

Scale the blanking packet sizes to match the ratio between HS clock
and DPI interface clock. The controller seems to do internal scaling
to the number of active lanes, so we don't take those into account.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Adam Ford <aford173@gmail.com>
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

