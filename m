Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C07660DCD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 11:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjAGKX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 05:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjAGKXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:23:01 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6427F8BF10
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 02:23:00 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso2597494pjl.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 02:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vk6NGcipu/mOeHU6ZjpOH7eJ5ckPZsNgiu0Kdi+7+sc=;
        b=KKueoDmdumc0cBC0mDXZqEtJsgGxOy9pJBdnxVjLUxIqhad/6daWqIpnlHC4R4NEny
         S+N3Kpbbavrh8TMPf/+uXsbsLfYiDSlti2GancnZPs2gDxPX8dTYpMFZWBCbDe8rE7CY
         E5TzrkPGfkQb+BiwDuDC25Phut4a3okYC5aa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk6NGcipu/mOeHU6ZjpOH7eJ5ckPZsNgiu0Kdi+7+sc=;
        b=TTpy9fbhh+I0+c7mEfAy81BiiEXmuJwuy//22et6btVezUKZnCRkX97Zeqb8fTpE0w
         CVB7nl5nTvxUOA0idfxQ5wiS2shKJnKqqEBMqk8X7H56OETsrrzzvxbEkb1BysCbDlea
         VrT9Eh/JYZ5LJkA0SiQm6cXns5i6gdh2yXe8eNx0jHmB8vvQK7FCZuyk+l4hBLGiOq6Z
         jv9HU1VLK55IHdSSJKL5pU3hVHAOtWo0g82Z0WoVhZfMEWqOCOocNi8sXtDyG38598Nk
         KR3/wLpA9Aj9inENdetmBW/H6ojaatd8oGEhatc8PzqzGive1yEUS0WCBYWw8WpoBClr
         Xv/A==
X-Gm-Message-State: AFqh2kqTo1MUo3EdEJNBdrOkOfzP5zyEUcs9MdLLW4ybB9IV1zX4czkw
        WTquYXKeF2NtG3MyhqcZZ/yPAg==
X-Google-Smtp-Source: AMrXdXvHbfhPl8qGKDebh6WMK2833EcJ579689/BiMFK/DuoxCNRAnIaFZU7x7cJj2l7EeDiywXfHA==
X-Received: by 2002:a17:902:82c4:b0:192:622a:ff9c with SMTP id u4-20020a17090282c400b00192622aff9cmr56080716plz.39.1673086979783;
        Sat, 07 Jan 2023 02:22:59 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:180d:95e8:f4:84fb])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b001892af9472esm2366362plh.261.2023.01.07.02.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 02:22:59 -0800 (PST)
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
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH v8 3/9] drm/display: Add Type-C switch helpers
Date:   Sat,  7 Jan 2023 18:22:25 +0800
Message-Id: <20230107102231.23682-4-treapking@chromium.org>
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

Add helpers to register and unregister Type-C "switches" for bridges
capable of switching their output between two downstream devices.

The helper registers USB Type-C mode switches when the "mode-switch"
and the "data-lanes" properties are available in Device Tree.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

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

