Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99C463763D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKXKWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiKXKVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:21:34 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD0614E6D9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:21:33 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id a16so854122pfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSARwn2UnE9YTFUF2W3+HZEu0BpMDJn1tvX56Vn2aEc=;
        b=Ug9Id50cct6zOXOQoNNjH9g7+k3Y+GPROT/0at83jSeiIUZNvMxLUnWXIfKhQWwCqD
         BvLcx+EY9+QMbGcQ5JRGAFFNl5qvTOXxO0htrR5T7HhUAP4Z9WIyIPI3a2F/bEF3byyF
         wVpCmNKlejLHByIQdI99O8XbYNYoezW4RvB7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSARwn2UnE9YTFUF2W3+HZEu0BpMDJn1tvX56Vn2aEc=;
        b=uAbGqOCDK9GWvG5LDy7elZWy2K2XNUSI0/PxxBdzxE53yPkQImo4omK9buTX9MED3M
         MgEwf0dcSCx85VMI/0WaaisZYBldfTazni+S5+itc7n7+8HJ9is+gnPUfrM+OLRpgS+f
         6tPaNQA61D2c45la3E9A7fuB6smX6+5eAVTF++LLI6rQJooA/efT605ncFR15Mikp2kU
         KEl1Klbwx5QCr9ozd9WiVzUMgb7PLnLrDCitDDRCTWIh7C0s7Z/ECU/wcj6iisFLZFf9
         sR0pcZOsw/MmFQDB+BuSFL01aG0huLbmCvnHh8yjpN+V4Oq0SMTW+sj8eT8IWpGHvxqE
         tvjA==
X-Gm-Message-State: ANoB5pkW3YdvP2kmtgwKg2OsF2zN9MJMXtjVWaKORa76wvuJSovJ3mpE
        Qh67mbSXLVEB9CgXbcFhjJ6X9g==
X-Google-Smtp-Source: AA0mqf7L3iC4gnmNoqCiVBZ9XwHWFS6fSLEjPGOepaa1BcV25Acbf6ifE5OqPVrzqGDBw0HCuMDfIQ==
X-Received: by 2002:a05:6a00:80f:b0:571:8794:e845 with SMTP id m15-20020a056a00080f00b005718794e845mr15217721pfk.18.1669285292953;
        Thu, 24 Nov 2022 02:21:32 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:d446:708:8556:dfee])
        by smtp.gmail.com with ESMTPSA id t123-20020a625f81000000b005747b59fc54sm854584pfb.172.2022.11.24.02.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 02:21:32 -0800 (PST)
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
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, Pin-yen Lin <treapking@chromium.org>,
        chrome-platform@lists.linux.dev, linux-acpi@vger.kernel.org,
        Marek Vasut <marex@denx.de>, Xin Ji <xji@analogixsemi.com>,
        Lyude Paul <lyude@redhat.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>
Subject: [PATCH v6 4/7] drm/bridge: anx7625: Check for Type-C during panel registration
Date:   Thu, 24 Nov 2022 18:20:53 +0800
Message-Id: <20221124102056.393220-5-treapking@chromium.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221124102056.393220-1-treapking@chromium.org>
References: <20221124102056.393220-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

---

Changes in v6:
- New in v6

 drivers/gpu/drm/bridge/analogix/anx7625.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index b0ff1ecb80a5..b9e3d6ad8846 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1650,7 +1650,7 @@ static int anx7625_get_swing_setting(struct device *dev,
 static int anx7625_parse_dt(struct device *dev,
 			    struct anx7625_platform_data *pdata)
 {
-	struct device_node *np = dev->of_node, *ep0;
+	struct device_node *np = dev->of_node, *ep0, *sw;
 	int bus_type, mipi_lanes;
 
 	anx7625_get_swing_setting(dev, pdata);
@@ -1689,6 +1689,17 @@ static int anx7625_parse_dt(struct device *dev,
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
2.38.1.584.g0f3c55d4c2-goog

