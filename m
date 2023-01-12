Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4B2666A45
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbjALEXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbjALEWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:22:02 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F02D101F0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:21:55 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w3so19012979ply.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyrwfywewO+EJZ65JeId9yW4fjW1rcHlsmlCHRqKdY4=;
        b=hE5nhmq9CLi+4zJA0yhBuE/nMUYwgkGU80LWlKESH7+Mjx2ijh5p6/txchkNtMgU9j
         LTbqDatXGlWhir6WPOKj0DX7MIq3rrqYtLqNGRl42A4ezNaTkxP19rTSws3rCNjES+Ec
         Ixck24yEFfVGYK4NUlpWDAkNBTaUx+RJ7N7gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyrwfywewO+EJZ65JeId9yW4fjW1rcHlsmlCHRqKdY4=;
        b=BVUO9jfFDjeia36P6oN6K/X7IhF+FsxjLM7xNRhk7/LiZOFLIUm6kBtO+xJ4LyaZuf
         LH3XqiZnrk62LnizJQSdlf01/yR8hKwC4i4arB2JRFGHTywXP26LQH8e/2gpP1nAfnYq
         4XkR1x95jX/mlU+1iuEVRKOuiDUsBvfUGs0yykRyWS12r/2jSoKx1xEuQRY0lmytnP79
         lFT1WK+4XUyarO+D7i9qQNWBLshfgvrE/P0bN4EViobzdwUHmXL3PtsN+nQUj5QCq7zA
         0w0AFJgwJcP2eAR3F38XkislcEiXvbeDPhbb1jh6Rs1xXzkA/2tRhD15/lx76KpU7AUR
         +i0Q==
X-Gm-Message-State: AFqh2kqL3L3oMYjLm6TWK/XcApHlB7kGFllHYnT//NxBhvj/5FRU88Hf
        ph9Zso5fBA8iqrfjw+E0HoMY4Q==
X-Google-Smtp-Source: AMrXdXs2t0E6AND31BLaha0/StVXtnDEBg3vSzj7UOY3y+k/SGmuYAo65IcRp55ZDqNesxTIM1EnaQ==
X-Received: by 2002:a05:6a20:d389:b0:af:7a4c:fb7d with SMTP id iq9-20020a056a20d38900b000af7a4cfb7dmr91809108pzb.23.1673497314896;
        Wed, 11 Jan 2023 20:21:54 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:594f:5484:7591:d074])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78bc8000000b00582579cb0e0sm5519478pfd.129.2023.01.11.20.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 20:21:54 -0800 (PST)
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
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v10 6/9] drm/bridge: anx7625: Register Type C mode switches
Date:   Thu, 12 Jan 2023 12:21:01 +0800
Message-Id: <20230112042104.4107253-7-treapking@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230112042104.4107253-1-treapking@chromium.org>
References: <20230112042104.4107253-1-treapking@chromium.org>
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

Register USB Type-C mode switches when the "mode-switch" property and
relevant ports are available in Device Tree. Configure the crosspoint
switch based on the entered alternate mode for a specific Type-C
connector.

Crosspoint switch can also be used for switching the output signal for
different orientations of a single USB Type-C connector, but the
orientation switch is not implemented yet. A TODO is added for this.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

---

Changes in v10:
- Added a TODO for implementing orientation switch for anx7625
- Updated the commit message for the absence of orientation switch
- Fixed typo in the commit message
- Collected Tested-by tag

Changes in v7:
- Fixed style issues in anx7625 driver
- Removed DT property validation in anx7625 driver.
- Extracted common codes to another commit.

Changes in v6:
- Squashed to a single patch

 drivers/gpu/drm/bridge/analogix/Kconfig   |  1 +
 drivers/gpu/drm/bridge/analogix/anx7625.c | 92 +++++++++++++++++++++++
 drivers/gpu/drm/bridge/analogix/anx7625.h | 13 ++++
 3 files changed, 106 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
index 173dada218ec..992b43ed1dd7 100644
--- a/drivers/gpu/drm/bridge/analogix/Kconfig
+++ b/drivers/gpu/drm/bridge/analogix/Kconfig
@@ -34,6 +34,7 @@ config DRM_ANALOGIX_ANX7625
 	tristate "Analogix Anx7625 MIPI to DP interface support"
 	depends on DRM
 	depends on OF
+	depends on TYPEC || TYPEC=n
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HDCP_HELPER
 	select DRM_DISPLAY_HELPER
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 1cf242130b91..808dbf79d209 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -15,6 +15,8 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_mux.h>
 #include <linux/workqueue.h>
 
 #include <linux/of_gpio.h>
@@ -2572,6 +2574,90 @@ static void anx7625_runtime_disable(void *data)
 	pm_runtime_disable(data);
 }
 
+static void anx7625_set_crosspoint_switch(struct anx7625_data *ctx,
+					  enum typec_orientation orientation)
+{
+	if (orientation == TYPEC_ORIENTATION_NORMAL) {
+		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_0,
+				  SW_SEL1_SSRX_RX1 | SW_SEL1_DPTX0_RX2);
+		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_1,
+				  SW_SEL2_SSTX_TX1 | SW_SEL2_DPTX1_TX2);
+	} else if (orientation == TYPEC_ORIENTATION_REVERSE) {
+		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_0,
+				  SW_SEL1_SSRX_RX2 | SW_SEL1_DPTX0_RX1);
+		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_1,
+				  SW_SEL2_SSTX_TX2 | SW_SEL2_DPTX1_TX1);
+	}
+}
+
+static void anx7625_typec_two_ports_update(struct anx7625_data *ctx)
+{
+	struct drm_dp_typec_switch_desc switch_desc = ctx->switch_desc;
+	/* Check if both ports available and do nothing to retain the current one */
+	if (switch_desc.typec_ports[0].dp_connected && switch_desc.typec_ports[1].dp_connected)
+		return;
+
+	if (switch_desc.typec_ports[0].dp_connected)
+		anx7625_set_crosspoint_switch(ctx, TYPEC_ORIENTATION_NORMAL);
+	else if (switch_desc.typec_ports[1].dp_connected)
+		anx7625_set_crosspoint_switch(ctx, TYPEC_ORIENTATION_REVERSE);
+}
+
+static int anx7625_typec_mux_set(struct typec_mux_dev *mux,
+				 struct typec_mux_state *state)
+{
+	struct drm_dp_typec_port_data *port_data = typec_mux_get_drvdata(mux);
+	struct anx7625_data *ctx = (struct anx7625_data *) port_data->data;
+	struct device *dev = &ctx->client->dev;
+	struct drm_dp_typec_switch_desc switch_desc = ctx->switch_desc;
+	bool new_dp_connected, old_dp_connected;
+
+	if (switch_desc.num_typec_switches == 1)
+		return 0;
+
+	old_dp_connected = switch_desc.typec_ports[0].dp_connected ||
+			   switch_desc.typec_ports[1].dp_connected;
+
+	port_data->dp_connected = state->alt &&
+				  state->alt->svid == USB_TYPEC_DP_SID &&
+				  state->alt->mode == USB_TYPEC_DP_MODE;
+
+	dev_dbg(dev, "mux_set dp_connected: c0=%d, c1=%d\n",
+		switch_desc.typec_ports[0].dp_connected, switch_desc.typec_ports[1].dp_connected);
+
+	new_dp_connected = switch_desc.typec_ports[0].dp_connected ||
+			   switch_desc.typec_ports[1].dp_connected;
+
+	/* dp on, power on first */
+	if (!old_dp_connected && new_dp_connected)
+		pm_runtime_get_sync(dev);
+
+	anx7625_typec_two_ports_update(ctx);
+
+	/* dp off, power off last */
+	if (old_dp_connected && !new_dp_connected)
+		pm_runtime_put_sync(dev);
+
+	return 0;
+}
+
+static void anx7625_unregister_typec_switches(struct anx7625_data *ctx)
+{
+	drm_dp_unregister_typec_switches(&ctx->switch_desc);
+}
+
+static int anx7625_register_typec_switches(struct device *dev, struct anx7625_data *ctx)
+{
+	struct device_node *port = of_graph_get_port_by_id(dev->of_node, 1);
+
+	/*
+	 * Currently, only mode switch is implemented.
+	 * TODO: Implement Type-C orientation switch for anx7625.
+	 */
+	return drm_dp_register_typec_switches(dev, port, &ctx->switch_desc,
+					      ctx, anx7625_typec_mux_set);
+}
+
 static int anx7625_i2c_probe(struct i2c_client *client)
 {
 	struct anx7625_data *platform;
@@ -2679,6 +2765,10 @@ static int anx7625_i2c_probe(struct i2c_client *client)
 	if (platform->pdata.intp_irq)
 		queue_work(platform->workqueue, &platform->work);
 
+	ret = anx7625_register_typec_switches(dev, platform);
+	if (ret && ret != -ENODEV)
+		dev_warn(dev, "Didn't register Type-C switches, err: %d\n", ret);
+
 	platform->bridge.funcs = &anx7625_bridge_funcs;
 	platform->bridge.of_node = client->dev.of_node;
 	if (!anx7625_of_panel_on_aux_bus(&client->dev))
@@ -2730,6 +2820,8 @@ static void anx7625_i2c_remove(struct i2c_client *client)
 
 	drm_bridge_remove(&platform->bridge);
 
+	anx7625_unregister_typec_switches(platform);
+
 	if (platform->pdata.intp_irq)
 		destroy_workqueue(platform->workqueue);
 
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
index 14f33d6be289..38abbd3d6b36 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.h
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
@@ -55,6 +55,18 @@
 #define HPD_STATUS_CHANGE 0x80
 #define HPD_STATUS 0x80
 
+#define TCPC_SWITCH_0 0xB4
+#define SW_SEL1_DPTX0_RX2 BIT(0)
+#define SW_SEL1_DPTX0_RX1 BIT(1)
+#define SW_SEL1_SSRX_RX2 BIT(4)
+#define SW_SEL1_SSRX_RX1 BIT(5)
+
+#define TCPC_SWITCH_1 0xB5
+#define SW_SEL2_DPTX1_TX2 BIT(0)
+#define SW_SEL2_DPTX1_TX1 BIT(1)
+#define SW_SEL2_SSTX_TX2 BIT(4)
+#define SW_SEL2_SSTX_TX1 BIT(5)
+
 /******** END of I2C Address 0x58 ********/
 
 /***************************************************************/
@@ -479,6 +491,7 @@ struct anx7625_data {
 	struct drm_connector *connector;
 	struct mipi_dsi_device *dsi;
 	struct drm_dp_aux aux;
+	struct drm_dp_typec_switch_desc switch_desc;
 };
 
 #endif  /* __ANX7625_H__ */
-- 
2.39.0.314.g84b9a713c41-goog

