Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE52066205F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbjAIImS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjAIIl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:41:29 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906981274E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:41:28 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l1-20020a17090a384100b00226f05b9595so6637994pjf.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 00:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MXOYfmNfd9KcAxT0zPGzT8IazJsHl6r6/YGz1PqL0o=;
        b=ha/L8kak1f9aKvzSGEswK90wmUBWDjlLO+9uca9p8po9lfL+ceRpgn+JdV8CHaynXZ
         yD4qxhJMMjRew7wlYlDJCMyuKfwOCDGk0JL3OFCXf+fK+FyW5qO7ILcrb05U4mrtvSkH
         lIeaAmTL+QvB1ZTF8eJzJueDm9+BQmY2stXU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MXOYfmNfd9KcAxT0zPGzT8IazJsHl6r6/YGz1PqL0o=;
        b=tp1ggrQSp/mZG++eQDQDleuxdRm9dG2s0/MwpmF9TAFzJnXMMfqUxmd8htseewp2N6
         VHqBuhiOpLUQaDicJf730dRKTQMR0cgdNQKZ3WIiuncxPhUxW4AbY82+ID4RlK7Irbss
         qfCUV44K1fmSe8KH6yQDkzx6TRqNJduoTS2/6MjjQY1qhIVYSKUYT4X1Q+vJsBWmB+ei
         TCaFuIJHBpSPygcpYBzsea+jjj/AfeSloOpJAaifTT8V+8vz4KfSduT7K6dFNg0FpYiF
         8vG+cwUusf9iTJRiR6a53bwwVmIoeKWxSjHHnMVbz84hz056SZAOgjutpWUUogG/h7ZH
         5HgQ==
X-Gm-Message-State: AFqh2ko6aFEyFg1k5NbDRf5fpQxWdhN6qCk4Zz0qfPaQjYoaLQJD5qos
        bCt/vZorpir2iMO+hN/xGQp1uQ==
X-Google-Smtp-Source: AMrXdXuZ6CwfLD6kHpFWfIWQ6cAM+BRx8IBuTVjcl+pmMt7pQpASC6xCc6wxKkxtKgMPbCj7WijycA==
X-Received: by 2002:a17:902:d346:b0:192:9160:6cd with SMTP id l6-20020a170902d34600b00192916006cdmr45511750plk.13.1673253688284;
        Mon, 09 Jan 2023 00:41:28 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:801:a736:715:9a15])
        by smtp.gmail.com with ESMTPSA id c14-20020a170902d48e00b00186acb14c4asm5568119plg.67.2023.01.09.00.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 00:41:28 -0800 (PST)
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
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Stephen Boyd <swboyd@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Xin Ji <xji@analogixsemi.com>, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Allen Chen <allen.chen@ite.com.tw>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH v9 3/9] drm/display: Add Type-C switch helpers
Date:   Mon,  9 Jan 2023 16:40:55 +0800
Message-Id: <20230109084101.265664-4-treapking@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230109084101.265664-1-treapking@chromium.org>
References: <20230109084101.265664-1-treapking@chromium.org>
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

Add helpers to register and unregister Type-C "switches" for bridges
capable of switching their output between two downstream devices.

The helper registers USB Type-C mode switches when the "mode-switch"
and the "data-lanes" properties are available in Device Tree.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

(no changes since v8)

Changes in v8:
- Fixed the build issue when CONFIG_TYPEC=m
- Fixed some style issues

Changes in v7:
- Extracted the common codes to a helper function
- New in v7

 drivers/gpu/drm/display/drm_dp_helper.c | 132 ++++++++++++++++++++++++
 include/drm/display/drm_dp_helper.h     |  16 +++
 2 files changed, 148 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 16565a0a5da6..fb9e23744c08 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -30,11 +30,13 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/string_helpers.h>
+#include <linux/usb/typec_mux.h>
 #include <linux/dynamic_debug.h>
 
 #include <drm/display/drm_dp_helper.h>
 #include <drm/display/drm_dp_mst_helper.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_panel.h>
@@ -3891,3 +3893,133 @@ int drm_panel_dp_aux_backlight(struct drm_panel *panel, struct drm_dp_aux *aux)
 EXPORT_SYMBOL(drm_panel_dp_aux_backlight);
 
 #endif
+
+#if IS_REACHABLE(CONFIG_TYPEC)
+static int drm_dp_register_mode_switch(struct device *dev, struct device_node *node,
+				       struct drm_dp_typec_switch_desc *switch_desc,
+				       void *data, void *mux_set)
+{
+	struct drm_dp_typec_port_data *port_data;
+	struct typec_mux_desc mux_desc = {};
+	char name[32];
+	u32 dp_lanes[2];
+	int ret, num_lanes, port_num = -1;
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
+	port_num = dp_lanes[0] / 2;
+
+	port_data = &switch_desc->typec_ports[port_num];
+	port_data->data = data;
+	mux_desc.fwnode = &node->fwnode;
+	mux_desc.drvdata = port_data;
+	snprintf(name, sizeof(name), "%s-%u", node->name, port_num);
+	mux_desc.name = name;
+	mux_desc.set = mux_set;
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
+/**
+ * drm_dp_register_typec_switches() - register Type-C switches
+ * @dev: Device that registers Type-C switches
+ * @port: Device node for the switch
+ * @switch_desc: A Type-C switch descriptor
+ * @data: Private data for the switches
+ * @mux_set: Callback function for typec_mux_set
+ *
+ * This function registers USB Type-C switches for DP bridges that can switch
+ * the output signal between their output pins.
+ *
+ * Currently only mode switches are implemented, and the function assumes the
+ * given @port device node has endpoints with "mode-switch" property.
+ * Register the endpoint as port 0 if the "data-lanes" property falls in 0/1,
+ * and register it as port 1 if "data-lanes" falls in 2/3.
+ */
+int drm_dp_register_typec_switches(struct device *dev, struct device_node *port,
+				   struct drm_dp_typec_switch_desc *switch_desc,
+				   void *data, void *mux_set)
+{
+	struct device_node *sw;
+	int ret;
+
+	for_each_child_of_node(port, sw) {
+		if (of_property_read_bool(sw, "mode-switch"))
+			switch_desc->num_typec_switches++;
+	}
+
+	if (!switch_desc->num_typec_switches) {
+		dev_warn(dev, "No Type-C switches node found\n");
+		return 0;
+	}
+
+	switch_desc->typec_ports = devm_kcalloc(
+		dev, switch_desc->num_typec_switches,
+		sizeof(struct drm_dp_typec_port_data), GFP_KERNEL);
+
+	if (!switch_desc->typec_ports)
+		return -ENOMEM;
+
+	/* Register switches for each connector. */
+	for_each_child_of_node(port, sw) {
+		if (!of_property_read_bool(sw, "mode-switch"))
+			continue;
+		ret = drm_dp_register_mode_switch(dev, sw, switch_desc, data, mux_set);
+		if (ret)
+			goto err_unregister_typec_switches;
+	}
+
+	return 0;
+
+err_unregister_typec_switches:
+	of_node_put(sw);
+	drm_dp_unregister_typec_switches(switch_desc);
+	dev_err(dev, "Failed to register mode switch: %d\n", ret);
+	return ret;
+}
+EXPORT_SYMBOL(drm_dp_register_typec_switches);
+
+/**
+ * drm_dp_unregister_typec_switches() - unregister Type-C switches
+ * @switch_desc: A Type-C switch descriptor
+ */
+void drm_dp_unregister_typec_switches(struct drm_dp_typec_switch_desc *switch_desc)
+{
+	int i;
+
+	for (i = 0; i < switch_desc->num_typec_switches; i++)
+		typec_mux_unregister(switch_desc->typec_ports[i].typec_mux);
+}
+EXPORT_SYMBOL(drm_dp_unregister_typec_switches);
+#else
+void drm_dp_unregister_typec_switches(struct drm_dp_typec_switch_desc *switch_desc)
+{
+}
+EXPORT_SYMBOL(drm_dp_register_typec_switches);
+int drm_dp_register_typec_switches(struct device *dev, struct device_node *port,
+				   struct drm_dp_typec_switch_desc *switch_desc,
+				   void *data, void *mux_set)
+{
+	return 0;
+}
+EXPORT_SYMBOL(drm_dp_unregister_typec_switches);
+#endif
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index ab55453f2d2c..fef0a9a0d8ea 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -763,4 +763,20 @@ bool drm_dp_downstream_rgb_to_ycbcr_conversion(const u8 dpcd[DP_RECEIVER_CAP_SIZ
 					       const u8 port_cap[4], u8 color_spc);
 int drm_dp_pcon_convert_rgb_to_ycbcr(struct drm_dp_aux *aux, u8 color_spc);
 
+struct drm_dp_typec_port_data {
+	struct typec_mux_dev *typec_mux;
+	void *data;
+	bool dp_connected;
+};
+
+struct drm_dp_typec_switch_desc {
+	int num_typec_switches;
+	struct drm_dp_typec_port_data *typec_ports;
+};
+
+void drm_dp_unregister_typec_switches(struct drm_dp_typec_switch_desc *switch_desc);
+int drm_dp_register_typec_switches(struct device *dev, struct device_node *port,
+				   struct drm_dp_typec_switch_desc *switch_desc,
+				   void *data, void *mux_set);
+
 #endif /* _DRM_DP_HELPER_H_ */
-- 
2.39.0.314.g84b9a713c41-goog

