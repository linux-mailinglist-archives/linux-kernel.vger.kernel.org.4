Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDB3715724
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjE3Hj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjE3Hi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:38:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674C7188
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:38:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30ae901a9ffso1992080f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685432306; x=1688024306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9gRTS7DQWqJ/ikd7+9POX0/pTKqtzhXUCItDdZ3jbM=;
        b=WXinKsk30KKsL1JG1OHxfbHPq+b9sjMSAoY516xZKiKa9cVA1u3jN22XXrJkLCC7T1
         SxtWPI2vLzMXwh6vMCdYwwxqUl4pWHvX975N6mli85nOG7FTrZtDPeHNb4W6ZSJShTSV
         zmzGJ5XT6c8UIad8QJHkFkP90Q/3hdo+hHpnVCVtjN1RVLpvC60dgsYoyugMwX23DV9Y
         Tz+t/Yes2G13wldgnvFCNolw5ksSESag0Mdtr3LPXHjCTmgvLTeDGyePCAVM+nrlZvyM
         lInuZfB7hXtQQnuUnJpY5Z7NC7kp/yIWPATTYMO+pM4p2cZ8h8RXRnIwJ2OymPqSZ5bs
         8SoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685432306; x=1688024306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9gRTS7DQWqJ/ikd7+9POX0/pTKqtzhXUCItDdZ3jbM=;
        b=foC4JrAF37id0X6iqPUOg5IJNdv3iHZpCZlfQ19Y8D5qutcnlyd6sFptlBY6Lnw2AL
         AxIce72lad91/xX/BF/0mJkrl5uagnHs6GVG/Ci9AZgFLsyViRVRzQutr6DhQKE7Y9cs
         517bVGsRX4YhOjVO7rQrxPH2Q+NM4ZsBpzWkRcdg8V+7HPBnYpjFcXd4Yl/M2X3GcCwr
         52TO9Hly4EYUi69VuCrL9NwfP69Z+4jC6eXh1lvjqWeBG1XPwQN7T6fYryr0U4B4nL4K
         ZgSU1gQYi2PJN1Ggewees6KXHLz3/fTceZ1+bi07Nc54+yscIWXYcE8IYklPEa3b+92W
         P5WQ==
X-Gm-Message-State: AC+VfDyEFyHkpZ05ws3PsRU2ROF1WiIA6ZGJXl4V1p8TDcuPi9Avu2W7
        sUZZ0txwxKGqF7Cp0s5LbUo/Zg==
X-Google-Smtp-Source: ACHHUZ5KZL+8LqZUrCw+Q8RwTQBwlsmD8H329Cuh+zb0fXAEOI/FLnAfR9yNbswmzKNpgW3CRO3oNw==
X-Received: by 2002:adf:fc4e:0:b0:306:2c5b:9da6 with SMTP id e14-20020adffc4e000000b003062c5b9da6mr1157399wrs.56.1685432306551;
        Tue, 30 May 2023 00:38:26 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d4a04000000b003079c402762sm2312013wrq.19.2023.05.30.00.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 00:38:26 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 30 May 2023 09:38:12 +0200
Subject: [PATCH v5 11/17] drm/meson: add DSI encoder
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-11-56eb7a4d5b8e@linaro.org>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org>
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     "Lukas F. Hartmann" <lukas@mntre.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9381;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=CRG+a62gljx1JJalXPQmGyJpYRgdP01x+Wart/fUwko=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkdafhlxYYfr8IFFJUzCs+6LdwBR/WBt6YLg2sWYwT
 KUjgDMqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHWn4QAKCRB33NvayMhJ0YfFD/
 0fdaBJI+6lBQGtNeDmSSDC8j5iBqsvkRmNYxSKOUwy7OTpNPCWLVQyy1/jXchX87k9j+NvSUoO8fpX
 DZAOzKBr1xenUtfwXeakF4q8IzNSji4LhhKM79jNzxgFsHDs+NIYh1P9md/PpU7VStjcER7wk311pM
 7hNa8VGkSkzlaR9Jmq81CHaubH9xQ4VVF6sKVLUwBQDJWLhq006r08GtuiA56Dqc8Tp5gM4jjWfFWv
 cLSOySKc7UVS27IGh61jb24kzIYOrl5XM3uhXJHyUiqMxxqva0tuxaZqQB2qVUjRHkUVi9fvX8EG1X
 RED0AjrcFoknRq6NDWeBNUDtTKbsY4am0IwKv+df31mOj0wGFaCqA1BmbGLebS42hUSfJicYkKG41L
 m+AWSUuntLe0OsAcr6WmyJZGp3HN4HjBJAWff2vdzVKmFx3svTiywry8/zTWg79b8ZkZR3VpXHPvT4
 sO05QcZvWY4nGUjYPZHi93gGE7ouS9Hwca5uYuQdvd9Nl/v88K8HiVkcxAyQxX0i/phXNk3Da8GJvo
 KIyU6OIzzhC0rkP27EX/j1SdhNHd+fBQmB7bsLMSQQW6iRZYPKvhKTtoVMLMFslNJaAbllJ/phPIlf
 BJXy+kvsF0NY4Bz96m6eyuCP/Ki22RdBNxZCgCIeOddIL22PA1L22mifaUVQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an encoder bridge designed to drive a MIPI-DSI display
by using the ENCL encoder through the internal MIPI DSI transceiver
connected to the output of the ENCL pixel encoder.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/meson/Makefile            |   2 +-
 drivers/gpu/drm/meson/meson_drv.c         |   9 ++
 drivers/gpu/drm/meson/meson_drv.h         |   1 +
 drivers/gpu/drm/meson/meson_encoder_dsi.c | 174 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/meson/meson_encoder_dsi.h |  13 +++
 5 files changed, 198 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/Makefile b/drivers/gpu/drm/meson/Makefile
index 3afa31bdc950..833e18c20603 100644
--- a/drivers/gpu/drm/meson/Makefile
+++ b/drivers/gpu/drm/meson/Makefile
@@ -2,7 +2,7 @@
 meson-drm-y := meson_drv.o meson_plane.o meson_crtc.o meson_encoder_cvbs.o
 meson-drm-y += meson_viu.o meson_vpp.o meson_venc.o meson_vclk.o meson_overlay.o
 meson-drm-y += meson_rdma.o meson_osd_afbcd.o
-meson-drm-y += meson_encoder_hdmi.o
+meson-drm-y += meson_encoder_hdmi.o meson_encoder_dsi.o
 
 obj-$(CONFIG_DRM_MESON) += meson-drm.o
 obj-$(CONFIG_DRM_MESON_DW_HDMI) += meson_dw_hdmi.o
diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index e935c0286a20..747b639ea0c4 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -34,6 +34,7 @@
 #include "meson_registers.h"
 #include "meson_encoder_cvbs.h"
 #include "meson_encoder_hdmi.h"
+#include "meson_encoder_dsi.h"
 #include "meson_viu.h"
 #include "meson_vpp.h"
 #include "meson_rdma.h"
@@ -329,6 +330,12 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	if (ret)
 		goto exit_afbcd;
 
+	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
+		ret = meson_encoder_dsi_init(priv);
+		if (ret)
+			goto exit_afbcd;
+	}
+
 	ret = meson_plane_create(priv);
 	if (ret)
 		goto exit_afbcd;
@@ -367,6 +374,7 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 free_drm:
 	drm_dev_put(drm);
 
+	meson_encoder_dsi_remove(priv);
 	meson_encoder_hdmi_remove(priv);
 	meson_encoder_cvbs_remove(priv);
 
@@ -399,6 +407,7 @@ static void meson_drv_unbind(struct device *dev)
 	free_irq(priv->vsync_irq, drm);
 	drm_dev_put(drm);
 
+	meson_encoder_dsi_remove(priv);
 	meson_encoder_hdmi_remove(priv);
 	meson_encoder_cvbs_remove(priv);
 
diff --git a/drivers/gpu/drm/meson/meson_drv.h b/drivers/gpu/drm/meson/meson_drv.h
index c62ee358456f..b23009a3380f 100644
--- a/drivers/gpu/drm/meson/meson_drv.h
+++ b/drivers/gpu/drm/meson/meson_drv.h
@@ -28,6 +28,7 @@ enum vpu_compatible {
 enum {
 	MESON_ENC_CVBS = 0,
 	MESON_ENC_HDMI,
+	MESON_ENC_DSI,
 	MESON_ENC_LAST,
 };
 
diff --git a/drivers/gpu/drm/meson/meson_encoder_dsi.c b/drivers/gpu/drm/meson/meson_encoder_dsi.c
new file mode 100644
index 000000000000..812e172dec63
--- /dev/null
+++ b/drivers/gpu/drm/meson/meson_encoder_dsi.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_graph.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
+#include <drm/drm_device.h>
+#include <drm/drm_probe_helper.h>
+
+#include "meson_drv.h"
+#include "meson_encoder_dsi.h"
+#include "meson_registers.h"
+#include "meson_venc.h"
+#include "meson_vclk.h"
+
+struct meson_encoder_dsi {
+	struct drm_encoder encoder;
+	struct drm_bridge bridge;
+	struct drm_bridge *next_bridge;
+	struct meson_drm *priv;
+};
+
+#define bridge_to_meson_encoder_dsi(x) \
+	container_of(x, struct meson_encoder_dsi, bridge)
+
+static int meson_encoder_dsi_attach(struct drm_bridge *bridge,
+				    enum drm_bridge_attach_flags flags)
+{
+	struct meson_encoder_dsi *encoder_dsi = bridge_to_meson_encoder_dsi(bridge);
+
+	return drm_bridge_attach(bridge->encoder, encoder_dsi->next_bridge,
+				 &encoder_dsi->bridge, flags);
+}
+
+static void meson_encoder_dsi_atomic_enable(struct drm_bridge *bridge,
+					    struct drm_bridge_state *bridge_state)
+{
+	struct meson_encoder_dsi *encoder_dsi = bridge_to_meson_encoder_dsi(bridge);
+	struct drm_atomic_state *state = bridge_state->base.state;
+	struct meson_drm *priv = encoder_dsi->priv;
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector *connector;
+
+	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
+	if (WARN_ON(!connector))
+		return;
+
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	if (WARN_ON(!conn_state))
+		return;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
+	if (WARN_ON(!crtc_state))
+		return;
+
+	/* ENCL clock setup is handled by CCF */
+
+	meson_venc_mipi_dsi_mode_set(priv, &crtc_state->adjusted_mode);
+	meson_encl_load_gamma(priv);
+
+	writel_relaxed(0, priv->io_base + _REG(ENCL_VIDEO_EN));
+
+	writel_bits_relaxed(ENCL_VIDEO_MODE_ADV_VFIFO_EN, ENCL_VIDEO_MODE_ADV_VFIFO_EN,
+			    priv->io_base + _REG(ENCL_VIDEO_MODE_ADV));
+	writel_relaxed(0, priv->io_base + _REG(ENCL_TST_EN));
+
+	writel_bits_relaxed(BIT(0), 0, priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_EN_CTRL));
+
+	writel_relaxed(1, priv->io_base + _REG(ENCL_VIDEO_EN));
+}
+
+static void meson_encoder_dsi_atomic_disable(struct drm_bridge *bridge,
+					     struct drm_bridge_state *bridge_state)
+{
+	struct meson_encoder_dsi *meson_encoder_dsi =
+					bridge_to_meson_encoder_dsi(bridge);
+	struct meson_drm *priv = meson_encoder_dsi->priv;
+
+	writel_relaxed(0, priv->io_base + _REG(ENCL_VIDEO_EN));
+
+	writel_bits_relaxed(BIT(0), BIT(0), priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_EN_CTRL));
+}
+
+static const struct drm_bridge_funcs meson_encoder_dsi_bridge_funcs = {
+	.attach	= meson_encoder_dsi_attach,
+	.atomic_enable = meson_encoder_dsi_atomic_enable,
+	.atomic_disable	= meson_encoder_dsi_atomic_disable,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+};
+
+int meson_encoder_dsi_init(struct meson_drm *priv)
+{
+	struct meson_encoder_dsi *meson_encoder_dsi;
+	struct device_node *remote;
+	int ret;
+
+	meson_encoder_dsi = devm_kzalloc(priv->dev, sizeof(*meson_encoder_dsi), GFP_KERNEL);
+	if (!meson_encoder_dsi)
+		return -ENOMEM;
+
+	/* DSI Transceiver Bridge */
+	remote = of_graph_get_remote_node(priv->dev->of_node, 2, 0);
+	if (!remote) {
+		dev_err(priv->dev, "DSI transceiver device is disabled");
+		return 0;
+	}
+
+	meson_encoder_dsi->next_bridge = of_drm_find_bridge(remote);
+	if (!meson_encoder_dsi->next_bridge) {
+		dev_dbg(priv->dev, "Failed to find DSI transceiver bridge\n");
+		return -EPROBE_DEFER;
+	}
+
+	/* DSI Encoder Bridge */
+	meson_encoder_dsi->bridge.funcs = &meson_encoder_dsi_bridge_funcs;
+	meson_encoder_dsi->bridge.of_node = priv->dev->of_node;
+	meson_encoder_dsi->bridge.type = DRM_MODE_CONNECTOR_DSI;
+
+	drm_bridge_add(&meson_encoder_dsi->bridge);
+
+	meson_encoder_dsi->priv = priv;
+
+	/* Encoder */
+	ret = drm_simple_encoder_init(priv->drm, &meson_encoder_dsi->encoder,
+				      DRM_MODE_ENCODER_DSI);
+	if (ret) {
+		dev_err(priv->dev, "Failed to init DSI encoder: %d\n", ret);
+		return ret;
+	}
+
+	meson_encoder_dsi->encoder.possible_crtcs = BIT(0);
+
+	/* Attach DSI Encoder Bridge to Encoder */
+	ret = drm_bridge_attach(&meson_encoder_dsi->encoder, &meson_encoder_dsi->bridge, NULL, 0);
+	if (ret) {
+		dev_err(priv->dev, "Failed to attach bridge: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * We should have now in place:
+	 * encoder->[dsi encoder bridge]->[dw-mipi-dsi bridge]->[panel bridge]->[panel]
+	 */
+
+	priv->encoders[MESON_ENC_DSI] = meson_encoder_dsi;
+
+	dev_dbg(priv->dev, "DSI encoder initialized\n");
+
+	return 0;
+}
+
+void meson_encoder_dsi_remove(struct meson_drm *priv)
+{
+	struct meson_encoder_dsi *meson_encoder_dsi;
+
+	if (priv->encoders[MESON_ENC_DSI]) {
+		meson_encoder_dsi = priv->encoders[MESON_ENC_DSI];
+		drm_bridge_remove(&meson_encoder_dsi->bridge);
+		drm_bridge_remove(meson_encoder_dsi->next_bridge);
+	}
+}
diff --git a/drivers/gpu/drm/meson/meson_encoder_dsi.h b/drivers/gpu/drm/meson/meson_encoder_dsi.h
new file mode 100644
index 000000000000..9277d7015193
--- /dev/null
+++ b/drivers/gpu/drm/meson/meson_encoder_dsi.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2021 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#ifndef __MESON_ENCODER_DSI_H
+#define __MESON_ENCODER_DSI_H
+
+int meson_encoder_dsi_init(struct meson_drm *priv);
+void meson_encoder_dsi_remove(struct meson_drm *priv);
+
+#endif /* __MESON_ENCODER_DSI_H */

-- 
2.34.1

