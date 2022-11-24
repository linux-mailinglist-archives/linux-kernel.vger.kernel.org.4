Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A789163763E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiKXKWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiKXKVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:21:40 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56A114F9DE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:21:39 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id h193so1198234pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AMzuZTvtULhDaNSb1CGR7wc9XfQGANRhchKL9iMWpc=;
        b=jYETd7vRF39IppIhmII7tbsyaUQpByJvGYddMez3t0wvAsKDcjqYisry/Hjr/8vxPD
         PyTMM/9y3cCcuPrjYSHLe6bs16y4EJQ9+eKf54Er6N5NNrlWQwPMIOsLaIC5iUzunsD5
         23bQsA+xq3PaWRlVLGnKgTLHiWS+ns7D3LtY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AMzuZTvtULhDaNSb1CGR7wc9XfQGANRhchKL9iMWpc=;
        b=m8fO8VjwnZg5tBbYEG1rQ6jm88HHioWscw+OEZZLmDLoWy6r5uvHG5FspwrKOYBb2h
         NB0JAEfoUaY1J6YOAccgxM/vvuGcn7VfF2PsBLwVK2+Dmw7YyIVrC4F9X5tU3KSwJ8/x
         zFTlwf+gMv3xvaIidM5FgQ02L7m+J4rCmj37iXchzwM7QDx6meCihv8KKNLXu49paKO1
         Bl58AqFZ9ohKxNGYK2riDKG/FJDaIHJQFgnJCJRbq3S+NYch5Rj62Sk13x/bMkQHHyK5
         /lE/26Ew9bWQmE1SGoQOIZVFJ6ynqI+5W+Yy/yFUUO7033KJvM1wPFBIKO66PvuXUq8p
         aACw==
X-Gm-Message-State: ANoB5plVTKpzgS7rtOoF19S5+nM9R7DV9O0JQsFg61OCIr8ADEDiyWdM
        c7yCASJSozeWOln8R+9YRGkUUg==
X-Google-Smtp-Source: AA0mqf7uiJNri7ShNc7g3uvn+n6tfamN3Ey97TemVTN3B6xuR1e8ujBuJ5eX9U46TMi77SoxlYuYDg==
X-Received: by 2002:a62:148f:0:b0:560:ee47:81e1 with SMTP id 137-20020a62148f000000b00560ee4781e1mr17482882pfu.63.1669285299158;
        Thu, 24 Nov 2022 02:21:39 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:d446:708:8556:dfee])
        by smtp.gmail.com with ESMTPSA id t123-20020a625f81000000b005747b59fc54sm854584pfb.172.2022.11.24.02.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 02:21:38 -0800 (PST)
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
Subject: [PATCH v6 5/7] drm/bridge: anx7625: Register Type C mode switches
Date:   Thu, 24 Nov 2022 18:20:54 +0800
Message-Id: <20221124102056.393220-6-treapking@chromium.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221124102056.393220-1-treapking@chromium.org>
References: <20221124102056.393220-1-treapking@chromium.org>
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

Register USB Type-C mode switches when the "mode-switch" property and
relevant port are available in Device Tree. Configure the crosspoint
switch based on the entered alternate mode for a specific Type-C
connector.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

Changes in v6:
- Squashed to a single patch

 drivers/gpu/drm/bridge/analogix/Kconfig   |   1 +
 drivers/gpu/drm/bridge/analogix/anx7625.c | 169 ++++++++++++++++++++++
 drivers/gpu/drm/bridge/analogix/anx7625.h |  20 +++
 3 files changed, 190 insertions(+)

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
index b9e3d6ad8846..2485e61f5cab 100644
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
@@ -2573,6 +2575,167 @@ static void anx7625_runtime_disable(void *data)
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
+	if (ctx->typec_ports[0].dp_connected && ctx->typec_ports[1].dp_connected)
+		/* Both ports available, do nothing to retain the current one. */
+		return;
+	else if (ctx->typec_ports[0].dp_connected)
+		anx7625_set_crosspoint_switch(ctx, TYPEC_ORIENTATION_NORMAL);
+	else if (ctx->typec_ports[1].dp_connected)
+		anx7625_set_crosspoint_switch(ctx, TYPEC_ORIENTATION_REVERSE);
+}
+
+static int anx7625_typec_mux_set(struct typec_mux_dev *mux,
+				 struct typec_mux_state *state)
+{
+	struct anx7625_port_data *data = typec_mux_get_drvdata(mux);
+	struct anx7625_data *ctx = data->ctx;
+	struct device *dev = &ctx->client->dev;
+	bool new_dp_connected, old_dp_connected;
+
+	if (ctx->num_typec_switches == 1)
+		return 0;
+
+	old_dp_connected = ctx->typec_ports[0].dp_connected || ctx->typec_ports[1].dp_connected;
+
+	data->dp_connected = (state->alt && state->alt->svid == USB_TYPEC_DP_SID &&
+			      state->alt->mode == USB_TYPEC_DP_MODE);
+
+	dev_dbg(dev, "mux_set dp_connected: c0=%d, c1=%d\n",
+		ctx->typec_ports[0].dp_connected, ctx->typec_ports[1].dp_connected);
+
+	new_dp_connected = ctx->typec_ports[0].dp_connected || ctx->typec_ports[1].dp_connected;
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
+static int anx7625_register_mode_switch(struct device *dev, struct device_node *node,
+					struct anx7625_data *ctx)
+{
+	struct anx7625_port_data *port_data;
+	struct typec_mux_desc mux_desc = {};
+	char name[32];
+	u32 dp_lanes[2];
+	int ret, num_lanes, i, port_num = -1;
+
+	num_lanes = drm_of_get_data_lanes_count(node, 0, 2);
+	if (num_lanes < 0) {
+		dev_err(dev, "Error on getting data lanes count: %d\n", num_lanes);
+		return num_lanes;
+	}
+
+	ret = of_property_read_u32_array(node, "data-lanes", dp_lanes, num_lanes);
+	if (ret) {
+		dev_err(dev, "Failed to read the data-lanes variable: %d\n",
+			ret);
+		return ret;
+	}
+
+	/*
+	 * <0 1> refers to SSRX1/SSTX1, and <2 3> refers to SSRX2/SSTX2.
+	 */
+	for (i = 0; i < num_lanes; i++) {
+		if (port_num != -1 && port_num != dp_lanes[i] / 2) {
+			dev_err(dev, "Invalid data lane numbers\n");
+			return -EINVAL;
+		}
+		port_num = dp_lanes[i] / 2;
+	}
+
+	port_data = &ctx->typec_ports[port_num];
+	port_data->ctx = ctx;
+	mux_desc.fwnode = &node->fwnode;
+	mux_desc.drvdata = port_data;
+	snprintf(name, sizeof(name), "%s-%u", node->name, port_num);
+	mux_desc.name = name;
+	mux_desc.set = anx7625_typec_mux_set;
+
+	port_data->typec_mux = typec_mux_register(dev, &mux_desc);
+	if (IS_ERR(port_data->typec_mux)) {
+		ret = PTR_ERR(port_data->typec_mux);
+		dev_err(dev, "Mode switch register for port %d failed: %d\n",
+			port_num, ret);
+	}
+
+	return ret;
+}
+
+static void anx7625_unregister_typec_switches(struct anx7625_data *ctx)
+{
+	int i;
+
+	for (i = 0; i < ctx->num_typec_switches; i++)
+		typec_mux_unregister(ctx->typec_ports[i].typec_mux);
+}
+
+static int anx7625_register_typec_switches(struct device *dev, struct anx7625_data *ctx)
+{
+	struct device_node *port, *sw;
+	int ret = 0;
+
+	port = of_graph_get_port_by_id(dev->of_node, 1);
+
+	for_each_child_of_node(port, sw) {
+		if (of_property_read_bool(sw, "mode-switch"))
+			ctx->num_typec_switches++;
+	}
+
+	if (!ctx->num_typec_switches) {
+		dev_warn(dev, "No Type-C switches node found\n");
+		return ret;
+	}
+
+	ctx->typec_ports = devm_kcalloc(
+		dev, ctx->num_typec_switches, sizeof(struct anx7625_port_data),
+		GFP_KERNEL);
+	if (!ctx->typec_ports)
+		return -ENOMEM;
+
+	/* Register switches for each connector. */
+	for_each_child_of_node(port, sw) {
+		if (!of_property_read_bool(sw, "mode-switch"))
+			continue;
+		ret = anx7625_register_mode_switch(dev, sw, ctx);
+		if (ret) {
+			dev_err(dev, "Failed to register mode switch: %d\n", ret);
+			of_node_put(sw);
+			break;
+		}
+	}
+
+	if (ret)
+		anx7625_unregister_typec_switches(ctx);
+
+	return ret;
+}
+
 static int anx7625_i2c_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
 {
@@ -2681,6 +2844,10 @@ static int anx7625_i2c_probe(struct i2c_client *client,
 	if (platform->pdata.intp_irq)
 		queue_work(platform->workqueue, &platform->work);
 
+	ret = anx7625_register_typec_switches(dev, platform);
+	if (ret && ret != -ENODEV)
+		dev_warn(dev, "Didn't register Type-C switches, err: %d\n", ret);
+
 	platform->bridge.funcs = &anx7625_bridge_funcs;
 	platform->bridge.of_node = client->dev.of_node;
 	if (!anx7625_of_panel_on_aux_bus(&client->dev))
@@ -2732,6 +2899,8 @@ static void anx7625_i2c_remove(struct i2c_client *client)
 
 	drm_bridge_remove(&platform->bridge);
 
+	anx7625_unregister_typec_switches(platform);
+
 	if (platform->pdata.intp_irq)
 		destroy_workqueue(platform->workqueue);
 
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
index 14f33d6be289..b8634766b04e 100644
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
@@ -449,6 +461,12 @@ struct anx7625_i2c_client {
 	struct i2c_client *tcpc_client;
 };
 
+struct anx7625_port_data {
+	bool dp_connected;
+	struct typec_mux_dev *typec_mux;
+	struct anx7625_data *ctx;
+};
+
 struct anx7625_data {
 	struct anx7625_platform_data pdata;
 	struct platform_device *audio_pdev;
@@ -479,6 +497,8 @@ struct anx7625_data {
 	struct drm_connector *connector;
 	struct mipi_dsi_device *dsi;
 	struct drm_dp_aux aux;
+	int num_typec_switches;
+	struct anx7625_port_data *typec_ports;
 };
 
 #endif  /* __ANX7625_H__ */
-- 
2.38.1.584.g0f3c55d4c2-goog

