Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEC474145E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjF1OzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjF1Oyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:54:54 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB372127
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:54:45 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fa9850bfd9so35261655e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687964084; x=1690556084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEIDKnY6hlz8qR0CTjocfFcu7D9gRkb8diLHleyV7Hg=;
        b=BmTY+XOhWVYgq4KUy7tlPqQxvwo44RQk2kkYyh9vyxiuZytG9SajUwrCj7o22SS4iY
         yYVzFZT71QJjfcBdLHMAKg5w3T0yjQuPBbQ6xLqaHPQ8gCZeysBmLggg45xFunJ2zEaU
         5TyJ/SDjDuwKxu7mSBj8Uiu4XaS/dkZ8vy4Q4zOXJ5Bm3T3mjeM4lY0+F/88zhEwFUl1
         022zb3yxGzEqftfj1R83A0OvFknlI7HLhmL/YffjyQuXkGMb5cXkt+R+rN4g0K17143n
         pfUzwtHOWiMob7sV68F8b/S77vPSs1yKj3xM1jJrlWBL9QnTQgXQGLjtcJk50alHdAab
         ASbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687964084; x=1690556084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEIDKnY6hlz8qR0CTjocfFcu7D9gRkb8diLHleyV7Hg=;
        b=gafFML8vt7XYyxJQsPBLCbwnyY2KYzGiIAff8ugwyYBt6np0wtsuwjafEhj1E53JDN
         kBZTuJvIvcL9blGxPwcvRoDTX5PSqjsgVUpC4YZ5xKnwTkj7ph+hANgwdzkYk+Iuda8K
         ycb/8Gs79uOd+8QyAJ8thuQ83SBrYH91FnSwiVtAOcSoOHRITTzvJ+8K3KBSec7kl+kv
         qZ6FSJpPHFkE2K+Zu0NQzhJE4jyij7jTbsOPH5t83AXxXbusDq4Shmmd/O1/8D0xGB+J
         24q7YM0SH1z2cAfBtmQBIsDA+7Bi8Q4OvySYan1GN1Od1z08mHEkEu806BpSU1v2i6eq
         hOqA==
X-Gm-Message-State: AC+VfDyCV2zZ7+trWxmYCvv+lokLoOscHTfUrj0HxwM7+8sf8AWa9qwH
        pBLRfRoRvwlFBtJdk1p5XgHGHQ==
X-Google-Smtp-Source: ACHHUZ5oRFY6Qc3MyPdG9jRK2hGvh2fgGCGObLGa/MXoy4dPPOw1ctwij6+PNxlqcufkmB834kM1ZA==
X-Received: by 2002:a7b:c3d7:0:b0:3fb:40ce:503e with SMTP id t23-20020a7bc3d7000000b003fb40ce503emr5172147wmj.25.1687964083591;
        Wed, 28 Jun 2023 07:54:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c0b5000b003fba6709c68sm4846278wmr.47.2023.06.28.07.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:54:43 -0700 (PDT)
From:   Julien Stephan <jstephan@baylibre.com>
Cc:     Louis Kuo <louis.kuo@mediatek.com>,
        Phi-bang Nguyen <pnguyen@baylibre.com>,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Julien Stephan <jstephan@baylibre.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 2/4] media: platform: mediatek: isp_30: add mediatek ISP3.0 sensor interface
Date:   Wed, 28 Jun 2023 16:52:53 +0200
Message-ID: <20230628145412.1610260-3-jstephan@baylibre.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628145412.1610260-1-jstephan@baylibre.com>
References: <20230628145412.1610260-1-jstephan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Louis Kuo <louis.kuo@mediatek.com>

This will add the mediatek ISP3.0 seninf (sensor interface) driver found
on several Mediatek SoCs such as the mt8365.

Then seninf module has 4 physical CSI-2 inputs. Depending on the soc they
may not be all connected.

Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 MAINTAINERS                                   |    1 +
 drivers/media/platform/mediatek/Kconfig       |    1 +
 drivers/media/platform/mediatek/Makefile      |    1 +
 drivers/media/platform/mediatek/isp/Kconfig   |    2 +
 drivers/media/platform/mediatek/isp/Makefile  |    3 +
 .../platform/mediatek/isp/isp_30/Kconfig      |   16 +
 .../platform/mediatek/isp/isp_30/Makefile     |    3 +
 .../mediatek/isp/isp_30/seninf/Makefile       |    5 +
 .../mediatek/isp/isp_30/seninf/mtk_seninf.c   | 1559 +++++++++++++++++
 .../isp/isp_30/seninf/mtk_seninf_reg.h        |   99 ++
 10 files changed, 1690 insertions(+)
 create mode 100644 drivers/media/platform/mediatek/isp/Kconfig
 create mode 100644 drivers/media/platform/mediatek/isp/Makefile
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/Kconfig
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/Makefile
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/seninf/Makefile
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf.c
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf_reg.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1248a915a72f..4f83682732e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13262,6 +13262,7 @@ M:	Julien Stephan <jstephan@baylibre.com>
 M:	Andy Hsieh <andy.hsieh@mediatek.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
+F:	drivers/media/platform/mediatek/isp/isp_30/seninf/*
 
 MEDIATEK SMI DRIVER
 M:	Yong Wu <yong.wu@mediatek.com>
diff --git a/drivers/media/platform/mediatek/Kconfig b/drivers/media/platform/mediatek/Kconfig
index 84104e2cd024..4e0a5a43f35e 100644
--- a/drivers/media/platform/mediatek/Kconfig
+++ b/drivers/media/platform/mediatek/Kconfig
@@ -7,3 +7,4 @@ source "drivers/media/platform/mediatek/mdp/Kconfig"
 source "drivers/media/platform/mediatek/vcodec/Kconfig"
 source "drivers/media/platform/mediatek/vpu/Kconfig"
 source "drivers/media/platform/mediatek/mdp3/Kconfig"
+source "drivers/media/platform/mediatek/isp/Kconfig"
diff --git a/drivers/media/platform/mediatek/Makefile b/drivers/media/platform/mediatek/Makefile
index 38e6ba917fe5..695f05f525a6 100644
--- a/drivers/media/platform/mediatek/Makefile
+++ b/drivers/media/platform/mediatek/Makefile
@@ -4,3 +4,4 @@ obj-y += mdp/
 obj-y += vcodec/
 obj-y += vpu/
 obj-y += mdp3/
+obj-y += isp/
diff --git a/drivers/media/platform/mediatek/isp/Kconfig b/drivers/media/platform/mediatek/isp/Kconfig
new file mode 100644
index 000000000000..708b9a6660d2
--- /dev/null
+++ b/drivers/media/platform/mediatek/isp/Kconfig
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+source "drivers/media/platform/mediatek/isp/isp_30/Kconfig"
diff --git a/drivers/media/platform/mediatek/isp/Makefile b/drivers/media/platform/mediatek/isp/Makefile
new file mode 100644
index 000000000000..a81ab33d0dd3
--- /dev/null
+++ b/drivers/media/platform/mediatek/isp/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-y += isp_30/
diff --git a/drivers/media/platform/mediatek/isp/isp_30/Kconfig b/drivers/media/platform/mediatek/isp/isp_30/Kconfig
new file mode 100644
index 000000000000..831f9bee5fdd
--- /dev/null
+++ b/drivers/media/platform/mediatek/isp/isp_30/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config MTK_SENINF
+	tristate "MediaTek ISP3.0 SENINF driver"
+	depends on VIDEO_V4L2_SUBDEV_API
+	depends on MEDIA_CAMERA_SUPPORT
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on OF
+	select V4L2_FWNODE
+	default n
+	help
+	  This driver provides a MIPI CSI-2 receiver interface to connect
+	  an external camera module with MediaTek ISP3.0. It is able to handle
+	  multiple cameras at the same time.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mtk-seninf.
diff --git a/drivers/media/platform/mediatek/isp/isp_30/Makefile b/drivers/media/platform/mediatek/isp/isp_30/Makefile
new file mode 100644
index 000000000000..2e7d731d42b7
--- /dev/null
+++ b/drivers/media/platform/mediatek/isp/isp_30/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_MTK_SENINF) += seninf/
diff --git a/drivers/media/platform/mediatek/isp/isp_30/seninf/Makefile b/drivers/media/platform/mediatek/isp/isp_30/seninf/Makefile
new file mode 100644
index 000000000000..853dad32f2b3
--- /dev/null
+++ b/drivers/media/platform/mediatek/isp/isp_30/seninf/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+mtk-seninf-objs += mtk_seninf.o
+
+obj-$(CONFIG_MTK_SENINF) += mtk-seninf.o
diff --git a/drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf.c b/drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf.c
new file mode 100644
index 000000000000..65b2c2858d2f
--- /dev/null
+++ b/drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf.c
@@ -0,0 +1,1559 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_graph.h>
+#include <linux/of_platform.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/videodev2.h>
+#include <media/media-device.h>
+#include <media/media-entity.h>
+#include <media/v4l2-async.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-mc.h>
+#include <media/v4l2-subdev.h>
+
+#include "mtk_seninf_reg.h"
+
+#define SENINF_TIMESTAMP_STEP		0x67
+#define SENINF_SETTLE_DELAY		0x15
+#define SENINF_HS_TRAIL_PARAMETER	0x8
+
+#define SENINF_MAX_NUM_INPUTS		4
+#define SENINF_MAX_NUM_OUTPUTS		6
+#define SENINF_MAX_NUM_MUXES		6
+#define SENINF_MAX_NUM_PADS		(SENINF_MAX_NUM_INPUTS + \
+					 SENINF_MAX_NUM_OUTPUTS)
+
+#define SENINF_DEFAULT_BUS_FMT		MEDIA_BUS_FMT_SGRBG10_1X10
+#define SENINF_DEFAULT_WIDTH		1920
+#define SENINF_DEFAULT_HEIGHT		1080
+
+#define SENINF_PAD_10BIT		0
+
+#define SENINF_TEST_MODEL		0
+#define SENINF_NORMAL_MODEL		1
+#define SENINF_ALL_ERR_IRQ_EN		0x7f
+#define SENINF_IRQ_CLR_SEL		0x80000000
+
+#define SENINF_MIPI_SENSOR		0x8
+
+enum PIXEL_MODE {
+	ONE_PIXEL_MODE  = 0x0,
+	TWO_PIXEL_MODE  = 0x1,
+	FOUR_PIXEL_MODE = 0x2,
+};
+
+/* Port number in the device tree. */
+enum mtk_seninf_port {
+	CSI_PORT_0 = 0,	/* 4D1C or 2D1C */
+	CSI_PORT_1,	/* 4D1C */
+	CSI_PORT_2,	/* 4D1C */
+	CSI_PORT_0B,	/* 2D1C */
+};
+
+enum mtk_seninf_id {
+	SENINF_1 = 0,
+	SENINF_2 = 1,
+	SENINF_3 = 2,
+	SENINF_5 = 4,
+};
+
+static const u32 port_to_seninf_id[] = {
+	[CSI_PORT_0] = SENINF_1,
+	[CSI_PORT_1] = SENINF_3,
+	[CSI_PORT_2] = SENINF_5,
+	[CSI_PORT_0B] = SENINF_2,
+};
+
+enum mtk_seninf_phy_mode {
+	SENINF_PHY_MODE_NONE,
+	SENINF_PHY_MODE_4D1C,
+	SENINF_PHY_MODE_2D1C,
+};
+
+enum mtk_seninf_format_flag {
+	MTK_SENINF_FORMAT_BAYER = BIT(0),
+	MTK_SENINF_FORMAT_DPCM = BIT(1),
+	MTK_SENINF_FORMAT_JPEG = BIT(2),
+	MTK_SENINF_FORMAT_INPUT_ONLY = BIT(3),
+};
+
+/**
+ * struct mtk_seninf_conf - Model-specific SENINF parameters
+ * @model: Model description
+ * @nb_inputs: Number of SENINF inputs
+ * @nb_muxes: Number of SENINF MUX (FIFO) instances
+ * @nb_outputs: Number of outputs (to CAM and CAMSV instances)
+ */
+struct mtk_seninf_conf {
+	const char *model;
+	u8 nb_inputs;
+	u8 nb_muxes;
+	u8 nb_outputs;
+};
+
+/**
+ * struct mtk_seninf_format_info - Information about media bus formats
+ * @code: V4L2 media bus code
+ * @flags: Flags describing the format, as a combination of MTK_SENINF_FORMAT_*
+ */
+struct mtk_seninf_format_info {
+	u32 code;
+	u32 flags;
+};
+
+/**
+ * struct mtk_seninf_input - SENINF input block
+ * @pad: DT port and media entity pad number
+ * @seninf_id: SENINF hardware instance ID
+ * @base: Memory mapped I/O based address
+ * @seninf: Back pointer to the mtk_seninf
+ * @phy: PHY connected to the input
+ * @phy_mode: PHY operation mode (NONE when the input is not connected)
+ * @bus: CSI-2 bus configuration from DT
+ * @source_sd: Source subdev connected to the input
+ */
+struct mtk_seninf_input {
+	enum mtk_seninf_port pad;
+	enum mtk_seninf_id seninf_id;
+	void __iomem *base;
+	struct mtk_seninf *seninf;
+
+	struct phy *phy;
+	enum mtk_seninf_phy_mode phy_mode;
+
+	struct v4l2_mbus_config_mipi_csi2 bus;
+
+	struct v4l2_subdev *source_sd;
+};
+
+/**
+ * struct mtk_seninf_mux - SENINF MUX channel
+ * @pad: DT port and media entity pad number
+ * @mux_id: MUX hardware instance ID
+ * @base: Memory mapped I/O based address
+ * @seninf: Back pointer to the mtk_seninf
+ */
+struct mtk_seninf_mux {
+	unsigned int pad;
+	unsigned int mux_id;
+	void __iomem *base;
+	struct mtk_seninf *seninf;
+};
+
+/**
+ * struct mtk_seninf - Top-level SENINF device
+ * @dev: The (platform) device
+ * @phy: PHYs at the SENINF inputs
+ * @num_clks: Number of clocks in the clks array
+ * @clks: Clocks
+ * @base: Memory mapped I/O base address
+ * @media_dev: Media controller device
+ * @v4l2_dev: V4L2 device
+ * @subdev: V4L2 subdevice
+ * @pads: Media entity pads
+ * @notifier: V4L2 async notifier for source subdevs
+ * @ctrl_handler: V4L2 controls handler
+ * @source_format: Active format on the source pad
+ * @inputs: Array of SENINF inputs
+ * @muxes: Array of MUXes
+ * @conf: Model-specific SENINF parameters
+ * @is_testmode: Whether or not the test pattern generator is enabled
+ */
+struct mtk_seninf {
+	struct device *dev;
+	struct phy *phy[5];
+	unsigned int num_clks;
+	struct clk_bulk_data *clks;
+	void __iomem *base;
+
+	struct media_device media_dev;
+	struct v4l2_device v4l2_dev;
+	struct v4l2_subdev subdev;
+	struct media_pad pads[SENINF_MAX_NUM_PADS];
+	struct v4l2_async_notifier notifier;
+	struct v4l2_ctrl_handler ctrl_handler;
+
+	struct mtk_seninf_input inputs[SENINF_MAX_NUM_INPUTS];
+	struct mtk_seninf_mux muxes[SENINF_MAX_NUM_MUXES];
+
+	const struct mtk_seninf_conf *conf;
+
+	bool is_testmode;
+};
+
+inline struct mtk_seninf *sd_to_mtk_seninf(struct v4l2_subdev *sd)
+{
+	return container_of(sd, struct mtk_seninf, subdev);
+}
+
+static inline bool mtk_seninf_pad_is_sink(struct mtk_seninf *priv,
+					  unsigned int pad)
+{
+	return pad < priv->conf->nb_inputs;
+}
+
+static inline bool mtk_seninf_pad_is_source(struct mtk_seninf *priv,
+					    unsigned int pad)
+{
+	return !mtk_seninf_pad_is_sink(priv, pad);
+}
+
+/* -----------------------------------------------------------------------------
+ * Formats
+ */
+
+static const struct mtk_seninf_format_info mtk_seninf_formats[] = {
+	{
+		.code = MEDIA_BUS_FMT_SBGGR8_1X8,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SGBRG8_1X8,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SGRBG8_1X8,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SRGGB8_1X8,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SGRBG10_1X10,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SRGGB10_1X10,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SBGGR10_1X10,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SGBRG10_1X10,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SBGGR12_1X12,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SGBRG12_1X12,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SGRBG12_1X12,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SRGGB12_1X12,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SBGGR14_1X14,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SGBRG14_1X14,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SGRBG14_1X14,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SRGGB14_1X14,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SBGGR16_1X16,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SGBRG16_1X16,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SGRBG16_1X16,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_SRGGB16_1X16,
+		.flags = MTK_SENINF_FORMAT_BAYER,
+	}, {
+		.code = MEDIA_BUS_FMT_UYVY8_1X16,
+	}, {
+		.code = MEDIA_BUS_FMT_VYUY8_1X16,
+	}, {
+		.code = MEDIA_BUS_FMT_YUYV8_1X16,
+	}, {
+		.code = MEDIA_BUS_FMT_YVYU8_1X16,
+	}, {
+		.code = MEDIA_BUS_FMT_JPEG_1X8,
+		.flags = MTK_SENINF_FORMAT_JPEG,
+	}, {
+		.code = MEDIA_BUS_FMT_S5C_UYVY_JPEG_1X8,
+		.flags = MTK_SENINF_FORMAT_JPEG,
+	},
+	/* Keep the input-only formats last. */
+	{
+		.code = MEDIA_BUS_FMT_SGRBG10_DPCM8_1X8,
+		.flags = MTK_SENINF_FORMAT_DPCM | MTK_SENINF_FORMAT_INPUT_ONLY,
+	}, {
+		.code = MEDIA_BUS_FMT_SRGGB10_DPCM8_1X8,
+		.flags = MTK_SENINF_FORMAT_DPCM | MTK_SENINF_FORMAT_INPUT_ONLY,
+	}, {
+		.code = MEDIA_BUS_FMT_SBGGR10_DPCM8_1X8,
+		.flags = MTK_SENINF_FORMAT_DPCM | MTK_SENINF_FORMAT_INPUT_ONLY,
+	}, {
+		.code = MEDIA_BUS_FMT_SGBRG10_DPCM8_1X8,
+		.flags = MTK_SENINF_FORMAT_DPCM | MTK_SENINF_FORMAT_INPUT_ONLY,
+	}
+};
+
+static const struct mtk_seninf_format_info *mtk_seninf_format_info(u32 code)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(mtk_seninf_formats); ++i) {
+		if (mtk_seninf_formats[i].code == code)
+			return &mtk_seninf_formats[i];
+	}
+
+	return NULL;
+}
+
+/* -----------------------------------------------------------------------------
+ * I/O Accessors
+ */
+static u32 mtk_seninf_read(struct mtk_seninf *priv, u32 reg)
+{
+	return readl(priv->base + reg);
+}
+
+static void mtk_seninf_write(struct mtk_seninf *priv, u32 reg, u32 value)
+{
+	writel(value, priv->base + reg);
+}
+
+static void __mtk_seninf_update(struct mtk_seninf *priv, u32 reg,
+				u32 mask, u32 value)
+{
+	u32 val = mtk_seninf_read(priv, reg);
+
+	mtk_seninf_write(priv, reg, (val & ~mask) | (value & mask));
+}
+
+#define mtk_seninf_update(priv, reg, field, val)			\
+	__mtk_seninf_update(priv, reg, reg##_##field,		\
+			    FIELD_PREP(reg##_##field, val))
+
+static u32 mtk_seninf_input_read(struct mtk_seninf_input *input, u32 reg)
+{
+	return readl(input->base + reg);
+}
+
+static void mtk_seninf_input_write(struct mtk_seninf_input *input, u32 reg,
+				   u32 value)
+{
+	writel(value, input->base + reg);
+}
+
+static void __mtk_seninf_input_update(struct mtk_seninf_input *input, u32 reg,
+				      u32 mask, u32 value)
+{
+	u32 val = mtk_seninf_input_read(input, reg);
+
+	mtk_seninf_input_write(input, reg, (val & ~mask) | (value & mask));
+}
+
+#define mtk_seninf_input_update(input, reg, field, val)			\
+	__mtk_seninf_input_update(input, reg, reg##_##field,	\
+				  FIELD_PREP(reg##_##field, val))
+
+static u32 mtk_seninf_mux_read(struct mtk_seninf_mux *mux, u32 reg)
+{
+	return readl(mux->base + reg);
+}
+
+static void mtk_seninf_mux_write(struct mtk_seninf_mux *mux, u32 reg,
+				 u32 value)
+{
+	writel(value, mux->base + reg);
+}
+
+static void __mtk_seninf_mux_update(struct mtk_seninf_mux *mux, u32 reg,
+				    u32 mask, u32 value)
+{
+	u32 val = mtk_seninf_mux_read(mux, reg);
+
+	mtk_seninf_mux_write(mux, reg, (val & ~mask) | (value & mask));
+}
+
+#define mtk_seninf_mux_update(mux, reg, field, val)			\
+	__mtk_seninf_mux_update(mux, reg, reg##_##field,	\
+				FIELD_PREP(reg##_##field, val))
+
+/* -----------------------------------------------------------------------------
+ * Hardware Configuration
+ *
+ * The SENINF is the camera sensor interface. On the input side it contains
+ * input channels (also named SENINF), each made of a CSI-2 receiver, an
+ * interface for parallel sensors, and a test pattern generator. The inputs are
+ * routed through a N:M crossbar switch (TOP MUX) to VC/DT filters with a FIFO
+ * (MUX). The MUX are routed to another N:M crossbar switch (CAM MUX), whose
+ * output is then connected to other IP cores.
+ *
+ *            +-------------------------------------------------------+
+ *            | SENINF                                                |
+ *            |                                                       |
+ * +-------+  |   +----------+    TOP MUX                             |
+ * |       |  |   |  SENINF  |      |\                        CAM MUX |
+ * | D-PHY | ---> | CSI-2 RX | ---> | |      +------------+      |\   |
+ * |       |  |   |   TPG    |   -> | | ---> | MUX (FIFO) | ---> | | ---> CAMSV
+ * +-------+  |   +----------+   -> | |      +------------+   -> | |  |
+ *            |                     |/                        -> | |  |
+ *            |                                                  |/   |
+ *            |                                                       |
+ *    ...     |       ...                         ...                --->
+ *            |                                                       |
+ *            |                                                       |
+ *            +-------------------------------------------------------+
+ *
+ * The number of PHYs, SENINF and MUX differ between SoCs. MT8167 has a single
+ * MUX and thus no output CAM MUX crossbar switch.
+ */
+
+static void mtk_seninf_csi2_setup_phy(struct mtk_seninf *priv)
+{
+	/* CSI0 */
+	if (priv->inputs[CSI_PORT_0].phy) {
+		struct mtk_seninf_input *input = &priv->inputs[CSI_PORT_0];
+
+		mtk_seninf_update(priv, SENINF_TOP_PHY_SENINF_CTL_CSI0,
+				  DPHY_MODE, 0 /* 4D1C*/);
+		mtk_seninf_update(priv, SENINF_TOP_PHY_SENINF_CTL_CSI0,
+				  CK_SEL_1, input->bus.clock_lane);
+		mtk_seninf_update(priv, SENINF_TOP_PHY_SENINF_CTL_CSI0,
+				  CK_SEL_2, 2);
+		mtk_seninf_update(priv, SENINF_TOP_PHY_SENINF_CTL_CSI0,
+				  PHY_SENINF_LANE_MUX_CSI0_EN, 1);
+	}
+
+	/* CSI1 */
+	if (priv->inputs[CSI_PORT_1].phy) {
+		struct mtk_seninf_input *input = &priv->inputs[CSI_PORT_1];
+
+		mtk_seninf_update(priv, SENINF_TOP_PHY_SENINF_CTL_CSI1,
+				  DPHY_MODE, 0 /* 4D1C */);
+		mtk_seninf_update(priv, SENINF_TOP_PHY_SENINF_CTL_CSI1,
+				  CK_SEL_1, input->bus.clock_lane);
+		mtk_seninf_update(priv, SENINF_TOP_PHY_SENINF_CTL_CSI1,
+				  PHY_SENINF_LANE_MUX_CSI1_EN, 1);
+	}
+}
+
+static void mtk_seninf_input_setup_csi2_rx(struct mtk_seninf_input *input)
+{
+	unsigned int lanes[4] = { };
+	unsigned int i;
+
+	/*
+	 * Configure data lane muxing. In 2D1C mode, lanes 0 to 2 correspond to
+	 * CSIx[AB]_L{0,1,2}, and in 4D1C lanes 0 to 5 correspond to
+	 * CSIxA_L{0,1,2}, CSIxB_L{0,1,2}.
+	 *
+	 * The clock lane must be skipped when calculating the index of the
+	 * physical data lane. For instance, in 4D1C mode, the sensor clock
+	 * lane is typically connected to lane 2 (CSIxA_L2), and the sensor
+	 * data lanes 0-3 to lanes 1 (CSIxA_L1), 3 (CSIxB_L0), 0 (CSIxA_L0) and
+	 * 4 (CSIxB_L1). The when skipping the clock lane, the data lane
+	 * indices become 1, 2, 0 and 3.
+	 */
+	for (i = 0; i < input->bus.num_data_lanes; ++i) {
+		lanes[i] = input->bus.data_lanes[i];
+		if (lanes[i] > input->bus.clock_lane)
+			lanes[i]--;
+	}
+
+	mtk_seninf_input_update(input, MIPI_RX_CON24_CSI0,
+				CSI0_BIST_LN0_MUX, lanes[0]);
+	mtk_seninf_input_update(input, MIPI_RX_CON24_CSI0,
+				CSI0_BIST_LN1_MUX, lanes[1]);
+	mtk_seninf_input_update(input, MIPI_RX_CON24_CSI0,
+				CSI0_BIST_LN2_MUX, lanes[2]);
+	mtk_seninf_input_update(input, MIPI_RX_CON24_CSI0,
+				CSI0_BIST_LN3_MUX, lanes[3]);
+}
+
+static void mtk_seninf_input_setup_csi2(struct mtk_seninf_input *input,
+					struct v4l2_subdev_state *state)
+{
+	const struct mtk_seninf_format_info *fmtinfo;
+	const struct v4l2_mbus_framefmt *format;
+	unsigned int dpcm;
+	unsigned int data_lane_num = input->bus.num_data_lanes;
+	unsigned int data_header_order = 1;
+	unsigned int val = 0;
+
+	format = v4l2_subdev_state_get_stream_format(state, input->pad, 0);
+	fmtinfo = mtk_seninf_format_info(format->code);
+
+	/* Configure timestamp */
+	mtk_seninf_input_write(input, SENINF_TG1_TM_STP, SENINF_TIMESTAMP_STEP);
+
+	/* HQ */
+	mtk_seninf_input_write(input, SENINF_TG1_PH_CNT, 0x0);
+	mtk_seninf_input_write(input, SENINF_TG1_SEN_CK, 0x10001);
+
+	/* First Enable Sensor interface and select pad (0x1a04_0200) */
+	mtk_seninf_input_update(input, SENINF_CTRL, SENINF_EN, 1);
+	mtk_seninf_input_update(input, SENINF_CTRL, PAD2CAM_DATA_SEL, SENINF_PAD_10BIT);
+	mtk_seninf_input_update(input, SENINF_CTRL, SENINF_SRC_SEL, 0);
+	mtk_seninf_input_update(input, SENINF_CTRL_EXT, SENINF_CSI2_IP_EN, 1);
+	mtk_seninf_input_update(input, SENINF_CTRL_EXT, SENINF_NCSI2_IP_EN, 0);
+
+	/* DPCM Enable */
+	dpcm = fmtinfo->flags & MTK_SENINF_FORMAT_DPCM ? 0x2a : 0;
+	val = 1 << ((dpcm == 0x2a) ? 15 : ((dpcm & 0xF) + 7));
+	mtk_seninf_input_write(input, SENINF_CSI2_DPCM, val);
+
+	/* Settle delay */
+	mtk_seninf_input_update(input, SENINF_CSI2_LNRD_TIMING,
+				DATA_SETTLE_PARAMETER, SENINF_SETTLE_DELAY);
+
+	/* HQ */
+	mtk_seninf_input_write(input, SENINF_CSI2_LNRC_FSM, 0x10);
+
+	/* CSI2 control */
+	val = mtk_seninf_input_read(input, SENINF_CSI2_CTL)
+	    | (data_header_order << 16) | 0x10 | ((1 << data_lane_num) - 1);
+	mtk_seninf_input_write(input, SENINF_CSI2_CTL, val);
+
+	mtk_seninf_input_update(input, SENINF_CSI2_RESYNC_MERGE_CTL,
+				BYPASS_LANE_RESYNC, 0);
+	mtk_seninf_input_update(input, SENINF_CSI2_RESYNC_MERGE_CTL, CDPHY_SEL, 0);
+	mtk_seninf_input_update(input, SENINF_CSI2_RESYNC_MERGE_CTL,
+				CPHY_LANE_RESYNC_CNT, 3);
+	mtk_seninf_input_update(input, SENINF_CSI2_MODE, CSR_CSI2_MODE, 0);
+	mtk_seninf_input_update(input, SENINF_CSI2_MODE, CSR_CSI2_HEADER_LEN, 0);
+	mtk_seninf_input_update(input, SENINF_CSI2_DPHY_SYNC, SYNC_SEQ_MASK_0, 0xff00);
+	mtk_seninf_input_update(input, SENINF_CSI2_DPHY_SYNC, SYNC_SEQ_PAT_0, 0x001d);
+
+	mtk_seninf_input_update(input, SENINF_CSI2_CTL, CLOCK_HS_OPTION, 0);
+	mtk_seninf_input_update(input, SENINF_CSI2_CTL, HSRX_DET_EN, 0);
+	mtk_seninf_input_update(input, SENINF_CSI2_CTL, HS_TRAIL_EN, 1);
+	mtk_seninf_input_update(input, SENINF_CSI2_HS_TRAIL, HS_TRAIL_PARAMETER,
+				SENINF_HS_TRAIL_PARAMETER);
+
+	/* Set debug port to output packet number */
+	mtk_seninf_input_update(input, SENINF_CSI2_DGB_SEL, DEBUG_EN, 1);
+	mtk_seninf_input_update(input, SENINF_CSI2_DGB_SEL, DEBUG_SEL, 0x1a);
+
+	/* HQ */
+	mtk_seninf_input_write(input, SENINF_CSI2_SPARE0, 0xfffffffe);
+
+	/* Enable CSI2 IRQ mask */
+	/* Turn on all interrupt */
+	mtk_seninf_input_write(input, SENINF_CSI2_INT_EN, 0xffffffff);
+	/* Write clear CSI2 IRQ */
+	mtk_seninf_input_write(input, SENINF_CSI2_INT_STATUS, 0xffffffff);
+	/* Enable CSI2 Extend IRQ mask */
+	/* Turn on all interrupt */
+	mtk_seninf_input_update(input, SENINF_CTRL, CSI2_SW_RST, 1);
+	udelay(1);
+	mtk_seninf_input_update(input, SENINF_CTRL, CSI2_SW_RST, 0);
+}
+
+static void mtk_seninf_mux_setup(struct mtk_seninf_mux *mux,
+				 struct mtk_seninf_input *input,
+				 struct v4l2_subdev_state *state)
+{
+	const struct mtk_seninf_format_info *fmtinfo;
+	const struct v4l2_mbus_framefmt *format;
+	unsigned int pix_sel_ext;
+	unsigned int pix_sel;
+	unsigned int hs_pol = 0;
+	unsigned int vs_pol = 0;
+	unsigned int pixel_mode = TWO_PIXEL_MODE;
+	unsigned int val;
+
+	format = v4l2_subdev_state_get_stream_format(state, input->pad, 0);
+	fmtinfo = mtk_seninf_format_info(format->code);
+
+	/* Enable mux */
+	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_MUX_EN, 1);
+	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_SRC_SEL,
+			      SENINF_MIPI_SENSOR);
+	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL_EXT,
+			      SENINF_SRC_SEL_EXT, SENINF_NORMAL_MODEL);
+
+	switch (pixel_mode) {
+	case 1: /* 2 Pixel */
+		pix_sel_ext = 0;
+		pix_sel = 1;
+		break;
+	case 2: /* 4 Pixel */
+		pix_sel_ext = 1;
+		pix_sel = 0;
+		break;
+	default: /* 1 Pixel */
+		pix_sel_ext = 0;
+		pix_sel = 0;
+		break;
+	}
+
+	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL_EXT,
+			      SENINF_PIX_SEL_EXT, pix_sel_ext);
+	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_PIX_SEL, pix_sel);
+
+	if (!(fmtinfo->flags & MTK_SENINF_FORMAT_JPEG)) {
+		mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FULL_WR_EN, 2);
+		mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FLUSH_EN, 0x1b);
+		mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_PUSH_EN, 0x1f);
+	} else {
+		mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FULL_WR_EN, 0);
+		mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FLUSH_EN, 0x18);
+		mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_PUSH_EN, 0x1e);
+	}
+
+	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_HSYNC_POL, hs_pol);
+	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_VSYNC_POL, vs_pol);
+
+	val = mtk_seninf_mux_read(mux, SENINF_MUX_CTRL);
+	mtk_seninf_mux_write(mux, SENINF_MUX_CTRL, val |
+			     SENINF_MUX_CTRL_SENINF_IRQ_SW_RST |
+			     SENINF_MUX_CTRL_SENINF_MUX_SW_RST);
+	mtk_seninf_mux_write(mux, SENINF_MUX_CTRL, val &
+			     ~(SENINF_MUX_CTRL_SENINF_IRQ_SW_RST |
+			       SENINF_MUX_CTRL_SENINF_MUX_SW_RST));
+
+	/* HQ */
+	mtk_seninf_mux_write(mux, SENINF_MUX_SPARE, 0xc2000);
+}
+
+static void mtk_seninf_top_mux_setup(struct mtk_seninf *priv,
+				     enum mtk_seninf_id seninf_id,
+				     struct mtk_seninf_mux *mux)
+{
+	unsigned int val;
+
+	/*
+	 * Use the top mux (from SENINF input to MUX) to configure routing, and
+	 * hardcode a 1:1 mapping from the MUX instances to the SENINF outputs.
+	 */
+	val = mtk_seninf_read(priv, SENINF_TOP_MUX_CTRL)
+		& ~(0xf << (mux->mux_id * 4));
+	val |= (seninf_id & 0xf) << (mux->mux_id * 4);
+	mtk_seninf_write(priv, SENINF_TOP_MUX_CTRL, val);
+
+	mtk_seninf_write(priv, SENINF_TOP_CAM_MUX_CTRL, 0x76541010);
+}
+
+static void seninf_enable_test_pattern(struct mtk_seninf *priv,
+				       struct v4l2_subdev_state *state)
+{
+	struct mtk_seninf_input *input = &priv->inputs[CSI_PORT_0];
+	struct mtk_seninf_mux *mux = &priv->muxes[0];
+	const struct mtk_seninf_format_info *fmtinfo;
+	const struct v4l2_mbus_framefmt *format;
+	unsigned int val;
+	unsigned int pixel_mode = TWO_PIXEL_MODE;
+	unsigned int pix_sel_ext;
+	unsigned int pix_sel;
+	unsigned int hs_pol = 0;
+	unsigned int vs_pol = 0;
+	unsigned int seninf = 0;
+	unsigned int mux_id = mux->mux_id;
+
+	format = v4l2_subdev_state_get_stream_format(state, priv->conf->nb_inputs, 0);
+	fmtinfo = mtk_seninf_format_info(format->code);
+
+	mtk_seninf_update(priv, SENINF_TOP_CTRL, MUX_LP_MODE, 0);
+
+	mtk_seninf_update(priv, SENINF_TOP_CTRL, SENINF_PCLK_EN, 1);
+	mtk_seninf_update(priv, SENINF_TOP_CTRL, SENINF2_PCLK_EN, 1);
+
+	mtk_seninf_input_update(input, SENINF_CTRL, SENINF_EN, 1);
+	mtk_seninf_input_update(input, SENINF_CTRL, SENINF_SRC_SEL, 1);
+	mtk_seninf_input_update(input, SENINF_CTRL_EXT,
+				SENINF_TESTMDL_IP_EN, 1);
+
+	mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_EN, 1);
+	mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_PAT, 0xc);
+	mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_VSYNC, 4);
+	mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_DUMMYPXL, 0x28);
+
+	if (fmtinfo->flags & MTK_SENINF_FORMAT_BAYER)
+		mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_FMT, 0x0);
+	else
+		mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_FMT, 0x1);
+
+	switch (format->code) {
+	case MEDIA_BUS_FMT_UYVY8_1X16:
+	case MEDIA_BUS_FMT_VYUY8_1X16:
+	case MEDIA_BUS_FMT_YUYV8_1X16:
+	case MEDIA_BUS_FMT_YVYU8_1X16:
+		mtk_seninf_input_write(input, SENINF_TG1_TM_SIZE,
+				       (format->height + 8) << 16 |
+				       format->width * 2);
+		break;
+	default:
+		mtk_seninf_input_write(input, SENINF_TG1_TM_SIZE,
+				       (format->height + 8) << 16 |
+				       format->width);
+		break;
+	}
+
+	mtk_seninf_input_write(input, SENINF_TG1_TM_CLK, 0x8);
+	mtk_seninf_input_write(input, SENINF_TG1_TM_STP, 0x1);
+
+	/* Set top mux */
+	val = (mtk_seninf_read(priv, SENINF_TOP_MUX_CTRL) & (~(0xf << (mux_id * 4)))) |
+		((seninf & 0xf) << (mux_id * 4));
+	mtk_seninf_write(priv, SENINF_TOP_MUX_CTRL, val);
+
+	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_MUX_EN, 1);
+	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL_EXT,
+			      SENINF_SRC_SEL_EXT, SENINF_TEST_MODEL);
+	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_SRC_SEL, 1);
+
+	switch (pixel_mode) {
+	case 1:
+		pix_sel_ext = 0;
+		pix_sel = 1;
+		break;
+	case 2:
+		pix_sel_ext = 1;
+		pix_sel = 0;
+		break;
+	default:
+		pix_sel_ext = 0;
+		pix_sel = 0;
+		break;
+	}
+
+	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL_EXT,
+			      SENINF_PIX_SEL_EXT, pix_sel_ext);
+
+	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_PIX_SEL, pix_sel);
+
+	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_PUSH_EN, 0x1f);
+	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FLUSH_EN, 0x1b);
+	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FULL_WR_EN, 2);
+
+	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_HSYNC_POL, hs_pol);
+	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_VSYNC_POL, vs_pol);
+	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_HSYNC_MASK, 1);
+
+	mtk_seninf_mux_write(mux, SENINF_MUX_INTEN,
+			     SENINF_IRQ_CLR_SEL | SENINF_ALL_ERR_IRQ_EN);
+
+	mtk_seninf_mux_write(mux, SENINF_MUX_CTRL,
+			     mtk_seninf_mux_read(mux, SENINF_MUX_CTRL) |
+			     SENINF_MUX_CTRL_SENINF_IRQ_SW_RST |
+			     SENINF_MUX_CTRL_SENINF_MUX_SW_RST);
+	udelay(1);
+	mtk_seninf_mux_write(mux, SENINF_MUX_CTRL,
+			     mtk_seninf_mux_read(mux, SENINF_MUX_CTRL) &
+			     ~(SENINF_MUX_CTRL_SENINF_IRQ_SW_RST |
+			       SENINF_MUX_CTRL_SENINF_MUX_SW_RST));
+
+	//check this
+	mtk_seninf_write(priv, SENINF_TOP_CAM_MUX_CTRL, 0x76540010);
+
+	dev_dbg(priv->dev, "%s: OK\n", __func__);
+}
+
+static void mtk_seninf_start(struct mtk_seninf *priv,
+			     struct v4l2_subdev_state *state,
+			     struct mtk_seninf_input *input,
+			     struct mtk_seninf_mux *mux)
+{
+	phy_power_on(input->phy);
+
+	mtk_seninf_input_setup_csi2_rx(input);
+	mtk_seninf_input_setup_csi2(input, state);
+
+	mtk_seninf_mux_setup(mux, input, state);
+	mtk_seninf_top_mux_setup(priv, input->seninf_id, mux);
+}
+
+static void mtk_seninf_stop(struct mtk_seninf *priv,
+			    struct mtk_seninf_input *input)
+{
+	unsigned int val;
+
+	/* Disable CSI2(2.5G) first */
+	val = mtk_seninf_input_read(input, SENINF_CSI2_CTL);
+	val &= ~(SENINF_CSI2_CTL_CLOCK_LANE_EN |
+		 SENINF_CSI2_CTL_DATA_LANE3_EN |
+		 SENINF_CSI2_CTL_DATA_LANE2_EN |
+		 SENINF_CSI2_CTL_DATA_LANE1_EN |
+		 SENINF_CSI2_CTL_DATA_LANE0_EN);
+	mtk_seninf_input_write(input, SENINF_CSI2_CTL, val);
+
+	if (!priv->is_testmode)
+		phy_power_off(input->phy);
+}
+
+/* -----------------------------------------------------------------------------
+ * V4L2 Controls
+ */
+
+static int seninf_set_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct mtk_seninf *priv = container_of(ctrl->handler,
+					       struct mtk_seninf, ctrl_handler);
+
+	switch (ctrl->id) {
+	case V4L2_CID_TEST_PATTERN:
+		priv->is_testmode = !!ctrl->val;
+		break;
+	}
+
+	return 0;
+}
+
+static const struct v4l2_ctrl_ops seninf_ctrl_ops = {
+	.s_ctrl = seninf_set_ctrl,
+};
+
+static const char *const seninf_test_pattern_menu[] = {
+	"No test pattern",
+	"Static horizontal color bars",
+};
+
+static int seninf_initialize_controls(struct mtk_seninf *priv)
+{
+	struct v4l2_ctrl_handler *handler;
+	int ret;
+
+	handler = &priv->ctrl_handler;
+	ret = v4l2_ctrl_handler_init(handler, 2);
+	if (ret)
+		return ret;
+
+	v4l2_ctrl_new_std_menu_items(handler, &seninf_ctrl_ops,
+				     V4L2_CID_TEST_PATTERN,
+				     ARRAY_SIZE(seninf_test_pattern_menu) - 1,
+				     0, 0, seninf_test_pattern_menu);
+
+	priv->is_testmode = false;
+
+	if (handler->error) {
+		ret = handler->error;
+		dev_err(priv->dev,
+			"Failed to init controls(%d)\n", ret);
+		v4l2_ctrl_handler_free(handler);
+		return ret;
+	}
+
+	priv->subdev.ctrl_handler = handler;
+
+	return 0;
+}
+
+/* -----------------------------------------------------------------------------
+ * V4L2 Subdev Operations
+ */
+static int seninf_s_stream(struct v4l2_subdev *sd, unsigned int source_pad,
+			   int on)
+{
+	struct mtk_seninf *priv = sd_to_mtk_seninf(sd);
+	struct v4l2_subdev_state *state;
+	struct mtk_seninf_input *input;
+	struct mtk_seninf_mux *mux;
+	struct v4l2_subdev *source;
+	u32 sink_pad;
+	int ret;
+
+	/* Stream control can only operate on source pads. */
+	if (source_pad < priv->conf->nb_inputs ||
+	    source_pad >= priv->conf->nb_inputs + priv->conf->nb_outputs)
+		return -EINVAL;
+
+	/*
+	 * Locate the SENINF input and MUX for the source pad.
+	 *
+	 * Hardcode a 1:1 mapping of MUX instances to SENINF
+	 * outputs to match the TOP_CAM_MUX configuration in
+	 * mtk_seninf_top_mux_setup().
+	 */
+	state = v4l2_subdev_lock_and_get_active_state(&priv->subdev);
+	if (!state)
+		return -EPIPE;
+
+	ret = v4l2_subdev_routing_find_opposite_end(&state->routing, source_pad, 0, &sink_pad,
+						    NULL);
+	if (ret) {
+		dev_dbg(priv->dev, "No sink pad routed to source pad %u\n",
+			source_pad);
+		goto unlock;
+	}
+
+	input = &priv->inputs[sink_pad];
+	mux = &priv->muxes[source_pad - priv->conf->nb_inputs];
+
+	if (!on) {
+		if (!priv->is_testmode) {
+			source = input->source_sd;
+			ret = v4l2_subdev_call(source, video, s_stream, 0);
+			if (ret)
+				dev_err(priv->dev,
+					"failed to stop source %s: %d\n",
+					source->entity.name, ret);
+		}
+
+		mtk_seninf_stop(priv, input);
+		pm_runtime_put(priv->dev);
+		goto unlock;
+	}
+
+	ret = pm_runtime_get_sync(priv->dev);
+	if (ret < 0) {
+		dev_err(priv->dev, "Failed to pm_runtime_get_sync: %d\n", ret);
+		pm_runtime_put_noidle(priv->dev);
+		goto unlock;
+	}
+
+	/* If test mode is enabled, just enable the test pattern generator. */
+	if (priv->is_testmode) {
+		seninf_enable_test_pattern(priv, state);
+		ret = 0;
+		goto unlock;
+	}
+
+	/* Start the SENINF first and then the source. */
+	mtk_seninf_start(priv, state, input, mux);
+
+	source = input->source_sd;
+	ret = v4l2_subdev_call(source, video, s_stream, 1);
+	if (ret) {
+		dev_err(priv->dev, "failed to start source %s: %d\n",
+			source->entity.name, ret);
+		mtk_seninf_stop(priv, input);
+		pm_runtime_put(priv->dev);
+	}
+
+unlock:
+	v4l2_subdev_unlock_state(state);
+	return ret;
+};
+
+static int seninf_enable_streams(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_state *state, u32 pad,
+				 u64 streams_mask)
+{
+	return seninf_s_stream(sd, pad, 1);
+}
+
+static int seninf_disable_streams(struct v4l2_subdev *sd,
+				  struct v4l2_subdev_state *state, u32 pad,
+				  u64 streams_mask)
+{
+	return seninf_s_stream(sd, pad, 0);
+}
+
+static const struct v4l2_mbus_framefmt mtk_seninf_default_fmt = {
+	.code = SENINF_DEFAULT_BUS_FMT,
+	.width = SENINF_DEFAULT_WIDTH,
+	.height = SENINF_DEFAULT_HEIGHT,
+	.field = V4L2_FIELD_NONE,
+	.colorspace = V4L2_COLORSPACE_SRGB,
+	.xfer_func = V4L2_XFER_FUNC_DEFAULT,
+	.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT,
+	.quantization = V4L2_QUANTIZATION_DEFAULT,
+};
+
+static int __seninf_set_routing(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *state,
+				struct v4l2_subdev_krouting *routing)
+{
+	int ret;
+
+	ret = v4l2_subdev_routing_validate(sd, routing, V4L2_SUBDEV_ROUTING_ONLY_1_TO_1);
+	if (ret)
+		return ret;
+
+	ret = v4l2_subdev_set_routing_with_fmt(sd, state, routing,
+					       &mtk_seninf_default_fmt);
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int seninf_init_cfg(struct v4l2_subdev *sd,
+			   struct v4l2_subdev_state *state)
+{
+	struct mtk_seninf *priv = sd_to_mtk_seninf(sd);
+	struct v4l2_subdev_route routes[SENINF_MAX_NUM_OUTPUTS] = { };
+	struct v4l2_subdev_krouting routing = {
+		.routes = routes,
+	};
+	unsigned int i;
+
+	/*
+	 * Initialize one route for supported source pads.
+	 * It is a single route from the first sink pad to the source pad,
+	 * while on SENINF 5.0 the routing table will map sink pads to source
+	 * pads connected to CAMSV 1:1 (skipping the first two source pads
+	 * connected to the CAM instances).
+	 */
+	routing.num_routes = priv->conf->nb_outputs;
+
+	for (i = 0; i < routing.num_routes; i++) {
+		struct v4l2_subdev_route *route = &routes[i];
+
+		route->sink_pad = i;
+		route->sink_stream = 0;
+		route->source_pad = priv->conf->nb_inputs + i;
+		route->source_stream = 0;
+		route->flags = V4L2_SUBDEV_ROUTE_FL_ACTIVE;
+	}
+
+	return __seninf_set_routing(sd, state, &routing);
+}
+
+static int seninf_enum_mbus_code(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_state *state,
+				 struct v4l2_subdev_mbus_code_enum *code)
+{
+	const struct mtk_seninf_format_info *fmtinfo;
+	struct mtk_seninf *priv = sd_to_mtk_seninf(sd);
+
+	if (code->index >= ARRAY_SIZE(mtk_seninf_formats))
+		return -EINVAL;
+
+	fmtinfo = &mtk_seninf_formats[code->index];
+	if (fmtinfo->flags & MTK_SENINF_FORMAT_INPUT_ONLY &&
+	    mtk_seninf_pad_is_source(priv, code->pad))
+		return -EINVAL;
+
+	code->code = fmtinfo->code;
+
+	return 0;
+}
+
+static int seninf_set_fmt(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_state *state,
+			  struct v4l2_subdev_format *fmt)
+{
+	struct mtk_seninf *priv = sd_to_mtk_seninf(sd);
+	const struct mtk_seninf_format_info *fmtinfo;
+	struct v4l2_mbus_framefmt *format;
+
+	/*
+	 * TODO (?): We should disallow setting formats on the source pad
+	 * completely, as the SENINF can't perform any processing. This would
+	 * however break usage of the test pattern generator, as there would be
+	 * no way to configure formats at all when no active input is selected.
+	 */
+
+	/*
+	 * Default to the first format if the requested media bus code isn't
+	 * supported.
+	 */
+	fmtinfo = mtk_seninf_format_info(fmt->format.code);
+	if (!fmtinfo) {
+		fmtinfo = &mtk_seninf_formats[0];
+		fmt->format.code = fmtinfo->code;
+	}
+
+	/* Interlaced formats are not supported yet. */
+	fmt->format.field = V4L2_FIELD_NONE;
+
+	/* Store the format. */
+
+	format = v4l2_subdev_state_get_stream_format(state, fmt->pad, fmt->stream);
+	if (!format)
+		return -EINVAL;
+
+	*format = fmt->format;
+
+	if (mtk_seninf_pad_is_source(priv, fmt->pad))
+		return 0;
+
+	/* Propagate the format to the corresponding source pad. */
+	format = v4l2_subdev_state_get_opposite_stream_format(state, fmt->pad,
+							      fmt->stream);
+	if (!format)
+		return -EINVAL;
+
+	*format = fmt->format;
+
+	return 0;
+}
+
+static int seninf_set_routing(struct v4l2_subdev *sd,
+			      struct v4l2_subdev_state *state,
+			      enum v4l2_subdev_format_whence which,
+			      struct v4l2_subdev_krouting *routing)
+{
+	return __seninf_set_routing(sd, state, routing);
+}
+
+static const struct v4l2_subdev_core_ops seninf_subdev_core_ops = {
+	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
+	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
+};
+
+static const struct v4l2_subdev_pad_ops seninf_subdev_pad_ops = {
+	.init_cfg = seninf_init_cfg,
+	.enum_mbus_code = seninf_enum_mbus_code,
+	.get_fmt = v4l2_subdev_get_fmt,
+	.set_fmt = seninf_set_fmt,
+	.link_validate = v4l2_subdev_link_validate_default,
+	.set_routing = seninf_set_routing,
+	.enable_streams = seninf_enable_streams,
+	.disable_streams = seninf_disable_streams,
+};
+
+static const struct v4l2_subdev_ops seninf_subdev_ops = {
+	.core = &seninf_subdev_core_ops,
+	.pad = &seninf_subdev_pad_ops,
+};
+
+/* -----------------------------------------------------------------------------
+ * Media Entity Operations
+ */
+
+static const struct media_entity_operations seninf_media_ops = {
+	.get_fwnode_pad = v4l2_subdev_get_fwnode_pad_1_to_1,
+	.link_validate = v4l2_subdev_link_validate,
+};
+
+/* -----------------------------------------------------------------------------
+ * Async Subdev Notifier
+ */
+
+struct mtk_seninf_async_subdev {
+	struct v4l2_async_subdev asd;
+	struct mtk_seninf_input *input;
+	unsigned int port;
+};
+
+static int mtk_seninf_fwnode_parse(struct device *dev,
+				   unsigned int id)
+
+{
+	struct mtk_seninf *priv = dev_get_drvdata(dev);
+	struct mtk_seninf_async_subdev *s_asd;
+	unsigned int port;
+	struct mtk_seninf_input *input;
+	struct fwnode_handle *ep, *fwnode;
+	struct v4l2_fwnode_endpoint vep = {
+		.bus_type = V4L2_MBUS_CSI2_DPHY,
+	};
+	struct v4l2_async_subdev *asd;
+	int ret;
+
+	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), id, 0, 0);
+	if (!ep)
+		return 0;
+
+	fwnode = fwnode_graph_get_remote_endpoint(ep);
+	ret = v4l2_fwnode_endpoint_parse(ep, &vep);
+	if (ret) {
+		dev_err(dev, "Failed to parse %pOF\n", to_of_node(fwnode));
+		ret = -EINVAL;
+		goto out;
+	}
+
+	asd = v4l2_async_nf_add_fwnode(&priv->notifier,
+				       fwnode, struct v4l2_async_subdev);
+	if (IS_ERR(asd)) {
+		ret = PTR_ERR(asd);
+		goto out;
+	}
+	s_asd = container_of(asd, struct mtk_seninf_async_subdev, asd);
+
+	port = vep.base.port;
+	s_asd->port = port;
+
+	if (mtk_seninf_pad_is_source(priv, port))
+		return 0;
+
+	if (vep.bus_type != V4L2_MBUS_CSI2_DPHY) {
+		dev_err(dev, "Only CSI2 bus type is currently supported\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	input = &priv->inputs[port];
+
+	input->pad = port;
+	input->seninf_id = port_to_seninf_id[port];
+	input->base = priv->base + 0x1000 * input->seninf_id;
+	input->seninf = priv;
+
+	input->bus = vep.bus.mipi_csi2;
+
+	input->phy = devm_of_phy_get_by_index(dev, to_of_node(ep)->parent, 0);
+	if (IS_ERR(input->phy)) {
+		dev_err(dev, "failed to get phy:%ld\n", PTR_ERR(input->phy));
+		ret = PTR_ERR(input->phy);
+		goto out;
+	}
+	input->phy_mode = SENINF_PHY_MODE_4D1C;
+
+	s_asd->input = input;
+
+	ret = 0;
+out:
+	fwnode_handle_put(ep);
+	fwnode_handle_put(fwnode);
+	return ret;
+}
+
+static int mtk_seninf_notifier_bound(struct v4l2_async_notifier *notifier,
+				     struct v4l2_subdev *sd,
+				     struct v4l2_async_subdev *asd)
+{
+	struct mtk_seninf *priv = container_of(notifier, struct mtk_seninf, notifier);
+	struct mtk_seninf_async_subdev *s_asd =
+		container_of(asd, struct mtk_seninf_async_subdev, asd);
+	struct device_link *link;
+	int ret;
+
+	dev_dbg(priv->dev, "%s bound to SENINF port %u\n", sd->entity.name,
+		s_asd->port);
+
+	if (mtk_seninf_pad_is_sink(priv, s_asd->port)) {
+		struct mtk_seninf_input *input = s_asd->input;
+
+		input->source_sd = sd;
+
+		link = device_link_add(priv->dev, sd->dev,
+				       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
+		if (!link) {
+			dev_err(priv->dev,
+				"Failed to create device link from source %s\n", sd->name);
+			return -EINVAL;
+		}
+
+		ret = v4l2_create_fwnode_links_to_pad(sd, &priv->pads[input->pad],
+						      MEDIA_LNK_FL_IMMUTABLE |
+						      MEDIA_LNK_FL_ENABLED);
+	} else {
+		link = device_link_add(sd->dev, priv->dev,
+				       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
+		if (!link) {
+			dev_err(priv->dev,
+				"Failed to create device link to output %s\n", sd->name);
+			return -EINVAL;
+		}
+
+		ret = v4l2_create_fwnode_links_to_pad(&priv->subdev,
+						      &sd->entity.pads[0],
+						      MEDIA_LNK_FL_IMMUTABLE |
+						      MEDIA_LNK_FL_ENABLED);
+	}
+	if (ret)
+		dev_err(priv->dev, "Failed to create links between SENINF port %u and %s (%d)\n",
+			s_asd->port, sd->entity.name, ret);
+
+	return ret;
+}
+
+static int mtk_seninf_notifier_complete(struct v4l2_async_notifier *notifier)
+{
+	struct mtk_seninf *priv = container_of(notifier, struct mtk_seninf, notifier);
+	int ret;
+
+	ret = v4l2_device_register_subdev_nodes(&priv->v4l2_dev);
+	if (ret)
+		dev_err(priv->dev, "Failed to register subdev nodes: %d\n", ret);
+
+	return ret;
+}
+
+static const struct v4l2_async_notifier_operations mtk_seninf_async_ops = {
+	.bound = mtk_seninf_notifier_bound,
+	.complete = mtk_seninf_notifier_complete,
+};
+
+/* -----------------------------------------------------------------------------
+ * Probe & Remove
+ */
+
+static int mtk_seninf_media_init(struct mtk_seninf *priv)
+{
+	struct media_pad *pads = priv->pads;
+	const struct mtk_seninf_conf *conf = priv->conf;
+	struct device *dev = priv->dev;
+	struct media_device *media_dev = &priv->media_dev;
+	u8 num_pads = conf->nb_outputs + conf->nb_inputs;
+	unsigned int i;
+	int ret;
+
+	media_dev->dev = dev;
+	strscpy(media_dev->model, conf->model, sizeof(media_dev->model));
+	snprintf(media_dev->bus_info, sizeof(media_dev->bus_info),
+		 "platform:%s", dev_name(dev));
+	media_dev->hw_revision = 0;
+	media_device_init(media_dev);
+
+	ret = media_entity_pads_init(&priv->subdev.entity, num_pads, pads);
+	if (ret)
+		goto err_clean_media;
+
+	for (i = 0; i < conf->nb_inputs; i++)
+		pads[i].flags = MEDIA_PAD_FL_SINK;
+	for (i = conf->nb_inputs; i < num_pads; i++)
+		pads[i].flags = MEDIA_PAD_FL_SOURCE;
+
+	return 0;
+err_clean_media:
+	media_device_cleanup(media_dev);
+
+	return ret;
+}
+
+static int mtk_seninf_v4l2_async_register(struct mtk_seninf *priv)
+{
+	struct device *dev = priv->dev;
+	const struct mtk_seninf_conf *conf = priv->conf;
+	int ret;
+	unsigned int i;
+
+	v4l2_async_nf_init(&priv->notifier);
+
+	for (i = 0; i < conf->nb_inputs + conf->nb_outputs; ++i) {
+		ret = mtk_seninf_fwnode_parse(dev, i);
+
+		if (ret) {
+			dev_err(dev, "Failed to parse endpoint at port %d, err: %d\n", i, ret);
+			goto err_clean_notififer;
+		}
+	}
+
+	priv->notifier.ops = &mtk_seninf_async_ops;
+	ret = v4l2_async_nf_register(&priv->v4l2_dev, &priv->notifier);
+	if (ret)
+		dev_err(dev, "Failed to register async notifier: %d\n", ret);
+	return 0;
+
+err_clean_notififer:
+	v4l2_async_nf_cleanup(&priv->notifier);
+
+	return ret;
+}
+
+static int mtk_seninf_v4l2_register(struct mtk_seninf *priv)
+{
+	struct v4l2_subdev *sd = &priv->subdev;
+	struct device *dev = priv->dev;
+	int ret;
+
+	/* Initialize media device & pads. */
+	ret = mtk_seninf_media_init(priv);
+	if (ret)
+		return ret;
+
+	/* Initialize & register v4l2 device. */
+	priv->v4l2_dev.mdev = &priv->media_dev;
+
+	ret = v4l2_device_register(dev, &priv->v4l2_dev);
+	if (ret) {
+		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
+		goto err_clean_media;
+	}
+
+	/* Initialize & register subdev. */
+	v4l2_subdev_init(sd, &seninf_subdev_ops);
+	sd->dev = dev;
+	sd->entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
+	sd->entity.ops = &seninf_media_ops;
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS
+		  |  V4L2_SUBDEV_FL_STREAMS;
+	strscpy(sd->name, dev_name(dev), V4L2_SUBDEV_NAME_SIZE);
+	ret = seninf_initialize_controls(priv);
+	if (ret) {
+		dev_err(dev, "Failed to initialize controls: %d\n", ret);
+		goto err_unreg_v4l2;
+	}
+	v4l2_set_subdevdata(sd, priv);
+
+	ret = v4l2_subdev_init_finalize(sd);
+	if (ret)
+		goto err_free_handler;
+
+	ret = v4l2_device_register_subdev(&priv->v4l2_dev, sd);
+	if (ret) {
+		dev_err(dev, "Failed to register subdev: %d\n", ret);
+		goto err_cleanup_subdev;
+	}
+
+	/* Set up async device */
+	ret = mtk_seninf_v4l2_async_register(priv);
+	if (ret) {
+		dev_err(dev, "Failed to register v4l2 async notifier: %d\n", ret);
+		goto err_unreg_subdev;
+	}
+
+	/* Register media device */
+	ret = media_device_register(&priv->media_dev);
+	if (ret) {
+		dev_err(dev, "failed to register media device: %d\n", ret);
+		goto err_unreg_notifier;
+	}
+
+	return 0;
+
+err_unreg_notifier:
+	v4l2_async_nf_unregister(&priv->notifier);
+err_unreg_subdev:
+	v4l2_device_unregister_subdev(sd);
+err_cleanup_subdev:
+	v4l2_subdev_cleanup(sd);
+err_free_handler:
+	v4l2_ctrl_handler_free(&priv->ctrl_handler);
+err_unreg_v4l2:
+	v4l2_device_unregister(&priv->v4l2_dev);
+err_clean_media:
+	media_entity_cleanup(&sd->entity);
+	media_device_cleanup(&priv->media_dev);
+
+	return ret;
+}
+
+static int seninf_probe(struct platform_device *pdev)
+{
+	/* List of clocks required by seninf. */
+	static const char * const clk_names[] = {
+		"cam_seninf", "top_mux_seninf"
+	};
+
+	struct mtk_seninf *priv;
+	struct device *dev = &pdev->dev;
+	unsigned int i;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(struct mtk_seninf), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->conf = of_device_get_match_data(dev);
+
+	dev_set_drvdata(dev, priv);
+	priv->dev = dev;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->num_clks = ARRAY_SIZE(clk_names);
+	priv->clks = devm_kcalloc(dev, priv->num_clks,
+				  sizeof(*priv->clks), GFP_KERNEL);
+	if (!priv->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < priv->num_clks; ++i)
+		priv->clks[i].id = clk_names[i];
+
+	ret = devm_clk_bulk_get(dev, priv->num_clks, priv->clks);
+	if (ret) {
+		dev_err(dev, "failed to get seninf clock:%d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < priv->conf->nb_muxes; ++i) {
+		struct mtk_seninf_mux *mux = &priv->muxes[i];
+
+		mux->pad = priv->conf->nb_inputs + i;
+		mux->mux_id = i;
+		mux->base = priv->base + 0x1000 * i;
+		mux->seninf = priv;
+	}
+
+	ret = mtk_seninf_v4l2_register(priv);
+	if (!ret)
+		pm_runtime_enable(dev);
+
+	return ret;
+}
+
+static int seninf_pm_suspend(struct device *dev)
+{
+	struct mtk_seninf *priv = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "seninf runtime suspend\n");
+	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
+
+	return 0;
+}
+
+static int seninf_pm_resume(struct device *dev)
+{
+	struct mtk_seninf *priv = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(dev, "seninf runtime resume\n");
+	ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clock:%d\n", ret);
+		return ret;
+	}
+
+	mtk_seninf_csi2_setup_phy(priv);
+
+	return 0;
+}
+
+static const struct dev_pm_ops runtime_pm_ops = {
+	SET_RUNTIME_PM_OPS(seninf_pm_suspend, seninf_pm_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
+static int seninf_remove(struct platform_device *pdev)
+{
+	struct mtk_seninf *priv = dev_get_drvdata(&pdev->dev);
+
+	media_device_unregister(&priv->media_dev);
+	media_device_cleanup(&priv->media_dev);
+	v4l2_async_nf_unregister(&priv->notifier);
+	v4l2_async_nf_cleanup(&priv->notifier);
+	v4l2_device_unregister_subdev(&priv->subdev);
+	v4l2_subdev_cleanup(&priv->subdev);
+	v4l2_ctrl_handler_free(&priv->ctrl_handler);
+	media_entity_cleanup(&priv->subdev.entity);
+	v4l2_device_unregister(&priv->v4l2_dev);
+
+	pm_runtime_disable(priv->dev);
+
+	return 0;
+}
+
+static const struct mtk_seninf_conf seninf_8365_conf = {
+	.model = "mtk-camsys-3.0",
+	.nb_inputs = 4,
+	.nb_muxes = 6,
+	.nb_outputs = 4,
+};
+
+static const struct of_device_id mtk_seninf_of_match[] = {
+	{
+		.compatible = "mediatek,mt8365-seninf",
+		.data = &seninf_8365_conf,
+	},
+	{
+	},
+};
+MODULE_DEVICE_TABLE(of, mtk_seninf_of_match);
+
+static struct platform_driver seninf_pdrv = {
+	.driver	= {
+		.name	= "mtk-seninf",
+		.pm  = &runtime_pm_ops,
+		.of_match_table = mtk_seninf_of_match,
+	},
+	.probe	= seninf_probe,
+	.remove	= seninf_remove,
+};
+
+module_platform_driver(seninf_pdrv);
+
+MODULE_DESCRIPTION("MTK sensor interface driver");
+MODULE_AUTHOR("Louis Kuo <louis.kuo@mediatek.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf_reg.h b/drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf_reg.h
new file mode 100644
index 000000000000..b6af8567fa20
--- /dev/null
+++ b/drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf_reg.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#ifndef __SENINF_REG_H__
+#define __SENINF_REG_H__
+
+#include <linux/bits.h>
+
+#define SENINF_TOP_CTRL							0x0000
+#define SENINF_TOP_CTRL_MUX_LP_MODE					BIT(31)
+#define SENINF_TOP_CTRL_SENINF_PCLK_EN					BIT(10)
+#define SENINF_TOP_CTRL_SENINF2_PCLK_EN					BIT(11)
+#define SENINF_TOP_MUX_CTRL						0x0008
+#define SENINF_TOP_CAM_MUX_CTRL						0x0010
+#define SENINF_TOP_PHY_SENINF_CTL_CSI0					0x001c
+#define SENINF_TOP_PHY_SENINF_CTL_CSI0_DPHY_MODE			BIT(0)
+#define SENINF_TOP_PHY_SENINF_CTL_CSI0_CK_SEL_1				GENMASK(10, 8)
+#define SENINF_TOP_PHY_SENINF_CTL_CSI0_CK_SEL_2				GENMASK(13, 12)
+#define SENINF_TOP_PHY_SENINF_CTL_CSI0_PHY_SENINF_LANE_MUX_CSI0_EN	BIT(31)
+#define SENINF_TOP_PHY_SENINF_CTL_CSI1					0x0020
+#define SENINF_TOP_PHY_SENINF_CTL_CSI1_DPHY_MODE			BIT(0)
+#define SENINF_TOP_PHY_SENINF_CTL_CSI1_CK_SEL_1				GENMASK(10, 8)
+#define SENINF_TOP_PHY_SENINF_CTL_CSI1_PHY_SENINF_LANE_MUX_CSI1_EN	BIT(31)
+#define SENINF_CTRL							0x0200
+#define SENINF_CTRL_SENINF_EN						BIT(0)
+#define SENINF_CTRL_CSI2_SW_RST						BIT(7)
+#define SENINF_CTRL_SENINF_SRC_SEL					GENMASK(14, 12)
+#define SENINF_CTRL_PAD2CAM_DATA_SEL					GENMASK(30, 28)
+#define SENINF_CTRL_EXT							0x0204
+#define SENINF_CTRL_EXT_SENINF_TESTMDL_IP_EN				BIT(1)
+#define SENINF_CTRL_EXT_SENINF_NCSI2_IP_EN				BIT(5)
+#define SENINF_CTRL_EXT_SENINF_CSI2_IP_EN				BIT(6)
+#define SENINF_TG1_PH_CNT						0x0600
+#define SENINF_TG1_SEN_CK						0x0604
+#define SENINF_TG1_TM_CTL						0x0608
+#define SENINF_TG1_TM_CTL_TM_EN						BIT(0)
+#define SENINF_TG1_TM_CTL_TM_FMT					BIT(2)
+#define SENINF_TG1_TM_CTL_TM_PAT					GENMASK(7, 4)
+#define SENINF_TG1_TM_CTL_TM_VSYNC					GENMASK(15, 8)
+#define SENINF_TG1_TM_CTL_TM_DUMMYPXL					GENMASK(23, 16)
+#define SENINF_TG1_TM_SIZE						0x060c
+#define SENINF_TG1_TM_CLK						0x0610
+#define SENINF_TG1_TM_STP						0x0614
+#define MIPI_RX_CON24_CSI0						0x0824
+#define MIPI_RX_CON24_CSI0_CSI0_BIST_LN0_MUX				GENMASK(25, 24)
+#define MIPI_RX_CON24_CSI0_CSI0_BIST_LN1_MUX				GENMASK(27, 26)
+#define MIPI_RX_CON24_CSI0_CSI0_BIST_LN2_MUX				GENMASK(29, 28)
+#define MIPI_RX_CON24_CSI0_CSI0_BIST_LN3_MUX				GENMASK(31, 30)
+#define SENINF_CSI2_CTL							0x0a00
+#define SENINF_CSI2_CTL_DATA_LANE0_EN					BIT(0)
+#define SENINF_CSI2_CTL_DATA_LANE1_EN					BIT(1)
+#define SENINF_CSI2_CTL_DATA_LANE2_EN					BIT(2)
+#define SENINF_CSI2_CTL_DATA_LANE3_EN					BIT(3)
+#define SENINF_CSI2_CTL_CLOCK_LANE_EN					BIT(4)
+#define SENINF_CSI2_CTL_HSRX_DET_EN					BIT(7)
+#define SENINF_CSI2_CTL_HS_TRAIL_EN					BIT(25)
+#define SENINF_CSI2_CTL_CLOCK_HS_OPTION					BIT(27)
+#define SENINF_CSI2_LNRD_TIMING						0x0a08
+#define SENINF_CSI2_LNRD_TIMING_DATA_SETTLE_PARAMETER			GENMASK(15, 8)
+#define SENINF_CSI2_DPCM						0x0a0c
+#define SENINF_CSI2_INT_EN						0x0a10
+#define SENINF_CSI2_INT_STATUS						0x0a14
+#define SENINF_CSI2_DGB_SEL						0x0a18
+#define SENINF_CSI2_DGB_SEL_DEBUG_SEL					GENMASK(7, 0)
+#define SENINF_CSI2_DGB_SEL_DEBUG_EN					BIT(31)
+#define SENINF_CSI2_SPARE0						0x0a20
+#define SENINF_CSI2_LNRC_FSM						0x0a28
+#define SENINF_CSI2_HS_TRAIL						0x0a40
+#define SENINF_CSI2_HS_TRAIL_HS_TRAIL_PARAMETER				GENMASK(7, 0)
+#define SENINF_CSI2_RESYNC_MERGE_CTL					0x0a74
+#define SENINF_CSI2_RESYNC_MERGE_CTL_CPHY_LANE_RESYNC_CNT		GENMASK(2, 0)
+#define SENINF_CSI2_RESYNC_MERGE_CTL_BYPASS_LANE_RESYNC			BIT(10)
+#define SENINF_CSI2_RESYNC_MERGE_CTL_CDPHY_SEL				BIT(11)
+#define SENINF_CSI2_MODE						0x0ae8
+#define SENINF_CSI2_MODE_CSR_CSI2_MODE					GENMASK(7, 0)
+#define SENINF_CSI2_MODE_CSR_CSI2_HEADER_LEN				GENMASK(10, 8)
+#define SENINF_CSI2_DPHY_SYNC						0x0b20
+#define SENINF_CSI2_DPHY_SYNC_SYNC_SEQ_MASK_0				GENMASK(15, 0)
+#define SENINF_CSI2_DPHY_SYNC_SYNC_SEQ_PAT_0				GENMASK(31, 16)
+#define SENINF_MUX_CTRL							0x0d00
+#define SENINF_MUX_CTRL_SENINF_MUX_SW_RST				BIT(0)
+#define SENINF_MUX_CTRL_SENINF_IRQ_SW_RST				BIT(1)
+#define SENINF_MUX_CTRL_SENINF_HSYNC_MASK				BIT(7)
+#define SENINF_MUX_CTRL_SENINF_PIX_SEL					BIT(8)
+#define SENINF_MUX_CTRL_SENINF_VSYNC_POL				BIT(9)
+#define SENINF_MUX_CTRL_SENINF_HSYNC_POL				BIT(10)
+#define SENINF_MUX_CTRL_SENINF_SRC_SEL					GENMASK(15, 12)
+#define SENINF_MUX_CTRL_FIFO_PUSH_EN					GENMASK(21, 16)
+#define SENINF_MUX_CTRL_FIFO_FLUSH_EN					GENMASK(28, 22)
+#define SENINF_MUX_CTRL_FIFO_FULL_WR_EN					GENMASK(29, 28)
+#define SENINF_MUX_CTRL_SENINF_MUX_EN					BIT(31)
+#define SENINF_MUX_INTEN						0x0d04
+#define SENINF_MUX_SPARE						0x0d2c
+#define SENINF_MUX_CTRL_EXT						0x0d3c
+#define SENINF_MUX_CTRL_EXT_SENINF_SRC_SEL_EXT				GENMASK(1, 0)
+#define SENINF_MUX_CTRL_EXT_SENINF_PIX_SEL_EXT				BIT(4)
+#endif
-- 
2.41.0

