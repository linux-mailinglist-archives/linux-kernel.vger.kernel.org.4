Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55A371F034
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjFAREM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjFARD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:03:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7A3195
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:03:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96f850b32caso162950866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 10:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1685639032; x=1688231032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdElKIu+1cRclMUkHfLP6gJRhgH3ar2X29sNtbMoMuI=;
        b=hMITaXHxvJ0/6V49p/77QVqaWFXoe1YjU/+69GevnlKUdpZYaRjWcwQTaTldImYEbq
         VZUBQS6w+K6g5jn5x14c7Lu+zj8LCcRN2SZojZ6nhvsZiy/MXSeEyed/a/4llYaWc8SL
         Xrvd7Inu3eC8+2XKLZ/mi0wAJEulmiAXs3/oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685639032; x=1688231032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdElKIu+1cRclMUkHfLP6gJRhgH3ar2X29sNtbMoMuI=;
        b=kX533tdio/Sexg5QN6ukb60C9qtG6lW6UvKpc5FWbaR2Qe///mVRt0fDjTE6VQAe8+
         rv+Uv5LpcSvgkCyYNmfg+9YJefdXqwgWTXcaHCj7tkUM2zarKkOpBkiZmCcsTSOTCJC7
         hMiDy360VB52pmDgiXFeKZ6WzZOc7S930Hm6xqPuwXGaXbFHAziCwVK+WFTRhckmxBd6
         Z6UcaGRI9H9G/R8UP37HVs7vn3+N6O1J9JVinU/Zw7atRvqUxm3rr1otsn2Naya4qVpb
         O+mb7dTVh8Fnu9zaecQjtmzEPZyNh7ayyb3ushl7e+WncOZARkArKE4GsYxM+xeOod2b
         tG2g==
X-Gm-Message-State: AC+VfDy041IBHINPouD1SKTRX+jpLaz9zrxSI2g4lBOsGZVd4ct7mINi
        BUvg6N/bfijSe0F5siWb13i4pu5u2WC8kHWleZQt+Q==
X-Google-Smtp-Source: ACHHUZ7q6ifChzQbDQBZTUfEt3PO1GbSHVs0LKyrGDjyYdrlmbXnspinqqOAtt/lVAsXNNCaykR6QA==
X-Received: by 2002:a17:907:2d9f:b0:94e:e97b:c65 with SMTP id gt31-20020a1709072d9f00b0094ee97b0c65mr9290200ejc.60.1685639032574;
        Thu, 01 Jun 2023 10:03:52 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-248-31-20.retail.telecomitalia.it. [95.248.31.20])
        by smtp.gmail.com with ESMTPSA id bh25-20020a170906a0d900b0096165b2703asm10658522ejb.110.2023.06.01.10.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 10:03:52 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 5/6] drm/panel: simple: add support for Rocktech RK043FN48H panel
Date:   Thu,  1 Jun 2023 19:03:19 +0200
Message-Id: <20230601170320.2845218-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230601170320.2845218-1-dario.binacchi@amarulasolutions.com>
References: <20230601170320.2845218-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Rocktech RK043FN48H 4.3" (480x272) LCD-TFT panel.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 065f378bba9d..e8e2b2a55f37 100644
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
+	.flags = DISPLAY_FLAGS_VSYNC_LOW + DISPLAY_FLAGS_HSYNC_LOW |
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

