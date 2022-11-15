Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A01C62975D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiKOL27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiKOL12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:27:28 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C112496A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:27:27 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so16652690pji.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4zSQ0DjWyG+4BNx59pGTUfeFDadgUQEQVZPf7S2ofm4=;
        b=f9iEdJ5v8usTqfhxUiwrvfOFtGZEkKTKAnW7l97YkEsWMir2NPoG/C9cVE6uXZ5+d2
         wLeoImdBseWL+BDW4Oku7t3zwK3xZtX8gCFDB3tAADB+O0e5bt5r8Iw4eliKofReo42m
         xJF4paolACEq+Qra3Tm+2uGWaJlu/kIZq9z3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zSQ0DjWyG+4BNx59pGTUfeFDadgUQEQVZPf7S2ofm4=;
        b=GEFOfUKTeKRj38e1/zGgDDCYhv8y1sA5Di3+34jGeiCbQVZ3EdKsizcIj1x0wBsDWO
         jeAL1NKyJTK4I9AwsRKGF91+URzTbmt+gwzSLB8KKCSChXH1Npl8eBzkNvcQOjXrOXe9
         6D5bDfjq3as2Z523xiK9OLCq2cXW3AxIeJTLrtPgQJ7lDAosYPSjnbbXTRzTyVUl+kxz
         CUFcfJN7fGJNZlRgXaEHez+vyii23y8qPQBS25gN45TW0ym1Ffu1qo/oplmsqh1mJ1G0
         fYRiJvBWJ788FJtDkS8OvZtC5JJDzdpl9+PBXhcaM4SviHZ6pjiLxbetBjnOityLoxDZ
         upPw==
X-Gm-Message-State: ANoB5pkhcc6QR+0pkVwVkyCXRzWd5o8LPxp6o6cr1tgchJiTKKjkfOJN
        jBQzhGMhb8X38uwvvQOc5jFDCg==
X-Google-Smtp-Source: AA0mqf5XG2A5vG0RXAJAVZxu4ysiQ9ALyvgkiv483stnUKm9YOyMeOCWjrFQRvV0G48WsOCj3mZlVg==
X-Received: by 2002:a17:902:e483:b0:188:b44b:598 with SMTP id i3-20020a170902e48300b00188b44b0598mr3672200ple.54.1668511646490;
        Tue, 15 Nov 2022 03:27:26 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:e5b1:b561:a821:c6c])
        by smtp.gmail.com with ESMTPSA id cp5-20020a170902e78500b00186a8085382sm9584924plb.43.2022.11.15.03.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 03:27:25 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     allen chen <allen.chen@ite.com.tw>, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] drm/bridge: it6505: Add caching for EDID
Date:   Tue, 15 Nov 2022 19:27:20 +0800
Message-Id: <20221115112720.911158-1-treapking@chromium.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
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

Add caching when EDID is read, and invalidate the cache until the
bridge detects HPD low or sink count changes on HPD_IRQ.

It takes 1.2s for IT6505 bridge to read a 3-block EDID, and skipping
one EDID read would be a notable difference on user experience.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

 drivers/gpu/drm/bridge/ite-it6505.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 21a9b8422bda..4b818f31668f 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -457,6 +457,8 @@ struct it6505 {
 
 	/* it6505 driver hold option */
 	bool enable_drv_hold;
+
+	struct edid *cached_edid;
 };
 
 struct it6505_step_train_para {
@@ -2244,6 +2246,13 @@ static void it6505_plugged_status_to_codec(struct it6505 *it6505)
 				   status == connector_status_connected);
 }
 
+
+static void it6505_remove_edid(struct it6505 *it6505)
+{
+	kfree(it6505->cached_edid);
+	it6505->cached_edid = NULL;
+}
+
 static int it6505_process_hpd_irq(struct it6505 *it6505)
 {
 	struct device *dev = &it6505->client->dev;
@@ -2270,6 +2279,7 @@ static int it6505_process_hpd_irq(struct it6505 *it6505)
 		it6505_reset_logic(it6505);
 		it6505_int_mask_enable(it6505);
 		it6505_init(it6505);
+		it6505_remove_edid(it6505);
 		return 0;
 	}
 
@@ -2353,6 +2363,7 @@ static void it6505_irq_hpd(struct it6505 *it6505)
 			it6505_video_reset(it6505);
 	} else {
 		memset(it6505->dpcd, 0, sizeof(it6505->dpcd));
+		it6505_remove_edid(it6505);
 
 		if (it6505->hdcp_desired)
 			it6505_stop_hdcp(it6505);
@@ -3016,16 +3027,18 @@ static struct edid *it6505_bridge_get_edid(struct drm_bridge *bridge,
 {
 	struct it6505 *it6505 = bridge_to_it6505(bridge);
 	struct device *dev = &it6505->client->dev;
-	struct edid *edid;
 
-	edid = drm_do_get_edid(connector, it6505_get_edid_block, it6505);
+	if (!it6505->cached_edid) {
+		it6505->cached_edid = drm_do_get_edid(connector, it6505_get_edid_block,
+						      it6505);
 
-	if (!edid) {
-		DRM_DEV_DEBUG_DRIVER(dev, "failed to get edid!");
-		return NULL;
+		if (!it6505->cached_edid) {
+			DRM_DEV_DEBUG_DRIVER(dev, "failed to get edid!");
+			return NULL;
+		}
 	}
 
-	return edid;
+	return drm_edid_duplicate(it6505->cached_edid);
 }
 
 static const struct drm_bridge_funcs it6505_bridge_funcs = {
@@ -3367,6 +3380,7 @@ static void it6505_i2c_remove(struct i2c_client *client)
 	drm_dp_aux_unregister(&it6505->aux);
 	it6505_debugfs_remove(it6505);
 	it6505_poweroff(it6505);
+	it6505_remove_edid(it6505);
 }
 
 static const struct i2c_device_id it6505_id[] = {
-- 
2.38.1.493.g58b659f92b-goog

