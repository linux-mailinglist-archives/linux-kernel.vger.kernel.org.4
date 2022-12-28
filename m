Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC036571D1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiL1Btt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiL1Bte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:49:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E2110B1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672192098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hmJG1EQCcWrXtV6d3Al7nh8+VaY4Dt6NOgL2LFmlf+I=;
        b=JzzckhvIL2FElcE5k6jHTqaC4T2p2+ZvuweS+H8imh12Xfe/T9H2WL59nXUiCqeIzambWV
        y4FprvxJVqDvI5fwRWrMsJpw2tYNiwAjriUD+pyr5ufpyzWHjW+Bwz/tYN3XA0jfeFPp1k
        /yBCm1R+C+3IBEod5MYYvUrD9YQzEl4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-122-KDFsHOTOPeC5rnzuLu5IPA-1; Tue, 27 Dec 2022 20:48:17 -0500
X-MC-Unique: KDFsHOTOPeC5rnzuLu5IPA-1
Received: by mail-wm1-f69.google.com with SMTP id bg10-20020a05600c3c8a00b003d9717d882eso6800838wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmJG1EQCcWrXtV6d3Al7nh8+VaY4Dt6NOgL2LFmlf+I=;
        b=1aXN492eZOhyB6jVkFXqN4R10el6OvPzuk+Wjw5rTC2t9V+QCC7aRsqRlOX47c4Nov
         Q4ODCdPTKQaTZXGZx1d20YDWRQu19FtIvnDM66klfq6cGPF1k8q0PZ7ZWuWmEeun/+QB
         4Zy6FOiuq/krCtekGiJ7hqr8PKBKL/BLHNwH/beLJv0RAiqrH8u9r8mrari+8H0xONfv
         rGLVTwmfTzZprcWa51ItZi7UsIa5gVkpMsG/y1Pd8acbOKKwdma7mTPwYCL360ulyZ1n
         6JsOm8EKYzsOnkVmIc2uYbly8RcHrq+34ldZcQvdxyqKRFkKs/m80jZQUK/jy5sHx2FV
         xYuQ==
X-Gm-Message-State: AFqh2krebqxU77Tt/XcZ+ElU6ViFu0troHFSWXWFE7OwHqqen+ovXhCj
        cenZDcY9DZaMKq1GPhAxy3uXcH3qpBATWbGrzexCqwedIWfRJnGM7TEi4GCNY3x8PJGkF4Rjk4Q
        dmwk2vJNFClipzEOrZq7KG8Ac+rKCUCV5KvOPbH/cj70XQpXm7faIFalxwclt6fEK5qE5GKu5kb
        w=
X-Received: by 2002:a05:600c:798:b0:3d3:5737:3b0f with SMTP id z24-20020a05600c079800b003d357373b0fmr21465774wmo.36.1672192095561;
        Tue, 27 Dec 2022 17:48:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvE039uOLT+JN8vfvtYuN2+Wum9q322X6qb0mg5MVp6KJm5OqUaUJPFPONLpc3nVXyzRZciQA==
X-Received: by 2002:a05:600c:798:b0:3d3:5737:3b0f with SMTP id z24-20020a05600c079800b003d357373b0fmr21465759wmo.36.1672192095255;
        Tue, 27 Dec 2022 17:48:15 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b002258235bda3sm14158873wrx.61.2022.12.27.17.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:48:14 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 08/14] drm/panel-jdi-fhd-r63452: Drop custom DSI write macros
Date:   Wed, 28 Dec 2022 02:47:51 +0100
Message-Id: <20221228014757.3170486-9-javierm@redhat.com>
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

 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 50 +++++++-------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
index d8765b2294fb..e3f0e59b5e36 100644
--- a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
+++ b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
@@ -29,22 +29,6 @@ static inline struct jdi_fhd_r63452 *to_jdi_fhd_r63452(struct drm_panel *panel)
 	return container_of(panel, struct jdi_fhd_r63452, panel);
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
 static void jdi_fhd_r63452_reset(struct jdi_fhd_r63452 *ctx)
 {
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
@@ -63,12 +47,12 @@ static int jdi_fhd_r63452_on(struct jdi_fhd_r63452 *ctx)
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	dsi_generic_write_seq(dsi, 0xb0, 0x00);
-	dsi_generic_write_seq(dsi, 0xd6, 0x01);
-	dsi_generic_write_seq(dsi, 0xec,
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xd6, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xec,
 			      0x64, 0xdc, 0xec, 0x3b, 0x52, 0x00, 0x0b, 0x0b,
 			      0x13, 0x15, 0x68, 0x0b, 0xb5);
-	dsi_generic_write_seq(dsi, 0xb0, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x03);
 
 	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
 	if (ret < 0) {
@@ -76,7 +60,7 @@ static int jdi_fhd_r63452_on(struct jdi_fhd_r63452 *ctx)
 		return ret;
 	}
 
-	dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
 
 	ret = mipi_dsi_dcs_set_pixel_format(dsi, 0x77);
 	if (ret < 0) {
@@ -108,10 +92,10 @@ static int jdi_fhd_r63452_on(struct jdi_fhd_r63452 *ctx)
 		return ret;
 	}
 
-	dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24);
-	dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
-	dsi_dcs_write_seq(dsi, MIPI_DCS_SET_CABC_MIN_BRIGHTNESS, 0x00);
-	dsi_dcs_write_seq(dsi, 0x84, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_CABC_MIN_BRIGHTNESS, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0x84, 0x00);
 
 	ret = mipi_dsi_dcs_set_display_on(dsi);
 	if (ret < 0) {
@@ -127,10 +111,10 @@ static int jdi_fhd_r63452_on(struct jdi_fhd_r63452 *ctx)
 	}
 	msleep(80);
 
-	dsi_generic_write_seq(dsi, 0xb0, 0x04);
-	dsi_dcs_write_seq(dsi, 0x84, 0x00);
-	dsi_generic_write_seq(dsi, 0xc8, 0x11);
-	dsi_generic_write_seq(dsi, 0xb0, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x04);
+	mipi_dsi_dcs_write_seq(dsi, 0x84, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xc8, 0x11);
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x03);
 
 	return 0;
 }
@@ -143,12 +127,12 @@ static int jdi_fhd_r63452_off(struct jdi_fhd_r63452 *ctx)
 
 	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
-	dsi_generic_write_seq(dsi, 0xb0, 0x00);
-	dsi_generic_write_seq(dsi, 0xd6, 0x01);
-	dsi_generic_write_seq(dsi, 0xec,
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xd6, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xec,
 			      0x64, 0xdc, 0xec, 0x3b, 0x52, 0x00, 0x0b, 0x0b,
 			      0x13, 0x15, 0x68, 0x0b, 0x95);
-	dsi_generic_write_seq(dsi, 0xb0, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x03);
 
 	ret = mipi_dsi_dcs_set_display_off(dsi);
 	if (ret < 0) {
-- 
2.38.1

