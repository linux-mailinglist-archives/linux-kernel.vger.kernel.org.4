Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD975FD80D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJMLEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMLE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:04:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE23A10B785
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:04:27 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a6-20020a17090abe0600b0020d7c0c6650so4636844pjs.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYXJKMiQJ4PCw73TzI+ObZcy3XsnxrjgsDmU8SHv3n4=;
        b=i+v3uGLfxi76/KZh6GQhp6XyoYwQZqCvqQ936yd1CA565biHsX/Aow6gZdo9RfCLym
         DAxYk4wr6Oe76tPOGXRh8u9godGzap7LlYktW9HuvakC1jam47Hq4SLD/j892SxD/sXU
         koYKEF4tO5MW2wVnz6HdPJLVQAHzHFyCLNdYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYXJKMiQJ4PCw73TzI+ObZcy3XsnxrjgsDmU8SHv3n4=;
        b=SwTemLTdOyrcqhvol/s321s+83JdTj2YH3TvIzaN5Jkp5SMJ2B0dzdFwt1VtqgcxuD
         uFozuZnmlp8fdj+2RT+2y3/MrWQZEHR31fEU2v/HY5tHN13KdkPtX4/wYuiuGYOYH2oV
         gpTu0XDaacgMcHBxygnfOsbjFzmkr4YjgnVfWirw5eDjgk5JFs2EiAUUq1KwAjHSB6Ur
         BSN4v5nsulYerVIFppgxC9fMOB4qo7ypwnnsj8vra302NSJKDz7q2olAisxRiX6nL4i0
         zxphRdtAYp63WogEfbVnoXBIuDUyTMwcpiQV2Mw99DAlg2QBlg0NU5NaRPRjrL9bb2eG
         ZB5A==
X-Gm-Message-State: ACrzQf03jNwGWHvo0Ey/qeHhFILbkyXgqMz52uZm/yubvJ7CvnQ6ww9S
        ji12U6In4ov2YDZs7TKx4FVBPw==
X-Google-Smtp-Source: AMsMyM4GbGab5MMuBpDiibhmlwaFU1Pdum9yRNVJlzAqU6GR188DUVqZJQBC6c95Z0CwrJUOLr7+qw==
X-Received: by 2002:a17:90b:4d05:b0:202:ec78:9d73 with SMTP id mw5-20020a17090b4d0500b00202ec789d73mr10606717pjb.103.1665659067240;
        Thu, 13 Oct 2022 04:04:27 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:4b90:18ed:8d41:7622])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090ab88b00b0020af2411721sm2914794pjr.34.2022.10.13.04.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 04:04:26 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm/bridge: it6505: Setup links in it6505_irq_hpd
Date:   Thu, 13 Oct 2022 19:04:09 +0800
Message-Id: <20221013110411.1674359-3-treapking@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221013110411.1674359-1-treapking@chromium.org>
References: <20221013110411.1674359-1-treapking@chromium.org>
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

Move the DPCD read and link setup steps to HPD IRQ handler to remove
an unnecessary dependency between .detect callback and the HPD IRQ
handler before registering it6505 as a DRM bridge. This is safe because
there is always a .detect call after each HPD IRQ handler triggered by
the drm_helper_hpd_irq_event call.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

Changes in v2:
- Remove redundant spaces in it6505_detect
- Read sink count in it6505_irq_hpd

 drivers/gpu/drm/bridge/ite-it6505.c | 80 +++++++++++++----------------
 1 file changed, 35 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index f7f6c3e20fae..4b6061272599 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -725,28 +725,6 @@ static void it6505_calc_video_info(struct it6505 *it6505)
 			     DRM_MODE_ARG(&it6505->video_info));
 }
 
-static int it6505_drm_dp_link_probe(struct drm_dp_aux *aux,
-				    struct it6505_drm_dp_link *link)
-{
-	u8 values[3];
-	int err;
-
-	memset(link, 0, sizeof(*link));
-
-	err = drm_dp_dpcd_read(aux, DP_DPCD_REV, values, sizeof(values));
-	if (err < 0)
-		return err;
-
-	link->revision = values[0];
-	link->rate = drm_dp_bw_code_to_link_rate(values[1]);
-	link->num_lanes = values[2] & DP_MAX_LANE_COUNT_MASK;
-
-	if (values[2] & DP_ENHANCED_FRAME_CAP)
-		link->capabilities = DP_ENHANCED_FRAME_CAP;
-
-	return 0;
-}
-
 static int it6505_drm_dp_link_set_power(struct drm_dp_aux *aux,
 					struct it6505_drm_dp_link *link,
 					u8 mode)
@@ -1456,11 +1434,19 @@ static void it6505_parse_link_capabilities(struct it6505 *it6505)
 	int bcaps;
 
 	if (it6505->dpcd[0] == 0) {
-		it6505_aux_on(it6505);
-		it6505_get_dpcd(it6505, DP_DPCD_REV, it6505->dpcd,
-				ARRAY_SIZE(it6505->dpcd));
+		dev_err(dev, "DPCD is not initialized");
+		return;
 	}
 
+	memset(link, 0, sizeof(*link));
+
+	link->revision = it6505->dpcd[0];
+	link->rate = drm_dp_bw_code_to_link_rate(it6505->dpcd[1]);
+	link->num_lanes = it6505->dpcd[2] & DP_MAX_LANE_COUNT_MASK;
+
+	if (it6505->dpcd[2] & DP_ENHANCED_FRAME_CAP)
+		link->capabilities = DP_ENHANCED_FRAME_CAP;
+
 	DRM_DEV_DEBUG_DRIVER(dev, "DPCD Rev.: %d.%d",
 			     link->revision >> 4, link->revision & 0x0F);
 
@@ -2323,19 +2309,32 @@ static int it6505_process_hpd_irq(struct it6505 *it6505)
 static void it6505_irq_hpd(struct it6505 *it6505)
 {
 	struct device *dev = &it6505->client->dev;
+	int dp_sink_count;
 
 	it6505->hpd_state = it6505_get_sink_hpd_status(it6505);
 	DRM_DEV_DEBUG_DRIVER(dev, "hpd change interrupt, change to %s",
 			     it6505->hpd_state ? "high" : "low");
 
-	if (it6505->bridge.dev)
-		drm_helper_hpd_irq_event(it6505->bridge.dev);
-	DRM_DEV_DEBUG_DRIVER(dev, "it6505->sink_count: %d",
-			     it6505->sink_count);
-
 	if (it6505->hpd_state) {
 		wait_for_completion_timeout(&it6505->wait_edid_complete,
 					    msecs_to_jiffies(6000));
+		it6505_aux_on(it6505);
+		if (it6505->dpcd[0] == 0) {
+			it6505_get_dpcd(it6505, DP_DPCD_REV, it6505->dpcd,
+					ARRAY_SIZE(it6505->dpcd));
+			it6505_variable_config(it6505);
+			it6505_parse_link_capabilities(it6505);
+		}
+		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
+
+		it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
+					     DP_SET_POWER_D0);
+		dp_sink_count = it6505_dpcd_read(it6505, DP_SINK_COUNT);
+		it6505->sink_count = DP_GET_SINK_COUNT(dp_sink_count);
+
+		DRM_DEV_DEBUG_DRIVER(dev, "it6505->sink_count: %d",
+				     it6505->sink_count);
+
 		it6505_lane_termination_on(it6505);
 		it6505_lane_power_on(it6505);
 
@@ -2363,6 +2362,9 @@ static void it6505_irq_hpd(struct it6505 *it6505)
 		it6505_lane_off(it6505);
 		it6505_link_reset_step_train(it6505);
 	}
+
+	if (it6505->bridge.dev)
+		drm_helper_hpd_irq_event(it6505->bridge.dev);
 }
 
 static void it6505_irq_hpd_irq(struct it6505 *it6505)
@@ -2625,26 +2627,14 @@ static enum drm_connector_status it6505_detect(struct it6505 *it6505)
 		goto unlock;
 
 	if (it6505->enable_drv_hold) {
-		status = it6505_get_sink_hpd_status(it6505) ?
-					connector_status_connected :
-					connector_status_disconnected;
+		status = it6505->hpd_state ? connector_status_connected :
+					     connector_status_disconnected;
 		goto unlock;
 	}
 
-	if (it6505_get_sink_hpd_status(it6505)) {
-		it6505_aux_on(it6505);
-		it6505_drm_dp_link_probe(&it6505->aux, &it6505->link);
+	if (it6505->hpd_state) {
 		it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
 					     DP_SET_POWER_D0);
-		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
-
-		if (it6505->dpcd[0] == 0) {
-			it6505_get_dpcd(it6505, DP_DPCD_REV, it6505->dpcd,
-					ARRAY_SIZE(it6505->dpcd));
-			it6505_variable_config(it6505);
-			it6505_parse_link_capabilities(it6505);
-		}
-
 		dp_sink_count = it6505_dpcd_read(it6505, DP_SINK_COUNT);
 		it6505->sink_count = DP_GET_SINK_COUNT(dp_sink_count);
 		DRM_DEV_DEBUG_DRIVER(dev, "it6505->sink_count:%d branch:%d",
-- 
2.38.0.rc1.362.ged0d419d3c-goog

