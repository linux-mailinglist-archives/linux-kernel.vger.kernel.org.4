Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5606571D5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiL1BuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiL1Btf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:49:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8271005
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672192101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lU6VOUG1vSrY2tpqFwz0Ej2kvheVmIlXVmdfOeOCkyw=;
        b=GQzqP9FQJjJVYKhkVYY4B6l8FOhbm8pWnudUSY9Ujf1wjC1czr/IiGKBo8Lw7VZRaTi8Tz
        KxF8PBI1ahM78keleONEGB45v4DoVi0gr3IxnVvqbAFjMjZ2Wnng1MoIZ4EBSLxK/LTRGP
        MurRtYc/AUwbeGKH5IWpKQETZxTiyRI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-356-vTvclH96PWm6Ke5CkmhAaA-1; Tue, 27 Dec 2022 20:48:19 -0500
X-MC-Unique: vTvclH96PWm6Ke5CkmhAaA-1
Received: by mail-wm1-f70.google.com with SMTP id bg10-20020a05600c3c8a00b003d9717d882eso6800885wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lU6VOUG1vSrY2tpqFwz0Ej2kvheVmIlXVmdfOeOCkyw=;
        b=SIWQ71bVYM9xjV4xzwqjZ6iZ0QJs4LFcM7RwomB4wFenPQJRfpr2LUiVpFno1DAepr
         aGkiPYdhBpDp9FPa0GY1Ex2eUvfdgAX46+1iLOqfO+BG4fGh1+YmVWMcy2I8bA/RohI0
         x3skDOw9pHY2qZMghttwBCJossND9HruOSWyQ+XGSlGXuMSzTLKcqwFe0OSjz8Vld9Ys
         GjCs6T604gsJ2EIM2I8wo3yJDgJVD8U9i+i3YM0jsJdPrJhqRv0D/gIuXLi4yiZ0dG3I
         muLEniNP3+2JG2FRs/CpeJflko8mNdP/2O7vAMVCAdAYeFL8DfaeI6snKG5TZcO8mU1i
         wQ9w==
X-Gm-Message-State: AFqh2kpgE5dTEaHK71SY36uJj2whQKmfHvSWTjE6wvihs/GQ7ip65XL0
        bcivanlkaIOAbjFd2c9QOQ7ZzBM9Ud5Oz0c/hraIqltdReAnXvcFdSz+aiM5czQ/molv9kltvo3
        RybLcqtyn8orbi5F3kI4UwKLjx121DCi3FaiA5HgP2/0r9pTKYqfnr3AQYLgk6rVVBq0kBdXygw
        g=
X-Received: by 2002:adf:9b99:0:b0:241:fa2d:dea0 with SMTP id d25-20020adf9b99000000b00241fa2ddea0mr14018196wrc.3.1672192098242;
        Tue, 27 Dec 2022 17:48:18 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtFinSDNvZD1/lFP5JuaVSl0nj8OZdwp1w6kixV9ufXdaQQ+vqUKiQuRf6PKWrFwFLIszkKlw==
X-Received: by 2002:adf:9b99:0:b0:241:fa2d:dea0 with SMTP id d25-20020adf9b99000000b00241fa2ddea0mr14018183wrc.3.1672192097961;
        Tue, 27 Dec 2022 17:48:17 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b002258235bda3sm14158873wrx.61.2022.12.27.17.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:48:17 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 10/14] drm/panel-samsung-sofef00: Drop custom DSI write macro
Date:   Wed, 28 Dec 2022 02:47:53 +0100
Message-Id: <20221228014757.3170486-11-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221228014757.3170486-1-javierm@redhat.com>
References: <20221228014757.3170486-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a macro for this already in the <drm/drm_mipi_dsi.h> header, use
that instead and delete the custom DSI write macro defined in the driver.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/panel/panel-samsung-sofef00.c | 24 +++++++------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-sofef00.c b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
index 1a0d24595faa..9db49a028930 100644
--- a/drivers/gpu/drm/panel/panel-samsung-sofef00.c
+++ b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
@@ -34,14 +34,6 @@ struct sofef00_panel *to_sofef00_panel(struct drm_panel *panel)
 	return container_of(panel, struct sofef00_panel, panel);
 }
 
-#define dsi_dcs_write_seq(dsi, seq...) do {				\
-		static const u8 d[] = { seq };				\
-		int ret;						\
-		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static void sofef00_panel_reset(struct sofef00_panel *ctx)
 {
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
@@ -67,7 +59,7 @@ static int sofef00_panel_on(struct sofef00_panel *ctx)
 	}
 	usleep_range(10000, 11000);
 
-	dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
 
 	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
 	if (ret < 0) {
@@ -75,13 +67,13 @@ static int sofef00_panel_on(struct sofef00_panel *ctx)
 		return ret;
 	}
 
-	dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
-	dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
-	dsi_dcs_write_seq(dsi, 0xb0, 0x07);
-	dsi_dcs_write_seq(dsi, 0xb6, 0x12);
-	dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
-	dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x20);
-	dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
+	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq(dsi, 0xb0, 0x07);
+	mipi_dsi_dcs_write_seq(dsi, 0xb6, 0x12);
+	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x20);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
 
 	ret = mipi_dsi_dcs_set_display_on(dsi);
 	if (ret < 0) {
-- 
2.38.1

