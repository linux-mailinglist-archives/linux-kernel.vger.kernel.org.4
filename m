Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643A664454D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiLFOHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiLFOHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:07:31 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EB02B615
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:07:29 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id b2so6430383eja.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 06:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYJy/7NuiOmPove/gZ/LuJCrIxp8oUjqtCILM26tCpI=;
        b=cOunwgIBEgYS8IxoDDCceIQqs6OkMpceiVVxDbwj3iOM0kv872BdVyugcGg3woPwTR
         2PEnTHX0mgRYlL6aNpx/oThrHG/Rt0t1PDQa/8L7dA9ewziDqQIEbXR5W8Vu28OVL13o
         mxVCczo5kJ3Mtj9ea/ZmzhcRCN51Jt4zfJvNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYJy/7NuiOmPove/gZ/LuJCrIxp8oUjqtCILM26tCpI=;
        b=AXJe8kCyT1caBU4kvCbemICFPfCpghBhj97bqlFBJ0RD+h5CWGWgg7Bz/h1dB7tGY0
         14xdAwA0pSJLdf/KDjXEW4vrDQNvvIT215teiIZb93U7ZJXmiQrqOXW3boYd4fx3JDsx
         P5RzKCThh7c2pUEz3+PIwJsCT9o78Z+QfaKZx+HAYZalrqnkBgYuTodaxx9Yb4MGBKS9
         2R8fYFr2slsEXvOBBgGtaug7g2VNxyahDqz9+Mltl/P70OUpnemHPiBT9NN8d2N4JSyG
         X6SWzip2SsOJLfG169eT2XbkHR7qPI8aqQ1Y/5WKBNEnhEa5LYVLJld7VQ7pix9l3G9U
         Vo+g==
X-Gm-Message-State: ANoB5pkcZOxp2pywdibAq642S5EDRpm3nCcE0aJXgu6DEpCxatyxayht
        L0wZFzLXZLoGbBerM3Qbw32NAw==
X-Google-Smtp-Source: AA0mqf7xf8q1qhQYgDVIPVzwu8g/+Ayklud0L62gqsy4jSdT3kOnnmOC1AuadZRLLOHU2pV81V//5A==
X-Received: by 2002:a17:906:4a03:b0:7c1:13b6:fc50 with SMTP id w3-20020a1709064a0300b007c113b6fc50mr1122247eju.70.1670335648464;
        Tue, 06 Dec 2022 06:07:28 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c82e:c2a2:971e:1766])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906305500b007838e332d78sm7388027ejd.128.2022.12.06.06.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 06:07:28 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 06 Dec 2022 15:06:56 +0100
Subject: [PATCH v5 2/2] media: uvcvideo: Do power management granularly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-powersave-v5-2-692e6df6c1e2@chromium.org>
References: <20220920-resend-powersave-v5-0-692e6df6c1e2@chromium.org>
In-Reply-To: <20220920-resend-powersave-v5-0-692e6df6c1e2@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, Max Staudt <mstaudt@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=11450; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=v16u9iRE60ht7hVPIL/MQ/QwTUzU267J4r6CTkFMPcU=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjj0yZk4WRUyilMVGojY7L7e+SkelzL4VpBQsyy/7k
 0km1oD+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY49MmQAKCRDRN9E+zzrEiKzMD/
 9sIxj+c74Nym7fjkYdRdesLFOYREpQfnsXc+ItmkiLBgkkeBCbFyQIsBXeCc5TXZ0OTJC69MatgcmB
 9C4NHsiyhq2eFQmAY2g35RT7kU5IfM9YFiBrjvd/WgyEB95dnurSfLkqkAF1I6K8gH6VmBbefJhGO0
 BIqpYzIgINT7kkhq2zUWCK4fT1e3j4KgRejNPHy9thbWX2Whh+uPrQCsp9MTkRsczr6S/j4k0XZ1m6
 JLuEyAHRY3dYTsgXmG/RO8Z8Z2qcn1t2BvhaxaF0xZR5ZZXA+ZdvYbKvb6VEEejgzD9YIjygTT+Jk+
 to3NiY3kpTsahZjI/x4Krq1FaX56CvhicjQEQno5uXItJRAeM75YxDfB0wxK/dj6bocndWo3x+O3gu
 n9ia1Z5qfRjYqsFSuMkU8IczLiWdhlXdePDkweS9sf6sG6262+pRWEtvdd8r5qTjSngeBMm9DQjA7J
 zQYL1sKuPik7O76q5fHZC9ioTtbydCcZpY1q5BcCc6G55qJr2oO8I2TGxiBQgDEHUYn8HOWcjMP4LO
 9NrJHDn0vY2gaR+7msvZiD/n8mv6koRQ2h/Ltv/moelFqb7VNq/fYNMqb+Aq+WAu4JCLz/hLrMJISs
 +yBB4xsYKBcsA7grT2+SLnqAfJGz9lAIrG2zDffJkljvgcoYgG1CvsZq7WWA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of suspending/resume the USB device at open()/close(), do it
when the device is actually used.

This way we can reduce the power consumption when a service is holding
the video device and leaving it in an idle state.

Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Reviewed-by: Max Staudt <mstaudt@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 198 +++++++++++++++++++++++++++++++--------
 1 file changed, 161 insertions(+), 37 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 1389a87b8ae1..2e8f78bd1e4e 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -25,6 +25,46 @@
 
 #include "uvcvideo.h"
 
+/* ------------------------------------------------------------------------
+ * UVC power management
+ */
+
+static int uvc_pm_get(struct uvc_streaming *stream)
+{
+	int ret;
+
+	ret = usb_autopm_get_interface(stream->dev->intf);
+	if (ret)
+		return ret;
+
+	mutex_lock(&stream->dev->lock);
+	if (!stream->dev->users)
+		ret = uvc_status_start(stream->dev, GFP_KERNEL);
+	if (!ret)
+		stream->dev->users++;
+	mutex_unlock(&stream->dev->lock);
+
+	if (ret)
+		usb_autopm_put_interface(stream->dev->intf);
+
+	return ret;
+}
+
+static void uvc_pm_put(struct uvc_streaming *stream)
+{
+	mutex_lock(&stream->dev->lock);
+	if (WARN_ON(!stream->dev->users)) {
+		mutex_unlock(&stream->dev->lock);
+		return;
+	}
+	stream->dev->users--;
+	if (!stream->dev->users)
+		uvc_status_stop(stream->dev);
+	mutex_unlock(&stream->dev->lock);
+
+	usb_autopm_put_interface(stream->dev->intf);
+}
+
 /* ------------------------------------------------------------------------
  * UVC ioctls
  */
@@ -249,6 +289,9 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
 	 * developers test their webcams with the Linux driver as well as with
 	 * the Windows driver).
 	 */
+	ret = uvc_pm_get(stream);
+	if (ret)
+		return ret;
 	mutex_lock(&stream->mutex);
 	if (stream->dev->quirks & UVC_QUIRK_PROBE_EXTRAFIELDS)
 		probe->dwMaxVideoFrameSize =
@@ -257,6 +300,7 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
 	/* Probe the device. */
 	ret = uvc_probe_video(stream, probe);
 	mutex_unlock(&stream->mutex);
+	uvc_pm_put(stream);
 	if (ret < 0)
 		return ret;
 
@@ -408,8 +452,8 @@ static int uvc_v4l2_get_streamparm(struct uvc_streaming *stream,
 	return 0;
 }
 
-static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
-		struct v4l2_streamparm *parm)
+static int __uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
+				     struct v4l2_streamparm *parm)
 {
 	struct uvc_streaming_control probe;
 	struct v4l2_fract timeperframe;
@@ -419,9 +463,6 @@ static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
 	unsigned int i;
 	int ret;
 
-	if (parm->type != stream->type)
-		return -EINVAL;
-
 	if (parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
 		timeperframe = parm->parm.capture.timeperframe;
 	else
@@ -495,6 +536,25 @@ static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
 	return 0;
 }
 
+static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
+				   struct v4l2_streamparm *parm)
+{
+	int ret;
+
+	if (parm->type != stream->type)
+		return -EINVAL;
+
+	ret = uvc_pm_get(stream);
+	if (ret)
+		return ret;
+
+	ret = __uvc_v4l2_set_streamparm(stream, parm);
+
+	uvc_pm_put(stream);
+
+	return ret;
+}
+
 /* ------------------------------------------------------------------------
  * Privilege management
  */
@@ -559,36 +619,29 @@ static int uvc_v4l2_open(struct file *file)
 {
 	struct uvc_streaming *stream;
 	struct uvc_fh *handle;
-	int ret = 0;
 
 	stream = video_drvdata(file);
 	uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
 
-	ret = usb_autopm_get_interface(stream->dev->intf);
-	if (ret < 0)
-		return ret;
-
 	/* Create the device handle. */
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-	if (handle == NULL) {
-		usb_autopm_put_interface(stream->dev->intf);
+	if (!handle)
 		return -ENOMEM;
-	}
 
-	mutex_lock(&stream->dev->lock);
-	if (stream->dev->users == 0) {
-		ret = uvc_status_start(stream->dev, GFP_KERNEL);
-		if (ret < 0) {
-			mutex_unlock(&stream->dev->lock);
-			usb_autopm_put_interface(stream->dev->intf);
+	/*
+	 * If the uvc evdev exists we cannot suspend when the device
+	 * is idle. Otherwise we will miss button actions.
+	 */
+	if (stream->dev->input) {
+		int ret;
+
+		ret = uvc_pm_get(stream);
+		if (ret) {
 			kfree(handle);
 			return ret;
 		}
 	}
 
-	stream->dev->users++;
-	mutex_unlock(&stream->dev->lock);
-
 	v4l2_fh_init(&handle->vfh, &stream->vdev);
 	v4l2_fh_add(&handle->vfh);
 	handle->chain = stream->chain;
@@ -610,6 +663,16 @@ static int uvc_v4l2_release(struct file *file)
 	if (uvc_has_privileges(handle))
 		uvc_queue_release(&stream->queue);
 
+	/*
+	 * Release cannot happen at the same time as streamon/streamoff
+	 * no need to take the stream->mutex.
+	 */
+	if (handle->is_streaming)
+		uvc_pm_put(stream);
+
+	if (stream->dev->input)
+		uvc_pm_put(stream);
+
 	/* Release the file handle. */
 	uvc_dismiss_privileges(handle);
 	v4l2_fh_del(&handle->vfh);
@@ -617,12 +680,6 @@ static int uvc_v4l2_release(struct file *file)
 	kfree(handle);
 	file->private_data = NULL;
 
-	mutex_lock(&stream->dev->lock);
-	if (--stream->dev->users == 0)
-		uvc_status_stop(stream->dev);
-	mutex_unlock(&stream->dev->lock);
-
-	usb_autopm_put_interface(stream->dev->intf);
 	return 0;
 }
 
@@ -849,9 +906,17 @@ static int uvc_ioctl_streamon(struct file *file, void *fh,
 
 	if (handle->is_streaming)
 		goto unlock;
+
+	ret = uvc_pm_get(stream);
+	if (ret)
+		goto unlock;
+
 	ret = uvc_queue_streamon(&stream->queue, type);
 	handle->is_streaming = !ret;
 
+	if (!handle->is_streaming)
+		uvc_pm_put(stream);
+
 unlock:
 	mutex_unlock(&stream->mutex);
 
@@ -875,6 +940,9 @@ static int uvc_ioctl_streamoff(struct file *file, void *fh,
 	ret = uvc_queue_streamoff(&stream->queue, type);
 	handle->is_streaming = !!ret;
 
+	if (!handle->is_streaming)
+		uvc_pm_put(stream);
+
 unlock:
 	mutex_unlock(&stream->mutex);
 
@@ -928,6 +996,7 @@ static int uvc_ioctl_g_input(struct file *file, void *fh, unsigned int *input)
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
 	u8 *buf;
 	int ret;
 
@@ -941,9 +1010,16 @@ static int uvc_ioctl_g_input(struct file *file, void *fh, unsigned int *input)
 	if (!buf)
 		return -ENOMEM;
 
+	ret = uvc_pm_get(stream);
+	if (ret) {
+		kfree(buf);
+		return ret;
+	}
+
 	ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR, chain->selector->id,
 			     chain->dev->intfnum,  UVC_SU_INPUT_SELECT_CONTROL,
 			     buf, 1);
+	uvc_pm_put(stream);
 	if (!ret)
 		*input = *buf - 1;
 
@@ -956,6 +1032,7 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
 	u8 *buf;
 	int ret;
 
@@ -977,10 +1054,17 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
 	if (!buf)
 		return -ENOMEM;
 
+	ret = uvc_pm_get(stream);
+	if (ret) {
+		kfree(buf);
+		return ret;
+	}
+
 	*buf = input + 1;
 	ret = uvc_query_ctrl(chain->dev, UVC_SET_CUR, chain->selector->id,
 			     chain->dev->intfnum, UVC_SU_INPUT_SELECT_CONTROL,
 			     buf, 1);
+	uvc_pm_put(stream);
 	kfree(buf);
 
 	return ret;
@@ -991,8 +1075,15 @@ static int uvc_ioctl_queryctrl(struct file *file, void *fh,
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
+	int ret;
 
-	return uvc_query_v4l2_ctrl(chain, qc);
+	ret = uvc_pm_get(stream);
+	if (ret)
+		return ret;
+	ret = uvc_query_v4l2_ctrl(chain, qc);
+	uvc_pm_put(stream);
+	return ret;
 }
 
 static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
@@ -1000,10 +1091,15 @@ static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
 	struct v4l2_queryctrl qc = { qec->id };
 	int ret;
 
+	ret = uvc_pm_get(stream);
+	if (ret)
+		return ret;
 	ret = uvc_query_v4l2_ctrl(chain, &qc);
+	uvc_pm_put(stream);
 	if (ret)
 		return ret;
 
@@ -1049,6 +1145,7 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
 	struct v4l2_ext_control *ctrl = ctrls->controls;
 	unsigned int i;
 	int ret;
@@ -1073,22 +1170,30 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
 		return 0;
 	}
 
+	ret = uvc_pm_get(stream);
+	if (ret)
+		return ret;
 	ret = uvc_ctrl_begin(chain);
-	if (ret < 0)
+	if (ret < 0) {
+		uvc_pm_put(stream);
 		return ret;
+	}
 
 	for (i = 0; i < ctrls->count; ++ctrl, ++i) {
 		ret = uvc_ctrl_get(chain, ctrl);
 		if (ret < 0) {
 			uvc_ctrl_rollback(handle);
 			ctrls->error_idx = i;
-			return ret;
+			goto done;
 		}
 	}
 
 	ctrls->error_idx = 0;
 
-	return uvc_ctrl_rollback(handle);
+	ret = uvc_ctrl_rollback(handle);
+done:
+	uvc_pm_put(stream);
+	return ret;
 }
 
 static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
@@ -1097,6 +1202,7 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
 {
 	struct v4l2_ext_control *ctrl = ctrls->controls;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
 	unsigned int i;
 	int ret;
 
@@ -1104,9 +1210,15 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
 	if (ret < 0)
 		return ret;
 
+	ret = uvc_pm_get(stream);
+	if (ret)
+		return ret;
+
 	ret = uvc_ctrl_begin(chain);
-	if (ret < 0)
+	if (ret < 0) {
+		uvc_pm_put(stream);
 		return ret;
+	}
 
 	for (i = 0; i < ctrls->count; ++ctrl, ++i) {
 		ret = uvc_ctrl_set(handle, ctrl);
@@ -1114,16 +1226,20 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
 			uvc_ctrl_rollback(handle);
 			ctrls->error_idx = ioctl == VIDIOC_S_EXT_CTRLS ?
 						    ctrls->count : i;
-			return ret;
+			goto done;
 		}
 	}
 
 	ctrls->error_idx = 0;
 
 	if (ioctl == VIDIOC_S_EXT_CTRLS)
-		return uvc_ctrl_commit(handle, ctrls);
+		ret = uvc_ctrl_commit(handle, ctrls);
 	else
-		return uvc_ctrl_rollback(handle);
+		ret = uvc_ctrl_rollback(handle);
+
+done:
+	uvc_pm_put(stream);
+	return ret;
 }
 
 static int uvc_ioctl_s_ext_ctrls(struct file *file, void *fh,
@@ -1147,8 +1263,16 @@ static int uvc_ioctl_querymenu(struct file *file, void *fh,
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
+	int ret;
 
-	return uvc_query_v4l2_menu(chain, qm);
+	ret = uvc_pm_get(stream);
+	if (ret)
+		return ret;
+	ret = uvc_query_v4l2_menu(chain, qm);
+	uvc_pm_put(stream);
+
+	return ret;
 }
 
 static int uvc_ioctl_g_selection(struct file *file, void *fh,

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
