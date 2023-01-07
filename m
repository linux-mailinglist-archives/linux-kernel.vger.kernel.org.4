Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8526566114F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 20:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjAGTT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 14:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjAGTTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 14:19:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7302134D75
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 11:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673119115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vHFwZ5KWVYahcPXMiLUm5iqICbc3qqyTGQ1xxgbWuAE=;
        b=XczDkwIpEYrlEDlcfKiDTdRGbgEcb9/BV/kYG9MIUPm2ftBv2clLEhvGIqtWhJOxKhv20i
        TRzmokCQKrmMkCwP5hPZCDo+juurO/Z2wwjIQfiOxNQOopAjEFtSnOiVhzOqvvnu3mv1gn
        inVAdev/SHjK/Je39QjjhZEt+qaGjMk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-497-z1uTecATNXiwrWewkR52_w-1; Sat, 07 Jan 2023 14:18:34 -0500
X-MC-Unique: z1uTecATNXiwrWewkR52_w-1
Received: by mail-wm1-f70.google.com with SMTP id j1-20020a05600c1c0100b003d99070f529so4629440wms.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 11:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHFwZ5KWVYahcPXMiLUm5iqICbc3qqyTGQ1xxgbWuAE=;
        b=c8FiS+SkBAWZx43XTnSi31F56DN0ZE+KMwLGGd/s3zfYsAd8xRg3ymghXQ369kc8AQ
         OmvjVuPegqf+l1bsFkESJRZCKaDKluvrePLUUIfcl1UGRsH/59BlU/xyW8NjPJpmlFzH
         bXZARp7amLmwBBXOxbHz8ENbZbaAtbKVLQpHAeCoV22xwGrHaeuJle7lGps86cgqA9J4
         XBBpp84qjhz2l5C6eBdr7wzeruT4OBbswYML8zDwVunyy+2Dn9xFGsJl8d/P1cTixk2k
         Wk7S/5RfduAMsEP/Wt2AUcm1gy/fcrXIG0SHwcUqzNP4iu4Rr0ogqouwtM64NDchpUof
         R17Q==
X-Gm-Message-State: AFqh2kqeGsM96hZ6PqR++jJwgE4tlzuDd1vBtn0l7KAXEFMKXrJpWTmz
        eobMO98GjNDWG9xxKlZwB8NVr1HIcAhOrhWpwZpT9ihnr/LKiEQUqGYKdWWTtb7sGo8ovThzhki
        /a32fihh72qGoREvDWFbWmxGWHjt2Z+3zdKxYz2/FIyK1B6gTOfxfby6q729hvrbjzOFAqOvs56
        Y=
X-Received: by 2002:adf:dd88:0:b0:242:ac4:4a0c with SMTP id x8-20020adfdd88000000b002420ac44a0cmr45009086wrl.32.1673119113048;
        Sat, 07 Jan 2023 11:18:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvtuEttDcXb2+KgfpoYFh0D2+A1psW+hNliMeobsiLWNH8/iHfff6qgBGb1vGqWGiba4Rc7cQ==
X-Received: by 2002:adf:dd88:0:b0:242:ac4:4a0c with SMTP id x8-20020adfdd88000000b002420ac44a0cmr45009072wrl.32.1673119112787;
        Sat, 07 Jan 2023 11:18:32 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bp28-20020a5d5a9c000000b00273cd321a1bsm4553900wrb.107.2023.01.07.11.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:18:32 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 01/13] drm/panel-asus-z00t-tm5p5-n35596: Drop custom DSI write macros
Date:   Sat,  7 Jan 2023 20:18:10 +0100
Message-Id: <20230107191822.3787147-2-javierm@redhat.com>
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

