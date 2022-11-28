Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D883263AA85
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiK1OJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiK1OIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:08:52 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5387422B18;
        Mon, 28 Nov 2022 06:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669644480; x=1701180480;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dFABwFPijKhFczAL0bN4/gCsJpbf1kjPLAX8K5/iW2E=;
  b=wHem7hrOOItXtMZDO9sjG4DGwD3wZNXZWeyp05LrQtuf+clyyQsGncCn
   5MV9wu68VtEbQqzxX2u7M4/u5L7eemvx9HbKwCGgOrKx1m5/gJcF85Z2E
   MdsJc3Shk1HPQgR7JBnjP/kxkVmYKSNZLUo7euhxkonljL2S0sX96lNP1
   L/vKsCdir8gaEY00Sys+ls3zj4ZL9wVCLm/Mslt5vbjrFG+TusnImSWFX
   dAsNO6Rmn7QWAItV4QwfbOlxWzSXDKzo/dtxOMwMW5iqy5A2OmkU7V42Z
   ABwCVRUar8fnyos5jLcLqbnPCkHd/I0FMCo5L9CUkXqdjfh4/zIAp1rDX
   A==;
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="185487063"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Nov 2022 07:07:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 28 Nov 2022 07:07:31 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 28 Nov 2022 07:07:30 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH] media: microchip: microchip-isc: replace v4l2_{dbg|info|err} with dev-*
Date:   Mon, 28 Nov 2022 16:07:17 +0200
Message-ID: <20221128140717.77627-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
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

v4l2_dbg and friends are legacy and should be removed.
Replaced all the calls with dev_dbg equivalent.
This also removes the 'debug' module parameter which has become obsolete.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 .../platform/microchip/microchip-isc-base.c   | 109 ++++++++----------
 1 file changed, 48 insertions(+), 61 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index e2994d48f10c..71758ee8474b 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -32,10 +32,6 @@
 #include "microchip-isc-regs.h"
 #include "microchip-isc.h"
 
-static unsigned int debug;
-module_param(debug, int, 0644);
-MODULE_PARM_DESC(debug, "debug level (0-2)");
-
 #define ISC_IS_FORMAT_RAW(mbus_code) \
 	(((mbus_code) & 0xf000) == 0x3000)
 
@@ -114,8 +110,8 @@ static int isc_buffer_prepare(struct vb2_buffer *vb)
 	unsigned long size = isc->fmt.fmt.pix.sizeimage;
 
 	if (vb2_plane_size(vb, 0) < size) {
-		v4l2_err(&isc->v4l2_dev, "buffer too small (%lu < %lu)\n",
-			 vb2_plane_size(vb, 0), size);
+		dev_err(isc->dev, "buffer too small (%lu < %lu)\n",
+			vb2_plane_size(vb, 0), size);
 		return -EINVAL;
 	}
 
@@ -346,15 +342,14 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
 	/* Enable stream on the sub device */
 	ret = v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 1);
 	if (ret && ret != -ENOIOCTLCMD) {
-		v4l2_err(&isc->v4l2_dev, "stream on failed in subdev %d\n",
-			 ret);
+		dev_err(isc->dev, "stream on failed in subdev %d\n", ret);
 		goto err_start_stream;
 	}
 
 	ret = pm_runtime_resume_and_get(isc->dev);
 	if (ret < 0) {
-		v4l2_err(&isc->v4l2_dev, "RPM resume failed in subdev %d\n",
-			 ret);
+		dev_err(isc->dev, "RPM resume failed in subdev %d\n",
+			ret);
 		goto err_pm_get;
 	}
 
@@ -423,8 +418,7 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 
 	/* Wait until the end of the current frame */
 	if (isc->cur_frm && !wait_for_completion_timeout(&isc->comp, 5 * HZ))
-		v4l2_err(&isc->v4l2_dev,
-			 "Timeout waiting for end of the capture\n");
+		dev_err(isc->dev, "Timeout waiting for end of the capture\n");
 
 	mutex_unlock(&isc->awb_mutex);
 
@@ -436,7 +430,7 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 	/* Disable stream on the sub device */
 	ret = v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 0);
 	if (ret && ret != -ENOIOCTLCMD)
-		v4l2_err(&isc->v4l2_dev, "stream off failed in subdev\n");
+		dev_err(isc->dev, "stream off failed in subdev\n");
 
 	/* Release all active buffers */
 	spin_lock_irqsave(&isc->dma_queue_lock, flags);
@@ -620,28 +614,28 @@ static int isc_try_validate_formats(struct isc_device *isc)
 		break;
 	default:
 	/* any other different formats are not supported */
-		v4l2_err(&isc->v4l2_dev, "Requested unsupported format.\n");
+		dev_err(isc->dev, "Requested unsupported format.\n");
 		ret = -EINVAL;
 	}
-	v4l2_dbg(1, debug, &isc->v4l2_dev,
-		 "Format validation, requested rgb=%u, yuv=%u, grey=%u, bayer=%u\n",
-		 rgb, yuv, grey, bayer);
+	dev_dbg(isc->dev,
+		"Format validation, requested rgb=%u, yuv=%u, grey=%u, bayer=%u\n",
+		rgb, yuv, grey, bayer);
 
 	if (bayer &&
 	    !ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code)) {
-		v4l2_err(&isc->v4l2_dev, "Cannot output RAW if we do not receive RAW.\n");
+		dev_err(isc->dev, "Cannot output RAW if we do not receive RAW.\n");
 		return -EINVAL;
 	}
 
 	if (grey && !ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code) &&
 	    !ISC_IS_FORMAT_GREY(isc->try_config.sd_format->mbus_code)) {
-		v4l2_err(&isc->v4l2_dev, "Cannot output GREY if we do not receive RAW/GREY.\n");
+		dev_err(isc->dev, "Cannot output GREY if we do not receive RAW/GREY.\n");
 		return -EINVAL;
 	}
 
 	if ((rgb || bayer || yuv) &&
 	    ISC_IS_FORMAT_GREY(isc->try_config.sd_format->mbus_code)) {
-		v4l2_err(&isc->v4l2_dev, "Cannot convert GREY to another format.\n");
+		dev_err(isc->dev, "Cannot convert GREY to another format.\n");
 		return -EINVAL;
 	}
 
@@ -936,9 +930,9 @@ static int isc_set_fmt(struct isc_device *isc, struct v4l2_format *f)
 	isc->config = isc->try_config;
 	isc->fmt = isc->try_fmt;
 
-	v4l2_dbg(1, debug, &isc->v4l2_dev, "ISC set_fmt to %.4s @%dx%d\n",
-		 (char *)&f->fmt.pix.pixelformat,
-		 f->fmt.pix.width, f->fmt.pix.height);
+	dev_dbg(isc->dev, "ISC set_fmt to %.4s @%dx%d\n",
+		(char *)&f->fmt.pix.pixelformat,
+		f->fmt.pix.width, f->fmt.pix.height);
 
 	return 0;
 }
@@ -973,9 +967,9 @@ static int isc_validate(struct isc_device *isc)
 
 	/* Check if the format is not supported */
 	if (!sd_fmt) {
-		v4l2_err(&isc->v4l2_dev,
-			 "Current subdevice is streaming a media bus code that is not supported 0x%x\n",
-			 format.format.code);
+		dev_err(isc->dev,
+			"Current subdevice is streaming a media bus code that is not supported 0x%x\n",
+			format.format.code);
 		return -EPIPE;
 	}
 
@@ -993,16 +987,16 @@ static int isc_validate(struct isc_device *isc)
 	/* Check if the frame size is the same. Otherwise we may overflow */
 	if (pixfmt->height != format.format.height ||
 	    pixfmt->width != format.format.width) {
-		v4l2_err(&isc->v4l2_dev,
-			 "ISC not configured with the proper frame size: %dx%d\n",
-			 format.format.width, format.format.height);
+		dev_err(isc->dev,
+			"ISC not configured with the proper frame size: %dx%d\n",
+			format.format.width, format.format.height);
 		return -EPIPE;
 	}
 
-	v4l2_dbg(1, debug, &isc->v4l2_dev,
-		 "Identified subdev using format %.4s with %dx%d %d bpp\n",
-		 (char *)&sd_fmt->fourcc, pixfmt->width, pixfmt->height,
-		 isc->try_config.bpp);
+	dev_dbg(isc->dev,
+		"Identified subdev using format %.4s with %dx%d %d bpp\n",
+		(char *)&sd_fmt->fourcc, pixfmt->width, pixfmt->height,
+		isc->try_config.bpp);
 
 	/* Reset and restart AWB if the subdevice changed the format */
 	if (isc->try_config.sd_format && isc->config.sd_format &&
@@ -1027,7 +1021,7 @@ static int isc_validate(struct isc_device *isc)
 
 	isc->config = isc->try_config;
 
-	v4l2_dbg(1, debug, &isc->v4l2_dev, "New ISC configuration in place\n");
+	dev_dbg(isc->dev, "New ISC configuration in place\n");
 
 	return 0;
 }
@@ -1294,9 +1288,8 @@ static void isc_hist_count(struct isc_device *isc, u32 *min, u32 *max)
 	if (!*min)
 		*min = 1;
 
-	v4l2_dbg(1, debug, &isc->v4l2_dev,
-		 "isc wb: hist_id %u, hist_count %u",
-		 ctrls->hist_id, *hist_count);
+	dev_dbg(isc->dev, "isc wb: hist_id %u, hist_count %u",
+		ctrls->hist_id, *hist_count);
 }
 
 static void isc_wb_update(struct isc_ctrls *ctrls)
@@ -1318,8 +1311,7 @@ static void isc_wb_update(struct isc_ctrls *ctrls)
 		(u64)hist_count[ISC_HIS_CFG_MODE_GB];
 	avg >>= 1;
 
-	v4l2_dbg(1, debug, &isc->v4l2_dev,
-		 "isc wb: green components average %llu\n", avg);
+	dev_dbg(isc->dev, "isc wb: green components average %llu\n", avg);
 
 	/* Green histogram is null, nothing to do */
 	if (!avg)
@@ -1373,9 +1365,9 @@ static void isc_wb_update(struct isc_ctrls *ctrls)
 		else
 			gw_gain[c] = 1 << 9;
 
-		v4l2_dbg(1, debug, &isc->v4l2_dev,
-			 "isc wb: component %d, s_gain %u, gw_gain %u\n",
-			 c, s_gain[c], gw_gain[c]);
+		dev_dbg(isc->dev,
+			"isc wb: component %d, s_gain %u, gw_gain %u\n",
+			c, s_gain[c], gw_gain[c]);
 		/* multiply both gains and adjust for decimals */
 		ctrls->gain[c] = s_gain[c] * gw_gain[c];
 		ctrls->gain[c] >>= 9;
@@ -1383,9 +1375,8 @@ static void isc_wb_update(struct isc_ctrls *ctrls)
 		/* make sure we are not out of range */
 		ctrls->gain[c] = clamp_val(ctrls->gain[c], 0, GENMASK(12, 0));
 
-		v4l2_dbg(1, debug, &isc->v4l2_dev,
-			 "isc wb: component %d, final gain %u\n",
-			 c, ctrls->gain[c]);
+		dev_dbg(isc->dev, "isc wb: component %d, final gain %u\n",
+			c, ctrls->gain[c]);
 	}
 }
 
@@ -1406,8 +1397,8 @@ static void isc_awb_work(struct work_struct *w)
 
 	isc_hist_count(isc, &min, &max);
 
-	v4l2_dbg(1, debug, &isc->v4l2_dev,
-		 "isc wb mode %d: hist min %u , max %u\n", hist_id, min, max);
+	dev_dbg(isc->dev,
+		"isc wb mode %d: hist min %u , max %u\n", hist_id, min, max);
 
 	ctrls->hist_minmax[hist_id][HIST_MIN_INDEX] = min;
 	ctrls->hist_minmax[hist_id][HIST_MAX_INDEX] = max;
@@ -1446,8 +1437,8 @@ static void isc_awb_work(struct work_struct *w)
 		 * we are basically done.
 		 */
 		if (ctrls->awb == ISC_WB_ONETIME) {
-			v4l2_info(&isc->v4l2_dev,
-				  "Completed one time white-balance adjustment.\n");
+			dev_info(isc->dev,
+				 "Completed one time white-balance adjustment.\n");
 			/* update the v4l2 controls values */
 			isc_update_v4l2_ctrls(isc);
 			ctrls->awb = ISC_WB_NONE;
@@ -1580,8 +1571,7 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
 		    V4L2_CTRL_FLAG_INACTIVE)) {
 			ctrls->awb = ISC_WB_ONETIME;
 			isc_set_histogram(isc, true);
-			v4l2_dbg(1, debug, &isc->v4l2_dev,
-				 "One time white-balance started.\n");
+			dev_dbg(isc->dev, "One time white-balance started.\n");
 		}
 		return 0;
 	}
@@ -1730,7 +1720,7 @@ static int isc_async_bound(struct v4l2_async_notifier *notifier,
 	int pad;
 
 	if (video_is_registered(&isc->video_dev)) {
-		v4l2_err(&isc->v4l2_dev, "only supports one sub-device.\n");
+		dev_err(isc->dev, "only supports one sub-device.\n");
 		return -EBUSY;
 	}
 
@@ -1739,8 +1729,7 @@ static int isc_async_bound(struct v4l2_async_notifier *notifier,
 	pad = media_entity_get_fwnode_pad(&subdev->entity, asd->match.fwnode,
 					  MEDIA_PAD_FL_SOURCE);
 	if (pad < 0) {
-		v4l2_err(&isc->v4l2_dev, "failed to find pad for %s\n",
-			 subdev->name);
+		dev_err(isc->dev, "failed to find pad for %s\n", subdev->name);
 		return pad;
 	}
 
@@ -1813,7 +1802,7 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 
 	ret = v4l2_device_register_subdev_nodes(&isc->v4l2_dev);
 	if (ret < 0) {
-		v4l2_err(&isc->v4l2_dev, "Failed to register subdev nodes\n");
+		dev_err(isc->dev, "Failed to register subdev nodes\n");
 		return ret;
 	}
 
@@ -1838,8 +1827,7 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 
 	ret = vb2_queue_init(q);
 	if (ret < 0) {
-		v4l2_err(&isc->v4l2_dev,
-			 "vb2_queue_init() failed: %d\n", ret);
+		dev_err(isc->dev, "vb2_queue_init() failed: %d\n", ret);
 		goto isc_async_complete_err;
 	}
 
@@ -1850,13 +1838,13 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 
 	ret = isc_set_default_fmt(isc);
 	if (ret) {
-		v4l2_err(&isc->v4l2_dev, "Could not set default format\n");
+		dev_err(isc->dev, "Could not set default format\n");
 		goto isc_async_complete_err;
 	}
 
 	ret = isc_ctrl_init(isc);
 	if (ret) {
-		v4l2_err(&isc->v4l2_dev, "Init isc ctrols failed: %d\n", ret);
+		dev_err(isc->dev, "Init isc ctrols failed: %d\n", ret);
 		goto isc_async_complete_err;
 	}
 
@@ -1876,8 +1864,7 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 
 	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 	if (ret < 0) {
-		v4l2_err(&isc->v4l2_dev,
-			 "video_register_device failed: %d\n", ret);
+		dev_err(isc->dev, "video_register_device failed: %d\n", ret);
 		goto isc_async_complete_err;
 	}
 
-- 
2.25.1

