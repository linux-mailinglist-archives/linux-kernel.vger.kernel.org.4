Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5056571CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiL1BtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiL1BtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:49:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C73BEB4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672192093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g15VcQGD8pOXU33YkkONtfP58IPyQH60L411XlcKCd0=;
        b=NMHoe7GBUG9k2ZoFZrhDdY7W/iXO2flh7ICkXxy3R0Nq2Qv2VLt7fLrkpGpCCTzhzf8hVj
        U07zorogqLkEl71ontNEQTBDU/8+OTrkqmUnyQ6mP6i5TFB7Ziwj/w19lGxJ8x8PuOEncx
        251ksLAD1bn653/FftMNGwVMKh0mkcM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-8A4OVQ-3N8qzqMVlq0Ikdw-1; Tue, 27 Dec 2022 20:48:11 -0500
X-MC-Unique: 8A4OVQ-3N8qzqMVlq0Ikdw-1
Received: by mail-wm1-f71.google.com with SMTP id l31-20020a05600c1d1f00b003d9720d2a0eso6601069wms.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g15VcQGD8pOXU33YkkONtfP58IPyQH60L411XlcKCd0=;
        b=mrSZOV5zvBUAESMtQook2BO77Zo/Zjy9Zl5zlckQYAzrGN+68HQSf3j/rQh/yLGrHQ
         xNiQCXw1WIQ4JLBhC0EIv7xeKG0ma1M26JKZ3CuP7uZTN0DPoRUFxdxU6S4Fnw7kO8Qq
         iqM7Iovnd44V2vATlevonvsF2LaBti8HYkWqAKUcluADIaViET7cyWJWXl9HWnWpI+XQ
         3lv7SxJRBf3vZa5FnYpW3v1Af2yFCRH3zeZI7gz0Z59SRF4D4O0NEJi9g+QWXD+aVFCC
         m9rgTBhBUjIp1CcMxuYFnOE1mzUySQdMbZAIIEOcgybVp9PxAh5Qw+t3ALTRpzONqqwP
         B6Tw==
X-Gm-Message-State: AFqh2kqpkiPKS2chLYtFbI4qr8RqwVu3HoIId2a9+AH+ISahOmMXK4Ik
        rMraJuwZh+2TR9Ekud52vS03tPYfDjRmVXiQWlRBh3ntPWLGas0H2Q8GnhEOsNdnCulA3k+pYuJ
        x0LZbUh2yMp80zoifXnuHEgcwDg4vV/M5jNxVu7o0IW3hGBtOwaGk7bTPflVO9/FLFOf9WEWaBr
        U=
X-Received: by 2002:a5d:49c3:0:b0:232:be5c:ec4a with SMTP id t3-20020a5d49c3000000b00232be5cec4amr18463323wrs.6.1672192090452;
        Tue, 27 Dec 2022 17:48:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsCR5UYOjWU+wG5pcWo5e2TR0Mh3mfElBmA4Lw+8NrlaXHQ8azAl3N47MnAYoKcWmVES84Vyg==
X-Received: by 2002:a5d:49c3:0:b0:232:be5c:ec4a with SMTP id t3-20020a5d49c3000000b00232be5cec4amr18463309wrs.6.1672192090152;
        Tue, 27 Dec 2022 17:48:10 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b002258235bda3sm14158873wrx.61.2022.12.27.17.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:48:09 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/14] drm/panel-leadtek-ltk050h3146w: Drop custom DSI write macro
Date:   Wed, 28 Dec 2022 02:47:47 +0100
Message-Id: <20221228014757.3170486-5-javierm@redhat.com>
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

 .../drm/panel/panel-leadtek-ltk050h3146w.c    | 64 ++++++++-----------
 1 file changed, 28 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
index 5619f186d28c..525dddef4d9c 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
@@ -244,14 +244,6 @@ struct ltk050h3146w *panel_to_ltk050h3146w(struct drm_panel *panel)
 	return container_of(panel, struct ltk050h3146w, panel);
 }
 
-#define dsi_dcs_write_seq(dsi, cmd, seq...) do {			\
-		static const u8 b[] = { cmd, seq };			\
-		int ret;						\
-		ret = mipi_dsi_dcs_write_buffer(dsi, b, ARRAY_SIZE(b));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static int ltk050h3146w_init_sequence(struct ltk050h3146w *ctx)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
@@ -261,55 +253,55 @@ static int ltk050h3146w_init_sequence(struct ltk050h3146w *ctx)
 	 * Init sequence was supplied by the panel vendor without much
 	 * documentation.
 	 */
-	dsi_dcs_write_seq(dsi, 0xdf, 0x93, 0x65, 0xf8);
-	dsi_dcs_write_seq(dsi, 0xb0, 0x01, 0x03, 0x02, 0x00, 0x64, 0x06,
+	mipi_dsi_dcs_write_seq(dsi, 0xdf, 0x93, 0x65, 0xf8);
+	mipi_dsi_dcs_write_seq(dsi, 0xb0, 0x01, 0x03, 0x02, 0x00, 0x64, 0x06,
 			  0x01);
-	dsi_dcs_write_seq(dsi, 0xb2, 0x00, 0xb5);
-	dsi_dcs_write_seq(dsi, 0xb3, 0x00, 0xb5);
-	dsi_dcs_write_seq(dsi, 0xb7, 0x00, 0xbf, 0x00, 0x00, 0xbf, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xb2, 0x00, 0xb5);
+	mipi_dsi_dcs_write_seq(dsi, 0xb3, 0x00, 0xb5);
+	mipi_dsi_dcs_write_seq(dsi, 0xb7, 0x00, 0xbf, 0x00, 0x00, 0xbf, 0x00);
 
-	dsi_dcs_write_seq(dsi, 0xb9, 0x00, 0xc4, 0x23, 0x07);
-	dsi_dcs_write_seq(dsi, 0xbb, 0x02, 0x01, 0x24, 0x00, 0x28, 0x0f,
+	mipi_dsi_dcs_write_seq(dsi, 0xb9, 0x00, 0xc4, 0x23, 0x07);
+	mipi_dsi_dcs_write_seq(dsi, 0xbb, 0x02, 0x01, 0x24, 0x00, 0x28, 0x0f,
 			  0x28, 0x04, 0xcc, 0xcc, 0xcc);
-	dsi_dcs_write_seq(dsi, 0xbc, 0x0f, 0x04);
-	dsi_dcs_write_seq(dsi, 0xbe, 0x1e, 0xf2);
-	dsi_dcs_write_seq(dsi, 0xc0, 0x26, 0x03);
-	dsi_dcs_write_seq(dsi, 0xc1, 0x00, 0x12);
-	dsi_dcs_write_seq(dsi, 0xc3, 0x04, 0x02, 0x02, 0x76, 0x01, 0x80,
+	mipi_dsi_dcs_write_seq(dsi, 0xbc, 0x0f, 0x04);
+	mipi_dsi_dcs_write_seq(dsi, 0xbe, 0x1e, 0xf2);
+	mipi_dsi_dcs_write_seq(dsi, 0xc0, 0x26, 0x03);
+	mipi_dsi_dcs_write_seq(dsi, 0xc1, 0x00, 0x12);
+	mipi_dsi_dcs_write_seq(dsi, 0xc3, 0x04, 0x02, 0x02, 0x76, 0x01, 0x80,
 			  0x80);
-	dsi_dcs_write_seq(dsi, 0xc4, 0x24, 0x80, 0xb4, 0x81, 0x12, 0x0f,
+	mipi_dsi_dcs_write_seq(dsi, 0xc4, 0x24, 0x80, 0xb4, 0x81, 0x12, 0x0f,
 			  0x16, 0x00, 0x00);
-	dsi_dcs_write_seq(dsi, 0xc8, 0x7f, 0x72, 0x67, 0x5d, 0x5d, 0x50,
+	mipi_dsi_dcs_write_seq(dsi, 0xc8, 0x7f, 0x72, 0x67, 0x5d, 0x5d, 0x50,
 			  0x56, 0x41, 0x59, 0x57, 0x55, 0x70, 0x5b, 0x5f,
 			  0x4f, 0x47, 0x38, 0x23, 0x08, 0x7f, 0x72, 0x67,
 			  0x5d, 0x5d, 0x50, 0x56, 0x41, 0x59, 0x57, 0x55,
 			  0x70, 0x5b, 0x5f, 0x4f, 0x47, 0x38, 0x23, 0x08);
-	dsi_dcs_write_seq(dsi, 0xd0, 0x1e, 0x1f, 0x57, 0x58, 0x48, 0x4a,
+	mipi_dsi_dcs_write_seq(dsi, 0xd0, 0x1e, 0x1f, 0x57, 0x58, 0x48, 0x4a,
 			  0x44, 0x46, 0x40, 0x1f, 0x42, 0x1f, 0x1f, 0x1f,
 			  0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
-	dsi_dcs_write_seq(dsi, 0xd1, 0x1e, 0x1f, 0x57, 0x58, 0x49, 0x4b,
+	mipi_dsi_dcs_write_seq(dsi, 0xd1, 0x1e, 0x1f, 0x57, 0x58, 0x49, 0x4b,
 			  0x45, 0x47, 0x41, 0x1f, 0x43, 0x1f, 0x1f, 0x1f,
 			  0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
-	dsi_dcs_write_seq(dsi, 0xd2, 0x1f, 0x1e, 0x17, 0x18, 0x07, 0x05,
+	mipi_dsi_dcs_write_seq(dsi, 0xd2, 0x1f, 0x1e, 0x17, 0x18, 0x07, 0x05,
 			  0x0b, 0x09, 0x03, 0x1f, 0x01, 0x1f, 0x1f, 0x1f,
 			  0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
-	dsi_dcs_write_seq(dsi, 0xd3, 0x1f, 0x1e, 0x17, 0x18, 0x06, 0x04,
+	mipi_dsi_dcs_write_seq(dsi, 0xd3, 0x1f, 0x1e, 0x17, 0x18, 0x06, 0x04,
 			  0x0a, 0x08, 0x02, 0x1f, 0x00, 0x1f, 0x1f, 0x1f,
 			  0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
-	dsi_dcs_write_seq(dsi, 0xd4, 0x00, 0x00, 0x00, 0x0c, 0x06, 0x20,
+	mipi_dsi_dcs_write_seq(dsi, 0xd4, 0x00, 0x00, 0x00, 0x0c, 0x06, 0x20,
 			  0x01, 0x02, 0x00, 0x60, 0x15, 0xb0, 0x30, 0x03,
 			  0x04, 0x00, 0x60, 0x72, 0x0a, 0x00, 0x60, 0x08);
-	dsi_dcs_write_seq(dsi, 0xd5, 0x00, 0x06, 0x06, 0x00, 0x30, 0x00,
+	mipi_dsi_dcs_write_seq(dsi, 0xd5, 0x00, 0x06, 0x06, 0x00, 0x30, 0x00,
 			  0x00, 0x00, 0x00, 0x00, 0xbc, 0x50, 0x00, 0x05,
 			  0x21, 0x00, 0x60);
-	dsi_dcs_write_seq(dsi, 0xdd, 0x2c, 0xa3, 0x00);
-	dsi_dcs_write_seq(dsi, 0xde, 0x02);
-	dsi_dcs_write_seq(dsi, 0xb2, 0x32, 0x1c);
-	dsi_dcs_write_seq(dsi, 0xb7, 0x3b, 0x70, 0x00, 0x04);
-	dsi_dcs_write_seq(dsi, 0xc1, 0x11);
-	dsi_dcs_write_seq(dsi, 0xbb, 0x21, 0x22, 0x23, 0x24, 0x36, 0x37);
-	dsi_dcs_write_seq(dsi, 0xc2, 0x20, 0x38, 0x1e, 0x84);
-	dsi_dcs_write_seq(dsi, 0xde, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xdd, 0x2c, 0xa3, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xde, 0x02);
+	mipi_dsi_dcs_write_seq(dsi, 0xb2, 0x32, 0x1c);
+	mipi_dsi_dcs_write_seq(dsi, 0xb7, 0x3b, 0x70, 0x00, 0x04);
+	mipi_dsi_dcs_write_seq(dsi, 0xc1, 0x11);
+	mipi_dsi_dcs_write_seq(dsi, 0xbb, 0x21, 0x22, 0x23, 0x24, 0x36, 0x37);
+	mipi_dsi_dcs_write_seq(dsi, 0xc2, 0x20, 0x38, 0x1e, 0x84);
+	mipi_dsi_dcs_write_seq(dsi, 0xde, 0x00);
 
 	ret = mipi_dsi_dcs_set_tear_on(dsi, 1);
 	if (ret < 0) {
-- 
2.38.1

