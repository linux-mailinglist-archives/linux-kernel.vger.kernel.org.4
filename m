Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37A3608E75
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJVQWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJVQWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:22:21 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7316714C;
        Sat, 22 Oct 2022 09:22:19 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bs14so7564604ljb.9;
        Sat, 22 Oct 2022 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2au6TnZRP9rgvETvjr7xOxPHDmFxh39G/D2D1ufhbOI=;
        b=lLHzOjStBVvWgGn7R/lDqEElR+kC7FT93xyrwZ0VGvthg6joUynmF0NhThcq4jRD4l
         Xy0NLB//wyrEjVCvRr8qm37F2wBjCFou9azGvWCO9CPRidHOK1OEvLbETU8P5T+KITuj
         155cu9DLUE/XxG/ADgrRgB16gimNcIXrLRtbKgJ4FSx9OZP23j3hgYu99FxTPv6X/FJ1
         XG/EtHsHIWIw9RdwQ80RfF3u+dnjC4Qs23nfvNws/A9JwtHtkErzzExaObnOdfCWD4Kk
         sLLLvEpQoAQ/E89U/4YsJspTjf8RXAtWnB6LDxIH4GnjEj0aZeEFNEZfrv96uFxO0hrv
         pD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2au6TnZRP9rgvETvjr7xOxPHDmFxh39G/D2D1ufhbOI=;
        b=ABdK3WKaYN8jQdnhdpBe24oHP0wkCpeOgSXKh5sews1vnGPVInszoT1Ph5znXYaa+C
         R1Y/MeWB/k6wABIxU282MkKmoyqs6Zh3fHOuZEfAJHHTk1Dgfb277gb8ZSz3vtTpqKNs
         SYyOfXKa5FQyWbj9zQYpZ/xxd8Aec6bWbQffSOhV8t9+DFYdOJFWsPxHmk2jidiVAAzN
         qzH8cE4Lh5opmjiScQo46dNZedrUpSJJbwOYHcGyYWP9ivxGhJ6nBQWZvj/C5aWAX4OZ
         F+FmG9DroncG9IFCiRTolAcibYx5uLobKVjVLUxU0H2mVVBo1oejOMf0WzNZDEsM+5xW
         cYvw==
X-Gm-Message-State: ACrzQf1dzCjkort9ULTZYHXep1PDO3PmZV71dVxMOXsnR7lgwPfOMb90
        WACl3nmt3S+RFUBQ9b7nXOc=
X-Google-Smtp-Source: AMsMyM6I+my00MGijnh8d+vOHdvFpew/eThfkHennvOzTBdW1J9tQNdAB1EA8wQlzAPObM3HGNMGlQ==
X-Received: by 2002:a2e:a273:0:b0:26f:b795:8b30 with SMTP id k19-20020a2ea273000000b0026fb7958b30mr9546422ljm.209.1666455736997;
        Sat, 22 Oct 2022 09:22:16 -0700 (PDT)
Received: from localhost (95-31-187-187.broadband.corbina.ru. [95.31.187.187])
        by smtp.gmail.com with ESMTPSA id b23-20020a056512071700b0049313f77755sm3613696lfs.213.2022.10.22.09.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 09:22:16 -0700 (PDT)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mike Pagano <mpagano@gentoo.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marek Vasut <marex@denx.de>, Jimmy Su <jimmy.su@intel.com>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] media: i2c: add support for OV4689
Date:   Sat, 22 Oct 2022 19:20:07 +0300
Message-Id: <20221022162042.14113-3-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221022162042.14113-1-mike.rudenko@gmail.com>
References: <20221022162042.14113-1-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a V4L2 sub-device driver for OmniVision OV4689 image sensor. This
is a 4 Mpx image sensor using the I2C bus for control and the CSI-2
bus for data.

This driver supports following features:
- manual exposure and analog gain control support
- test pattern support
- media controller support
- runtime PM support
- support following resolutions:
  + 2688x1520 at 30 fps

The driver provides all mandatory V4L2 controls for compatibility with
libcamera. The sensor supports 1/2/4-lane CSI-2 modes, but the driver
implements 4 lane mode only at this moment.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 MAINTAINERS                |    1 +
 drivers/media/i2c/Kconfig  |   13 +
 drivers/media/i2c/Makefile |    1 +
 drivers/media/i2c/ov4689.c | 1026 ++++++++++++++++++++++++++++++++++++
 4 files changed, 1041 insertions(+)
 create mode 100644 drivers/media/i2c/ov4689.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d6d86a9f704..acf38afb3e73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15210,6 +15210,7 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
+F:	drivers/media/i2c/ov5647.c
 
 OMNIVISION OV5640 SENSOR DRIVER
 M:	Steve Longerbeam <slongerbeam@gmail.com>
diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 7806d4b81716..1e1985252ec8 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -445,6 +445,19 @@ config VIDEO_OV2740
 	  To compile this driver as a module, choose M here: the
 	  module will be called ov2740.
 
+config VIDEO_OV4689
+	tristate "OmniVision OV4689 sensor support"
+	depends on GPIOLIB && VIDEO_DEV && I2C
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor-level driver for the OmniVision
+	  OV4689 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov4689.
+
 config VIDEO_OV5640
 	tristate "OmniVision OV5640 sensor support"
 	depends on OF
diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
index 0a2933103dd9..c1a2cb351c0f 100644
--- a/drivers/media/i2c/Makefile
+++ b/drivers/media/i2c/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_VIDEO_OV2659) += ov2659.o
 obj-$(CONFIG_VIDEO_OV2680) += ov2680.o
 obj-$(CONFIG_VIDEO_OV2685) += ov2685.o
 obj-$(CONFIG_VIDEO_OV2740) += ov2740.o
+obj-$(CONFIG_VIDEO_OV4689) += ov4689.o
 obj-$(CONFIG_VIDEO_OV5640) += ov5640.o
 obj-$(CONFIG_VIDEO_OV5645) += ov5645.o
 obj-$(CONFIG_VIDEO_OV5647) += ov5647.o
diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
new file mode 100644
index 000000000000..419ff7371ba8
--- /dev/null
+++ b/drivers/media/i2c/ov4689.c
@@ -0,0 +1,1026 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ov4689 driver
+ *
+ * Copyright (C) 2017 Fuzhou Rockchip Electronics Co., Ltd.
+ * Copyright (C) 2022 Mikhail Rudenko
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <media/media-entity.h>
+#include <media/v4l2-async.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-subdev.h>
+#include <media/v4l2-fwnode.h>
+
+#define CHIP_ID				0x004688
+#define OV4689_REG_CHIP_ID		0x300a
+
+#define OV4689_XVCLK_FREQ		24000000
+
+#define OV4689_REG_CTRL_MODE		0x0100
+#define OV4689_MODE_SW_STANDBY		0x0
+#define OV4689_MODE_STREAMING		BIT(0)
+
+#define OV4689_REG_EXPOSURE		0x3500
+#define OV4689_EXPOSURE_MIN		4
+#define OV4689_EXPOSURE_STEP		1
+#define OV4689_VTS_MAX			0x7fff
+
+#define OV4689_REG_GAIN_H		0x3508
+#define OV4689_REG_GAIN_L		0x3509
+#define OV4689_GAIN_H_MASK		0x07
+#define OV4689_GAIN_H_SHIFT		8
+#define OV4689_GAIN_L_MASK		0xff
+#define OV4689_GAIN_STEP		1
+#define OV4689_GAIN_DEFAULT		0x80
+
+#define OV4689_REG_TEST_PATTERN		0x5040
+#define OV4689_TEST_PATTERN_ENABLE	0x80
+#define OV4689_TEST_PATTERN_DISABLE	0x0
+
+#define OV4689_REG_VTS			0x380e
+
+#define REG_NULL			0xFFFF
+
+#define OV4689_REG_VALUE_08BIT		1
+#define OV4689_REG_VALUE_16BIT		2
+#define OV4689_REG_VALUE_24BIT		3
+
+#define OV4689_LANES			4
+
+static const char *const ov4689_supply_names[] = {
+	"avdd", /* Analog power */
+	"dovdd", /* Digital I/O power */
+	"dvdd", /* Digital core power */
+};
+
+struct regval {
+	u16 addr;
+	u8 val;
+};
+
+enum ov4689_mode_id {
+	OV4689_MODE_2688_1520 = 0,
+	OV4689_NUM_MODES,
+};
+
+struct ov4689_mode {
+	enum ov4689_mode_id id;
+	u32 width;
+	u32 height;
+	u32 max_fps;
+	u32 hts_def;
+	u32 vts_def;
+	u32 exp_def;
+	u32 pixel_rate;
+	u32 sensor_width;
+	u32 sensor_height;
+	u32 crop_top;
+	u32 crop_left;
+	const struct regval *reg_list;
+};
+
+struct ov4689 {
+	struct i2c_client *client;
+	struct clk *xvclk;
+	struct gpio_desc *reset_gpio;
+	struct gpio_desc *pwdn_gpio;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(ov4689_supply_names)];
+
+	struct v4l2_subdev subdev;
+	struct media_pad pad;
+
+	u32 clock_rate;
+
+	struct mutex mutex; /* lock to protect streaming, ctrls and cur_mode */
+	bool streaming;
+	struct v4l2_ctrl_handler ctrl_handler;
+	struct v4l2_ctrl *exposure;
+
+	const struct ov4689_mode *cur_mode;
+};
+
+#define to_ov4689(sd) container_of(sd, struct ov4689, subdev)
+
+struct ov4689_gain_range {
+	u32 logical_min;
+	u32 logical_max;
+	u32 offset;
+	u32 divider;
+	u32 physical_min;
+	u32 physical_max;
+};
+
+/*
+ * Xclk 24Mhz
+ * max_framerate 30fps
+ * mipi_datarate per lane 1008Mbps
+ */
+static const struct regval ov4689_2688x1520_regs[] = {
+	{0x0103, 0x01}, {0x3638, 0x00}, {0x0300, 0x00},
+	{0x0302, 0x2a}, {0x0303, 0x00}, {0x0304, 0x03},
+	{0x030b, 0x00}, {0x030d, 0x1e}, {0x030e, 0x04},
+	{0x030f, 0x01}, {0x0312, 0x01}, {0x031e, 0x00},
+	{0x3000, 0x20}, {0x3002, 0x00}, {0x3018, 0x72},
+	{0x3020, 0x93}, {0x3021, 0x03}, {0x3022, 0x01},
+	{0x3031, 0x0a}, {0x303f, 0x0c}, {0x3305, 0xf1},
+	{0x3307, 0x04}, {0x3309, 0x29}, {0x3500, 0x00},
+	{0x3501, 0x60}, {0x3502, 0x00}, {0x3503, 0x04},
+	{0x3504, 0x00}, {0x3505, 0x00}, {0x3506, 0x00},
+	{0x3507, 0x00}, {0x3508, 0x00}, {0x3509, 0x80},
+	{0x350a, 0x00}, {0x350b, 0x00}, {0x350c, 0x00},
+	{0x350d, 0x00}, {0x350e, 0x00}, {0x350f, 0x80},
+	{0x3510, 0x00}, {0x3511, 0x00}, {0x3512, 0x00},
+	{0x3513, 0x00}, {0x3514, 0x00}, {0x3515, 0x80},
+	{0x3516, 0x00}, {0x3517, 0x00}, {0x3518, 0x00},
+	{0x3519, 0x00}, {0x351a, 0x00}, {0x351b, 0x80},
+	{0x351c, 0x00}, {0x351d, 0x00}, {0x351e, 0x00},
+	{0x351f, 0x00}, {0x3520, 0x00}, {0x3521, 0x80},
+	{0x3522, 0x08}, {0x3524, 0x08}, {0x3526, 0x08},
+	{0x3528, 0x08}, {0x352a, 0x08}, {0x3602, 0x00},
+	{0x3603, 0x40}, {0x3604, 0x02}, {0x3605, 0x00},
+	{0x3606, 0x00}, {0x3607, 0x00}, {0x3609, 0x12},
+	{0x360a, 0x40}, {0x360c, 0x08}, {0x360f, 0xe5},
+	{0x3608, 0x8f}, {0x3611, 0x00}, {0x3613, 0xf7},
+	{0x3616, 0x58}, {0x3619, 0x99}, {0x361b, 0x60},
+	{0x361c, 0x7a}, {0x361e, 0x79}, {0x361f, 0x02},
+	{0x3632, 0x00}, {0x3633, 0x10}, {0x3634, 0x10},
+	{0x3635, 0x10}, {0x3636, 0x15}, {0x3646, 0x86},
+	{0x364a, 0x0b}, {0x3700, 0x17}, {0x3701, 0x22},
+	{0x3703, 0x10}, {0x370a, 0x37}, {0x3705, 0x00},
+	{0x3706, 0x63}, {0x3709, 0x3c}, {0x370b, 0x01},
+	{0x370c, 0x30}, {0x3710, 0x24}, {0x3711, 0x0c},
+	{0x3716, 0x00}, {0x3720, 0x28}, {0x3729, 0x7b},
+	{0x372a, 0x84}, {0x372b, 0xbd}, {0x372c, 0xbc},
+	{0x372e, 0x52}, {0x373c, 0x0e}, {0x373e, 0x33},
+	{0x3743, 0x10}, {0x3744, 0x88}, {0x3745, 0xc0},
+	{0x374a, 0x43}, {0x374c, 0x00}, {0x374e, 0x23},
+	{0x3751, 0x7b}, {0x3752, 0x84}, {0x3753, 0xbd},
+	{0x3754, 0xbc}, {0x3756, 0x52}, {0x375c, 0x00},
+	{0x3760, 0x00}, {0x3761, 0x00}, {0x3762, 0x00},
+	{0x3763, 0x00}, {0x3764, 0x00}, {0x3767, 0x04},
+	{0x3768, 0x04}, {0x3769, 0x08}, {0x376a, 0x08},
+	{0x376b, 0x20}, {0x376c, 0x00}, {0x376d, 0x00},
+	{0x376e, 0x00}, {0x3773, 0x00}, {0x3774, 0x51},
+	{0x3776, 0xbd}, {0x3777, 0xbd}, {0x3781, 0x18},
+	{0x3783, 0x25}, {0x3798, 0x1b}, {0x3800, 0x00},
+	{0x3801, 0x08}, {0x3802, 0x00}, {0x3803, 0x04},
+	{0x3804, 0x0a}, {0x3805, 0x97}, {0x3806, 0x05},
+	{0x3807, 0xfb}, {0x3808, 0x0a}, {0x3809, 0x80},
+	{0x380a, 0x05}, {0x380b, 0xf0}, {0x380c, 0x0a},
+	{0x380d, 0x0e}, {0x380e, 0x06}, {0x380f, 0x12},
+	{0x3810, 0x00}, {0x3811, 0x08}, {0x3812, 0x00},
+	{0x3813, 0x04}, {0x3814, 0x01}, {0x3815, 0x01},
+	{0x3819, 0x01}, {0x3820, 0x00}, {0x3821, 0x06},
+	{0x3829, 0x00}, {0x382a, 0x01}, {0x382b, 0x01},
+	{0x382d, 0x7f}, {0x3830, 0x04}, {0x3836, 0x01},
+	{0x3837, 0x00}, {0x3841, 0x02}, {0x3846, 0x08},
+	{0x3847, 0x07}, {0x3d85, 0x36}, {0x3d8c, 0x71},
+	{0x3d8d, 0xcb}, {0x3f0a, 0x00}, {0x4000, 0xf1},
+	{0x4001, 0x40}, {0x4002, 0x04}, {0x4003, 0x14},
+	{0x400e, 0x00}, {0x4011, 0x00}, {0x401a, 0x00},
+	{0x401b, 0x00}, {0x401c, 0x00}, {0x401d, 0x00},
+	{0x401f, 0x00}, {0x4020, 0x00}, {0x4021, 0x10},
+	{0x4022, 0x07}, {0x4023, 0xcf}, {0x4024, 0x09},
+	{0x4025, 0x60}, {0x4026, 0x09}, {0x4027, 0x6f},
+	{0x4028, 0x00}, {0x4029, 0x02}, {0x402a, 0x06},
+	{0x402b, 0x04}, {0x402c, 0x02}, {0x402d, 0x02},
+	{0x402e, 0x0e}, {0x402f, 0x04}, {0x4302, 0xff},
+	{0x4303, 0xff}, {0x4304, 0x00}, {0x4305, 0x00},
+	{0x4306, 0x00}, {0x4308, 0x02}, {0x4500, 0x6c},
+	{0x4501, 0xc4}, {0x4502, 0x40}, {0x4503, 0x01},
+	{0x4601, 0xa7}, {0x4800, 0x04}, {0x4813, 0x08},
+	{0x481f, 0x40}, {0x4829, 0x78}, {0x4837, 0x10},
+	{0x4b00, 0x2a}, {0x4b0d, 0x00}, {0x4d00, 0x04},
+	{0x4d01, 0x42}, {0x4d02, 0xd1}, {0x4d03, 0x93},
+	{0x4d04, 0xf5}, {0x4d05, 0xc1}, {0x5000, 0xf3},
+	{0x5001, 0x11}, {0x5004, 0x00}, {0x500a, 0x00},
+	{0x500b, 0x00}, {0x5032, 0x00}, {0x5040, 0x00},
+	{0x5050, 0x0c}, {0x5500, 0x00}, {0x5501, 0x10},
+	{0x5502, 0x01}, {0x5503, 0x0f}, {0x8000, 0x00},
+	{0x8001, 0x00}, {0x8002, 0x00}, {0x8003, 0x00},
+	{0x8004, 0x00}, {0x8005, 0x00}, {0x8006, 0x00},
+	{0x8007, 0x00}, {0x8008, 0x00}, {0x3638, 0x00},
+	{REG_NULL, 0x00},
+};
+
+static const struct ov4689_mode supported_modes[] = {
+	{
+		.id = OV4689_MODE_2688_1520,
+		.width = 2688,
+		.height = 1520,
+		.sensor_width = 2720,
+		.sensor_height = 1536,
+		.crop_top = 8,
+		.crop_left = 16,
+		.max_fps = 30,
+		.exp_def = 1536,
+		.hts_def = 4 * 2574,
+		.vts_def = 1554,
+		.pixel_rate = 480000000,
+		.reg_list = ov4689_2688x1520_regs,
+	},
+};
+
+static const u64 link_freq_menu_items[] = { 504000000 };
+
+static const char *const ov4689_test_pattern_menu[] = {
+	"Disabled",
+	"Vertical Color Bar Type 1",
+	"Vertical Color Bar Type 2",
+	"Vertical Color Bar Type 3",
+	"Vertical Color Bar Type 4"
+};
+
+/*
+ * These coefficients are based on those used in Rockchip's camera
+ * engine, with minor tweaks for continuity.
+ */
+static const struct ov4689_gain_range ov4689_gain_ranges[] = {
+	{
+		.logical_min = 0,
+		.logical_max = 255,
+		.offset = 0,
+		.divider = 1,
+		.physical_min = 0,
+		.physical_max = 255,
+	},
+	{
+		.logical_min = 256,
+		.logical_max = 511,
+		.offset = 252,
+		.divider = 2,
+		.physical_min = 376,
+		.physical_max = 504,
+	},
+	{
+		.logical_min = 512,
+		.logical_max = 1023,
+		.offset = 758,
+		.divider = 4,
+		.physical_min = 884,
+		.physical_max = 1012,
+	},
+	{
+		.logical_min = 1024,
+		.logical_max = 2047,
+		.offset = 1788,
+		.divider = 8,
+		.physical_min = 1912,
+		.physical_max = 2047,
+	},
+};
+
+/* Write registers up to 4 at a time */
+static int ov4689_write_reg(struct i2c_client *client, u16 reg, u32 len,
+			    u32 val)
+{
+	u32 buf_i, val_i;
+	__be32 val_be;
+	u8 *val_p;
+	u8 buf[6];
+
+	if (len > 4)
+		return -EINVAL;
+
+	buf[0] = reg >> 8;
+	buf[1] = reg & 0xff;
+
+	val_be = cpu_to_be32(val);
+	val_p = (u8 *)&val_be;
+	buf_i = 2;
+	val_i = 4 - len;
+
+	while (val_i < 4)
+		buf[buf_i++] = val_p[val_i++];
+
+	if (i2c_master_send(client, buf, len + 2) != len + 2)
+		return -EIO;
+
+	return 0;
+}
+
+static int ov4689_write_array(struct i2c_client *client,
+			      const struct regval *regs)
+{
+	int ret = 0;
+	u32 i;
+
+	for (i = 0; ret == 0 && regs[i].addr != REG_NULL; i++)
+		ret = ov4689_write_reg(client, regs[i].addr,
+				       OV4689_REG_VALUE_08BIT, regs[i].val);
+
+	return ret;
+}
+
+/* Read registers up to 4 at a time */
+static int ov4689_read_reg(struct i2c_client *client, u16 reg, unsigned int len,
+			   u32 *val)
+{
+	__be16 reg_addr_be = cpu_to_be16(reg);
+	struct i2c_msg msgs[2];
+	__be32 data_be = 0;
+	u8 *data_be_p;
+	int ret;
+
+	if (len > 4 || !len)
+		return -EINVAL;
+
+	data_be_p = (u8 *)&data_be;
+	/* Write register address */
+	msgs[0].addr = client->addr;
+	msgs[0].flags = 0;
+	msgs[0].len = 2;
+	msgs[0].buf = (u8 *)&reg_addr_be;
+
+	/* Read data from register */
+	msgs[1].addr = client->addr;
+	msgs[1].flags = I2C_M_RD;
+	msgs[1].len = len;
+	msgs[1].buf = &data_be_p[4 - len];
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret != ARRAY_SIZE(msgs))
+		return -EIO;
+
+	*val = be32_to_cpu(data_be);
+
+	return 0;
+}
+
+static void ov4689_fill_fmt(const struct ov4689_mode *mode,
+			    struct v4l2_mbus_framefmt *fmt)
+{
+	fmt->code = MEDIA_BUS_FMT_SBGGR10_1X10;
+	fmt->width = mode->width;
+	fmt->height = mode->height;
+	fmt->field = V4L2_FIELD_NONE;
+}
+
+static int ov4689_set_fmt(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_state *sd_state,
+			  struct v4l2_subdev_format *fmt)
+{
+	struct v4l2_mbus_framefmt *mbus_fmt = &fmt->format;
+	struct ov4689 *ov4689 = to_ov4689(sd);
+
+	/* only one mode supported for now */
+	ov4689_fill_fmt(ov4689->cur_mode, mbus_fmt);
+
+	return 0;
+}
+
+static int ov4689_get_fmt(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_state *sd_state,
+			  struct v4l2_subdev_format *fmt)
+{
+	struct v4l2_mbus_framefmt *mbus_fmt = &fmt->format;
+	struct ov4689 *ov4689 = to_ov4689(sd);
+
+	/* only one mode supported for now */
+	ov4689_fill_fmt(ov4689->cur_mode, mbus_fmt);
+
+	return 0;
+}
+
+static int ov4689_enum_mbus_code(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_state *sd_state,
+				 struct v4l2_subdev_mbus_code_enum *code)
+{
+	if (code->index != 0)
+		return -EINVAL;
+	code->code = MEDIA_BUS_FMT_SBGGR10_1X10;
+
+	return 0;
+}
+
+static int ov4689_enum_frame_sizes(struct v4l2_subdev *sd,
+				   struct v4l2_subdev_state *sd_state,
+				   struct v4l2_subdev_frame_size_enum *fse)
+{
+	if (fse->index >= ARRAY_SIZE(supported_modes))
+		return -EINVAL;
+
+	if (fse->code != MEDIA_BUS_FMT_SBGGR10_1X10)
+		return -EINVAL;
+
+	fse->min_width = supported_modes[fse->index].width;
+	fse->max_width = supported_modes[fse->index].width;
+	fse->max_height = supported_modes[fse->index].height;
+	fse->min_height = supported_modes[fse->index].height;
+
+	return 0;
+}
+
+static int ov4689_enable_test_pattern(struct ov4689 *ov4689, u32 pattern)
+{
+	u32 val;
+
+	if (pattern)
+		val = (pattern - 1) | OV4689_TEST_PATTERN_ENABLE;
+	else
+		val = OV4689_TEST_PATTERN_DISABLE;
+
+	return ov4689_write_reg(ov4689->client, OV4689_REG_TEST_PATTERN,
+				OV4689_REG_VALUE_08BIT, val);
+}
+
+static int ov4689_get_selection(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *state,
+				struct v4l2_subdev_selection *sel)
+{
+	const struct ov4689_mode *mode = to_ov4689(sd)->cur_mode;
+
+	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
+		return -EINVAL;
+
+	switch (sel->target) {
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+		sel->r.top = 0;
+		sel->r.left = 0;
+		sel->r.width = mode->sensor_width;
+		sel->r.height = mode->sensor_height;
+		return 0;
+	case V4L2_SEL_TGT_CROP:
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+		sel->r.top = mode->crop_top;
+		sel->r.left = mode->crop_left;
+		sel->r.width = mode->width;
+		sel->r.height = mode->height;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
+{
+	struct ov4689 *ov4689 = to_ov4689(sd);
+	struct i2c_client *client = ov4689->client;
+	int ret = 0;
+
+	mutex_lock(&ov4689->mutex);
+
+	on = !!on;
+	if (on == ov4689->streaming)
+		goto unlock_and_return;
+
+	if (on) {
+		ret = pm_runtime_resume_and_get(&client->dev);
+		if (ret < 0)
+			goto unlock_and_return;
+
+		ret = ov4689_write_array(ov4689->client,
+					 ov4689->cur_mode->reg_list);
+		if (ret) {
+			pm_runtime_put(&client->dev);
+			goto unlock_and_return;
+		}
+
+		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
+		if (ret) {
+			pm_runtime_put(&client->dev);
+			goto unlock_and_return;
+		}
+
+		ret = ov4689_write_reg(ov4689->client, OV4689_REG_CTRL_MODE,
+				       OV4689_REG_VALUE_08BIT,
+				       OV4689_MODE_STREAMING);
+		if (ret) {
+			pm_runtime_put(&client->dev);
+			goto unlock_and_return;
+		}
+	} else {
+		ov4689_write_reg(ov4689->client, OV4689_REG_CTRL_MODE,
+				 OV4689_REG_VALUE_08BIT,
+				 OV4689_MODE_SW_STANDBY);
+		pm_runtime_put(&client->dev);
+	}
+
+	ov4689->streaming = on;
+
+unlock_and_return:
+	mutex_unlock(&ov4689->mutex);
+
+	return ret;
+}
+
+/* Calculate the delay in us by clock rate and clock cycles */
+static inline u32 ov4689_cal_delay(struct ov4689 *ov4689, u32 cycles)
+{
+	return DIV_ROUND_UP(cycles * 1000,
+			    DIV_ROUND_UP(ov4689->clock_rate, 1000));
+}
+
+static int __maybe_unused ov4689_power_on(struct device *dev)
+{
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct ov4689 *ov4689 = to_ov4689(sd);
+	u32 delay_us;
+	int ret;
+
+	ret = clk_prepare_enable(ov4689->xvclk);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable xvclk\n");
+		return ret;
+	}
+
+	gpiod_set_value_cansleep(ov4689->reset_gpio, 1);
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ov4689_supply_names),
+				    ov4689->supplies);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable regulators\n");
+		goto disable_clk;
+	}
+
+	gpiod_set_value_cansleep(ov4689->reset_gpio, 0);
+	usleep_range(500, 1000);
+	gpiod_set_value_cansleep(ov4689->pwdn_gpio, 0);
+
+	/* 8192 cycles prior to first SCCB transaction */
+	delay_us = ov4689_cal_delay(ov4689, 8192);
+	usleep_range(delay_us, delay_us * 2);
+
+	return 0;
+
+disable_clk:
+	clk_disable_unprepare(ov4689->xvclk);
+
+	return ret;
+}
+
+static int __maybe_unused ov4689_power_off(struct device *dev)
+{
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct ov4689 *ov4689 = to_ov4689(sd);
+
+	gpiod_set_value_cansleep(ov4689->pwdn_gpio, 1);
+	clk_disable_unprepare(ov4689->xvclk);
+	gpiod_set_value_cansleep(ov4689->reset_gpio, 1);
+	regulator_bulk_disable(ARRAY_SIZE(ov4689_supply_names),
+			       ov4689->supplies);
+	return 0;
+}
+
+static int ov4689_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
+{
+	struct ov4689 *ov4689 = to_ov4689(sd);
+	struct v4l2_mbus_framefmt *try_fmt;
+
+	mutex_lock(&ov4689->mutex);
+
+	try_fmt = v4l2_subdev_get_try_format(sd, fh->state, 0);
+	/* Initialize try_fmt */
+	ov4689_fill_fmt(&supported_modes[OV4689_MODE_2688_1520], try_fmt);
+
+	mutex_unlock(&ov4689->mutex);
+
+	return 0;
+}
+
+static const struct dev_pm_ops ov4689_pm_ops = {
+	SET_RUNTIME_PM_OPS(ov4689_power_off, ov4689_power_on, NULL)
+};
+
+static const struct v4l2_subdev_internal_ops ov4689_internal_ops = {
+	.open = ov4689_open,
+};
+
+static const struct v4l2_subdev_video_ops ov4689_video_ops = {
+	.s_stream = ov4689_s_stream,
+};
+
+static const struct v4l2_subdev_pad_ops ov4689_pad_ops = {
+	.enum_mbus_code = ov4689_enum_mbus_code,
+	.enum_frame_size = ov4689_enum_frame_sizes,
+	.get_fmt = ov4689_get_fmt,
+	.set_fmt = ov4689_set_fmt,
+	.get_selection = ov4689_get_selection,
+};
+
+static const struct v4l2_subdev_ops ov4689_subdev_ops = {
+	.video = &ov4689_video_ops,
+	.pad = &ov4689_pad_ops,
+};
+
+/*
+ * Map userspace (logical) gain to sensor (physical) gain using
+ * ov4689_gain_ranges table.
+ */
+static int ov4689_map_gain(struct ov4689 *ov4689, int logical_gain, int *result)
+{
+	const struct device *dev = &ov4689->client->dev;
+	const struct ov4689_gain_range *range;
+	unsigned int n;
+
+	for (n = 0; n < ARRAY_SIZE(ov4689_gain_ranges); n++) {
+		if (logical_gain >= ov4689_gain_ranges[n].logical_min &&
+		    logical_gain <= ov4689_gain_ranges[n].logical_max) {
+			break;
+		}
+	}
+
+	if (n == ARRAY_SIZE(ov4689_gain_ranges)) {
+		dev_warn_ratelimited(dev, "no mapping found for gain %d\n",
+				     logical_gain);
+		return -EINVAL;
+	}
+
+	range = &ov4689_gain_ranges[n];
+
+	*result = clamp(range->offset + (logical_gain) / range->divider,
+			range->physical_min, range->physical_max);
+	return 0;
+}
+
+static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct ov4689 *ov4689 =
+		container_of(ctrl->handler, struct ov4689, ctrl_handler);
+	struct i2c_client *client = ov4689->client;
+	int sensor_gain;
+	s64 max_expo;
+	int ret;
+
+	/* Propagate change of current control to all related controls */
+	switch (ctrl->id) {
+	case V4L2_CID_VBLANK:
+		/* Update max exposure while meeting expected vblanking */
+		max_expo = ov4689->cur_mode->height + ctrl->val - 4;
+		__v4l2_ctrl_modify_range(ov4689->exposure,
+					 ov4689->exposure->minimum, max_expo,
+					 ov4689->exposure->step,
+					 ov4689->exposure->default_value);
+		break;
+	}
+
+	if (!pm_runtime_get_if_in_use(&client->dev))
+		return 0;
+
+	switch (ctrl->id) {
+	case V4L2_CID_EXPOSURE:
+		/* 4 least significant bits of expsoure are fractional part */
+		ret = ov4689_write_reg(ov4689->client, OV4689_REG_EXPOSURE,
+				       OV4689_REG_VALUE_24BIT, ctrl->val << 4);
+		break;
+	case V4L2_CID_ANALOGUE_GAIN:
+		ret = ov4689_map_gain(ov4689, ctrl->val, &sensor_gain);
+
+		ret = ret ?:
+			ov4689_write_reg(ov4689->client, OV4689_REG_GAIN_H,
+					 OV4689_REG_VALUE_08BIT,
+					 (sensor_gain >> OV4689_GAIN_H_SHIFT) &
+					 OV4689_GAIN_H_MASK);
+		ret = ret ?:
+			ov4689_write_reg(ov4689->client, OV4689_REG_GAIN_L,
+					 OV4689_REG_VALUE_08BIT,
+					 sensor_gain & OV4689_GAIN_L_MASK);
+		break;
+	case V4L2_CID_VBLANK:
+		ret = ov4689_write_reg(ov4689->client, OV4689_REG_VTS,
+				       OV4689_REG_VALUE_16BIT,
+				       ctrl->val + ov4689->cur_mode->height);
+		break;
+	case V4L2_CID_TEST_PATTERN:
+		ret = ov4689_enable_test_pattern(ov4689, ctrl->val);
+		break;
+	default:
+		dev_warn(&client->dev, "%s Unhandled id:0x%x, val:0x%x\n",
+			 __func__, ctrl->id, ctrl->val);
+		ret = -EINVAL;
+		break;
+	}
+
+	pm_runtime_put(&client->dev);
+
+	return ret;
+}
+
+static const struct v4l2_ctrl_ops ov4689_ctrl_ops = {
+	.s_ctrl = ov4689_set_ctrl,
+};
+
+static int ov4689_initialize_controls(struct ov4689 *ov4689)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&ov4689->subdev);
+	struct v4l2_fwnode_device_properties props;
+	struct v4l2_ctrl_handler *handler;
+	const struct ov4689_mode *mode;
+	s64 exposure_max, vblank_def;
+	struct v4l2_ctrl *ctrl;
+	s64 h_blank_def;
+	int ret;
+
+	handler = &ov4689->ctrl_handler;
+	mode = ov4689->cur_mode;
+	ret = v4l2_ctrl_handler_init(handler, 10);
+	if (ret)
+		return ret;
+	handler->lock = &ov4689->mutex;
+
+	ctrl = v4l2_ctrl_new_int_menu(handler, NULL, V4L2_CID_LINK_FREQ, 0, 0,
+				      link_freq_menu_items);
+	if (ctrl)
+		ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+
+	v4l2_ctrl_new_std(handler, NULL, V4L2_CID_PIXEL_RATE, 0,
+			  mode->pixel_rate, 1, mode->pixel_rate);
+
+	h_blank_def = mode->hts_def - mode->width;
+	ctrl = v4l2_ctrl_new_std(handler, NULL, V4L2_CID_HBLANK, h_blank_def,
+				 h_blank_def, 1, h_blank_def);
+	if (ctrl)
+		ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+
+	vblank_def = mode->vts_def - mode->height;
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VBLANK,
+			  vblank_def, OV4689_VTS_MAX - mode->height, 1,
+			  vblank_def);
+
+	exposure_max = mode->vts_def - 4;
+	ov4689->exposure =
+		v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_EXPOSURE,
+				  OV4689_EXPOSURE_MIN, exposure_max,
+				  OV4689_EXPOSURE_STEP, mode->exp_def);
+
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_ANALOGUE_GAIN,
+			  ov4689_gain_ranges[0].logical_min,
+			  ov4689_gain_ranges[ARRAY_SIZE(ov4689_gain_ranges) - 1]
+				  .logical_max,
+			  OV4689_GAIN_STEP, OV4689_GAIN_DEFAULT);
+
+	v4l2_ctrl_new_std_menu_items(handler, &ov4689_ctrl_ops,
+				     V4L2_CID_TEST_PATTERN,
+				     ARRAY_SIZE(ov4689_test_pattern_menu) - 1,
+				     0, 0, ov4689_test_pattern_menu);
+
+	if (handler->error) {
+		ret = handler->error;
+		dev_err(&ov4689->client->dev, "Failed to init controls(%d)\n",
+			ret);
+		goto err_free_handler;
+	}
+
+	ret = v4l2_fwnode_device_parse(&client->dev, &props);
+	if (ret)
+		goto err_free_handler;
+
+	ret = v4l2_ctrl_new_fwnode_properties(handler, &ov4689_ctrl_ops,
+					      &props);
+	if (ret)
+		goto err_free_handler;
+
+	ov4689->subdev.ctrl_handler = handler;
+
+	return 0;
+
+err_free_handler:
+	v4l2_ctrl_handler_free(handler);
+
+	return ret;
+}
+
+static int ov4689_check_sensor_id(struct ov4689 *ov4689,
+				  struct i2c_client *client)
+{
+	struct device *dev = &ov4689->client->dev;
+	u32 id = 0;
+	int ret;
+
+	ret = ov4689_read_reg(client, OV4689_REG_CHIP_ID,
+			      OV4689_REG_VALUE_16BIT, &id);
+	if (ret) {
+		dev_err(dev, "Cannot read sensor ID\n");
+		return ret;
+	}
+
+	if (id != CHIP_ID) {
+		dev_err(dev, "Unexpected sensor ID %06x, expected %06x\n",
+			id, CHIP_ID);
+		return -ENODEV;
+	}
+
+	dev_info(dev, "Detected OV%06x sensor\n", CHIP_ID);
+
+	return 0;
+}
+
+static int ov4689_configure_regulators(struct ov4689 *ov4689)
+{
+	unsigned int supplies_count = ARRAY_SIZE(ov4689_supply_names);
+	unsigned int i;
+
+	for (i = 0; i < supplies_count; i++)
+		ov4689->supplies[i].supply = ov4689_supply_names[i];
+
+	return devm_regulator_bulk_get(&ov4689->client->dev, supplies_count,
+				       ov4689->supplies);
+}
+
+static u64 ov4689_check_link_frequency(struct v4l2_fwnode_endpoint *ep)
+{
+	unsigned int freqs_count = ARRAY_SIZE(link_freq_menu_items);
+	const u64 *freqs = link_freq_menu_items;
+	unsigned int i, j;
+
+	for (i = 0; i < freqs_count; i++) {
+		for (j = 0; j < ep->nr_of_link_frequencies; j++)
+			if (freqs[i] == ep->link_frequencies[j])
+				return freqs[i];
+	}
+
+	return 0;
+}
+
+static int ov4689_check_hwcfg(struct device *dev)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	struct v4l2_fwnode_endpoint bus_cfg = {
+		.bus_type = V4L2_MBUS_CSI2_DPHY,
+	};
+	struct fwnode_handle *endpoint;
+	int ret;
+
+	endpoint = fwnode_graph_get_next_endpoint(fwnode, NULL);
+	if (!endpoint)
+		return -EINVAL;
+
+	ret = v4l2_fwnode_endpoint_alloc_parse(endpoint, &bus_cfg);
+	fwnode_handle_put(endpoint);
+	if (ret)
+		return ret;
+
+	if (bus_cfg.bus.mipi_csi2.num_data_lanes != OV4689_LANES) {
+		dev_err(dev, "Only a 4-lane CSI2 config is supported");
+		ret = -EINVAL;
+		goto out_free_bus_cfg;
+	}
+
+	if (!bus_cfg.nr_of_link_frequencies) {
+		dev_err(dev, "No link frequencies defined\n");
+		ret = -EINVAL;
+		goto out_free_bus_cfg;
+	}
+
+	if (!ov4689_check_link_frequency(&bus_cfg)) {
+		dev_err(dev, "No supported link frequency found\n");
+		ret = -EINVAL;
+	}
+
+out_free_bus_cfg:
+	v4l2_fwnode_endpoint_free(&bus_cfg);
+
+	return ret;
+}
+
+static int ov4689_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct v4l2_subdev *sd;
+	struct ov4689 *ov4689;
+	int ret;
+
+	ret = ov4689_check_hwcfg(dev);
+	if (ret)
+		return ret;
+
+	ov4689 = devm_kzalloc(dev, sizeof(*ov4689), GFP_KERNEL);
+	if (!ov4689)
+		return -ENOMEM;
+
+	ov4689->client = client;
+	ov4689->cur_mode = &supported_modes[OV4689_MODE_2688_1520];
+
+	ov4689->xvclk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(ov4689->xvclk))
+		return dev_err_probe(dev, PTR_ERR(ov4689->xvclk),
+				     "Failed to get external clock\n");
+
+	if (!ov4689->xvclk) {
+		dev_dbg(dev,
+			"No clock provided, using clock-frequency property\n");
+		device_property_read_u32(dev, "clock-frequency",
+					 &ov4689->clock_rate);
+	} else {
+		ov4689->clock_rate = clk_get_rate(ov4689->xvclk);
+	}
+
+	if (ov4689->clock_rate != OV4689_XVCLK_FREQ) {
+		dev_err(dev,
+			"External clock rate mismatch: got %d Hz, expected %d Hz\n",
+			ov4689->clock_rate, OV4689_XVCLK_FREQ);
+		return -EINVAL;
+	}
+
+	ov4689->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						     GPIOD_OUT_LOW);
+	if (IS_ERR(ov4689->reset_gpio)) {
+		dev_err(dev, "Failed to get reset-gpios\n");
+		return PTR_ERR(ov4689->reset_gpio);
+	}
+
+	ov4689->pwdn_gpio = devm_gpiod_get_optional(dev, "pwdn", GPIOD_OUT_LOW);
+	if (IS_ERR(ov4689->pwdn_gpio)) {
+		dev_err(dev, "Failed to get pwdn-gpios\n");
+		return PTR_ERR(ov4689->pwdn_gpio);
+	}
+
+	ret = ov4689_configure_regulators(ov4689);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get power regulators\n");
+
+	mutex_init(&ov4689->mutex);
+
+	sd = &ov4689->subdev;
+	v4l2_i2c_subdev_init(sd, client, &ov4689_subdev_ops);
+	ret = ov4689_initialize_controls(ov4689);
+	if (ret)
+		goto err_destroy_mutex;
+
+	ret = ov4689_power_on(dev);
+	if (ret)
+		goto err_free_handler;
+
+	ret = ov4689_check_sensor_id(ov4689, client);
+	if (ret)
+		goto err_power_off;
+
+	sd->internal_ops = &ov4689_internal_ops;
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+
+	ov4689->pad.flags = MEDIA_PAD_FL_SOURCE;
+	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
+	ret = media_entity_pads_init(&sd->entity, 1, &ov4689->pad);
+	if (ret < 0)
+		goto err_power_off;
+
+	ret = v4l2_async_register_subdev_sensor(sd);
+	if (ret) {
+		dev_err(dev, "v4l2 async register subdev failed\n");
+		goto err_clean_entity;
+	}
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_idle(dev);
+
+	return 0;
+
+err_clean_entity:
+	media_entity_cleanup(&sd->entity);
+err_power_off:
+	ov4689_power_off(dev);
+err_free_handler:
+	v4l2_ctrl_handler_free(&ov4689->ctrl_handler);
+err_destroy_mutex:
+	mutex_destroy(&ov4689->mutex);
+
+	return ret;
+}
+
+static void ov4689_remove(struct i2c_client *client)
+{
+	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct ov4689 *ov4689 = to_ov4689(sd);
+
+	v4l2_async_unregister_subdev(sd);
+	media_entity_cleanup(&sd->entity);
+
+	v4l2_ctrl_handler_free(&ov4689->ctrl_handler);
+	mutex_destroy(&ov4689->mutex);
+
+	pm_runtime_disable(&client->dev);
+	if (!pm_runtime_status_suspended(&client->dev))
+		ov4689_power_off(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+}
+
+static const struct of_device_id ov4689_of_match[] = {
+	{ .compatible = "ovti,ov4689" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ov4689_of_match);
+
+static struct i2c_driver ov4689_i2c_driver = {
+	.driver = {
+		.name = "ov4689",
+		.pm = &ov4689_pm_ops,
+		.of_match_table = ov4689_of_match,
+	},
+	.probe_new = ov4689_probe,
+	.remove	= ov4689_remove,
+};
+
+module_i2c_driver(ov4689_i2c_driver);
+
+MODULE_DESCRIPTION("OmniVision ov4689 sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.38.1

