Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC41B65F9E0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjAFDCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjAFDBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:01:55 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A433B6A0D0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 19:01:11 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b2so365079pld.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 19:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FLEA2wQkQBIO15nu3HyGaLDd58pUqyHA63e/BahflBg=;
        b=gr1lwpg+ZbMVA7VcYOW5YvvzRvyk56qGEw34yRLVGhuBq+su/XvHWcwtgeYG5Q5API
         kQWl20V6HCSzhC+y3lpli6F+e5NnCI736lNGtNY3CR7LWYw9K1WOVN8CmTdTLHH/VHT1
         /UbBKNWAAha3z8idSR8hR8tlBNBJY87nnTfCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLEA2wQkQBIO15nu3HyGaLDd58pUqyHA63e/BahflBg=;
        b=A9A3bps1d/RtzLNg6SS8iIYgOynQvcNDtXTxssk/0jMcYaf3hQ8L7/20RDMBvGmpp7
         VUizjiuMkWFP5PviYpDo9JXyc3/a6RPAD/hyfU4Z1C43dOdVMUn1otvVxezi584yOf0J
         b2+JqDx2Ac2PQqLyNjw/MYh4Hol4xnQwGobqF+tQr2gNhNm5d7MtaEss8qQkdsRjPwZH
         wBZdkdizF3xTwrsbFygNkFplB/uNXXgw8gfhAxP8CceJIKaklPYgyGztlq8Yi9JHq05E
         hryci+CVcuPFczryGP+TXSKCFSpfcKNwf3GDFW1uVCUOO8Yaw1MvJeRVwpcLeewuhhFS
         ao/A==
X-Gm-Message-State: AFqh2kqB/YXWl3qayyPrdU4PhQxeCfFAZc0TMjHoruef4cD47azAIqvp
        Wmf630UpF2At9y8WdNkJfMh0WQ==
X-Google-Smtp-Source: AMrXdXsomxVgbccv1usflDMgeLmsRP7BhyBVOMFDU6WowU+xXCKfXlkP0R8LnNIfb1r5yNksWji+AQ==
X-Received: by 2002:a05:6a20:cb44:b0:af:e129:cc4 with SMTP id hd4-20020a056a20cb4400b000afe1290cc4mr51387940pzb.41.1672974071148;
        Thu, 05 Jan 2023 19:01:11 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:11a:201:d024:f69:ad7c:2653])
        by smtp.gmail.com with ESMTPSA id g38-20020a635666000000b004768b74f208sm21320pgm.4.2023.01.05.19.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 19:01:10 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH] drm/panel: boe-tv101wum-nl6: Ensure DSI writes succeed during disable
Date:   Thu,  5 Jan 2023 19:01:08 -0800
Message-Id: <20230106030108.2542081-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unprepare sequence has started to fail after moving to panel bridge
code in the msm drm driver (commit 007ac0262b0d ("drm/msm/dsi: switch to
DRM_PANEL_BRIDGE")). You'll see messages like this in the kernel logs:

   panel-boe-tv101wum-nl6 ae94000.dsi.0: failed to set panel off: -22

This is because boe_panel_enter_sleep_mode() needs an operating DSI link
to set the panel into sleep mode. Performing those writes in the
unprepare phase of bridge ops is too late, because the link has already
been torn down by the DSI controller in post_disable, i.e. the PHY has
been disabled, etc. See dsi_mgr_bridge_post_disable() for more details
on the DSI .

Split the unprepare function into a disable part and an unprepare part.
For now, just the DSI writes to enter sleep mode are put in the disable
function. This fixes the panel off routine and keeps the panel happy.

My Wormdingler has an integrated touchscreen that stops responding to
touch if the panel is only half disabled too. This patch fixes it. And
finally, this saves power when the screen is off because without this
fix the regulators for the panel are left enabled when nothing is being
displayed on the screen.

Fixes: 007ac0262b0d ("drm/msm/dsi: switch to DRM_PANEL_BRIDGE")
Fixes: a869b9db7adf ("drm/panel: support for boe tv101wum-nl6 wuxga dsi video mode panel")
Cc: yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Jitao Shi <jitao.shi@mediatek.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Rob Clark <robdclark@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 857a2f0420d7..c924f1124ebc 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1193,14 +1193,11 @@ static int boe_panel_enter_sleep_mode(struct boe_panel *boe)
 	return 0;
 }
 
-static int boe_panel_unprepare(struct drm_panel *panel)
+static int boe_panel_disable(struct drm_panel *panel)
 {
 	struct boe_panel *boe = to_boe_panel(panel);
 	int ret;
 
-	if (!boe->prepared)
-		return 0;
-
 	ret = boe_panel_enter_sleep_mode(boe);
 	if (ret < 0) {
 		dev_err(panel->dev, "failed to set panel off: %d\n", ret);
@@ -1209,6 +1206,16 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 
 	msleep(150);
 
+	return 0;
+}
+
+static int boe_panel_unprepare(struct drm_panel *panel)
+{
+	struct boe_panel *boe = to_boe_panel(panel);
+
+	if (!boe->prepared)
+		return 0;
+
 	if (boe->desc->discharge_on_disable) {
 		regulator_disable(boe->avee);
 		regulator_disable(boe->avdd);
@@ -1528,6 +1535,7 @@ static enum drm_panel_orientation boe_panel_get_orientation(struct drm_panel *pa
 }
 
 static const struct drm_panel_funcs boe_panel_funcs = {
+	.disable = boe_panel_disable,
 	.unprepare = boe_panel_unprepare,
 	.prepare = boe_panel_prepare,
 	.enable = boe_panel_enable,

base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
https://chromeos.dev

