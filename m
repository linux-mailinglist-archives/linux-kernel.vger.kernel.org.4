Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4234B6BA5D0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 04:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjCODz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 23:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCODzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:55:24 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B4B23A4B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:55:19 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso558826pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678852519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UR5Snc3M6kE4bbPG5fLurLAjOBbquSwKDwwKT7rp0HU=;
        b=hOFv5NxgdftfiStX4TRWv884J/ivID9MdwbTZgkw7Y+3r4Yg1Iw5QpaSeSENO+8Dnw
         BLja3KBei0oVpkyX0rLlRHAiVEn+9cWTjpcrmvtDepEtZDDeZdex+boj3fwO7e2iJ2h8
         Z8ZsnCO5i86z/6QfbvDCOVzVZNcztUaAfRt1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678852519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UR5Snc3M6kE4bbPG5fLurLAjOBbquSwKDwwKT7rp0HU=;
        b=EBaKJIafWI4lsGEBaOSzDxy4q+0WTHcFHCHas61o80SvqyzxQ//WKAi2fxtBc/+qnp
         1DpeXWr5Pv7wMyqOimAyonVO4HNV2J2kXS3wE27Rxz3bRwBSeEEfhtzkx7uQ+vlBlbqw
         /KJrPV0bypxR/nnwzc9sqdpVKQIgV6X0oy2qw3J74BYv5aaj05QltoOguXugfmC3mwP8
         xUGPCmaRZDYXPI2mZKQt665MIRsQeG/Qi/63k2KARE9+JEmtv5CjpGuifHNfTQiTBzJV
         E0Er3NH6G85KrAre7AAa5YAtUQAr8z/RlpGG7vzAn2UvAl46oGgIHu9KnoSSmlbtS/wv
         zPYA==
X-Gm-Message-State: AO0yUKUWt4MHnefZBqoTjaKsQHlBJbpuLmuAcGXLIs+8rzuv2mbER7Y6
        E8A/d4egxVUfFefeVC3jJbJ/dg==
X-Google-Smtp-Source: AK7set+eyLkMyOObG/kj3l6Dhx1fJbEltApMhR8KbXej+L5VZL0UnhT5fjyoZmLOLlwZS8u20A3v6w==
X-Received: by 2002:a17:90b:3b90:b0:233:ebd4:301c with SMTP id pc16-20020a17090b3b9000b00233ebd4301cmr18867349pjb.1.1678852518901;
        Tue, 14 Mar 2023 20:55:18 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:3a77:bf68:24f0:1c75])
        by smtp.gmail.com with ESMTPSA id z31-20020a17090a6d2200b001fde655225fsm3208372pjj.2.2023.03.14.20.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 20:55:18 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2 2/2] drm/bridge: ps8640: Add a cache for EDID
Date:   Wed, 15 Mar 2023 11:55:08 +0800
Message-Id: <20230315035508.2874915-2-treapking@chromium.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315035508.2874915-1-treapking@chromium.org>
References: <20230315035508.2874915-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there are multiple EDID reads, the bridge will be repeatedly
enabled and disabled. Add a cache for EDID to speed this up.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Remove the NULL assignment in ps8640_remove

 drivers/gpu/drm/bridge/parade-ps8640.c | 60 +++++++++++++++-----------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 08de501c436e..cddbfe91f75e 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -105,6 +105,7 @@ struct ps8640 {
 	struct gpio_desc *gpio_reset;
 	struct gpio_desc *gpio_powerdown;
 	struct device_link *link;
+	struct edid *edid;
 	bool pre_enabled;
 	bool need_post_hpd_delay;
 };
@@ -543,34 +544,37 @@ static struct edid *ps8640_bridge_get_edid(struct drm_bridge *bridge,
 {
 	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
 	bool poweroff = !ps_bridge->pre_enabled;
-	struct edid *edid;
 
-	/*
-	 * When we end calling get_edid() triggered by an ioctl, i.e
-	 *
-	 *   drm_mode_getconnector (ioctl)
-	 *     -> drm_helper_probe_single_connector_modes
-	 *        -> drm_bridge_connector_get_modes
-	 *           -> ps8640_bridge_get_edid
-	 *
-	 * We need to make sure that what we need is enabled before reading
-	 * EDID, for this chip, we need to do a full poweron, otherwise it will
-	 * fail.
-	 */
-	if (poweroff)
-		drm_atomic_bridge_chain_pre_enable(bridge, connector->state->state);
+	if (!ps_bridge->edid) {
+		/*
+		 * When we end calling get_edid() triggered by an ioctl, i.e
+		 *
+		 *   drm_mode_getconnector (ioctl)
+		 *     -> drm_helper_probe_single_connector_modes
+		 *        -> drm_bridge_connector_get_modes
+		 *           -> ps8640_bridge_get_edid
+		 *
+		 * We need to make sure that what we need is enabled before
+		 * reading EDID, for this chip, we need to do a full poweron,
+		 * otherwise it will fail.
+		 */
+		if (poweroff)
+			drm_atomic_bridge_chain_pre_enable(bridge,
+							   connector->state->state);
 
-	edid = drm_get_edid(connector,
-			    ps_bridge->page[PAGE0_DP_CNTL]->adapter);
+		ps_bridge->edid = drm_get_edid(connector,
+					       ps_bridge->page[PAGE0_DP_CNTL]->adapter);
 
-	/*
-	 * If we call the get_edid() function without having enabled the chip
-	 * before, return the chip to its original power state.
-	 */
-	if (poweroff)
-		drm_atomic_bridge_chain_post_disable(bridge, connector->state->state);
+		/*
+		 * If we call the get_edid() function without having enabled the
+		 * chip before, return the chip to its original power state.
+		 */
+		if (poweroff)
+			drm_atomic_bridge_chain_post_disable(bridge,
+							     connector->state->state);
+	}
 
-	return edid;
+	return drm_edid_duplicate(ps_bridge->edid);
 }
 
 static void ps8640_runtime_disable(void *data)
@@ -767,6 +771,13 @@ static int ps8640_probe(struct i2c_client *client)
 	return ret;
 }
 
+static void ps8640_remove(struct i2c_client *client)
+{
+	struct ps8640 *ps_bridge = i2c_get_clientdata(client);
+
+	kfree(ps_bridge->edid);
+}
+
 static const struct of_device_id ps8640_match[] = {
 	{ .compatible = "parade,ps8640" },
 	{ }
@@ -775,6 +786,7 @@ MODULE_DEVICE_TABLE(of, ps8640_match);
 
 static struct i2c_driver ps8640_driver = {
 	.probe_new = ps8640_probe,
+	.remove = ps8640_remove,
 	.driver = {
 		.name = "ps8640",
 		.of_match_table = ps8640_match,
-- 
2.40.0.rc1.284.g88254d51c5-goog

