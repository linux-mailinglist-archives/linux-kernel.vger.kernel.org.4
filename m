Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1283E61639B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiKBNPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiKBNPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:15:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4372A70A;
        Wed,  2 Nov 2022 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667394934; x=1698930934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f/IcWWS+IF/9w65XCrBSkoarspdzqpwPVL/ejx8TEJg=;
  b=kuqyslqvQs4bPHp60B20W/1a0gKlFETbE4/Vb+Pm/2zUV00/JypGRbva
   3W+gHPmGoDTsMIShJBpZY7aKOUVdxaKkB8my8puVe/x+ML+aYST1OifD8
   56jCXHHnp4s+7j1ttnEB/A8graf3aq4RjyrFr+0IaJm7mFm9inq5zRNfz
   Nl9crwKjI2g58OrCU2JqfnFBN/bR1dYe/onyGD7AiuyGjsCbMARnn3L6T
   zCzjI9qct3X/BSvS8zK6l8NOkzqdbPGqHUiikRszuIM2P7SRKNpx2xg4u
   UZHYnQho+DMmN/yFY13JZPnbzgKNlsYtZJMArQK8sinptDR6kPS289omd
   w==;
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="187366762"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2022 06:15:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 2 Nov 2022 06:15:33 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 2 Nov 2022 06:15:32 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <jacopo@jmondi.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-staging@lists.linux.dev>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v11 4/6] media: microchip: microchip-isc: prepare for media controller support
Date:   Wed, 2 Nov 2022 15:14:58 +0200
Message-ID: <20221102131500.476024-5-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102131500.476024-1-eugen.hristev@microchip.com>
References: <20221102131500.476024-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare the support for media-controller.
This means that the capabilities of the driver have changed and now it's
capable of media controller operations.
The driver will register its media device, and add the video entity to this
media device. The subdevices are registered to the same media device.
The ISC will have a base entity which is auto-detected as
microchip_isc_base.
It will also register a subdevice that allows cropping of the incoming
frame to the maximum frame size supported by the ISC.
The ISC will create a link between the subdevice that is asynchronously
registered and the microchip_isc_scaler entity.
Then, the microchip_isc_scaler and microchip_isc_base are connected
through another link.
This patch does not change the previous capability of the driver, the
fact that the format is still being propagated from the top video node
down to the sensor.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
Changes in v11:
- changed to apply on top of MICROCHIP_ISC
- changed naming s/Atmel/Microchip

Changes in v10:
- edited commit message, and patch name
- moved IO_MC to another patch

Changes in v8:
- use source format size as bounds always

Changes in v7:
- use maximum isc frame size as bounds always

Changes in v6:
- reworked a bit as suggested by Jacopo
- add try crops

Changes in v5:
- reworked s_fmt to pass the same format from sink to source
- simplified enum_mbus_code
- separated tgt and bounds to report correctly in g_sel

Changes in v4:
As suggested by Jacopo:
- renamed atmel_isc_mc to atmel_isc_scaler.c
- moved init_mc/clean_mc to isc_base file

Changes in v2:
- implement try formats

 drivers/media/platform/microchip/Makefile     |   2 +-
 .../platform/microchip/microchip-isc-base.c   |  72 ++++-
 .../platform/microchip/microchip-isc-scaler.c | 262 ++++++++++++++++++
 .../media/platform/microchip/microchip-isc.h  |  37 +++
 .../microchip/microchip-sama5d2-isc.c         |  12 +-
 .../microchip/microchip-sama7g5-isc.c         |  12 +-
 6 files changed, 391 insertions(+), 6 deletions(-)
 create mode 100644 drivers/media/platform/microchip/microchip-isc-scaler.c

diff --git a/drivers/media/platform/microchip/Makefile b/drivers/media/platform/microchip/Makefile
index 498a0fafc1b3..bd8d6e779c51 100644
--- a/drivers/media/platform/microchip/Makefile
+++ b/drivers/media/platform/microchip/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 microchip-isc-objs = microchip-sama5d2-isc.o
 microchip-xisc-objs = microchip-sama7g5-isc.o
-microchip-isc-common-objs = microchip-isc-base.o microchip-isc-clk.o
+microchip-isc-common-objs = microchip-isc-base.o microchip-isc-clk.o microchip-isc-scaler.o
 
 obj-$(CONFIG_VIDEO_MICROCHIP_ISC_BASE) += microchip-isc-common.o
 obj-$(CONFIG_VIDEO_MICROCHIP_ISC) += microchip-isc.o
diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index 8080cb01b0dd..3122c9347691 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -1732,6 +1732,7 @@ static int isc_async_bound(struct v4l2_async_notifier *notifier,
 					      struct isc_device, v4l2_dev);
 	struct isc_subdev_entity *subdev_entity =
 		container_of(notifier, struct isc_subdev_entity, notifier);
+	int pad;
 
 	if (video_is_registered(&isc->video_dev)) {
 		v4l2_err(&isc->v4l2_dev, "only supports one sub-device.\n");
@@ -1740,6 +1741,16 @@ static int isc_async_bound(struct v4l2_async_notifier *notifier,
 
 	subdev_entity->sd = subdev;
 
+	pad = media_entity_get_fwnode_pad(&subdev->entity, asd->match.fwnode,
+					  MEDIA_PAD_FL_SOURCE);
+	if (pad < 0) {
+		v4l2_err(&isc->v4l2_dev, "failed to find pad for %s\n",
+			 subdev->name);
+		return pad;
+	}
+
+	isc->remote_pad = pad;
+
 	return 0;
 }
 
@@ -1755,8 +1766,8 @@ static void isc_async_unbind(struct v4l2_async_notifier *notifier,
 	v4l2_ctrl_handler_free(&isc->ctrls.handler);
 }
 
-static struct isc_format *find_format_by_code(struct isc_device *isc,
-					      unsigned int code, int *index)
+struct isc_format *isc_find_format_by_code(struct isc_device *isc,
+					   unsigned int code, int *index)
 {
 	struct isc_format *fmt = &isc->formats_list[0];
 	unsigned int i;
@@ -1772,6 +1783,7 @@ static struct isc_format *find_format_by_code(struct isc_device *isc,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(isc_find_format_by_code);
 
 static int isc_formats_init(struct isc_device *isc)
 {
@@ -1788,7 +1800,7 @@ static int isc_formats_init(struct isc_device *isc)
 				 NULL, &mbus_code)) {
 		mbus_code.index++;
 
-		fmt = find_format_by_code(isc, mbus_code.code, &i);
+		fmt = isc_find_format_by_code(isc, mbus_code.code, &i);
 		if (!fmt) {
 			v4l2_warn(&isc->v4l2_dev, "Mbus code %x not supported\n",
 				  mbus_code.code);
@@ -1926,8 +1938,19 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 		goto isc_async_complete_err;
 	}
 
+	ret = isc_scaler_link(isc);
+	if (ret < 0)
+		goto isc_async_complete_unregister_device;
+
+	ret = media_device_register(&isc->mdev);
+	if (ret < 0)
+		goto isc_async_complete_unregister_device;
+
 	return 0;
 
+isc_async_complete_unregister_device:
+	video_unregister_device(vdev);
+
 isc_async_complete_err:
 	mutex_destroy(&isc->awb_mutex);
 	mutex_destroy(&isc->lock);
@@ -1995,6 +2018,49 @@ int isc_pipeline_init(struct isc_device *isc)
 }
 EXPORT_SYMBOL_GPL(isc_pipeline_init);
 
+int isc_mc_init(struct isc_device *isc, u32 ver)
+{
+	const struct of_device_id *match;
+	int ret;
+
+	isc->video_dev.entity.function = MEDIA_ENT_F_IO_V4L;
+	isc->video_dev.entity.flags = MEDIA_ENT_FL_DEFAULT;
+	isc->pads[ISC_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+
+	ret = media_entity_pads_init(&isc->video_dev.entity, ISC_PADS_NUM,
+				     isc->pads);
+	if (ret < 0) {
+		dev_err(isc->dev, "media entity init failed\n");
+		return ret;
+	}
+
+	isc->mdev.dev = isc->dev;
+
+	match = of_match_node(isc->dev->driver->of_match_table,
+			      isc->dev->of_node);
+
+	strscpy(isc->mdev.driver_name, KBUILD_MODNAME,
+		sizeof(isc->mdev.driver_name));
+	strscpy(isc->mdev.model, match->compatible, sizeof(isc->mdev.model));
+	snprintf(isc->mdev.bus_info, sizeof(isc->mdev.bus_info), "platform:%s",
+		 isc->v4l2_dev.name);
+	isc->mdev.hw_revision = ver;
+
+	media_device_init(&isc->mdev);
+
+	isc->v4l2_dev.mdev = &isc->mdev;
+
+	return isc_scaler_init(isc);
+}
+EXPORT_SYMBOL_GPL(isc_mc_init);
+
+void isc_mc_cleanup(struct isc_device *isc)
+{
+	media_entity_cleanup(&isc->video_dev.entity);
+	media_device_cleanup(&isc->mdev);
+}
+EXPORT_SYMBOL_GPL(isc_mc_cleanup);
+
 /* regmap configuration */
 #define MICROCHIP_ISC_REG_MAX    0xd5c
 const struct regmap_config isc_regmap_config = {
diff --git a/drivers/media/platform/microchip/microchip-isc-scaler.c b/drivers/media/platform/microchip/microchip-isc-scaler.c
new file mode 100644
index 000000000000..80fff803e6bb
--- /dev/null
+++ b/drivers/media/platform/microchip/microchip-isc-scaler.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Microchip Image Sensor Controller (ISC) Scaler entity support
+ *
+ * Copyright (C) 2022 Microchip Technology, Inc.
+ *
+ * Author: Eugen Hristev <eugen.hristev@microchip.com>
+ *
+ */
+
+#include <media/media-device.h>
+#include <media/media-entity.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-subdev.h>
+
+#include "microchip-isc-regs.h"
+#include "microchip-isc.h"
+
+static void isc_scaler_prepare_fmt(struct v4l2_mbus_framefmt *framefmt)
+{
+	framefmt->colorspace = V4L2_COLORSPACE_SRGB;
+	framefmt->field = V4L2_FIELD_NONE;
+	framefmt->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	framefmt->quantization = V4L2_QUANTIZATION_DEFAULT;
+	framefmt->xfer_func = V4L2_XFER_FUNC_DEFAULT;
+};
+
+static int isc_scaler_get_fmt(struct v4l2_subdev *sd,
+			      struct v4l2_subdev_state *sd_state,
+			      struct v4l2_subdev_format *format)
+{
+	struct isc_device *isc = container_of(sd, struct isc_device, scaler_sd);
+	struct v4l2_mbus_framefmt *v4l2_try_fmt;
+
+	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
+		v4l2_try_fmt = v4l2_subdev_get_try_format(sd, sd_state,
+							  format->pad);
+		format->format = *v4l2_try_fmt;
+
+		return 0;
+	}
+
+	format->format = isc->scaler_format[format->pad];
+
+	return 0;
+}
+
+static int isc_scaler_set_fmt(struct v4l2_subdev *sd,
+			      struct v4l2_subdev_state *sd_state,
+			      struct v4l2_subdev_format *req_fmt)
+{
+	struct isc_device *isc = container_of(sd, struct isc_device, scaler_sd);
+	struct v4l2_mbus_framefmt *v4l2_try_fmt;
+	struct isc_format *fmt;
+	unsigned int i;
+
+	/* Source format is fixed, we cannot change it */
+	if (req_fmt->pad == ISC_SCALER_PAD_SOURCE) {
+		req_fmt->format = isc->scaler_format[ISC_SCALER_PAD_SOURCE];
+		return 0;
+	}
+
+	/* There is no limit on the frame size on the sink pad */
+	v4l_bound_align_image(&req_fmt->format.width, 16, UINT_MAX, 0,
+			      &req_fmt->format.height, 16, UINT_MAX, 0, 0);
+
+	isc_scaler_prepare_fmt(&req_fmt->format);
+
+	fmt = isc_find_format_by_code(isc, req_fmt->format.code, &i);
+
+	if (!fmt)
+		fmt = &isc->formats_list[0];
+
+	req_fmt->format.code = fmt->mbus_code;
+
+	if (req_fmt->which == V4L2_SUBDEV_FORMAT_TRY) {
+		v4l2_try_fmt = v4l2_subdev_get_try_format(sd, sd_state,
+							  req_fmt->pad);
+		*v4l2_try_fmt = req_fmt->format;
+		/* Trying on the sink pad makes the source pad change too */
+		v4l2_try_fmt = v4l2_subdev_get_try_format(sd, sd_state,
+							  ISC_SCALER_PAD_SOURCE);
+		*v4l2_try_fmt = req_fmt->format;
+
+		v4l_bound_align_image(&v4l2_try_fmt->width,
+				      16, isc->max_width, 0,
+				      &v4l2_try_fmt->height,
+				      16, isc->max_height, 0, 0);
+		/* if we are just trying, we are done */
+		return 0;
+	}
+
+	isc->scaler_format[ISC_SCALER_PAD_SINK] = req_fmt->format;
+
+	/* The source pad is the same as the sink, but we have to crop it */
+	isc->scaler_format[ISC_SCALER_PAD_SOURCE] =
+		isc->scaler_format[ISC_SCALER_PAD_SINK];
+	v4l_bound_align_image
+		(&isc->scaler_format[ISC_SCALER_PAD_SOURCE].width, 16,
+		 isc->max_width, 0,
+		 &isc->scaler_format[ISC_SCALER_PAD_SOURCE].height, 16,
+		 isc->max_height, 0, 0);
+
+	return 0;
+}
+
+static int isc_scaler_enum_mbus_code(struct v4l2_subdev *sd,
+				     struct v4l2_subdev_state *sd_state,
+				     struct v4l2_subdev_mbus_code_enum *code)
+{
+	struct isc_device *isc = container_of(sd, struct isc_device, scaler_sd);
+
+	/*
+	 * All formats supported by the ISC are supported by the scaler.
+	 * Advertise the formats which the ISC can take as input, as the scaler
+	 * entity cropping is part of the PFE module (parallel front end)
+	 */
+	if (code->index < isc->formats_list_size) {
+		code->code = isc->formats_list[code->index].mbus_code;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int isc_scaler_g_sel(struct v4l2_subdev *sd,
+			    struct v4l2_subdev_state *sd_state,
+			    struct v4l2_subdev_selection *sel)
+{
+	struct isc_device *isc = container_of(sd, struct isc_device, scaler_sd);
+
+	if (sel->pad == ISC_SCALER_PAD_SOURCE)
+		return -EINVAL;
+
+	if (sel->target != V4L2_SEL_TGT_CROP_BOUNDS &&
+	    sel->target != V4L2_SEL_TGT_CROP)
+		return -EINVAL;
+
+	sel->r.height = isc->scaler_format[ISC_SCALER_PAD_SOURCE].height;
+	sel->r.width = isc->scaler_format[ISC_SCALER_PAD_SOURCE].width;
+
+	sel->r.left = 0;
+	sel->r.top = 0;
+
+	return 0;
+}
+
+static int isc_scaler_init_cfg(struct v4l2_subdev *sd,
+			       struct v4l2_subdev_state *sd_state)
+{
+	struct v4l2_mbus_framefmt *v4l2_try_fmt =
+		v4l2_subdev_get_try_format(sd, sd_state, 0);
+	struct v4l2_rect *try_crop;
+	struct isc_device *isc = container_of(sd, struct isc_device, scaler_sd);
+
+	*v4l2_try_fmt = isc->scaler_format[ISC_SCALER_PAD_SOURCE];
+
+	try_crop = v4l2_subdev_get_try_crop(sd, sd_state, 0);
+
+	try_crop->top = 0;
+	try_crop->left = 0;
+	try_crop->width = v4l2_try_fmt->width;
+	try_crop->height = v4l2_try_fmt->height;
+
+	return 0;
+}
+
+static const struct v4l2_subdev_pad_ops isc_scaler_pad_ops = {
+	.enum_mbus_code = isc_scaler_enum_mbus_code,
+	.set_fmt = isc_scaler_set_fmt,
+	.get_fmt = isc_scaler_get_fmt,
+	.get_selection = isc_scaler_g_sel,
+	.init_cfg = isc_scaler_init_cfg,
+};
+
+static const struct v4l2_subdev_ops xisc_scaler_subdev_ops = {
+	.pad = &isc_scaler_pad_ops,
+};
+
+int isc_scaler_init(struct isc_device *isc)
+{
+	int ret;
+
+	v4l2_subdev_init(&isc->scaler_sd, &xisc_scaler_subdev_ops);
+
+	isc->scaler_sd.owner = THIS_MODULE;
+	isc->scaler_sd.dev = isc->dev;
+	snprintf(isc->scaler_sd.name, sizeof(isc->scaler_sd.name),
+		 "microchip_isc_scaler");
+
+	isc->scaler_sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	isc->scaler_sd.entity.function = MEDIA_ENT_F_PROC_VIDEO_SCALER;
+	isc->scaler_pads[ISC_SCALER_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+	isc->scaler_pads[ISC_SCALER_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE;
+
+	isc_scaler_prepare_fmt(&isc->scaler_format[ISC_SCALER_PAD_SOURCE]);
+	isc->scaler_format[ISC_SCALER_PAD_SOURCE].height = isc->max_height;
+	isc->scaler_format[ISC_SCALER_PAD_SOURCE].width = isc->max_width;
+	isc->scaler_format[ISC_SCALER_PAD_SOURCE].code =
+		 isc->formats_list[0].mbus_code;
+
+	isc->scaler_format[ISC_SCALER_PAD_SINK] =
+		 isc->scaler_format[ISC_SCALER_PAD_SOURCE];
+
+	ret = media_entity_pads_init(&isc->scaler_sd.entity,
+				     ISC_SCALER_PADS_NUM,
+				     isc->scaler_pads);
+	if (ret < 0) {
+		dev_err(isc->dev, "scaler sd media entity init failed\n");
+		return ret;
+	}
+
+	ret = v4l2_device_register_subdev(&isc->v4l2_dev, &isc->scaler_sd);
+	if (ret < 0) {
+		dev_err(isc->dev, "scaler sd failed to register subdev\n");
+		return ret;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(isc_scaler_init);
+
+int isc_scaler_link(struct isc_device *isc)
+{
+	int ret;
+
+	ret = media_create_pad_link(&isc->current_subdev->sd->entity,
+				    isc->remote_pad, &isc->scaler_sd.entity,
+				    ISC_SCALER_PAD_SINK,
+				    MEDIA_LNK_FL_ENABLED |
+				    MEDIA_LNK_FL_IMMUTABLE);
+
+	if (ret < 0) {
+		dev_err(isc->dev, "Failed to create pad link: %s to %s\n",
+			isc->current_subdev->sd->entity.name,
+			isc->scaler_sd.entity.name);
+		return ret;
+	}
+
+	dev_dbg(isc->dev, "link with %s pad: %d\n",
+		isc->current_subdev->sd->name, isc->remote_pad);
+
+	ret = media_create_pad_link(&isc->scaler_sd.entity,
+				    ISC_SCALER_PAD_SOURCE,
+				    &isc->video_dev.entity, ISC_PAD_SINK,
+				    MEDIA_LNK_FL_ENABLED |
+				    MEDIA_LNK_FL_IMMUTABLE);
+
+	if (ret < 0) {
+		dev_err(isc->dev, "Failed to create pad link: %s to %s\n",
+			isc->scaler_sd.entity.name,
+			isc->video_dev.entity.name);
+		return ret;
+	}
+
+	dev_dbg(isc->dev, "link with %s pad: %d\n", isc->scaler_sd.name,
+		ISC_SCALER_PAD_SOURCE);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(isc_scaler_link);
+
diff --git a/drivers/media/platform/microchip/microchip-isc.h b/drivers/media/platform/microchip/microchip-isc.h
index 565ccb09ec28..8c11e7b95e91 100644
--- a/drivers/media/platform/microchip/microchip-isc.h
+++ b/drivers/media/platform/microchip/microchip-isc.h
@@ -183,6 +183,17 @@ struct isc_reg_offsets {
 	u32 his_entry;
 };
 
+enum isc_mc_pads {
+	ISC_PAD_SINK	= 0,
+	ISC_PADS_NUM	= 1,
+};
+
+enum isc_scaler_pads {
+	ISC_SCALER_PAD_SINK	= 0,
+	ISC_SCALER_PAD_SOURCE	= 1,
+	ISC_SCALER_PADS_NUM	= 2,
+};
+
 /*
  * struct isc_device - ISC device driver data/config struct
  * @regmap:		Register map
@@ -259,6 +270,12 @@ struct isc_reg_offsets {
  *			be used as an input to the controller
  * @controller_formats_size:	size of controller_formats array
  * @formats_list_size:	size of formats_list array
+ * @pads:		media controller pads for isc video entity
+ * @mdev:		media device that is registered by the isc
+ * @remote_pad:		remote pad on the connected subdevice
+ * @scaler_sd:		subdevice for the scaler that isc registers
+ * @scaler_pads:	media controller pads for the scaler subdevice
+ * @scaler_format:	current format for the scaler subdevice
  */
 struct isc_device {
 	struct regmap		*regmap;
@@ -348,6 +365,19 @@ struct isc_device {
 	struct isc_format		*formats_list;
 	u32				controller_formats_size;
 	u32				formats_list_size;
+
+	struct {
+		struct media_pad		pads[ISC_PADS_NUM];
+		struct media_device		mdev;
+
+		u32				remote_pad;
+	};
+
+	struct {
+		struct v4l2_subdev		scaler_sd;
+		struct media_pad		scaler_pads[ISC_SCALER_PADS_NUM];
+		struct v4l2_mbus_framefmt	scaler_format[ISC_SCALER_PADS_NUM];
+	};
 };
 
 extern const struct regmap_config isc_regmap_config;
@@ -359,4 +389,11 @@ int isc_clk_init(struct isc_device *isc);
 void isc_subdev_cleanup(struct isc_device *isc);
 void isc_clk_cleanup(struct isc_device *isc);
 
+int isc_scaler_link(struct isc_device *isc);
+int isc_scaler_init(struct isc_device *isc);
+int isc_mc_init(struct isc_device *isc, u32 ver);
+void isc_mc_cleanup(struct isc_device *isc);
+
+struct isc_format *isc_find_format_by_code(struct isc_device *isc,
+					   unsigned int code, int *index);
 #endif
diff --git a/drivers/media/platform/microchip/microchip-sama5d2-isc.c b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
index 5b088fdb2389..d6486ab0d550 100644
--- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
@@ -536,6 +536,12 @@ static int microchip_isc_probe(struct platform_device *pdev)
 			break;
 	}
 
+	regmap_read(isc->regmap, ISC_VERSION + isc->offsets.version, &ver);
+
+	ret = isc_mc_init(isc, ver);
+	if (ret < 0)
+		goto isc_probe_mc_init_err;
+
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 	pm_request_idle(dev);
@@ -555,7 +561,6 @@ static int microchip_isc_probe(struct platform_device *pdev)
 		goto unprepare_clk;
 	}
 
-	regmap_read(isc->regmap, ISC_VERSION + isc->offsets.version, &ver);
 	dev_info(dev, "Microchip ISC version %x\n", ver);
 
 	return 0;
@@ -566,6 +571,9 @@ static int microchip_isc_probe(struct platform_device *pdev)
 disable_pm:
 	pm_runtime_disable(dev);
 
+isc_probe_mc_init_err:
+	isc_mc_cleanup(isc);
+
 cleanup_subdev:
 	isc_subdev_cleanup(isc);
 
@@ -586,6 +594,8 @@ static int microchip_isc_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
+	isc_mc_cleanup(isc);
+
 	isc_subdev_cleanup(isc);
 
 	v4l2_device_unregister(&isc->v4l2_dev);
diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
index 1f3774dde12d..e485b58ebe7e 100644
--- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -526,15 +526,23 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 			break;
 	}
 
+	regmap_read(isc->regmap, ISC_VERSION + isc->offsets.version, &ver);
+
+	ret = isc_mc_init(isc, ver);
+	if (ret < 0)
+		goto isc_probe_mc_init_err;
+
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 	pm_request_idle(dev);
 
-	regmap_read(isc->regmap, ISC_VERSION + isc->offsets.version, &ver);
 	dev_info(dev, "Microchip XISC version %x\n", ver);
 
 	return 0;
 
+isc_probe_mc_init_err:
+	isc_mc_cleanup(isc);
+
 cleanup_subdev:
 	isc_subdev_cleanup(isc);
 
@@ -555,6 +563,8 @@ static int microchip_xisc_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
+	isc_mc_cleanup(isc);
+
 	isc_subdev_cleanup(isc);
 
 	v4l2_device_unregister(&isc->v4l2_dev);
-- 
2.25.1

