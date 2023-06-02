Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C7B71FEEF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbjFBKV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjFBKVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:21:44 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF86198
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:21:43 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b1b1635661so3805291fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 03:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1685701301; x=1688293301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVzHDRPJNZ9IK1tuBeqT97BbWRZLa0+X8FPJl3jJUF8=;
        b=mMi7B8OLzoBy0XdAAy57UW6vUUYVs6mZUY0Eqj4wxd1azuZfGhxtdE7mSDOZMCdJVR
         IB2BbJdt79R6mNQXU43ev6H5pDzb6kBJbz06J8MyOaRw5PRn/2IQxDISZtggxt2HmCS0
         YnQ66M5U89s0AEJmmT1tOXh+wO2SEOodTG4jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701301; x=1688293301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVzHDRPJNZ9IK1tuBeqT97BbWRZLa0+X8FPJl3jJUF8=;
        b=CHuT4p9Np/gYBLb9SJXpcWhgt45cq0p5B0P7I4mQipA6u0XgfnRYJUhPOLEGSHfpVh
         oEbTbDplBNu/a83OYN9Y1VxvtuPWTK7+WUvlDabOzCKF7xloE+DlC+qUEgi9leDDKlgL
         mlJfptQ3telWCcEikr3HL9UeVumOuxJ3R8iHa3Eq7l258Dg5TW63JdldNmfIB/ugYTvu
         6vXvx6ycJm+7xAOF2W+GgOS8B/VjEk4fYNUtmClId2ASd6WzZhcJyTZU4oVoJwza3501
         Ap1N5V9Nc131yGKfptedH2GAk0gVkZVttmfR+lAvsiG0YzqtL67xTnTU4dvBO9gwv6/s
         /w1Q==
X-Gm-Message-State: AC+VfDwUva7BYZ3qgA1srwY6bXFLs9ZI55zxQZcoozFICPz6B0keRzM8
        MlA5T3NCE5OmV79YTPBrJWv0XR6fjIK1jcgz+JnSEQ==
X-Google-Smtp-Source: ACHHUZ6Ed45kcIADNWUp9NNVg26d/KpiaFAlx21eReeknhNRdp8zZ84PfjAecQZ4ZkYv7TO8lp7/GA==
X-Received: by 2002:a2e:8e89:0:b0:2ac:d51f:2d60 with SMTP id z9-20020a2e8e89000000b002acd51f2d60mr1241778ljk.33.1685701301140;
        Fri, 02 Jun 2023 03:21:41 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-248-31-20.retail.telecomitalia.it. [95.248.31.20])
        by smtp.gmail.com with ESMTPSA id x24-20020aa7d398000000b0051499320435sm528887edq.14.2023.06.02.03.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:21:40 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 5/6] drm/panel: simple: add support for Rocktech RK043FN48H panel
Date:   Fri,  2 Jun 2023 12:21:21 +0200
Message-Id: <20230602102123.3345587-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230602102123.3345587-1-dario.binacchi@amarulasolutions.com>
References: <20230602102123.3345587-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Rocktech RK043FN48H 4.3" (480x272) LCD-TFT panel.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306020343.jNTWeM0P-lkp@intel.com/

---

Changes in v2:
- Fix build warning reported by kernel test robot.
- Add 'Reported-by' tag of kernel test robot.

 drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 065f378bba9d..3b10e78d07d9 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3188,6 +3188,32 @@ static const struct panel_desc qishenglong_gopher2b_lcd = {
 	.connector_type = DRM_MODE_CONNECTOR_DPI,
 };
 
+static const struct display_timing rocktech_rk043fn48h_timing = {
+	.pixelclock = { 6000000, 9000000, 12000000 },
+	.hactive = { 480, 480, 480 },
+	.hback_porch = { 8, 43, 43 },
+	.hfront_porch = { 2, 8, 8 },
+	.hsync_len = { 1, 1, 1 },
+	.vactive = { 272, 272, 272 },
+	.vback_porch = { 2, 12, 12 },
+	.vfront_porch = { 1, 4, 4 },
+	.vsync_len = { 1, 10, 10 },
+	.flags = DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_HSYNC_LOW |
+		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE,
+};
+
+static const struct panel_desc rocktech_rk043fn48h = {
+	.timings = &rocktech_rk043fn48h_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 95,
+		.height = 54,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+};
+
 static const struct display_timing rocktech_rk070er9427_timing = {
 	.pixelclock = { 26400000, 33300000, 46800000 },
 	.hactive = { 800, 800, 800 },
@@ -4218,6 +4244,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "qishenglong,gopher2b-lcd",
 		.data = &qishenglong_gopher2b_lcd,
+	}, {
+		.compatible = "rocktech,rk043fn48h",
+		.data = &rocktech_rk043fn48h,
 	}, {
 		.compatible = "rocktech,rk070er9427",
 		.data = &rocktech_rk070er9427,
-- 
2.32.0

