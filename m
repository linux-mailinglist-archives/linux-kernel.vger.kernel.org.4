Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788506571D9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiL1Bu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiL1Btv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:49:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D30116C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672192106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eFLyXnnWWLV2WFqSFA8goZjk6zRci0Sl+99Zm9465ac=;
        b=KZFkt8vPoSlEgrrNN4w1D+L0NVLdfHo6k+F8/+hmBureEwP+blxaOXap8pQ/8Ku6Ko/ckE
        gE5xZ1YalM9HBO7yFYSJq0iceukm/kXMUbIg4VTf48RujctmQPzBGTZdQg/QFieLm5/uag
        ybEwm7FxJ4zmS2KSDJ7rjQK39F1vQ1g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-468-5Ncr2JdUPJKrzj4xNOeI3Q-1; Tue, 27 Dec 2022 20:48:25 -0500
X-MC-Unique: 5Ncr2JdUPJKrzj4xNOeI3Q-1
Received: by mail-wm1-f72.google.com with SMTP id m7-20020a05600c4f4700b003d971a5e770so5557142wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFLyXnnWWLV2WFqSFA8goZjk6zRci0Sl+99Zm9465ac=;
        b=dDVvCV985Q0AUOAKH5dixjADAQYbdQ1UAaTlAeD7+AVO3vUFkJ1dNt97wF+oMR9Amv
         N0LJqvsIIE8AsrRiaOfGty4PqYYdIdYeQknsnE4fPrEQdZUMLadQqQg/CIORKcNDuTro
         OeLYcD0d2aArawJy5K7uxHYV/2Qqeg1TcPHOJ3bVr7aBVLJnW7qX4/x3OJg3viTpmSUu
         j7o04TFjIxhWFOkmZOJGNp6F6xOYSDG4xYDPFmMM/l63wYWgoU2l2YQHf2PaX3kZH15m
         brPS0TYGbZd5lOP7P2jYOdfj+MgE/+UMzjQJpTU4uECStgIIA8+f82ZFQUgZwrReVFIw
         89Hg==
X-Gm-Message-State: AFqh2krDOxdLiXHJKqBRUd1GYRH8uQbSvzZBmT2if8e/ysEb3nGn94iO
        YhMy3Sk+FhtyL5IF/94pxwA36vbfCN96lNBaHFxZOoQgcE5PSQiLMp4FXKNs/CSd987A9zJcPnM
        mc7BRyc6AJZT+OVix8JP6r0ZksEbgkc62EAeRX3UCNWUce5TcC66JUFZNFo8FXUMpRQ75L/Dk+7
        I=
X-Received: by 2002:adf:f243:0:b0:26d:798f:ab8a with SMTP id b3-20020adff243000000b0026d798fab8amr12795233wrp.68.1672192103644;
        Tue, 27 Dec 2022 17:48:23 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvN08ikHqxEdwe0XuYcR9XedLDUgccllFpcGIC3jMI8Eb83v8+q0wvMG7cAIKpa5v3FBH8MNA==
X-Received: by 2002:adf:f243:0:b0:26d:798f:ab8a with SMTP id b3-20020adff243000000b0026d798fab8amr12795224wrp.68.1672192103369;
        Tue, 27 Dec 2022 17:48:23 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b002258235bda3sm14158873wrx.61.2022.12.27.17.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:48:22 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 14/14] drm/panel-xinpeng-xpp055c272: Drop custom DSI write macro
Date:   Wed, 28 Dec 2022 02:47:57 +0100
Message-Id: <20221228014757.3170486-15-javierm@redhat.com>
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

 .../gpu/drm/panel/panel-xinpeng-xpp055c272.c  | 44 ++++++++-----------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c b/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
index 2c54733ee241..230d87ba139a 100644
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
@@ -77,37 +69,37 @@ static int xpp055c272_init_sequence(struct xpp055c272 *ctx)
 	 * Init sequence was supplied by the panel vendor without much
 	 * documentation.
 	 */
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETEXTC, 0xf1, 0x12, 0x83);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETMIPI,
+	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETEXTC, 0xf1, 0x12, 0x83);
+	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETMIPI,
 			      0x33, 0x81, 0x05, 0xf9, 0x0e, 0x0e, 0x00, 0x00,
 			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x25,
 			      0x00, 0x91, 0x0a, 0x00, 0x00, 0x02, 0x4f, 0x01,
 			      0x00, 0x00, 0x37);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETPOWER_EXT, 0x25);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETPCR, 0x02, 0x11, 0x00);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETRGBIF,
+	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETPOWER_EXT, 0x25);
+	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETPCR, 0x02, 0x11, 0x00);
+	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETRGBIF,
 			      0x0c, 0x10, 0x0a, 0x50, 0x03, 0xff, 0x00, 0x00,
 			      0x00, 0x00);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETSCR,
+	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETSCR,
 			      0x73, 0x73, 0x50, 0x50, 0x00, 0x00, 0x08, 0x70,
 			      0x00);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETVDC, 0x46);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETPANEL, 0x0b);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETCYC, 0x80);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETDISP, 0xc8, 0x12, 0x30);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETEQ,
+	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETVDC, 0x46);
+	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETPANEL, 0x0b);
+	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETCYC, 0x80);
+	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETDISP, 0xc8, 0x12, 0x30);
+	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETEQ,
 			      0x07, 0x07, 0x0B, 0x0B, 0x03, 0x0B, 0x00, 0x00,
 			      0x00, 0x00, 0xFF, 0x00, 0xC0, 0x10);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETPOWER,
+	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETPOWER,
 			      0x53, 0x00, 0x1e, 0x1e, 0x77, 0xe1, 0xcc, 0xdd,
 			      0x67, 0x77, 0x33, 0x33);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETECO, 0x00, 0x00, 0xff,
+	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETECO, 0x00, 0x00, 0xff,
 			      0xff, 0x01, 0xff);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETBGP, 0x09, 0x09);
+	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETBGP, 0x09, 0x09);
 	msleep(20);
 
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETVCOM, 0x87, 0x95);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETGIP1,
+	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETVCOM, 0x87, 0x95);
+	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETGIP1,
 			      0xc2, 0x10, 0x05, 0x05, 0x10, 0x05, 0xa0, 0x12,
 			      0x31, 0x23, 0x3f, 0x81, 0x0a, 0xa0, 0x37, 0x18,
 			      0x00, 0x80, 0x01, 0x00, 0x00, 0x00, 0x00, 0x80,
@@ -116,7 +108,7 @@ static int xpp055c272_init_sequence(struct xpp055c272 *ctx)
 			      0xf8, 0x87, 0x53, 0x18, 0x88, 0x88, 0x81, 0x88,
 			      0x88, 0x88, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
 			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETGIP2,
+	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETGIP2,
 			      0x00, 0x1a, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00,
 			      0x00, 0x00, 0x00, 0x00, 0x1f, 0x88, 0x81, 0x35,
 			      0x78, 0x88, 0x88, 0x85, 0x88, 0x88, 0x88, 0x0f,
@@ -125,7 +117,7 @@ static int xpp055c272_init_sequence(struct xpp055c272 *ctx)
 			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x05,
 			      0xa0, 0x00, 0x00, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETGAMMA,
+	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETGAMMA,
 			      0x00, 0x06, 0x08, 0x2a, 0x31, 0x3f, 0x38, 0x36,
 			      0x07, 0x0c, 0x0d, 0x11, 0x13, 0x12, 0x13, 0x11,
 			      0x18, 0x00, 0x06, 0x08, 0x2a, 0x31, 0x3f, 0x38,
-- 
2.38.1

