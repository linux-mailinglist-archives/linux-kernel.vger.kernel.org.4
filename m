Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29485F3C3B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 06:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJDEuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 00:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJDEuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 00:50:02 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA84E033
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 21:49:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x6so6415344pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 21:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6rx+SIB5qyaNNqvePOxH/VVXvkvOQPlultnrgr/9WBk=;
        b=gLGYEgNEm1k0Ctu79S1ja4IaXh59wOmABV1jWdHjEbgedZEQzeIDzDBbD1qAmzhWbG
         +pOdKXHnrAj5muXLm6SQeZeGtUbxGWqcDI+Ts7dloblRb2Y5kaWPkAIPYNXVLHPv2GIJ
         WUTRAIr1Xjg0hzxo7X++xRMfkVvQ31BsFnOaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6rx+SIB5qyaNNqvePOxH/VVXvkvOQPlultnrgr/9WBk=;
        b=Pq5YN2eedQxaqG5OPfJnk+n0XsejWOnje8pHpnVFcac5QTtmwNbDESVrdgClKofsw1
         /DQQ8MEa6ZCjgfDseS4GuNMhI019yBIvIxDDCxgi5GSuenHgJD2k1aChhRIwnEZNPH0/
         W1/aEiDjcSzXWviz+Dt4i4KAcJnb/qUsX7JUApYtm/HoyJWwXFOmFvkHyenYMrBBT5ix
         kt73kyzBTmJ++YgSTeNJodTkZ7wLMclMM6LBjtA4hh4/idZSpqFP13cxjXibTL4+mnoR
         5WaRE/zWc6Tk+oOKeGk3McSPwSNP/LQZ61h+2y3ZIGigmyWHnLD2zWGXxreBurrDeYyO
         UcQw==
X-Gm-Message-State: ACrzQf1ShmXivW0+QyQueQsXhJXVmqRLrhZvSj4xaaRSOBDAntNlpLEk
        BwKPLWXtt1awhCiwzQLtcZkqQQ==
X-Google-Smtp-Source: AMsMyM4J4QFS3sG3dhrr9gH6JE3zLYeTHARsUl9uaqvmP8uj0TuQMSKZR9U5E7D+Jg2TXjgK3vhrIw==
X-Received: by 2002:a17:902:b092:b0:17b:833e:74f7 with SMTP id p18-20020a170902b09200b0017b833e74f7mr23318315plr.149.1664858998744;
        Mon, 03 Oct 2022 21:49:58 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:5713:ccf0:f1dd:69d2])
        by smtp.gmail.com with ESMTPSA id gl1-20020a17090b120100b0020ab3f9c27dsm1095051pjb.55.2022.10.03.21.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 21:49:58 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, Hermes Wu <hermes.wu@ite.com.tw>,
        Allen Chen <allen.chen@ite.com.tw>,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v3 2/2] drm/bridge: it6505: Add pre_enable/post_disable callback
Date:   Tue,  4 Oct 2022 12:49:43 +0800
Message-Id: <20221004044943.2407781-3-treapking@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221004044943.2407781-1-treapking@chromium.org>
References: <20221004044943.2407781-1-treapking@chromium.org>
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

Add atomic_pre_enable and atomic_post_disable callback to make sure the
bridge is not powered off until atomic_post_disable is called. This
prevents a power leakage when it6505 is powered off, but the upstream
DRM bridge is still sending display signals.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

---

Changes in v3:
- Collect review tag

 drivers/gpu/drm/bridge/ite-it6505.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 050f3be9adbc..922e1f2b7a35 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2991,6 +2991,28 @@ static void it6505_bridge_atomic_disable(struct drm_bridge *bridge,
 	}
 }
 
+static void it6505_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+					    struct drm_bridge_state *old_state)
+{
+	struct it6505 *it6505 = bridge_to_it6505(bridge);
+	struct device *dev = &it6505->client->dev;
+
+	DRM_DEV_DEBUG_DRIVER(dev, "start");
+
+	pm_runtime_get_sync(dev);
+}
+
+static void it6505_bridge_atomic_post_disable(struct drm_bridge *bridge,
+					      struct drm_bridge_state *old_state)
+{
+	struct it6505 *it6505 = bridge_to_it6505(bridge);
+	struct device *dev = &it6505->client->dev;
+
+	DRM_DEV_DEBUG_DRIVER(dev, "start");
+
+	pm_runtime_put_sync(dev);
+}
+
 static enum drm_connector_status
 it6505_bridge_detect(struct drm_bridge *bridge)
 {
@@ -3025,6 +3047,8 @@ static const struct drm_bridge_funcs it6505_bridge_funcs = {
 	.mode_valid = it6505_bridge_mode_valid,
 	.atomic_enable = it6505_bridge_atomic_enable,
 	.atomic_disable = it6505_bridge_atomic_disable,
+	.atomic_pre_enable = it6505_bridge_atomic_pre_enable,
+	.atomic_post_disable = it6505_bridge_atomic_post_disable,
 	.detect = it6505_bridge_detect,
 	.get_edid = it6505_bridge_get_edid,
 };
-- 
2.38.0.rc1.362.ged0d419d3c-goog

