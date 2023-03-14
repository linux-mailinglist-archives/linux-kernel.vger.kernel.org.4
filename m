Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114EF6B90DB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCNLBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCNLA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:00:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DAE618B6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:00:56 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso14728217pjs.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678791656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KN7ooQKtWhMgWI3W1SHW4dYGbxtb6ATUYGlRWw76wgQ=;
        b=BEKj7lEbmcWnFmkOJdZwe8ucuJK8mKGQ7K0afNaXQcPnqxlskX496O2ThHHXhQUXQd
         GKPs8gd6OHeF2Liuh7ckYhPLQFkDZlF9Fqu3J4KaDghsy0lnVU2NTGWSQpKRyeI1vnfi
         dKBp5jll9MXUT5SojLvFgVllrrlynsewKJXm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678791656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KN7ooQKtWhMgWI3W1SHW4dYGbxtb6ATUYGlRWw76wgQ=;
        b=3ECnCiAFFSpFoE55AzI97HuAyc8qKFr7IQ0ugNujJ1nbe3Q1F4Kiu3SdAzgPJdmb+u
         aQYSigv6vT9sQxnVUIbolnzEm2cl0EVz0/N+xfCQfusyiX+Un6zzAq9A0/NPXobYyIEu
         r5usjedcul0gTlQQvN+C8UIVxNVOHJV37H3efTzhKbpAd466RI1XzVZcTRNF8Sk+cjX5
         388L7Ma+8IaZxUo2ngfXfofjvJ9ij/93g4E4uwQZR14FUPslpdE8BVTWf+MWSCrNTItz
         Vzmn5Q5/YGsXwT87O6eIaiEUCnb5LKxltpAWKieEZSfvM04+P0T7P0sE7Q3uCDlDTld4
         O+Mg==
X-Gm-Message-State: AO0yUKVxJcBe+Tq1tuJ2U5lKkU69QSJjVF5qCuSno32yxBHt5pKdRrMI
        tuX03BmvfMknD2gNaKyrD/Qc1A==
X-Google-Smtp-Source: AK7set+0VaGLdaQczHOJsZh+t2MPnBQeqgWSCKsi61Ji4oSLJ0ZfZVNLs32RrsPDU/dAQZEs3QT1kA==
X-Received: by 2002:a05:6a20:3d8e:b0:bc:e785:5ad3 with SMTP id s14-20020a056a203d8e00b000bce7855ad3mr14026106pzi.29.1678791655678;
        Tue, 14 Mar 2023 04:00:55 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:3718:fdeb:7d7e:b6c0])
        by smtp.gmail.com with ESMTPSA id x2-20020a62fb02000000b005a909290425sm1362028pfm.172.2023.03.14.04.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 04:00:55 -0700 (PDT)
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
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH 2/2] drm/bridge: ps8640: Add a cache for EDID
Date:   Tue, 14 Mar 2023 19:00:43 +0800
Message-Id: <20230314110043.2139111-2-treapking@chromium.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230314110043.2139111-1-treapking@chromium.org>
References: <20230314110043.2139111-1-treapking@chromium.org>
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
---

 drivers/gpu/drm/bridge/parade-ps8640.c | 61 ++++++++++++++++----------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 08de501c436e..4d594be8b89c 100644
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
@@ -767,6 +771,14 @@ static int ps8640_probe(struct i2c_client *client)
 	return ret;
 }
 
+static void ps8640_remove(struct i2c_client *client)
+{
+	struct ps8640 *ps_bridge = i2c_get_clientdata(client);
+
+	kfree(ps_bridge->edid);
+	ps_bridge->edid = NULL;
+}
+
 static const struct of_device_id ps8640_match[] = {
 	{ .compatible = "parade,ps8640" },
 	{ }
@@ -775,6 +787,7 @@ MODULE_DEVICE_TABLE(of, ps8640_match);
 
 static struct i2c_driver ps8640_driver = {
 	.probe_new = ps8640_probe,
+	.remove = ps8640_remove,
 	.driver = {
 		.name = "ps8640",
 		.of_match_table = ps8640_match,
-- 
2.40.0.rc1.284.g88254d51c5-goog

