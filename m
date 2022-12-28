Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E566571CC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiL1BtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiL1BtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:49:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487FDF6E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672192094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R3zNujiFj3yLofalQ468fJjqEb+VryQvUoblSG4qto8=;
        b=e7XK3ncW5V2XSAyKtJQiSPr3YfnnpMbtViaPnovyswrDQmB+jtbVOFQcyRYgwztlKqrLN5
        BvYf9VF033dybHi0ZdeGmsfixQSsgejzD65l0jgwRsOZmL80dFqR5DlyagZ7LllxH57J3Q
        43hvh3U0pq9YVGf/eVli4NVSHdNINow=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-144-3aEkd2vZPG-yjx8K_UFD4A-1; Tue, 27 Dec 2022 20:48:13 -0500
X-MC-Unique: 3aEkd2vZPG-yjx8K_UFD4A-1
Received: by mail-wm1-f72.google.com with SMTP id l31-20020a05600c1d1f00b003d9720d2a0eso6601097wms.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3zNujiFj3yLofalQ468fJjqEb+VryQvUoblSG4qto8=;
        b=xZy9vyqsRY1Ld6Qqi3deZv2qfZN0Rcbd/jEhNNFevr4PpnsVrekIVw2on9ksKRQGZJ
         MMaCdA/gZceUQ9NgkgkVTmzFA23lo5kdWQJI9TEa+72WF7/6xRMrHM0/HzTRIffOTvqp
         EL8lLkGGYsIeZW8tLuHmlAHhaIh/PfdaytIXZrEBxCosb8xlEvKmeSWkUwQslLzTp8+7
         0JaWJTaqsqBE7rsWScKfUyd5amMKlvs/+8e6UeNP+qBmD3hLLsiv68cehgKKjaYP4Dgt
         PC9dSPK0KDu2GRwWVIf2zrrzxBj0loDffPie4fZTbanFXerautrpDIBqG99nKd3M/jkn
         KP5w==
X-Gm-Message-State: AFqh2krEA0j4FoqYmQgAFLljgsqvuOVRnQgZPhkLBmYOCG8W7OTuX5/1
        rtY0K5+YqS9V657Vo0yWAn3m6sFgRwJVuIPyAX6xdLMVeRKB20p3KFv8BjyTs1VrDZyXfu1tD3Z
        Tj9lxwSLqGev4fRvyhep/GEVjMhar1Xutejke6u/4unhYeqRXvw5OhCPKnQnn8G+p+HisRqKxCg
        w=
X-Received: by 2002:a05:600c:1509:b0:3d2:17a5:17fe with SMTP id b9-20020a05600c150900b003d217a517femr16573137wmg.18.1672192091813;
        Tue, 27 Dec 2022 17:48:11 -0800 (PST)
X-Google-Smtp-Source: AMrXdXspfH/t9hYVfL/CoCHFa0Z1pRLmWZ9qGIX9X9C+FhjVQIDoxI5o6qh6BstWlE6yV+CGQoT4yg==
X-Received: by 2002:a05:600c:1509:b0:3d2:17a5:17fe with SMTP id b9-20020a05600c150900b003d217a517femr16573123wmg.18.1672192091540;
        Tue, 27 Dec 2022 17:48:11 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b002258235bda3sm14158873wrx.61.2022.12.27.17.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:48:11 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 05/14] drm/panel-elida-kd35t133: Drop custom DSI write macro
Date:   Wed, 28 Dec 2022 02:47:48 +0100
Message-Id: <20221228014757.3170486-6-javierm@redhat.com>
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

 drivers/gpu/drm/panel/panel-elida-kd35t133.c | 34 ++++++++------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
index eee714cf3f49..48535ea3f1d3 100644
--- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
+++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
@@ -51,14 +51,6 @@ static inline struct kd35t133 *panel_to_kd35t133(struct drm_panel *panel)
 	return container_of(panel, struct kd35t133, panel);
 }
 
-#define dsi_dcs_write_seq(dsi, cmd, seq...) do {			\
-		static const u8 b[] = { cmd, seq };			\
-		int ret;						\
-		ret = mipi_dsi_dcs_write_buffer(dsi, b, ARRAY_SIZE(b));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static int kd35t133_init_sequence(struct kd35t133 *ctx)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
@@ -68,24 +60,24 @@ static int kd35t133_init_sequence(struct kd35t133 *ctx)
 	 * Init sequence was supplied by the panel vendor with minimal
 	 * documentation.
 	 */
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_POSITIVEGAMMA,
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POSITIVEGAMMA,
 			  0x00, 0x13, 0x18, 0x04, 0x0f, 0x06, 0x3a, 0x56,
 			  0x4d, 0x03, 0x0a, 0x06, 0x30, 0x3e, 0x0f);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_NEGATIVEGAMMA,
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_NEGATIVEGAMMA,
 			  0x00, 0x13, 0x18, 0x01, 0x11, 0x06, 0x38, 0x34,
 			  0x4d, 0x06, 0x0d, 0x0b, 0x31, 0x37, 0x0f);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL1, 0x18, 0x17);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL2, 0x41);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_VCOMCONTROL, 0x00, 0x1a, 0x80);
-	dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x48);
-	dsi_dcs_write_seq(dsi, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_INTERFACEMODECTRL, 0x00);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_FRAMERATECTRL, 0xa0);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYINVERSIONCTRL, 0x02);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYFUNCTIONCTRL,
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL1, 0x18, 0x17);
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL2, 0x41);
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_VCOMCONTROL, 0x00, 0x1a, 0x80);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x48);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_INTERFACEMODECTRL, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_FRAMERATECTRL, 0xa0);
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYINVERSIONCTRL, 0x02);
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYFUNCTIONCTRL,
 			  0x20, 0x02);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_SETIMAGEFUNCTION, 0x00);
-	dsi_dcs_write_seq(dsi, KD35T133_CMD_ADJUSTCONTROL3,
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_SETIMAGEFUNCTION, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_ADJUSTCONTROL3,
 			  0xa9, 0x51, 0x2c, 0x82);
 	mipi_dsi_dcs_write(dsi, MIPI_DCS_ENTER_INVERT_MODE, NULL, 0);
 
-- 
2.38.1

