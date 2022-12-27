Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2793657150
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 00:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiL0XjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 18:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiL0Xik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 18:38:40 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8CEEE3C;
        Tue, 27 Dec 2022 15:34:14 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 60E3C2D9;
        Wed, 28 Dec 2022 00:34:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672184047;
        bh=Z3U0NTl94DkXk19JV6N3/Hc2n/WuJ6GXhzwGIIf0YIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dIu88hTwW3ZXJZg75zr8dXrdecfB8wmwhE9gN8wgG35frpG6iYDIlxS8JiBcCGZre
         ZHecMXNoqyHKt5dl9m5ncxZ8tU6jvIK3h48tDBF9seg6r9fShOvF0PhaXjyfbvZY2y
         Vj59FSQTQvFCa5sySXy64ipay0j85lO7nLGUsePA=
Date:   Wed, 28 Dec 2022 01:34:03 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, Max Staudt <mstaudt@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v5 2/2] media: uvcvideo: Do power management granularly
Message-ID: <Y6uA6yKo1jjSlWvU@pendragon.ideasonboard.com>
References: <20220920-resend-powersave-v5-0-692e6df6c1e2@chromium.org>
 <20220920-resend-powersave-v5-2-692e6df6c1e2@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-powersave-v5-2-692e6df6c1e2@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Tue, Dec 06, 2022 at 03:06:56PM +0100, Ricardo Ribalda wrote:
> Instead of suspending/resume the USB device at open()/close(), do it
> when the device is actually used.
> 
> This way we can reduce the power consumption when a service is holding
> the video device and leaving it in an idle state.
> 
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Reviewed-by: Max Staudt <mstaudt@chromium.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 198 +++++++++++++++++++++++++++++++--------
>  1 file changed, 161 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 1389a87b8ae1..2e8f78bd1e4e 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -25,6 +25,46 @@
>  
>  #include "uvcvideo.h"
>  
> +/* ------------------------------------------------------------------------
> + * UVC power management
> + */
> +
> +static int uvc_pm_get(struct uvc_streaming *stream)
> +{
> +	int ret;
> +
> +	ret = usb_autopm_get_interface(stream->dev->intf);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&stream->dev->lock);
> +	if (!stream->dev->users)
> +		ret = uvc_status_start(stream->dev, GFP_KERNEL);
> +	if (!ret)
> +		stream->dev->users++;
> +	mutex_unlock(&stream->dev->lock);
> +
> +	if (ret)
> +		usb_autopm_put_interface(stream->dev->intf);
> +
> +	return ret;
> +}
> +
> +static void uvc_pm_put(struct uvc_streaming *stream)
> +{
> +	mutex_lock(&stream->dev->lock);
> +	if (WARN_ON(!stream->dev->users)) {
> +		mutex_unlock(&stream->dev->lock);
> +		return;
> +	}
> +	stream->dev->users--;
> +	if (!stream->dev->users)
> +		uvc_status_stop(stream->dev);
> +	mutex_unlock(&stream->dev->lock);
> +
> +	usb_autopm_put_interface(stream->dev->intf);
> +}
> +
>  /* ------------------------------------------------------------------------
>   * UVC ioctls
>   */
> @@ -249,6 +289,9 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
>  	 * developers test their webcams with the Linux driver as well as with
>  	 * the Windows driver).
>  	 */
> +	ret = uvc_pm_get(stream);
> +	if (ret)
> +		return ret;
>  	mutex_lock(&stream->mutex);
>  	if (stream->dev->quirks & UVC_QUIRK_PROBE_EXTRAFIELDS)
>  		probe->dwMaxVideoFrameSize =
> @@ -257,6 +300,7 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
>  	/* Probe the device. */
>  	ret = uvc_probe_video(stream, probe);
>  	mutex_unlock(&stream->mutex);
> +	uvc_pm_put(stream);

Sprinkling get/put calls around ioctls individually is error-prone. For
instance, I think you're missing uvc_xu_ctrl_query() already, and
possibly other ioctls. It would be better to wrap the ioctl calls only
level up, essentially doing something like

@@ -1432,6 +1490,7 @@ static long uvc_v4l2_compat_ioctl32(struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
 	struct uvc_fh *handle = file->private_data;
+	struct uvc_streaming *stream = handle->stream;
 	union {
 		struct uvc_xu_control_mapping xmap;
 		struct uvc_xu_control_query xqry;
@@ -1439,36 +1498,41 @@ static long uvc_v4l2_compat_ioctl32(struct file *file,
 	void __user *up = compat_ptr(arg);
 	long ret;

+	ret = uvc_pm_get(stream);
+	if (ret)
+		return ret;
+
 	switch (cmd) {
 	case UVCIOC_CTRL_MAP32:
 		ret = uvc_v4l2_get_xu_mapping(&karg.xmap, up);
 		if (ret)
-			return ret;
+			break;
 		ret = uvc_ioctl_ctrl_map(handle->chain, &karg.xmap);
 		if (ret)
-			return ret;
+			break;
 		ret = uvc_v4l2_put_xu_mapping(&karg.xmap, up);
 		if (ret)
-			return ret;
-
+			break;
 		break;

 	case UVCIOC_CTRL_QUERY32:
 		ret = uvc_v4l2_get_xu_query(&karg.xqry, up);
 		if (ret)
-			return ret;
+			break;
 		ret = uvc_xu_ctrl_query(handle->chain, &karg.xqry);
 		if (ret)
-			return ret;
+			break;
 		ret = uvc_v4l2_put_xu_query(&karg.xqry, up);
 		if (ret)
-			return ret;
+			break;
 		break;

 	default:
-		return -ENOIOCTLCMD;
+		ret = -ENOIOCTLCMD;
+		break;
 	}

+	uvc_pm_put(stream);
 	return ret;
 }
 #endif
@@ -1558,7 +1622,7 @@ const struct v4l2_file_operations uvc_fops = {
 	.owner		= THIS_MODULE,
 	.open		= uvc_v4l2_open,
 	.release	= uvc_v4l2_release,
-	.unlocked_ioctl	= video_ioctl2,
+	.unlocked_ioctl	= uvc_v4l2_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl32	= uvc_v4l2_compat_ioctl32,
 #endif

This means, however, that we'll call uvc_pm_get() and uvc_pm_put()
around more ioctls. As we're using usb_autopm_put_interface(), I assume
that the USB core delays device suspend, so it's not much of an issue,
we won't actually suspend the device synchronously every time, and if
userspace issues ioctls with short intervals (less than 2s with the
default kernel configuration), it should be fine.

(Side note: I've looked at the USB autosuspend implementation, and it
seems to use pm_runtime_put_sync(), with manual autosuspend handling in
the RPM suspend handler. I got scared and ran away without making sure
it actually has a low cost as stated above :-S)

However, I'm more bother by the fact that the status endpoint polling is
started and stopped synchronously for each ioctl call, for two reasons.
One of them is the overhead of doing so for each ioctl call. It would be
made worse by wrapping the top-level ioctl handlers with get/put calls,
but it's already an issue without that.

The other reason is that I think it introduces a regression. UVC devices
can implement asynchronous controls, to report the new value of a
control at a later time. This is used for controls that take time to be
set, typically all controls related to physical motors (pan/tilt for
instance). The uvcvideo driver sends control change events to userspace
in that case. With this patch, and with commit "media: uvcvideo: Only
create input devs if hw supports it" merged, if an aplication opens a
video device but doesn't start streaming, the status URB will be killed
as soon as a S_CTRL ioctl returns, which will prevent asynchronous event
reporting from working.

It seems that one way to fix this would be to start/stop the status
endpoint polling in the resume/suspend handlers. I haven't investigated
though. I may give it a try, so please ping me on IRC before you resume
work on this. Feel free to comment by e-mail on the above though, and
tell me where I got it wrong :-)

>  	if (ret < 0)
>  		return ret;
>  
> @@ -408,8 +452,8 @@ static int uvc_v4l2_get_streamparm(struct uvc_streaming *stream,
>  	return 0;
>  }
>  
> -static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
> -		struct v4l2_streamparm *parm)
> +static int __uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
> +				     struct v4l2_streamparm *parm)
>  {
>  	struct uvc_streaming_control probe;
>  	struct v4l2_fract timeperframe;
> @@ -419,9 +463,6 @@ static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
>  	unsigned int i;
>  	int ret;
>  
> -	if (parm->type != stream->type)
> -		return -EINVAL;
> -
>  	if (parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
>  		timeperframe = parm->parm.capture.timeperframe;
>  	else
> @@ -495,6 +536,25 @@ static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
>  	return 0;
>  }
>  
> +static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
> +				   struct v4l2_streamparm *parm)
> +{
> +	int ret;
> +
> +	if (parm->type != stream->type)
> +		return -EINVAL;
> +
> +	ret = uvc_pm_get(stream);
> +	if (ret)
> +		return ret;
> +
> +	ret = __uvc_v4l2_set_streamparm(stream, parm);
> +
> +	uvc_pm_put(stream);
> +
> +	return ret;
> +}
> +
>  /* ------------------------------------------------------------------------
>   * Privilege management
>   */
> @@ -559,36 +619,29 @@ static int uvc_v4l2_open(struct file *file)
>  {
>  	struct uvc_streaming *stream;
>  	struct uvc_fh *handle;
> -	int ret = 0;
>  
>  	stream = video_drvdata(file);
>  	uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
>  
> -	ret = usb_autopm_get_interface(stream->dev->intf);
> -	if (ret < 0)
> -		return ret;
> -
>  	/* Create the device handle. */
>  	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> -	if (handle == NULL) {
> -		usb_autopm_put_interface(stream->dev->intf);
> +	if (!handle)
>  		return -ENOMEM;
> -	}
>  
> -	mutex_lock(&stream->dev->lock);
> -	if (stream->dev->users == 0) {
> -		ret = uvc_status_start(stream->dev, GFP_KERNEL);
> -		if (ret < 0) {
> -			mutex_unlock(&stream->dev->lock);
> -			usb_autopm_put_interface(stream->dev->intf);
> +	/*
> +	 * If the uvc evdev exists we cannot suspend when the device

s/uvc evdev/UVC input device/

> +	 * is idle. Otherwise we will miss button actions.
> +	 */
> +	if (stream->dev->input) {
> +		int ret;
> +
> +		ret = uvc_pm_get(stream);
> +		if (ret) {
>  			kfree(handle);
>  			return ret;
>  		}
>  	}
>  
> -	stream->dev->users++;
> -	mutex_unlock(&stream->dev->lock);
> -
>  	v4l2_fh_init(&handle->vfh, &stream->vdev);
>  	v4l2_fh_add(&handle->vfh);
>  	handle->chain = stream->chain;
> @@ -610,6 +663,16 @@ static int uvc_v4l2_release(struct file *file)
>  	if (uvc_has_privileges(handle))
>  		uvc_queue_release(&stream->queue);
>  
> +	/*
> +	 * Release cannot happen at the same time as streamon/streamoff
> +	 * no need to take the stream->mutex.

There seems to be something missing here, maybe

	 * Release cannot happen at the same time as streamon/streamoff, so
	 * there is no need to take the stream->mutex.

> +	 */
> +	if (handle->is_streaming)
> +		uvc_pm_put(stream);
> +
> +	if (stream->dev->input)
> +		uvc_pm_put(stream);
> +
>  	/* Release the file handle. */
>  	uvc_dismiss_privileges(handle);
>  	v4l2_fh_del(&handle->vfh);
> @@ -617,12 +680,6 @@ static int uvc_v4l2_release(struct file *file)
>  	kfree(handle);
>  	file->private_data = NULL;
>  
> -	mutex_lock(&stream->dev->lock);
> -	if (--stream->dev->users == 0)
> -		uvc_status_stop(stream->dev);
> -	mutex_unlock(&stream->dev->lock);
> -
> -	usb_autopm_put_interface(stream->dev->intf);
>  	return 0;
>  }
>  
> @@ -849,9 +906,17 @@ static int uvc_ioctl_streamon(struct file *file, void *fh,
>  
>  	if (handle->is_streaming)
>  		goto unlock;
> +
> +	ret = uvc_pm_get(stream);
> +	if (ret)
> +		goto unlock;
> +
>  	ret = uvc_queue_streamon(&stream->queue, type);
>  	handle->is_streaming = !ret;
>  
> +	if (!handle->is_streaming)
> +		uvc_pm_put(stream);
> +
>  unlock:
>  	mutex_unlock(&stream->mutex);
>  
> @@ -875,6 +940,9 @@ static int uvc_ioctl_streamoff(struct file *file, void *fh,
>  	ret = uvc_queue_streamoff(&stream->queue, type);
>  	handle->is_streaming = !!ret;
>  
> +	if (!handle->is_streaming)
> +		uvc_pm_put(stream);
> +
>  unlock:
>  	mutex_unlock(&stream->mutex);
>  
> @@ -928,6 +996,7 @@ static int uvc_ioctl_g_input(struct file *file, void *fh, unsigned int *input)
>  {
>  	struct uvc_fh *handle = fh;
>  	struct uvc_video_chain *chain = handle->chain;
> +	struct uvc_streaming *stream = handle->stream;
>  	u8 *buf;
>  	int ret;
>  
> @@ -941,9 +1010,16 @@ static int uvc_ioctl_g_input(struct file *file, void *fh, unsigned int *input)
>  	if (!buf)
>  		return -ENOMEM;
>  
> +	ret = uvc_pm_get(stream);
> +	if (ret) {
> +		kfree(buf);
> +		return ret;
> +	}
> +
>  	ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR, chain->selector->id,
>  			     chain->dev->intfnum,  UVC_SU_INPUT_SELECT_CONTROL,
>  			     buf, 1);
> +	uvc_pm_put(stream);
>  	if (!ret)
>  		*input = *buf - 1;
>  
> @@ -956,6 +1032,7 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
>  {
>  	struct uvc_fh *handle = fh;
>  	struct uvc_video_chain *chain = handle->chain;
> +	struct uvc_streaming *stream = handle->stream;
>  	u8 *buf;
>  	int ret;
>  
> @@ -977,10 +1054,17 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
>  	if (!buf)
>  		return -ENOMEM;
>  
> +	ret = uvc_pm_get(stream);
> +	if (ret) {
> +		kfree(buf);
> +		return ret;
> +	}
> +
>  	*buf = input + 1;
>  	ret = uvc_query_ctrl(chain->dev, UVC_SET_CUR, chain->selector->id,
>  			     chain->dev->intfnum, UVC_SU_INPUT_SELECT_CONTROL,
>  			     buf, 1);
> +	uvc_pm_put(stream);
>  	kfree(buf);
>  
>  	return ret;
> @@ -991,8 +1075,15 @@ static int uvc_ioctl_queryctrl(struct file *file, void *fh,
>  {
>  	struct uvc_fh *handle = fh;
>  	struct uvc_video_chain *chain = handle->chain;
> +	struct uvc_streaming *stream = handle->stream;
> +	int ret;
>  
> -	return uvc_query_v4l2_ctrl(chain, qc);
> +	ret = uvc_pm_get(stream);
> +	if (ret)
> +		return ret;
> +	ret = uvc_query_v4l2_ctrl(chain, qc);
> +	uvc_pm_put(stream);
> +	return ret;
>  }
>  
>  static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
> @@ -1000,10 +1091,15 @@ static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
>  {
>  	struct uvc_fh *handle = fh;
>  	struct uvc_video_chain *chain = handle->chain;
> +	struct uvc_streaming *stream = handle->stream;
>  	struct v4l2_queryctrl qc = { qec->id };
>  	int ret;
>  
> +	ret = uvc_pm_get(stream);
> +	if (ret)
> +		return ret;
>  	ret = uvc_query_v4l2_ctrl(chain, &qc);
> +	uvc_pm_put(stream);
>  	if (ret)
>  		return ret;
>  
> @@ -1049,6 +1145,7 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
>  {
>  	struct uvc_fh *handle = fh;
>  	struct uvc_video_chain *chain = handle->chain;
> +	struct uvc_streaming *stream = handle->stream;
>  	struct v4l2_ext_control *ctrl = ctrls->controls;
>  	unsigned int i;
>  	int ret;
> @@ -1073,22 +1170,30 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
>  		return 0;
>  	}
>  
> +	ret = uvc_pm_get(stream);
> +	if (ret)
> +		return ret;
>  	ret = uvc_ctrl_begin(chain);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		uvc_pm_put(stream);
>  		return ret;
> +	}
>  
>  	for (i = 0; i < ctrls->count; ++ctrl, ++i) {
>  		ret = uvc_ctrl_get(chain, ctrl);
>  		if (ret < 0) {
>  			uvc_ctrl_rollback(handle);
>  			ctrls->error_idx = i;
> -			return ret;
> +			goto done;
>  		}
>  	}
>  
>  	ctrls->error_idx = 0;
>  
> -	return uvc_ctrl_rollback(handle);
> +	ret = uvc_ctrl_rollback(handle);
> +done:
> +	uvc_pm_put(stream);
> +	return ret;
>  }
>  
>  static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
> @@ -1097,6 +1202,7 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
>  {
>  	struct v4l2_ext_control *ctrl = ctrls->controls;
>  	struct uvc_video_chain *chain = handle->chain;
> +	struct uvc_streaming *stream = handle->stream;
>  	unsigned int i;
>  	int ret;
>  
> @@ -1104,9 +1210,15 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = uvc_pm_get(stream);
> +	if (ret)
> +		return ret;
> +
>  	ret = uvc_ctrl_begin(chain);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		uvc_pm_put(stream);
>  		return ret;
> +	}
>  
>  	for (i = 0; i < ctrls->count; ++ctrl, ++i) {
>  		ret = uvc_ctrl_set(handle, ctrl);
> @@ -1114,16 +1226,20 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
>  			uvc_ctrl_rollback(handle);
>  			ctrls->error_idx = ioctl == VIDIOC_S_EXT_CTRLS ?
>  						    ctrls->count : i;
> -			return ret;
> +			goto done;
>  		}
>  	}
>  
>  	ctrls->error_idx = 0;
>  
>  	if (ioctl == VIDIOC_S_EXT_CTRLS)
> -		return uvc_ctrl_commit(handle, ctrls);
> +		ret = uvc_ctrl_commit(handle, ctrls);
>  	else
> -		return uvc_ctrl_rollback(handle);
> +		ret = uvc_ctrl_rollback(handle);
> +
> +done:
> +	uvc_pm_put(stream);
> +	return ret;
>  }
>  
>  static int uvc_ioctl_s_ext_ctrls(struct file *file, void *fh,
> @@ -1147,8 +1263,16 @@ static int uvc_ioctl_querymenu(struct file *file, void *fh,
>  {
>  	struct uvc_fh *handle = fh;
>  	struct uvc_video_chain *chain = handle->chain;
> +	struct uvc_streaming *stream = handle->stream;
> +	int ret;
>  
> -	return uvc_query_v4l2_menu(chain, qm);
> +	ret = uvc_pm_get(stream);
> +	if (ret)
> +		return ret;
> +	ret = uvc_query_v4l2_menu(chain, qm);
> +	uvc_pm_put(stream);
> +
> +	return ret;
>  }
>  
>  static int uvc_ioctl_g_selection(struct file *file, void *fh,

-- 
Regards,

Laurent Pinchart
