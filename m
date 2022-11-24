Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CB7637643
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiKXKW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiKXKV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:21:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D05115BB03
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:21:52 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d20so1087522plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lj9TOq4Mi1yjs5u7EUelEqMG61qPa6abk6tN/y0iWc=;
        b=dh73Yb5LdX3XzNMgeceewCLByB4kWa76LmjwGRhHetVfb+CTAGgtAq5OTOlGq1UIUU
         N5maCRzze0/a+LAv9FVd004ct9wIXxE5OfztI8aNUhcr+K8WLORlTU6U/+GI93MusNF9
         tlo96VnZBJaBiQbAN7YVW60Xdb7XdmMurNEcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lj9TOq4Mi1yjs5u7EUelEqMG61qPa6abk6tN/y0iWc=;
        b=MfRr3jWE909anGmp1hnNjr+5a4g+Si+Iar3GpTzAHQ/PN4hS44TG1T1hgv/ChngJvo
         G/VzOR945JN6RdEIyt6D9ngWWY7q9mp6rDVZrn3jDcSJYP9ITYQMwbuZACEOWxoACczV
         PsVA4OU0Newotbi55JS5MPXo8fYZrlANrg5AgSMCqIqfIlpCQraFCKJ13WLkcZlW8mmX
         /qzi0ji+kxxnlkPC4/jRlel86/70aexpqJt1Iot9RofgG8Tlurla5PD0rwSif8cEP3rX
         wmGoKnf12AG0+KfceuAL21gKREBciMzjWZZUty1IuWXOcpQnIuqzWI5tFEGg1Pm86gmn
         ce7A==
X-Gm-Message-State: ANoB5pkopuQHlDxSPZOfHXoblDJ4sKEJxrznbyE4R1kOGkfxwimavk9I
        0t6/7zRuomwszP2aqXPxdrHU6g==
X-Google-Smtp-Source: AA0mqf5vM89hcYo+bffA1QF85tTKpfgIDPFWo2QBf9erTyQa+wFSdxLwOaGJ+X+28Ax9kTHSiczlKA==
X-Received: by 2002:a17:90a:71c8:b0:213:caaf:411 with SMTP id m8-20020a17090a71c800b00213caaf0411mr16426875pjs.74.1669285311724;
        Thu, 24 Nov 2022 02:21:51 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:d446:708:8556:dfee])
        by smtp.gmail.com with ESMTPSA id t123-20020a625f81000000b005747b59fc54sm854584pfb.172.2022.11.24.02.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 02:21:51 -0800 (PST)
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
Subject: [PATCH v6 7/7] drm/bridge: it6505: Register Type C mode switches
Date:   Thu, 24 Nov 2022 18:20:56 +0800
Message-Id: <20221124102056.393220-8-treapking@chromium.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221124102056.393220-1-treapking@chromium.org>
References: <20221124102056.393220-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
relevant port are available in Device Tree. Configure the "lane_swap"
state based on the entered alternate mode for a specific Type-C
connector, which ends up updating the lane swap registers of the it6505
chip.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

Changes in v6:
- Changed it6505_typec_mux_set callback function to accommodate with
  the latest drm-misc patches
- Changed the driver implementation to accommodate with the new binding
- Squashed to a single patch

 drivers/gpu/drm/bridge/Kconfig      |   1 +
 drivers/gpu/drm/bridge/ite-it6505.c | 205 +++++++++++++++++++++++++++-
 2 files changed, 202 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 57946d80b02d..9b1240ef3981 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -87,6 +87,7 @@ config DRM_FSL_LDB
 config DRM_ITE_IT6505
         tristate "ITE IT6505 DisplayPort bridge"
         depends on OF
+	depends on TYPEC || TYPEC=n
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HDCP_HELPER
 	select DRM_DISPLAY_HELPER
diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 21a9b8422bda..37e2bd8d8d79 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -17,6 +17,8 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/types.h>
+#include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_mux.h>
 #include <linux/wait.h>
 
 #include <crypto/hash.h>
@@ -30,6 +32,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_of.h>
 
 #include <sound/hdmi-codec.h>
 
@@ -402,6 +405,12 @@ struct debugfs_entries {
 	const struct file_operations *fops;
 };
 
+struct it6505_port_data {
+	bool dp_connected;
+	struct typec_mux_dev *typec_mux;
+	struct it6505 *it6505;
+};
+
 struct it6505 {
 	struct drm_dp_aux aux;
 	struct drm_bridge bridge;
@@ -454,6 +463,8 @@ struct it6505 {
 	struct delayed_work delayed_audio;
 	struct it6505_audio_data audio;
 	struct dentry *debugfs;
+	int num_typec_switches;
+	struct it6505_port_data *typec_ports;
 
 	/* it6505 driver hold option */
 	bool enable_drv_hold;
@@ -3265,13 +3276,185 @@ static void it6505_shutdown(struct i2c_client *client)
 		it6505_lane_off(it6505);
 }
 
+static void it6505_typec_ports_update(struct it6505 *it6505)
+{
+	usleep_range(3000, 4000);
+
+	if (it6505->typec_ports[0].dp_connected && it6505->typec_ports[1].dp_connected)
+		/* Both ports available, do nothing to retain the current one. */
+		return;
+	else if (it6505->typec_ports[0].dp_connected)
+		it6505->lane_swap = false;
+	else if (it6505->typec_ports[1].dp_connected)
+		it6505->lane_swap = true;
+
+	usleep_range(3000, 4000);
+}
+
+static int it6505_typec_mux_set(struct typec_mux_dev *mux,
+				struct typec_mux_state *state)
+{
+	struct it6505_port_data *data = typec_mux_get_drvdata(mux);
+	struct it6505 *it6505 = data->it6505;
+	struct device *dev = &it6505->client->dev;
+	bool old_dp_connected, new_dp_connected;
+
+	if (it6505->num_typec_switches == 1)
+		return 0;
+
+	mutex_lock(&it6505->extcon_lock);
+
+	old_dp_connected = it6505->typec_ports[0].dp_connected ||
+			   it6505->typec_ports[1].dp_connected;
+
+	data->dp_connected = (state->alt && state->alt->svid == USB_TYPEC_DP_SID &&
+			      state->alt->mode == USB_TYPEC_DP_MODE);
+
+	dev_dbg(dev, "mux_set dp_connected: c0=%d, c1=%d\n",
+		it6505->typec_ports[0].dp_connected, it6505->typec_ports[1].dp_connected);
+
+	new_dp_connected = it6505->typec_ports[0].dp_connected ||
+			   it6505->typec_ports[1].dp_connected;
+
+	if (it6505->enable_drv_hold) {
+		dev_dbg(dev, "enable driver hold\n");
+		goto unlock;
+	}
+
+	it6505_typec_ports_update(it6505);
+
+	if (!old_dp_connected && new_dp_connected) {
+		int ret = pm_runtime_get_sync(dev);
+
+		/*
+		 * On system resume, mux_set can be triggered before
+		 * pm_runtime_force_resume re-enables runtime power management.
+		 * Handling the error here to make sure the bridge is powered on.
+		 */
+		if (ret < 0)
+			it6505_poweron(it6505);
+
+		complete_all(&it6505->extcon_completion);
+	}
+
+	if (old_dp_connected && !new_dp_connected) {
+		reinit_completion(&it6505->extcon_completion);
+		pm_runtime_put_sync(dev);
+		if (it6505->bridge.dev)
+			drm_helper_hpd_irq_event(it6505->bridge.dev);
+		memset(it6505->dpcd, 0, sizeof(it6505->dpcd));
+	}
+
+unlock:
+	mutex_unlock(&it6505->extcon_lock);
+	return 0;
+}
+
+static int it6505_register_mode_switch(struct device *dev, struct device_node *node,
+				       struct it6505 *it6505)
+{
+	struct it6505_port_data *port_data;
+	struct typec_mux_desc mux_desc = {};
+	char name[32];
+	u32 dp_lanes[2];
+	int ret, num_lanes, i, port_num = -1;
+
+	num_lanes = drm_of_get_data_lanes_count(node, 0, 2);
+	if (num_lanes <= 0) {
+		dev_err(dev, "Error on getting data lanes count: %d\n",
+			num_lanes);
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
+	for (i = 0; i < num_lanes; i++) {
+		if (port_num != -1 && port_num != dp_lanes[i] / 2) {
+			dev_err(dev, "Invalid data lane numbers\n");
+			return -EINVAL;
+		}
+		port_num = dp_lanes[i] / 2;
+	}
+
+	port_data = &it6505->typec_ports[port_num];
+	port_data->it6505 = it6505;
+	mux_desc.fwnode = &node->fwnode;
+	mux_desc.drvdata = port_data;
+	snprintf(name, sizeof(name), "%s-%u", node->name, port_num);
+	mux_desc.name = name;
+	mux_desc.set = it6505_typec_mux_set;
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
+static void it6505_unregister_typec_switches(struct it6505 *it6505)
+{
+	int i;
+
+	for (i = 0; i < it6505->num_typec_switches; i++)
+		typec_mux_unregister(it6505->typec_ports[i].typec_mux);
+}
+
+static int it6505_register_typec_switches(struct device *dev, struct it6505 *it6505)
+{
+	struct device_node *port, *sw;
+	int ret = 0;
+
+	port = of_graph_get_port_by_id(dev->of_node, 1);
+
+	for_each_child_of_node(port, sw) {
+		if (of_property_read_bool(sw, "mode-switch"))
+			it6505->num_typec_switches++;
+	}
+
+	if (!it6505->num_typec_switches) {
+		dev_warn(dev, "No Type-C switches node found\n");
+		return ret;
+	}
+
+	it6505->typec_ports = devm_kzalloc(
+		dev, it6505->num_typec_switches * sizeof(struct it6505_port_data),
+		GFP_KERNEL);
+	if (!it6505->typec_ports)
+		return -ENOMEM;
+
+	/* Register switches for each connector. */
+	for_each_child_of_node(port, sw) {
+		if (!of_property_read_bool(sw, "mode-switch"))
+			continue;
+		ret = it6505_register_mode_switch(dev, sw, it6505);
+		if (ret) {
+			dev_err(dev, "Failed to register mode switch: %d\n", ret);
+			of_node_put(sw);
+			break;
+		}
+	}
+
+	if (ret)
+		it6505_unregister_typec_switches(it6505);
+
+	return ret;
+}
+
 static int it6505_i2c_probe(struct i2c_client *client,
 			    const struct i2c_device_id *id)
 {
 	struct it6505 *it6505;
 	struct device *dev = &client->dev;
 	struct extcon_dev *extcon;
-	int err, intp_irq;
+	int err, intp_irq, ret;
 
 	it6505 = devm_kzalloc(&client->dev, sizeof(*it6505), GFP_KERNEL);
 	if (!it6505)
@@ -3292,11 +3475,24 @@ static int it6505_i2c_probe(struct i2c_client *client,
 	if (PTR_ERR(extcon) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 	if (IS_ERR(extcon)) {
-		dev_err(dev, "can not get extcon device!");
-		return PTR_ERR(extcon);
+		if (PTR_ERR(extcon) != -ENODEV)
+			dev_warn(dev, "Cannot get extcon device: %ld\n",
+				 PTR_ERR(extcon));
+		it6505->extcon = NULL;
+	} else {
+		it6505->extcon = extcon;
 	}
 
-	it6505->extcon = extcon;
+	ret = it6505_register_typec_switches(dev, it6505);
+	if (ret) {
+		if (ret != -ENODEV)
+			dev_warn(dev, "Didn't register Type-C switches, err: %d\n",
+				 ret);
+		if (!it6505->extcon) {
+			dev_err(dev, "Both extcon and typec-switch are not registered.\n");
+			return -EINVAL;
+		}
+	}
 
 	it6505->regmap = devm_regmap_init_i2c(client, &it6505_regmap_config);
 	if (IS_ERR(it6505->regmap)) {
@@ -3367,6 +3563,7 @@ static void it6505_i2c_remove(struct i2c_client *client)
 	drm_dp_aux_unregister(&it6505->aux);
 	it6505_debugfs_remove(it6505);
 	it6505_poweroff(it6505);
+	it6505_unregister_typec_switches(it6505);
 }
 
 static const struct i2c_device_id it6505_id[] = {
-- 
2.38.1.584.g0f3c55d4c2-goog

