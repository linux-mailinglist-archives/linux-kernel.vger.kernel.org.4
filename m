Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205945FD80B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJMLEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJMLEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:04:24 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF4610B7B3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:04:23 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id bh13so1264707pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BptX1vlVcNHP5LWvhu8S2NjiO9ee4jWe/KGbor9Uaxo=;
        b=IjO7mPYpHNOk7l0IwChYojbxdMe0w7AtfsioruRTxng85gyCJNgkqJnFCxndp4y7CF
         LmqkG0MoozuBvOalP282o4s4e+MTQ5av6B5oaw8LvDe0Sbi6JKY3IsvlYNw+/irSHaoK
         /rpzoM8YRjbt815iGMAdUlEYWZVUMlSH94ac8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BptX1vlVcNHP5LWvhu8S2NjiO9ee4jWe/KGbor9Uaxo=;
        b=xiR6Gn6qG9yvvqWtA+PpkF8zKMcYB7Zo8iMNt4MxrfCug8kDozlTiYfRSqKhE2z/rW
         aH5xyGBIbZT3wy8Y7GokzoC0s4c+UgYvbY4vnbKmMrX+qJfJecVbuXglBrwLkXka19MK
         6v/dBEr0c9MQiR3f/80JvTxondxkSslUt+BMBKVG1XO8uF1GYcooYwI0HL/+7B997GiP
         7QcXsxYloxWSXPyWWNO7QdnwEH7hA4tbIq/HWteyuWcJsrDVnigJCXr+/O03pAHaNV79
         awVkwyWdfpn14LRa5UdZ6Banq1XNjCU1pc+b1CXKMPGKUwzmr397254Km5mjvCsH0XX4
         O+TA==
X-Gm-Message-State: ACrzQf11jbjLa8rOR5kJkyX02QjAWCg7m7YFNidUGNbrM8szcV79TgoM
        2+l0JBXfNH5ULtj1hEHMAPBSBABJVOeFgg==
X-Google-Smtp-Source: AMsMyM5vi2Tzg/9fz7+9dffyUUr9Nbvyb5LJ1k3XC6DE7+11qMdHRvhWoVcFLb8QoWkWqqE58Gk15w==
X-Received: by 2002:a63:2cc2:0:b0:41c:681d:60d2 with SMTP id s185-20020a632cc2000000b0041c681d60d2mr28700706pgs.502.1665659062636;
        Thu, 13 Oct 2022 04:04:22 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:4b90:18ed:8d41:7622])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090ab88b00b0020af2411721sm2914794pjr.34.2022.10.13.04.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 04:04:22 -0700 (PDT)
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
        Allen Chen <allen.chen@ite.com.tw>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drm/bridge: it6505: Initialize AUX channel in it6505_i2c_probe
Date:   Thu, 13 Oct 2022 19:04:08 +0800
Message-Id: <20221013110411.1674359-2-treapking@chromium.org>
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

During device boot, the HPD interrupt could be triggered before the DRM
subsystem registers it6505 as a DRM bridge. In such cases, the driver
tries to access AUX channel and causes NULL pointer dereference.
Initializing the AUX channel earlier to prevent such error.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/bridge/ite-it6505.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index a4302492cf8d..f7f6c3e20fae 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2871,10 +2871,7 @@ static int it6505_bridge_attach(struct drm_bridge *bridge,
 	}
 
 	/* Register aux channel */
-	it6505->aux.name = "DP-AUX";
-	it6505->aux.dev = dev;
 	it6505->aux.drm_dev = bridge->dev;
-	it6505->aux.transfer = it6505_aux_transfer;
 
 	ret = drm_dp_aux_register(&it6505->aux);
 
@@ -3354,6 +3351,11 @@ static int it6505_i2c_probe(struct i2c_client *client,
 	debugfs_init(it6505);
 	pm_runtime_enable(dev);
 
+	it6505->aux.name = "DP-AUX";
+	it6505->aux.dev = dev;
+	it6505->aux.transfer = it6505_aux_transfer;
+	drm_dp_aux_init(&it6505->aux);
+
 	it6505->bridge.funcs = &it6505_bridge_funcs;
 	it6505->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
 	it6505->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
-- 
2.38.0.rc1.362.ged0d419d3c-goog

