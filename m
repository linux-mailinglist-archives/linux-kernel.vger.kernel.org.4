Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253B9725449
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjFGGcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjFGGb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:31:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6DFAA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:31:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f732d37d7cso41478415e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 23:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1686119513; x=1688711513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVzHDRPJNZ9IK1tuBeqT97BbWRZLa0+X8FPJl3jJUF8=;
        b=UYvhY2b4HirdovbXfPtrGbUTJmn6mv0vjtYgUpqMd26yDC895U6FxmXqgAGGLQenPB
         FYBFTQymCHZR9yDzHZpZtmUct4e7yOQVQxu9U1J+GoTgNqgB2sTkk86EzY+LrPiny4+E
         xtH62ZWLxxlheBL841A43Q3wpYHfq0ZPA7qsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686119513; x=1688711513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVzHDRPJNZ9IK1tuBeqT97BbWRZLa0+X8FPJl3jJUF8=;
        b=AJSlhbG0s6AOFVShYuj67MKZwGznMNBoifr/dWFAsGTEr8M29LNfP+l4pkPAYm4Cnl
         IBlJpoDxu1DlZroP0CvjpAaBmuKmX6/jgrmVpk2CvXc9MWewHkK0rAr71UfYhTjECC+Z
         /Pz58HyEYx1WWdGHx9nuv8y6cpGizh/f9d4VumifqZ0KgQn/Dd1y3IBRfIcYLSErPs1G
         KpYugLVkLRjFc7PSke5pMSqCjWVFjgSNHkbDeaQyLAdj+KDyc4tKl2SpTiJiqA5gRQMc
         t3r/jJoHtHD+jvXDlLCk6D0K+PKfJoIZy/Y9nrno8G78ZTKIaM8ttlBB3bD9tyyNApTp
         Pfuw==
X-Gm-Message-State: AC+VfDyFuwavByAdfgJx/lATAdiw7GUjIA6pC9ZSQOKboH0ZRIdg4WSa
        ckkC0RxNTRE7DOGmDXK8wBeigHFy8QeXofvInsnVSg==
X-Google-Smtp-Source: ACHHUZ7femRg72fKhwkXtOViccaCRPhvLbf87oH15MUY/N6uqJKzd9GvRbot+SgLThtMLLZ1M23wWg==
X-Received: by 2002:adf:eb88:0:b0:309:38f4:fb52 with SMTP id t8-20020adfeb88000000b0030938f4fb52mr5870830wrn.9.1686119512971;
        Tue, 06 Jun 2023 23:31:52 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([37.159.114.163])
        by smtp.gmail.com with ESMTPSA id m6-20020adff386000000b0030630120e56sm14385127wro.57.2023.06.06.23.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 23:31:52 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        michael@amarulasolutions.com,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [RESEND PATCH v2 5/6] drm/panel: simple: add support for Rocktech RK043FN48H panel
Date:   Wed,  7 Jun 2023 08:31:38 +0200
Message-Id: <20230607063139.621351-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230607063139.621351-1-dario.binacchi@amarulasolutions.com>
References: <20230607063139.621351-1-dario.binacchi@amarulasolutions.com>
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

