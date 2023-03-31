Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9146D1BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjCaJON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjCaJNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:13:38 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2F230ED
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:12:55 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so22760626pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680253970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DftOuC34jgK6vdfEHR4p5+Z7I+B73avis2TRz4siHN0=;
        b=iPbuEJLQFsyK12xhR7n77O9f3ArrTMQ7LJ4E3u1SoR/u+l8QB2O97SWlANyKzlxhj5
         0MxEiSRWTm+0T3gB01G8ks9lLukGWkvbyQx6h+46SOs/Lb3rJu1/TZg1dMMmBeKSrVjH
         bJzBabjOcV+MfgCrfD1IJoo++c4j7M1GpnFJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680253970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DftOuC34jgK6vdfEHR4p5+Z7I+B73avis2TRz4siHN0=;
        b=xq0ZwZdmBlByLzFJCDZgYIGcppMH7X4NopOsoRz2jdOyOJOTjwb640KzoRWyQ6CYgQ
         oBfwtzpZ28UQRonR/m29MzCHcj95ARA8NRujvZXfnLN2ljqsPeuSw0Aw8waLZ5EeTqnz
         1HWQLg5zp626dbKZoKd0FTdf+vkfm9EOALvKG/9p9WEHcqUUN5dlMDPCNwS14iiIfc7P
         raXYspm3igQvErjAhGMgcPr5haEBZxp6TsmXa9jSypE4pDaTQ18pnOEx21dBDahbVpsJ
         5ggzdQV5vBhIm9Qwo6ZSBc8kmkAn3eqWoaVn3Nh5bf03dKQOAHavj9lwfTG35EEoQAk2
         c43A==
X-Gm-Message-State: AO0yUKWQ/F2h+FFH+tgySb2zucJ3MuUnkuuQC9j+Unkn9kjdrwlQPTcH
        iuKaO6/WWF4+Ds7pQ8jSp6YRFA==
X-Google-Smtp-Source: AK7set9+PFlF8H1hDPzcYo0cfctK+6K0fRB1oLnkcDm5pp5/Pln0V+QDTYaWVOFbUPhrh21vRrZwCA==
X-Received: by 2002:a05:6a20:2903:b0:d3:a347:7db4 with SMTP id t3-20020a056a20290300b000d3a3477db4mr22713158pzf.15.1680253969754;
        Fri, 31 Mar 2023 02:12:49 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:ae9d:db7a:8a71:d458])
        by smtp.gmail.com with ESMTPSA id n6-20020a62e506000000b006227c3d5e29sm1360905pff.16.2023.03.31.02.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 02:12:49 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
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
Cc:     Xin Ji <xji@analogixsemi.com>, Marek Vasut <marex@denx.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Lyude Paul <lyude@redhat.com>, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Pin-yen Lin <treapking@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v15 10/10] drm/bridge: it6505: Register Type C mode switches
Date:   Fri, 31 Mar 2023 17:11:45 +0800
Message-Id: <20230331091145.737305-11-treapking@chromium.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331091145.737305-1-treapking@chromium.org>
References: <20230331091145.737305-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

Changes in v15:
- Add comments about the completion
- Fix style issues
- Abort the mux_set callback when the switch is unregistered

Changes in v14:
- Fix style issues

Changes in v13:
- Fix style issues

Changes in v12:
- Fixes style issues in it6505 driver
- Replaced &it6505->client->dev with it6505->dev
- Updated the error logs when parsing data-lanes property

Changes in v11:
- Added back "data-lanes" parsing logics
- Removed Kconfig dependency
- Updated the usage of the private data

Changes in v7:
- Fixed style issues in it6505 driver
- Removed the redundant sleep in it6505 driver
- Removed DT property validation in it6505 driver
- Rebased to drm-misc-next
- Extracted common codes to another commit

Changes in v6:
- Changed it6505_typec_mux_set callback function to accommodate with
  the latest drm-misc patches
- Changed the driver implementation to accommodate with the new binding
- Squashed to a single patch

 drivers/gpu/drm/bridge/ite-it6505.c | 198 +++++++++++++++++++++++++++-
 1 file changed, 191 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 39edcbad586f..12fea5727c92 100644
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
@@ -27,6 +29,7 @@
 #include <drm/drm_bridge.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
@@ -401,6 +404,11 @@ struct debugfs_entries {
 	const struct file_operations *fops;
 };
 
+struct it6505_typec_port_data {
+	bool dp_connected;
+	bool lane_swap;
+};
+
 struct it6505 {
 	struct drm_dp_aux aux;
 	struct drm_bridge bridge;
@@ -454,6 +462,9 @@ struct it6505 {
 	struct delayed_work delayed_audio;
 	struct it6505_audio_data audio;
 	struct dentry *debugfs;
+	struct completion mux_register;
+	struct drm_dp_typec_switch_desc switch_desc;
+	struct it6505_typec_port_data *port_data;
 
 	/* it6505 driver hold option */
 	bool enable_drv_hold;
@@ -3357,12 +3368,172 @@ static void it6505_shutdown(struct i2c_client *client)
 		it6505_lane_off(it6505);
 }
 
+static void it6505_typec_ports_update(struct it6505 *it6505)
+{
+	unsigned int i;
+
+	/* Check if both ports available and do nothing to retain the current one */
+	if (it6505->port_data[0].dp_connected && it6505->port_data[1].dp_connected)
+		return;
+
+	for (i = 0; i < 2; i++) {
+		if (it6505->port_data[i].dp_connected)
+			it6505->lane_swap = it6505->port_data[i].lane_swap;
+	}
+}
+
+static int it6505_typec_mux_set(struct typec_mux_dev *mux,
+				struct typec_mux_state *state)
+{
+	struct drm_dp_typec_port_data *port = typec_mux_get_drvdata(mux);
+	struct it6505 *it6505 = port->data;
+	struct device *dev = it6505->dev;
+	struct drm_dp_typec_switch_desc switch_desc = it6505->switch_desc;
+	bool old_dp_connected, new_dp_connected;
+	int ret = 0;
+
+	if (switch_desc.num_typec_switches == 1)
+		return 0;
+
+	mutex_lock(&it6505->extcon_lock);
+	/*
+	 * The completion is called in it6505_register_typec_switches even on
+	 * errors, so it's safe to wait for completion without timeout.
+	 */
+	wait_for_completion(&it6505->mux_register);
+
+	/* Abort when the switches are unregistered. */
+	if (!it6505->port_data) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	old_dp_connected = it6505->port_data[0].dp_connected ||
+			   it6505->port_data[1].dp_connected;
+
+	it6505->port_data[port->port_num].dp_connected =
+		state->alt &&
+		state->alt->svid == USB_TYPEC_DP_SID &&
+		state->alt->mode == USB_TYPEC_DP_MODE;
+
+	dev_dbg(dev, "mux_set dp_connected: c0=%d, c1=%d\n",
+		it6505->port_data[0].dp_connected, it6505->port_data[1].dp_connected);
+
+	new_dp_connected = it6505->port_data[0].dp_connected ||
+			   it6505->port_data[1].dp_connected;
+
+	if (it6505->enable_drv_hold) {
+		dev_dbg(dev, "enable driver hold\n");
+		goto unlock;
+	}
+
+	it6505_typec_ports_update(it6505);
+
+	if (!old_dp_connected && new_dp_connected) {
+		/*
+		 * pm_runtime_force_suspend() disables runtime PM when the
+		 * system enters suspend state. But on system resume, mux_set
+		 * can be triggered before pm_runtime_force_resume() re-enables
+		 * runtime PM. This makes the bridge stay powered off if the
+		 * downstream display is connected when the system is suspended.
+		 * Handling the error here to make sure the bridge is powered
+		 * on, and leave the PM runtime usage count incremented so
+		 * the future runtime PM calls is balanced.
+		 */
+		if (pm_runtime_get_sync(dev) < 0)
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
+	return ret;
+}
+
+static void it6505_unregister_typec_switches(struct it6505 *it6505)
+{
+	drm_dp_unregister_typec_switches(&it6505->switch_desc);
+	it6505->port_data = NULL;
+}
+
+static int it6505_register_typec_switches(struct device *dev, struct it6505 *it6505)
+{
+	struct device_node *port_node = of_graph_get_port_by_id(dev->of_node, 1);
+	struct drm_dp_typec_switch_desc *switch_desc = &it6505->switch_desc;
+	int ret;
+	u32 dp_lanes[4];
+	unsigned int i, num_lanes;
+
+	ret = drm_dp_register_typec_switches(dev, &port_node->fwnode,
+					     &it6505->switch_desc, it6505,
+					     it6505_typec_mux_set);
+	if (ret)
+		return ret;
+
+	it6505->port_data = devm_kcalloc(dev, switch_desc->num_typec_switches,
+					 sizeof(*it6505->port_data),
+					 GFP_KERNEL);
+	if (!it6505->port_data) {
+		ret = -ENOMEM;
+		goto unregister_mux;
+	}
+
+	for (i = 0; i < switch_desc->num_typec_switches; i++) {
+		struct drm_dp_typec_port_data *port = &switch_desc->typec_ports[i];
+		struct fwnode_handle *fwnode = port->fwnode;
+
+		ret = fwnode_property_count_u32(fwnode, "data-lanes");
+		if (ret < 0) {
+			dev_err(dev,
+				"Error on getting data lanes count from %pfwP: %d\n",
+				fwnode, ret);
+			goto unregister_mux;
+		}
+		if (ret > 2) {
+			dev_err(dev,
+				"Invalid data lanes count for mode switches from %pfwP: %d\n",
+				fwnode, ret);
+			ret = -EINVAL;
+			goto unregister_mux;
+		}
+		num_lanes = ret;
+
+		ret = fwnode_property_read_u32_array(fwnode, "data-lanes",
+						     dp_lanes, num_lanes);
+		if (ret) {
+			dev_err(dev,
+				"Failed to read the data-lanes variable: %d\n",
+				ret);
+			goto unregister_mux;
+		}
+
+		it6505->port_data[i].lane_swap = (dp_lanes[0] >= 2);
+	}
+	complete_all(&it6505->mux_register);
+
+	return 0;
+
+unregister_mux:
+	it6505_unregister_typec_switches(it6505);
+	complete_all(&it6505->mux_register);
+	return ret;
+}
+
 static int it6505_i2c_probe(struct i2c_client *client)
 {
 	struct it6505 *it6505;
 	struct device *dev = &client->dev;
 	struct extcon_dev *extcon;
-	int err, intp_irq;
+	int err, intp_irq, ret;
 
 	it6505 = devm_kzalloc(&client->dev, sizeof(*it6505), GFP_KERNEL);
 	if (!it6505)
@@ -3379,14 +3550,26 @@ static int it6505_i2c_probe(struct i2c_client *client)
 
 	/* get extcon device from DTS */
 	extcon = extcon_get_edev_by_phandle(dev, 0);
-	if (PTR_ERR(extcon) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-	if (IS_ERR(extcon)) {
-		dev_err(dev, "can not get extcon device!");
-		return PTR_ERR(extcon);
+	ret = PTR_ERR_OR_ZERO(extcon);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+	if (ret) {
+		if (ret != -ENODEV)
+			dev_warn(dev, "Cannot get extcon device: %d\n", ret);
+
+		it6505->extcon = NULL;
+	} else {
+		it6505->extcon = extcon;
 	}
 
-	it6505->extcon = extcon;
+	init_completion(&it6505->mux_register);
+	ret = it6505_register_typec_switches(dev, it6505);
+	if (ret != -ENODEV)
+		dev_warn(dev, "Didn't register Type-C switches, err: %d\n", ret);
+	if (ret && !it6505->extcon) {
+		dev_err(dev, "Both extcon and Type-C switch are not registered.\n");
+		return ret;
+	}
 
 	it6505->regmap = devm_regmap_init_i2c(client, &it6505_regmap_config);
 	if (IS_ERR(it6505->regmap)) {
@@ -3458,6 +3641,7 @@ static void it6505_i2c_remove(struct i2c_client *client)
 	it6505_debugfs_remove(it6505);
 	it6505_poweroff(it6505);
 	it6505_remove_edid(it6505);
+	it6505_unregister_typec_switches(it6505);
 }
 
 static const struct i2c_device_id it6505_id[] = {
-- 
2.40.0.348.gf938b09366-goog

