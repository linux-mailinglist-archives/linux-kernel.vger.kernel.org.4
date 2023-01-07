Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105C7661155
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 20:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjAGTUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 14:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjAGTUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 14:20:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5E835903
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 11:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673119123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ttV0XcYX1fJWmH88XgdEow2vXwmHcFArdkGg5SIJWK0=;
        b=OiTJ9ZFL6J0Lsiryo58+1EBxFerPMw5BM8jm6BZmNmu91RmWyuGLQxitsI4TKRZf4KEJR7
        RtlmBXvJuo3yc/a09BJA3DszSLbhGZfpKgRHYH+nRdku2fvqdwRMzhq/3HMLylvaOfKq2s
        CrzLns/EbkDt3p3P3aJRt6PwDhf8uwE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-328-l9OQrE2PPmW1qhbHS_A6JQ-1; Sat, 07 Jan 2023 14:18:42 -0500
X-MC-Unique: l9OQrE2PPmW1qhbHS_A6JQ-1
Received: by mail-wm1-f71.google.com with SMTP id c66-20020a1c3545000000b003d355c13229so4660700wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 11:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttV0XcYX1fJWmH88XgdEow2vXwmHcFArdkGg5SIJWK0=;
        b=eU0XHdcK9lCew43upxbVwvANYQWDLq1nwMH8iQMhcWm6dKZ4x5A36skBt3FVCMi6cn
         jqTMTFsf8RgsZmE6auIiwckWnr0SgrjiPNn6Zhcm36t2ezcxEoruoCCh6aqtGPh1qQTS
         szYXvXebmg8f6QMtGX8+tFCPXmp7tyjRsRWgeWCVvVRrtsZiZrlFBqpvKSBus/4Psmxo
         WeXfOz7m61H1uE640CUJOsy6jpPlus4U4Poy+JL4pXEcihoKwFVQPMjku8JvZ+n90EYo
         bbaNUVh7DuEWNqNm8uPqmhOUjQVVqJIOD4aVi4ihYCM9IjumqeUcdXk9zDyBRlus7BOO
         sMbg==
X-Gm-Message-State: AFqh2krebq3X0ZEa4FfVvYU2jeWnBsYunaWfB+zXi4PZ3MQuZ6A3VmTA
        2pgxGs5jI7Y+I4cnvsha3185MKrqgHn55+3r28QQEkRGRPlVmXCa9BJD6XKKQeQS+smvfJ5YFdD
        jCedaQdGxSW0/iw/Y+JzUvJ2Gj9JvEKGD2kYxCe/zr7qKe5Ilhz0pIbB3pRItmFKD0ZOkKsSwVw
        g=
X-Received: by 2002:a05:600c:3506:b0:3cf:803b:d7cc with SMTP id h6-20020a05600c350600b003cf803bd7ccmr45486000wmq.33.1673119120736;
        Sat, 07 Jan 2023 11:18:40 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsqRumGFiFSh2jflHPYUHsPzJdMy9PeAGY0Mpa8khexDGjR9FKqpABGnvJs8fvLrfT0jXlJ6w==
X-Received: by 2002:a05:600c:3506:b0:3cf:803b:d7cc with SMTP id h6-20020a05600c350600b003cf803bd7ccmr45485988wmq.33.1673119120509;
        Sat, 07 Jan 2023 11:18:40 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bp28-20020a5d5a9c000000b00273cd321a1bsm4553900wrb.107.2023.01.07.11.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:18:40 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 07/13] drm/panel-jdi-fhd-r63452: Drop custom DSI write macros
Date:   Sat,  7 Jan 2023 20:18:16 +0100
Message-Id: <20230107191822.3787147-8-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230107191822.3787147-1-javierm@redhat.com>
References: <20230107191822.3787147-1-javierm@redhat.com>
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

There are macros for these already in the <drm/drm_mipi_dsi.h> header, use
that instead and delete the custom DSI write macros defined in the driver.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v2:
- Add Sam Ravnborg's Reviewed-by tag.
- Fix identation on macro usage (Sam Ravnborg).

 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 58 +++++++-------------
 1 file changed, 21 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
index d8765b2294fb..8912757a6f42 100644
--- a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
+++ b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
@@ -29,22 +29,6 @@ static inline struct jdi_fhd_r63452 *to_jdi_fhd_r63452(struct drm_panel *panel)
 	return container_of(panel, struct jdi_fhd_r63452, panel);
 }
 
-#define dsi_generic_write_seq(dsi, seq...) do {				\
-		static const u8 d[] = { seq };				\
-		int ret;						\
-		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
-#define dsi_dcs_write_seq(dsi, seq...) do {				\
-		static const u8 d[] = { seq };				\
-		int ret;						\
-		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static void jdi_fhd_r63452_reset(struct jdi_fhd_r63452 *ctx)
 {
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
@@ -63,12 +47,12 @@ static int jdi_fhd_r63452_on(struct jdi_fhd_r63452 *ctx)
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	dsi_generic_write_seq(dsi, 0xb0, 0x00);
-	dsi_generic_write_seq(dsi, 0xd6, 0x01);
-	dsi_generic_write_seq(dsi, 0xec,
-			      0x64, 0xdc, 0xec, 0x3b, 0x52, 0x00, 0x0b, 0x0b,
-			      0x13, 0x15, 0x68, 0x0b, 0xb5);
-	dsi_generic_write_seq(dsi, 0xb0, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xd6, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xec,
+				   0x64, 0xdc, 0xec, 0x3b, 0x52, 0x00, 0x0b, 0x0b,
+				   0x13, 0x15, 0x68, 0x0b, 0xb5);
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x03);
 
 	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
 	if (ret < 0) {
@@ -76,7 +60,7 @@ static int jdi_fhd_r63452_on(struct jdi_fhd_r63452 *ctx)
 		return ret;
 	}
 
-	dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
 
 	ret = mipi_dsi_dcs_set_pixel_format(dsi, 0x77);
 	if (ret < 0) {
@@ -108,10 +92,10 @@ static int jdi_fhd_r63452_on(struct jdi_fhd_r63452 *ctx)
 		return ret;
 	}
 
-	dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24);
-	dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
-	dsi_dcs_write_seq(dsi, MIPI_DCS_SET_CABC_MIN_BRIGHTNESS, 0x00);
-	dsi_dcs_write_seq(dsi, 0x84, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_CABC_MIN_BRIGHTNESS, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0x84, 0x00);
 
 	ret = mipi_dsi_dcs_set_display_on(dsi);
 	if (ret < 0) {
@@ -127,10 +111,10 @@ static int jdi_fhd_r63452_on(struct jdi_fhd_r63452 *ctx)
 	}
 	msleep(80);
 
-	dsi_generic_write_seq(dsi, 0xb0, 0x04);
-	dsi_dcs_write_seq(dsi, 0x84, 0x00);
-	dsi_generic_write_seq(dsi, 0xc8, 0x11);
-	dsi_generic_write_seq(dsi, 0xb0, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x04);
+	mipi_dsi_dcs_write_seq(dsi, 0x84, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xc8, 0x11);
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x03);
 
 	return 0;
 }
@@ -143,12 +127,12 @@ static int jdi_fhd_r63452_off(struct jdi_fhd_r63452 *ctx)
 
 	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
-	dsi_generic_write_seq(dsi, 0xb0, 0x00);
-	dsi_generic_write_seq(dsi, 0xd6, 0x01);
-	dsi_generic_write_seq(dsi, 0xec,
-			      0x64, 0xdc, 0xec, 0x3b, 0x52, 0x00, 0x0b, 0x0b,
-			      0x13, 0x15, 0x68, 0x0b, 0x95);
-	dsi_generic_write_seq(dsi, 0xb0, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xd6, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xec,
+				   0x64, 0xdc, 0xec, 0x3b, 0x52, 0x00, 0x0b, 0x0b,
+				   0x13, 0x15, 0x68, 0x0b, 0x95);
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x03);
 
 	ret = mipi_dsi_dcs_set_display_off(dsi);
 	if (ret < 0) {
-- 
2.38.1

