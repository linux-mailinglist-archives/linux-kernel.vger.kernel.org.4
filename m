Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE5C60E03B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbiJZMGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiJZMGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:06:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978BA87685
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:06:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x2so13803744edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3aLAqx1UmJhgGtzBHcHb9QyFZFPiOEXRjvNmq6X8fw=;
        b=edNMJTQ85mCASuHS8h6GXdQovCDGcQOiwkAINEAoQc7dobAkUSum7FUP0pj5QGoo/8
         q97pUfK7BZ4E1QgE4/WH4axRkc2WK1fSO5yKYoet+fzVxfx93As7nA0IDrsex22+9r5u
         Uy5Fcto4Q4dxugJZYUUQeevzbFd9oY+7AqdtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3aLAqx1UmJhgGtzBHcHb9QyFZFPiOEXRjvNmq6X8fw=;
        b=7Hktr6AIxMQn7JgAFbOtEYK3xzuWwAx1xXg2EyiEMcHCuGrpi7Oz8a4ib0wFySJ2Pk
         V/tvxG1Ft6KxyWZMVEViTsJe5RUOmSm2c72deCC9m/nGAv4nhTs3LmEvNWyA1spx9cRT
         /MqxmRhfdeTtPgkDZyFbqlSDbeG8V8rIE/SBPv0pnS2PdMTVf5J5XmElPM6UGJRIW6kS
         pXoWMHaQUh0AsPXlp1D1IESt+XO/WDBQRDXzyquzG7g0Zr2qlHObbOeF7NmnVgoSvpgQ
         /ODGJ7NThscT0MqtFmBcWzqRXE6VxBS1BvbjIu+Ym7aSd5sfXroKjGh11YHUoeNTs4DI
         isOw==
X-Gm-Message-State: ACrzQf07T/a1qyBMYssAr+f86JETu3OGJTmt2XQYCPx+Uz10hpeWsU9M
        tgfh53+sbiEqU74S+GtxWr6aVw==
X-Google-Smtp-Source: AMsMyM5UOg1JMiWz7k0aqd85PLsiuGf7bdy7MmYF5Sio47TrLWMyrhddQLp6ZcBiOyI1/H6/ItlKOQ==
X-Received: by 2002:a05:6402:414f:b0:456:c2c1:23ec with SMTP id x15-20020a056402414f00b00456c2c123ecmr41613747eda.420.1666785994930;
        Wed, 26 Oct 2022 05:06:34 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:b47a:bedd:2941:1e3f])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090668d200b0079e11b8e891sm2892546ejr.125.2022.10.26.05.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 05:06:34 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 26 Oct 2022 14:06:07 +0200
Subject: [PATCH v3 2/7] media: uvcvideo: Do power management granularly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-powersave-v3-2-c47856d8757e@chromium.org>
References: <20220920-resend-powersave-v3-0-c47856d8757e@chromium.org>
In-Reply-To: <20220920-resend-powersave-v3-0-c47856d8757e@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Max Staudt <mstaudt@chromium.org>,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10240; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=9JC+xKdhqfQ07Aja2WDiXvrtLcLtkT6rTXo67NjWgLI=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjWSK+e2m3BA+oc+r9uya55vadcNyhns4KU+wqqUKm
 jTbsZ/iJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY1kivgAKCRDRN9E+zzrEiJQ0D/
 93ifgleBrzC1Hwpo7lXAsu1p/qdaCm8+jyMElrtHrqmJsTPwKibAhbgC6C7tKcz0h8sL9CidluN2EZ
 wdS/fcl/uusZ0I9xmRvqN7JziD4opT9aNtsNj3/tNb5V0qULQtUpCMUFb/5D2T3iiP6a2QwKOucIfV
 5wuUjJo7MVOjsjKOifljGvGeKAWPVZEIMjbFLtqNePTXQJrS9auVLQXp8CseFBvT93oRQq+xw0oMfR
 958OFHRRGJ6IGsURsJGZzge4F9BXgqgwDpptE19odLYycPVzC0/Sp5gGzvwFS03tBGQnW0gCNMQ54c
 xaHqAwp63p7T33kN+07YpzAUfeFEFaQy2U4hiULs7qThA60OtEIND7u1zDLVKauC9pQrHjZyZgix9C
 Gr6PnuKaAMra6AFxA/+07iZQkvv5TWg26w6CvqH2ZrW/FhUtBGP0aKDdHUyntH35H24ITEbRNEH0D7
 38S/XIqgWSKOlqInU/R299NfBMEb/N4QB36wBp4d8vYoc8YuLvTlHm9eA0PPVarUp6HSc88EWVQWfS
 zkYYL6tnWGs1a+LTlx82RZQ/fu9V1y6jw3ovUjLaYXFf5y514hPLWiT+EmzpI3S9qVatY84VafZHIG
 AfpkpE6cG3CC8D3qR73pWwLgBYGPBVBILSsYIL79BSLVAYz/SixM5P8oJtnw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

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
b4 0.11.0-dev-d93f8
