Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99098660DDA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 11:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbjAGKYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 05:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbjAGKX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:23:59 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA36E8D3AD
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 02:23:19 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso2598053pjl.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 02:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pb08j6ef/XKfmfzrAl6D47q85iNk8V/i2frcck8touc=;
        b=hDmF8vQDsfvKYtog/VyHHRVuucyGtQG/KgGxvezGWCUo7sakysiONAMCyZxEFdM15K
         3XPiRUGHDlZBD9ZzqQBju3modTkJ3ONfQ86kXiinDFvkWaDaR4Bb6EzQ6/UKzlnOZ3TP
         zPqQx1sw8LwbN8E+WiLOYP9/GOS+Bb5O6c4Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pb08j6ef/XKfmfzrAl6D47q85iNk8V/i2frcck8touc=;
        b=paAyC9UartnH6BiyaNQi5UqmuD0hdkNWsFU2DwLkYX+XIzoN4ZvMhyemeP136xRICq
         dwdufrfJqAJYs34MgnhFtDa9k+qm96CrSQbjq4CP7gGCvlnEW+Ysvr/VHXASIwEOZ/HY
         hdRL1YDvpozoNQP/kfoN0pwrKcwAvp5EcUL0v9ctasDThvReC/rg7u8Pnp0VD6oUb4IN
         sWpQ4EU9STqXrlWpGtTPZqBhB8xBSzTKj8TQZrhnnCqunxE/5/3mbu0OTkORFM0Q0Izi
         cw0q/lFFhh14encTtcDtt+G8hYyt0SWiycSoi8ZuA+34TlbsUQdtgdcOObc1B0ws61wd
         i2ow==
X-Gm-Message-State: AFqh2kohBFTqKzO+KiAOaWRS/kEqHJCUBEoPTzO3yFYD1CScQuZaDeBY
        AxoAj2jLydrIxP5CVeNUt7LdQg==
X-Google-Smtp-Source: AMrXdXs6lMM+/XKOMbIu3/dCOcJjZuKDy1OK9/V+DuEfAPLNtLDh+M8O0Z1N2rLvpnatJcZPifNC4w==
X-Received: by 2002:a17:902:9888:b0:192:ce7e:93b7 with SMTP id s8-20020a170902988800b00192ce7e93b7mr20995450plp.49.1673086998035;
        Sat, 07 Jan 2023 02:23:18 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:180d:95e8:f4:84fb])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b001892af9472esm2366362plh.261.2023.01.07.02.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 02:23:17 -0800 (PST)
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
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Xin Ji <xji@analogixsemi.com>,
        Pin-yen Lin <treapking@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen Chen <allen.chen@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        chrome-platform@lists.linux.dev,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org,
        Marek Vasut <marex@denx.de>, linux-acpi@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v8 6/9] drm/bridge: anx7625: Register Type C mode switches
Date:   Sat,  7 Jan 2023 18:22:28 +0800
Message-Id: <20230107102231.23682-7-treapking@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230107102231.23682-1-treapking@chromium.org>
References: <20230107102231.23682-1-treapking@chromium.org>
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

(no changes since v7)

Changes in v7:
- Fixed style issues in anx7625 driver
- Removed DT property validation in anx7625 driver.
- Extracted common codes to another commit.

Changes in v6:
- Squashed to a single patch

 drivers/gpu/drm/bridge/analogix/Kconfig   |  1 +
 drivers/gpu/drm/bridge/analogix/anx7625.c | 88 +++++++++++++++++++++++
 drivers/gpu/drm/bridge/analogix/anx7625.h | 13 ++++
 3 files changed, 102 insertions(+)

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
index 1cf242130b91..2bb504a8d789 100644
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
@@ -2572,6 +2574,86 @@ static void anx7625_runtime_disable(void *data)
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
+	return drm_dp_register_typec_switches(dev, port, &ctx->switch_desc,
+					      ctx, anx7625_typec_mux_set);
+}
+
 static int anx7625_i2c_probe(struct i2c_client *client)
 {
 	struct anx7625_data *platform;
@@ -2679,6 +2761,10 @@ static int anx7625_i2c_probe(struct i2c_client *client)
 	if (platform->pdata.intp_irq)
 		queue_work(platform->workqueue, &platform->work);
 
+	ret = anx7625_register_typec_switches(dev, platform);
+	if (ret && ret != -ENODEV)
+		dev_warn(dev, "Didn't register Type-C switches, err: %d\n", ret);
+
 	platform->bridge.funcs = &anx7625_bridge_funcs;
 	platform->bridge.of_node = client->dev.of_node;
 	if (!anx7625_of_panel_on_aux_bus(&client->dev))
@@ -2730,6 +2816,8 @@ static void anx7625_i2c_remove(struct i2c_client *client)
 
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

