Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C126571C7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiL1BtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiL1Bs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:48:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8C1DFBA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672192090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9JgG18siC0zFvcxfSnzxDZkFtR9u8dpp2nx4seyvBE=;
        b=jPQ7TA726SRWqqUrjT4H9klbXHhVFstx8BtssaWzZU6yImxwQ1lTE5Wp1+ImPZJ85cKBRU
        dpuZtKJH9RS9dlWjzLXO5i86OgaG/nAA71EEuLjgvSqeSleyKtVrAsL3gA17iUBFdBKeLU
        BAK7J8xNLLdIepVNU61vZubWo4NrEeY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-517-lcNYc2tCOd6Y5ODUSWRpUw-1; Tue, 27 Dec 2022 20:48:09 -0500
X-MC-Unique: lcNYc2tCOd6Y5ODUSWRpUw-1
Received: by mail-wm1-f70.google.com with SMTP id n18-20020a05600c4f9200b003d993e08485so287485wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9JgG18siC0zFvcxfSnzxDZkFtR9u8dpp2nx4seyvBE=;
        b=neMcaN7IrkcqRViixzwQGKpkSbv8y69+xbezCp9t5ImX/DJLD/h6QCgEfl3CEgnLvJ
         ceG2Qyew29EqzEdwU2edmWJo2ZhSn2YRIeVUCP+MKgzum6DzKcbbn+qLyaZ+jFQ1wA3e
         uDlBFjyqIGjjUzK1R7qcLWg8JdFfWN87kEj4iXnZaJ1+hmSRtlr6cYEhDSso3dV/GL35
         8XtbhGjcuMGmGfbBjqDgc86mnBNC7E/jWDN01Obk+Vq5UxSaufd7QtqyxPg76pkxWJYS
         iXm52tu0VJUTHtuw5EOcoyM3f6CZoX0kj8ccHFpRE0VFjY0TZjpUh7kaimkcJvPeu+A/
         OChA==
X-Gm-Message-State: AFqh2krgErdvVIDvMIiKCDfLWn8V09jliSuISBAb+pfsSw9XofX/cVTr
        ic1UVi/UNsPhDR4Kq7roUwj7D5cct8PFhAxVurQjJjX8RKTQg4hZ9ePtsnVJGOjKyuQI5gkJbEz
        TyUl3LDLyb3/KtH16WE7IDlhUvmQY4hHH4v9b+p97rylt184kkHC8HLRJhZE+Mam1sFqg8GhBML
        4=
X-Received: by 2002:adf:ed0a:0:b0:242:142a:c8ba with SMTP id a10-20020adfed0a000000b00242142ac8bamr13298912wro.52.1672192087724;
        Tue, 27 Dec 2022 17:48:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvG4ykycaEyWwwt5gYNozMEuWfW2ekORtLjj1KHz3ZIik5MWGYROBHkszCeYe0Xn9LWWOLgPw==
X-Received: by 2002:adf:ed0a:0:b0:242:142a:c8ba with SMTP id a10-20020adfed0a000000b00242142ac8bamr13298902wro.52.1672192087422;
        Tue, 27 Dec 2022 17:48:07 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b002258235bda3sm14158873wrx.61.2022.12.27.17.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:48:07 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 02/14] drm/panel-asus-z00t-tm5p5-n35596: Drop custom DSI write macros
Date:   Wed, 28 Dec 2022 02:47:45 +0100
Message-Id: <20221228014757.3170486-3-javierm@redhat.com>
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

 .../drm/panel/panel-asus-z00t-tm5p5-n35596.c  | 96 ++++++++-----------
 1 file changed, 40 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c b/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
index b3235781e6ba..075a7af81eff 100644
--- a/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
+++ b/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
@@ -24,22 +24,6 @@ static inline struct tm5p5_nt35596 *to_tm5p5_nt35596(struct drm_panel *panel)
 	return container_of(panel, struct tm5p5_nt35596, panel);
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
 static void tm5p5_nt35596_reset(struct tm5p5_nt35596 *ctx)
 {
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
@@ -54,46 +38,46 @@ static int tm5p5_nt35596_on(struct tm5p5_nt35596 *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi;
 
-	dsi_generic_write_seq(dsi, 0xff, 0x05);
-	dsi_generic_write_seq(dsi, 0xfb, 0x01);
-	dsi_generic_write_seq(dsi, 0xc5, 0x31);
-	dsi_generic_write_seq(dsi, 0xff, 0x04);
-	dsi_generic_write_seq(dsi, 0x01, 0x84);
-	dsi_generic_write_seq(dsi, 0x05, 0x25);
-	dsi_generic_write_seq(dsi, 0x06, 0x01);
-	dsi_generic_write_seq(dsi, 0x07, 0x20);
-	dsi_generic_write_seq(dsi, 0x08, 0x06);
-	dsi_generic_write_seq(dsi, 0x09, 0x08);
-	dsi_generic_write_seq(dsi, 0x0a, 0x10);
-	dsi_generic_write_seq(dsi, 0x0b, 0x10);
-	dsi_generic_write_seq(dsi, 0x0c, 0x10);
-	dsi_generic_write_seq(dsi, 0x0d, 0x14);
-	dsi_generic_write_seq(dsi, 0x0e, 0x14);
-	dsi_generic_write_seq(dsi, 0x0f, 0x14);
-	dsi_generic_write_seq(dsi, 0x10, 0x14);
-	dsi_generic_write_seq(dsi, 0x11, 0x14);
-	dsi_generic_write_seq(dsi, 0x12, 0x14);
-	dsi_generic_write_seq(dsi, 0x17, 0xf3);
-	dsi_generic_write_seq(dsi, 0x18, 0xc0);
-	dsi_generic_write_seq(dsi, 0x19, 0xc0);
-	dsi_generic_write_seq(dsi, 0x1a, 0xc0);
-	dsi_generic_write_seq(dsi, 0x1b, 0xb3);
-	dsi_generic_write_seq(dsi, 0x1c, 0xb3);
-	dsi_generic_write_seq(dsi, 0x1d, 0xb3);
-	dsi_generic_write_seq(dsi, 0x1e, 0xb3);
-	dsi_generic_write_seq(dsi, 0x1f, 0xb3);
-	dsi_generic_write_seq(dsi, 0x20, 0xb3);
-	dsi_generic_write_seq(dsi, 0xfb, 0x01);
-	dsi_generic_write_seq(dsi, 0xff, 0x00);
-	dsi_generic_write_seq(dsi, 0xfb, 0x01);
-	dsi_generic_write_seq(dsi, 0x35, 0x01);
-	dsi_generic_write_seq(dsi, 0xd3, 0x06);
-	dsi_generic_write_seq(dsi, 0xd4, 0x04);
-	dsi_generic_write_seq(dsi, 0x5e, 0x0d);
-	dsi_generic_write_seq(dsi, 0x11, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xff, 0x05);
+	mipi_dsi_generic_write_seq(dsi, 0xfb, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xc5, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xff, 0x04);
+	mipi_dsi_generic_write_seq(dsi, 0x01, 0x84);
+	mipi_dsi_generic_write_seq(dsi, 0x05, 0x25);
+	mipi_dsi_generic_write_seq(dsi, 0x06, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0x07, 0x20);
+	mipi_dsi_generic_write_seq(dsi, 0x08, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0x09, 0x08);
+	mipi_dsi_generic_write_seq(dsi, 0x0a, 0x10);
+	mipi_dsi_generic_write_seq(dsi, 0x0b, 0x10);
+	mipi_dsi_generic_write_seq(dsi, 0x0c, 0x10);
+	mipi_dsi_generic_write_seq(dsi, 0x0d, 0x14);
+	mipi_dsi_generic_write_seq(dsi, 0x0e, 0x14);
+	mipi_dsi_generic_write_seq(dsi, 0x0f, 0x14);
+	mipi_dsi_generic_write_seq(dsi, 0x10, 0x14);
+	mipi_dsi_generic_write_seq(dsi, 0x11, 0x14);
+	mipi_dsi_generic_write_seq(dsi, 0x12, 0x14);
+	mipi_dsi_generic_write_seq(dsi, 0x17, 0xf3);
+	mipi_dsi_generic_write_seq(dsi, 0x18, 0xc0);
+	mipi_dsi_generic_write_seq(dsi, 0x19, 0xc0);
+	mipi_dsi_generic_write_seq(dsi, 0x1a, 0xc0);
+	mipi_dsi_generic_write_seq(dsi, 0x1b, 0xb3);
+	mipi_dsi_generic_write_seq(dsi, 0x1c, 0xb3);
+	mipi_dsi_generic_write_seq(dsi, 0x1d, 0xb3);
+	mipi_dsi_generic_write_seq(dsi, 0x1e, 0xb3);
+	mipi_dsi_generic_write_seq(dsi, 0x1f, 0xb3);
+	mipi_dsi_generic_write_seq(dsi, 0x20, 0xb3);
+	mipi_dsi_generic_write_seq(dsi, 0xfb, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xff, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xfb, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0x35, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xd3, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xd4, 0x04);
+	mipi_dsi_generic_write_seq(dsi, 0x5e, 0x0d);
+	mipi_dsi_generic_write_seq(dsi, 0x11, 0x00);
 	msleep(100);
-	dsi_generic_write_seq(dsi, 0x29, 0x00);
-	dsi_generic_write_seq(dsi, 0x53, 0x24);
+	mipi_dsi_generic_write_seq(dsi, 0x29, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0x53, 0x24);
 
 	return 0;
 }
@@ -117,7 +101,7 @@ static int tm5p5_nt35596_off(struct tm5p5_nt35596 *ctx)
 		return ret;
 	}
 
-	dsi_dcs_write_seq(dsi, 0x4f, 0x01);
+	mipi_dsi_dcs_write_seq(dsi, 0x4f, 0x01);
 
 	return 0;
 }
-- 
2.38.1

