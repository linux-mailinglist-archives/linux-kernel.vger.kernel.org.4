Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5445F661159
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 20:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjAGTU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 14:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjAGTUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 14:20:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F4E3590E
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 11:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673119128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vpnPFBzRW6eHCPCk8Ls0t1EZjEyRqRYmlX28Isym++A=;
        b=TZl92XL4qiMlvrdBeOMuEiqsvymrttSytoWe5diJFU3a+TMKqmMHPXqDCvrFAtQbpQ1wm3
        3mH937IBIhzlvA5fardCuFLycbueCT02D0PJ16FZOTP1eBxEEVIYiDOIZnP4Ss5PBgE0jr
        ooGEfmY8qAxQQIsh/kSkjPNFE51FlmM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-197-tiFQ2P3cPUqN3vbHs0URig-1; Sat, 07 Jan 2023 14:18:47 -0500
X-MC-Unique: tiFQ2P3cPUqN3vbHs0URig-1
Received: by mail-wm1-f72.google.com with SMTP id fm25-20020a05600c0c1900b003d9702a11e5so2740350wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 11:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpnPFBzRW6eHCPCk8Ls0t1EZjEyRqRYmlX28Isym++A=;
        b=nC65IiqxNpycA3fLFSZewspEFeJpBLuuGGgxMWlMM0zDk9Um7XPiFzTXRQKaTLygTl
         n5NAFCa+tspoTeEWfTwtWbU/nvVSw/hwEPff/sJZP/ZXNEESr9S+fbE8rvOu71xU4BDb
         QTw0Qg9NYO6Rlq/H70UdCpiJ0HHotdSc+Tn9iae1lwGivyGRE/uQrxazdRFKWo+AUSgn
         lGffz20BZDcPXXuHy60k/5Yjlzrmw4n8UiQbeBaRswn7SdeNPPRpx2Gf7AJbgzYtBUFR
         s6KiEbYvED7TNSjieh4VrcrxYOrJCCkYAq2tqV41EU7VG8khaXGd+RU2jj3FEwOUQ82g
         K8sw==
X-Gm-Message-State: AFqh2krVQV/EgyLhj/g+Xp2okJYNItzQj68lr/+XZ2F5cZzTbaBqbsV6
        LP83Wk4vCwibpNhibqbJ2memMcMkq3PDy1drgSQyJLMBQQzEFpoZUdDyfWGNijq6M3PpS/fpq/r
        DTlqTJeBRSp7RF0GOY++bB/br+MCtD3hfaBUMlIK4Z+pDvYqRL8LI+dQE9DCwg5TDvS5iHQgAFv
        k=
X-Received: by 2002:a5d:620f:0:b0:242:9e3:72b8 with SMTP id y15-20020a5d620f000000b0024209e372b8mr43020258wru.31.1673119125860;
        Sat, 07 Jan 2023 11:18:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvGRowZHlkk4D63NFUoqF99EB2JPISpBuBanleVv/OAGREuj85b6r46NB2BstsyZH7AAsnhZQ==
X-Received: by 2002:a5d:620f:0:b0:242:9e3:72b8 with SMTP id y15-20020a5d620f000000b0024209e372b8mr43020244wru.31.1673119125605;
        Sat, 07 Jan 2023 11:18:45 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bp28-20020a5d5a9c000000b00273cd321a1bsm4553900wrb.107.2023.01.07.11.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:18:45 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 11/13] drm/panel-mantix-mlaf057we51: Drop custom DSI write macro
Date:   Sat,  7 Jan 2023 20:18:20 +0100
Message-Id: <20230107191822.3787147-12-javierm@redhat.com>
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

