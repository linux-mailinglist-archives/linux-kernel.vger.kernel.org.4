Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8C6661154
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 20:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjAGTUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 14:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjAGTUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 14:20:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF353590C
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 11:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673119124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3UbmEV+kUDRxsVEHZ8LXGuydtVY+f4VLUneyt4KaPUA=;
        b=LzL1fbRUNcVTkUUs/bEJtqcfwh3KxtT1/JnueVlh12Sc64LsbuN/RXpwuytIa00YdV7a2Q
        dzj7MFruGwS5IecUgDKPi3i3gXB+jbHIr3vZCGBjfO0aUXZqWaS6DPWq7UGKYO98mGNbkj
        cxJ2rRcXzSY7DAzSP40mFquQCSgANwg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-266-Sfv0iq9kMEeKUzS1-8WAxw-1; Sat, 07 Jan 2023 14:18:43 -0500
X-MC-Unique: Sfv0iq9kMEeKUzS1-8WAxw-1
Received: by mail-wr1-f72.google.com with SMTP id u15-20020adfa18f000000b002b129dc55bfso585307wru.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 11:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UbmEV+kUDRxsVEHZ8LXGuydtVY+f4VLUneyt4KaPUA=;
        b=I5EMa5zj0DHS4ZkGpkcUUxvpBtvghGsx5Ea/+GwqtPIfs/y6YAc/AefknGEFDPikg1
         HFWPMsPUA0a1q6/lLPnm8+RyZfRCEEoQNqA53+NNUUNX1rS6ynNaBMkrzsrrrcjlA+9C
         6JoMcenQG787yQcGVZHtuAy8JP0ASLI51fxUVyuPALb+4i4BypmBiZZI7G4KnE7uhh1i
         cOKlCzSU3Wh5UYCRVbYVV0HrN42nun5G9pZGtmKE56Wxdl2skWiJGmG+ydZu1/EhSmHK
         rCzkqoSubf7X0SoTd69ZwRy/na7upS+M0v0NJG58xkc5d2euFGYufdgrlQnohYocfB2L
         NUgA==
X-Gm-Message-State: AFqh2kpG6X0FKc8AVoHdS4LmyBnxurTrU1uerIXfjUHbgm8hXvzik6l+
        aqNtu2v/ykfJkxzwwabAKTIyVF0r8BOaGMYfuN/t+YKw8kzlsNldrcydIZj9GwBhle6/E7TxmXM
        gQhwvPOqJAK156ucOc3WsGJwJsC8Vt5kPotYqQmqFzyv253UL3uP2JvtEFzcLG2gGLx2ZQ9BhyZ
        M=
X-Received: by 2002:a5d:5965:0:b0:27f:1c70:58c3 with SMTP id e37-20020a5d5965000000b0027f1c7058c3mr28918831wri.24.1673119121786;
        Sat, 07 Jan 2023 11:18:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvn3/NsWtFEC4rkLPj22mr95+5FOn9c8MbeYB/J6hRruQBMnje0oECXATpAR/FApVyushGPog==
X-Received: by 2002:a5d:5965:0:b0:27f:1c70:58c3 with SMTP id e37-20020a5d5965000000b0027f1c7058c3mr28918817wri.24.1673119121594;
        Sat, 07 Jan 2023 11:18:41 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bp28-20020a5d5a9c000000b00273cd321a1bsm4553900wrb.107.2023.01.07.11.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:18:41 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 08/13] drm/panel-samsung-s6e88a0-ams452ef01: Drop custom DSI write macro
Date:   Sat,  7 Jan 2023 20:18:17 +0100
Message-Id: <20230107191822.3787147-9-javierm@redhat.com>
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

 .../panel/panel-samsung-s6e88a0-ams452ef01.c  | 44 ++++++++-----------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c
index 97ff7a18545c..7431cae7427e 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c
@@ -28,14 +28,6 @@ s6e88a0_ams452ef01 *to_s6e88a0_ams452ef01(struct drm_panel *panel)
 	return container_of(panel, struct s6e88a0_ams452ef01, panel);
 }
 
-#define dsi_dcs_write_seq(dsi, seq...) do {				\
-		static const u8 d[] = { seq };				\
-		int ret;						\
-		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static void s6e88a0_ams452ef01_reset(struct s6e88a0_ams452ef01 *ctx)
 {
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
@@ -54,8 +46,8 @@ static int s6e88a0_ams452ef01_on(struct s6e88a0_ams452ef01 *ctx)
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a); // enable LEVEL2 commands
-	dsi_dcs_write_seq(dsi, 0xcc, 0x4c); // set Pixel Clock Divider polarity
+	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a); // enable LEVEL2 commands
+	mipi_dsi_dcs_write_seq(dsi, 0xcc, 0x4c); // set Pixel Clock Divider polarity
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret < 0) {
@@ -65,23 +57,23 @@ static int s6e88a0_ams452ef01_on(struct s6e88a0_ams452ef01 *ctx)
 	msleep(120);
 
 	// set default brightness/gama
-	dsi_dcs_write_seq(dsi, 0xca,
-			  0x01, 0x00, 0x01, 0x00, 0x01, 0x00,	// V255 RR,GG,BB
-			  0x80, 0x80, 0x80,			// V203 R,G,B
-			  0x80, 0x80, 0x80,			// V151 R,G,B
-			  0x80, 0x80, 0x80,			// V87  R,G,B
-			  0x80, 0x80, 0x80,			// V51  R,G,B
-			  0x80, 0x80, 0x80,			// V35  R,G,B
-			  0x80, 0x80, 0x80,			// V23  R,G,B
-			  0x80, 0x80, 0x80,			// V11  R,G,B
-			  0x6b, 0x68, 0x71,			// V3   R,G,B
-			  0x00, 0x00, 0x00);			// V1   R,G,B
+	mipi_dsi_dcs_write_seq(dsi, 0xca,
+			       0x01, 0x00, 0x01, 0x00, 0x01, 0x00,	// V255 RR,GG,BB
+			       0x80, 0x80, 0x80,			// V203 R,G,B
+			       0x80, 0x80, 0x80,			// V151 R,G,B
+			       0x80, 0x80, 0x80,			// V87  R,G,B
+			       0x80, 0x80, 0x80,			// V51  R,G,B
+			       0x80, 0x80, 0x80,			// V35  R,G,B
+			       0x80, 0x80, 0x80,			// V23  R,G,B
+			       0x80, 0x80, 0x80,			// V11  R,G,B
+			       0x6b, 0x68, 0x71,			// V3   R,G,B
+			       0x00, 0x00, 0x00);			// V1   R,G,B
 	// set default Amoled Off Ratio
-	dsi_dcs_write_seq(dsi, 0xb2, 0x40, 0x0a, 0x17, 0x00, 0x0a);
-	dsi_dcs_write_seq(dsi, 0xb6, 0x2c, 0x0b); // set default elvss voltage
-	dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
-	dsi_dcs_write_seq(dsi, 0xf7, 0x03); // gamma/aor update
-	dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5); // disable LEVEL2 commands
+	mipi_dsi_dcs_write_seq(dsi, 0xb2, 0x40, 0x0a, 0x17, 0x00, 0x0a);
+	mipi_dsi_dcs_write_seq(dsi, 0xb6, 0x2c, 0x0b); // set default elvss voltage
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xf7, 0x03); // gamma/aor update
+	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5); // disable LEVEL2 commands
 
 	ret = mipi_dsi_dcs_set_display_on(dsi);
 	if (ret < 0) {
-- 
2.38.1

