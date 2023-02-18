Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C9169B9B1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 12:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBRLSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 06:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBRLSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 06:18:15 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970325BB8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 03:17:50 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id j1so192194pfu.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 03:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSUXhwP2T6y6hqUphQwZzIcqD97JaNMTBQcCPNpA7ZY=;
        b=K1ebpzy7sQJrifSr7e6YnSVeGJ8lDRR1yYZfXCzj4juhrWWGZvln6tIvaFW84W9fZD
         wwL7IzYZEc5IuBLUQ/9hdp5vkMg4XPS+XJ5eNBEEUN8+491hL4ySB+6rQN2X3UgwwSYV
         EAat6KZ08pXwtENkeDMWN8OHzDCPuqNLH2C3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSUXhwP2T6y6hqUphQwZzIcqD97JaNMTBQcCPNpA7ZY=;
        b=A8MivwTce+EhHEwfcq5Dkn7rp0mUcGNKhynSu1EEWApaYhxnkb9/HewqPqULbwAzZi
         vjH+o91IyxuFcDRjOGAxuWT3mT0Fkbd1p2ZGFqXyAHemD9HqnWiJJVcGKdaHRDUk5ox7
         JXuQ4J7iQiDqIeJgKEgrZ8wNfAjBl6MPxKKzpABe5g9/eFpOXcgFlrw3gwcGvImY784a
         3++/TnhUPLiE2oTlMFw/dM11RDKB7bAluS/N/uNmTmGEqyQ1cdL/qQPcrfGowrirUbzr
         VoJRW6RD/8zDx9bbJdkstdZSwZ09KqIRCSFOvsK7tLCkMQM6Kr5YtEDRUFKbIyo9J/Xw
         YJrA==
X-Gm-Message-State: AO0yUKXW1CQqaKr/wFFPm1LRL2FfHrIRGl0ct7Oqb+iPFG5qeOQ2ARK2
        mPHDDmkXQ39BPRNjvRaVSWannQ==
X-Google-Smtp-Source: AK7set/t1QPWaM3swLlams/S2tCFO1WlAAg0l17iP2nJ78MPCrsY8PR338sdT9FfB0Tov/MzBtYzLg==
X-Received: by 2002:a62:528d:0:b0:5a8:808a:d3ce with SMTP id g135-20020a62528d000000b005a8808ad3cemr4276103pfb.8.1676719070101;
        Sat, 18 Feb 2023 03:17:50 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:88dd:be84:8f65:fec2])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79157000000b005a8686b72fcsm4457829pfi.75.2023.02.18.03.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 03:17:49 -0800 (PST)
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
        Benson Leung <bleung@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v3 5/5] drm: bridge: Generic GPIO mux driver
Date:   Sat, 18 Feb 2023 19:17:12 +0800
Message-Id: <20230218111712.2380225-6-treapking@chromium.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230218111712.2380225-1-treapking@chromium.org>
References: <20230218111712.2380225-1-treapking@chromium.org>
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

From: Nicolas Boichat <drinkcat@chromium.org>

This driver supports single input, 2 output display mux (e.g.
HDMI mux), that provide its status via a GPIO.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

Changes in v3:
- Added .get_edid callback in generic-gpio-mux driver

Changes in v2:
- Dropped attach/mode_set/enable/disable callbacks
- Fixed style issues
- Removed the special case for the HDMI connector
- Made the driver only read the GPIO status in IRQ handler
- Rebased to drm-misc-next
- Update the license: "GPL v2" --> "GPL"

 drivers/gpu/drm/bridge/Kconfig            |  10 +
 drivers/gpu/drm/bridge/Makefile           |   1 +
 drivers/gpu/drm/bridge/generic-gpio-mux.c | 222 ++++++++++++++++++++++
 3 files changed, 233 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/generic-gpio-mux.c

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 12e8f30c65f7..42d7c418e8ff 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -73,6 +73,16 @@ config DRM_FSL_LDB
 	help
 	  Support for i.MX8MP DPI-to-LVDS on-SoC encoder.
 
+config DRM_GENERIC_GPIO_MUX
+	tristate "Generic GPIO-controlled mux"
+	depends on OF
+	select DRM_KMS_HELPER
+	help
+	  This bridge driver models a GPIO-controlled display mux with one
+	  input, 2 outputs (e.g. an HDMI mux). The hardware decides which output
+	  is active, reports it as a GPIO, and the driver redirects calls to the
+	  appropriate downstream bridge (if any).
+
 config DRM_ITE_IT6505
         tristate "ITE IT6505 DisplayPort bridge"
         depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 52f6e8b4a821..4d6d7f63330c 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_DRM_CHRONTEL_CH7033) += chrontel-ch7033.o
 obj-$(CONFIG_DRM_CROS_EC_ANX7688) += cros-ec-anx7688.o
 obj-$(CONFIG_DRM_DISPLAY_CONNECTOR) += display-connector.o
 obj-$(CONFIG_DRM_FSL_LDB) += fsl-ldb.o
+obj-$(CONFIG_DRM_GENERIC_GPIO_MUX) += generic-gpio-mux.o
 obj-$(CONFIG_DRM_ITE_IT6505) += ite-it6505.o
 obj-$(CONFIG_DRM_LONTIUM_LT8912B) += lontium-lt8912b.o
 obj-$(CONFIG_DRM_LONTIUM_LT9211) += lontium-lt9211.o
diff --git a/drivers/gpu/drm/bridge/generic-gpio-mux.c b/drivers/gpu/drm/bridge/generic-gpio-mux.c
new file mode 100644
index 000000000000..928edde701fa
--- /dev/null
+++ b/drivers/gpu/drm/bridge/generic-gpio-mux.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generic gpio mux bridge driver
+ *
+ * Copyright 2016 Google LLC
+ */
+
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+
+#include <drm/drm_bridge.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
+
+struct gpio_display_mux {
+	struct device *dev;
+
+	struct gpio_desc *gpiod_detect;
+	int detect_irq;
+	int cur_next;
+
+	struct drm_bridge bridge;
+
+	struct drm_bridge *next[2];
+};
+
+static inline struct gpio_display_mux *bridge_to_gpio_display_mux(
+		struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct gpio_display_mux, bridge);
+}
+
+static irqreturn_t gpio_display_mux_det_threaded_handler(int unused, void *data)
+{
+	struct gpio_display_mux *mux = data;
+	int active = gpiod_get_value(mux->gpiod_detect);
+
+	if (active < 0) {
+		dev_err(mux->dev, "Failed to get detect GPIO\n");
+		return IRQ_HANDLED;
+	}
+
+	dev_dbg(mux->dev, "Interrupt %d!\n", active);
+	mux->cur_next = active;
+
+	if (mux->bridge.dev)
+		drm_kms_helper_hotplug_event(mux->bridge.dev);
+
+	return IRQ_HANDLED;
+}
+
+static bool gpio_display_mux_mode_fixup(struct drm_bridge *bridge,
+				const struct drm_display_mode *mode,
+				struct drm_display_mode *adjusted_mode)
+{
+	struct gpio_display_mux *mux = bridge_to_gpio_display_mux(bridge);
+	struct drm_bridge *next;
+
+	next = mux->next[mux->cur_next];
+
+	/* Assume that we have a most one bridge in both downstreams */
+	if (next && next->funcs->mode_fixup)
+		return next->funcs->mode_fixup(next, mode, adjusted_mode);
+
+	return true;
+}
+
+static struct edid *gpio_display_mux_get_edid(struct drm_bridge *bridge,
+					      struct drm_connector *connector)
+{
+	struct gpio_display_mux *mux = bridge_to_gpio_display_mux(bridge);
+	struct drm_bridge *next;
+
+	next = mux->next[mux->cur_next];
+
+	return next->funcs->get_edid(next, connector);
+}
+
+static const struct drm_bridge_funcs gpio_display_mux_bridge_funcs = {
+	.mode_fixup = gpio_display_mux_mode_fixup,
+	.get_edid = gpio_display_mux_get_edid,
+};
+
+static int gpio_display_mux_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct gpio_display_mux *mux;
+	struct device_node *port, *ep, *remote;
+	int ret;
+	u32 reg;
+
+	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mux);
+	mux->dev = &pdev->dev;
+
+	mux->bridge.of_node = dev->of_node;
+
+	mux->gpiod_detect = devm_gpiod_get(dev, "detect", GPIOD_IN);
+	if (IS_ERR(mux->gpiod_detect))
+		return PTR_ERR(mux->gpiod_detect);
+
+	mux->detect_irq = gpiod_to_irq(mux->gpiod_detect);
+	if (mux->detect_irq < 0) {
+		dev_err(dev, "Failed to get output irq %d\n",
+			mux->detect_irq);
+		return -ENODEV;
+	}
+
+	port = of_graph_get_port_by_id(dev->of_node, 1);
+	if (!port) {
+		dev_err(dev, "Missing output port node\n");
+		return -EINVAL;
+	}
+
+	for_each_child_of_node(port, ep) {
+		if (!ep->name || (of_node_cmp(ep->name, "endpoint") != 0)) {
+			of_node_put(ep);
+			continue;
+		}
+
+		if (of_property_read_u32(ep, "reg", &reg) < 0 ||
+		    reg >= ARRAY_SIZE(mux->next)) {
+			dev_err(dev,
+				"Missing/invalid reg property for endpoint %s\n",
+				ep->full_name);
+			of_node_put(ep);
+			of_node_put(port);
+			return -EINVAL;
+		}
+
+		remote = of_graph_get_remote_port_parent(ep);
+		if (!remote) {
+			dev_err(dev,
+				"Missing connector/bridge node for endpoint %s\n",
+				ep->full_name);
+			of_node_put(ep);
+			of_node_put(port);
+			return -EINVAL;
+		}
+
+		mux->next[reg] = of_drm_find_bridge(remote);
+		if (!mux->next[reg]) {
+			dev_err(dev, "Waiting for external bridge %s\n",
+				remote->name);
+			of_node_put(ep);
+			of_node_put(remote);
+			of_node_put(port);
+			return -EPROBE_DEFER;
+		}
+
+		of_node_put(remote);
+	}
+	of_node_put(port);
+
+	/*
+	 * Because the next bridges are not registered to the drm bridge chain,
+	 * we have to set DRM_BRIDGE_OP_EDID here and trigger the .get_edid
+	 * callbacks of the actual connectors.
+	 */
+	if (mux->next[0] && mux->next[0]->ops & DRM_BRIDGE_OP_EDID &&
+	    mux->next[1] && mux->next[1]->ops & DRM_BRIDGE_OP_EDID)
+		mux->bridge.ops |= DRM_BRIDGE_OP_EDID;
+
+	mux->bridge.funcs = &gpio_display_mux_bridge_funcs;
+	mux->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
+	drm_bridge_add(&mux->bridge);
+
+	ret = devm_request_threaded_irq(dev, mux->detect_irq, NULL,
+					gpio_display_mux_det_threaded_handler,
+					IRQF_TRIGGER_RISING |
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					"gpio-display-mux-det", mux);
+	if (ret) {
+		dev_err(dev, "Failed to request MUX_DET threaded irq\n");
+		goto err_bridge_remove;
+	}
+
+	return 0;
+
+err_bridge_remove:
+	drm_bridge_remove(&mux->bridge);
+
+	return ret;
+}
+
+static int gpio_display_mux_remove(struct platform_device *pdev)
+{
+	struct gpio_display_mux *mux = platform_get_drvdata(pdev);
+
+	disable_irq(mux->detect_irq);
+	drm_bridge_remove(&mux->bridge);
+
+	return 0;
+}
+
+static const struct of_device_id gpio_display_mux_match[] = {
+	{ .compatible = "gpio-display-mux", },
+	{},
+};
+
+struct platform_driver gpio_display_mux_driver = {
+	.probe = gpio_display_mux_probe,
+	.remove = gpio_display_mux_remove,
+	.driver = {
+		.name = "gpio-display-mux",
+		.of_match_table = gpio_display_mux_match,
+	},
+};
+
+module_platform_driver(gpio_display_mux_driver);
+
+MODULE_DESCRIPTION("GPIO-controlled display mux");
+MODULE_AUTHOR("Nicolas Boichat <drinkcat@chromium.org>");
+MODULE_LICENSE("GPL");
-- 
2.39.2.637.g21b0678d19-goog

