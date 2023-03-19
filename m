Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97206C01C4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjCSMzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCSMzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:55:44 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F02761AC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:55:43 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id l9so5258027iln.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679230542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gMuTuV/PxnF04ieD+/WbXry01J3vTyybaYMQ7rpMYzk=;
        b=JFLeHt79k0jl0YPaFxMk08tz8fIIrticmPoC6+HWmJdoiPxGXxSzC94TTHirmQobYI
         SXc4+85nu/sFJ0/HgsoJFxW7vS5ZD4O7uXJ6Li6zSKDuXG9+JhOLVYROOms+Xb0gYFHS
         hf3q/A41rZIWWqI3gx3B+IqPfKh1mPK08se5xYq9Q9axDpmH8A0W6HyLMHOJD/n+5BWt
         hsziHwm9HbMxEqCHm6iq2PpLRXt1gE9ZIyXKa1h82SkgpvqLoGNidEb9Z3IdN6aKKoBP
         RftzG8IY6V22c8ZR6/z7+xo/y6JVJK7w3FEQNNl9TIemOA6DBBAUcyv3CWsg49idNORf
         Hk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679230542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMuTuV/PxnF04ieD+/WbXry01J3vTyybaYMQ7rpMYzk=;
        b=QCjVhnyTMwm70wShI+lVwkxPVQyx6xq2BHOHTKeNEt8zFVlax57G6SIeuwKmOozDo/
         +ge6lIWXr2EerEUVGHjKVLhPvr9ipzLMnF3dyD3IGWWubE3EE5X8lYK2d3qAdyT9o5iA
         1gnU0TF5M6eLvw4+M2jowRtoCZqh55dvlW6Q5Q3dxGKMGVpGWo5jT6+Yf9u9ORDQuSao
         0wZZOg+ctD6jMZxsouLmrmlHEhs4ecnNuvKlaGO/uh8/nc59SXXf+aiPZ+jRTfHIIzq0
         mZkQCDUAhnrvSF3eoh6OReLbYpqw3Ga4YWd95d8cE4vrRR+6IvPrVeYydzFXP/j0hLQg
         FMBg==
X-Gm-Message-State: AO0yUKUdM6SaqaAIUioZcxp2EVlXlPjK48+0IXUoUHwN0OKMY4l6dmKL
        H7AuKbkaM1N6JaioAtCKkSg=
X-Google-Smtp-Source: AK7set8VyHh9qqJa1SPElGRsWeVDUg/sleWLwqO3yN/4giWtiwTXrwDZC+ww+CQIFatT6z4eqsLHdg==
X-Received: by 2002:a05:6e02:6cb:b0:323:1362:19b2 with SMTP id p11-20020a056e0206cb00b00323136219b2mr2912498ils.21.1679230542265;
        Sun, 19 Mar 2023 05:55:42 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id z2-20020a056638240200b003b331f0bbdfsm2335605jat.97.2023.03.19.05.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 05:55:41 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     dmitry.baryshkov@linaro.org, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>, Robert Foss <rfoss@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] drm/bridge: adv7533: Fix adv7533_mode_valid for adv7533 and adv7535
Date:   Sun, 19 Mar 2023 07:55:24 -0500
Message-Id: <20230319125524.58803-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dynamically switching lanes was removed, the intent of the code
was to check to make sure that higher speed items used 4 lanes, but
it had the unintended consequence of removing the slower speeds for
4-lane users.

This attempts to remedy this by doing a check to see that the
max frequency doesn't exceed the chip limit, and a second
check to make sure that the max bit-rate doesn't exceed the
number of lanes * max bit rate / lane.

Fixes: 9a0cdcd6649b ("drm/bridge: adv7533: remove dynamic lane switching from adv7533 bridge")
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Adam Ford <aford173@gmail.com>
---

V2:  Fix whitespace in comment
     Remove TODO comment
     Add R-B from Robert.

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm/bridge/adv7511/adv7533.c
index fdfeadcefe80..7e3e56441aed 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
@@ -103,22 +103,19 @@ void adv7533_dsi_power_off(struct adv7511 *adv)
 enum drm_mode_status adv7533_mode_valid(struct adv7511 *adv,
 					const struct drm_display_mode *mode)
 {
-	int lanes;
+	unsigned long max_lane_freq;
 	struct mipi_dsi_device *dsi = adv->dsi;
+	u8 bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
 
-	if (mode->clock > 80000)
-		lanes = 4;
-	else
-		lanes = 3;
-
-	/*
-	 * TODO: add support for dynamic switching of lanes
-	 * by using the bridge pre_enable() op . Till then filter
-	 * out the modes which shall need different number of lanes
-	 * than what was configured in the device tree.
-	 */
-	if (lanes != dsi->lanes)
-		return MODE_BAD;
+	/* Check max clock for either 7533 or 7535 */
+	if (mode->clock > (adv->type == ADV7533 ? 80000 : 148500))
+		return MODE_CLOCK_HIGH;
+
+	/* Check max clock for each lane */
+	max_lane_freq = (adv->type == ADV7533 ? 800000 : 891000);
+
+	if (mode->clock * bpp > max_lane_freq * adv->num_dsi_lanes)
+		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
 }
-- 
2.34.1

