Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9416571D8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbiL1Buy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiL1Btv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:49:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9992113B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672192103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBWsJfhSjF4lqYz4anPq3n98W47+FDRWTO/XdFMlbU8=;
        b=hn2whuSvpJzcw6vBHbhhFZ0H6c9/VVoj52EjmZ0tywtXqkL/7BcEQdD8fWei7w5EzEyVyS
        +8qg/UBwjDqVPz+yHtwxu++i5ErPiGNzDH6fyl+bsxje2Z57NLyfvBKGBNBMFahH0IuW7Y
        6YQ1j/lgs4ZFzTZdE/99HBhuLCcbwyk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-665-DCizUMQSNJC64cDUZciibg-1; Tue, 27 Dec 2022 20:48:22 -0500
X-MC-Unique: DCizUMQSNJC64cDUZciibg-1
Received: by mail-wr1-f69.google.com with SMTP id e23-20020adfa457000000b0026e7cf45583so1918268wra.23
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBWsJfhSjF4lqYz4anPq3n98W47+FDRWTO/XdFMlbU8=;
        b=qT0Ho5Sej9/Ygek70BkLd8ZgtjaeNlT1PIZzYQwyxUP7U7QW4wlH35UzXuzFnTpO7d
         wp+dzleWO6LZXLowEXJDLXle/4En9ErmEeG6ZVgOUXDn6nEP5JeOavVXIpXga6sA1ubM
         zqlqdyAWq2k5oYJ1CTE5ZMrLppIqPeN6pBSnLFe/sOeLFHryI24e4wRPcBeeC7hnprNi
         INhUGkiah3PAoXx06kJoxvSjA4P1cmS2g8Al45Pb2ZouXYHM9tbdOWyGScXmckWUjAUz
         yNbtkjtxhMFhRXK6dPDL0NEpEaFAQVlp3RyD76kwSszJ3GdN36NNnhoFN8yXYQ+wnABe
         0snw==
X-Gm-Message-State: AFqh2koZSaHxL3Vn5DmBXh5m+N3BVcIBp/bxXUiSYtzURObQIUfo9e1Z
        yQbGYX8xTJfQ5FxEOfjVEYBczxrG3wTGzfrgB72YYCA73I5sZgDp4s8nOJbUNZ859S/CwDEl4OA
        CYTONf0cP6xXePAzMqolIjnNEWb0i3TSAcy5oi0XaLQzpR7GI+5p0AUa61guzfKyUKCiH2XpUgu
        I=
X-Received: by 2002:a05:6000:695:b0:260:6b09:fa0e with SMTP id bo21-20020a056000069500b002606b09fa0emr17505658wrb.31.1672192100798;
        Tue, 27 Dec 2022 17:48:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvz6+6p8xNg+VftUEk6bb+9Eo+lwwvp+EpH24JFd41W3kiLxm5gwCaY8sNrCtQMfAOPn77qAQ==
X-Received: by 2002:a05:6000:695:b0:260:6b09:fa0e with SMTP id bo21-20020a056000069500b002606b09fa0emr17505641wrb.31.1672192100486;
        Tue, 27 Dec 2022 17:48:20 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b002258235bda3sm14158873wrx.61.2022.12.27.17.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:48:20 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 12/14] drm/panel-mantix-mlaf057we51: Drop custom DSI write macro
Date:   Wed, 28 Dec 2022 02:47:55 +0100
Message-Id: <20221228014757.3170486-13-javierm@redhat.com>
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

 .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 24 +++++++------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
index 772e3b6acece..9243b2ad828d 100644
--- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
+++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
@@ -45,14 +45,6 @@ static inline struct mantix *panel_to_mantix(struct drm_panel *panel)
 	return container_of(panel, struct mantix, panel);
 }
 
-#define dsi_generic_write_seq(dsi, seq...) do {				\
-		static const u8 d[] = { seq };				\
-		int ret;						\
-		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static int mantix_init_sequence(struct mantix *ctx)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
@@ -61,18 +53,18 @@ static int mantix_init_sequence(struct mantix *ctx)
 	/*
 	 * Init sequence was supplied by the panel vendor.
 	 */
-	dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A);
+	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A);
 
-	dsi_generic_write_seq(dsi, MANTIX_CMD_INT_CANCEL, 0x03);
-	dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x03);
-	dsi_generic_write_seq(dsi, 0x80, 0xA9, 0x00);
+	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_INT_CANCEL, 0x03);
+	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0x80, 0xA9, 0x00);
 
-	dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x09);
-	dsi_generic_write_seq(dsi, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x09);
+	mipi_dsi_generic_write_seq(dsi, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
 	msleep(20);
 
-	dsi_generic_write_seq(dsi, MANTIX_CMD_SPI_FINISH, 0xA5);
-	dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2F);
+	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_SPI_FINISH, 0xA5);
+	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2F);
 	msleep(20);
 
 	dev_dbg(dev, "Panel init sequence done\n");
-- 
2.38.1

