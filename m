Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C806961F5CC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiKGOXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiKGOXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:23:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49A61DF01;
        Mon,  7 Nov 2022 06:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667830742; x=1699366742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5VT1nZc4qdpr+u+9x7BX59zm6n1Wh1FSGfeGbR4ItgI=;
  b=acN1DM6QYFzbk2qV/LYtxsgNC+ZBOP1b84V06+wvItA2Cq2FBrTh8O7Z
   pET4MH96IhdXYY0FgM81oDr2yODeB3KXL/QfpBo8z5D0XLa6WvM0zRqPa
   WcKYHF2dGN+uZu5NV8D0GbtgMhHDtiVoD5SF4Lx1h2Qe0GSyZU9CzJVUl
   73ZJqXeirg8lfqjQRips8J86niWLM7ErZMJHBP580ET/vX3AngsYQ64C6
   lSQ/upW3MGA4Lp0qTu7Akki0VUPz85fKLbtEADDW3ernEZymNzvf4KFsI
   7FYIV7uK30YOMoUuzbEcMLYb1LzSXqLTnFNeo5SSxjzJ2d6/mU4RtZgnd
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="182277019"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Nov 2022 07:18:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 7 Nov 2022 07:18:37 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 7 Nov 2022 07:18:35 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <jacopo@jmondi.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-staging@lists.linux.dev>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v12 4/6] media: microchip: microchip-isc: implement media controller
Date:   Mon, 7 Nov 2022 16:18:16 +0200
Message-ID: <20221107141818.104937-5-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107141818.104937-1-eugen.hristev@microchip.com>
References: <20221107141818.104937-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a top MC video driver, the microchip-isc should not propagate the format
to the subdevice, it should rather check at start_streaming() time if the
subdev is properly configured with a compatible format.
Removed the whole format finding logic, and reworked the format
verification at start_streaming time, such that the ISC will return an
error if the subdevice is not properly configured.
To achieve this, media_pipeline_start is called and a link_validate
callback is created to check the formats.
With this being done, the module parameter 'sensor_preferred' makes no
sense anymore. The ISC should not decide which format the sensor is using.
The ISC should only cope with the situation and inform userspace if the
streaming is possible in the current configuration.
The redesign of the format propagation has also risen the question of the
enumfmt callback. If enumfmt is called with an mbus_code, the enumfmt
handler should only return the formats that are supported for this
mbus_code. Otherwise, the enumfmt will report all the formats that the ISC
could output.
With this rework, the dynamic list of user formats is removed. It makes no
more sense to identify at complete time which formats the sensor could
emit, and add those into a separate dynamic list.
The ISC will start with a simple preconfigured default format, and at
link validate time, decide whether it can use the format that is
configured on the sink or not.
From now on, the driver also advertises the IO_MC capability.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
Changes in v12:
- all exported symbols now prefixed by microchip_

Changes in v11:
- changed to apply on top of MICROCHIP_ISC
- changed media pipeline_stop/start to use new type of first parameter
- s/Atmel/Microchip

Changes in v10:
- moved IO_MC to this patch
- edited commit message

Changes in v9:
- isc_link_validate now static

Changes in v7:
- minor typos as suggested by Jacopo
- small changes, reduce some indentation, modified an index, as suggested by
Jacopo

Changes in v6:
- reworked a bit enum_fmt as suggested by Jacopo

Changes in v5:
- removed user_formats dynamic list as it is now pointless
- greatly simplified the enum_fmt function
- removed some init code that was useless now

Changes in v4:
- moved validation code into link_validate and used media_pipeline_start
- merged this patch with the enum_fmt patch which was previously in v3 of
the series

Changes in v3:
- clamp to maximum resolution once the frame size from the subdev is found

 drivers/media/platform/microchip/Kconfig      |   2 +-
 .../platform/microchip/microchip-isc-base.c   | 416 ++++++++----------
 .../platform/microchip/microchip-isc-scaler.c |   5 +
 .../media/platform/microchip/microchip-isc.h  |  13 +-
 .../microchip/microchip-sama5d2-isc.c         |  20 +
 .../microchip/microchip-sama7g5-isc.c         |  20 +
 6 files changed, 239 insertions(+), 237 deletions(-)

diff --git a/drivers/media/platform/microchip/Kconfig b/drivers/media/platform/microchip/Kconfig
index 4f30807aae43..4734ecced029 100644
--- a/drivers/media/platform/microchip/Kconfig
+++ b/drivers/media/platform/microchip/Kconfig
@@ -23,7 +23,7 @@ config VIDEO_MICROCHIP_ISC
 config VIDEO_MICROCHIP_XISC
 	tristate "Microchip eXtended Image Sensor Controller (XISC) support"
 	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_DEV && COMMON_CLK && VIDEO_V4L2_SUBDEV_API
+	depends on VIDEO_DEV && COMMON_CLK
 	depends on ARCH_AT91 || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
 	select REGMAP_MMIO
diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index 9034d8f97831..28749a09b0c3 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -36,11 +36,6 @@ static unsigned int debug;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "debug level (0-2)");
 
-static unsigned int sensor_preferred = 1;
-module_param(sensor_preferred, uint, 0644);
-MODULE_PARM_DESC(sensor_preferred,
-		 "Sensor is preferred to output the specified format (1-on 0-off), default 1");
-
 #define ISC_IS_FORMAT_RAW(mbus_code) \
 	(((mbus_code) & 0xf000) == 0x3000)
 
@@ -341,6 +336,10 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
 	unsigned long flags;
 	int ret;
 
+	ret = media_pipeline_start(isc->video_dev.entity.pads, &isc->mpipe);
+	if (ret)
+		goto err_pipeline_start;
+
 	/* Enable stream on the sub device */
 	ret = v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 1);
 	if (ret && ret != -ENOIOCTLCMD) {
@@ -390,6 +389,9 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
 	v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 0);
 
 err_start_stream:
+	media_pipeline_stop(isc->video_dev.entity.pads);
+
+err_pipeline_start:
 	spin_lock_irqsave(&isc->dma_queue_lock, flags);
 	list_for_each_entry(buf, &isc->dma_queue, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
@@ -428,6 +430,9 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 	if (ret && ret != -ENOIOCTLCMD)
 		v4l2_err(&isc->v4l2_dev, "stream off failed in subdev\n");
 
+	/* Stop media pipeline */
+	media_pipeline_stop(isc->video_dev.entity.pads);
+
 	/* Release all active buffers */
 	spin_lock_irqsave(&isc->dma_queue_lock, flags);
 	if (unlikely(isc->cur_frm)) {
@@ -459,22 +464,6 @@ static void isc_buffer_queue(struct vb2_buffer *vb)
 	spin_unlock_irqrestore(&isc->dma_queue_lock, flags);
 }
 
-static struct isc_format *find_format_by_fourcc(struct isc_device *isc,
-						unsigned int fourcc)
-{
-	unsigned int num_formats = isc->num_user_formats;
-	struct isc_format *fmt;
-	unsigned int i;
-
-	for (i = 0; i < num_formats; i++) {
-		fmt = isc->user_formats[i];
-		if (fmt->fourcc == fourcc)
-			return fmt;
-	}
-
-	return NULL;
-}
-
 static const struct vb2_ops isc_vb2_ops = {
 	.queue_setup		= isc_queue_setup,
 	.wait_prepare		= vb2_ops_wait_prepare,
@@ -503,23 +492,57 @@ static int isc_enum_fmt_vid_cap(struct file *file, void *priv,
 {
 	struct isc_device *isc = video_drvdata(file);
 	u32 index = f->index;
-	u32 i, supported_index;
+	u32 i, supported_index = 0;
+	struct isc_format *fmt;
+
+	/*
+	 * If we are not asked a specific mbus_code, we have to report all
+	 * the formats that we can output.
+	 */
+	if (!f->mbus_code) {
+		if (index >= isc->controller_formats_size)
+			return -EINVAL;
 
-	if (index < isc->controller_formats_size) {
 		f->pixelformat = isc->controller_formats[index].fourcc;
+
+		return 0;
+	}
+
+	/*
+	 * If a specific mbus_code is requested, check if we support
+	 * this mbus_code as input for the ISC.
+	 * If it's supported, then we report the corresponding pixelformat
+	 * as first possible option for the ISC.
+	 * E.g. mbus MEDIA_BUS_FMT_YUYV8_2X8 and report
+	 * 'YUYV' (YUYV 4:2:2)
+	 */
+	fmt = isc_find_format_by_code(isc, f->mbus_code, &i);
+	if (!fmt)
+		return -EINVAL;
+
+	if (!index) {
+		f->pixelformat = fmt->fourcc;
+
 		return 0;
 	}
 
-	index -= isc->controller_formats_size;
+	supported_index++;
 
-	supported_index = 0;
+	/* If the index is not raw, we don't have anymore formats to report */
+	if (!ISC_IS_FORMAT_RAW(f->mbus_code))
+		return -EINVAL;
 
-	for (i = 0; i < isc->formats_list_size; i++) {
-		if (!ISC_IS_FORMAT_RAW(isc->formats_list[i].mbus_code) ||
-		    !isc->formats_list[i].sd_support)
+	/*
+	 * We are asked for a specific mbus code, which is raw.
+	 * We have to search through the formats we can convert to.
+	 * We have to skip the raw formats, we cannot convert to raw.
+	 * E.g. 'AR12' (16-bit ARGB 4-4-4-4), 'AR15' (16-bit ARGB 1-5-5-5), etc.
+	 */
+	for (i = 0; i < isc->controller_formats_size; i++) {
+		if (isc->controller_formats[i].raw)
 			continue;
-		if (supported_index == index) {
-			f->pixelformat = isc->formats_list[i].fourcc;
+		if (index == supported_index) {
+			f->pixelformat = isc->controller_formats[i].fourcc;
 			return 0;
 		}
 		supported_index++;
@@ -590,20 +613,30 @@ static int isc_try_validate_formats(struct isc_device *isc)
 		break;
 	default:
 	/* any other different formats are not supported */
+		v4l2_err(&isc->v4l2_dev, "Requested unsupported format.\n");
 		ret = -EINVAL;
 	}
 	v4l2_dbg(1, debug, &isc->v4l2_dev,
 		 "Format validation, requested rgb=%u, yuv=%u, grey=%u, bayer=%u\n",
 		 rgb, yuv, grey, bayer);
 
-	/* we cannot output RAW if we do not receive RAW */
-	if ((bayer) && !ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code))
+	if (bayer &&
+	    !ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code)) {
+		v4l2_err(&isc->v4l2_dev, "Cannot output RAW if we do not receive RAW.\n");
 		return -EINVAL;
+	}
 
-	/* we cannot output GREY if we do not receive RAW/GREY */
 	if (grey && !ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code) &&
-	    !ISC_IS_FORMAT_GREY(isc->try_config.sd_format->mbus_code))
+	    !ISC_IS_FORMAT_GREY(isc->try_config.sd_format->mbus_code)) {
+		v4l2_err(&isc->v4l2_dev, "Cannot output GREY if we do not receive RAW/GREY.\n");
 		return -EINVAL;
+	}
+
+	if ((rgb || bayer || yuv) &&
+	    ISC_IS_FORMAT_GREY(isc->try_config.sd_format->mbus_code)) {
+		v4l2_err(&isc->v4l2_dev, "Cannot convert GREY to another format.\n");
+		return -EINVAL;
+	}
 
 	return ret;
 }
@@ -831,7 +864,7 @@ static void isc_try_fse(struct isc_device *isc,
 	 * If we do not know yet which format the subdev is using, we cannot
 	 * do anything.
 	 */
-	if (!isc->try_config.sd_format)
+	if (!isc->config.sd_format)
 		return;
 
 	fse.code = isc->try_config.sd_format->mbus_code;
@@ -852,180 +885,139 @@ static void isc_try_fse(struct isc_device *isc,
 	}
 }
 
-static int isc_try_fmt(struct isc_device *isc, struct v4l2_format *f,
-		       u32 *code)
+static int isc_try_fmt(struct isc_device *isc, struct v4l2_format *f)
 {
-	int i;
-	struct isc_format *sd_fmt = NULL, *direct_fmt = NULL;
 	struct v4l2_pix_format *pixfmt = &f->fmt.pix;
-	struct v4l2_subdev_pad_config pad_cfg = {};
-	struct v4l2_subdev_state pad_state = {
-		.pads = &pad_cfg
-		};
-	struct v4l2_subdev_format format = {
-		.which = V4L2_SUBDEV_FORMAT_TRY,
-	};
-	u32 mbus_code;
-	int ret;
-	bool rlp_dma_direct_dump = false;
+	unsigned int i;
 
 	if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
 		return -EINVAL;
 
-	/* Step 1: find a RAW format that is supported */
-	for (i = 0; i < isc->num_user_formats; i++) {
-		if (ISC_IS_FORMAT_RAW(isc->user_formats[i]->mbus_code)) {
-			sd_fmt = isc->user_formats[i];
+	isc->try_config.fourcc = isc->controller_formats[0].fourcc;
+
+	/* find if the format requested is supported */
+	for (i = 0; i < isc->controller_formats_size; i++)
+		if (isc->controller_formats[i].fourcc == pixfmt->pixelformat) {
+			isc->try_config.fourcc = pixfmt->pixelformat;
 			break;
 		}
-	}
-	/* Step 2: We can continue with this RAW format, or we can look
-	 * for better: maybe sensor supports directly what we need.
-	 */
-	direct_fmt = find_format_by_fourcc(isc, pixfmt->pixelformat);
-
-	/* Step 3: We have both. We decide given the module parameter which
-	 * one to use.
-	 */
-	if (direct_fmt && sd_fmt && sensor_preferred)
-		sd_fmt = direct_fmt;
-
-	/* Step 4: we do not have RAW but we have a direct format. Use it. */
-	if (direct_fmt && !sd_fmt)
-		sd_fmt = direct_fmt;
-
-	/* Step 5: if we are using a direct format, we need to package
-	 * everything as 8 bit data and just dump it
-	 */
-	if (sd_fmt == direct_fmt)
-		rlp_dma_direct_dump = true;
-
-	/* Step 6: We have no format. This can happen if the userspace
-	 * requests some weird/invalid format.
-	 * In this case, default to whatever we have
-	 */
-	if (!sd_fmt && !direct_fmt) {
-		sd_fmt = isc->user_formats[isc->num_user_formats - 1];
-		v4l2_dbg(1, debug, &isc->v4l2_dev,
-			 "Sensor not supporting %.4s, using %.4s\n",
-			 (char *)&pixfmt->pixelformat, (char *)&sd_fmt->fourcc);
-	}
-
-	if (!sd_fmt) {
-		ret = -EINVAL;
-		goto isc_try_fmt_err;
-	}
-
-	/* Step 7: Print out what we decided for debugging */
-	v4l2_dbg(1, debug, &isc->v4l2_dev,
-		 "Preferring to have sensor using format %.4s\n",
-		 (char *)&sd_fmt->fourcc);
-
-	/* Step 8: at this moment we decided which format the subdev will use */
-	isc->try_config.sd_format = sd_fmt;
-
-	/* Limit to Microchip ISC hardware capabilities */
-	if (pixfmt->width > isc->max_width)
-		pixfmt->width = isc->max_width;
-	if (pixfmt->height > isc->max_height)
-		pixfmt->height = isc->max_height;
-
-	/*
-	 * The mbus format is the one the subdev outputs.
-	 * The pixels will be transferred in this format Sensor -> ISC
-	 */
-	mbus_code = sd_fmt->mbus_code;
-
-	/*
-	 * Validate formats. If the required format is not OK, default to raw.
-	 */
-
-	isc->try_config.fourcc = pixfmt->pixelformat;
-
-	if (isc_try_validate_formats(isc)) {
-		pixfmt->pixelformat = isc->try_config.fourcc = sd_fmt->fourcc;
-		/* Re-try to validate the new format */
-		ret = isc_try_validate_formats(isc);
-		if (ret)
-			goto isc_try_fmt_err;
-	}
-
-	ret = isc_try_configure_rlp_dma(isc, rlp_dma_direct_dump);
-	if (ret)
-		goto isc_try_fmt_err;
-
-	ret = isc_try_configure_pipeline(isc);
-	if (ret)
-		goto isc_try_fmt_err;
-
-	/* Obtain frame sizes if possible to have crop requirements ready */
-	isc_try_fse(isc, &pad_state);
 
-	v4l2_fill_mbus_format(&format.format, pixfmt, mbus_code);
-	ret = v4l2_subdev_call(isc->current_subdev->sd, pad, set_fmt,
-			       &pad_state, &format);
-	if (ret < 0)
-		goto isc_try_fmt_subdev_err;
-
-	v4l2_fill_pix_format(pixfmt, &format.format);
+	isc_try_configure_rlp_dma(isc, false);
 
 	/* Limit to Microchip ISC hardware capabilities */
-	if (pixfmt->width > isc->max_width)
-		pixfmt->width = isc->max_width;
-	if (pixfmt->height > isc->max_height)
-		pixfmt->height = isc->max_height;
-
+	v4l_bound_align_image(&pixfmt->width, 16, isc->max_width, 0,
+			      &pixfmt->height, 16, isc->max_height, 0, 0);
+	/* If we did not find the requested format, we will fallback here */
+	pixfmt->pixelformat = isc->try_config.fourcc;
+	pixfmt->colorspace = V4L2_COLORSPACE_SRGB;
 	pixfmt->field = V4L2_FIELD_NONE;
+
 	pixfmt->bytesperline = (pixfmt->width * isc->try_config.bpp_v4l2) >> 3;
 	pixfmt->sizeimage = ((pixfmt->width * isc->try_config.bpp) >> 3) *
 			     pixfmt->height;
 
-	if (code)
-		*code = mbus_code;
+	isc->try_fmt = *f;
 
 	return 0;
+}
 
-isc_try_fmt_err:
-	v4l2_err(&isc->v4l2_dev, "Could not find any possible format for a working pipeline\n");
-isc_try_fmt_subdev_err:
-	memset(&isc->try_config, 0, sizeof(isc->try_config));
+static int isc_set_fmt(struct isc_device *isc, struct v4l2_format *f)
+{
+	isc_try_fmt(isc, f);
 
-	return ret;
+	/* make the try configuration active */
+	isc->config = isc->try_config;
+	isc->fmt = isc->try_fmt;
+
+	v4l2_dbg(1, debug, &isc->v4l2_dev, "ISC set_fmt to %.4s @%dx%d\n",
+		 (char *)&f->fmt.pix.pixelformat,
+		 f->fmt.pix.width, f->fmt.pix.height);
+
+	return 0;
 }
 
-static int isc_set_fmt(struct isc_device *isc, struct v4l2_format *f)
+static int isc_validate(struct isc_device *isc)
 {
+	int ret;
+	int i;
+	struct isc_format *sd_fmt = NULL;
+	struct v4l2_pix_format *pixfmt = &isc->fmt.fmt.pix;
 	struct v4l2_subdev_format format = {
 		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.pad = isc->remote_pad,
+	};
+	struct v4l2_subdev_pad_config pad_cfg = {};
+	struct v4l2_subdev_state pad_state = {
+		.pads = &pad_cfg,
 	};
-	u32 mbus_code = 0;
-	int ret;
 
-	ret = isc_try_fmt(isc, f, &mbus_code);
+	/* Get current format from subdev */
+	ret = v4l2_subdev_call(isc->current_subdev->sd, pad, get_fmt, NULL,
+			       &format);
 	if (ret)
 		return ret;
 
-	v4l2_fill_mbus_format(&format.format, &f->fmt.pix, mbus_code);
-	ret = v4l2_subdev_call(isc->current_subdev->sd, pad,
-			       set_fmt, NULL, &format);
-	if (ret < 0)
-		return ret;
+	/* Identify the subdev's format configuration */
+	for (i = 0; i < isc->formats_list_size; i++)
+		if (isc->formats_list[i].mbus_code == format.format.code) {
+			sd_fmt = &isc->formats_list[i];
+			break;
+		}
+
+	/* Check if the format is not supported */
+	if (!sd_fmt) {
+		v4l2_err(&isc->v4l2_dev,
+			 "Current subdevice is streaming a media bus code that is not supported 0x%x\n",
+			 format.format.code);
+		return -EPIPE;
+	}
+
+	/* At this moment we know which format the subdev will use */
+	isc->try_config.sd_format = sd_fmt;
+
+	/* If the sensor is not RAW, we can only do a direct dump */
+	if (!ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code))
+		isc_try_configure_rlp_dma(isc, true);
 
 	/* Limit to Microchip ISC hardware capabilities */
-	if (f->fmt.pix.width > isc->max_width)
-		f->fmt.pix.width = isc->max_width;
-	if (f->fmt.pix.height > isc->max_height)
-		f->fmt.pix.height = isc->max_height;
+	v4l_bound_align_image(&format.format.width, 16, isc->max_width, 0,
+			      &format.format.height, 16, isc->max_height, 0, 0);
 
-	isc->fmt = *f;
+	/* Check if the frame size is the same. Otherwise we may overflow */
+	if (pixfmt->height != format.format.height ||
+	    pixfmt->width != format.format.width) {
+		v4l2_err(&isc->v4l2_dev,
+			 "ISC not configured with the proper frame size: %dx%d\n",
+			 format.format.width, format.format.height);
+		return -EPIPE;
+	}
+
+	v4l2_dbg(1, debug, &isc->v4l2_dev,
+		 "Identified subdev using format %.4s with %dx%d %d bpp\n",
+		 (char *)&sd_fmt->fourcc, pixfmt->width, pixfmt->height,
+		 isc->try_config.bpp);
 
+	/* Reset and restart AWB if the subdevice changed the format */
 	if (isc->try_config.sd_format && isc->config.sd_format &&
 	    isc->try_config.sd_format != isc->config.sd_format) {
 		isc->ctrls.hist_stat = HIST_INIT;
 		isc_reset_awb_ctrls(isc);
 		isc_update_v4l2_ctrls(isc);
 	}
-	/* make the try configuration active */
+
+	/* Validate formats */
+	ret = isc_try_validate_formats(isc);
+	if (ret)
+		return ret;
+
+	/* Obtain frame sizes if possible to have crop requirements ready */
+	isc_try_fse(isc, &pad_state);
+
+	/* Configure ISC pipeline for the config */
+	ret = isc_try_configure_pipeline(isc);
+	if (ret)
+		return ret;
+
 	isc->config = isc->try_config;
 
 	v4l2_dbg(1, debug, &isc->v4l2_dev, "New ISC configuration in place\n");
@@ -1049,7 +1041,7 @@ static int isc_try_fmt_vid_cap(struct file *file, void *priv,
 {
 	struct isc_device *isc = video_drvdata(file);
 
-	return isc_try_fmt(isc, f, NULL);
+	return isc_try_fmt(isc, f);
 }
 
 static int isc_enum_input(struct file *file, void *priv,
@@ -1104,10 +1096,6 @@ static int isc_enum_framesizes(struct file *file, void *fh,
 	if (fsize->index)
 		return -EINVAL;
 
-	for (i = 0; i < isc->num_user_formats; i++)
-		if (isc->user_formats[i]->fourcc == fsize->pixel_format)
-			ret = 0;
-
 	for (i = 0; i < isc->controller_formats_size; i++)
 		if (isc->controller_formats[i].fourcc == fsize->pixel_format)
 			ret = 0;
@@ -1785,52 +1773,6 @@ struct isc_format *isc_find_format_by_code(struct isc_device *isc,
 }
 EXPORT_SYMBOL_GPL(isc_find_format_by_code);
 
-static int isc_formats_init(struct isc_device *isc)
-{
-	struct isc_format *fmt;
-	struct v4l2_subdev *subdev = isc->current_subdev->sd;
-	unsigned int num_fmts, i, j;
-	u32 list_size = isc->formats_list_size;
-	struct v4l2_subdev_mbus_code_enum mbus_code = {
-		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
-	};
-
-	num_fmts = 0;
-	while (!v4l2_subdev_call(subdev, pad, enum_mbus_code,
-				 NULL, &mbus_code)) {
-		mbus_code.index++;
-
-		fmt = isc_find_format_by_code(isc, mbus_code.code, &i);
-		if (!fmt) {
-			v4l2_warn(&isc->v4l2_dev, "Mbus code %x not supported\n",
-				  mbus_code.code);
-			continue;
-		}
-
-		fmt->sd_support = true;
-		num_fmts++;
-	}
-
-	if (!num_fmts)
-		return -ENXIO;
-
-	isc->num_user_formats = num_fmts;
-	isc->user_formats = devm_kcalloc(isc->dev,
-					 num_fmts, sizeof(*isc->user_formats),
-					 GFP_KERNEL);
-	if (!isc->user_formats)
-		return -ENOMEM;
-
-	fmt = &isc->formats_list[0];
-	for (i = 0, j = 0; i < list_size; i++) {
-		if (fmt->sd_support)
-			isc->user_formats[j++] = fmt;
-		fmt++;
-	}
-
-	return 0;
-}
-
 static int isc_set_default_fmt(struct isc_device *isc)
 {
 	struct v4l2_format f = {
@@ -1839,12 +1781,12 @@ static int isc_set_default_fmt(struct isc_device *isc)
 			.width		= VGA_WIDTH,
 			.height		= VGA_HEIGHT,
 			.field		= V4L2_FIELD_NONE,
-			.pixelformat	= isc->user_formats[0]->fourcc,
+			.pixelformat	= isc->controller_formats[0].fourcc,
 		},
 	};
 	int ret;
 
-	ret = isc_try_fmt(isc, &f, NULL);
+	ret = isc_try_fmt(isc, &f);
 	if (ret)
 		return ret;
 
@@ -1899,13 +1841,6 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	spin_lock_init(&isc->dma_queue_lock);
 	spin_lock_init(&isc->awb_lock);
 
-	ret = isc_formats_init(isc);
-	if (ret < 0) {
-		v4l2_err(&isc->v4l2_dev,
-			 "Init format failed: %d\n", ret);
-		goto isc_async_complete_err;
-	}
-
 	ret = isc_set_default_fmt(isc);
 	if (ret) {
 		v4l2_err(&isc->v4l2_dev, "Could not set default format\n");
@@ -1928,7 +1863,8 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	vdev->queue		= q;
 	vdev->lock		= &isc->lock;
 	vdev->ctrl_handler	= &isc->ctrls.handler;
-	vdev->device_caps	= V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_CAPTURE;
+	vdev->device_caps	= V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_CAPTURE |
+				  V4L2_CAP_IO_MC;
 	video_set_drvdata(vdev, isc);
 
 	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
@@ -2018,6 +1954,24 @@ int microchip_isc_pipeline_init(struct isc_device *isc)
 }
 EXPORT_SYMBOL_GPL(microchip_isc_pipeline_init);
 
+static int isc_link_validate(struct media_link *link)
+{
+	struct video_device *vdev =
+		media_entity_to_video_device(link->sink->entity);
+	struct isc_device *isc = video_get_drvdata(vdev);
+	int ret;
+
+	ret = v4l2_subdev_link_validate(link);
+	if (ret)
+		return ret;
+
+	return isc_validate(isc);
+}
+
+static const struct media_entity_operations isc_entity_operations = {
+	.link_validate = isc_link_validate,
+};
+
 int isc_mc_init(struct isc_device *isc, u32 ver)
 {
 	const struct of_device_id *match;
@@ -2025,6 +1979,8 @@ int isc_mc_init(struct isc_device *isc, u32 ver)
 
 	isc->video_dev.entity.function = MEDIA_ENT_F_IO_V4L;
 	isc->video_dev.entity.flags = MEDIA_ENT_FL_DEFAULT;
+	isc->video_dev.entity.ops = &isc_entity_operations;
+
 	isc->pads[ISC_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
 
 	ret = media_entity_pads_init(&isc->video_dev.entity, ISC_PADS_NUM,
diff --git a/drivers/media/platform/microchip/microchip-isc-scaler.c b/drivers/media/platform/microchip/microchip-isc-scaler.c
index 80fff803e6bb..0f29a32d15ce 100644
--- a/drivers/media/platform/microchip/microchip-isc-scaler.c
+++ b/drivers/media/platform/microchip/microchip-isc-scaler.c
@@ -173,6 +173,10 @@ static const struct v4l2_subdev_pad_ops isc_scaler_pad_ops = {
 	.init_cfg = isc_scaler_init_cfg,
 };
 
+static const struct media_entity_operations isc_scaler_entity_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+};
+
 static const struct v4l2_subdev_ops xisc_scaler_subdev_ops = {
 	.pad = &isc_scaler_pad_ops,
 };
@@ -190,6 +194,7 @@ int isc_scaler_init(struct isc_device *isc)
 
 	isc->scaler_sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	isc->scaler_sd.entity.function = MEDIA_ENT_F_PROC_VIDEO_SCALER;
+	isc->scaler_sd.entity.ops = &isc_scaler_entity_ops;
 	isc->scaler_pads[ISC_SCALER_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
 	isc->scaler_pads[ISC_SCALER_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE;
 
diff --git a/drivers/media/platform/microchip/microchip-isc.h b/drivers/media/platform/microchip/microchip-isc.h
index 1ba951df4f15..e3a6c7367e70 100644
--- a/drivers/media/platform/microchip/microchip-isc.h
+++ b/drivers/media/platform/microchip/microchip-isc.h
@@ -63,15 +63,16 @@ struct isc_subdev_entity {
  * @cfa_baycfg:		If this format is RAW BAYER, indicate the type of bayer.
 			this is either BGBG, RGRG, etc.
  * @pfe_cfg0_bps:	Number of hardware data lines connected to the ISC
+ * @raw:		If the format is raw bayer.
  */
 
 struct isc_format {
 	u32	fourcc;
 	u32	mbus_code;
 	u32	cfa_baycfg;
-
-	bool	sd_support;
 	u32	pfe_cfg0_bps;
+
+	bool	raw;
 };
 
 /* Pipeline bitmap */
@@ -216,8 +217,7 @@ enum isc_scaler_pads {
  * @comp:		completion reference that signals frame completion
  *
  * @fmt:		current v42l format
- * @user_formats:	list of formats that are supported and agreed with sd
- * @num_user_formats:	how many formats are in user_formats
+ * @try_fmt:		current v4l2 try format
  *
  * @config:		current ISC format configuration
  * @try_config:		the current ISC try format , not yet activated
@@ -272,6 +272,7 @@ enum isc_scaler_pads {
  * @formats_list_size:	size of formats_list array
  * @pads:		media controller pads for isc video entity
  * @mdev:		media device that is registered by the isc
+ * @mpipe:		media device pipeline used by the isc
  * @remote_pad:		remote pad on the connected subdevice
  * @scaler_sd:		subdevice for the scaler that isc registers
  * @scaler_pads:	media controller pads for the scaler subdevice
@@ -298,8 +299,7 @@ struct isc_device {
 	struct completion	comp;
 
 	struct v4l2_format	fmt;
-	struct isc_format	**user_formats;
-	unsigned int		num_user_formats;
+	struct v4l2_format	try_fmt;
 
 	struct fmt_config	config;
 	struct fmt_config	try_config;
@@ -369,6 +369,7 @@ struct isc_device {
 	struct {
 		struct media_pad		pads[ISC_PADS_NUM];
 		struct media_device		mdev;
+		struct media_pipeline		mpipe;
 
 		u32				remote_pad;
 	};
diff --git a/drivers/media/platform/microchip/microchip-sama5d2-isc.c b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
index c702d2537738..ac4715d91de6 100644
--- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
@@ -80,20 +80,40 @@ static const struct isc_format sama5d2_controller_formats[] = {
 		.fourcc		= V4L2_PIX_FMT_Y10,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SBGGR8,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SGBRG8,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SGRBG8,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SRGGB8,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SBGGR10,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SGBRG10,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SGRBG10,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SRGGB10,
+		.raw		= true,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SBGGR12,
+		.raw		= true,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGBRG12,
+		.raw		= true,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGRBG12,
+		.raw		= true,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SRGGB12,
+		.raw		= true,
 	},
 };
 
diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
index 75a0a5caa8d8..d583eafe5cc1 100644
--- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -89,20 +89,40 @@ static const struct isc_format sama7g5_controller_formats[] = {
 		.fourcc		= V4L2_PIX_FMT_Y16,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SBGGR8,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SGBRG8,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SGRBG8,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SRGGB8,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SBGGR10,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SGBRG10,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SGRBG10,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SRGGB10,
+		.raw		= true,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SBGGR12,
+		.raw		= true,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGBRG12,
+		.raw		= true,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGRBG12,
+		.raw		= true,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SRGGB12,
+		.raw		= true,
 	},
 };
 
-- 
2.25.1

