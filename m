Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16EF70E57E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbjEWTbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjEWTbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:31:34 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB7C132
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:31:13 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae85b71141so508075ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684870273; x=1687462273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKRK4xfTer6o8sAg3PoM2xcqa0uawxE5nHuVWKhZwR0=;
        b=F+RFRAAVkb14F3v0JkgcAWWjh6tAt8ecJgxOH0c24t+NptgnNpm3yQZQ4chcrhs6tm
         PmNunCCzD43Hl4JOutjqj+OkMvfjL9s/Hy5YtWhcfZCwQP+UezJfVTMEClILyKcpUTXP
         hSME9ktlQEYrUZ+NXyBfWVdcr5AxjahHC70oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870273; x=1687462273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKRK4xfTer6o8sAg3PoM2xcqa0uawxE5nHuVWKhZwR0=;
        b=GWrEr+aoYnlrlPNYjiT8TgKz3FMb3TgjtzpcSLPh1s3tL9iIXmV1acE3WWvS+Uow24
         hXPdfZmBFOrBegSfSr6EhFC4hPc/MLZwetktYK9NxqqGe8aok/gQArmoynqCT6pcJh9E
         jaM02P1j+vRStZOx/X5jOQhTGinWLxYrvqJM1eb5H8Oc83SyDLGXYFjCiagf5ZyeY6qq
         zzxNxvmcW3o61+3Bzlkba7XAYcrBwwcHLtAvk3x749xm1cBIxRWbua90dCMpOlY+Vixm
         UE1501Rc8I/+XvqLxwJYu8VaC/hMPrRZE5grBV+7gZx8YLg/P/NHlBOyp7FMftgwvoP8
         LMSw==
X-Gm-Message-State: AC+VfDwYCgq38iitFOXbSAXjATwS19PQjF5UYV6PbnZ64H5Cbb6nKUzW
        2VcHA2MnmRLvP09bVqgd5kXHDQ==
X-Google-Smtp-Source: ACHHUZ6+R5dtBFK1umveld97BEXM7URbVt+ovbFLPIhv1kkW0xyJu3i7kIBJg1vLIb01UTdBgQqzTg==
X-Received: by 2002:a17:902:d2c2:b0:1ac:4412:bd9 with SMTP id n2-20020a170902d2c200b001ac44120bd9mr14843362plc.3.1684870272940;
        Tue, 23 May 2023 12:31:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:af98:af9d:ed15:f8b3])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b001aaef9d0102sm7109947plr.197.2023.05.23.12.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 12:31:12 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, hsinyi@google.com,
        devicetree@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 2/9] drm/panel: Check for already prepared/enabled in drm_panel
Date:   Tue, 23 May 2023 12:27:56 -0700
Message-ID: <20230523122802.2.I59b417d4c29151cc2eff053369ec4822b606f375@changeid>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230523193017.4109557-1-dianders@chromium.org>
References: <20230523193017.4109557-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a whole pile of panel drivers, we have code to make the
prepare/unprepare/enable/disable callbacks behave as no-ops if they've
already been called. It's silly to have this code duplicated
everywhere. Add it to the core instead so that we can eventually
delete it from all the drivers. Note: to get some idea of the
duplicated code, try:
  git grep 'if.*>prepared' -- drivers/gpu/drm/panel
  git grep 'if.*>enabled' -- drivers/gpu/drm/panel

NOTE: arguably, the right thing to do here is actually to skip this
patch and simply remove all the extra checks from the individual
drivers. Perhaps the checks were needed at some point in time in the
past but maybe they no longer are? Certainly as we continue
transitioning over to "panel_bridge" then we expect there to be much
less variety in how these calls are made. When we're called as part of
the bridge chain, things should be pretty simple. In fact, there was
some discussion in the past about these checks [1], including a
discussion about whether the checks were needed and whether the calls
ought to be refcounted. At the time, I decided not to mess with it
because it felt too risky.

Looking closer at it now, I'm fairly certain that nothing in the
existing codebase is expecting these calls to be refcounted. The only
real question is whether someone is already doing something to ensure
prepare()/unprepare() match and enabled()/disable() match. I would say
that, even if there is something else ensuring that things match,
there's enough complexity that adding an extra bool and an extra
double-check here is a good idea. Let's add a drm_warn() to let people
know that it's considered a minor error to take advantage of
drm_panel's double-checking but we'll still make things work fine.

[1] https://lore.kernel.org/r/20210416153909.v4.27.I502f2a92ddd36c3d28d014dd75e170c2d405a0a5@changeid

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/drm_panel.c | 49 ++++++++++++++++++++++++++++++++-----
 include/drm/drm_panel.h     | 14 +++++++++++
 2 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index f634371c717a..4e1c4e42575b 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -105,11 +105,22 @@ EXPORT_SYMBOL(drm_panel_remove);
  */
 int drm_panel_prepare(struct drm_panel *panel)
 {
+	int ret;
+
 	if (!panel)
 		return -EINVAL;
 
-	if (panel->funcs && panel->funcs->prepare)
-		return panel->funcs->prepare(panel);
+	if (panel->prepared) {
+		dev_warn(panel->dev, "Skipping prepare of already prepared panel\n");
+		return 0;
+	}
+
+	if (panel->funcs && panel->funcs->prepare) {
+		ret = panel->funcs->prepare(panel);
+		if (ret < 0)
+			return ret;
+	}
+	panel->prepared = true;
 
 	return 0;
 }
@@ -128,11 +139,22 @@ EXPORT_SYMBOL(drm_panel_prepare);
  */
 int drm_panel_unprepare(struct drm_panel *panel)
 {
+	int ret;
+
 	if (!panel)
 		return -EINVAL;
 
-	if (panel->funcs && panel->funcs->unprepare)
-		return panel->funcs->unprepare(panel);
+	if (!panel->prepared) {
+		dev_warn(panel->dev, "Skipping unprepare of already unprepared panel\n");
+		return 0;
+	}
+
+	if (panel->funcs && panel->funcs->unprepare) {
+		ret = panel->funcs->unprepare(panel);
+		if (ret < 0)
+			return ret;
+	}
+	panel->prepared = false;
 
 	return 0;
 }
@@ -155,11 +177,17 @@ int drm_panel_enable(struct drm_panel *panel)
 	if (!panel)
 		return -EINVAL;
 
+	if (panel->enabled) {
+		dev_warn(panel->dev, "Skipping enable of already enabled panel\n");
+		return 0;
+	}
+
 	if (panel->funcs && panel->funcs->enable) {
 		ret = panel->funcs->enable(panel);
 		if (ret < 0)
 			return ret;
 	}
+	panel->enabled = true;
 
 	ret = backlight_enable(panel->backlight);
 	if (ret < 0)
@@ -187,13 +215,22 @@ int drm_panel_disable(struct drm_panel *panel)
 	if (!panel)
 		return -EINVAL;
 
+	if (!panel->enabled) {
+		dev_warn(panel->dev, "Skipping disable of already disabled panel\n");
+		return 0;
+	}
+
 	ret = backlight_disable(panel->backlight);
 	if (ret < 0)
 		DRM_DEV_INFO(panel->dev, "failed to disable backlight: %d\n",
 			     ret);
 
-	if (panel->funcs && panel->funcs->disable)
-		return panel->funcs->disable(panel);
+	if (panel->funcs && panel->funcs->disable) {
+		ret = panel->funcs->disable(panel);
+		if (ret < 0)
+			return ret;
+	}
+	panel->enabled = false;
 
 	return 0;
 }
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 432fab2347eb..c6cf75909389 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -198,6 +198,20 @@ struct drm_panel {
 	 * the panel is powered up.
 	 */
 	bool prepare_prev_first;
+
+	/**
+	 * @prepared:
+	 *
+	 * If true then the panel has been prepared.
+	 */
+	bool prepared;
+
+	/**
+	 * @enabled:
+	 *
+	 * If true then the panel has been enabled.
+	 */
+	bool enabled;
 };
 
 void drm_panel_init(struct drm_panel *panel, struct device *dev,
-- 
2.40.1.698.g37aff9b760-goog

