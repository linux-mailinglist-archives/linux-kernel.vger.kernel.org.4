Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18566571C3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiL1Bs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiL1Bss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:48:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44513E60
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672192092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hx2zdSTlHmxb+hbHjQrVPjtZGZHukfcKpLvqATtqWSw=;
        b=H2YcC45L6frEoHEt26ldJZ5eESF2hPKlBajwLSp9BKOEROF88Kpte+6uRqvR84RQdg+2d3
        y3f5kbI/15qgyVA46B0YSP7UI5ldp6+z13v/QNKFrIQ+YeGMOj2lzVyZofiUoa7izYjxwo
        sc4hZV2oER1NrdyzpCDS38BDWAF/k8w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-48-9NoL5BkGO2WhVUza_SfPYA-1; Tue, 27 Dec 2022 20:48:10 -0500
X-MC-Unique: 9NoL5BkGO2WhVUza_SfPYA-1
Received: by mail-wm1-f69.google.com with SMTP id j1-20020a05600c1c0100b003d99070f529so1114122wms.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hx2zdSTlHmxb+hbHjQrVPjtZGZHukfcKpLvqATtqWSw=;
        b=NmLjckf8MHch2I1thUbojD+ySz2WrkGvORDGEDRyS9xquYvSyudd3PdPn9sBsWmWHW
         9L46FzlG7M3/LOTlkRYEzHGX4+IaGNDTLKPnRoQJZeigq0EykeUlNcV5ZK49LHJ3E1Sm
         U+TNQibQF0QdKzOt5j85zBv+XLDBMQmMvuDcy6R/XBbjv/9TX/fOjChga/AvY5ieehdi
         2xe0NBaZUYvahgopS97AHoi0vU8MrLwMEjV6KO4Qu1V5DXKdCllJVXOQLysDzdBYFD+9
         WgwGlqA8PtHyZEPYc/K7rik7TDZF+JrB6wwZUno42Xd0JuFNhFe04LWuMiY5mv1mhEUE
         FXPA==
X-Gm-Message-State: AFqh2kqZ96Iw+pY7fxzcMx/yx1HnAlwPRq9VmpEB3lMTsZAwWEQW8RYP
        JbM73HMWoME0zClVq8Ga7rRqOF5FjoExwxsHHRfo54Wdiio508Gc8EgttEq0AWHRXDXhdY3mNOq
        D+nAKiOk2SGiB10ZQl0SzWa69Fr/jCZrEL8tKVqMSGl/OXXchnNbGwH4/dN/Q9L63I5Lu/PVd5E
        A=
X-Received: by 2002:a05:600c:a51:b0:3d3:513c:240b with SMTP id c17-20020a05600c0a5100b003d3513c240bmr16354538wmq.7.1672192089434;
        Tue, 27 Dec 2022 17:48:09 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvTlRSdaGC3QhI/Azugg4WEuCuUG6bFFOv0Xr58DZtcrjSJCaH8fun4gBbvPnjQqnosKq5JBA==
X-Received: by 2002:a05:600c:a51:b0:3d3:513c:240b with SMTP id c17-20020a05600c0a5100b003d3513c240bmr16354518wmq.7.1672192089015;
        Tue, 27 Dec 2022 17:48:09 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b002258235bda3sm14158873wrx.61.2022.12.27.17.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:48:08 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Ondrej Jirman <megous@megous.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 03/14] drm/panel-sitronix-st7703: Drop custom DSI write macros
Date:   Wed, 28 Dec 2022 02:47:46 +0100
Message-Id: <20221228014757.3170486-4-javierm@redhat.com>
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

There are macros for these already in the <drm/drm_mipi_dsi.h> header, use
that instead and delete the custom DSI write macros defined in the driver.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 83 ++++++++-----------
 1 file changed, 33 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 86a472b01360..3e6655c2727e 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -73,14 +73,6 @@ static inline struct st7703 *panel_to_st7703(struct drm_panel *panel)
 	return container_of(panel, struct st7703, panel);
 }
 
-#define dsi_generic_write_seq(dsi, seq...) do {				\
-		static const u8 d[] = { seq };				\
-		int ret;						\
-		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static int jh057n_init_sequence(struct st7703 *ctx)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
@@ -90,27 +82,27 @@ static int jh057n_init_sequence(struct st7703 *ctx)
 	 * resemble the ST7703 but the number of parameters often don't match
 	 * so it's likely a clone.
 	 */
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETEXTC,
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETEXTC,
 			      0xF1, 0x12, 0x83);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETRGBIF,
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETRGBIF,
 			      0x10, 0x10, 0x05, 0x05, 0x03, 0xFF, 0x00, 0x00,
 			      0x00, 0x00);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETSCR,
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETSCR,
 			      0x73, 0x73, 0x50, 0x50, 0x00, 0x00, 0x08, 0x70,
 			      0x00);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETVDC, 0x4E);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETPANEL, 0x0B);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETCYC, 0x80);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETDISP, 0xF0, 0x12, 0x30);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETEQ,
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETVDC, 0x4E);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETPANEL, 0x0B);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETCYC, 0x80);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETDISP, 0xF0, 0x12, 0x30);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETEQ,
 			      0x07, 0x07, 0x0B, 0x0B, 0x03, 0x0B, 0x00, 0x00,
 			      0x00, 0x00, 0xFF, 0x00, 0xC0, 0x10);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETBGP, 0x08, 0x08);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETBGP, 0x08, 0x08);
 	msleep(20);
 
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETVCOM, 0x3F, 0x3F);
-	dsi_generic_write_seq(dsi, ST7703_CMD_UNKNOWN_BF, 0x02, 0x11, 0x00);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETGIP1,
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETVCOM, 0x3F, 0x3F);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_UNKNOWN_BF, 0x02, 0x11, 0x00);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETGIP1,
 			      0x82, 0x10, 0x06, 0x05, 0x9E, 0x0A, 0xA5, 0x12,
 			      0x31, 0x23, 0x37, 0x83, 0x04, 0xBC, 0x27, 0x38,
 			      0x0C, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00,
@@ -119,7 +111,7 @@ static int jh057n_init_sequence(struct st7703 *ctx)
 			      0x64, 0x20, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
 			      0x02, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETGIP2,
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETGIP2,
 			      0x02, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 			      0x00, 0x00, 0x00, 0x00, 0x02, 0x46, 0x02, 0x88,
 			      0x88, 0x88, 0x88, 0x88, 0x88, 0x64, 0x88, 0x13,
@@ -128,7 +120,7 @@ static int jh057n_init_sequence(struct st7703 *ctx)
 			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x0A,
 			      0xA5, 0x00, 0x00, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETGAMMA,
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_SETGAMMA,
 			      0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41, 0x37,
 			      0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10, 0x11,
 			      0x18, 0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41,
@@ -162,15 +154,6 @@ static const struct st7703_panel_desc jh057n00900_panel_desc = {
 	.init_sequence = jh057n_init_sequence,
 };
 
-#define dsi_dcs_write_seq(dsi, cmd, seq...) do {			\
-		static const u8 d[] = { seq };				\
-		int ret;						\
-		ret = mipi_dsi_dcs_write(dsi, cmd, d, ARRAY_SIZE(d));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
-
 static int xbd599_init_sequence(struct st7703 *ctx)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
@@ -180,9 +163,9 @@ static int xbd599_init_sequence(struct st7703 *ctx)
 	 */
 
 	/* Magic sequence to unlock user commands below. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETEXTC, 0xF1, 0x12, 0x83);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETEXTC, 0xF1, 0x12, 0x83);
 
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETMIPI,
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETMIPI,
 			  0x33, /* VC_main = 0, Lane_Number = 3 (4 lanes) */
 			  0x81, /* DSI_LDO_SEL = 1.7V, RTERM = 90 Ohm */
 			  0x05, /* IHSRX = x6 (Low High Speed driving ability) */
@@ -194,14 +177,14 @@ static int xbd599_init_sequence(struct st7703 *ctx)
 			  0x44, 0x25, 0x00, 0x91, 0x0a, 0x00, 0x00, 0x02,
 			  0x4F, 0x11, 0x00, 0x00, 0x37);
 
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETPOWER_EXT,
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETPOWER_EXT,
 			  0x25, /* PCCS = 2, ECP_DC_DIV = 1/4 HSYNC */
 			  0x22, /* DT = 15ms XDK_ECP = x2 */
 			  0x20, /* PFM_DC_DIV = /1 */
 			  0x03  /* ECP_SYNC_EN = 1, VGX_SYNC_EN = 1 */);
 
 	/* RGB I/F porch timing */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETRGBIF,
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETRGBIF,
 			  0x10, /* VBP_RGB_GEN */
 			  0x10, /* VFP_RGB_GEN */
 			  0x05, /* DE_BP_RGB_GEN */
@@ -212,7 +195,7 @@ static int xbd599_init_sequence(struct st7703 *ctx)
 			  0x00, 0x00);
 
 	/* Source driving settings. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETSCR,
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETSCR,
 			  0x73, /* N_POPON */
 			  0x73, /* N_NOPON */
 			  0x50, /* I_POPON */
@@ -224,19 +207,19 @@ static int xbd599_init_sequence(struct st7703 *ctx)
 			  0x00  /* Undocumented */);
 
 	/* NVDDD_SEL = -1.8V, VDDD_SEL = out of range (possibly 1.9V?) */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETVDC, 0x4E);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETVDC, 0x4E);
 
 	/*
 	 * SS_PANEL = 1 (reverse scan), GS_PANEL = 0 (normal scan)
 	 * REV_PANEL = 1 (normally black panel), BGR_PANEL = 1 (BGR)
 	 */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETPANEL, 0x0B);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETPANEL, 0x0B);
 
 	/* Zig-Zag Type C column inversion. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETCYC, 0x80);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETCYC, 0x80);
 
 	/* Set display resolution. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETDISP,
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETDISP,
 			  0xF0, /* NL = 240 */
 			  0x12, /* RES_V_LSB = 0, BLK_CON = VSSD,
 				 * RESO_SEL = 720RGB
@@ -246,7 +229,7 @@ static int xbd599_init_sequence(struct st7703 *ctx)
 				 * ISC = 0 frames
 				 */);
 
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETEQ,
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETEQ,
 			  0x00, /* PNOEQ */
 			  0x00, /* NNOEQ */
 			  0x0B, /* PEQGND */
@@ -267,9 +250,9 @@ static int xbd599_init_sequence(struct st7703 *ctx)
 				 */);
 
 	/* Undocumented command. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_UNKNOWN_C6, 0x01, 0x00, 0xFF, 0xFF, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_UNKNOWN_C6, 0x01, 0x00, 0xFF, 0xFF, 0x00);
 
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETPOWER,
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETPOWER,
 			  0x74, /* VBTHS, VBTLS: VGH = 17V, VBL = -11V */
 			  0x00, /* FBOFF_VGH = 0, FBOFF_VGL = 0 */
 			  0x32, /* VRP  */
@@ -287,20 +270,20 @@ static int xbd599_init_sequence(struct st7703 *ctx)
 			  0x77  /* VGH3_R_DIV, VGL3_R_DIV (4.5MHz) */);
 
 	/* Reference voltage. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETBGP,
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETBGP,
 			  0x07, /* VREF_SEL = 4.2V */
 			  0x07  /* NVREF_SEL = 4.2V */);
 	msleep(20);
 
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETVCOM,
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETVCOM,
 			  0x2C, /* VCOMDC_F = -0.67V */
 			  0x2C  /* VCOMDC_B = -0.67V */);
 
 	/* Undocumented command. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_UNKNOWN_BF, 0x02, 0x11, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_UNKNOWN_BF, 0x02, 0x11, 0x00);
 
 	/* This command is to set forward GIP timing. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETGIP1,
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETGIP1,
 			  0x82, 0x10, 0x06, 0x05, 0xA2, 0x0A, 0xA5, 0x12,
 			  0x31, 0x23, 0x37, 0x83, 0x04, 0xBC, 0x27, 0x38,
 			  0x0C, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00,
@@ -311,7 +294,7 @@ static int xbd599_init_sequence(struct st7703 *ctx)
 			  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
 
 	/* This command is to set backward GIP timing. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETGIP2,
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETGIP2,
 			  0x02, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 			  0x00, 0x00, 0x00, 0x00, 0x02, 0x46, 0x02, 0x88,
 			  0x88, 0x88, 0x88, 0x88, 0x88, 0x64, 0x88, 0x13,
@@ -322,7 +305,7 @@ static int xbd599_init_sequence(struct st7703 *ctx)
 			  0xA5, 0x00, 0x00, 0x00, 0x00);
 
 	/* Adjust the gamma characteristics of the panel. */
-	dsi_dcs_write_seq(dsi, ST7703_CMD_SETGAMMA,
+	mipi_dsi_dcs_write_seq(dsi, ST7703_CMD_SETGAMMA,
 			  0x00, 0x09, 0x0D, 0x23, 0x27, 0x3C, 0x41, 0x35,
 			  0x07, 0x0D, 0x0E, 0x12, 0x13, 0x10, 0x12, 0x12,
 			  0x18, 0x00, 0x09, 0x0D, 0x23, 0x27, 0x3C, 0x41,
@@ -499,7 +482,7 @@ static int allpixelson_set(void *data, u64 val)
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 
 	dev_dbg(ctx->dev, "Setting all pixels on\n");
-	dsi_generic_write_seq(dsi, ST7703_CMD_ALL_PIXEL_ON);
+	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_ALL_PIXEL_ON);
 	msleep(val * 1000);
 	/* Reset the panel to get video back */
 	drm_panel_disable(&ctx->panel);
-- 
2.38.1

