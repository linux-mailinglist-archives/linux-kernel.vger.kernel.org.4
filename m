Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB2E640BF9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbiLBRT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiLBRTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:19:48 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F23DE84
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:19:47 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vp12so13052073ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFhDF/K1xBNCd81nvtlYA1OZ1iPMNCjyBMR69X5yrP8=;
        b=OnqfxpYBgq8BfSAZy+0aiDmYmu4Ui/nnt1BwsyP4svRb1/JRQj2jsYjwDPit9TgF3x
         zBr3n0afLb0y5bu0zKq/jvP9jBSuuApOfW5uitOiyo4BynkDeM4gWg16s7qcAca3NuM5
         7ZzTnDc0pU++9WJX6SkNfIleoQIrvN19GTWxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFhDF/K1xBNCd81nvtlYA1OZ1iPMNCjyBMR69X5yrP8=;
        b=mapTm71tY9xO7tlsuEXFjQ8h3EM0qjGceS2KUTQTv9qzIbLf8v/skCNtSiClIER5oE
         iTgM6qjCTDoWmsKnrUs0I/XmLOVkftaYW3XqqFZhFG2WVLCNLeVNtDPCwibja2jBGl0M
         x4jgWp/j6rN2l+YtbqNUfukz13kwleh4u5SClniY9Afr948UJYIFKrH07Zt3uW8G5Wdw
         hzAKEiCo6SohjFJj+MY0uWX6BMW7jR46rTfCuz5TO5hc4MIf4Et4rAkp4OMtGasGMUBe
         2PyDwhliHG2m8JGOY6qndlkzxkfreCxWuQwVg72IS4a3q4d3LM8PORng/fe+5uYkC9WG
         ycPQ==
X-Gm-Message-State: ANoB5pnh8zE0pEagEn71PCOktI75Mn7SFv8LfDE/Zi9levjpwQeGDFT+
        NYCoVk4aXU3YGoyO0tRp1fHT7fvDkxFYxNuRkeg=
X-Google-Smtp-Source: AA0mqf57gBDuGNC6+g3M6fAIZwZumeByjSwDX5UdodOzlrHUgTN5/vjMouDcbmLXvHvnZyegWjSEng==
X-Received: by 2002:a17:906:fd57:b0:7be:5c6f:e63c with SMTP id wi23-20020a170906fd5700b007be5c6fe63cmr24887069ejb.253.1670001585627;
        Fri, 02 Dec 2022 09:19:45 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id l4-20020aa7c304000000b00458dc7e8ecasm3117864edq.72.2022.12.02.09.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:19:45 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:19:32 +0100
Subject: [PATCH v4 2/2] media: uvcvideo: Do power management granularly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-powersave-v4-2-47484ae40761@chromium.org>
References: <20220920-resend-powersave-v4-0-47484ae40761@chromium.org>
In-Reply-To: <20220920-resend-powersave-v4-0-47484ae40761@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
        Max Staudt <mstaudt@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=10459; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=SSBrN/bsc2uIn+IxDFf5q8l+vH/Kaz2gJNRm1Tk/syE=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjijOt9+69pqS/JyjZzJxwAfjl/TVNcKY1RM9s8Rt1
 4ku4YtKJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4ozrQAKCRDRN9E+zzrEiMIVD/
 9bJaHkb7L8HHLwtmaSp3YyoOpfDsiLWexi55+XzBDd8tLkMs39zKWfI3iTd/hob8AOGl7obuCsq+HL
 zar1D4pCWUONdTxo/UgbkMwL8LyQyuMw96jWcsG2slZ4CenSj5g8CTe9kTd3niOxznlRcH9rZW9XYY
 QQTYs2vclsTEyEqrC7vGqCWogXA0vdxk1qRlqaRr42VH4/Nwp/nkhDmoJVZWTBtBZ3WVRqrDs5zU/c
 VjbQgxdDqpAXNutD0cDHYcGeezpZThnrGz90L6VdVYa5zT0Q3IH7EtZWViUpROkUU9Qsa6bdL1ZJGq
 AiLM2MJb080zvoZXJi1OsspoznoZePjn2m2U2LEvARlGlwk+b0IlTKLCEsnRiUD3PR7asgNC5ceySj
 YBk4X1guM1X+uM4cI+jV9bFeoJ59Lb3RodbmREa/hLZ0dedaORhZE2LhE1v9YmSvTqjmkUlb69ZO6s
 B7RjuTH9FD2+5p/i410rYg+wHEuVV9WFSGCRElIz8Li5swyPdUmv92eHbnOU6XVRVkbJ6lfkApOOdv
 KPfghPjgOQvlBv97E9xiuUdpes5Q3sc4C1vNFPNfxaRB5AX7lptsmgCHRBc2QlfBhifQlSP9D8nZK3
 larJbpfx9uLosT9VlM5+0oPIHupUqMREJEVFWca4EO8x9MpwhMeMdKWgTZPQ==
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
 drivers/media/usb/uvc/uvc_v4l2.c | 174 ++++++++++++++++++++++++++++++++-------
 1 file changed, 142 insertions(+), 32 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 1389a87b8ae1..f5b0f1905962 100644
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
 
@@ -468,7 +512,13 @@ static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
 	}
 
 	/* Probe the device with the new settings. */
+	ret = uvc_pm_get(stream);
+	if (ret) {
+		mutex_unlock(&stream->mutex);
+		return ret;
+	}
 	ret = uvc_probe_video(stream, &probe);
+	uvc_pm_put(stream);
 	if (ret < 0) {
 		mutex_unlock(&stream->mutex);
 		return ret;
@@ -559,36 +609,29 @@ static int uvc_v4l2_open(struct file *file)
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
@@ -610,6 +653,12 @@ static int uvc_v4l2_release(struct file *file)
 	if (uvc_has_privileges(handle))
 		uvc_queue_release(&stream->queue);
 
+	if (handle->is_streaming)
+		uvc_pm_put(stream);
+
+	if (stream->dev->input)
+		uvc_pm_put(stream);
+
 	/* Release the file handle. */
 	uvc_dismiss_privileges(handle);
 	v4l2_fh_del(&handle->vfh);
@@ -617,12 +666,6 @@ static int uvc_v4l2_release(struct file *file)
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
 
@@ -849,9 +892,17 @@ static int uvc_ioctl_streamon(struct file *file, void *fh,
 
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
 
@@ -875,6 +926,9 @@ static int uvc_ioctl_streamoff(struct file *file, void *fh,
 	ret = uvc_queue_streamoff(&stream->queue, type);
 	handle->is_streaming = !!ret;
 
+	if (!handle->is_streaming)
+		uvc_pm_put(stream);
+
 unlock:
 	mutex_unlock(&stream->mutex);
 
@@ -928,6 +982,7 @@ static int uvc_ioctl_g_input(struct file *file, void *fh, unsigned int *input)
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
 	u8 *buf;
 	int ret;
 
@@ -941,9 +996,16 @@ static int uvc_ioctl_g_input(struct file *file, void *fh, unsigned int *input)
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
 
@@ -956,6 +1018,7 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
 	u8 *buf;
 	int ret;
 
@@ -977,10 +1040,17 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
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
@@ -991,8 +1061,15 @@ static int uvc_ioctl_queryctrl(struct file *file, void *fh,
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
@@ -1000,10 +1077,15 @@ static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
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
 
@@ -1049,6 +1131,7 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
 	struct v4l2_ext_control *ctrl = ctrls->controls;
 	unsigned int i;
 	int ret;
@@ -1073,22 +1156,30 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
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
@@ -1097,6 +1188,7 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
 {
 	struct v4l2_ext_control *ctrl = ctrls->controls;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
 	unsigned int i;
 	int ret;
 
@@ -1104,9 +1196,15 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
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
@@ -1114,16 +1212,20 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
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
@@ -1147,8 +1249,16 @@ static int uvc_ioctl_querymenu(struct file *file, void *fh,
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_streaming *stream = handle->stream;
+	int ret;
+
+	ret = uvc_pm_get(stream);
+	if (ret)
+		return ret;
+	ret = uvc_query_v4l2_menu(chain, qm);
+	uvc_pm_put(stream);
 
-	return uvc_query_v4l2_menu(chain, qm);
+	return ret;
 }
 
 static int uvc_ioctl_g_selection(struct file *file, void *fh,

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
