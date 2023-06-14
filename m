Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACD2712BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjEZRkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbjEZRkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:40:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7617DE54;
        Fri, 26 May 2023 10:40:27 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96fd3a658eeso142404266b.1;
        Fri, 26 May 2023 10:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685122826; x=1687714826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5ulXv131XACQa1N3gMs+ow3iDR22QUMWNdri33eDFM=;
        b=cxTMD/rsabP4WC8zdC/DhC95k4IfUWiCL5AisLHBqRS9p7IxllkolzCcszkzg28VRa
         bbOzYCk6i/1QPr1uqxzkhQBmaxStFK2SogD8jDUHCTsbuckeDxG9pg+P4jos9TEZKcHA
         eW7wVI37w8JvRnEgMZ5AdLOpPfPc4aLT29JlV7tPYwjS9jspoh1J9Ke4AygYao5k11//
         4GtiSRzyM5t2YrfCxYFyB0hJgKi4eZ0BdUYKquRd03FYwWtdEegooQAELeBJCDH6kC8R
         HSyBUpJg946mxlJgEt4cOD5Vs8bCHdlmjule+Mt49oN2YZCaYVatc/tyAg5sH4jaF1ed
         7o7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685122826; x=1687714826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5ulXv131XACQa1N3gMs+ow3iDR22QUMWNdri33eDFM=;
        b=cfAxMg+lnPFr+vSwxFKcpBxtcf4W8QWzDXd+A95y+6dTv49jri3Vd/bNZzQ58jckFu
         jRlmckkJb9PE1yJEhPBSRntZ20b5nWDLHykB7AzLd8xmRU0Km6Ki/nLo6ukUy87cQ6aa
         SggDb978gF8CencRTImx3COf4Wu9m7Tbr7Z/niqp0f+YNYyAnj7n+6zVViILxvNV7Ivl
         TmPiO5cm5GbONcNVVhl/iLX5z253GXw4RvPOukXUhS4JUy/G9Ce1Wg+66G2f5OzICJ+e
         KR2L5EueVinxYu11eo4B4EwRReIP4noS7/4995Vq9Qw/7ZK+8xL30BFak7Q8yEz0Yci5
         nDqw==
X-Gm-Message-State: AC+VfDwocsxANhxElXoQjtxBGYjGUMIuOjyxqmMObe/rVpTPQHr8zi/4
        0ZRGoZgD0UbuldHRDs1zuEw=
X-Google-Smtp-Source: ACHHUZ6BjthMKLCsJdUXq8bhlDLnWQJpNbGRELLqmqu/jXvYbqERHQ50Vbgccbu88BJuPXDxhH9egw==
X-Received: by 2002:a17:907:36cd:b0:96a:ec5c:687b with SMTP id bj13-20020a17090736cd00b0096aec5c687bmr2674641ejc.64.1685122825262;
        Fri, 26 May 2023 10:40:25 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id dk5-20020a170906f0c500b00965b2d3968csm2367723ejb.84.2023.05.26.10.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 10:40:24 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, linuxfancy@googlegroups.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 2/2] media: i2c: Add support for alvium camera
Date:   Fri, 26 May 2023 19:39:44 +0200
Message-Id: <20230526173955.797226-3-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526173955.797226-1-tomm.merciai@gmail.com>
References: <20230526173955.797226-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Alvium camera is shipped with sensor + isp in the same housing.
The camera can be equipped with one out of various sensor and abstract
the user from this. Camera is connected via MIPI CSI-2.

Most of the sensor's features are supported, with the main exception
being fw update.

The driver provides all mandatory, optional and recommended V4L2 controls
for maximum compatibility with libcamera

References:
 - https://www.alliedvision.com/en/products/embedded-vision-solutions

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/media/i2c/Kconfig  |    9 +
 drivers/media/i2c/Makefile |    1 +
 drivers/media/i2c/alvium.c | 3547 ++++++++++++++++++++++++++++++++++++
 drivers/media/i2c/alvium.h |  500 +++++
 4 files changed, 4057 insertions(+)
 create mode 100644 drivers/media/i2c/alvium.c
 create mode 100644 drivers/media/i2c/alvium.h

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 256d55bb2b1d..ad55cfc530aa 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -34,6 +34,15 @@ config VIDEO_APTINA_PLL
 config VIDEO_CCS_PLL
 	tristate
 
+config VIDEO_ALVIUM
+	tristate "Alliedvision ALVIUM camera support"
+	depends on I2C
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This driver supports the Allied Vision's Camera.
+
 config VIDEO_AR0521
 	tristate "ON Semiconductor AR0521 sensor support"
 	depends on I2C && VIDEO_DEV
diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
index b44dacf935f4..14e19d48cf05 100644
--- a/drivers/media/i2c/Makefile
+++ b/drivers/media/i2c/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_VIDEO_ADV7604) += adv7604.o
 obj-$(CONFIG_VIDEO_ADV7842) += adv7842.o
 obj-$(CONFIG_VIDEO_AK7375) += ak7375.o
 obj-$(CONFIG_VIDEO_AK881X) += ak881x.o
+obj-$(CONFIG_VIDEO_ALVIUM) += alvium.o
 obj-$(CONFIG_VIDEO_APTINA_PLL) += aptina-pll.o
 obj-$(CONFIG_VIDEO_AR0521) += ar0521.o
 obj-$(CONFIG_VIDEO_BT819) += bt819.o
diff --git a/drivers/media/i2c/alvium.c b/drivers/media/i2c/alvium.c
new file mode 100644
index 000000000000..e77fb6bda64b
--- /dev/null
+++ b/drivers/media/i2c/alvium.c
@@ -0,0 +1,3547 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Allied Vision Inc. Alvium camera driver
+ *
+ * Copyright (C) 2023 Tommaso Merciai
+ * Copyright (C) 2023 Martin Hecht
+ * Copyright (C) 2023 Avnet EMG GmbH
+ */
+
+#include <asm/unaligned.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/ctype.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_graph.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <media/v4l2-async.h>
+#include <media/v4l2-ctrls.h>
+#include <media/mipi-csi2.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-subdev.h>
+
+#include "alvium.h"
+
+static const struct v4l2_mbus_framefmt alvium_csi2_default_fmt = {
+	.code = MEDIA_BUS_FMT_UYVY8_1X16,
+	.width = 640,
+	.height = 480,
+	.colorspace = V4L2_COLORSPACE_SRGB,
+	.ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(V4L2_COLORSPACE_SRGB),
+	.quantization = V4L2_QUANTIZATION_FULL_RANGE,
+	.xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(V4L2_COLORSPACE_SRGB),
+	.field = V4L2_FIELD_NONE,
+};
+
+static const struct alvium_pixfmt alvium_csi2_fmts[] = {
+	{
+		/* UYVY8_2X8 */
+		.id = ALVIUM_FMT_UYVY8_2X8,
+		.code = MEDIA_BUS_FMT_UYVY8_2X8,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.fmt_av_bit = ALVIUM_BIT_YUV422_8,
+		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
+		.mipi_fmt_regval = 0x1E,
+		.bay_fmt_regval = -1,
+		.is_raw = 0,
+	}, {
+		/* UYVY8_1X16 */
+		.id = ALVIUM_FMT_UYVY8_1X16,
+		.code = MEDIA_BUS_FMT_UYVY8_1X16,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.fmt_av_bit = ALVIUM_BIT_YUV422_8,
+		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
+		.mipi_fmt_regval = 0x1E,
+		.bay_fmt_regval = -1,
+		.is_raw = 0,
+	}, {
+		/* YUYV8_1X16 */
+		.id = ALVIUM_FMT_YUYV8_1X16,
+		.code = MEDIA_BUS_FMT_YUYV8_1X16,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.fmt_av_bit = ALVIUM_BIT_YUV422_8,
+		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
+		.mipi_fmt_regval = 0x1E,
+		.bay_fmt_regval = -1,
+		.is_raw = 0,
+	}, {
+		/* YUYV8_2X8 */
+		.id = ALVIUM_FMT_YUYV8_2X8,
+		.code = MEDIA_BUS_FMT_YUYV8_2X8,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.fmt_av_bit = ALVIUM_BIT_YUV422_8,
+		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
+		.mipi_fmt_regval = 0x1E,
+		.bay_fmt_regval = -1,
+		.is_raw = 0,
+	}, {
+		/* YUYV10_1X20 */
+		.id = ALVIUM_FMT_YUYV10_1X20,
+		.code = MEDIA_BUS_FMT_YUYV10_1X20,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.fmt_av_bit = ALVIUM_BIT_YUV422_10,
+		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
+		.mipi_fmt_regval = 0x1F,
+		.bay_fmt_regval = -1,
+		.is_raw = 0,
+	}, {
+		/* RGB888_1X24 */
+		.id = ALVIUM_FMT_RGB888_1X24,
+		.code = MEDIA_BUS_FMT_RGB888_1X24,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.fmt_av_bit = ALVIUM_BIT_RGB888,
+		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
+		.mipi_fmt_regval = 0x24,
+		.bay_fmt_regval = -1,
+		.is_raw = 0,
+	}, {
+		/* RBG888_1X24 */
+		.id = ALVIUM_FMT_RBG888_1X24,
+		.code = MEDIA_BUS_FMT_RBG888_1X24,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.fmt_av_bit = ALVIUM_BIT_RGB888,
+		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
+		.mipi_fmt_regval = 0x24,
+		.bay_fmt_regval = -1,
+		.is_raw = 0,
+	}, {
+		/* BGR888_1X24 */
+		.id = ALVIUM_FMT_BGR888_1X24,
+		.code = MEDIA_BUS_FMT_BGR888_1X24,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.fmt_av_bit = ALVIUM_BIT_RGB888,
+		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
+		.mipi_fmt_regval = 0x24,
+		.bay_fmt_regval = -1,
+		.is_raw = 0,
+	}, {
+		/* RGB888_3X8 */
+		.id = ALVIUM_FMT_RGB888_3X8,
+		.code = MEDIA_BUS_FMT_RGB888_3X8,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.fmt_av_bit = ALVIUM_BIT_RGB888,
+		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
+		.mipi_fmt_regval = 0x24,
+		.bay_fmt_regval = -1,
+		.is_raw = 0,
+	}, {
+		/* Y8_1X8 */
+		.id = ALVIUM_FMT_Y8_1X8,
+		.code = MEDIA_BUS_FMT_Y8_1X8,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW8,
+		.bay_av_bit = ALVIUM_BIT_BAY_MONO,
+		.mipi_fmt_regval = 0x2A,
+		.bay_fmt_regval = 0x00,
+		.is_raw = 1,
+	}, {
+		/* SGRBG8_1X8 */
+		.id = ALVIUM_FMT_SGRBG8_1X8,
+		.code = MEDIA_BUS_FMT_SGRBG8_1X8,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW8,
+		.bay_av_bit = ALVIUM_BIT_BAY_GR,
+		.mipi_fmt_regval = 0x2A,
+		.bay_fmt_regval = 0x01,
+		.is_raw = 1,
+	}, {
+		/* SRGGB8_1X8 */
+		.id = ALVIUM_FMT_SRGGB8_1X8,
+		.code = MEDIA_BUS_FMT_SRGGB8_1X8,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW8,
+		.bay_av_bit = ALVIUM_BIT_BAY_RG,
+		.mipi_fmt_regval = 0x2A,
+		.bay_fmt_regval = 0x02,
+		.is_raw = 1,
+	}, {
+		/* SGBRG8_1X8 */
+		.id = ALVIUM_FMT_SGBRG8_1X8,
+		.code = MEDIA_BUS_FMT_SGBRG8_1X8,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW8,
+		.bay_av_bit = ALVIUM_BIT_BAY_GB,
+		.mipi_fmt_regval = 0x2A,
+		.bay_fmt_regval = 0x03,
+		.is_raw = 1,
+	}, {
+		/* SBGGR8_1X8 */
+		.id = ALVIUM_FMT_SBGGR8_1X8,
+		.code = MEDIA_BUS_FMT_SBGGR8_1X8,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW8,
+		.bay_av_bit = ALVIUM_BIT_BAY_BG,
+		.mipi_fmt_regval = 0x2A,
+		.bay_fmt_regval = 0x04,
+		.is_raw = 1,
+	}, {
+		/* Y10_1X10 */
+		.id = ALVIUM_FMT_Y10_1X10,
+		.code = MEDIA_BUS_FMT_Y10_1X10,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW10,
+		.bay_av_bit = ALVIUM_BIT_BAY_MONO,
+		.mipi_fmt_regval = 0x2B,
+		.bay_fmt_regval = 0x00,
+		.is_raw = 1,
+	}, {
+		/* SGRBG10_1X10 */
+		.id = ALVIUM_FMT_SGRBG10_1X10,
+		.code = MEDIA_BUS_FMT_SGRBG10_1X10,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW10,
+		.bay_av_bit = ALVIUM_BIT_BAY_GR,
+		.mipi_fmt_regval = 0x2B,
+		.bay_fmt_regval = 0x01,
+		.is_raw = 1,
+	}, {
+		/* SRGGB10_1X10 */
+		.id = ALVIUM_FMT_SRGGB10_1X10,
+		.code = MEDIA_BUS_FMT_SRGGB10_1X10,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW10,
+		.bay_av_bit = ALVIUM_BIT_BAY_RG,
+		.mipi_fmt_regval = 0x2B,
+		.bay_fmt_regval = 0x02,
+		.is_raw = 1,
+	}, {
+		/* SGBRG10_1X10 */
+		.id = ALVIUM_FMT_SGBRG10_1X10,
+		.code = MEDIA_BUS_FMT_SGBRG10_1X10,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW10,
+		.bay_av_bit = ALVIUM_BIT_BAY_GB,
+		.mipi_fmt_regval = 0x2B,
+		.bay_fmt_regval = 0x03,
+		.is_raw = 1,
+	}, {
+		/* SBGGR10_1X10 */
+		.id = ALVIUM_FMT_SBGGR10_1X10,
+		.code = MEDIA_BUS_FMT_SBGGR10_1X10,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW10,
+		.bay_av_bit = ALVIUM_BIT_BAY_BG,
+		.mipi_fmt_regval = 0x2B,
+		.bay_fmt_regval = 0x04,
+		.is_raw = 1,
+	}, {
+		/* Y12_1X12 */
+		.id = ALVIUM_FMT_Y12_1X12,
+		.code = MEDIA_BUS_FMT_Y12_1X12,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW12,
+		.bay_av_bit = ALVIUM_BIT_BAY_MONO,
+		.mipi_fmt_regval = 0x2C,
+		.bay_fmt_regval = 0x00,
+		.is_raw = 1,
+	}, {
+		/* SGRBG12_1X12 */
+		.id = ALVIUM_FMT_SGRBG12_1X12,
+		.code = MEDIA_BUS_FMT_SGRBG12_1X12,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW12,
+		.bay_av_bit = ALVIUM_BIT_BAY_GR,
+		.mipi_fmt_regval = 0x2C,
+		.bay_fmt_regval = 0x01,
+		.is_raw = 1,
+	}, {
+		/* SRGGB12_1X12 */
+		.id = ALVIUM_FMT_SRGGB12_1X12,
+		.code = MEDIA_BUS_FMT_SRGGB12_1X12,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW12,
+		.bay_av_bit = ALVIUM_BIT_BAY_RG,
+		.mipi_fmt_regval = 0x2C,
+		.bay_fmt_regval = 0x02,
+		.is_raw = 1,
+	}, {
+		/* SGBRG12_1X12 */
+		.id = ALVIUM_FMT_SGBRG12_1X12,
+		.code = MEDIA_BUS_FMT_SGBRG12_1X12,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW12,
+		.bay_av_bit = ALVIUM_BIT_BAY_GB,
+		.mipi_fmt_regval = 0x2C,
+		.bay_fmt_regval = 0x03,
+		.is_raw = 1,
+	}, {
+		/* SBGGR12_1X12 */
+		.id = ALVIUM_FMT_SBGGR12_1X12,
+		.code = MEDIA_BUS_FMT_SBGGR12_1X12,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW12,
+		.bay_av_bit = ALVIUM_BIT_BAY_BG,
+		.mipi_fmt_regval = 0x2C,
+		.bay_fmt_regval = 0x04,
+		.is_raw = 1,
+	}, {
+		/* SBGGR14_1X14 */
+		.id = ALVIUM_FMT_SBGGR14_1X14,
+		.code = MEDIA_BUS_FMT_SBGGR14_1X14,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW14,
+		.bay_av_bit = ALVIUM_BIT_BAY_GR,
+		.mipi_fmt_regval = 0x2D,
+		.bay_fmt_regval = 0x01,
+		.is_raw = 1,
+	}, {
+		/* SGBRG14_1X14 */
+		.id = ALVIUM_FMT_SGBRG14_1X14,
+		.code = MEDIA_BUS_FMT_SGBRG14_1X14,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW14,
+		.bay_av_bit = ALVIUM_BIT_BAY_RG,
+		.mipi_fmt_regval = 0x2D,
+		.bay_fmt_regval = 0x02,
+		.is_raw = 1,
+	}, {
+		/* SRGGB14_1X14 */
+		.id = ALVIUM_FMT_SRGGB14_1X14,
+		.code = MEDIA_BUS_FMT_SRGGB14_1X14,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW14,
+		.bay_av_bit = ALVIUM_BIT_BAY_GB,
+		.mipi_fmt_regval = 0x2D,
+		.bay_fmt_regval = 0x03,
+		.is_raw = 1,
+	}, {
+		/* SGRBG14_1X14 */
+		.id = ALVIUM_FMT_SGRBG14_1X14,
+		.code = MEDIA_BUS_FMT_SGRBG14_1X14,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW14,
+		.bay_av_bit = ALVIUM_BIT_BAY_BG,
+		.mipi_fmt_regval = 0x2D,
+		.bay_fmt_regval = 0x04,
+		.is_raw = 1,
+	},
+	{ /* sentinel */ }
+};
+
+static int alvium_i2c_read_reg(struct alvium_dev *alvium,
+				  u16 reg, u32 len, u64 *val)
+{
+	struct i2c_client *client = alvium->i2c_client;
+	struct i2c_msg msgs[2] = {0};
+	u8 addr_buf[2] = {0};
+	u8 data_buf[8] = {0};
+	int ret;
+
+	if (WARN_ON(len > 8))
+		return -EINVAL;
+
+	put_unaligned_be16(reg, addr_buf);
+
+	msgs[0].addr = client->addr;
+	msgs[0].flags = 0;
+	msgs[0].len = ARRAY_SIZE(addr_buf);
+	msgs[0].buf = addr_buf;
+
+	msgs[1].addr = client->addr;
+	msgs[1].flags = I2C_M_RD;
+	msgs[1].len = len;
+	msgs[1].buf = &data_buf[8 - len];
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret != ARRAY_SIZE(msgs))
+		return -EIO;
+
+	*val = get_unaligned_be64(data_buf);
+
+	return 0;
+}
+
+static int alvium_i2c_write_reg(struct alvium_dev *alvium,
+				  u16 reg, u32 len, u64 val)
+{
+	struct i2c_client *client = alvium->i2c_client;
+	u8 buf[10] = {0};
+
+	if (WARN_ON(len > 8))
+		return -EINVAL;
+
+	put_unaligned_be16(reg, buf);
+	put_unaligned_be64(val << (8 * (8 - len)), buf + 2);
+	if (i2c_master_send(client, buf, len + 2) != len + 2)
+		return -EIO;
+
+	return 0;
+}
+
+static int alvium_i2c_write_reg_hshake(struct alvium_dev *alvium,
+				  u16 reg, u32 len, u64 val)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	u64 hshake_regval;
+	int ret;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	/* reset handshake bit */
+	ret = alvium_i2c_write_reg(alvium,
+				  alvium->bcrm_addr + REG_BCRM_WRITE_HANDSHAKE_8RW,
+				  1, BCRM_HANDSHAKE_W_RST);
+	if (ret) {
+		dev_err(dev, "Fail to read host supported csi2 lanes reg\n");
+		return ret;
+	}
+
+	ret = alvium_i2c_write_reg(alvium, reg, len, val);
+	if (ret) {
+		dev_err(dev, "Fail to read host supported csi2 lanes reg\n");
+		return ret;
+	}
+
+	/* poll handshake bit since bit0 = 1*/
+	do {
+		ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr + REG_BCRM_WRITE_HANDSHAKE_8RW,
+				  1, &hshake_regval);
+		if (ret) {
+			dev_err(dev, "Fail to read host supported csi2 lanes reg\n");
+			return ret;
+		}
+
+		alvium->hshake_bit =
+				  (hshake_regval & BCRM_HANDSHAKE_W_DONE_EN_BIT);
+
+	} while (!(alvium->hshake_bit));
+
+	/* reset handshake bit, write 0 to bit0 */
+	ret = alvium_i2c_write_reg(alvium,
+				  alvium->bcrm_addr + REG_BCRM_WRITE_HANDSHAKE_8RW,
+				  1, BCRM_HANDSHAKE_W_RST);
+	if (ret) {
+		dev_err(dev, "Fail to read host supported csi2 lanes reg\n");
+		return ret;
+	}
+
+	/* poll handshake bit since bit0 = 0 */
+	do {
+		ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr + REG_BCRM_WRITE_HANDSHAKE_8RW,
+				  1, &hshake_regval);
+		if (ret) {
+			dev_err(dev, "Fail to read host supported csi2 lanes reg\n");
+			return ret;
+		}
+
+		alvium->hshake_bit =
+				  (hshake_regval & BCRM_HANDSHAKE_W_DONE_EN_BIT);
+
+	} while (alvium->hshake_bit);
+
+	return 0;
+}
+
+static int alvium_power_on(struct alvium_dev *alvium)
+{
+	int ret;
+
+	ret = clk_set_rate(alvium->xclk, alvium->xclk_freq);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(alvium->xclk);
+	if (ret)
+		return ret;
+
+	gpiod_set_value(alvium->pwdn_gpio, 0);
+	usleep_range(100, 200);
+	gpiod_set_value(alvium->reset_gpio, 0);
+	usleep_range(50, 100);
+
+	return 0;
+}
+
+static int alvium_power_off(struct alvium_dev *alvium)
+{
+	gpiod_set_value(alvium->reset_gpio, 1);
+	usleep_range(10, 50);
+	gpiod_set_value(alvium->pwdn_gpio, 1);
+	usleep_range(100, 200);
+
+	clk_disable_unprepare(alvium->xclk);
+
+	return 0;
+}
+
+static int alvium_get_bcrm_vers(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+	alvium_bcrm_vers_t *v;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  REG_BCRM_VERSION_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read bcrm version reg\n");
+		return ret;
+	}
+
+	v = (alvium_bcrm_vers_t *) &tmp;
+
+	alvium->bcrm_v.minor = v->minor;
+	alvium->bcrm_v.major = v->major;
+
+	dev_dbg(dev, "bcrm version: %u.%u\n", alvium->bcrm_v.minor,
+				  alvium->bcrm_v.major);
+
+	return 0;
+}
+
+static int alvium_get_fw_vers(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+	alvium_fw_vers_t *fw_v;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_DEVICE_FIRMWARE_VERSION_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read fw version reg\n");
+		return ret;
+	}
+
+	fw_v = (alvium_fw_vers_t *) &tmp;
+
+	alvium->fw_v.special = fw_v->special;
+	alvium->fw_v.major = fw_v->major;
+	alvium->fw_v.minor = fw_v->major;
+	alvium->fw_v.patch = fw_v->patch;
+
+	dev_dbg(dev, "fw version: %u.%u.%u.%u\n",
+				  alvium->fw_v.special,
+				  alvium->fw_v.major,
+				  alvium->fw_v.minor,
+				  alvium->fw_v.patch);
+
+	return 0;
+}
+
+static int alvium_get_bcrm_addr(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  REG_BCRM_REG_ADDR_16R, 2, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read bcrm addr reg\n");
+		return ret;
+	}
+
+	alvium->bcrm_addr = (u16)tmp;
+	dev_dbg(dev, "bcrm addr: %d\n", alvium->bcrm_addr);
+
+	return 0;
+}
+
+void alvium_print_avail_mipi_fmt(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+
+	dev_dbg(dev, "avail mipi_fmt yuv420_8_leg: %u\n",
+		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8_LEG]);
+	dev_dbg(dev, "avail mipi_fmt yuv420_8: %u\n",
+		   alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8]);
+	dev_dbg(dev, "avail mipi_fmt yuv420_10: %u\n",
+		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_10]);
+	dev_dbg(dev, "avail mipi_fmt yuv420_8_csps: %u\n",
+		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8_CSPS]);
+	dev_dbg(dev, "avail mipi_fmt yuv420_10_csps: %u\n",
+		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_10_CSPS]);
+	dev_dbg(dev, "avail mipi_fmt yuv422_8: %u\n",
+		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV422_8]);
+	dev_dbg(dev, "avail mipi_fmt yuv422_10: %u\n",
+		   alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV422_10]);
+	dev_dbg(dev, "avail mipi_fmt rgb888: %u\n",
+		   alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB888]);
+	dev_dbg(dev, "avail mipi_fmt rgb666: %u\n",
+		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB666]);
+	dev_dbg(dev, "avail mipi_fmt rgb565: %u\n",
+		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB565]);
+	dev_dbg(dev, "avail mipi_fmt rgb555: %u\n",
+		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB555]);
+	dev_dbg(dev, "avail mipi_fmt rgb444: %u\n",
+		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB444]);
+	dev_dbg(dev, "avail mipi_fmt raw6: %u\n",
+		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW6]);
+	dev_dbg(dev, "avail mipi_fmt raw7: %u\n",
+		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW7]);
+	dev_dbg(dev, "avail mipi_fmt raw8: %u\n",
+		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW8]);
+	dev_dbg(dev, "avail mipi_fmt raw10: %u\n",
+		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW10]);
+	dev_dbg(dev, "avail mipi_fmt raw12: %u\n",
+		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW12]);
+	dev_dbg(dev, "avail mipi_fmt raw14: %u\n",
+		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW14]);
+	dev_dbg(dev, "avail mipi_fmt jpeg: %u\n",
+		  alvium->is_mipi_fmt_avail[ALVIUM_BIT_JPEG]);
+}
+
+void alvium_print_avail_feat(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+
+	dev_dbg(dev, "feature rev_x: %u\n",
+		  alvium->avail_ft.rev_x);
+	dev_dbg(dev, "feature rev_y: %u\n",
+		  alvium->avail_ft.rev_y);
+	dev_dbg(dev, "feature int_autop: %u\n",
+		  alvium->avail_ft.int_autop);
+	dev_dbg(dev, "feature black_lvl: %u\n",
+		  alvium->avail_ft.black_lvl);
+	dev_dbg(dev, "feature gain: %u\n",
+		  alvium->avail_ft.gain);
+	dev_dbg(dev, "feature gamma: %u\n",
+		  alvium->avail_ft.gamma);
+	dev_dbg(dev, "feature contrast: %u\n",
+		  alvium->avail_ft.contrast);
+	dev_dbg(dev, "feature sat: %u\n",
+		  alvium->avail_ft.sat);
+	dev_dbg(dev, "feature hue: %u\n",
+		  alvium->avail_ft.hue);
+	dev_dbg(dev, "feature whiteb: %u\n",
+		  alvium->avail_ft.whiteb);
+	dev_dbg(dev, "feature sharp: %u\n",
+		  alvium->avail_ft.sharp);
+	dev_dbg(dev, "feature auto_exp: %u\n",
+		  alvium->avail_ft.auto_exp);
+	dev_dbg(dev, "feature auto_gain: %u\n",
+		  alvium->avail_ft.auto_gain);
+	dev_dbg(dev, "feature auto_whiteb: %u\n",
+		  alvium->avail_ft.auto_whiteb);
+	dev_dbg(dev, "feature dev_temp: %u\n",
+		  alvium->avail_ft.dev_temp);
+	dev_dbg(dev, "feature acq_abort: %u\n",
+		  alvium->avail_ft.acq_abort);
+	dev_dbg(dev, "feature acq_fr: %u\n",
+		  alvium->avail_ft.acq_fr);
+	dev_dbg(dev, "feature fr_trigger: %u\n",
+		  alvium->avail_ft.fr_trigger);
+	dev_dbg(dev, "feature exp_acq_line: %u\n",
+		  alvium->avail_ft.exp_acq_line);
+}
+
+void alvium_print_avail_bayer(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+
+	dev_dbg(dev, "avail bayer mono: %u\n",
+		  alvium->is_bay_avail[ALVIUM_BIT_BAY_MONO]);
+	dev_dbg(dev, "avail bayer gr: %u\n",
+		  alvium->is_bay_avail[ALVIUM_BIT_BAY_GR]);
+	dev_dbg(dev, "avail bayer rg: %u\n",
+		  alvium->is_bay_avail[ALVIUM_BIT_BAY_RG]);
+	dev_dbg(dev, "avail bayer gb: %u\n",
+		  alvium->is_bay_avail[ALVIUM_BIT_BAY_GB]);
+	dev_dbg(dev, "avail bayer bg: %u\n",
+		  alvium->is_bay_avail[ALVIUM_BIT_BAY_BG]);
+}
+
+static int alvium_get_feat_inq(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	alvium_avail_feat_t *f;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr + REG_BCRM_FEATURE_INQUIRY_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to features inquiry reg\n");
+		return ret;
+	}
+
+	f = (alvium_avail_feat_t *) &tmp;
+
+	alvium->avail_ft.rev_x = f->rev_x;
+	alvium->avail_ft.rev_y = f->rev_y;
+	alvium->avail_ft.int_autop = f->int_autop;
+	alvium->avail_ft.black_lvl = f->black_lvl;
+	alvium->avail_ft.gain = f->gain;
+	alvium->avail_ft.gamma = f->gamma;
+	alvium->avail_ft.contrast = f->contrast;
+	alvium->avail_ft.sat = f->sat;
+	alvium->avail_ft.hue = f->rev_y;
+	alvium->avail_ft.whiteb = f->whiteb;
+	alvium->avail_ft.sharp = f->sharp;
+	alvium->avail_ft.auto_exp = f->auto_exp;
+	alvium->avail_ft.auto_gain = f->auto_gain;
+	alvium->avail_ft.auto_whiteb = f->auto_whiteb;
+	alvium->avail_ft.dev_temp = f->dev_temp;
+	alvium->avail_ft.acq_abort = f->acq_abort;
+	alvium->avail_ft.acq_fr = f->acq_fr;
+	alvium->avail_ft.fr_trigger = f->fr_trigger;
+	alvium->avail_ft.exp_acq_line = f->exp_acq_line;
+
+	alvium_print_avail_feat(alvium);
+
+	return 0;
+}
+
+static int alvium_get_host_supp_csi_lanes(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr + REG_BCRM_CSI2_LANE_COUNT_8RW,
+				  1, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read host supported csi2 lanes reg\n");
+		return ret;
+	}
+
+	alvium->h_sup_csi_lanes = (u8)tmp;
+	dev_dbg(dev, "host supported csi2 lanes count: %d\n",
+				  alvium->h_sup_csi_lanes);
+
+	return 0;
+}
+
+static int alvium_set_csi_lanes(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 num_lanes;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	num_lanes = alvium->ep.bus.mipi_csi2.num_data_lanes;
+
+	if (num_lanes <= alvium->h_sup_csi_lanes) {
+		ret = alvium_i2c_write_reg_hshake(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_CSI2_LANE_COUNT_8RW,
+				  1, num_lanes);
+		if (ret) {
+			dev_err(dev, "Fail to set csi lanes reg\n");
+			return ret;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "Set n lanes = %llu", num_lanes);
+
+	return 0;
+}
+
+static int alvium_set_streamon_delay(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 streamon_delay;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	/*
+	 * CSI2 receivers sometimes need some delay before are ready to
+	 * get data. This register set delay before camera start
+	 * capturing frames in us.
+	 */
+	streamon_delay = (u64)alvium->streamon_delay;
+
+	ret = alvium_i2c_write_reg_hshake(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_STREAM_ON_DELAY_32RW,
+				  4, streamon_delay);
+	if (ret) {
+		dev_err(dev, "Fail to set streamon delay reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_get_csi_clk_params(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_CSI2_CLOCK_MIN_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read host supported csi2 lanes reg\n");
+		return ret;
+	}
+
+	alvium->min_csi_clk = (u32)tmp;
+	dev_dbg(dev, "Min host supported csi clock: %d\n",
+				  alvium->min_csi_clk);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_CSI2_CLOCK_MAX_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read host supported csi2 lanes reg\n");
+		return ret;
+	}
+
+	alvium->max_csi_clk = (u32)tmp;
+	dev_dbg(dev, "Max host supported csi clock: %d\n",
+				  alvium->max_csi_clk);
+
+	return 0;
+}
+
+static int alvium_set_csi_clk(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 csi_clk;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_CSI2_CLOCK_32RW,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read host supported csi2 lanes reg\n");
+		return ret;
+	}
+
+	dev_dbg(dev, "bcrm csi2 clock freq reg: %llu\n", tmp);
+	csi_clk = alvium->ep.link_frequencies[0];
+
+	if (csi_clk > alvium->min_csi_clk ||
+		csi_clk < alvium->max_csi_clk) {
+		ret = alvium_i2c_write_reg_hshake(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_CSI2_CLOCK_32RW,
+				  4, csi_clk);
+		if (ret) {
+			dev_err(dev, "Fail to set csi lanes reg\n");
+			return ret;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	alvium->link_freq = alvium->ep.link_frequencies[0];
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_CSI2_CLOCK_32RW,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read host supported csi2 lanes reg\n");
+		return ret;
+	}
+
+	dev_dbg(dev, "bcrm csi2 clock freq reg: %llu\n", tmp);
+
+	return 0;
+}
+
+static int alvium_get_img_width_params(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_WIDTH_MIN_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read img min width reg\n");
+		return ret;
+	}
+
+	alvium->img_min_width = (u32)tmp;
+	dev_dbg(dev, "Min img width: %d\n",
+				  alvium->img_min_width);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_WIDTH_MAX_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read img max width reg\n");
+		return ret;
+	}
+
+	alvium->img_max_width = (u32)tmp;
+	dev_dbg(dev, "Max img width: %d\n",
+				  alvium->img_max_width);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_WIDTH_INC_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read img inc width reg\n");
+		return ret;
+	}
+
+	alvium->img_inc_width = (u32)tmp;
+	dev_dbg(dev, "img width increment: %d px\n",
+				  alvium->img_inc_width);
+
+	return 0;
+}
+
+static int alvium_get_img_height_params(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_HEIGHT_MIN_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read img min height reg\n");
+		return ret;
+	}
+
+	alvium->img_min_height = (u32)tmp;
+	dev_dbg(dev, "Min img height: %d\n",
+				  alvium->img_min_height);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_HEIGHT_MAX_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read img max height reg\n");
+		return ret;
+	}
+
+	alvium->img_max_height = (u32)tmp;
+	dev_dbg(dev, "Max img height: %d\n",
+				  alvium->img_max_height);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_HEIGHT_INC_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read img inc height reg\n");
+		return ret;
+	}
+
+	alvium->img_inc_height = (u32)tmp;
+	dev_dbg(dev, "img height increment: %d\n",
+				  alvium->img_inc_height);
+
+	return 0;
+}
+
+static int alvium_set_img_width(struct alvium_dev *alvium, u32 width)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_i2c_write_reg_hshake(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_WIDTH_32RW,
+				  4, width);
+	if (ret) {
+		dev_err(dev, "Fail to set img width\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_img_height(struct alvium_dev *alvium, u32 height)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_i2c_write_reg_hshake(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_HEIGHT_32RW,
+				  4, height);
+	if (ret) {
+		dev_err(dev, "Fail to set img height\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_img_offx(struct alvium_dev *alvium, u32 offx)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_i2c_write_reg_hshake(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_OFFSET_X_32RW,
+				  4, offx);
+	if (ret) {
+		dev_err(dev, "Fail to set img offx\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_img_offy(struct alvium_dev *alvium, u32 offy)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_i2c_write_reg_hshake(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_OFFSET_Y_32RW,
+				  4, offy);
+	if (ret) {
+		dev_err(dev, "Fail to set img offy\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_get_offx_params(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_OFFSET_X_MIN_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read min offx reg\n");
+		return ret;
+	}
+
+	alvium->min_offx = (u32)tmp;
+	dev_dbg(dev, "Min img offx: %d\n",
+				  alvium->min_offx);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_OFFSET_X_MAX_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read max offx reg\n");
+		return ret;
+	}
+
+	alvium->max_offx = (u32)tmp;
+	dev_dbg(dev, "Max img offx: %d\n",
+				  alvium->max_offx);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_OFFSET_X_INC_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read inc offx reg\n");
+		return ret;
+	}
+
+	alvium->inc_offx = (u32)tmp;
+	dev_dbg(dev, "Inc img offx: %d\n",
+				  alvium->inc_offx);
+
+	return 0;
+}
+
+static int alvium_get_offy_params(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_OFFSET_Y_MIN_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read min offy reg\n");
+		return ret;
+	}
+
+	alvium->min_offy = (u32)tmp;
+	dev_dbg(dev, "Min img offy: %d\n",
+				  alvium->min_offy);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_OFFSET_Y_MAX_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read max offy reg\n");
+		return ret;
+	}
+
+	alvium->max_offy = (u32)tmp;
+	dev_dbg(dev, "Max img offy: %d\n",
+				  alvium->max_offy);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_OFFSET_Y_INC_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read inc offy reg\n");
+		return ret;
+	}
+
+	alvium->inc_offy = (u32)tmp;
+	dev_dbg(dev, "Inc img offy: %d\n",
+				  alvium->inc_offy);
+
+	return 0;
+}
+
+static int alvium_get_gain_params(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_GAIN_MIN_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to min gain reg\n");
+		return ret;
+	}
+
+	alvium->min_gain = tmp;
+	dev_dbg(dev, "Min gain: %llu mB\n",
+				  alvium->min_gain);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_GAIN_MAX_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to max gain reg\n");
+		return ret;
+	}
+
+	alvium->max_gain = tmp;
+	dev_dbg(dev, "Max gain: %llu mB\n",
+				  alvium->max_gain);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_GAIN_INC_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to inc gain reg\n");
+		return ret;
+	}
+
+	alvium->inc_gain = tmp;
+	dev_dbg(dev, "gain inc: %llu mB\n",
+				  alvium->inc_gain);
+
+	return 0;
+}
+
+static int alvium_get_exposure_params(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_EXPOSURE_TIME_MIN_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read img min exp reg\n");
+		return ret;
+	}
+
+	alvium->min_exp = tmp;
+	dev_dbg(dev, "Min exp: %llu ns\n",
+				  alvium->min_exp);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_EXPOSURE_TIME_MAX_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read img max exp reg\n");
+		return ret;
+	}
+
+	alvium->max_exp = tmp;
+	dev_dbg(dev, "Max exp: %llu ns\n",
+				  alvium->max_exp);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_EXPOSURE_TIME_INC_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read inc exp reg\n");
+		return ret;
+	}
+
+	alvium->inc_exp = tmp;
+	dev_dbg(dev, "Inc exp: %llu ns\n",
+				  alvium->inc_exp);
+
+	return 0;
+}
+
+static int alvium_get_red_balance_ratio_params(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_RED_BALANCE_RATIO_MIN_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read min rbalance reg\n");
+		return ret;
+	}
+
+	alvium->min_rbalance = tmp;
+	dev_dbg(dev, "Min rbalance: %llu\n",
+				  alvium->min_rbalance);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_RED_BALANCE_RATIO_MAX_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read max rbalance reg\n");
+		return ret;
+	}
+
+	alvium->max_rbalance = tmp;
+	dev_dbg(dev, "Max rbalance: %llu\n",
+				  alvium->max_rbalance);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_RED_BALANCE_RATIO_INC_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read inc rbalance reg\n");
+		return ret;
+	}
+
+	alvium->inc_rbalance = tmp;
+	dev_dbg(dev, "Inc rbalance: %llu\n",
+				  alvium->inc_rbalance);
+
+	return 0;
+}
+
+static int alvium_get_blue_balance_ratio_params(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_BLUE_BALANCE_RATIO_MIN_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read min bbalance reg\n");
+		return ret;
+	}
+
+	alvium->min_bbalance = tmp;
+	dev_dbg(dev, "Min bbalance: %llu\n",
+				  alvium->min_bbalance);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_BLUE_BALANCE_RATIO_MAX_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read max bbalance reg\n");
+		return ret;
+	}
+
+	alvium->max_bbalance = tmp;
+	dev_dbg(dev, "Max bbalance: %llu\n",
+				  alvium->max_bbalance);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_BLUE_BALANCE_RATIO_INC_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read inc bbalance reg\n");
+		return ret;
+	}
+
+	alvium->inc_bbalance = tmp;
+	dev_dbg(dev, "Inc bbalance: %llu\n",
+				  alvium->inc_bbalance);
+
+	return 0;
+}
+
+static int alvium_get_hue_params(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_HUE_MIN_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read min hue reg\n");
+		return ret;
+	}
+
+	alvium->min_hue = (s32)tmp;
+	dev_dbg(dev, "Min hue: %d\n",
+				  alvium->min_hue);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_HUE_MAX_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read max hue reg\n");
+		return ret;
+	}
+
+	alvium->max_hue = (s32)tmp;
+	dev_dbg(dev, "Max hue: %d\n",
+				  alvium->max_hue);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_HUE_INC_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read inc hue reg\n");
+		return ret;
+	}
+
+	alvium->inc_hue = (s32)tmp;
+	dev_dbg(dev, "Inc hue: %d\n",
+				  alvium->inc_hue);
+
+	return 0;
+}
+
+static int alvium_get_black_lvl_params(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_BLACK_LEVEL_MIN_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read min black lvl reg\n");
+		return ret;
+	}
+
+	alvium->min_black_lvl = (s32)tmp;
+	dev_dbg(dev, "Min black lvl: %d\n",
+				  alvium->min_hue);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_BLACK_LEVEL_MAX_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read max black lvl reg\n");
+		return ret;
+	}
+
+	alvium->max_black_lvl = (s32)tmp;
+	dev_dbg(dev, "Max black lvl: %d\n",
+				  alvium->max_black_lvl);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_BLACK_LEVEL_INC_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read inc black lvl reg\n");
+		return ret;
+	}
+
+	alvium->inc_black_lvl = (s32)tmp;
+	dev_dbg(dev, "Inc black lvl: %d\n",
+				  alvium->inc_black_lvl);
+
+	return 0;
+}
+
+static int alvium_get_gamma_params(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_GAMMA_MIN_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read min gamma reg\n");
+		return ret;
+	}
+
+	alvium->min_gamma = tmp;
+	dev_dbg(dev, "Min gamma: %llu\n",
+				  alvium->min_gamma);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_GAMMA_MAX_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read max bbalance reg\n");
+		return ret;
+	}
+
+	alvium->max_gamma = tmp;
+	dev_dbg(dev, "Max gamma: %llu\n",
+				  alvium->max_gamma);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_GAMMA_INC_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read inc gamma reg\n");
+		return ret;
+	}
+
+	alvium->inc_gamma = tmp;
+	dev_dbg(dev, "Inc gamma: %llu\n",
+				  alvium->inc_gamma);
+
+	return 0;
+}
+
+static int alvium_get_sharpness_params(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_SHARPNESS_MIN_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read min sharpness lvl reg\n");
+		return ret;
+	}
+
+	alvium->min_sharp = (s32)tmp;
+	dev_dbg(dev, "Min sharpness: %d\n",
+				  alvium->min_sharp);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_BLACK_LEVEL_MAX_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read max sharpness reg\n");
+		return ret;
+	}
+
+	alvium->max_sharp = (s32)tmp;
+	dev_dbg(dev, "Max sharpness: %d\n",
+				  alvium->max_sharp);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_SHARPNESS_INC_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read inc sharpness reg\n");
+		return ret;
+	}
+
+	alvium->inc_sharp = (s32)tmp;
+	dev_dbg(dev, "Inc sharpness: %d\n",
+				  alvium->inc_sharp);
+
+	return 0;
+}
+
+static int alvium_get_contrast_params(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_CONTRAST_VALUE_MIN_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read min contrast reg\n");
+		return ret;
+	}
+
+	alvium->min_contrast = (u32)tmp;
+	dev_dbg(dev, "Min contrast: %d\n",
+				  alvium->min_contrast);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_CONTRAST_VALUE_MAX_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read max contrast reg\n");
+		return ret;
+	}
+
+	alvium->max_contrast = (u32)tmp;
+	dev_dbg(dev, "Max contrast: %d\n",
+				  alvium->max_contrast);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_CONTRAST_VALUE_INC_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read inc contrast reg\n");
+		return ret;
+	}
+
+	alvium->inc_contrast = (u32)tmp;
+	dev_dbg(dev, "Inc contrast: %d\n",
+				  alvium->inc_contrast);
+
+	return 0;
+}
+
+static int alvium_get_saturation_params(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_SATURATION_MIN_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read min saturation reg\n");
+		return ret;
+	}
+
+	alvium->min_sat = (u32)tmp;
+	dev_dbg(dev, "Min saturation: %d\n",
+				  alvium->min_sat);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_SATURATION_MAX_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read max saturation reg\n");
+		return ret;
+	}
+
+	alvium->max_sat = (u32)tmp;
+	dev_dbg(dev, "Max saturation: %d\n",
+				  alvium->max_sat);
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_SATURATION_INC_32R,
+				  4, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read max saturation reg\n");
+		return ret;
+	}
+
+	alvium->inc_sat = (u32)tmp;
+	dev_dbg(dev, "Inc saturation: %d\n",
+				  alvium->inc_sat);
+
+	return 0;
+}
+
+static int alvium_set_bcm_mode(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_i2c_write_reg(alvium,
+				  REG_GENCP_CHANGEMODE_8W,
+				  1, ALVIUM_BCM_MODE);
+	if (ret) {
+		dev_err(dev, "Fail to current mode reg\n");
+		return ret;
+	}
+
+	alvium->bcrm_mode = ALVIUM_BCM_MODE;
+	dev_dbg(dev, "Set BCM mode");
+
+	return 0;
+}
+
+static int alvium_get_mode(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 bcrm_mode;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  REG_GENCP_CURRENTMODE_8R,
+				  1, &bcrm_mode);
+	if (ret) {
+		dev_err(dev, "Fail to read current mode reg\n");
+		return ret;
+	}
+
+	switch (bcrm_mode) {
+	case ALVIUM_BCM_MODE:
+		alvium->bcrm_mode = ALVIUM_BCM_MODE;
+		break;
+	case ALVIUM_GENCP_MODE:
+		alvium->bcrm_mode = ALVIUM_GENCP_MODE;
+		break;
+	}
+
+	dev_dbg(dev, "Current mode is: %d\n", alvium->bcrm_mode);
+	return 0;
+}
+
+static int alvium_get_avail_mipi_data_format(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	alvium_avail_mipi_fmt_t *avail_fmt;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_AVAILABLE_MIPI_DATA_FORMATS_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "available mipi data format reg\n");
+		return ret;
+	}
+
+	avail_fmt = (alvium_avail_mipi_fmt_t *) &tmp;
+
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8_LEG]
+				  = avail_fmt->yuv420_8_leg;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8]
+				  = avail_fmt->yuv420_8;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_10]
+				  = avail_fmt->yuv420_10;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8_CSPS]
+				  = avail_fmt->yuv420_8_csps;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_10_CSPS]
+				  = avail_fmt->yuv420_10_csps;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV422_8]
+				  = avail_fmt->yuv422_8;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV422_10]
+				  = avail_fmt->yuv422_10;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB888]
+				  = avail_fmt->rgb888;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB666]
+				  = avail_fmt->rgb666;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB565]
+				  = avail_fmt->rgb565;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB555]
+				  = avail_fmt->rgb555;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB444]
+				  = avail_fmt->rgb444;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW6]
+				  = avail_fmt->raw6;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW7]
+				  = avail_fmt->raw7;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW8]
+				  = avail_fmt->raw8;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW10]
+				  = avail_fmt->raw10;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW12]
+				  = avail_fmt->raw12;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW14]
+				  = avail_fmt->raw14;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_JPEG]
+				  = avail_fmt->jpeg;
+
+	alvium_print_avail_mipi_fmt(alvium);
+
+	return 0;
+}
+
+static int alvium_setup_mipi_fmt(struct alvium_dev *alvium)
+{
+	int sz = 0;
+	int fmt = 0;
+	int avail_fmt_cnt = 0;
+
+	alvium->alvium_csi2_fmt = NULL;
+
+	/* calculate fmt array size */
+	for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
+		if (alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit]) {
+			if (!alvium_csi2_fmts[fmt].is_raw) {
+				sz++;
+			} else if (alvium_csi2_fmts[fmt].is_raw &&
+			      alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]) {
+				sz++;
+			}
+		}
+	}
+
+	/* init alvium_csi2_fmt array */
+	alvium->alvium_csi2_fmt_n = sz;
+	alvium->alvium_csi2_fmt = kmalloc((
+						     sizeof(struct alvium_pixfmt) * sz),
+						     GFP_KERNEL);
+
+	/* Create the alvium_csi2 fmt array from formats available */
+	for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
+		if (alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit]) {
+			if (!alvium_csi2_fmts[fmt].is_raw) {
+				alvium->alvium_csi2_fmt[avail_fmt_cnt] =
+					alvium_csi2_fmts[fmt];
+				avail_fmt_cnt++;
+			} else if (alvium_csi2_fmts[fmt].is_raw &&
+			      alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]) {
+				alvium->alvium_csi2_fmt[avail_fmt_cnt] =
+					alvium_csi2_fmts[fmt];
+				avail_fmt_cnt++;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int alvium_set_mipi_fmt(struct alvium_dev *alvium,
+				  const struct alvium_pixfmt *pixfmt)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	u64 reg_val;
+	int ret;
+
+	reg_val = pixfmt->mipi_fmt_regval;
+
+	ret = alvium_i2c_write_reg_hshake(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_MIPI_DATA_FORMAT_32RW,
+				  4, reg_val);
+	if (ret) {
+		dev_err(dev, "Fail to set mipi fmt\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_get_avail_bayer(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	alvium_avail_bayer_t *avail_bay;
+	int ret;
+	u64 tmp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_BAYER_PATTERN_INQUIRY_8R,
+				  1, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read available Bayer patterns reg\n");
+		return ret;
+	}
+
+	avail_bay = (alvium_avail_bayer_t *) &tmp;
+
+	alvium->is_bay_avail[ALVIUM_BIT_BAY_MONO] = avail_bay->mono;
+	alvium->is_bay_avail[ALVIUM_BIT_BAY_GR] = avail_bay->gr;
+	alvium->is_bay_avail[ALVIUM_BIT_BAY_RG] = avail_bay->rg;
+	alvium->is_bay_avail[ALVIUM_BIT_BAY_GB] = avail_bay->gb;
+	alvium->is_bay_avail[ALVIUM_BIT_BAY_BG] = avail_bay->bg;
+
+	alvium_print_avail_bayer(alvium);
+
+	return 0;
+}
+
+static int alvium_set_bayer_pattern(struct alvium_dev *alvium,
+				  const struct alvium_pixfmt *pixfmt)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	u64 reg_val;
+	int ret;
+
+	reg_val = pixfmt->bay_fmt_regval;
+
+	ret = alvium_i2c_write_reg_hshake(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_IMG_BAYER_PATTERN_8RW,
+				  1, reg_val);
+	if (ret) {
+		dev_err(dev, "Fail to set bayer pattern\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_get_frame_interval(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 tmp;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_ACQUISITION_FRAME_RATE_MIN_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read min frame rate reg\n");
+		return ret;
+	}
+
+	alvium->min_fr = tmp;
+
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_ACQUISITION_FRAME_RATE_MAX_64R,
+				  8, &tmp);
+	if (ret) {
+		dev_err(dev, "Fail to read max frame rate reg\n");
+		return ret;
+	}
+
+	alvium->max_fr = tmp;
+
+	dev_dbg(dev, "framerate min: %llu µHz, max: %llu µHz\n",
+				  alvium->min_fr, alvium->max_fr);
+	return 0;
+}
+
+static int alvium_set_frame_rate(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 fr;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	fr = alvium->fr;
+
+	ret = alvium_i2c_write_reg_hshake(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_ACQUISITION_FRAME_RATE_64RW,
+				  8, fr);
+	if (ret) {
+		dev_err(dev, "Fail to set frame rate lanes reg\n");
+		return ret;
+	}
+
+	dev_dbg(dev, "set frame rate: %llu us\n", fr);
+
+	return 0;
+}
+
+static int alvium_set_stream_mipi(struct alvium_dev *alvium, bool on)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	switch (on) {
+	case ALVIUM_STREAM_ON:
+		ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_ACQUISITION_START_8RW,
+					1, 0x01);
+		break;
+	case ALVIUM_STREAM_OFF:
+		ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_ACQUISITION_STOP_8RW,
+					1, 0x01);
+		break;
+	}
+
+	if (ret) {
+		dev_err(dev, "Fail set_stream_mipi\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_get_gain(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 gain;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	if (!alvium->avail_ft.auto_gain)
+		return -EINVAL;
+
+	/* The unit is millibel (1 mB = 0.01 dB) */
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_GAIN_64RW,
+				  8, &gain);
+	if (ret) {
+		dev_err(dev, "Fail to read gain value reg\n");
+		return ret;
+	}
+
+	return gain;
+}
+
+static int alvium_set_gain(struct alvium_dev *alvium, int gain)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	if (!alvium->avail_ft.auto_gain)
+		return -EINVAL;
+
+	/* The unit is millibel (1 mB = 0.01 dB) */
+	ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_GAIN_64RW,
+					8, (u64)gain);
+	if (ret) {
+		dev_err(dev, "Fail to set gain value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_autogain(struct alvium_dev *alvium, bool on)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	if (!alvium->avail_ft.auto_gain)
+		return -EINVAL;
+
+	switch (on) {
+	case ALVIUM_AUTOGAIN_ON:
+		ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_GAIN_AUTO_8RW,
+					1, 0x02);
+		break;
+	case ALVIUM_AUTOGAIN_OFF:
+		ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_GAIN_AUTO_8RW,
+					1, 0x00);
+		break;
+	}
+
+	if (ret) {
+		dev_err(dev, "Fail to set autogain reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_get_exposure(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+	u64 exp;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	if (!alvium->avail_ft.auto_exp)
+		return -EINVAL;
+
+	/* Exposure time in ns */
+	ret = alvium_i2c_read_reg(alvium,
+				  alvium->bcrm_addr +
+				  REG_BCRM_EXPOSURE_TIME_64RW,
+				  8, &exp);
+	if (ret) {
+		dev_err(dev, "Fail to read exposure value reg\n");
+		return ret;
+	}
+
+	return exp;
+}
+
+static int alvium_set_autoexposure(struct alvium_dev *alvium, bool on)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	if (!alvium->avail_ft.auto_exp)
+		return -EINVAL;
+
+	switch (on) {
+	case ALVIUM_AUTOEXPOSURE_ON:
+		ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_EXPOSURE_AUTO_8RW,
+					1, 0x02);
+		break;
+	case ALVIUM_AUTOEXPOSURE_OFF:
+		ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_EXPOSURE_AUTO_8RW,
+					1, 0x00);
+		break;
+	}
+
+	if (ret) {
+		dev_err(dev, "Fail to set autoexposure reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_exposure(struct alvium_dev *alvium, int exposure_ns)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_EXPOSURE_TIME_64RW,
+					8, (u64)exposure_ns);
+	if (ret) {
+		dev_err(dev, "Fail to set exposure value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_gain(struct alvium_dev *alvium, bool auto_gain)
+{
+	struct alvium_ctrls *ctrls = &alvium->ctrls;
+	int ret = 0;
+
+	if (ctrls->auto_gain->is_new) {
+		ret = alvium_set_autogain(alvium, auto_gain);
+		if (ret)
+			return ret;
+	}
+
+	if (!auto_gain && ctrls->gain->is_new) {
+		u64 max_gain;
+		u64 min_gain;
+
+		ret = alvium_get_gain_params(alvium);
+		if (ret)
+			return ret;
+
+		max_gain = alvium->max_gain;
+		min_gain = alvium->min_gain;
+
+		if (ctrls->gain->val >= min_gain &&
+			  ctrls->gain->val <= max_gain) {
+			ret = alvium_set_gain(alvium, ctrls->gain->val);
+		} else {
+			return -EINVAL;
+		}
+	}
+
+	return ret;
+}
+
+static int alvium_set_blue_balance_ratio(struct alvium_dev *alvium,
+				    int blue)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_BLUE_BALANCE_RATIO_64RW,
+					8, (u64)blue);
+	if (ret) {
+		dev_err(dev, "Fail to set blue ratio value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_red_balance_ratio(struct alvium_dev *alvium,
+				    int red)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_RED_BALANCE_RATIO_64RW,
+					8, (u64)red);
+	if (ret) {
+		dev_err(dev, "Fail to set red ratio value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_awb(struct alvium_dev *alvium, bool on)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	if (!alvium->avail_ft.auto_whiteb)
+		return -EINVAL;
+
+	switch (on) {
+	case ALVIUM_AWB_ON:
+		ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_WHITE_BALANCE_AUTO_8RW,
+					1, 0x02);
+		break;
+	case ALVIUM_AWB_OFF:
+		ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_WHITE_BALANCE_AUTO_8RW,
+					1, 0x00);
+		break;
+	}
+
+	if (ret) {
+		dev_err(dev, "Fail to set awb reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_exposure(struct alvium_dev *alvium,
+				    enum v4l2_exposure_auto_type auto_exposure)
+{
+	struct alvium_ctrls *ctrls = &alvium->ctrls;
+	bool auto_exp = (auto_exposure == V4L2_EXPOSURE_AUTO);
+	int ret = 0;
+
+	if (ctrls->auto_exp->is_new) {
+		ret = alvium_set_autoexposure(alvium, auto_exp);
+		if (ret)
+			return ret;
+	}
+
+	if (!auto_exp && ctrls->exposure->is_new) {
+		u64 max_exp;
+		u64 min_exp;
+
+		ret = alvium_get_exposure_params(alvium);
+		if (ret)
+			return ret;
+
+		max_exp = alvium->max_exp;
+		min_exp = alvium->min_exp;
+
+		if (ctrls->exposure->val >= min_exp &&
+			  ctrls->exposure->val <= max_exp) {
+			ret = alvium_set_exposure(alvium, ctrls->exposure->val);
+			if (ret)
+				return ret;
+		} else {
+			return -EINVAL;
+		}
+	}
+
+	return ret;
+}
+
+static int alvium_set_ctrl_white_balance(struct alvium_dev *alvium,
+				    bool awb)
+{
+	struct alvium_ctrls *ctrls = &alvium->ctrls;
+	int ret = 0;
+
+	if (ctrls->auto_wb->is_new) {
+		ret = alvium_set_awb(alvium, awb);
+		if (ret)
+			return ret;
+	}
+
+	if (!awb && ctrls->auto_wb->is_new) {
+		u64 red = (u64)ctrls->red_balance->val;
+		u64 blue = (u64)ctrls->blue_balance->val;
+		u64 red_max;
+		u64 red_min;
+		u64 blue_max;
+		u64 blue_min;
+
+		ret = alvium_get_red_balance_ratio_params(alvium);
+		if (ret)
+			return ret;
+
+		ret = alvium_get_blue_balance_ratio_params(alvium);
+		if (ret)
+			return ret;
+
+		red_max = alvium->max_rbalance;
+		red_min = alvium->min_rbalance;
+		blue_max = alvium->max_bbalance;
+		blue_min = alvium->min_rbalance;
+
+		ret = alvium_set_red_balance_ratio(alvium, red);
+		if (ret)
+			return ret;
+
+		ret = alvium_set_blue_balance_ratio(alvium, blue);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int alvium_set_ctrl_hue(struct alvium_dev *alvium, int val)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_HUE_32RW,
+					4, (u64)val);
+	if (ret) {
+		dev_err(dev, "Fail to set hue value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_contrast(struct alvium_dev *alvium, int val)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_CONTRAST_VALUE_32RW,
+					4, (u64)val);
+	if (ret) {
+		dev_err(dev, "Fail to set contrast value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_saturation(struct alvium_dev *alvium, int val)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_SATURATION_32RW,
+					4, (u64)val);
+	if (ret) {
+		dev_err(dev, "Fail to set contrast value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_gamma(struct alvium_dev *alvium, int val)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_GAMMA_64RW,
+					8, (u64)val);
+	if (ret) {
+		dev_err(dev, "Fail to set gamma value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_sharpness(struct alvium_dev *alvium, int val)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_SHARPNESS_32RW,
+					4, (u64)val);
+	if (ret) {
+		dev_err(dev, "Fail to set sharpness value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_hflip(struct alvium_dev *alvium, int val)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_IMG_REVERSE_X_8RW,
+					1, (u64)val);
+	if (ret) {
+		dev_err(dev, "Fail to set reverse_x value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_vflip(struct alvium_dev *alvium, int val)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	if (!alvium->bcrm_addr)
+		return -EINVAL;
+
+	ret = alvium_i2c_write_reg_hshake(alvium,
+					alvium->bcrm_addr +
+					REG_BCRM_IMG_REVERSE_Y_8RW,
+					1, (u64)val);
+	if (ret) {
+		dev_err(dev, "Fail to set reverse_y value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_get_hw_features_params(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_get_csi_clk_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read min/max csi clock regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_img_width_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read img width regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_img_height_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read img heigth regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_offx_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read offx regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_offy_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read offy regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_gain_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read gain regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_exposure_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read min/max exp regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_red_balance_ratio_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read red balance ratio regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_blue_balance_ratio_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read blue balance ratio regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_hue_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read hue regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_contrast_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read contrast regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_saturation_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read saturation regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_black_lvl_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read black lvl regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_gamma_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read gamma regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_sharpness_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read sharpness regs\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_get_hw_info(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	mutex_lock(&alvium->lock);
+
+	ret = alvium_get_bcrm_vers(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read bcrm version reg\n");
+		return ret;
+	}
+
+	ret = alvium_get_bcrm_addr(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to bcrm address reg\n");
+		return ret;
+	}
+
+	ret = alvium_get_fw_vers(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read fw version reg\n");
+		return ret;
+	}
+
+	ret = alvium_get_host_supp_csi_lanes(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read host supported csi lanes reg\n");
+		return ret;
+	}
+
+	ret = alvium_get_feat_inq(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read bcrm feature inquiry reg\n");
+		return ret;
+	}
+
+	ret = alvium_get_hw_features_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read features params regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_avail_mipi_data_format(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read available mipi data formats reg\n");
+		return ret;
+	}
+
+	ret = alvium_get_avail_bayer(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read available Bayer patterns reg\n");
+		return ret;
+	}
+
+	ret = alvium_get_mode(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to get current mode reg\n");
+		return ret;
+	}
+
+	mutex_unlock(&alvium->lock);
+	return 0;
+}
+
+static int alvium_hw_init(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	mutex_lock(&alvium->lock);
+
+	/* Set Alvium BCM mode*/
+	ret = alvium_set_bcm_mode(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to set BCM mode\n");
+		return ret;
+	}
+
+	ret = alvium_set_csi_lanes(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to set csi lanes\n");
+		return ret;
+	}
+
+	ret = alvium_set_csi_clk(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to set csi lanes\n");
+		return ret;
+	}
+
+	ret = alvium_set_streamon_delay(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to set streamon reg\n");
+		return ret;
+	}
+
+	mutex_unlock(&alvium->lock);
+
+	return 0;
+}
+
+/* --------------- Subdev Operations --------------- */
+
+static struct v4l2_rect *
+__alvium_get_pad_crop(struct alvium_dev *alvium,
+		      struct v4l2_subdev_state *state,
+		      unsigned int pad, enum v4l2_subdev_format_whence which)
+{
+	switch (which) {
+	case V4L2_SUBDEV_FORMAT_TRY:
+		return v4l2_subdev_get_try_crop(&alvium->sd, state, pad);
+	case V4L2_SUBDEV_FORMAT_ACTIVE:
+		return &alvium->mode.crop;
+	}
+
+	return NULL;
+}
+
+static struct v4l2_mbus_framefmt *
+__alvium_get_pad_format(struct alvium_dev *alvium,
+			struct v4l2_subdev_state *state,
+			unsigned int pad, enum v4l2_subdev_format_whence which)
+{
+	switch (which) {
+	case V4L2_SUBDEV_FORMAT_TRY:
+		return v4l2_subdev_get_try_format(&alvium->sd, state, pad);
+	case V4L2_SUBDEV_FORMAT_ACTIVE:
+		return &alvium->mode.fmt;
+	default:
+		return NULL;
+	}
+}
+
+static int alvium_g_frame_interval(struct v4l2_subdev *sd,
+				   struct v4l2_subdev_frame_interval *fi)
+{
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+
+	mutex_lock(&alvium->lock);
+	fi->interval = alvium->frame_interval;
+	mutex_unlock(&alvium->lock);
+
+	return 0;
+}
+
+static int alvium_set_frame_interval(struct alvium_dev *alvium,
+					struct v4l2_subdev_frame_interval *fi)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	u64 req_fr, min_fr, max_fr;
+	int ret;
+
+	if (fi->interval.denominator == 0)
+		return -EINVAL;
+
+	ret = alvium_get_frame_interval(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to get frame interval\n");
+		return ret;
+	}
+
+	min_fr = alvium->min_fr;
+	max_fr = alvium->max_fr;
+
+	dev_dbg(dev, "fi->interval.numerator = %d\n",
+		  fi->interval.numerator);
+	dev_dbg(dev, "fi->interval.denominator = %d\n",
+		  fi->interval.denominator);
+
+	req_fr = (fi->interval.denominator * ALVIUM_HZ_TO_UHZ) /
+				  fi->interval.numerator;
+
+	if (req_fr >= alvium->max_fr &&
+		  req_fr <= alvium->min_fr)
+		return -EINVAL;
+
+	alvium->fr = req_fr;
+	alvium->frame_interval.numerator = fi->interval.numerator;
+	alvium->frame_interval.denominator = fi->interval.denominator;
+
+	return 0;
+}
+
+static int alvium_s_frame_interval(struct v4l2_subdev *sd,
+				   struct v4l2_subdev_frame_interval *fi)
+{
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	int ret;
+
+	if (fi->pad != 0)
+		return -EINVAL;
+
+	if (alvium->streaming)
+		return -EBUSY;
+
+	mutex_lock(&alvium->lock);
+
+	ret = alvium_set_frame_interval(alvium, fi);
+	if (!ret) {
+		ret = alvium_set_frame_rate(alvium);
+		if (ret)
+			return -EIO;
+	}
+
+	mutex_unlock(&alvium->lock);
+	return ret;
+}
+
+static int alvium_enum_mbus_code(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_state *sd_state,
+				 struct v4l2_subdev_mbus_code_enum *code)
+{
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	const struct alvium_pixfmt *formats;
+	unsigned int num_formats;
+
+	if (alvium_is_csi2(alvium)) {
+		formats = alvium->alvium_csi2_fmt;
+		num_formats = alvium->alvium_csi2_fmt_n;
+	}
+
+	if (code->index >= num_formats)
+		return -EINVAL;
+
+	code->code = formats[code->index].code;
+
+	return 0;
+}
+
+static const struct alvium_pixfmt *
+alvium_code_to_pixfmt(struct alvium_dev *alvium, u32 code)
+{
+	const struct alvium_pixfmt *formats = alvium->alvium_csi2_fmt;
+	unsigned int i;
+
+	for (i = 0; formats[i].code; ++i) {
+		if (formats[i].code == code)
+			return &formats[i];
+	}
+
+	return &formats[0];
+}
+
+static int alvium_set_mode(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	struct alvium_mode *current_mode = &alvium->mode;
+	int ret;
+
+	if (current_mode->width < alvium->img_max_width &&
+		   current_mode->width > alvium->img_min_width) {
+		ret = alvium_set_img_width(alvium, current_mode->width);
+		if (ret)
+			return ret;
+	} else {
+		dev_err(dev, "Unsupported width");
+		return -EINVAL;
+	}
+
+	if (current_mode->height < alvium->img_max_height &&
+		   current_mode->height > alvium->img_min_height) {
+		ret = alvium_set_img_height(alvium, current_mode->height);
+		if (ret)
+			return ret;
+	} else {
+		dev_err(dev, "Unsupported height");
+		return -EINVAL;
+	}
+
+	ret = alvium_set_img_offx(alvium, current_mode->crop.left);
+	if (ret)
+		return ret;
+
+	ret = alvium_set_img_offy(alvium, current_mode->crop.top);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int alvium_set_framefmt(struct alvium_dev *alvium,
+			       struct v4l2_mbus_framefmt *format)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	const struct alvium_pixfmt *alvium_csi2_fmt;
+	int ret = 0;
+
+	alvium_csi2_fmt = alvium_code_to_pixfmt(alvium, format->code);
+
+	ret = alvium_set_mipi_fmt(alvium, alvium_csi2_fmt);
+	if (ret)
+		return ret;
+
+	if (alvium_csi2_fmt->is_raw) {
+		ret = alvium_set_bayer_pattern(alvium, alvium_csi2_fmt);
+		if (ret)
+			return ret;
+	}
+
+	dev_dbg(dev, "start: %s, mipi_fmt_regval regval = 0x%llx",
+	  __func__, alvium_csi2_fmt->mipi_fmt_regval);
+
+	return ret;
+}
+
+static int alvium_s_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	int ret = 0;
+
+	if (enable) {
+		mutex_lock(&alvium->lock);
+		ret = __v4l2_ctrl_handler_setup(&alvium->ctrls.handler);
+		if (ret)
+			goto out;
+
+		ret = alvium_set_mode(alvium);
+		if (ret)
+			goto out;
+
+		ret = alvium_set_framefmt(alvium, &alvium->mode.fmt);
+		if (ret)
+			goto out;
+
+		if (alvium_is_csi2(alvium))
+			ret = alvium_set_stream_mipi(alvium, enable);
+		mutex_unlock(&alvium->lock);
+	} else {
+		mutex_lock(&alvium->lock);
+		ret = alvium_set_stream_mipi(alvium, enable);
+		if (ret)
+			goto out;
+
+		mutex_unlock(&alvium->lock);
+	}
+
+	alvium->streaming = !!enable;
+	return 0;
+
+out:
+	mutex_unlock(&alvium->lock);
+	return ret;
+}
+
+static int alvium_init_cfg(struct v4l2_subdev *sd,
+			   struct v4l2_subdev_state *state)
+{
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	struct v4l2_mbus_framefmt *fmt =
+				v4l2_subdev_get_try_format(sd, state, 0);
+	struct v4l2_rect *crop = v4l2_subdev_get_try_crop(sd, state, 0);
+	struct alvium_mode *current_mode = &alvium->mode;
+
+	*fmt = alvium_csi2_default_fmt;
+
+	crop->left = current_mode->crop.left;
+	crop->top = current_mode->crop.top;
+	crop->width = current_mode->crop.width;
+	crop->height = current_mode->crop.height;
+
+	return 0;
+}
+
+static int alvium_set_fmt(struct v4l2_subdev *sd,
+			   struct v4l2_subdev_state *sd_state,
+			   struct v4l2_subdev_format *format)
+{
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	struct alvium_mode *current_mode = &alvium->mode;
+	const struct alvium_pixfmt *alvium_csi2_fmt;
+	struct v4l2_mbus_framefmt *fmt;
+	const struct v4l2_rect *crop;
+
+	crop = __alvium_get_pad_crop(alvium, sd_state, format->pad, format->which);
+	fmt = __alvium_get_pad_format(alvium, sd_state, format->pad, format->which);
+
+	if (format->format.width <= alvium->img_max_width &&
+		  format->format.width >= alvium->img_min_width) {
+		current_mode->width = format->format.width;
+	} else {
+		return -EINVAL;
+	}
+
+	if (format->format.height <= alvium->img_max_height &&
+		  format->format.height >= alvium->img_min_height) {
+		current_mode->height = format->format.height;
+	} else {
+		return -EINVAL;
+	}
+
+	alvium_csi2_fmt = alvium_code_to_pixfmt(alvium, format->format.code);
+
+	fmt->code = alvium_csi2_fmt->code;
+	fmt->width = current_mode->width;
+	fmt->height = current_mode->height;
+
+	/* Set also the crop width and height when set a new fmt */
+	current_mode->crop.width = current_mode->width;
+	current_mode->crop.height = current_mode->height;
+
+	format->format = *fmt;
+
+	if (format->which == V4L2_SUBDEV_FORMAT_TRY)
+		return 0;
+
+	return 0;
+}
+
+static int alvium_get_fmt(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_state *sd_state,
+			  struct v4l2_subdev_format *format)
+{
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	struct alvium_mode *current_mode = &alvium->mode;
+
+	format->format = current_mode->fmt;
+	return 0;
+}
+
+static int alvium_set_selection(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *sd_state,
+				struct v4l2_subdev_selection *sel)
+{
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	struct alvium_mode *current_mode = &alvium->mode;
+	struct v4l2_rect *__crop;
+
+	/*
+	 * Alvium can only shift the origin of the img
+	 * then we accept only value with the same value of the actual fmt
+	 */
+	if (sel->r.width != current_mode->width ||
+		  sel->r.height != current_mode->height)
+		return -EINVAL;
+
+	if (sel->target != V4L2_SEL_TGT_CROP)
+		return -EINVAL;
+
+	if ((sel->r.left + sel->r.width) <= alvium->img_max_width)
+		current_mode->crop.left = sel->r.left;
+	else
+		return -EINVAL;
+
+	if ((sel->r.top + sel->r.height) <= alvium->img_max_height)
+		current_mode->crop.top = sel->r.top;
+	else
+		return -EINVAL;
+
+	current_mode->crop.width = sel->r.width;
+	current_mode->crop.height = sel->r.height;
+
+	__crop = __alvium_get_pad_crop(alvium, sd_state, sel->pad, sel->which);
+
+	*__crop = current_mode->crop;
+	sel->r = current_mode->crop;
+
+	return 0;
+}
+
+static int alvium_get_selection(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *sd_state,
+				struct v4l2_subdev_selection *sel)
+{
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+
+	switch (sel->target) {
+	/* Current cropping area */
+	case V4L2_SEL_TGT_CROP:
+		mutex_lock(&alvium->lock);
+		sel->r = *__alvium_get_pad_crop(alvium, sd_state, sel->pad,
+						sel->which);
+		mutex_unlock(&alvium->lock);
+		break;
+	/* Cropping bounds */
+	case V4L2_SEL_TGT_NATIVE_SIZE:
+		sel->r.top = 0;
+		sel->r.left = 0;
+		sel->r.width = alvium->img_max_width;
+		sel->r.height = alvium->img_max_height;
+		break;
+	/* Default cropping area */
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+		sel->r.top = alvium->min_offy;
+		sel->r.left = alvium->min_offx;
+		sel->r.width = alvium->img_max_width;
+		sel->r.height = alvium->img_max_height;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int alvium_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	int val;
+
+	switch (ctrl->id) {
+	case V4L2_CID_AUTOGAIN:
+		val = alvium_get_gain(alvium);
+		if (val < 0)
+			return val;
+		alvium->ctrls.gain->val = val;
+		break;
+	case V4L2_CID_EXPOSURE_AUTO:
+		val = alvium_get_exposure(alvium);
+		if (val < 0)
+			return val;
+		alvium->ctrls.exposure->val = val;
+		break;
+	}
+
+	return 0;
+}
+
+static int alvium_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	int ret;
+
+	switch (ctrl->id) {
+	case V4L2_CID_AUTOGAIN:
+		ret = alvium_set_ctrl_gain(alvium, ctrl->val);
+		break;
+	case V4L2_CID_EXPOSURE_AUTO:
+		ret = alvium_set_ctrl_exposure(alvium, ctrl->val);
+		break;
+	case V4L2_CID_AUTO_WHITE_BALANCE:
+		ret = alvium_set_ctrl_white_balance(alvium, ctrl->val);
+		break;
+	case V4L2_CID_HUE:
+		ret = alvium_set_ctrl_hue(alvium, ctrl->val);
+		break;
+	case V4L2_CID_CONTRAST:
+		ret = alvium_set_ctrl_contrast(alvium, ctrl->val);
+		break;
+	case V4L2_CID_SATURATION:
+		ret = alvium_set_ctrl_saturation(alvium, ctrl->val);
+		break;
+	case V4L2_CID_GAMMA:
+		ret = alvium_set_ctrl_gamma(alvium, ctrl->val);
+		break;
+	case V4L2_CID_SHARPNESS:
+		ret = alvium_set_ctrl_sharpness(alvium, ctrl->val);
+		break;
+	case V4L2_CID_HFLIP:
+		ret = alvium_set_ctrl_hflip(alvium, ctrl->val);
+		break;
+	case V4L2_CID_VFLIP:
+		ret = alvium_set_ctrl_vflip(alvium, ctrl->val);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct v4l2_ctrl_ops alvium_ctrl_ops = {
+	.g_volatile_ctrl = alvium_g_volatile_ctrl,
+	.s_ctrl = alvium_s_ctrl,
+};
+
+static int alvium_init_controls(struct alvium_dev *alvium)
+{
+	const struct v4l2_ctrl_ops *ops = &alvium_ctrl_ops;
+	struct alvium_ctrls *ctrls = &alvium->ctrls;
+	struct v4l2_ctrl_handler *hdl = &ctrls->handler;
+	struct v4l2_fwnode_device_properties props;
+	int ret;
+
+	v4l2_ctrl_handler_init(hdl, 32);
+
+	/* we can use our own mutex for the ctrl lock */
+	hdl->lock = &alvium->lock;
+
+	/* Pixel rate is fixed */
+	ctrls->pixel_rate = v4l2_ctrl_new_std(hdl, ops,
+					     V4L2_CID_PIXEL_RATE, 0,
+					     ALVIUM_DEFAULT_PIXEL_RATE_MHZ, 1,
+					     ALVIUM_DEFAULT_PIXEL_RATE_MHZ);
+
+	/* Link freq is fixed */
+	ctrls->link_freq = v4l2_ctrl_new_int_menu(hdl, ops,
+					     V4L2_CID_LINK_FREQ,
+					     0, 0, &alvium->link_freq);
+
+	/* Auto/manual white balance */
+	if (alvium->avail_ft.auto_whiteb)
+		ctrls->auto_wb = v4l2_ctrl_new_std(hdl, ops,
+					     V4L2_CID_AUTO_WHITE_BALANCE,
+					     0, 1, 1, 1);
+
+	ctrls->blue_balance = v4l2_ctrl_new_std(hdl, ops,
+					     V4L2_CID_BLUE_BALANCE,
+					     alvium->min_bbalance,
+					     alvium->max_bbalance,
+					     alvium->inc_bbalance,
+					     alvium->min_bbalance);
+	ctrls->red_balance = v4l2_ctrl_new_std(hdl, ops,
+					     V4L2_CID_RED_BALANCE,
+					     alvium->min_rbalance,
+					     alvium->max_rbalance,
+					     alvium->inc_rbalance,
+					     alvium->min_rbalance);
+
+	/* Auto/manual exposure */
+	if (alvium->avail_ft.auto_exp)
+		ctrls->auto_exp = v4l2_ctrl_new_std_menu(hdl, ops,
+					     V4L2_CID_EXPOSURE_AUTO,
+					     V4L2_EXPOSURE_MANUAL, 0,
+					     V4L2_EXPOSURE_AUTO);
+
+	ctrls->exposure = v4l2_ctrl_new_std(hdl, ops,
+					     V4L2_CID_EXPOSURE,
+					     alvium->min_exp,
+					     alvium->max_exp,
+					     alvium->inc_exp,
+					     alvium->min_exp);
+
+	/* Auto/manual gain */
+	if (alvium->avail_ft.auto_gain)
+		ctrls->auto_gain = v4l2_ctrl_new_std(hdl, ops,
+					     V4L2_CID_AUTOGAIN,
+					     0, 1, 1, 1);
+
+	if (alvium->avail_ft.gain)
+		ctrls->gain = v4l2_ctrl_new_std(hdl, ops,
+					     V4L2_CID_GAIN,
+					     alvium->min_gain,
+					     alvium->max_gain,
+					     alvium->inc_gain,
+					     alvium->min_gain);
+
+	if (alvium->avail_ft.sat)
+		ctrls->saturation = v4l2_ctrl_new_std(hdl, ops,
+					     V4L2_CID_SATURATION,
+					     alvium->min_sat,
+					     alvium->max_sat,
+					     alvium->inc_sat,
+					     alvium->max_sat);
+
+	if (alvium->avail_ft.hue)
+		ctrls->hue = v4l2_ctrl_new_std(hdl, ops,
+					     V4L2_CID_HUE,
+					     alvium->min_hue,
+					     alvium->max_hue,
+					     alvium->inc_hue,
+					     alvium->min_hue);
+
+	if (alvium->avail_ft.contrast)
+		ctrls->contrast = v4l2_ctrl_new_std(hdl, ops,
+					     V4L2_CID_CONTRAST,
+					     alvium->min_contrast,
+					     alvium->max_contrast,
+					     alvium->inc_contrast,
+					     alvium->min_contrast);
+
+	if (alvium->avail_ft.gamma)
+		ctrls->contrast = v4l2_ctrl_new_std(hdl, ops,
+					     V4L2_CID_GAMMA,
+					     alvium->min_gamma,
+					     alvium->max_gamma,
+					     alvium->inc_gamma,
+					     alvium->min_gamma);
+
+	if (alvium->avail_ft.sharp)
+		ctrls->contrast = v4l2_ctrl_new_std(hdl, ops,
+					     V4L2_CID_SHARPNESS,
+					     alvium->min_sharp,
+					     alvium->max_sharp,
+					     alvium->inc_sharp,
+					     alvium->min_sharp);
+
+	if (alvium->avail_ft.rev_x)
+		ctrls->hflip = v4l2_ctrl_new_std(hdl, ops,
+					     V4L2_CID_HFLIP,
+					     0, 1, 1, 0);
+
+	if (alvium->avail_ft.rev_y)
+		ctrls->vflip = v4l2_ctrl_new_std(hdl, ops,
+					     V4L2_CID_VFLIP,
+					     0, 1, 1, 0);
+
+	if (hdl->error) {
+		ret = hdl->error;
+		goto free_ctrls;
+	}
+
+	ret = v4l2_fwnode_device_parse(&alvium->i2c_client->dev, &props);
+	if (ret)
+		goto free_ctrls;
+
+	if (props.rotation == 180)
+		alvium->upside_down = true;
+
+	ret = v4l2_ctrl_new_fwnode_properties(hdl, ops, &props);
+	if (ret)
+		goto free_ctrls;
+
+	ctrls->pixel_rate->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+	ctrls->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+	ctrls->gain->flags |= V4L2_CTRL_FLAG_VOLATILE;
+	ctrls->exposure->flags |= V4L2_CTRL_FLAG_VOLATILE;
+
+	v4l2_ctrl_auto_cluster(3, &ctrls->auto_wb, 0, false);
+	v4l2_ctrl_auto_cluster(2, &ctrls->auto_gain, 0, true);
+	v4l2_ctrl_auto_cluster(2, &ctrls->auto_exp, 1, true);
+
+	alvium->sd.ctrl_handler = hdl;
+	return 0;
+
+free_ctrls:
+	v4l2_ctrl_handler_free(hdl);
+	return ret;
+}
+
+static int alvium_link_setup(struct media_entity *entity,
+			   const struct media_pad *local,
+			   const struct media_pad *remote, u32 flags)
+{
+	/*
+	 * Return no error:
+	 * For some drivers this media entity operation
+	 * is mandatory.
+	 * TODO: add this media entity operation implementation
+	 */
+	return 0;
+}
+
+static int alvium_s_power(struct v4l2_subdev *sd, int on)
+{
+	/*
+	 * Return no error:
+	 * For some drivers this subdev ops is mandatory.
+	 * TODO: add this subdev_core_ops implementation
+	 */
+	return 0;
+}
+
+static const struct v4l2_subdev_core_ops alvium_core_ops = {
+	.s_power = alvium_s_power,
+	.log_status = v4l2_ctrl_subdev_log_status,
+	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
+	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
+};
+
+static const struct v4l2_subdev_video_ops alvium_video_ops = {
+	.g_frame_interval	= alvium_g_frame_interval,
+	.s_frame_interval	= alvium_s_frame_interval,
+	.s_stream		= alvium_s_stream,
+};
+
+static const struct v4l2_subdev_pad_ops alvium_pad_ops = {
+	.init_cfg = alvium_init_cfg,
+	.enum_mbus_code = alvium_enum_mbus_code,
+	.get_fmt = alvium_get_fmt,
+	.set_fmt = alvium_set_fmt,
+	.get_selection = alvium_get_selection,
+	.set_selection = alvium_set_selection,
+};
+
+static const struct v4l2_subdev_ops alvium_subdev_ops = {
+	.core	= &alvium_core_ops,
+	.pad	= &alvium_pad_ops,
+	.video	= &alvium_video_ops,
+};
+
+static const struct media_entity_operations alvium_sd_media_ops = {
+	.link_setup = alvium_link_setup,
+};
+
+static int alvium_get_dt_data(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	struct device_node *node = dev->of_node;
+	struct fwnode_handle *endpoint;
+	int ret = 0;
+
+	if (!node)
+		return -EINVAL;
+
+	/* get system clock (xclk) */
+	alvium->xclk = devm_clk_get(dev, "xclk");
+	if (IS_ERR(alvium->xclk)) {
+		dev_err(dev, "failed to get xclk\n");
+		return PTR_ERR(alvium->xclk);
+	}
+
+	alvium->xclk_freq = clk_get_rate(alvium->xclk);
+	if (alvium->xclk_freq)
+		dev_err(dev, "xclk frequency: %d Hz\n",
+			alvium->xclk_freq);
+
+	/* request optional power down pin */
+	alvium->pwdn_gpio = devm_gpiod_get_optional(dev, "powerdown",
+						    GPIOD_OUT_HIGH);
+	if (IS_ERR(alvium->pwdn_gpio))
+		return PTR_ERR(alvium->pwdn_gpio);
+
+	/* request optional reset pin */
+	alvium->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						     GPIOD_OUT_HIGH);
+	if (IS_ERR(alvium->reset_gpio))
+		return PTR_ERR(alvium->reset_gpio);
+
+	ret = fwnode_property_read_u32(dev_fwnode(dev), "streamon-delay",
+								   &alvium->streamon_delay);
+	if (ret)
+		dev_info(dev, "streamon-delay not found\n");
+
+	endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
+	if (!endpoint) {
+		dev_err(dev, "endpoint node not found\n");
+		return -EINVAL;
+	}
+
+	if (v4l2_fwnode_endpoint_alloc_parse(endpoint, &alvium->ep)) {
+		dev_err(dev, "could not parse endpoint\n");
+		return 0;
+	}
+
+	if (alvium->ep.bus_type != V4L2_MBUS_CSI2_DPHY) {
+		dev_err(dev, "unsupported bus type\n");
+		return -EINVAL;
+	}
+
+	if (!alvium->ep.nr_of_link_frequencies) {
+		dev_err(dev, "no link frequencies defined");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "number of link frequencies rate: %d\n",
+						    alvium->ep.nr_of_link_frequencies);
+	dev_dbg(dev, "link frequencies rate: %llu\n",
+						    alvium->ep.link_frequencies[0]);
+	dev_dbg(dev, "csi data lanes number: %d\n",
+						    alvium->ep.bus.mipi_csi2.num_data_lanes);
+
+	return 0;
+}
+
+static int alvium_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct v4l2_subdev *sd;
+	struct alvium_dev *alvium;
+	int ret;
+
+	alvium = devm_kzalloc(dev, sizeof(*alvium), GFP_KERNEL);
+	if (!alvium)
+		return -ENOMEM;
+
+	alvium->i2c_client = client;
+	ret = alvium_get_dt_data(alvium);
+	if (ret)
+		return ret;
+
+	mutex_init(&alvium->lock);
+
+	sd = &alvium->sd;
+
+	/* init alvium sd */
+	v4l2_i2c_subdev_init(sd, client, &alvium_subdev_ops);
+
+	sd->flags |= V4L2_SUBDEV_FL_HAS_EVENTS | V4L2_SUBDEV_FL_HAS_DEVNODE;
+	alvium->pad.flags = MEDIA_PAD_FL_SOURCE;
+	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
+	sd->entity.ops = &alvium_sd_media_ops;
+
+	ret = media_entity_pads_init(&sd->entity, 1, &alvium->pad);
+	if (ret)
+		return ret;
+
+	sd->dev = dev;
+
+	ret = alvium_power_on(alvium);
+	if (ret)
+		goto entity_cleanup;
+
+	ret = alvium_get_hw_info(alvium);
+	if (ret) {
+		dev_err(dev, "Device detection failed: %d\n", ret);
+		goto err_poweroff;
+	}
+
+	ret = alvium_hw_init(alvium);
+	if (ret) {
+		dev_err(dev, "hw_init fail %d\n", ret);
+		goto entity_cleanup;
+	}
+
+	ret = alvium_setup_mipi_fmt(alvium);
+	if (ret) {
+		dev_err(dev, "hw_init fail %d\n", ret);
+		goto entity_cleanup;
+	}
+
+	/* Setup initial frame interval*/
+	alvium->frame_interval.numerator = 1;
+	alvium->frame_interval.denominator = ALVIUM_DEFAULT_FR_HZ;
+	alvium->fr = ALVIUM_DEFAULT_FR_HZ;
+
+	/* Setup the initial mode */
+	alvium->mode.fmt = alvium_csi2_default_fmt;
+	alvium->mode.width = alvium_csi2_default_fmt.width;
+	alvium->mode.height = alvium_csi2_default_fmt.height;
+	alvium->mode.crop.left = alvium->min_offx;
+	alvium->mode.crop.top = alvium->min_offy;
+	alvium->mode.crop.width = alvium_csi2_default_fmt.width;
+	alvium->mode.crop.height = alvium_csi2_default_fmt.height;
+
+	ret = alvium_init_controls(alvium);
+	if (ret)
+		goto entity_cleanup;
+
+	ret = v4l2_async_register_subdev_sensor(sd);
+	if (ret) {
+		dev_err(dev,
+			"failed to register async subdev: %d", ret);
+		goto entity_cleanup;
+	}
+
+	v4l2_info(sd, "%s: completed successfully\n", __func__);
+	return 0;
+
+err_poweroff:
+	alvium_power_off(alvium);
+entity_cleanup:
+	media_entity_cleanup(&sd->entity);
+	mutex_destroy(&alvium->lock);
+	return ret;
+}
+
+static void alvium_remove(struct i2c_client *client)
+{
+	struct alvium_dev *dev = i2c_to_alvium(client);
+
+	i2c_unregister_device(dev->i2c_client);
+}
+
+static const struct i2c_device_id alvium_id[] = {
+	{"alvium", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, alvium_id);
+
+static const struct of_device_id alvium_of_ids[] = {
+	{ .compatible = "alliedvision,alvium", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, alvium_of_ids);
+
+static struct i2c_driver alvium_i2c_driver = {
+	.driver	= {
+		.name	= "alvium",
+		.of_match_table = alvium_of_ids,
+	},
+	.id_table = alvium_id,
+	.probe_new	= alvium_probe,
+	.remove		= alvium_remove,
+};
+
+module_i2c_driver(alvium_i2c_driver);
+
+MODULE_DESCRIPTION("Allied Vision's Alvium Camera Driver");
+MODULE_AUTHOR("Tommaso Merciai <tomm.merciai@gmail.com>");
+MODULE_AUTHOR("Martin Hecht <martin.hecht@avnet.eu>");
+MODULE_AUTHOR("Avnet Silica Software & Services EMEA");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/media/i2c/alvium.h b/drivers/media/i2c/alvium.h
new file mode 100644
index 000000000000..c363bbd822dd
--- /dev/null
+++ b/drivers/media/i2c/alvium.h
@@ -0,0 +1,500 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Allied Vision Inc. Alvium camera driver
+ *
+ * Copyright (C) 2023 Tommaso Merciai
+ * Copyright (C) 2023 Martin Hecht
+ * Copyright (C) 2023 Avnet EMG GmbH
+ */
+
+#ifndef ALVIUM_H_
+#define ALVIUM_H_
+
+#include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/regulator/consumer.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-subdev.h>
+
+#define ALVIUM_HZ_TO_UHZ 1000000UL
+
+#define ALVIUM_STREAM_ON true
+#define ALVIUM_STREAM_OFF false
+#define ALVIUM_AUTOGAIN_ON true
+#define ALVIUM_AUTOGAIN_OFF false
+#define ALVIUM_AUTOEXPOSURE_ON true
+#define ALVIUM_AUTOEXPOSURE_OFF false
+#define ALVIUM_AWB_ON true
+#define ALVIUM_AWB_OFF false
+
+/* BCRM register offsets */
+#define REG_BCRM_VERSION_32R                           0x0000
+#define REG_BCRM_FEATURE_INQUIRY_64R                   0x0008
+#define REG_BCRM_DEVICE_FIRMWARE_VERSION_64R           0x0010
+#define REG_BCRM_REG_ADDR_16R                          0x0014
+#define REG_BCRM_WRITE_HANDSHAKE_8RW                   0x0018
+
+/* Streaming Control Registers */
+#define REG_BCRM_SUPPORTED_CSI2_LANE_COUNTS_8R         0x0040
+#define REG_BCRM_CSI2_LANE_COUNT_8RW                   0x0044
+#define REG_BCRM_CSI2_CLOCK_MIN_32R                    0x0048
+#define REG_BCRM_CSI2_CLOCK_MAX_32R                    0x004C
+#define REG_BCRM_CSI2_CLOCK_32RW                       0x0050
+#define REG_BCRM_BUFFER_SIZE_32R                       0x0054
+
+#define REG_BCRM_IPU_X_MIN_32W                         0x0058
+#define REG_BCRM_IPU_X_MAX_32W                         0x005C
+#define REG_BCRM_IPU_X_INC_32W                         0x0060
+#define REG_BCRM_IPU_Y_MIN_32W                         0x0064
+#define REG_BCRM_IPU_Y_MAX_32W                         0x0068
+#define REG_BCRM_IPU_Y_INC_32W                         0x006C
+#define REG_BCRM_IPU_X_32R                             0x0070
+#define REG_BCRM_IPU_Y_32R                             0x0074
+
+#define REG_BCRM_PHY_RESET_8RW                         0x0078
+#define REG_BCRM_STREAM_ON_DELAY_32RW                  0x007C
+
+/* Acquisition Control Registers */
+#define REG_BCRM_ACQUISITION_START_8RW                 0x0080
+#define REG_BCRM_ACQUISITION_STOP_8RW                  0x0084
+#define REG_BCRM_ACQUISITION_ABORT_8RW                 0x0088
+#define REG_BCRM_ACQUISITION_STATUS_8R                 0x008C
+#define REG_BCRM_ACQUISITION_FRAME_RATE_64RW           0x0090
+#define REG_BCRM_ACQUISITION_FRAME_RATE_MIN_64R        0x0098
+#define REG_BCRM_ACQUISITION_FRAME_RATE_MAX_64R        0x00A0
+#define REG_BCRM_ACQUISITION_FRAME_RATE_INC_64R        0x00A8
+#define REG_BCRM_ACQUISITION_FRAME_RATE_ENABLE_8RW     0x00B0
+
+#define REG_BCRM_FRAME_START_TRIGGER_MODE_8RW          0x00B4
+#define REG_BCRM_FRAME_START_TRIGGER_SOURCE_8RW        0x00B8
+#define REG_BCRM_FRAME_START_TRIGGER_ACTIVATION_8RW    0x00BC
+#define REG_BCRM_FRAME_START_TRIGGER_SOFTWARE_8W       0x00C0
+#define REG_BCRM_FRAME_START_TRIGGER_DELAY_32RW        0x00C4
+#define REG_BCRM_EXPOSURE_ACTIVE_LINE_MODE_8RW         0x00C8
+#define REG_BCRM_EXPOSURE_ACTIVE_LINE_SELECTOR_8RW     0x00CC
+#define REG_BCRM_LINE_CONFIGURATION_32RW               0x00D0
+
+#define REG_BCRM_IMG_WIDTH_32RW                        0x0100
+#define REG_BCRM_IMG_WIDTH_MIN_32R                     0x0104
+#define REG_BCRM_IMG_WIDTH_MAX_32R                     0x0108
+#define REG_BCRM_IMG_WIDTH_INC_32R                     0x010C
+
+#define REG_BCRM_IMG_HEIGHT_32RW                       0x0110
+#define REG_BCRM_IMG_HEIGHT_MIN_32R                    0x0114
+#define REG_BCRM_IMG_HEIGHT_MAX_32R                    0x0118
+#define REG_BCRM_IMG_HEIGHT_INC_32R                    0x011C
+
+#define REG_BCRM_IMG_OFFSET_X_32RW                     0x0120
+#define REG_BCRM_IMG_OFFSET_X_MIN_32R                  0x0124
+#define REG_BCRM_IMG_OFFSET_X_MAX_32R                  0x0128
+#define REG_BCRM_IMG_OFFSET_X_INC_32R                  0x012C
+
+#define REG_BCRM_IMG_OFFSET_Y_32RW                     0x0130
+#define REG_BCRM_IMG_OFFSET_Y_MIN_32R                  0x0134
+#define REG_BCRM_IMG_OFFSET_Y_MAX_32R                  0x0138
+#define REG_BCRM_IMG_OFFSET_Y_INC_32R                  0x013C
+
+#define REG_BCRM_IMG_MIPI_DATA_FORMAT_32RW             0x0140
+#define REG_BCRM_IMG_AVAILABLE_MIPI_DATA_FORMATS_64R   0x0148
+#define REG_BCRM_IMG_BAYER_PATTERN_INQUIRY_8R          0x0150
+#define REG_BCRM_IMG_BAYER_PATTERN_8RW                 0x0154
+#define REG_BCRM_IMG_REVERSE_X_8RW                     0x0158
+#define REG_BCRM_IMG_REVERSE_Y_8RW                     0x015C
+
+#define REG_BCRM_SENSOR_WIDTH_32R                      0x0160
+#define REG_BCRM_SENSOR_HEIGHT_32R                     0x0164
+#define REG_BCRM_WIDTH_MAX_32R                         0x0168
+#define REG_BCRM_HEIGHT_MAX_32R                        0x016C
+
+#define REG_BCRM_EXPOSURE_TIME_64RW                    0x0180
+#define REG_BCRM_EXPOSURE_TIME_MIN_64R                 0x0188
+#define REG_BCRM_EXPOSURE_TIME_MAX_64R                 0x0190
+#define REG_BCRM_EXPOSURE_TIME_INC_64R                 0x0198
+#define REG_BCRM_EXPOSURE_AUTO_8RW                     0x01A0
+
+#define REG_BCRM_INTENSITY_AUTO_PRECEDENCE_8RW         0x01A4
+#define REG_BCRM_INTENSITY_AUTO_PRECEDENCE_VALUE_32RW  0x01A8
+#define REG_BCRM_INTENSITY_AUTO_PRECEDENCE_MIN_32R     0x01AC
+#define REG_BCRM_INTENSITY_AUTO_PRECEDENCE_MAX_32R     0x01B0
+#define REG_BCRM_INTENSITY_AUTO_PRECEDENCE_INC_32R     0x01B4
+
+#define REG_BCRM_BLACK_LEVEL_32RW                      0x01B8
+#define REG_BCRM_BLACK_LEVEL_MIN_32R                   0x01BC
+#define REG_BCRM_BLACK_LEVEL_MAX_32R                   0x01C0
+#define REG_BCRM_BLACK_LEVEL_INC_32R                   0x01C4
+
+#define REG_BCRM_GAIN_64RW                             0x01C8
+#define REG_BCRM_GAIN_MIN_64R                          0x01D0
+#define REG_BCRM_GAIN_MAX_64R                          0x01D8
+#define REG_BCRM_GAIN_INC_64R                          0x01E0
+#define REG_BCRM_GAIN_AUTO_8RW                         0x01E8
+
+#define REG_BCRM_GAMMA_64RW                            0x01F0
+#define REG_BCRM_GAMMA_MIN_64R                         0x01F8
+#define REG_BCRM_GAMMA_MAX_64R                         0x0200
+#define REG_BCRM_GAMMA_INC_64R                         0x0208
+
+#define REG_BCRM_CONTRAST_VALUE_32RW                   0x0214
+#define REG_BCRM_CONTRAST_VALUE_MIN_32R                0x0218
+#define REG_BCRM_CONTRAST_VALUE_MAX_32R                0x021C
+#define REG_BCRM_CONTRAST_VALUE_INC_32R                0x0220
+
+#define REG_BCRM_SATURATION_32RW                       0x0240
+#define REG_BCRM_SATURATION_MIN_32R                    0x0244
+#define REG_BCRM_SATURATION_MAX_32R                    0x0248
+#define REG_BCRM_SATURATION_INC_32R                    0x024C
+
+#define REG_BCRM_HUE_32RW                              0x0250
+#define REG_BCRM_HUE_MIN_32R                           0x0254
+#define REG_BCRM_HUE_MAX_32R                           0x0258
+#define REG_BCRM_HUE_INC_32R                           0x025C
+
+#define REG_BCRM_ALL_BALANCE_RATIO_64RW                0x0260
+#define REG_BCRM_ALL_BALANCE_RATIO_MIN_64R             0x0268
+#define REG_BCRM_ALL_BALANCE_RATIO_MAX_64R             0x0270
+#define REG_BCRM_ALL_BALANCE_RATIO_INC_64R             0x0278
+
+#define REG_BCRM_RED_BALANCE_RATIO_64RW                0x0280
+#define REG_BCRM_RED_BALANCE_RATIO_MIN_64R             0x0288
+#define REG_BCRM_RED_BALANCE_RATIO_MAX_64R             0x0290
+#define REG_BCRM_RED_BALANCE_RATIO_INC_64R             0x0298
+
+#define REG_BCRM_GREEN_BALANCE_RATIO_64RW              0x02A0
+#define REG_BCRM_GREEN_BALANCE_RATIO_MIN_64R           0x02A8
+#define REG_BCRM_GREEN_BALANCE_RATIO_MAX_64R           0x02B0
+#define REG_BCRM_GREEN_BALANCE_RATIO_INC_64R           0x02B8
+
+#define REG_BCRM_BLUE_BALANCE_RATIO_64RW               0x02C0
+#define REG_BCRM_BLUE_BALANCE_RATIO_MIN_64R            0x02C8
+#define REG_BCRM_BLUE_BALANCE_RATIO_MAX_64R            0x02D0
+#define REG_BCRM_BLUE_BALANCE_RATIO_INC_64R            0x02D8
+
+#define REG_BCRM_WHITE_BALANCE_AUTO_8RW                0x02E0
+#define REG_BCRM_SHARPNESS_32RW                        0x0300
+#define REG_BCRM_SHARPNESS_MIN_32R                     0x0304
+#define REG_BCRM_SHARPNESS_MAX_32R                     0x0308
+#define REG_BCRM_SHARPNESS_INC_32R                     0x030C
+
+#define REG_BCRM_DEVICE_TEMPERATURE_32R                0x0310
+#define REG_BCRM_EXPOSURE_AUTO_MIN_64RW                0x0330
+#define REG_BCRM_EXPOSURE_AUTO_MAX_64RW                0x0338
+#define REG_BCRM_GAIN_AUTO_MIN_64RW                    0x0340
+#define REG_BCRM_GAIN_AUTO_MAX_64RW                    0x0348
+
+#define REG_BCRM_LAST_ADDR                             0x0348
+
+/* GenCP Registers */
+#define REG_GENCP_CHANGEMODE_8W                        0x021C
+#define REG_GENCP_CURRENTMODE_8R                       0x021D
+
+#define REG_GENCP_OUT_HANDSHAKE_8RW                    0x0018
+#define REG_GENCP_IN_HANDSHAKE_8RW                     0x001c
+#define REG_GENCP_OUT_SIZE_16W                         0x0020
+#define REG_GENCP_IN_SIZE_16R                          0x0024
+
+#define REG_BCRM_HANDSHAKE_STATUS_MASK      0x01
+#define REG_BCRM_HANDSHAKE_AVAILABLE_MASK   0x80
+
+#define BCRM_HANDSHAKE_W_DONE_EN_BIT        BIT(0)
+#define BCRM_HANDSHAKE_W_RST                0
+
+#define ALVIUM_DEFAULT_FR_HZ 10
+#define ALVIUM_DEFAULT_PIXEL_RATE_MHZ 148000000
+
+enum alvium_bcrm_mode {
+	ALVIUM_BCM_MODE,
+	ALVIUM_GENCP_MODE,
+	ALVIUM_NUM_MODE
+};
+
+enum alvium_mipi_fmt {
+	ALVIUM_FMT_UYVY8_2X8 = 0,
+	ALVIUM_FMT_UYVY8_1X16,
+	ALVIUM_FMT_YUYV8_1X16,
+	ALVIUM_FMT_YUYV8_2X8,
+	ALVIUM_FMT_YUYV10_1X20,
+	ALVIUM_FMT_RGB888_1X24,
+	ALVIUM_FMT_RBG888_1X24,
+	ALVIUM_FMT_BGR888_1X24,
+	ALVIUM_FMT_RGB888_3X8,
+	ALVIUM_FMT_Y8_1X8,
+	ALVIUM_FMT_SGRBG8_1X8,
+	ALVIUM_FMT_SRGGB8_1X8,
+	ALVIUM_FMT_SGBRG8_1X8,
+	ALVIUM_FMT_SBGGR8_1X8,
+	ALVIUM_FMT_Y10_1X10,
+	ALVIUM_FMT_SGRBG10_1X10,
+	ALVIUM_FMT_SRGGB10_1X10,
+	ALVIUM_FMT_SGBRG10_1X10,
+	ALVIUM_FMT_SBGGR10_1X10,
+	ALVIUM_FMT_Y12_1X12,
+	ALVIUM_FMT_SGRBG12_1X12,
+	ALVIUM_FMT_SRGGB12_1X12,
+	ALVIUM_FMT_SGBRG12_1X12,
+	ALVIUM_FMT_SBGGR12_1X12,
+	ALVIUM_FMT_SBGGR14_1X14,
+	ALVIUM_FMT_SGBRG14_1X14,
+	ALVIUM_FMT_SRGGB14_1X14,
+	ALVIUM_FMT_SGRBG14_1X14,
+	ALVIUM_NUM_SUPP_MIPI_DATA_FMT
+};
+
+enum alvium_av_bayer_bit {
+	ALVIUM_BIT_BAY_NONE = -1,
+	ALVIUM_BIT_BAY_MONO = 0,
+	ALVIUM_BIT_BAY_GR,
+	ALVIUM_BIT_BAY_RG,
+	ALVIUM_BIT_BAY_GB,
+	ALVIUM_BIT_BAY_BG,
+	ALVIUM_NUM_BAY_AV_BIT
+};
+
+enum alvium_av_mipi_bit {
+	ALVIUM_BIT_YUV420_8_LEG = 0,
+	ALVIUM_BIT_YUV420_8,
+	ALVIUM_BIT_YUV420_10,
+	ALVIUM_BIT_YUV420_8_CSPS,
+	ALVIUM_BIT_YUV420_10_CSPS,
+	ALVIUM_BIT_YUV422_8,
+	ALVIUM_BIT_YUV422_10,
+	ALVIUM_BIT_RGB888,
+	ALVIUM_BIT_RGB666,
+	ALVIUM_BIT_RGB565,
+	ALVIUM_BIT_RGB555,
+	ALVIUM_BIT_RGB444,
+	ALVIUM_BIT_RAW6,
+	ALVIUM_BIT_RAW7,
+	ALVIUM_BIT_RAW8,
+	ALVIUM_BIT_RAW10,
+	ALVIUM_BIT_RAW12,
+	ALVIUM_BIT_RAW14,
+	ALVIUM_BIT_JPEG,
+	ALVIUM_NUM_SUPP_MIPI_DATA_BIT
+};
+
+typedef struct {
+	u16 minor;
+	u16 major;
+} alvium_bcrm_vers_t;
+
+typedef struct {
+	u8 special;
+	u8 major;
+	u16 minor;
+	u32 patch;
+} alvium_fw_vers_t;
+
+typedef struct {
+	u8 rev_x:1;
+	u8 rev_y:1;
+	u8 int_autop:1;
+	u8 black_lvl:1;
+	u8 gain:1;
+	u8 gamma:1;
+	u8 contrast:1;
+	u8 sat:1;
+	u8 hue:1;
+	u8 whiteb:1;
+	u8 sharp:1;
+	u8 auto_exp:1;
+	u8 auto_gain:1;
+	u8 auto_whiteb:1;
+	u8 dev_temp:1;
+	u8 acq_abort:1;
+	u8 acq_fr:1;
+	u8 fr_trigger:1;
+	u8 exp_acq_line:1;
+} alvium_avail_feat_t;
+
+typedef struct {
+	u8 yuv420_8_leg:1;
+	u8 yuv420_8:1;
+	u8 yuv420_10:1;
+	u8 yuv420_8_csps:1;
+	u8 yuv420_10_csps:1;
+	u8 yuv422_8:1;
+	u8 yuv422_10:1;
+	u8 rgb888:1;
+	u8 rgb666:1;
+	u8 rgb565:1;
+	u8 rgb555:1;
+	u8 rgb444:1;
+	u8 raw6:1;
+	u8 raw7:1;
+	u8 raw8:1;
+	u8 raw10:1;
+	u8 raw12:1;
+	u8 raw14:1;
+	u8 jpeg:1;
+} alvium_avail_mipi_fmt_t;
+
+typedef struct {
+	u8 mono:1;
+	u8 gr:1;
+	u8 rg:1;
+	u8 gb:1;
+	u8 bg:1;
+} alvium_avail_bayer_t;
+
+struct alvium_mode {
+	struct v4l2_rect crop;
+	struct v4l2_mbus_framefmt fmt;
+	u32 width;
+	u32 height;
+
+};
+
+struct alvium_pixfmt {
+	u8 id;
+	u32 code;
+	u32 colorspace;
+	u8 fmt_av_bit;
+	u8 bay_av_bit;
+	u64 mipi_fmt_regval;
+	u64 bay_fmt_regval;
+	u8 is_raw;
+};
+
+struct alvium_ctrls {
+	struct v4l2_ctrl_handler handler;
+	struct v4l2_ctrl *pixel_rate;
+	struct v4l2_ctrl *link_freq;
+	struct {
+		struct v4l2_ctrl *auto_exp;
+		struct v4l2_ctrl *exposure;
+	};
+	struct {
+		struct v4l2_ctrl *auto_wb;
+		struct v4l2_ctrl *blue_balance;
+		struct v4l2_ctrl *red_balance;
+	};
+	struct {
+		struct v4l2_ctrl *auto_gain;
+		struct v4l2_ctrl *gain;
+	};
+	struct v4l2_ctrl *saturation;
+	struct v4l2_ctrl *hue;
+	struct v4l2_ctrl *contrast;
+	struct v4l2_ctrl *gamma;
+	struct v4l2_ctrl *sharpness;
+	struct v4l2_ctrl *hflip;
+	struct v4l2_ctrl *vflip;
+};
+
+struct alvium_dev {
+	struct i2c_client *i2c_client;
+	struct v4l2_subdev sd;
+	struct v4l2_fwnode_endpoint ep;
+	struct media_pad pad;
+
+	struct mutex lock;
+
+	struct gpio_desc *reset_gpio;
+	struct gpio_desc *pwdn_gpio;
+
+	u16 bcrm_addr;
+	alvium_bcrm_vers_t bcrm_v;
+	alvium_fw_vers_t fw_v;
+
+	alvium_avail_feat_t avail_ft;
+	u8 is_mipi_fmt_avail[ALVIUM_NUM_SUPP_MIPI_DATA_BIT];
+	u8 is_bay_avail[ALVIUM_NUM_BAY_AV_BIT];
+
+	u32 min_csi_clk;
+	u32 max_csi_clk;
+	u32 img_min_width;
+	u32 img_max_width;
+	u32 img_inc_width;
+	u32 img_min_height;
+	u32 img_max_height;
+	u32 img_inc_height;
+	u32 min_offx;
+	u32 max_offx;
+	u32 inc_offx;
+	u32 min_offy;
+	u32 max_offy;
+	u32 inc_offy;
+	u64 min_gain;
+	u64 max_gain;
+	u64 inc_gain;
+	u64 min_exp;
+	u64 max_exp;
+	u64 inc_exp;
+	u64 min_rbalance;
+	u64 max_rbalance;
+	u64 inc_rbalance;
+	u64 min_bbalance;
+	u64 max_bbalance;
+	u64 inc_bbalance;
+	s32 min_hue;
+	s32 max_hue;
+	s32 inc_hue;
+	u32 min_contrast;
+	u32 max_contrast;
+	u32 inc_contrast;
+	u32 min_sat;
+	u32 max_sat;
+	u32 inc_sat;
+	s32 min_black_lvl;
+	s32 max_black_lvl;
+	s32 inc_black_lvl;
+	u64 min_gamma;
+	u64 max_gamma;
+	u64 inc_gamma;
+	s32 min_sharp;
+	s32 max_sharp;
+	s32 inc_sharp;
+
+	u32 streamon_delay;
+
+	struct alvium_mode mode;
+	struct v4l2_fract frame_interval;
+	u64 min_fr;
+	u64 max_fr;
+	u64 fr;
+
+	u8 h_sup_csi_lanes;
+	struct clk *xclk;
+	u32 xclk_freq;
+	u32 csi_clk;
+	u64 link_freq;
+
+	struct alvium_ctrls ctrls;
+
+	u8 bcrm_mode;
+	u8 hshake_bit;
+
+	struct alvium_pixfmt *alvium_csi2_fmt;
+	u8 alvium_csi2_fmt_n;
+	struct v4l2_mbus_framefmt fmt;
+
+	u8 streaming:1;
+	u8 apply_fiv:1;
+
+	bool upside_down;
+};
+
+static inline struct alvium_dev *sd_to_alvium(struct v4l2_subdev *sd)
+{
+	return container_of(sd, struct alvium_dev, sd);
+}
+
+static inline struct alvium_dev *i2c_to_alvium(struct i2c_client *client)
+{
+	return sd_to_alvium(i2c_get_clientdata(client));
+}
+
+static inline bool alvium_is_csi2(const struct alvium_dev *alvium)
+{
+	return alvium->ep.bus_type == V4L2_MBUS_CSI2_DPHY;
+}
+
+static inline struct v4l2_subdev *ctrl_to_sd(struct v4l2_ctrl *ctrl)
+{
+	return &container_of(ctrl->handler, struct alvium_dev,
+					  ctrls.handler)->sd;
+}
+#endif /* ALVIUM_H_ */
-- 
2.34.1

