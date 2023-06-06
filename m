Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9806D724EC9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 23:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbjFFV2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 17:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjFFV2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:28:30 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B86710FB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 14:28:29 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d18d772bdso7340593b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 14:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686086908; x=1688678908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2sxRgoat8T+i5BlkEmmYkTauekQlW2JTibKZA6oBH7A=;
        b=KOlMnU2csedCuB+1N3G5sryayb2bGRmTmpeKSm7Db0/Yce0WZlnRrfipyKn3YaL9YB
         Gh9Mg52A/JXAKuTUNb0GJxYurFksnJ6ReX19vi5D1ZG1vz5L4RkBT9q4cU5a8eQVWG1w
         4Ajg7TegZnd7DSSTzd8BjqIPevIDAyAmqOz5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686086908; x=1688678908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sxRgoat8T+i5BlkEmmYkTauekQlW2JTibKZA6oBH7A=;
        b=fQsu7JKRUs44fGSWDejbJuj1GyjsBAg7y8DgZngr6MpJGJf+WR2Khbti3fMTZrkr9F
         mh+6ZwaDsSBMOh2wB5cSVXkMIfftTWV7SSYh9mrPMmmfbVHLZ04V8I5uxm5q3+ggwwOt
         A2+KPW8vLD7ZwPeBPkiX1R6/2EdNNEsTgiPLMbAGS2ZbtAuztLfDTXc+yOKKAI5VSwl/
         OLrrMQRBVRW9YIvg1Zu1Yj4xsCv5R//AXL7444qhEwNHd/HDHyAVbKYA0QY+gZEoSM8h
         i5CMCMeIw1rolXsjZ5JOHQcXesSUBhiAlEZSXnE/bBN6s8oVfXmplMC08gKcbJTC+ky/
         2n9Q==
X-Gm-Message-State: AC+VfDz4BsH+gDXCDjDJimYIP2Hhw2/PX7Q2jP3v/ZBiiOT4SCKKKjxi
        avhw1JFGLKmZFNQkpUVepGFvEvgJXL3dlFBwQPo=
X-Google-Smtp-Source: ACHHUZ6eVUGZvSc9BvXgHjP7hdptxeL7cYFm1fPWsO5lOhIXnPYN0sjI0aNLWvnZWtY+hKL8M+USsg==
X-Received: by 2002:a05:6a00:1585:b0:652:c336:e63e with SMTP id u5-20020a056a00158500b00652c336e63emr4458187pfk.31.1686086908535;
        Tue, 06 Jun 2023 14:28:28 -0700 (PDT)
Received: from ballway1.c.googlers.com.com (97.173.125.34.bc.googleusercontent.com. [34.125.173.97])
        by smtp.gmail.com with ESMTPSA id m3-20020aa78a03000000b005a8173829d5sm7283325pfa.66.2023.06.06.14.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 14:28:28 -0700 (PDT)
From:   Allen Ballway <ballway@chromium.org>
To:     jani.nikula@linux.intel.com
Cc:     arun.r.murthy@intel.com, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Allen Ballway <ballway@chromium.org>
Subject: [PATCH] drm/i915/quirk: Add quirk for devices that cannot be dimmed
Date:   Tue,  6 Jun 2023 21:25:13 +0000
Message-ID: <20230606211901.1.I06e778109090b5dc85c44da7b742d185aa6adb59@changeid>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cybernet T10C cannot be dimmed without the backlight strobing. Create a
new quirk to lock the minimum brightness to the highest supported value.
This aligns the device with its behavior on Windows, which will not
lower the brightness below maximum.

Signed-off-by: Allen Ballway <ballway@chromium.org>
---

 .../gpu/drm/i915/display/intel_backlight.c    |  6 +++++
 drivers/gpu/drm/i915/display/intel_quirks.c   | 27 +++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_quirks.h   |  1 +
 3 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
index 2e8f17c045222..863a33245a3d7 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -1192,6 +1192,11 @@ static u32 get_backlight_min_vbt(struct intel_connector *connector)

 	drm_WARN_ON(&i915->drm, panel->backlight.pwm_level_max == 0);

+	if (intel_has_quirk(i915, QUIRK_NO_DIM)) {
+		/* Cannot dim backlight, set minimum to hightest value */
+		return panel->backlight.pwm_level_max - 1;
+	}
+
 	/*
 	 * XXX: If the vbt value is 255, it makes min equal to max, which leads
 	 * to problems. There are such machines out there. Either our
@@ -1206,6 +1211,7 @@ static u32 get_backlight_min_vbt(struct intel_connector *connector)
 			    connector->panel.vbt.backlight.min_brightness, min);
 	}

+
 	/* vbt value is a coefficient in range [0..255] */
 	return scale(min, 0, 255, 0, panel->backlight.pwm_level_max);
 }
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index a280448df771a..910c95840a539 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -65,6 +65,12 @@ static void quirk_no_pps_backlight_power_hook(struct drm_i915_private *i915)
 	drm_info(&i915->drm, "Applying no pps backlight power quirk\n");
 }

+static void quirk_no_dim(struct drm_i915_private *i915)
+{
+	intel_set_quirk(i915, QUIRK_NO_DIM);
+	drm_info(&i915->drm, "Applying no dim quirk\n");
+}
+
 struct intel_quirk {
 	int device;
 	int subsystem_vendor;
@@ -90,6 +96,12 @@ static int intel_dmi_no_pps_backlight(const struct dmi_system_id *id)
 	return 1;
 }

+static int intel_dmi_no_dim(const struct dmi_system_id *id)
+{
+	DRM_INFO("No dimming allowed on %s\n", id->ident);
+	return 1;
+}
+
 static const struct intel_dmi_quirk intel_dmi_quirks[] = {
 	{
 		.dmi_id_list = &(const struct dmi_system_id[]) {
@@ -136,6 +148,20 @@ static const struct intel_dmi_quirk intel_dmi_quirks[] = {
 		},
 		.hook = quirk_no_pps_backlight_power_hook,
 	},
+	{
+		.dmi_id_list = &(const struct dmi_system_id[]) {
+			{
+				.callback = intel_dmi_no_dim,
+				.ident = "Cybernet T10C Tablet",
+				.matches = {DMI_EXACT_MATCH(DMI_BOARD_VENDOR,
+							    "Cybernet Manufacturing Inc."),
+					    DMI_EXACT_MATCH(DMI_BOARD_NAME, "T10C Tablet"),
+				},
+			},
+			{ }
+		},
+		.hook = quirk_no_dim,
+	},
 };

 static struct intel_quirk intel_quirks[] = {
@@ -218,6 +244,7 @@ void intel_init_quirks(struct drm_i915_private *i915)
 		     q->subsystem_device == PCI_ANY_ID))
 			q->hook(i915);
 	}
+
 	for (i = 0; i < ARRAY_SIZE(intel_dmi_quirks); i++) {
 		if (dmi_check_system(*intel_dmi_quirks[i].dmi_id_list) != 0)
 			intel_dmi_quirks[i].hook(i915);
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
index 10a4d163149fd..b41c7bbf0a5e3 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.h
+++ b/drivers/gpu/drm/i915/display/intel_quirks.h
@@ -17,6 +17,7 @@ enum intel_quirk_id {
 	QUIRK_INVERT_BRIGHTNESS,
 	QUIRK_LVDS_SSC_DISABLE,
 	QUIRK_NO_PPS_BACKLIGHT_POWER_HOOK,
+	QUIRK_NO_DIM,
 };

 void intel_init_quirks(struct drm_i915_private *i915);
--
2.41.0.162.gfafddb0af9-goog

