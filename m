Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAC75FC951
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiJLQ3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiJLQ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:29:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7422BF88E7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:29:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f23so16725162plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTxG4nqa8QVexuH2rmRHDWaG3PP9EntkxN4qD7ACWjE=;
        b=H0VYL2aG9H6KXx1Kol9zfdHrSHL7oK1X9La3hR1QkCPrETfDFOQMGt0GTWQaIgVLLB
         tuoVOmCKNm1r3oO+vepoTkT0bBeOWyPSsKx24e7eRZgzeaAXCi67XEk6xgZ+9jQgqA+j
         +5BTXjwEcl4aHCA874jYBQwgec1M4+YNCVh1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTxG4nqa8QVexuH2rmRHDWaG3PP9EntkxN4qD7ACWjE=;
        b=sc1ueIfAhMRu0GWNJyMClnMY7/Zv+tvvwpe2xHfu6OXTJP2oUbqDNofOuaNusyT2rT
         Glr4oBS95PrNiVMWTF3T+khf9va7WqNC0uEe7XkOISfq1dbEFoCqEdsu4gwslItDLtVv
         SikN+GCL/1VucYY0EebSY8oKq8CeZqborITFX/nVbRtTdbMXxGB70BdeEQMSxCVNUuWk
         XJfy9fOUbQJrYqiYll7s8F5fIVjXADcPUgBisTP5mN1WF40K/kN1jYoyWvlzN2mJOYV4
         xTow5y2zRjsx6hgG+2blQXg5Op8qVU65mp01MlN11GlhID22eEA4joOJ2uiJhJBfMm9/
         Bf0A==
X-Gm-Message-State: ACrzQf3I+JhW13Wv4VxeYHmymQHCHH2NVK3SXZE6TrLIGj5eFrysdy9f
        0PunfmoyXQfJe5k+zs0xKBF44Q==
X-Google-Smtp-Source: AMsMyM6awjdgfDnPDEDYiaTo7+JawoCntQNX5yEWwozmmelTyRcbyAPB4ztMEmtbhq8Lg1T+Ujd19w==
X-Received: by 2002:a17:90b:48c9:b0:20a:e225:1afd with SMTP id li9-20020a17090b48c900b0020ae2251afdmr6008045pjb.21.1665592154110;
        Wed, 12 Oct 2022 09:29:14 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:2921:f6a9:5848:18e1])
        by smtp.gmail.com with ESMTPSA id l4-20020a635704000000b0045dc85c4a5fsm9722163pgb.44.2022.10.12.09.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 09:29:13 -0700 (PDT)
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
Subject: [PATCH 2/3] drm/bridge: it6505: Setup links in it6505_irq_hpd
Date:   Thu, 13 Oct 2022 00:28:58 +0800
Message-Id: <20221012162900.2876686-3-treapking@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221012162900.2876686-1-treapking@chromium.org>
References: <20221012162900.2876686-1-treapking@chromium.org>
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

 drivers/gpu/drm/bridge/ite-it6505.c | 74 +++++++++++------------------
 1 file changed, 29 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index f7f6c3e20fae..cf94e44ec73a 100644
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
 
@@ -2328,14 +2314,21 @@ static void it6505_irq_hpd(struct it6505 *it6505)
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
+		DRM_DEV_DEBUG_DRIVER(dev, "it6505->sink_count: %d",
+				     it6505->sink_count);
+
 		it6505_lane_termination_on(it6505);
 		it6505_lane_power_on(it6505);
 
@@ -2363,6 +2356,9 @@ static void it6505_irq_hpd(struct it6505 *it6505)
 		it6505_lane_off(it6505);
 		it6505_link_reset_step_train(it6505);
 	}
+
+	if (it6505->bridge.dev)
+		drm_helper_hpd_irq_event(it6505->bridge.dev);
 }
 
 static void it6505_irq_hpd_irq(struct it6505 *it6505)
@@ -2625,26 +2621,14 @@ static enum drm_connector_status it6505_detect(struct it6505 *it6505)
 		goto unlock;
 
 	if (it6505->enable_drv_hold) {
-		status = it6505_get_sink_hpd_status(it6505) ?
-					connector_status_connected :
-					connector_status_disconnected;
+		status = it6505->hpd_state ?  connector_status_connected :
+					      connector_status_disconnected;
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

