Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958D260D0E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiJYPlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiJYPlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:41:50 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D244C02C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:41:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k8so13126180wrh.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ARqyqo3HxwELLENCNcBHViWWddo+7tDukUTLtjIqP7Q=;
        b=yhR26ByW8L4aOLdLVfAVHO3mGe5c+VYr6fgBSxajZmTlR4gezi7235ziAvX7MOtvXU
         QqOY22m28l196CJrJvhw88bFI2zUblULB9PnTPabSgkreG8/17sUkNnL4xLqIwKs3mlO
         e64PcPZNq42Vtq/vTRMMrIByHlCksqy85JZxYxBXdcT5rzorPYmYC3aeR5DFdQ/bkeNz
         0yIOLCjzNBb7XCPsJeLX3mB25TN6U+oqSKiv4N1jJt5IWnfZgTOUmIv30OQ5ddLZQU/c
         fTtF8cxPaTaJT57PhrjhQCCEKwGesIun5k+BR9iyFiZmZXW9O8KxWzQKUMGAGZJKz3tE
         6nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ARqyqo3HxwELLENCNcBHViWWddo+7tDukUTLtjIqP7Q=;
        b=DEoZxA+HtBiP6dWlrzVa56WpA4h6g+amvtDRQrIQj42IkoPWOAKG5v6WC8XktLdtoL
         ivKsIugTkwmH4SYYo1R5lNk+Jf2y5bbzxz5uNG/aZzvBXKFiO4i4+M3waRJ9Pje0NYRn
         /d0yiHRd12ecDG3UImZAOnX45bsEyC3QD8bQnDqWFAPp+81gj+bKyFqjkgNn/Iik7GH4
         fAnDVYkjfPScVIPhZojaNuYewHvL3WxnK3o3lZ9/i6edwgFK497RHjZRz2bFiKF5USN+
         GGyogFcY8MbxXAYPmh8wou97hQxzd3GwDAmyCoAxRaVAnCi13WmTUnaV6eOq3g43bNJd
         Wq0Q==
X-Gm-Message-State: ACrzQf23PLhxIfF041pF13OOsIiFDakTyYGI/6m5B5RQ/FCBe93wwJn6
        MwrT8vkyDfrMQa+1IcpA9SuZ/g==
X-Google-Smtp-Source: AMsMyM7hU8P1pHqEnztNH+cnBBDz+KOlEdjcte6dDTB7t1Y0VcQSmnanSySLd0xIEg8izkZjTIX5Sg==
X-Received: by 2002:a5d:5a0c:0:b0:22f:608:48b with SMTP id bq12-20020a5d5a0c000000b0022f0608048bmr26205512wrb.84.1666712508652;
        Tue, 25 Oct 2022 08:41:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id v26-20020a5d591a000000b0022cd96b3ba6sm3541463wrd.90.2022.10.25.08.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:41:48 -0700 (PDT)
From:   neil.armstrong@linaro.org
To:     Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/panel: khadas-ts050: update timings to achieve 60Hz refresh rate
Date:   Tue, 25 Oct 2022 17:41:45 +0200
Message-Id: <20221025-ts050-timings-v1-0-c95a60acf935@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <neil.armstrong@linaro.org>

This updates the panel timings to achieve a clean 60Hz refresh rate.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
To: Sam Ravnborg <sam@ravnborg.org>
To: David Airlie <airlied@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/panel/panel-khadas-ts050.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-khadas-ts050.c b/drivers/gpu/drm/panel/panel-khadas-ts050.c
index 1ab1ebe30882..e0cebfa14b36 100644
--- a/drivers/gpu/drm/panel/panel-khadas-ts050.c
+++ b/drivers/gpu/drm/panel/panel-khadas-ts050.c
@@ -568,7 +568,7 @@ static const struct khadas_ts050_panel_cmd init_code[] = {
 	{0xfb, 0x01},
 	/* Select CMD1 */
 	{0xff, 0x00},
-	{0xd3, 0x05}, /* RGBMIPICTRL: VSYNC back porch = 5 */
+	{0xd3, 0x22}, /* RGBMIPICTRL: VSYNC back porch = 34 */
 	{0xd4, 0x04}, /* RGBMIPICTRL: VSYNC front porch = 4 */
 };
 
@@ -717,15 +717,15 @@ static int khadas_ts050_panel_disable(struct drm_panel *panel)
 }
 
 static const struct drm_display_mode default_mode = {
-	.clock = 120000,
-	.hdisplay = 1088,
-	.hsync_start = 1088 + 104,
-	.hsync_end = 1088 + 104 + 4,
-	.htotal = 1088 + 104 + 4 + 127,
+	.clock = 160000,
+	.hdisplay = 1080,
+	.hsync_start = 1080 + 117,
+	.hsync_end = 1080 + 117 + 5,
+	.htotal = 1080 + 117 + 5 + 160,
 	.vdisplay = 1920,
-	.vsync_start = 1920 + 4,
-	.vsync_end = 1920 + 4 + 2,
-	.vtotal = 1920 + 4 + 2 + 3,
+	.vsync_start = 1920 + 4 ,
+	.vsync_end = 1920 + 4 + 3,
+	.vtotal = 1920 + 4 + 3 + 31 ,
 	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
 };
 

---
base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740
change-id: 20221025-ts050-timings-2fb4b034a268

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
