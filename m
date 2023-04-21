Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2C16EAEDD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjDUQNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjDUQM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:12:56 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5055713FB0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:12:46 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b8f5121503eso2466329276.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682093565; x=1684685565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKO1I2nyCroJ5CwepD9IlxcHZJ24Ly0m35i9l8S4MQs=;
        b=HJfyn5H0QVx3NXHRM8iU50CH7Ukb/wfDINz8hm/4f7n2NjK0MiMfZadyU4/9ZxGvkJ
         pH/IHUyy274lKYCO1jODOlPX2cacKBGdFCiGRGEYu2bzEwGpsO7LKkbrxIkAQWVLIc+j
         byWAkFmPgv/5cQKlcgPuQSV6bzI9E6E8GcAvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682093565; x=1684685565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKO1I2nyCroJ5CwepD9IlxcHZJ24Ly0m35i9l8S4MQs=;
        b=HWtQQItZJM81Y6S9wON0ZAo2sj/N5wl+EgWKf9jCKuG+ziBJYIuMTzcWiMZlVYDnMO
         pn9SmWyH3vUlMu9SE92B+Xj/1z2Rd/e6mWHOPSnHXfVG3qruRxKoTgH5yywAhQ/OodHy
         OCT22yiaxP+fawnGc6XPgCSB9TilQSmECYq+YZzHGRrAUmGdsNYQbLYwv1ATDNUJGDGb
         qEZTcurXNnHcKxVhNKpUPgYJCDrhJ9BgZFXe8isw8Nmp45Ck6kxh6+m+43g38T5rOe3E
         YYYHGLOyGRJtpXsbZGb/BCAFy6KrjERq3fkik7t2DUX3TZ2WtX3riO0wG3k7X0LZ0lO3
         JBmQ==
X-Gm-Message-State: AAQBX9dAiDItUK+puXXS5DKN+8fZJIrv3pCGbyiaUFOIZ9+U0BK8xcVA
        gMApk0ZnwfFVdmma/y7x1evKZg==
X-Google-Smtp-Source: AKy350ZfHj4U+debwEjtoM+P+zXHEbqLPoMWNeevKjzr0FvvwqIS7hVfrAuFlrrufYErsNiIub5ahw==
X-Received: by 2002:a25:b31b:0:b0:b8c:4e4:d3d4 with SMTP id l27-20020a25b31b000000b00b8c04e4d3d4mr2748897ybj.17.1682093565513;
        Fri, 21 Apr 2023 09:12:45 -0700 (PDT)
Received: from localhost ([2620:0:1035:15:25e5:2115:c97c:bf00])
        by smtp.gmail.com with UTF8SMTPSA id n12-20020a0dcb0c000000b00552e32354f8sm1038529ywd.32.2023.04.21.09.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 09:12:45 -0700 (PDT)
From:   Mark Yacoub <markyacoub@chromium.org>
X-Google-Original-From: Mark Yacoub <markyacoub@google.com>
To:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     seanpaul@chromium.org, dianders@chromium.org,
        Mark Yacoub <markyacoub@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] dp_hdcp: Get the hdcp key from the connector prop
Date:   Fri, 21 Apr 2023 12:12:37 -0400
Message-ID: <20230421161237.357342-3-markyacoub@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230421161237.357342-1-markyacoub@google.com>
References: <20230421161237.357342-1-markyacoub@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Yacoub <markyacoub@chromium.org>

[Why]
To support protected content, the driver requires a key.
Currently, it's being injected from debugfs, which is not super useful
to run a user space in the wild.

[How]
When the key is needed, fetch the "Content Protection Property" on the
connector and get the key blob. Verify that the size is valid and use
it.

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_hdcp.c | 66 +++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_hdcp.c b/drivers/gpu/drm/msm/dp/dp_hdcp.c
index 191340971f943..4321d245b36c9 100644
--- a/drivers/gpu/drm/msm/dp/dp_hdcp.c
+++ b/drivers/gpu/drm/msm/dp/dp_hdcp.c
@@ -117,19 +117,61 @@ static bool dp_hdcp_are_keys_valid(struct drm_connector *connector,
 	return FIELD_GET(DP_HDCP_KEY_STATUS, val) == DP_HDCP_KEY_STATUS_VALID;
 }
 
+static bool dp_hdcp_get_key_from_connector(struct drm_connector *connector,
+					   struct drm_bridge *bridge)
+{
+	struct drm_property_blob *key_blob;
+	u8 *raw_key;
+	int ret;
+	struct dp_hdcp *hdcp;
+	struct drm_device *dev = connector->dev;
+	struct drm_property *prop =
+		dev->mode_config.content_protection_key_property;
+
+	if (!prop)
+		return false;
+
+	key_blob = connector->state->content_protection_key;
+	if (!key_blob)
+		return false;
+
+	raw_key = key_blob->data;
+
+	if (key_blob->length !=
+	    DRM_HDCP_KSV_LEN + DP_HDCP_NUM_KEYS * DP_HDCP_KEY_LEN) {
+		drm_dbg_atomic(
+			dev,
+			"[CONNECTOR:%d:%s] Content Protection Key is a blob that we don't expect.\n",
+			connector->base.id, connector->name);
+		return false;
+	}
+
+	hdcp = dp_display_bridge_to_hdcp(bridge);
+	ret = dp_hdcp_ingest_key(hdcp, key_blob->data, key_blob->length);
+	if (ret)
+		return false;
+
+	return true;
+}
+
 static int dp_hdcp_load_keys(struct drm_connector *connector, void *driver_data)
 {
 	struct drm_bridge *bridge = (struct drm_bridge *)driver_data;
 	struct dp_hdcp *hdcp = dp_display_bridge_to_hdcp(bridge);
 	int i, ret = 0;
+	bool is_hdcp_key_valid;
 
 	mutex_lock(&hdcp->key_lock);
+	is_hdcp_key_valid = hdcp->key.valid;
+	mutex_unlock(&hdcp->key_lock);
 
-	if (!hdcp->key.valid) {
-		ret = -ENOENT;
-		goto out;
+	if (!is_hdcp_key_valid &&
+	    !dp_hdcp_get_key_from_connector(connector, bridge)) {
+		return -ENOENT;
 	}
 
+	mutex_lock(&hdcp->key_lock);
+
 	dp_catalog_hdcp_write_aksv(hdcp->catalog, hdcp->key.ksv.words);
 
 
@@ -139,7 +181,6 @@ static int dp_hdcp_load_keys(struct drm_connector *connector, void *driver_data)
 	}
 	dp_catalog_hdcp_post_write_key(hdcp->catalog);
 
-out:
 	mutex_unlock(&hdcp->key_lock);
 	return ret;
 }
@@ -346,6 +387,8 @@ int dp_hdcp_attach(struct dp_hdcp *hdcp, struct drm_connector *connector,
 		   struct drm_bridge *bridge, struct dp_catalog *catalog)
 {
 	struct drm_hdcp_helper_data *helper_data;
+	struct drm_device *dev;
+	struct drm_property *prop;
 
 	/* HDCP is not configured for this device */
 	if (!hdcp->parser->io.dp_controller.hdcp_key.base)
@@ -357,7 +400,20 @@ int dp_hdcp_attach(struct dp_hdcp *hdcp, struct drm_connector *connector,
 		return PTR_ERR(helper_data);
 
 	helper_data->driver_data = bridge;
-	hdcp->dev = connector->dev;
+
+	dev = connector->dev;
+	prop = dev->mode_config.content_protection_key_property;
+	if (!prop) {
+		prop = drm_property_create(dev, DRM_MODE_PROP_BLOB,
+					   "Content Protection Key", 0);
+	}
+	if (!prop)
+		return -1;
+	drm_object_attach_property(&connector->base, prop,
+				   DRM_MODE_HDCP_CONTENT_TYPE0);
+	dev->mode_config.content_protection_key_property = prop;
+
+	hdcp->dev = dev;
 	hdcp->connector = connector;
 	hdcp->helper_data = helper_data;
 	hdcp->catalog = catalog;
-- 
2.40.0.634.g4ca3ef3211-goog

