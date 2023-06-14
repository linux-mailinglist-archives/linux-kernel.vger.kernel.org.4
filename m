Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B635710779
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240073AbjEYIcg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 May 2023 04:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239912AbjEYIcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:32:14 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFFB194;
        Thu, 25 May 2023 01:32:06 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C2F5A24E26C;
        Thu, 25 May 2023 16:32:05 +0800 (CST)
Received: from EXMBX173.cuchost.com (172.16.6.93) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 25 May
 2023 16:32:05 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX173.cuchost.com
 (172.16.6.93) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 25 May
 2023 16:32:04 +0800
From:   Jack Zhu <jack.zhu@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jack.zhu@starfivetech.com>,
        <changhuang.liang@starfivetech.com>
Subject: [PATCH v6 5/6] media: starfive: Add ISP driver
Date:   Thu, 25 May 2023 16:32:01 +0800
Message-ID: <20230525083202.67933-6-jack.zhu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525083202.67933-1-jack.zhu@starfivetech.com>
References: <20230525083202.67933-1-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX173.cuchost.com
 (172.16.6.93)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ISP driver for StarFive Camera Subsystem.

Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
---
 drivers/media/platform/starfive/Makefile      |   2 +
 drivers/media/platform/starfive/stf_camss.c   |  71 ++-
 drivers/media/platform/starfive/stf_camss.h   |   2 +
 drivers/media/platform/starfive/stf_isp.c     | 550 ++++++++++++++++++
 drivers/media/platform/starfive/stf_isp.h     | 483 +++++++++++++++
 .../media/platform/starfive/stf_isp_hw_ops.c  | 468 +++++++++++++++
 6 files changed, 1574 insertions(+), 2 deletions(-)
 create mode 100644 drivers/media/platform/starfive/stf_isp.c
 create mode 100644 drivers/media/platform/starfive/stf_isp.h
 create mode 100644 drivers/media/platform/starfive/stf_isp_hw_ops.c

diff --git a/drivers/media/platform/starfive/Makefile b/drivers/media/platform/starfive/Makefile
index d7a42b3a938c..60a3018f4994 100644
--- a/drivers/media/platform/starfive/Makefile
+++ b/drivers/media/platform/starfive/Makefile
@@ -5,6 +5,8 @@
 
 starfive-camss-objs += \
 		stf_camss.o \
+		stf_isp.o \
+		stf_isp_hw_ops.o \
 		stf_video.o
 
 obj-$(CONFIG_VIDEO_STARFIVE_CAMSS) += starfive-camss.o \
diff --git a/drivers/media/platform/starfive/stf_camss.c b/drivers/media/platform/starfive/stf_camss.c
index cb2b62d49416..0d8406ba6a40 100644
--- a/drivers/media/platform/starfive/stf_camss.c
+++ b/drivers/media/platform/starfive/stf_camss.c
@@ -126,16 +126,66 @@ static int stfcamss_of_parse_ports(struct stfcamss *stfcamss)
 	return ret;
 }
 
+/*
+ * stfcamss_init_subdevices - Initialize subdev structures and resources
+ * @stfcamss: STFCAMSS device
+ *
+ * Return 0 on success or a negative error code on failure
+ */
+static int stfcamss_init_subdevices(struct stfcamss *stfcamss)
+{
+	int ret;
+
+	ret = stf_isp_subdev_init(stfcamss);
+	if (ret < 0) {
+		dev_err(stfcamss->dev, "Failed to init isp subdev: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int stfcamss_register_subdevices(struct stfcamss *stfcamss)
+{
+	int ret;
+	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
+
+	ret = stf_isp_register(isp_dev, &stfcamss->v4l2_dev);
+	if (ret < 0) {
+		dev_err(stfcamss->dev,
+			"Failed to register stf isp%d entity: %d\n", 0, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static void stfcamss_unregister_subdevices(struct stfcamss *stfcamss)
+{
+	stf_isp_unregister(&stfcamss->isp_dev);
+}
+
 static int stfcamss_subdev_notifier_bound(struct v4l2_async_notifier *async,
 					  struct v4l2_subdev *subdev,
 					  struct v4l2_async_subdev *asd)
 {
 	struct stfcamss *stfcamss =
 		container_of(async, struct stfcamss, notifier);
+	struct stfcamss_async_subdev *csd =
+		container_of(asd, struct stfcamss_async_subdev, asd);
+	enum port_num port = csd->port;
+	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
 	struct host_data *host_data = &stfcamss->host_data;
 	struct media_entity *source;
 	int i, j;
 
+	if (port == PORT_NUMBER_CSI2RX) {
+		host_data->host_entity[1] = &isp_dev->subdev.entity;
+	} else if (port == PORT_NUMBER_DVP_SENSOR) {
+		dev_err(stfcamss->dev, "Not support DVP sensor\n");
+		return -EPERM;
+	}
+
 	source = &subdev->entity;
 
 	for (i = 0; i < source->num_pads; i++) {
@@ -266,12 +316,18 @@ static int stfcamss_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	ret = stfcamss_init_subdevices(stfcamss);
+	if (ret < 0) {
+		dev_err(dev, "Failed to init subdevice: %d\n", ret);
+		goto err_cleanup_notifier;
+	}
+
 	stfcamss_mc_init(pdev, stfcamss);
 
 	ret = v4l2_device_register(stfcamss->dev, &stfcamss->v4l2_dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
-		goto err_cleanup_notifier;
+		goto err_cleanup_media_device;
 	}
 
 	ret = media_device_register(&stfcamss->media_dev);
@@ -280,22 +336,32 @@ static int stfcamss_probe(struct platform_device *pdev)
 		goto err_unregister_device;
 	}
 
+	ret = stfcamss_register_subdevices(stfcamss);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register subdevice: %d\n", ret);
+		goto err_unregister_media_dev;
+	}
+
 	stfcamss->notifier.ops = &stfcamss_subdev_notifier_ops;
 	ret = v4l2_async_nf_register(&stfcamss->v4l2_dev, &stfcamss->notifier);
 	if (ret) {
 		dev_err(dev, "Failed to register async subdev nodes: %d\n",
 			ret);
-		goto err_unregister_media_dev;
+		goto err_unregister_subdevs;
 	}
 
 	pm_runtime_enable(dev);
 
 	return 0;
 
+err_unregister_subdevs:
+	stfcamss_unregister_subdevices(stfcamss);
 err_unregister_media_dev:
 	media_device_unregister(&stfcamss->media_dev);
 err_unregister_device:
 	v4l2_device_unregister(&stfcamss->v4l2_dev);
+err_cleanup_media_device:
+	media_device_cleanup(&stfcamss->media_dev);
 err_cleanup_notifier:
 	v4l2_async_nf_cleanup(&stfcamss->notifier);
 	return ret;
@@ -311,6 +377,7 @@ static int stfcamss_remove(struct platform_device *pdev)
 {
 	struct stfcamss *stfcamss = platform_get_drvdata(pdev);
 
+	stfcamss_unregister_subdevices(stfcamss);
 	v4l2_device_unregister(&stfcamss->v4l2_dev);
 	media_device_cleanup(&stfcamss->media_dev);
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/media/platform/starfive/stf_camss.h b/drivers/media/platform/starfive/stf_camss.h
index 8f39cd65950c..c9d94be92ea8 100644
--- a/drivers/media/platform/starfive/stf_camss.h
+++ b/drivers/media/platform/starfive/stf_camss.h
@@ -16,6 +16,7 @@
 #include <media/v4l2-device.h>
 
 #include "stf_common.h"
+#include "stf_isp.h"
 
 #define DRV_NAME     "starfive-camss"
 #define STF_DVP_NAME "stf_dvp"
@@ -71,6 +72,7 @@ struct stfcamss {
 	struct media_device media_dev;
 	struct media_pipeline pipe;
 	struct device *dev;
+	struct stf_isp_dev isp_dev;
 	struct v4l2_async_notifier notifier;
 	struct host_data host_data;
 	void __iomem *syscon_base;
diff --git a/drivers/media/platform/starfive/stf_isp.c b/drivers/media/platform/starfive/stf_isp.c
new file mode 100644
index 000000000000..874e06efc45d
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_isp.c
@@ -0,0 +1,550 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stf_isp.c
+ *
+ * StarFive Camera Subsystem - ISP Module
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+#include <linux/firmware.h>
+#include <media/v4l2-event.h>
+
+#include "stf_camss.h"
+
+#define SINK_FORMATS_INDEX    0
+#define UO_FORMATS_INDEX      1
+
+static int isp_set_selection(struct v4l2_subdev *sd,
+			     struct v4l2_subdev_state *state,
+			     struct v4l2_subdev_selection *sel);
+
+static const struct isp_format isp_formats_sink[] = {
+	{ MEDIA_BUS_FMT_SRGGB10_1X10, 10 },
+	{ MEDIA_BUS_FMT_SGRBG10_1X10, 10 },
+	{ MEDIA_BUS_FMT_SGBRG10_1X10, 10 },
+	{ MEDIA_BUS_FMT_SBGGR10_1X10, 10 },
+};
+
+static const struct isp_format isp_formats_uo[] = {
+	{ MEDIA_BUS_FMT_Y12_1X12, 8 },
+};
+
+static const struct isp_format_table isp_formats_st7110[] = {
+	{ isp_formats_sink, ARRAY_SIZE(isp_formats_sink) },
+	{ isp_formats_uo, ARRAY_SIZE(isp_formats_uo) },
+};
+
+int stf_isp_subdev_init(struct stfcamss *stfcamss)
+{
+	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
+
+	isp_dev->sdev_type = STF_SUBDEV_TYPE_ISP;
+	isp_dev->stfcamss = stfcamss;
+	isp_dev->formats = isp_formats_st7110;
+	isp_dev->nformats = ARRAY_SIZE(isp_formats_st7110);
+
+	mutex_init(&isp_dev->stream_lock);
+	mutex_init(&isp_dev->power_lock);
+	return 0;
+}
+
+static int isp_set_power(struct v4l2_subdev *sd, int on)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+
+	mutex_lock(&isp_dev->power_lock);
+	if (on) {
+		if (isp_dev->power_count == 0)
+			dev_dbg(isp_dev->stfcamss->dev, "turn on isp\n");
+		isp_dev->power_count++;
+	} else {
+		if (isp_dev->power_count == 0)
+			goto exit;
+		isp_dev->power_count--;
+	}
+exit:
+	mutex_unlock(&isp_dev->power_lock);
+
+	return 0;
+}
+
+static struct v4l2_mbus_framefmt *
+__isp_get_format(struct stf_isp_dev *isp_dev,
+		 struct v4l2_subdev_state *state,
+		 unsigned int pad,
+		 enum v4l2_subdev_format_whence which)
+{
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_format(&isp_dev->subdev, state, pad);
+
+	return &isp_dev->fmt[pad];
+}
+
+static int isp_set_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+	int ret = 0;
+	struct v4l2_mbus_framefmt *fmt;
+	struct v4l2_event src_ch = { 0 };
+
+	fmt = __isp_get_format(isp_dev, NULL, STF_ISP_PAD_SINK,
+			       V4L2_SUBDEV_FORMAT_ACTIVE);
+	mutex_lock(&isp_dev->stream_lock);
+	if (enable) {
+		if (isp_dev->stream_count == 0) {
+			stf_isp_clk_enable(isp_dev);
+			stf_isp_reset(isp_dev);
+			stf_isp_init_cfg(isp_dev);
+			stf_isp_settings(isp_dev, isp_dev->rect, fmt->code);
+			stf_isp_stream_set(isp_dev);
+		}
+		isp_dev->stream_count++;
+	} else {
+		if (isp_dev->stream_count == 0)
+			goto exit;
+
+		if (isp_dev->stream_count == 1)
+			stf_isp_clk_disable(isp_dev);
+
+		isp_dev->stream_count--;
+	}
+	src_ch.type = V4L2_EVENT_SOURCE_CHANGE,
+	src_ch.u.src_change.changes = isp_dev->stream_count,
+
+	v4l2_subdev_notify_event(sd, &src_ch);
+exit:
+	mutex_unlock(&isp_dev->stream_lock);
+
+	return ret;
+}
+
+static void isp_try_format(struct stf_isp_dev *isp_dev,
+			   struct v4l2_subdev_state *state,
+			   unsigned int pad,
+			   struct v4l2_mbus_framefmt *fmt,
+			   enum v4l2_subdev_format_whence which)
+{
+	const struct isp_format_table *formats;
+	struct stf_isp_crop *rect;
+	int i;
+
+	switch (pad) {
+	case STF_ISP_PAD_SINK:
+		/* Set format on sink pad */
+		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
+		rect = &isp_dev->rect[SINK_FORMATS_INDEX];
+		fmt->width = clamp_t(u32,
+				     fmt->width, STFCAMSS_FRAME_MIN_WIDTH,
+				     STFCAMSS_FRAME_MAX_WIDTH);
+		fmt->height = clamp_t(u32,
+				      fmt->height, STFCAMSS_FRAME_MIN_HEIGHT,
+				      STFCAMSS_FRAME_MAX_HEIGHT);
+		fmt->height &= ~0x1;
+		fmt->field = V4L2_FIELD_NONE;
+		fmt->colorspace = V4L2_COLORSPACE_SRGB;
+		fmt->flags = 0;
+		break;
+
+	case STF_ISP_PAD_SRC:
+		formats = &isp_dev->formats[UO_FORMATS_INDEX];
+		rect = &isp_dev->rect[UO_FORMATS_INDEX];
+		*fmt = *__isp_get_format(isp_dev, state,
+					 STF_ISP_PAD_SINK, which);
+		break;
+	}
+
+	for (i = 0; i < formats->nfmts; i++) {
+		if (fmt->code == formats->fmts[i].code)
+			break;
+	}
+
+	if (i >= formats->nfmts) {
+		fmt->code = formats->fmts[0].code;
+		rect->bpp = formats->fmts[0].bpp;
+	} else {
+		rect->bpp = formats->fmts[i].bpp;
+	}
+}
+
+static int isp_enum_mbus_code(struct v4l2_subdev *sd,
+			      struct v4l2_subdev_state *state,
+			      struct v4l2_subdev_mbus_code_enum *code)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+	const struct isp_format_table *formats;
+
+	if (code->index >= isp_dev->nformats)
+		return -EINVAL;
+	if (code->pad == STF_ISP_PAD_SINK) {
+		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
+		code->code = formats->fmts[code->index].code;
+	} else {
+		struct v4l2_mbus_framefmt *sink_fmt;
+
+		sink_fmt = __isp_get_format(isp_dev, state, STF_ISP_PAD_SINK,
+					    code->which);
+
+		code->code = sink_fmt->code;
+		if (!code->code)
+			return -EINVAL;
+	}
+	code->flags = 0;
+
+	return 0;
+}
+
+static int isp_enum_frame_size(struct v4l2_subdev *sd,
+			       struct v4l2_subdev_state *state,
+			       struct v4l2_subdev_frame_size_enum *fse)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt format;
+
+	if (fse->index != 0)
+		return -EINVAL;
+
+	format.code = fse->code;
+	format.width = 1;
+	format.height = 1;
+	isp_try_format(isp_dev, state, fse->pad, &format, fse->which);
+	fse->min_width = format.width;
+	fse->min_height = format.height;
+
+	if (format.code != fse->code)
+		return -EINVAL;
+
+	format.code = fse->code;
+	format.width = -1;
+	format.height = -1;
+	isp_try_format(isp_dev, state, fse->pad, &format, fse->which);
+	fse->max_width = format.width;
+	fse->max_height = format.height;
+
+	return 0;
+}
+
+static int isp_get_format(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_state *state,
+			  struct v4l2_subdev_format *fmt)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	format = __isp_get_format(isp_dev, state, fmt->pad, fmt->which);
+	if (!format)
+		return -EINVAL;
+
+	fmt->format = *format;
+
+	return 0;
+}
+
+static int isp_set_format(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_state *state,
+			  struct v4l2_subdev_format *fmt)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	format = __isp_get_format(isp_dev, state, fmt->pad, fmt->which);
+	if (!format)
+		return -EINVAL;
+
+	mutex_lock(&isp_dev->stream_lock);
+
+	isp_try_format(isp_dev, state, fmt->pad, &fmt->format, fmt->which);
+	*format = fmt->format;
+
+	mutex_unlock(&isp_dev->stream_lock);
+
+	/* Propagate to in crop */
+	if (fmt->pad == STF_ISP_PAD_SINK) {
+		struct v4l2_subdev_selection sel = { 0 };
+		int ret;
+
+		/* Reset sink pad compose selection */
+		sel.which = fmt->which;
+		sel.pad = STF_ISP_PAD_SINK;
+		sel.target = V4L2_SEL_TGT_CROP;
+		sel.r.width = fmt->format.width;
+		sel.r.height = fmt->format.height;
+		ret = isp_set_selection(sd, state, &sel);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static struct v4l2_rect *
+__isp_get_crop(struct stf_isp_dev *isp_dev,
+	       struct v4l2_subdev_state *state,
+	       unsigned int pad,
+	       enum v4l2_subdev_format_whence which)
+{
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_crop(&isp_dev->subdev, state,
+						STF_ISP_PAD_SINK);
+
+	return &isp_dev->rect[pad].rect;
+}
+
+static void isp_try_crop(struct stf_isp_dev *isp_dev,
+			 struct v4l2_subdev_state *state,
+			 struct v4l2_rect *rect,
+			 enum v4l2_subdev_format_whence which)
+{
+	struct v4l2_mbus_framefmt *fmt;
+
+	fmt = __isp_get_format(isp_dev, state, STF_ISP_PAD_SINK, which);
+
+	if (rect->width > fmt->width)
+		rect->width = fmt->width;
+
+	if (rect->width + rect->left > fmt->width)
+		rect->left = fmt->width - rect->width;
+
+	if (rect->height > fmt->height)
+		rect->height = fmt->height;
+
+	if (rect->height + rect->top > fmt->height)
+		rect->top = fmt->height - rect->height;
+
+	if (rect->width < STFCAMSS_FRAME_MIN_WIDTH) {
+		rect->left = 0;
+		rect->width = STFCAMSS_FRAME_MAX_WIDTH;
+	}
+
+	if (rect->height < STFCAMSS_FRAME_MIN_HEIGHT) {
+		rect->top = 0;
+		rect->height = STFCAMSS_FRAME_MAX_HEIGHT;
+	}
+	rect->height &= ~0x1;
+}
+
+static int isp_get_selection(struct v4l2_subdev *sd,
+			     struct v4l2_subdev_state *state,
+			     struct v4l2_subdev_selection *sel)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+	struct v4l2_subdev_format fmt = { 0 };
+	struct v4l2_rect *rect;
+	int ret;
+
+	switch (sel->target) {
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+		if (sel->pad == STF_ISP_PAD_SINK) {
+			fmt.pad = sel->pad;
+			fmt.which = sel->which;
+			ret = isp_get_format(sd, state, &fmt);
+			if (ret < 0)
+				return ret;
+
+			sel->r.left = 0;
+			sel->r.top = 0;
+			sel->r.width = fmt.format.width;
+			sel->r.height = fmt.format.height;
+		} else if (sel->pad == STF_ISP_PAD_SRC) {
+			rect = __isp_get_crop(isp_dev, state,
+					      sel->pad, sel->which);
+			sel->r = *rect;
+		}
+		break;
+
+	case V4L2_SEL_TGT_CROP:
+		rect = __isp_get_crop(isp_dev, state, sel->pad, sel->which);
+		if (!rect)
+			return -EINVAL;
+
+		sel->r = *rect;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int isp_set_selection(struct v4l2_subdev *sd,
+			     struct v4l2_subdev_state *state,
+			     struct v4l2_subdev_selection *sel)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+	struct v4l2_rect *rect;
+	int ret = 0;
+
+	if (sel->target == V4L2_SEL_TGT_CROP &&
+	    sel->pad == STF_ISP_PAD_SINK) {
+		struct v4l2_subdev_selection crop = { 0 };
+
+		rect = __isp_get_crop(isp_dev, state, sel->pad, sel->which);
+		if (!rect)
+			return -EINVAL;
+
+		mutex_lock(&isp_dev->stream_lock);
+		isp_try_crop(isp_dev, state, &sel->r, sel->which);
+		*rect = sel->r;
+		mutex_unlock(&isp_dev->stream_lock);
+
+		/* Reset source crop selection */
+		crop.which = sel->which;
+		crop.pad = STF_ISP_PAD_SRC;
+		crop.target = V4L2_SEL_TGT_CROP;
+		crop.r = *rect;
+		ret = isp_set_selection(sd, state, &crop);
+	} else if (sel->target == V4L2_SEL_TGT_CROP &&
+		   sel->pad == STF_ISP_PAD_SRC) {
+		struct v4l2_subdev_format fmt = { 0 };
+
+		rect = __isp_get_crop(isp_dev, state, sel->pad, sel->which);
+		if (!rect)
+			return -EINVAL;
+
+		mutex_lock(&isp_dev->stream_lock);
+		isp_try_crop(isp_dev, state, &sel->r, sel->which);
+		*rect = sel->r;
+		mutex_unlock(&isp_dev->stream_lock);
+
+		/* Reset source pad format width and height */
+		fmt.which = sel->which;
+		fmt.pad = STF_ISP_PAD_SRC;
+		fmt.format.width = rect->width;
+		fmt.format.height = rect->height;
+		ret = isp_set_format(sd, state, &fmt);
+		if (ret < 0)
+			return ret;
+	}
+
+	dev_dbg(isp_dev->stfcamss->dev, "pad: %d sel(%d,%d)/%dx%d\n",
+		sel->pad, sel->r.left, sel->r.top, sel->r.width, sel->r.height);
+
+	return 0;
+}
+
+static int isp_init_formats(struct v4l2_subdev *sd,
+			    struct v4l2_subdev_fh *fh)
+{
+	struct v4l2_subdev_format format = {
+		.pad = STF_ISP_PAD_SINK,
+		.which =
+			fh ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE,
+		.format = {
+			.code = MEDIA_BUS_FMT_RGB565_2X8_LE,
+			.width = 1920,
+			.height = 1080
+		}
+	};
+
+	return isp_set_format(sd, fh ? fh->state : NULL, &format);
+}
+
+static int isp_link_setup(struct media_entity *entity,
+			  const struct media_pad *local,
+			  const struct media_pad *remote, u32 flags)
+{
+	if (flags & MEDIA_LNK_FL_ENABLED)
+		if (media_pad_remote_pad_first(local))
+			return -EBUSY;
+	return 0;
+}
+
+static int stf_isp_subscribe_event(struct v4l2_subdev *sd,
+				   struct v4l2_fh *fh,
+				   struct v4l2_event_subscription *sub)
+{
+	switch (sub->type) {
+	case V4L2_EVENT_SOURCE_CHANGE:
+		return v4l2_src_change_event_subdev_subscribe(sd, fh, sub);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct v4l2_subdev_core_ops isp_core_ops = {
+	.s_power = isp_set_power,
+	.subscribe_event = stf_isp_subscribe_event,
+	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
+};
+
+static const struct v4l2_subdev_video_ops isp_video_ops = {
+	.s_stream = isp_set_stream,
+};
+
+static const struct v4l2_subdev_pad_ops isp_pad_ops = {
+	.enum_mbus_code = isp_enum_mbus_code,
+	.enum_frame_size = isp_enum_frame_size,
+	.get_fmt = isp_get_format,
+	.set_fmt = isp_set_format,
+	.get_selection = isp_get_selection,
+	.set_selection = isp_set_selection,
+};
+
+static const struct v4l2_subdev_ops isp_v4l2_ops = {
+	.core = &isp_core_ops,
+	.video = &isp_video_ops,
+	.pad = &isp_pad_ops,
+};
+
+static const struct v4l2_subdev_internal_ops isp_v4l2_internal_ops = {
+	.open = isp_init_formats,
+};
+
+static const struct media_entity_operations isp_media_ops = {
+	.link_setup = isp_link_setup,
+	.link_validate = v4l2_subdev_link_validate,
+};
+
+int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev)
+{
+	struct v4l2_subdev *sd = &isp_dev->subdev;
+	struct media_pad *pads = isp_dev->pads;
+	int ret;
+
+	v4l2_subdev_init(sd, &isp_v4l2_ops);
+	sd->internal_ops = &isp_v4l2_internal_ops;
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
+	snprintf(sd->name, ARRAY_SIZE(sd->name), "%s%d", STF_ISP_NAME, 0);
+	v4l2_set_subdevdata(sd, isp_dev);
+
+	ret = isp_init_formats(sd, NULL);
+	if (ret < 0) {
+		dev_err(isp_dev->stfcamss->dev, "Failed to init format: %d\n",
+			ret);
+		return ret;
+	}
+
+	pads[STF_ISP_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+	pads[STF_ISP_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
+
+	sd->entity.function = MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
+	sd->entity.ops = &isp_media_ops;
+	ret = media_entity_pads_init(&sd->entity, STF_ISP_PAD_MAX, pads);
+	if (ret < 0) {
+		dev_err(isp_dev->stfcamss->dev,
+			"Failed to init media entity: %d\n", ret);
+		return ret;
+	}
+
+	ret = v4l2_device_register_subdev(v4l2_dev, sd);
+	if (ret < 0) {
+		dev_err(isp_dev->stfcamss->dev,
+			"Failed to register subdev: %d\n", ret);
+		goto err_sreg;
+	}
+
+	return 0;
+
+err_sreg:
+	media_entity_cleanup(&sd->entity);
+	return ret;
+}
+
+int stf_isp_unregister(struct stf_isp_dev *isp_dev)
+{
+	v4l2_device_unregister_subdev(&isp_dev->subdev);
+	media_entity_cleanup(&isp_dev->subdev.entity);
+	mutex_destroy(&isp_dev->stream_lock);
+	mutex_destroy(&isp_dev->power_lock);
+	return 0;
+}
diff --git a/drivers/media/platform/starfive/stf_isp.h b/drivers/media/platform/starfive/stf_isp.h
new file mode 100644
index 000000000000..45bf20af020d
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_isp.h
@@ -0,0 +1,483 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * stf_isp.h
+ *
+ * StarFive Camera Subsystem - ISP Module
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+
+#ifndef STF_ISP_H
+#define STF_ISP_H
+
+#include <media/media-entity.h>
+#include <media/v4l2-subdev.h>
+
+#include "stf_video.h"
+
+#define ISP_RAW_DATA_BITS       12
+#define SCALER_RATIO_MAX        1
+#define STF_ISP_REG_OFFSET_MAX  0x0fff
+#define STF_ISP_REG_DELAY_MAX   100
+
+/* isp registers */
+#define ISP_REG_CSI_INPUT_EN_AND_STATUS	0x000
+#define CSI_SCD_ERR	BIT(6)
+#define CSI_ITU656_ERR	BIT(4)
+#define CSI_ITU656_F	BIT(3)
+#define CSI_SCD_DONE	BIT(2)
+#define CSI_BUSY_S	BIT(1)
+#define CSI_EN_S	BIT(0)
+
+#define ISP_REG_CSIINTS	0x008
+#define CSI_INTS(n)	((n) << 16)
+#define CSI_SHA_M(n)	((n) << 0)
+#define CSI_INTS_MASK	GENMASK(17, 16)
+
+#define ISP_REG_CSI_MODULE_CFG	0x010
+#define CSI_DUMP_EN	BIT(19)
+#define CSI_VS_EN	BIT(18)
+#define CSI_SC_EN	BIT(17)
+#define CSI_OBA_EN	BIT(16)
+#define CSI_AWB_EN	BIT(7)
+#define CSI_LCCF_EN	BIT(6)
+#define CSI_OECFHM_EN	BIT(5)
+#define CSI_OECF_EN	BIT(4)
+#define CSI_LCBQ_EN	BIT(3)
+#define CSI_OBC_EN	BIT(2)
+#define CSI_DEC_EN	BIT(1)
+#define CSI_DC_EN	BIT(0)
+
+#define ISP_REG_SENSOR	0x014
+#define DVP_SYNC_POL(n)	((n) << 2)
+#define ITU656_EN(n)	((n) << 1)
+#define IMAGER_SEL(n)	((n) << 0)
+
+#define ISP_REG_RAW_FORMAT_CFG	0x018
+#define SMY13(n)	((n) << 14)
+#define SMY12(n)	((n) << 12)
+#define SMY11(n)	((n) << 10)
+#define SMY10(n)	((n) << 8)
+#define SMY3(n)	((n) << 6)
+#define SMY2(n)	((n) << 4)
+#define SMY1(n)	((n) << 2)
+#define SMY0(n)	((n) << 0)
+
+#define ISP_REG_PIC_CAPTURE_START_CFG	0x01c
+#define VSTART_CAP(n)	((n) << 16)
+#define HSTART_CAP(n)	((n) << 0)
+
+#define ISP_REG_PIC_CAPTURE_END_CFG	0x020
+#define VEND_CAP(n)	((n) << 16)
+#define HEND_CAP(n)	((n) << 0)
+
+#define ISP_REG_DUMP_CFG_0	0x024
+#define ISP_REG_DUMP_CFG_1	0x028
+#define DUMP_ID(n)	((n) << 24)
+#define DUMP_SHT(n)	((n) << 20)
+#define DUMP_BURST_LEN(n)	((n) << 16)
+#define DUMP_SD(n)	((n) << 0)
+#define DUMP_BURST_LEN_MASK	GENMASK(17, 16)
+#define DUMP_SD_MASK	GENMASK(15, 0)
+
+#define ISP_REG_DEC_CFG	0x030
+#define DEC_V_KEEP(n)	((n) << 24)
+#define DEC_V_PERIOD(n)	((n) << 16)
+#define DEC_H_KEEP(n)	((n) << 8)
+#define DEC_H_PERIOD(n)	((n) << 0)
+
+#define ISP_REG_OBC_CFG	0x034
+#define OBC_W_H(y)	((y) << 4)
+#define OBC_W_W(x)	((x) << 0)
+
+#define ISP_REG_DC_CFG_1	0x044
+#define DC_AXI_ID(n)	((n) << 0)
+
+#define ISP_REG_LCCF_CFG_0	0x050
+#define Y_DISTANCE(y)	((y) << 16)
+#define X_DISTANCE(x)	((x) << 0)
+
+#define ISP_REG_LCCF_CFG_1	0x058
+#define LCCF_MAX_DIS(n)	((n) << 0)
+
+#define ISP_REG_LCBQ_CFG_0	0x074
+#define H_LCBQ(y)	((y) << 12)
+#define W_LCBQ(x)	((x) << 8)
+
+#define ISP_REG_LCBQ_CFG_1	0x07c
+#define Y_COOR(y)	((y) << 16)
+#define X_COOR(x)	((x) << 0)
+
+#define ISP_REG_LCCF_CFG_2	0x0e0
+#define ISP_REG_LCCF_CFG_3	0x0e4
+#define ISP_REG_LCCF_CFG_4	0x0e8
+#define ISP_REG_LCCF_CFG_5	0x0ec
+#define LCCF_F2_PAR(n)	((n) << 16)
+#define LCCF_F1_PAR(n)	((n) << 0)
+
+#define ISP_REG_OECF_X0_CFG0	0x100
+#define ISP_REG_OECF_X0_CFG1	0x104
+#define ISP_REG_OECF_X0_CFG2	0x108
+#define ISP_REG_OECF_X0_CFG3	0x10c
+#define ISP_REG_OECF_X0_CFG4	0x110
+#define ISP_REG_OECF_X0_CFG5	0x114
+#define ISP_REG_OECF_X0_CFG6	0x118
+#define ISP_REG_OECF_X0_CFG7	0x11c
+
+#define ISP_REG_OECF_Y3_CFG0	0x1e0
+#define ISP_REG_OECF_Y3_CFG1	0x1e4
+#define ISP_REG_OECF_Y3_CFG2	0x1e8
+#define ISP_REG_OECF_Y3_CFG3	0x1ec
+#define ISP_REG_OECF_Y3_CFG4	0x1f0
+#define ISP_REG_OECF_Y3_CFG5	0x1f4
+#define ISP_REG_OECF_Y3_CFG6	0x1f8
+#define ISP_REG_OECF_Y3_CFG7	0x1fc
+
+#define ISP_REG_OECF_S0_CFG0	0x200
+#define ISP_REG_OECF_S3_CFG7	0x27c
+#define OCEF_PAR_H(n)	((n) << 16)
+#define OCEF_PAR_L(n)	((n) << 0)
+
+#define ISP_REG_AWB_X0_CFG_0	0x280
+#define ISP_REG_AWB_X0_CFG_1	0x284
+#define ISP_REG_AWB_X1_CFG_0	0x288
+#define ISP_REG_AWB_X1_CFG_1	0x28c
+#define ISP_REG_AWB_X2_CFG_0	0x290
+#define ISP_REG_AWB_X2_CFG_1	0x294
+#define ISP_REG_AWB_X3_CFG_0	0x298
+#define ISP_REG_AWB_X3_CFG_1	0x29c
+#define AWB_X_SYMBOL_H(n)	((n) << 16)
+#define AWB_X_SYMBOL_L(n)	((n) << 0)
+
+#define ISP_REG_AWB_Y0_CFG_0	0x2a0
+#define ISP_REG_AWB_Y0_CFG_1	0x2a4
+#define ISP_REG_AWB_Y1_CFG_0	0x2a8
+#define ISP_REG_AWB_Y1_CFG_1	0x2ac
+#define ISP_REG_AWB_Y2_CFG_0	0x2b0
+#define ISP_REG_AWB_Y2_CFG_1	0x2b4
+#define ISP_REG_AWB_Y3_CFG_0	0x2b8
+#define ISP_REG_AWB_Y3_CFG_1	0x2bc
+#define AWB_Y_SYMBOL_H(n)	((n) << 16)
+#define AWB_Y_SYMBOL_L(n)	((n) << 0)
+
+#define ISP_REG_AWB_S0_CFG_0	0x2c0
+#define ISP_REG_AWB_S0_CFG_1	0x2c4
+#define ISP_REG_AWB_S1_CFG_0	0x2c8
+#define ISP_REG_AWB_S1_CFG_1	0x2cc
+#define ISP_REG_AWB_S2_CFG_0	0x2d0
+#define ISP_REG_AWB_S2_CFG_1	0x2d4
+#define ISP_REG_AWB_S3_CFG_0	0x2d8
+#define ISP_REG_AWB_S3_CFG_1	0x2dc
+#define AWB_S_SYMBOL_H(n)	((n) << 16)
+#define AWB_S_SYMBOL_L(n)	((n) << 0)
+
+#define ISP_REG_OBCG_CFG_0	0x2e0
+#define ISP_REG_OBCG_CFG_1	0x2e4
+#define ISP_REG_OBCG_CFG_2	0x2e8
+#define ISP_REG_OBCG_CFG_3	0x2ec
+#define ISP_REG_OBCO_CFG_0	0x2f0
+#define ISP_REG_OBCO_CFG_1	0x2f4
+#define ISP_REG_OBCO_CFG_2	0x2f8
+#define ISP_REG_OBCO_CFG_3	0x2fc
+#define GAIN_D_POINT(x)	((x) << 24)
+#define GAIN_C_POINT(x)	((x) << 16)
+#define GAIN_B_POINT(x)	((x) << 8)
+#define GAIN_A_POINT(x)	((x) << 0)
+#define OFFSET_D_POINT(x)	((x) << 24)
+#define OFFSET_C_POINT(x)	((x) << 16)
+#define OFFSET_B_POINT(x)	((x) << 8)
+#define OFFSET_A_POINT(x)	((x) << 0)
+
+#define ISP_REG_ISP_CTRL_0	0xa00
+#define ISPC_SCFEINT	BIT(27)
+#define ISPC_VSFWINT	BIT(26)
+#define ISPC_VSINT	BIT(25)
+#define ISPC_INTS	BIT(24)
+#define ISPC_ENUO	BIT(20)
+#define ISPC_ENLS	BIT(17)
+#define ISPC_ENSS1	BIT(12)
+#define ISPC_ENSS0	BIT(11)
+#define ISPC_RST	BIT(1)
+#define ISPC_EN	BIT(0)
+#define ISPC_RST_MASK	BIT(1)
+
+#define ISP_REG_ISP_CTRL_1	0xa08
+#define CTRL_SAT(n)	((n) << 28)
+#define CTRL_DBC	BIT(22)
+#define CTRL_CTC	BIT(21)
+#define CTRL_YHIST	BIT(20)
+#define CTRL_YCURVE	BIT(19)
+#define CTRL_CTM	BIT(18)
+#define CTRL_BIYUV	BIT(17)
+#define CTRL_SCE	BIT(8)
+#define CTRL_EE	BIT(7)
+#define CTRL_CCE	BIT(5)
+#define CTRL_RGE	BIT(4)
+#define CTRL_CME	BIT(3)
+#define CTRL_AE	BIT(2)
+#define CTRL_CE	BIT(1)
+#define CTRL_SAT_MASK	GENMASK(31, 28)
+
+#define ISP_REG_PIPELINE_XY_SIZE	0xa0c
+#define H_ACT_CAP(n)	((n) << 16)
+#define W_ACT_CAP(n)	((n) << 0)
+
+#define ISP_REG_ICTC	0xa10
+#define GF_MODE(n)	((n) << 30)
+#define MAXGT(n)	((n) << 16)
+#define MINGT(n)	((n) << 0)
+
+#define ISP_REG_IDBC	0xa14
+#define BADGT(n)	((n) << 16)
+#define BADXT(n)	((n) << 0)
+
+#define ISP_REG_ICFAM	0xa1c
+#define CROSS_COV(n)	((n) << 4)
+#define HV_W(n)	((n) << 0)
+
+#define ISP_REG_CS_GAIN	0xa30
+#define CMAD(n)	((n) << 16)
+#define CMAB(n)	((n) << 0)
+
+#define ISP_REG_CS_THRESHOLD	0xa34
+#define CMD(n)	((n) << 16)
+#define CMB(n)	((n) << 0)
+
+#define ISP_REG_CS_OFFSET	0xa38
+#define VOFF(n)	((n) << 16)
+#define UOFF(n)	((n) << 0)
+
+#define ISP_REG_CS_HUE_F	0xa3c
+#define SIN(n)	((n) << 16)
+#define COS(n)	((n) << 0)
+
+#define ISP_REG_CS_SCALE	0xa40
+#define CMSF(n)	((n) << 0)
+
+#define ISP_REG_IESHD	0xa50
+#define SHAD_UP_M	BIT(1)
+#define SHAD_UP_EN	BIT(0)
+
+#define ISP_REG_YADJ0	0xa54
+#define YOIR(n)	((n) << 16)
+#define YIMIN(n)	((n) << 0)
+
+#define ISP_REG_YADJ1	0xa58
+#define YOMAX(n)	((n) << 16)
+#define YOMIN(n)	((n) << 0)
+
+#define ISP_REG_Y_PLANE_START_ADDR	0xa80
+#define ISP_REG_UV_PLANE_START_ADDR	0xa84
+
+#define ISP_REG_STRIDE	0xa88
+#define IMG_STR(n)	((n) << 0)
+
+#define ISP_REG_ITIIWSR	0xb20
+#define ITI_HSIZE(n)	((n) << 16)
+#define ITI_WSIZE(n)	((n) << 0)
+
+#define ISP_REG_ITIDWLSR	0xb24
+#define ITI_WSTRIDE(n)	((n) << 0)
+
+#define ISP_REG_ITIPDFR	0xb38
+#define ITI_PACKAGE_FMT(n)	((n) << 0)
+
+#define ISP_REG_ITIDRLSR	0xb3C
+#define ITI_STRIDE_L(n)	((n) << 0)
+
+#define ISP_REG_DNYUV_YSWR0	0xc00
+#define ISP_REG_DNYUV_YSWR1	0xc04
+#define ISP_REG_DNYUV_CSWR0	0xc08
+#define ISP_REG_DNYUV_CSWR1	0xc0c
+#define YUVSW5(n)	((n) << 20)
+#define YUVSW4(n)	((n) << 16)
+#define YUVSW3(n)	((n) << 12)
+#define YUVSW2(n)	((n) << 8)
+#define YUVSW1(n)	((n) << 4)
+#define YUVSW0(n)	((n) << 0)
+
+#define ISP_REG_DNYUV_YDR0	0xc10
+#define ISP_REG_DNYUV_YDR1	0xc14
+#define ISP_REG_DNYUV_YDR2	0xc18
+#define ISP_REG_DNYUV_CDR0	0xc1c
+#define ISP_REG_DNYUV_CDR1	0xc20
+#define ISP_REG_DNYUV_CDR2	0xc24
+#define CURVE_D_H(n)	((n) << 16)
+#define CURVE_D_L(n)	((n) << 0)
+
+#define ISP_REG_ICAMD_0	0xc40
+#define DNRM_F(n)	((n) << 16)
+#define ISP_REG_ICAMD_12	0xc70
+#define ISP_REG_ICAMD_20	0xc90
+#define ISP_REG_ICAMD_24	0xca0
+#define ISP_REG_ICAMD_25	0xca4
+#define CCM_M_DAT(n)	((n) << 0)
+
+#define ISP_REG_GAMMA_VAL0	0xe00
+#define ISP_REG_GAMMA_VAL1	0xe04
+#define ISP_REG_GAMMA_VAL2	0xe08
+#define ISP_REG_GAMMA_VAL3	0xe0c
+#define ISP_REG_GAMMA_VAL4	0xe10
+#define ISP_REG_GAMMA_VAL5	0xe14
+#define ISP_REG_GAMMA_VAL6	0xe18
+#define ISP_REG_GAMMA_VAL7	0xe1c
+#define ISP_REG_GAMMA_VAL8	0xe20
+#define ISP_REG_GAMMA_VAL9	0xe24
+#define ISP_REG_GAMMA_VAL10	0xe28
+#define ISP_REG_GAMMA_VAL11	0xe2c
+#define ISP_REG_GAMMA_VAL12	0xe30
+#define ISP_REG_GAMMA_VAL13	0xe34
+#define ISP_REG_GAMMA_VAL14	0xe38
+#define GAMMA_S_VAL(n)	((n) << 16)
+#define GAMMA_VAL(n)	((n) << 0)
+
+#define ISP_REG_R2Y_0	0xe40
+#define ISP_REG_R2Y_1	0xe44
+#define ISP_REG_R2Y_2	0xe48
+#define ISP_REG_R2Y_3	0xe4c
+#define ISP_REG_R2Y_4	0xe50
+#define ISP_REG_R2Y_5	0xe54
+#define ISP_REG_R2Y_6	0xe58
+#define ISP_REG_R2Y_7	0xe5c
+#define ISP_REG_R2Y_8	0xe60
+#define CSC_M(n)	((n) << 0)
+
+#define ISP_REG_SHARPEN0	0xe80
+#define ISP_REG_SHARPEN1	0xe84
+#define ISP_REG_SHARPEN2	0xe88
+#define ISP_REG_SHARPEN3	0xe8c
+#define ISP_REG_SHARPEN4	0xe90
+#define ISP_REG_SHARPEN5	0xe94
+#define ISP_REG_SHARPEN6	0xe98
+#define ISP_REG_SHARPEN7	0xe9c
+#define ISP_REG_SHARPEN8	0xea0
+#define ISP_REG_SHARPEN9	0xea4
+#define ISP_REG_SHARPEN10	0xea8
+#define ISP_REG_SHARPEN11	0xeac
+#define ISP_REG_SHARPEN12	0xeb0
+#define ISP_REG_SHARPEN13	0xeb4
+#define ISP_REG_SHARPEN14	0xeb8
+#define S_DELTA(n)	((n) << 16)
+#define S_WEIGHT(n)	((n) << 8)
+
+#define ISP_REG_SHARPEN_FS0	0xebc
+#define ISP_REG_SHARPEN_FS1	0xec0
+#define ISP_REG_SHARPEN_FS2	0xec4
+#define ISP_REG_SHARPEN_FS3	0xec8
+#define ISP_REG_SHARPEN_FS4	0xecc
+#define ISP_REG_SHARPEN_FS5	0xed0
+#define S_FACTOR(n)	((n) << 24)
+#define S_SLOPE(n)	((n) << 0)
+
+#define ISP_REG_SHARPEN_WN	0xed4
+#define PDIRF(n)	((n) << 28)
+#define NDIRF(n)	((n) << 24)
+#define WSUM(n)	((n) << 0)
+
+#define ISP_REG_IUVS1	0xed8
+#define UVDIFF2(n)	((n) << 16)
+#define UVDIFF1(n)	((n) << 0)
+
+#define ISP_REG_IUVS2	0xedc
+#define UVF(n)	((n) << 24)
+#define UVSLOPE(n)	((n) << 0)
+
+#define ISP_REG_IUVCKS1	0xee0
+#define UVCKDIFF2(n)	((n) << 16)
+#define UVCKDIFF1(n)	((n) << 0)
+
+#define ISP_REG_IUVCKS2	0xee4
+#define UVCKSLOPE(n)	((n) << 0)
+
+#define ISP_REG_ISHRPET	0xee8
+#define TH(n)	((n) << 8)
+#define EN(n)	((n) << 0)
+
+#define ISP_REG_YCURVE_0	0xf00
+#define ISP_REG_YCURVE_63	0xffc
+#define L_PARAM(n)	((n) << 0)
+
+#define IMAGE_MAX_WIDTH	1920
+#define IMAGE_MAX_HEIGH	1080
+
+/* The output line of ISP */
+enum isp_line_id {
+	STF_ISP_LINE_INVALID = -1,
+	STF_ISP_LINE_SRC = 1,
+	STF_ISP_LINE_MAX = STF_ISP_LINE_SRC
+};
+
+/* pad id for media framework */
+enum isp_pad_id {
+	STF_ISP_PAD_SINK = 0,
+	STF_ISP_PAD_SRC,
+	STF_ISP_PAD_MAX
+};
+
+enum {
+	EN_INT_NONE                 = 0,
+	EN_INT_ISP_DONE             = (0x1 << 24),
+	EN_INT_CSI_DONE             = (0x1 << 25),
+	EN_INT_SC_DONE              = (0x1 << 26),
+	EN_INT_LINE_INT             = (0x1 << 27),
+	EN_INT_ALL                  = (0xF << 24),
+};
+
+enum {
+	INTERFACE_DVP = 0,
+	INTERFACE_CSI,
+};
+
+struct isp_format {
+	u32 code;
+	u8 bpp;
+};
+
+struct isp_format_table {
+	const struct isp_format *fmts;
+	int nfmts;
+};
+
+struct regval_t {
+	u32 addr;
+	u32 val;
+	u32 delay_ms;
+};
+
+struct reg_table {
+	const struct regval_t *regval;
+	int regval_num;
+};
+
+struct stf_isp_crop {
+	struct v4l2_rect rect;
+	u32 bpp;
+};
+
+struct stf_isp_dev {
+	enum stf_subdev_type sdev_type;  /* This member must be first */
+	struct stfcamss *stfcamss;
+	struct v4l2_subdev subdev;
+	struct media_pad pads[STF_ISP_PAD_MAX];
+	struct v4l2_mbus_framefmt fmt[STF_ISP_PAD_MAX];
+	struct stf_isp_crop rect[STF_ISP_PAD_MAX];
+	const struct isp_format_table *formats;
+	unsigned int nformats;
+	struct mutex power_lock;	/* serialize power control*/
+	int power_count;
+	struct mutex stream_lock;	/* serialize stream control */
+	int stream_count;
+};
+
+int stf_isp_clk_enable(struct stf_isp_dev *isp_dev);
+int stf_isp_clk_disable(struct stf_isp_dev *isp_dev);
+int stf_isp_reset(struct stf_isp_dev *isp_dev);
+void stf_isp_init_cfg(struct stf_isp_dev *isp_dev);
+void stf_isp_settings(struct stf_isp_dev *isp_dev,
+		      struct stf_isp_crop *crop_array, u32 mcode);
+void stf_isp_stream_set(struct stf_isp_dev *isp_dev);
+int stf_isp_subdev_init(struct stfcamss *stfcamss);
+int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev);
+int stf_isp_unregister(struct stf_isp_dev *isp_dev);
+
+#endif /* STF_ISP_H */
diff --git a/drivers/media/platform/starfive/stf_isp_hw_ops.c b/drivers/media/platform/starfive/stf_isp_hw_ops.c
new file mode 100644
index 000000000000..2088b6bd0d61
--- /dev/null
+++ b/drivers/media/platform/starfive/stf_isp_hw_ops.c
@@ -0,0 +1,468 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stf_isp_hw_ops.c
+ *
+ * Register interface file for StarFive ISP driver
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ *
+ */
+
+#include "stf_camss.h"
+
+static void stf_isp_config_obc(struct stfcamss *stfcamss)
+{
+	u32 reg_val, reg_add;
+
+	stf_isp_reg_write(stfcamss, ISP_REG_OBC_CFG, OBC_W_H(11) | OBC_W_W(11));
+
+	reg_val = GAIN_D_POINT(0x40) | GAIN_C_POINT(0x40) |
+		  GAIN_B_POINT(0x40) | GAIN_A_POINT(0x40);
+	for (reg_add = ISP_REG_OBCG_CFG_0; reg_add <= ISP_REG_OBCG_CFG_3;) {
+		stf_isp_reg_write(stfcamss, reg_add, reg_val);
+		reg_add += 4;
+	}
+
+	reg_val = OFFSET_D_POINT(0) | OFFSET_C_POINT(0) |
+		  OFFSET_B_POINT(0) | OFFSET_A_POINT(0);
+	for (reg_add = ISP_REG_OBCO_CFG_0; reg_add <= ISP_REG_OBCO_CFG_3;) {
+		stf_isp_reg_write(stfcamss, reg_add, reg_val);
+		reg_add += 4;
+	}
+}
+
+static void stf_isp_config_oecf(struct stfcamss *stfcamss)
+{
+	u32 reg_add, par_val;
+	u16 par_h, par_l;
+
+	par_h = 0x10; par_l = 0;
+	par_val = OCEF_PAR_H(par_h) | OCEF_PAR_L(par_l);
+	for (reg_add = ISP_REG_OECF_X0_CFG0; reg_add <= ISP_REG_OECF_Y3_CFG0;) {
+		stf_isp_reg_write(stfcamss, reg_add, par_val);
+		reg_add += 0x20;
+	}
+
+	par_h = 0x40; par_l = 0x20;
+	par_val = OCEF_PAR_H(par_h) | OCEF_PAR_L(par_l);
+	for (reg_add = ISP_REG_OECF_X0_CFG1; reg_add <= ISP_REG_OECF_Y3_CFG1;) {
+		stf_isp_reg_write(stfcamss, reg_add, par_val);
+		reg_add += 0x20;
+	}
+
+	par_h = 0x80; par_l = 0x60;
+	par_val = OCEF_PAR_H(par_h) | OCEF_PAR_L(par_l);
+	for (reg_add = ISP_REG_OECF_X0_CFG2; reg_add <= ISP_REG_OECF_Y3_CFG2;) {
+		stf_isp_reg_write(stfcamss, reg_add, par_val);
+		reg_add += 0x20;
+	}
+
+	par_h = 0xc0; par_l = 0xa0;
+	par_val = OCEF_PAR_H(par_h) | OCEF_PAR_L(par_l);
+	for (reg_add = ISP_REG_OECF_X0_CFG3; reg_add <= ISP_REG_OECF_Y3_CFG3;) {
+		stf_isp_reg_write(stfcamss, reg_add, par_val);
+		reg_add += 0x20;
+	}
+
+	par_h = 0x100; par_l = 0xe0;
+	par_val = OCEF_PAR_H(par_h) | OCEF_PAR_L(par_l);
+	for (reg_add = ISP_REG_OECF_X0_CFG4; reg_add <= ISP_REG_OECF_Y3_CFG4;) {
+		stf_isp_reg_write(stfcamss, reg_add, par_val);
+		reg_add += 0x20;
+	}
+
+	par_h = 0x200; par_l = 0x180;
+	par_val = OCEF_PAR_H(par_h) | OCEF_PAR_L(par_l);
+	for (reg_add = ISP_REG_OECF_X0_CFG5; reg_add <= ISP_REG_OECF_Y3_CFG5;) {
+		stf_isp_reg_write(stfcamss, reg_add, par_val);
+		reg_add += 0x20;
+	}
+
+	par_h = 0x300; par_l = 0x280;
+	par_val = OCEF_PAR_H(par_h) | OCEF_PAR_L(par_l);
+	for (reg_add = ISP_REG_OECF_X0_CFG6; reg_add <= ISP_REG_OECF_Y3_CFG6;) {
+		stf_isp_reg_write(stfcamss, reg_add, par_val);
+		reg_add += 0x20;
+	}
+
+	par_h = 0x3fe; par_l = 0x380;
+	par_val = OCEF_PAR_H(par_h) | OCEF_PAR_L(par_l);
+	for (reg_add = ISP_REG_OECF_X0_CFG7; reg_add <= ISP_REG_OECF_Y3_CFG7;) {
+		stf_isp_reg_write(stfcamss, reg_add, par_val);
+		reg_add += 0x20;
+	}
+
+	par_h = 0x80; par_l = 0x80;
+	par_val = OCEF_PAR_H(par_h) | OCEF_PAR_L(par_l);
+	for (reg_add = ISP_REG_OECF_S0_CFG0; reg_add <= ISP_REG_OECF_S3_CFG7;) {
+		stf_isp_reg_write(stfcamss, reg_add, par_val);
+		reg_add += 4;
+	}
+}
+
+static void stf_isp_config_lccf(struct stfcamss *stfcamss)
+{
+	u32 reg_add;
+
+	stf_isp_reg_write(stfcamss, ISP_REG_LCCF_CFG_0,
+			  Y_DISTANCE(0x21C) | X_DISTANCE(0x3C0));
+	stf_isp_reg_write(stfcamss, ISP_REG_LCCF_CFG_1, LCCF_MAX_DIS(0xb));
+
+	for (reg_add = ISP_REG_LCCF_CFG_2; reg_add <= ISP_REG_LCCF_CFG_5;) {
+		stf_isp_reg_write(stfcamss, reg_add,
+				  LCCF_F2_PAR(0x0) | LCCF_F1_PAR(0x0));
+		reg_add += 4;
+	}
+}
+
+static void stf_isp_config_awb(struct stfcamss *stfcamss)
+{
+	u32 reg_val, reg_add;
+	u16 symbol_h, symbol_l;
+
+	symbol_h = 0x0; symbol_l = 0x0;
+	reg_val = AWB_X_SYMBOL_H(symbol_h) | AWB_X_SYMBOL_L(symbol_l);
+
+	for (reg_add = ISP_REG_AWB_X0_CFG_0; reg_add <= ISP_REG_AWB_X3_CFG_1;) {
+		stf_isp_reg_write(stfcamss, reg_add, reg_val);
+		reg_add += 4;
+	}
+
+	symbol_h = 0x0, symbol_l = 0x0;
+	reg_val = AWB_Y_SYMBOL_H(symbol_h) | AWB_Y_SYMBOL_L(symbol_l);
+
+	for (reg_add = ISP_REG_AWB_Y0_CFG_0; reg_add <= ISP_REG_AWB_Y3_CFG_1;) {
+		stf_isp_reg_write(stfcamss, reg_add, reg_val);
+		reg_add += 4;
+	}
+
+	symbol_h = 0x80, symbol_l = 0x80;
+	reg_val = AWB_S_SYMBOL_H(symbol_h) | AWB_S_SYMBOL_L(symbol_l);
+
+	for (reg_add = ISP_REG_AWB_S0_CFG_0; reg_add <= ISP_REG_AWB_S3_CFG_1;) {
+		stf_isp_reg_write(stfcamss, reg_add, reg_val);
+		reg_add += 4;
+	}
+}
+
+static void stf_isp_config_grgb(struct stfcamss *stfcamss)
+{
+	stf_isp_reg_write(stfcamss, ISP_REG_ICTC,
+			  GF_MODE(1) | MAXGT(0x140) | MINGT(0x40));
+	stf_isp_reg_write(stfcamss, ISP_REG_IDBC, BADGT(0x200) | BADXT(0x200));
+}
+
+static void stf_isp_config_cfa(struct stfcamss *stfcamss)
+{
+	stf_isp_reg_write(stfcamss, ISP_REG_RAW_FORMAT_CFG,
+			  SMY13(0) | SMY12(1) | SMY11(0) | SMY10(1) | SMY3(2) |
+			  SMY2(3) | SMY1(2) | SMY0(3));
+	stf_isp_reg_write(stfcamss, ISP_REG_ICFAM, CROSS_COV(3) | HV_W(2));
+}
+
+static void stf_isp_config_ccm(struct stfcamss *stfcamss)
+{
+	u32 reg_add;
+
+	stf_isp_reg_write(stfcamss, ISP_REG_ICAMD_0, DNRM_F(6) | CCM_M_DAT(0));
+
+	for (reg_add = ISP_REG_ICAMD_12; reg_add <= ISP_REG_ICAMD_20;) {
+		stf_isp_reg_write(stfcamss, reg_add, CCM_M_DAT(0x80));
+		reg_add += 0x10;
+	}
+
+	stf_isp_reg_write(stfcamss, ISP_REG_ICAMD_24, CCM_M_DAT(0x700));
+	stf_isp_reg_write(stfcamss, ISP_REG_ICAMD_25, CCM_M_DAT(0x200));
+}
+
+static void stf_isp_config_gamma(struct stfcamss *stfcamss)
+{
+	u32 reg_val, reg_add;
+	u16 gamma_slope_v, gamma_v;
+
+	gamma_slope_v = 0x2400; gamma_v = 0x0;
+	reg_val = GAMMA_S_VAL(gamma_slope_v) | GAMMA_VAL(gamma_v);
+	stf_isp_reg_write(stfcamss, ISP_REG_GAMMA_VAL0, reg_val);
+
+	gamma_slope_v = 0x800; gamma_v = 0x20;
+	for (reg_add = ISP_REG_GAMMA_VAL1; reg_add <= ISP_REG_GAMMA_VAL7;) {
+		reg_val = GAMMA_S_VAL(gamma_slope_v) | GAMMA_VAL(gamma_v);
+		stf_isp_reg_write(stfcamss, reg_add, reg_val);
+		reg_add += 4;
+		gamma_v += 0x20;
+	}
+
+	gamma_v = 0x100;
+	for (reg_add = ISP_REG_GAMMA_VAL8; reg_add <= ISP_REG_GAMMA_VAL13;) {
+		reg_val = GAMMA_S_VAL(gamma_slope_v) | GAMMA_VAL(gamma_v);
+		stf_isp_reg_write(stfcamss, reg_add, reg_val);
+		reg_add += 4;
+		gamma_v += 0x80;
+	}
+
+	gamma_v = 0x3fe;
+	reg_val = GAMMA_S_VAL(gamma_slope_v) | GAMMA_VAL(gamma_v);
+	stf_isp_reg_write(stfcamss, ISP_REG_GAMMA_VAL14, reg_val);
+}
+
+static void stf_isp_config_r2y(struct stfcamss *stfcamss)
+{
+	stf_isp_reg_write(stfcamss, ISP_REG_R2Y_0, CSC_M(0x4C));
+	stf_isp_reg_write(stfcamss, ISP_REG_R2Y_1, CSC_M(0x97));
+	stf_isp_reg_write(stfcamss, ISP_REG_R2Y_2, CSC_M(0x1d));
+	stf_isp_reg_write(stfcamss, ISP_REG_R2Y_3, CSC_M(0x1d5));
+	stf_isp_reg_write(stfcamss, ISP_REG_R2Y_4, CSC_M(0x1ac));
+	stf_isp_reg_write(stfcamss, ISP_REG_R2Y_5, CSC_M(0x80));
+	stf_isp_reg_write(stfcamss, ISP_REG_R2Y_6, CSC_M(0x80));
+	stf_isp_reg_write(stfcamss, ISP_REG_R2Y_7, CSC_M(0x194));
+	stf_isp_reg_write(stfcamss, ISP_REG_R2Y_8, CSC_M(0x1ec));
+}
+
+static void stf_isp_config_y_curve(struct stfcamss *stfcamss)
+{
+	u32 reg_add;
+	u16 y_curve;
+
+	y_curve = 0x0;
+	for (reg_add = ISP_REG_YCURVE_0; reg_add <= ISP_REG_YCURVE_63;) {
+		stf_isp_reg_write(stfcamss, reg_add, y_curve);
+		reg_add += 4;
+		y_curve += 0x10;
+	}
+}
+
+static void stf_isp_config_sharpen(struct stfcamss *sc)
+{
+	u32 reg_add;
+
+	stf_isp_reg_write(sc, ISP_REG_SHARPEN0, S_DELTA(0x7) | S_WEIGHT(0xf));
+	stf_isp_reg_write(sc, ISP_REG_SHARPEN1, S_DELTA(0x18) | S_WEIGHT(0xf));
+	stf_isp_reg_write(sc, ISP_REG_SHARPEN2, S_DELTA(0x80) | S_WEIGHT(0xf));
+	stf_isp_reg_write(sc, ISP_REG_SHARPEN3, S_DELTA(0x100) | S_WEIGHT(0xf));
+	stf_isp_reg_write(sc, ISP_REG_SHARPEN4, S_DELTA(0x10) | S_WEIGHT(0xf));
+	stf_isp_reg_write(sc, ISP_REG_SHARPEN5, S_DELTA(0x60) | S_WEIGHT(0xf));
+	stf_isp_reg_write(sc, ISP_REG_SHARPEN6, S_DELTA(0x100) | S_WEIGHT(0xf));
+	stf_isp_reg_write(sc, ISP_REG_SHARPEN7, S_DELTA(0x190) | S_WEIGHT(0xf));
+	stf_isp_reg_write(sc, ISP_REG_SHARPEN8, S_DELTA(0x0) | S_WEIGHT(0xf));
+
+	for (reg_add = ISP_REG_SHARPEN9; reg_add <= ISP_REG_SHARPEN14;) {
+		stf_isp_reg_write(sc, reg_add, S_WEIGHT(0xf));
+		reg_add += 4;
+	}
+
+	for (reg_add = ISP_REG_SHARPEN_FS0; reg_add <= ISP_REG_SHARPEN_FS5;) {
+		stf_isp_reg_write(sc, reg_add, S_FACTOR(0x10) | S_SLOPE(0x0));
+		reg_add += 4;
+	}
+
+	stf_isp_reg_write(sc, ISP_REG_SHARPEN_WN,
+			  PDIRF(0x8) | NDIRF(0x8) | WSUM(0xd7c));
+	stf_isp_reg_write(sc, ISP_REG_IUVS1, UVDIFF2(0xC0) | UVDIFF1(0x40));
+	stf_isp_reg_write(sc, ISP_REG_IUVS2, UVF(0xff) | UVSLOPE(0x0));
+	stf_isp_reg_write(sc, ISP_REG_IUVCKS1,
+			  UVCKDIFF2(0xa0) | UVCKDIFF1(0x40));
+}
+
+static void stf_isp_config_dnyuv(struct stfcamss *stfcamss)
+{
+	u32 reg_val;
+
+	reg_val = YUVSW5(7) | YUVSW4(7) | YUVSW3(7) | YUVSW2(7) |
+		  YUVSW1(7) | YUVSW0(7);
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_YSWR0, reg_val);
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_CSWR0, reg_val);
+
+	reg_val = YUVSW3(7) | YUVSW2(7) | YUVSW1(7) | YUVSW0(7);
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_YSWR1, reg_val);
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_CSWR1, reg_val);
+
+	reg_val = CURVE_D_H(0x60) | CURVE_D_L(0x40);
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_YDR0, reg_val);
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_CDR0, reg_val);
+
+	reg_val = CURVE_D_H(0xd8) | CURVE_D_L(0x90);
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_YDR1, reg_val);
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_CDR1, reg_val);
+
+	reg_val = CURVE_D_H(0x1e6) | CURVE_D_L(0x144);
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_YDR2, reg_val);
+	stf_isp_reg_write(stfcamss, ISP_REG_DNYUV_CDR2, reg_val);
+}
+
+static void stf_isp_config_sat(struct stfcamss *stfcamss)
+{
+	stf_isp_reg_write(stfcamss, ISP_REG_CS_GAIN, CMAD(0x0) | CMAB(0x100));
+	stf_isp_reg_write(stfcamss, ISP_REG_CS_THRESHOLD, CMD(0x1f) | CMB(0x1));
+	stf_isp_reg_write(stfcamss, ISP_REG_CS_OFFSET, VOFF(0x0) | UOFF(0x0));
+	stf_isp_reg_write(stfcamss, ISP_REG_CS_HUE_F, SIN(0x0) | COS(0x100));
+	stf_isp_reg_write(stfcamss, ISP_REG_CS_SCALE, CMSF(0x8));
+	stf_isp_reg_write(stfcamss, ISP_REG_YADJ0, YOIR(0x401) | YIMIN(0x1));
+	stf_isp_reg_write(stfcamss, ISP_REG_YADJ1, YOMAX(0x3ff) | YOMIN(0x1));
+}
+
+int stf_isp_clk_enable(struct stf_isp_dev *isp_dev)
+{
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+
+	clk_prepare_enable(stfcamss->sys_clk[STF_CLK_WRAPPER_CLK_C].clk);
+	reset_control_deassert(stfcamss->sys_rst[STF_RST_WRAPPER_C].rstc);
+	reset_control_deassert(stfcamss->sys_rst[STF_RST_WRAPPER_P].rstc);
+
+	return 0;
+}
+
+int stf_isp_clk_disable(struct stf_isp_dev *isp_dev)
+{
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+
+	reset_control_assert(stfcamss->sys_rst[STF_RST_WRAPPER_C].rstc);
+	reset_control_assert(stfcamss->sys_rst[STF_RST_WRAPPER_P].rstc);
+	clk_disable_unprepare(stfcamss->sys_clk[STF_CLK_WRAPPER_CLK_C].clk);
+
+	return 0;
+}
+
+int stf_isp_reset(struct stf_isp_dev *isp_dev)
+{
+	stf_isp_reg_set_bit(isp_dev->stfcamss, ISP_REG_ISP_CTRL_0,
+			    ISPC_RST_MASK, ISPC_RST);
+	stf_isp_reg_set_bit(isp_dev->stfcamss, ISP_REG_ISP_CTRL_0,
+			    ISPC_RST_MASK, 0);
+
+	return 0;
+}
+
+void stf_isp_init_cfg(struct stf_isp_dev *isp_dev)
+{
+	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_DC_CFG_1, DC_AXI_ID(0x0));
+	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_DEC_CFG,
+			  DEC_V_KEEP(0x0) |
+			  DEC_V_PERIOD(0x0) |
+			  DEC_H_KEEP(0x0) |
+			  DEC_H_PERIOD(0x0));
+
+	stf_isp_config_obc(isp_dev->stfcamss);
+	stf_isp_config_oecf(isp_dev->stfcamss);
+	stf_isp_config_lccf(isp_dev->stfcamss);
+	stf_isp_config_awb(isp_dev->stfcamss);
+	stf_isp_config_grgb(isp_dev->stfcamss);
+	stf_isp_config_cfa(isp_dev->stfcamss);
+	stf_isp_config_ccm(isp_dev->stfcamss);
+	stf_isp_config_gamma(isp_dev->stfcamss);
+	stf_isp_config_r2y(isp_dev->stfcamss);
+	stf_isp_config_y_curve(isp_dev->stfcamss);
+	stf_isp_config_sharpen(isp_dev->stfcamss);
+	stf_isp_config_dnyuv(isp_dev->stfcamss);
+	stf_isp_config_sat(isp_dev->stfcamss);
+
+	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_CSI_MODULE_CFG,
+			  CSI_DUMP_EN | CSI_SC_EN | CSI_AWB_EN |
+			  CSI_LCCF_EN | CSI_OECF_EN | CSI_OBC_EN | CSI_DEC_EN);
+	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_ISP_CTRL_1,
+			  CTRL_SAT(1) | CTRL_DBC | CTRL_CTC | CTRL_YHIST |
+			  CTRL_YCURVE | CTRL_BIYUV | CTRL_SCE | CTRL_EE |
+			  CTRL_CCE | CTRL_RGE | CTRL_CME | CTRL_AE | CTRL_CE);
+}
+
+static void stf_isp_config_crop(struct stfcamss *stfcamss,
+				struct stf_isp_crop *crop)
+{
+	struct v4l2_rect *rect = &crop[STF_ISP_PAD_SRC].rect;
+	u32 bpp = crop[STF_ISP_PAD_SRC].bpp;
+	u32 val;
+
+	val = VSTART_CAP(rect->top) | HSTART_CAP(rect->left);
+	stf_isp_reg_write(stfcamss, ISP_REG_PIC_CAPTURE_START_CFG, val);
+
+	val = VEND_CAP(rect->height + rect->top - 1) |
+	      HEND_CAP(rect->width + rect->left - 1);
+	stf_isp_reg_write(stfcamss, ISP_REG_PIC_CAPTURE_END_CFG, val);
+
+	val = H_ACT_CAP(rect->height) | W_ACT_CAP(rect->width);
+	stf_isp_reg_write(stfcamss, ISP_REG_PIPELINE_XY_SIZE, val);
+
+	val = ALIGN(rect->width * bpp / 8, STFCAMSS_FRAME_WIDTH_ALIGN_8);
+	stf_isp_reg_write(stfcamss, ISP_REG_STRIDE, val);
+}
+
+static void stf_isp_config_raw_fmt(struct stfcamss *stfcamss, u32 mcode)
+{
+	u32 val, val1;
+
+	switch (mcode) {
+	case MEDIA_BUS_FMT_SRGGB10_1X10:
+	case MEDIA_BUS_FMT_SRGGB8_1X8:
+		/* 3 2 3 2 1 0 1 0 B Gb B Gb Gr R Gr R */
+		val = SMY13(3) | SMY12(2) | SMY11(3) | SMY10(2) |
+		      SMY3(1) | SMY2(0) | SMY1(1) | SMY0(0);
+		val1 = CTRL_SAT(0x0);
+		break;
+	case MEDIA_BUS_FMT_SGRBG10_1X10:
+	case MEDIA_BUS_FMT_SGRBG8_1X8:
+		/* 2 3 2 3 0 1 0 1, Gb B Gb B R Gr R Gr */
+		val = SMY13(2) | SMY12(3) | SMY11(2) | SMY10(3) |
+		      SMY3(0) | SMY2(1) | SMY1(0) | SMY0(1);
+		val1 = CTRL_SAT(0x2);
+		break;
+	case MEDIA_BUS_FMT_SGBRG10_1X10:
+	case MEDIA_BUS_FMT_SGBRG8_1X8:
+		/* 1 0 1 0 3 2 3 2, Gr R Gr R B Gb B Gb */
+		val = SMY13(1) | SMY12(0) | SMY11(1) | SMY10(0) |
+		      SMY3(3) | SMY2(2) | SMY1(3) | SMY0(2);
+		val1 = CTRL_SAT(0x3);
+		break;
+	case MEDIA_BUS_FMT_SBGGR10_1X10:
+	case MEDIA_BUS_FMT_SBGGR8_1X8:
+		/* 0 1 0 1 2 3 2 3 R Gr R Gr Gb B Gb B */
+		val = SMY13(0) | SMY12(1) | SMY11(0) | SMY10(1) |
+		      SMY3(2) | SMY2(3) | SMY1(2) | SMY0(3);
+		val1 = CTRL_SAT(0x1);
+		break;
+	default:
+		val = SMY13(0) | SMY12(1) | SMY11(0) | SMY10(1) |
+		      SMY3(2) | SMY2(3) | SMY1(2) | SMY0(3);
+		val1 = CTRL_SAT(0x1);
+		break;
+	}
+	stf_isp_reg_write(stfcamss, ISP_REG_RAW_FORMAT_CFG, val);
+	stf_isp_reg_set_bit(stfcamss, ISP_REG_ISP_CTRL_1, CTRL_SAT_MASK, val1);
+}
+
+void stf_isp_settings(struct stf_isp_dev *isp_dev,
+		      struct stf_isp_crop *crop, u32 mcode)
+{
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+
+	stf_isp_config_crop(stfcamss, crop);
+	stf_isp_config_raw_fmt(stfcamss, mcode);
+
+	stf_isp_reg_set_bit(stfcamss, ISP_REG_DUMP_CFG_1,
+			    DUMP_BURST_LEN_MASK | DUMP_SD_MASK,
+			    DUMP_BURST_LEN(3));
+
+	stf_isp_reg_write(stfcamss, ISP_REG_ITIIWSR,
+			  ITI_HSIZE(IMAGE_MAX_HEIGH) |
+			  ITI_WSIZE(IMAGE_MAX_WIDTH));
+	stf_isp_reg_write(stfcamss, ISP_REG_ITIDWLSR, ITI_WSTRIDE(0x960));
+	stf_isp_reg_write(stfcamss, ISP_REG_ITIDRLSR, ITI_STRIDE_L(0x960));
+	stf_isp_reg_write(stfcamss, ISP_REG_SENSOR, 0x1);
+}
+
+void stf_isp_stream_set(struct stf_isp_dev *isp_dev)
+{
+	struct stfcamss *stfcamss = isp_dev->stfcamss;
+
+	stf_isp_reg_write_delay(stfcamss, ISP_REG_ISP_CTRL_0,
+				ISPC_ENUO | ISPC_ENLS | ISPC_RST, 10);
+	stf_isp_reg_write_delay(stfcamss, ISP_REG_ISP_CTRL_0,
+				ISPC_ENUO | ISPC_ENLS, 10);
+	stf_isp_reg_write(stfcamss, ISP_REG_IESHD, SHAD_UP_M);
+	stf_isp_reg_write_delay(stfcamss, ISP_REG_ISP_CTRL_0,
+				ISPC_ENUO | ISPC_ENLS | ISPC_EN, 10);
+	stf_isp_reg_write_delay(stfcamss, ISP_REG_CSIINTS,
+				CSI_INTS(1) | CSI_SHA_M(4), 10);
+	stf_isp_reg_write_delay(stfcamss, ISP_REG_CSIINTS,
+				CSI_INTS(2) | CSI_SHA_M(4), 10);
+	stf_isp_reg_write_delay(stfcamss, ISP_REG_CSI_INPUT_EN_AND_STATUS,
+				CSI_EN_S, 10);
+}
-- 
2.34.1

