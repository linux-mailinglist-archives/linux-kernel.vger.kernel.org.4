Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D88467C798
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbjAZJkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbjAZJj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:39:57 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBE95CFE4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:39:55 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso3821775wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g9aGpJns5SgWg0z8BSWVW6zwSMuvm0bnc+KZO7SfArc=;
        b=IZyGrTIRrDbz4InbWqSNvFY6qwhg9AIIG41TDCGNkDCJQbC3ESdKD3Q8ZMiMc7OFjH
         Fq+tx8k7E2RCQqiRqxrXkuo9bUi5t9BHeQl7Tqgch7rJ2sFyyno7evSNHFU/glk+ZmDP
         OYoetYCtTxPGj754w/ALAL8tOeHD3EKbZxBLgICLjBNe5RKs3OlRAwsbybPlQ8mEFLSY
         2uNBWFgzvkNZNE+YdTz+M0O9tm1N+lwxqSbuUBYdJZrkLDXlWs7lSVwKwt7DBaAgSKyA
         QyEx/6jVJ99ooLFJIxOU+asnKcPapH88CDn9h3XYuIWMk+6Yx5j1E5fVsCfXAvyQm/+J
         fSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9aGpJns5SgWg0z8BSWVW6zwSMuvm0bnc+KZO7SfArc=;
        b=RpWuukEQHfiYUVAYq1jo+JbyuT5B/5e21ZMzaoez7gNPvm55WEDDmIbGPawg4fQli7
         8JX3ObpO9gGoy8OeEMLaXhlMZtZ69IQgWIcG2AlM1PS44lwZTGMk1GYu+MIhXpG0VVHZ
         rlqzorxSYL3XXummVcAbO3VOknE3Uj4HCnoVkVFvydw+0IsbOKhIwiZn1Y2/Vxyt2fnS
         VGYJXRypqudkZHJ27qpjrDBUtrgzzYehDNjB9n4oC71daKUUR5O5aDAjW5+ANvQ5uNZh
         tjBpu6qizieBZJajrGWqkEqDpN9+7J26jlMOtTEWirrC7BvgKQsqd0KWYTVYCv80VguB
         t3Dg==
X-Gm-Message-State: AFqh2kpPNB3FAEulz2Widq4lh/AQ63DJS/WkbDR84mBsSo8pYhnhV/4k
        qLK41+Y+AqsqLyEDxXhBgkrg3g==
X-Google-Smtp-Source: AMrXdXvKP7X3PIQgQU+dDO/PF9OYHGMFlxmM7vU//xmZfVh+2o8Pom/JXrLdvx24PmPSikwWmAGxAQ==
X-Received: by 2002:a05:600c:502c:b0:3db:30d:deac with SMTP id n44-20020a05600c502c00b003db030ddeacmr34904000wmr.1.1674725994338;
        Thu, 26 Jan 2023 01:39:54 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c415100b003da2932bde0sm1182652wmm.23.2023.01.26.01.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 01:39:52 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 26 Jan 2023 10:39:42 +0100
Subject: [PATCH] drm/panel: khadas-ts050: update timings to achieve 60Hz
 refresh rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221025-ts050-timings-v1-1-5c824bbb24d9@linaro.org>
X-B4-Tracking: v=1; b=H4sIAF1K0mMC/w3LOwqAMAwA0KtIZgMxfhBv09aoAY3QqIt4dzu+4
 b3gklUcpuqFLI+6nlbQ1BWkLdgqqHMxMDE3xD1eTj3hpYfa6shL7CK1XeBhhHJicMGYg6WtLLv
 3/ft+wHXDQWQAAAA=
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates the panel timings to achieve a clean 60Hz refresh rate.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
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

