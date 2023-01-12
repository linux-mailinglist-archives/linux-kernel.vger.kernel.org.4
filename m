Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8775F666A46
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbjALEXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbjALEWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:22:01 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE7ABE00
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:21:47 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id s67so11970412pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4fsKZ8vfmDfUc1Nfjl36ivIzejXzy6Kt8K+gcJWI24=;
        b=mkPluvk59KIiAcPlMDzERaNoAA9HeVVqvopt0+jh3JVWYVk5ewNwNrAH9p0jo5Iwws
         2CQ86HkEsKNCSwoYJKBDsEcZe8eQR/vO6t/ZPbARJBLEagCttO1T7hJDbm9X73MbQz2h
         pC/tdKthbblySuECemzkzZQ0F+XgWqAGd7pkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4fsKZ8vfmDfUc1Nfjl36ivIzejXzy6Kt8K+gcJWI24=;
        b=FLNWr/6kJgPR8ohVSzNYnkcFvs8wQudRgD9v1oXcHcynHy9pKZGG1BNiOecTvM8gL5
         wTxsePkv1tTDKJxg9re8gIcPbHMDQOdTuVFet9K1jN/nXL0YNsjrLcCycDBRFRMMMS1k
         gUvVEVUYwrNt+0yT318EblXK20a0EQqFPxEaZhReGl1HhQHkh5rG9XGRALjOTNCVF/qI
         vrpavaC9xb2fqI9QCXx17lE2cQ7N1G9q92h1uLEGATWnywJQk7uPpijLoCL+85v3Jjee
         iLv3wqwNccBfSCdnLrB7RI0ooald05dIy/IJGjtbaptmCRrC1ARBLjkCkN1w0y9VOVTu
         BXmA==
X-Gm-Message-State: AFqh2krXLLddO1shSaB2RgYCXxArrFz9bJN8EynyLiwoJ/Yh0XHzmWzk
        10QWrqT2Nu8cnEey3YAG4eh7FQ==
X-Google-Smtp-Source: AMrXdXsaiGwsMJ8RFHGEHuDbChLN9aOocfYMm/szoOGxe37pNLiAJo1fc3aVRfyGVkuuPJbgMkCkNw==
X-Received: by 2002:a62:4dc7:0:b0:586:210b:2b67 with SMTP id a190-20020a624dc7000000b00586210b2b67mr17041922pfb.6.1673497307326;
        Wed, 11 Jan 2023 20:21:47 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:594f:5484:7591:d074])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78bc8000000b00582579cb0e0sm5519478pfd.129.2023.01.11.20.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 20:21:47 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Marek Vasut <marex@denx.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lyude Paul <lyude@redhat.com>, chrome-platform@lists.linux.dev,
        Xin Ji <xji@analogixsemi.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        linux-acpi@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v10 5/9] drm/bridge: anx7625: Check for Type-C during panel registration
Date:   Thu, 12 Jan 2023 12:21:00 +0800
Message-Id: <20230112042104.4107253-6-treapking@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230112042104.4107253-1-treapking@chromium.org>
References: <20230112042104.4107253-1-treapking@chromium.org>
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

The output port endpoints can be connected to USB-C connectors.
Running drm_of_find_panel_or_bridge() with such endpoints leads to
a continuous return value of -EPROBE_DEFER, even though there is
no panel present.

To avoid this, check for the existence of a "mode-switch" property in
the port endpoint, and skip panel registration completely if so.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

---

Changes in v10:
- Collected Reviewed-by and Tested-by tags

Changes in v6:
- New in v6

 drivers/gpu/drm/bridge/analogix/anx7625.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index b375887e655d..1cf242130b91 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1649,7 +1649,7 @@ static int anx7625_get_swing_setting(struct device *dev,
 static int anx7625_parse_dt(struct device *dev,
 			    struct anx7625_platform_data *pdata)
 {
-	struct device_node *np = dev->of_node, *ep0;
+	struct device_node *np = dev->of_node, *ep0, *sw;
 	int bus_type, mipi_lanes;
 
 	anx7625_get_swing_setting(dev, pdata);
@@ -1688,6 +1688,17 @@ static int anx7625_parse_dt(struct device *dev,
 	if (of_property_read_bool(np, "analogix,audio-enable"))
 		pdata->audio_en = 1;
 
+	/*
+	 * Don't bother finding a panel if a Type-C `mode-switch` property is
+	 * present in one of the endpoints.
+	 */
+	for_each_endpoint_of_node(np, sw) {
+		if (of_property_read_bool(sw, "mode-switch")) {
+			of_node_put(sw);
+			return 0;
+		}
+	}
+
 	pdata->panel_bridge = devm_drm_of_get_bridge(dev, np, 1, 0);
 	if (IS_ERR(pdata->panel_bridge)) {
 		if (PTR_ERR(pdata->panel_bridge) == -ENODEV) {
-- 
2.39.0.314.g84b9a713c41-goog

