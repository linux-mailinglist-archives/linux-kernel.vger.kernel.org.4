Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E3F742B20
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjF2RVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjF2RVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:21:19 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6684D3596
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:21:18 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso687919a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688059278; x=1690651278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsgtV3gsuq2XfON4jvCyFxoryk5TOcuLFWUrBaX1WYY=;
        b=SUTgBd7nnKI0lCrtVJiG7+3eZDAdgWm+jqhpR1qYQX+VKo8E+Ff/CNM75hMhboRsJU
         TxiwFqauGpbkgjfGrhTeuSSoXISlSB6rinGGKxXTpOh2NvmrOr3P1vwxQ63RIneIQWPR
         FLlL1TvmkJmaOuAD0hDCkJBRHu4s2OjArQMTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688059278; x=1690651278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsgtV3gsuq2XfON4jvCyFxoryk5TOcuLFWUrBaX1WYY=;
        b=VRSbrGZnrzPIVBUAEaTSWhp9ywhSB3YMKAbwe/q2ktJDmS8UlwxDlkv/TsvQzUolVj
         t/GNkCzVfXnJ812VaTpGOW3zive0srXV5We2Bo/7U9dSDrydjbmYVb6gY16z5WdryW3N
         ETDjEh8Ce6CoGknD0P1v4mnvkn9pCi3L+BB0XXF358/kLdr0kpcD35xAN5pEAn5ADhoS
         VcTV9Quh6lqnbIERc+yjdYDyHVekMeAx9W/Df59Q3CnL0i4LVaUScvcB0QlF7JjDTt8S
         fzXkiNRRqHIal37OQCwbUqpqkb1f/CpAk3djwuYuddJlZ8arSBzQLVuBBOkTFJfZGlcu
         KqZQ==
X-Gm-Message-State: AC+VfDw6ZpfMuhNeK9oBw1IxVb6z+M9lE91gtx1JH5uV0+IbUp1nPks1
        76ljnEel8yGZUBREqRB7oCXkoA==
X-Google-Smtp-Source: ACHHUZ6KjoaHUbB1snQx6KA7V/+Rdn+D2dm/vCMRfsOaMIH21tGOCvSGK9Vi3lxTbhTpP3XPToJ1qQ==
X-Received: by 2002:a05:6a20:1586:b0:122:de52:eaf4 with SMTP id h6-20020a056a20158600b00122de52eaf4mr379759pzj.22.1688059277859;
        Thu, 29 Jun 2023 10:21:17 -0700 (PDT)
Received: from ballway1.c.googlers.com.com (97.173.125.34.bc.googleusercontent.com. [34.125.173.97])
        by smtp.gmail.com with ESMTPSA id q136-20020a632a8e000000b0055b0c330b30sm4487060pgq.84.2023.06.29.10.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 10:21:17 -0700 (PDT)
From:   Allen Ballway <ballway@chromium.org>
To:     josh@joshtriplett.org
Cc:     arun.r.murthy@intel.com, ballway@chromium.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/quirk: Add quirk for devices that cannot be dimmed
Date:   Thu, 29 Jun 2023 17:21:02 +0000
Message-ID: <20230629172106.3798019-1-ballway@chromium.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <ZJSKBg+LymhvINoG@localhost>
References: <ZJSKBg+LymhvINoG@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
V2 -> V3: Fix typo.
V1 -> V2: Fix style issue.

.../gpu/drm/i915/display/intel_backlight.c    |  5 ++++
 drivers/gpu/drm/i915/display/intel_quirks.c   | 27 +++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_quirks.h   |  1 +
 3 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
index 2e8f17c045222..f015563d3ebd5 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -1192,6 +1192,11 @@ static u32 get_backlight_min_vbt(struct intel_connector *connector)

 	drm_WARN_ON(&i915->drm, panel->backlight.pwm_level_max == 0);

+	if (intel_has_quirk(i915, QUIRK_NO_DIM)) {
+		/* Cannot dim backlight, set minimum to highest value */
+		return panel->backlight.pwm_level_max - 1;
+	}
+
 	/*
 	 * XXX: If the vbt value is 255, it makes min equal to max, which leads
 	 * to problems. There are such machines out there. Either our
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
2.41.0.255.g8b1d071c50-goog

