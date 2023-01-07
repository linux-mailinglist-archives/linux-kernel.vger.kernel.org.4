Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D0366115B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 20:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbjAGTVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 14:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjAGTUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 14:20:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F61635909
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 11:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673119131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=deWthXcTON7t66x4tziVex8yFWTz8gUPIMDdjgbvK2o=;
        b=btgXEsg5oPnkuqAaj4XDZGn78EO6e+cwY7HJCOceZjZvFn6eCNjvhZoQ/uN28zsq2OG3qs
        cOEsAyK6rs7qzXHzFYNxfdQpknjfi6lIne2DKj9Opwnsoa9UyrQoFHqpt3Ejk1nMgF7V6a
        /zC1Edz620K5na/y+RptGCbbYHzyTnI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-448-gtetOsVRMy6rbLmppY4KCw-1; Sat, 07 Jan 2023 14:18:50 -0500
X-MC-Unique: gtetOsVRMy6rbLmppY4KCw-1
Received: by mail-wm1-f69.google.com with SMTP id l17-20020a05600c1d1100b003d9a145366cso2712359wms.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 11:18:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deWthXcTON7t66x4tziVex8yFWTz8gUPIMDdjgbvK2o=;
        b=SIIsYcZUGulkKzb3C5pKRUiXvQFAlSgE+OMcRT1BJ0PvFkMCHTrnJaxRBt9rcYKysP
         xmFRqJjThQY4awRZEew0Vnihg99a6uAW4kcPNX00gVOHY5bIBYa5mQC9UayRPkjbWj8d
         gZNN2ml0jpxfTHN+KC0KOvMkszRIwlezc7fDrts9sKsNLIESSV6mSwxwODYVMErCdSzE
         FyrEPZJ1I7BxxKaumg4Y2sAWg2PTnXktc/fRlsNCTs3x4pAdvpi39BTkw4DhadwryEOI
         ViSSWFeGWh52WhI8VJJC1gXdcMg15/xma7OBzp/Gp0+oGu/rgxGSlTOnG4zjFOrjUZfA
         RmMA==
X-Gm-Message-State: AFqh2kqh9QyaRT4xve/uiR2BTPK02groXj3LeeVih8AZD3FhuIDguKn1
        uEL8L8IU7AaVyMplkpbgKboZ8JTHTenSKPOddRcjJRGauFFB+YEkwEbqDiZHvspjHCdype1qo/L
        yEtMZSDY6zdlKLllcAdbQFvserenEMc5v7onpem/jXmpA73Uf7HqtCJGet1EiNKsJt80QNSgrGq
        o=
X-Received: by 2002:a5d:5910:0:b0:27c:7c2a:f700 with SMTP id v16-20020a5d5910000000b0027c7c2af700mr25242863wrd.8.1673119128649;
        Sat, 07 Jan 2023 11:18:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsGBkBD1CsnybBCNLEDbnkha+PRHO1FTA17G+lmd3rkuDh20smPXVuDqRUNb1X9pNidHM51Ig==
X-Received: by 2002:a5d:5910:0:b0:27c:7c2a:f700 with SMTP id v16-20020a5d5910000000b0027c7c2af700mr25242852wrd.8.1673119128415;
        Sat, 07 Jan 2023 11:18:48 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bp28-20020a5d5a9c000000b00273cd321a1bsm4553900wrb.107.2023.01.07.11.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:18:47 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 13/13] drm/panel-xinpeng-xpp055c272: Drop custom DSI write macro
Date:   Sat,  7 Jan 2023 20:18:22 +0100
Message-Id: <20230107191822.3787147-14-javierm@redhat.com>
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

There is a macro for this already in the <drm/drm_mipi_dsi.h> header, use
that instead and delete the custom DSI write macro defined in the driver.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v2:
- Add Sam Ravnborg's Reviewed-by tag.
- Fix identation on macro usage (Sam Ravnborg).
- Fix generic DSI and DCS commands write discrepancy (Sam Ravnborg).

 .../gpu/drm/panel/panel-xinpeng-xpp055c272.c  | 112 ++++++++----------
 1 file changed, 52 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c b/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
index 2c54733ee241..8670386498a4 100644
--- a/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
+++ b/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
@@ -60,14 +60,6 @@ static inline struct xpp055c272 *panel_to_xpp055c272(struct drm_panel *panel)
 	return container_of(panel, struct xpp055c272, panel);
 }
 
-#define dsi_generic_write_seq(dsi, cmd, seq...) do {			\
-		static const u8 b[] = { cmd, seq };			\
-		int ret;						\
-		ret = mipi_dsi_dcs_write_buffer(dsi, b, ARRAY_SIZE(b));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static int xpp055c272_init_sequence(struct xpp055c272 *ctx)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
@@ -77,60 +69,60 @@ static int xpp055c272_init_sequence(struct xpp055c272 *ctx)
 	 * Init sequence was supplied by the panel vendor without much
 	 * documentation.
 	 */
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETEXTC, 0xf1, 0x12, 0x83);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETMIPI,
-			      0x33, 0x81, 0x05, 0xf9, 0x0e, 0x0e, 0x00, 0x00,
-			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x25,
-			      0x00, 0x91, 0x0a, 0x00, 0x00, 0x02, 0x4f, 0x01,
-			      0x00, 0x00, 0x37);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETPOWER_EXT, 0x25);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETPCR, 0x02, 0x11, 0x00);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETRGBIF,
-			      0x0c, 0x10, 0x0a, 0x50, 0x03, 0xff, 0x00, 0x00,
-			      0x00, 0x00);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETSCR,
-			      0x73, 0x73, 0x50, 0x50, 0x00, 0x00, 0x08, 0x70,
-			      0x00);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETVDC, 0x46);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETPANEL, 0x0b);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETCYC, 0x80);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETDISP, 0xc8, 0x12, 0x30);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETEQ,
-			      0x07, 0x07, 0x0B, 0x0B, 0x03, 0x0B, 0x00, 0x00,
-			      0x00, 0x00, 0xFF, 0x00, 0xC0, 0x10);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETPOWER,
-			      0x53, 0x00, 0x1e, 0x1e, 0x77, 0xe1, 0xcc, 0xdd,
-			      0x67, 0x77, 0x33, 0x33);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETECO, 0x00, 0x00, 0xff,
-			      0xff, 0x01, 0xff);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETBGP, 0x09, 0x09);
+	mipi_dsi_dcs_write_seq(dsi, XPP055C272_CMD_SETEXTC, 0xf1, 0x12, 0x83);
+	mipi_dsi_dcs_write_seq(dsi, XPP055C272_CMD_SETMIPI,
+			       0x33, 0x81, 0x05, 0xf9, 0x0e, 0x0e, 0x00, 0x00,
+			       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x25,
+			       0x00, 0x91, 0x0a, 0x00, 0x00, 0x02, 0x4f, 0x01,
+			       0x00, 0x00, 0x37);
+	mipi_dsi_dcs_write_seq(dsi, XPP055C272_CMD_SETPOWER_EXT, 0x25);
+	mipi_dsi_dcs_write_seq(dsi, XPP055C272_CMD_SETPCR, 0x02, 0x11, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, XPP055C272_CMD_SETRGBIF,
+			       0x0c, 0x10, 0x0a, 0x50, 0x03, 0xff, 0x00, 0x00,
+			       0x00, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, XPP055C272_CMD_SETSCR,
+			       0x73, 0x73, 0x50, 0x50, 0x00, 0x00, 0x08, 0x70,
+			       0x00);
+	mipi_dsi_dcs_write_seq(dsi, XPP055C272_CMD_SETVDC, 0x46);
+	mipi_dsi_dcs_write_seq(dsi, XPP055C272_CMD_SETPANEL, 0x0b);
+	mipi_dsi_dcs_write_seq(dsi, XPP055C272_CMD_SETCYC, 0x80);
+	mipi_dsi_dcs_write_seq(dsi, XPP055C272_CMD_SETDISP, 0xc8, 0x12, 0x30);
+	mipi_dsi_dcs_write_seq(dsi, XPP055C272_CMD_SETEQ,
+			       0x07, 0x07, 0x0B, 0x0B, 0x03, 0x0B, 0x00, 0x00,
+			       0x00, 0x00, 0xFF, 0x00, 0xC0, 0x10);
+	mipi_dsi_dcs_write_seq(dsi, XPP055C272_CMD_SETPOWER,
+			       0x53, 0x00, 0x1e, 0x1e, 0x77, 0xe1, 0xcc, 0xdd,
+			       0x67, 0x77, 0x33, 0x33);
+	mipi_dsi_dcs_write_seq(dsi, XPP055C272_CMD_SETECO, 0x00, 0x00, 0xff,
+			       0xff, 0x01, 0xff);
+	mipi_dsi_dcs_write_seq(dsi, XPP055C272_CMD_SETBGP, 0x09, 0x09);
 	msleep(20);
 
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETVCOM, 0x87, 0x95);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETGIP1,
-			      0xc2, 0x10, 0x05, 0x05, 0x10, 0x05, 0xa0, 0x12,
-			      0x31, 0x23, 0x3f, 0x81, 0x0a, 0xa0, 0x37, 0x18,
-			      0x00, 0x80, 0x01, 0x00, 0x00, 0x00, 0x00, 0x80,
-			      0x01, 0x00, 0x00, 0x00, 0x48, 0xf8, 0x86, 0x42,
-			      0x08, 0x88, 0x88, 0x80, 0x88, 0x88, 0x88, 0x58,
-			      0xf8, 0x87, 0x53, 0x18, 0x88, 0x88, 0x81, 0x88,
-			      0x88, 0x88, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
-			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETGIP2,
-			      0x00, 0x1a, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00,
-			      0x00, 0x00, 0x00, 0x00, 0x1f, 0x88, 0x81, 0x35,
-			      0x78, 0x88, 0x88, 0x85, 0x88, 0x88, 0x88, 0x0f,
-			      0x88, 0x80, 0x24, 0x68, 0x88, 0x88, 0x84, 0x88,
-			      0x88, 0x88, 0x23, 0x10, 0x00, 0x00, 0x1c, 0x00,
-			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x05,
-			      0xa0, 0x00, 0x00, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETGAMMA,
-			      0x00, 0x06, 0x08, 0x2a, 0x31, 0x3f, 0x38, 0x36,
-			      0x07, 0x0c, 0x0d, 0x11, 0x13, 0x12, 0x13, 0x11,
-			      0x18, 0x00, 0x06, 0x08, 0x2a, 0x31, 0x3f, 0x38,
-			      0x36, 0x07, 0x0c, 0x0d, 0x11, 0x13, 0x12, 0x13,
-			      0x11, 0x18);
+	mipi_dsi_dcs_write_seq(dsi, XPP055C272_CMD_SETVCOM, 0x87, 0x95);
+	mipi_dsi_dcs_write_seq(dsi, XPP055C272_CMD_SETGIP1,
+			       0xc2, 0x10, 0x05, 0x05, 0x10, 0x05, 0xa0, 0x12,
+			       0x31, 0x23, 0x3f, 0x81, 0x0a, 0xa0, 0x37, 0x18,
+			       0x00, 0x80, 0x01, 0x00, 0x00, 0x00, 0x00, 0x80,
+			       0x01, 0x00, 0x00, 0x00, 0x48, 0xf8, 0x86, 0x42,
+			       0x08, 0x88, 0x88, 0x80, 0x88, 0x88, 0x88, 0x58,
+			       0xf8, 0x87, 0x53, 0x18, 0x88, 0x88, 0x81, 0x88,
+			       0x88, 0x88, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
+			       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, XPP055C272_CMD_SETGIP2,
+			       0x00, 0x1a, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00,
+			       0x00, 0x00, 0x00, 0x00, 0x1f, 0x88, 0x81, 0x35,
+			       0x78, 0x88, 0x88, 0x85, 0x88, 0x88, 0x88, 0x0f,
+			       0x88, 0x80, 0x24, 0x68, 0x88, 0x88, 0x84, 0x88,
+			       0x88, 0x88, 0x23, 0x10, 0x00, 0x00, 0x1c, 0x00,
+			       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x05,
+			       0xa0, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, XPP055C272_CMD_SETGAMMA,
+			       0x00, 0x06, 0x08, 0x2a, 0x31, 0x3f, 0x38, 0x36,
+			       0x07, 0x0c, 0x0d, 0x11, 0x13, 0x12, 0x13, 0x11,
+			       0x18, 0x00, 0x06, 0x08, 0x2a, 0x31, 0x3f, 0x38,
+			       0x36, 0x07, 0x0c, 0x0d, 0x11, 0x13, 0x12, 0x13,
+			       0x11, 0x18);
 
 	msleep(60);
 
-- 
2.38.1

