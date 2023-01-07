Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A20661158
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 20:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjAGTUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 14:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjAGTUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 14:20:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7364434D7A
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 11:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673119125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z5ujAZitOZbP2puOeLODSdf7lrppmKAKMcwgyMXAuXA=;
        b=cfm++JKcfo1L2M6ynfJljGCLYZtuSGYI6Jgvin8BWZ81cOXdNNAWbE+SdCNd46pC00Uqef
        R0IpXeNFBb8nsRHouu1kH6L711l8yozLgiE8spLsTnIp/DnLt2QAXLyILYNVh5/7B4qfIj
        qxlnLoKJ4JQMsu9NQA89YjlwBKFSoh0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-418-VBBnXHv2Ou2sc3Aiy-ziVA-1; Sat, 07 Jan 2023 14:18:44 -0500
X-MC-Unique: VBBnXHv2Ou2sc3Aiy-ziVA-1
Received: by mail-wm1-f70.google.com with SMTP id i7-20020a05600c354700b003d62131fe46so4645126wmq.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 11:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5ujAZitOZbP2puOeLODSdf7lrppmKAKMcwgyMXAuXA=;
        b=nSqkWcyYfGHBtJhWLRWksUhiGlKWrkCZaCLIjwJklWU4qF1KiSPL84AnixWrnMrgN1
         XstQH3BiQ9SP00640dpHyDS5b6v9e2dElzf9M+Y/LcGPI6gzXRkooGAJb4OFILTDziS6
         8xlmCQUDLcudZeb8WExCYjVA5eZ1lHdvgbTNiGQpQTKL+bkmfXqRQGCkRqKa+qMfimZZ
         e+fEyEUnPmLigWK4CPOsoFK4yM6+eHczUNOnsuvYALKsz87CjfD8Av24Ph0W6kU8PkTI
         jBE++44jq45WnOLOO1VAP7uIMCTW6DkCHhguTysXD/3L6Xaw7uWe6dWd/yE3cOzXx7+E
         qieg==
X-Gm-Message-State: AFqh2kp/lUDczRn8GnM6SXPa3TTL467hCkbrdOlVqcVjzV9HoRHCvObo
        TgMgcZQbEH1vF31MSFZmmw/A20RQ+d+apFuB4qNUYrljNBdY+TdaDSEJ1dd91IkAbXZ+PCIPKU/
        IeebR5ufgnVs3AwVhL6PJeWc+LBONxsnfrLMelRo6bj0xZyFGBg0SNUeT2Ky/zUDTiMWNuJDFqr
        E=
X-Received: by 2002:a05:600c:54ef:b0:3d0:5254:8a43 with SMTP id jb15-20020a05600c54ef00b003d052548a43mr52375494wmb.38.1673119122996;
        Sat, 07 Jan 2023 11:18:42 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuv3SFkN1BZjacT8KalmsIEXaMxI/TG40bGBxvzNZy7X+fmcWJdSZrf1MPJY091RCqPgDX4mQ==
X-Received: by 2002:a05:600c:54ef:b0:3d0:5254:8a43 with SMTP id jb15-20020a05600c54ef00b003d052548a43mr52375482wmb.38.1673119122796;
        Sat, 07 Jan 2023 11:18:42 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bp28-20020a5d5a9c000000b00273cd321a1bsm4553900wrb.107.2023.01.07.11.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:18:42 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 09/13] drm/panel-samsung-sofef00: Drop custom DSI write macro
Date:   Sat,  7 Jan 2023 20:18:18 +0100
Message-Id: <20230107191822.3787147-10-javierm@redhat.com>
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

 drivers/gpu/drm/panel/panel-samsung-sofef00.c | 24 +++++++------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-sofef00.c b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
index 1a0d24595faa..9db49a028930 100644
--- a/drivers/gpu/drm/panel/panel-samsung-sofef00.c
+++ b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
@@ -34,14 +34,6 @@ struct sofef00_panel *to_sofef00_panel(struct drm_panel *panel)
 	return container_of(panel, struct sofef00_panel, panel);
 }
 
-#define dsi_dcs_write_seq(dsi, seq...) do {				\
-		static const u8 d[] = { seq };				\
-		int ret;						\
-		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static void sofef00_panel_reset(struct sofef00_panel *ctx)
 {
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
@@ -67,7 +59,7 @@ static int sofef00_panel_on(struct sofef00_panel *ctx)
 	}
 	usleep_range(10000, 11000);
 
-	dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
 
 	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
 	if (ret < 0) {
@@ -75,13 +67,13 @@ static int sofef00_panel_on(struct sofef00_panel *ctx)
 		return ret;
 	}
 
-	dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
-	dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
-	dsi_dcs_write_seq(dsi, 0xb0, 0x07);
-	dsi_dcs_write_seq(dsi, 0xb6, 0x12);
-	dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
-	dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x20);
-	dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
+	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq(dsi, 0xb0, 0x07);
+	mipi_dsi_dcs_write_seq(dsi, 0xb6, 0x12);
+	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x20);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
 
 	ret = mipi_dsi_dcs_set_display_on(dsi);
 	if (ret < 0) {
-- 
2.38.1

