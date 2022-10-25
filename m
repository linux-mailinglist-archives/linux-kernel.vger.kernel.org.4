Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7859160CCFF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiJYNHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiJYNHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:07:42 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2463C26AFA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:07:39 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 63so588794iov.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q07aaT4SHNhMOhTcGZ5ftUmdt3BsIAl6z31UNPVE/2Y=;
        b=lnjbAhuyl3KaKOkC2pBySk8MM3gx05Geuv3xQyOT3N3QUJPICGscyYLKvM1LaCUOSK
         /rsoIEDXsI0pMv1oJvoWf7o09WwJmELbdnStnrfrdPh2ywW3oEzYlbkIyUSF1tRXNB8T
         N46phz2z8bnyO+K7EpbHvR+yHQFH1wDMkL+Do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q07aaT4SHNhMOhTcGZ5ftUmdt3BsIAl6z31UNPVE/2Y=;
        b=7xUA5mBdRbL7AmlbYOni0iPqFCa94D1OX3H7Xxv/gZ11vsF+Z/LGwGA9wQAJuEo6a/
         GsdzfxVHIn/q0tbI6UVc3DBOysswciKSOZbDXHwOIcRyH13gNdgUztBSAAjQfjL5hoAw
         HlOtxCuvI3vCfj2t+3mO3pQJ/YjZg3C4itw92T5i6tYd/V+iyPB1a3Z5RpPCI2uhbWGm
         QSZzhufYKpr7BQn7IoZtsB1q1JXvvlyOwHc07WANQ20YcXCo9JZUxKe78y/CP7vHyAcn
         kiZbRYwn34OfG0ZP9asuKRWBIZcCUQUXMkBi3yShW2s9M2QqayYig7Wpt/Nm9B6kf3zy
         8GUA==
X-Gm-Message-State: ACrzQf0A2/bjN+bFiizokuL6FySxLuMU84g2E+asHfWh6QWCx/xcje1L
        88XulAQffmttMFKsxhcHc4AIdSs3kSojMkM9
X-Google-Smtp-Source: AMsMyM5q4mSTsYhGWUqJgDUuMA8iKyQr+o+HV90XCwarI7Zi863WV9tZGGbHGpoFxfj9/7eFUMzKig==
X-Received: by 2002:a05:6638:e8a:b0:374:f6c5:cff6 with SMTP id p10-20020a0566380e8a00b00374f6c5cff6mr4570923jas.187.1666703258114;
        Tue, 25 Oct 2022 06:07:38 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id a26-20020a02735a000000b00374294947e0sm891278jae.7.2022.10.25.06.07.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 06:07:37 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id q18so6722174ils.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:07:36 -0700 (PDT)
X-Received: by 2002:a92:c547:0:b0:2fa:d5f4:e9ed with SMTP id
 a7-20020a92c547000000b002fad5f4e9edmr23073195ilj.243.1666703256467; Tue, 25
 Oct 2022 06:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220920-resend-powersave-v1-0-123aa2ba3836@chromium.org>
 <20220920-resend-powersave-v1-3-123aa2ba3836@chromium.org>
 <Y1facEGMo+N1v0RU@pendragon.ideasonboard.com> <CANiDSCv3WPH+BYgWEONQK2AsVgEdSvXE6_5JSXRrYVa0j=cBNg@mail.gmail.com>
In-Reply-To: <CANiDSCv3WPH+BYgWEONQK2AsVgEdSvXE6_5JSXRrYVa0j=cBNg@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 25 Oct 2022 15:07:25 +0200
X-Gmail-Original-Message-ID: <CANiDSCs-t635BHEeZQs+3F0CjvyJ9zYc2vyyqJgM16CcJe3QTA@mail.gmail.com>
Message-ID: <CANiDSCs-t635BHEeZQs+3F0CjvyJ9zYc2vyyqJgM16CcJe3QTA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] media: uvcvideo: Do power management granularly
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again

On Tue, 25 Oct 2022 at 14:55, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Hi Laurent
>
> Thanks for the review!
>
> On Tue, 25 Oct 2022 at 14:46, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > Hi Ricardo,
> >
> > Thank you for the patch.
> >
> > On Tue, Sep 20, 2022 at 04:09:52PM +0200, Ricardo Ribalda wrote:
> > > Instead of suspending/resume the USB device at open()/close(), do it
> > > when the device is actually used.
> > >
> > > This way we can reduce the power consumption when a service is holding
> > > the video device and leaving it in an idle state.
> > >
> > > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > > index 8d5002543e2c..b9642afabd9b 100644
> > > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > > @@ -25,6 +25,46 @@
> > >
> > >  #include "uvcvideo.h"
> > >
> > > +/* ------------------------------------------------------------------------
> > > + * UVC power management
> > > + */
> > > +
> > > +static int uvc_pm_get(struct uvc_streaming *stream)
> > > +{
> > > +     int ret = 0;
> >
> > No need to initialize ret to 0.
> >
> > > +
> > > +     ret = usb_autopm_get_interface(stream->dev->intf);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     mutex_lock(&stream->dev->lock);
> > > +     if (!stream->dev->users)
> > > +             ret = uvc_status_start(stream->dev, GFP_KERNEL);
> >
> > For devices that don't have a status endpoint, we will end up calling
> > uvc_status_start() and uvc_status_stop() around most ioctl calls (all
> > call sites of uvc_pm_get() and uvc_pm_put() below). uvc_status_start()
> > and uvc_status_stop() are no-op in that case, but conceptually I don't
> > think that's very nice. Could we instead keep the status start/stop
> > calls to open()/release() ?
>
>
> I do not think that we can call uvc_status_start without calling
> usb_autopm_get_interface()
>
> We could add a flag on the device, and do something like:
>
> if (!stream->dev->users && stream->dev->has_ststatus_enpoint)
>             ret = uvc_status_start(stream->dev, GFP_KERNEL);
>
> But I am not sure what is cleaner...
>

with the mentioned flag, we could make the locking a bit simpler on resume/start

Let me prepare something

Thanks!


>
> >
> > If you don't mind, I'll give this a try and post a new version of the
> > patch, that should be faster than going through another review round.
> >
> > > +     if (!ret)
> > > +             stream->dev->users++;
> > > +     mutex_unlock(&stream->dev->lock);
> > > +
> > > +     if (ret)
> > > +             usb_autopm_put_interface(stream->dev->intf);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static void uvc_pm_put(struct uvc_streaming *stream)
> > > +{
> > > +     mutex_lock(&stream->dev->lock);
> > > +     if (WARN_ON(!stream->dev->users)) {
> > > +             mutex_unlock(&stream->dev->lock);
> > > +             return;
> > > +     }
> > > +     stream->dev->users--;
> > > +     if (!stream->dev->users)
> > > +             uvc_status_stop(stream->dev);
> > > +     mutex_unlock(&stream->dev->lock);
> > > +
> > > +     usb_autopm_put_interface(stream->dev->intf);
> > > +}
> > > +
> > >  /* ------------------------------------------------------------------------
> > >   * UVC ioctls
> > >   */
> > > @@ -249,6 +289,9 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
> > >        * developers test their webcams with the Linux driver as well as with
> > >        * the Windows driver).
> > >        */
> > > +     ret = uvc_pm_get(stream);
> > > +     if (ret)
> > > +             return ret;
> > >       mutex_lock(&stream->mutex);
> > >       if (stream->dev->quirks & UVC_QUIRK_PROBE_EXTRAFIELDS)
> > >               probe->dwMaxVideoFrameSize =
> > > @@ -257,6 +300,7 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
> > >       /* Probe the device. */
> > >       ret = uvc_probe_video(stream, probe);
> > >       mutex_unlock(&stream->mutex);
> > > +     uvc_pm_put(stream);
> > >       if (ret < 0)
> > >               return ret;
> > >
> > > @@ -468,7 +512,13 @@ static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
> > >       }
> > >
> > >       /* Probe the device with the new settings. */
> > > +     ret = uvc_pm_get(stream);
> > > +     if (ret) {
> > > +             mutex_unlock(&stream->mutex);
> > > +             return ret;
> > > +     }
> > >       ret = uvc_probe_video(stream, &probe);
> > > +     uvc_pm_put(stream);
> > >       if (ret < 0) {
> > >               mutex_unlock(&stream->mutex);
> > >               return ret;
> > > @@ -559,36 +609,29 @@ static int uvc_v4l2_open(struct file *file)
> > >  {
> > >       struct uvc_streaming *stream;
> > >       struct uvc_fh *handle;
> > > -     int ret = 0;
> > >
> > >       stream = video_drvdata(file);
> > >       uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
> > >
> > > -     ret = usb_autopm_get_interface(stream->dev->intf);
> > > -     if (ret < 0)
> > > -             return ret;
> > > -
> > >       /* Create the device handle. */
> > >       handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> > > -     if (handle == NULL) {
> > > -             usb_autopm_put_interface(stream->dev->intf);
> > > +     if (!handle)
> > >               return -ENOMEM;
> > > -     }
> > >
> > > -     mutex_lock(&stream->dev->lock);
> > > -     if (stream->dev->users == 0) {
> > > -             ret = uvc_status_start(stream->dev, GFP_KERNEL);
> > > -             if (ret < 0) {
> > > -                     mutex_unlock(&stream->dev->lock);
> > > -                     usb_autopm_put_interface(stream->dev->intf);
> > > +     /*
> > > +      * If the uvc evdev exists we cannot suspend when the device
> > > +      * is idle. Otherwise we will miss button actions.
> > > +      */
> > > +     if (stream->dev->input) {
> > > +             int ret;
> > > +
> > > +             ret = uvc_pm_get(stream);
> > > +             if (ret) {
> > >                       kfree(handle);
> > >                       return ret;
> > >               }
> > >       }
> > >
> > > -     stream->dev->users++;
> > > -     mutex_unlock(&stream->dev->lock);
> > > -
> > >       v4l2_fh_init(&handle->vfh, &stream->vdev);
> > >       v4l2_fh_add(&handle->vfh);
> > >       handle->chain = stream->chain;
> > > @@ -610,6 +653,12 @@ static int uvc_v4l2_release(struct file *file)
> > >       if (uvc_has_privileges(handle))
> > >               uvc_queue_release(&stream->queue);
> > >
> > > +     if (handle->is_streaming)
> > > +             uvc_pm_put(stream);
> > > +
> > > +     if (stream->dev->input)
> > > +             uvc_pm_put(stream);
> > > +
> > >       /* Release the file handle. */
> > >       uvc_dismiss_privileges(handle);
> > >       v4l2_fh_del(&handle->vfh);
> > > @@ -617,12 +666,6 @@ static int uvc_v4l2_release(struct file *file)
> > >       kfree(handle);
> > >       file->private_data = NULL;
> > >
> > > -     mutex_lock(&stream->dev->lock);
> > > -     if (--stream->dev->users == 0)
> > > -             uvc_status_stop(stream->dev);
> > > -     mutex_unlock(&stream->dev->lock);
> > > -
> > > -     usb_autopm_put_interface(stream->dev->intf);
> > >       return 0;
> > >  }
> > >
> > > @@ -849,9 +892,17 @@ static int uvc_ioctl_streamon(struct file *file, void *fh,
> > >
> > >       if (handle->is_streaming)
> > >               goto unlock;
> > > +
> > > +     ret = uvc_pm_get(stream);
> > > +     if (ret)
> > > +             goto unlock;
> > > +
> > >       ret = uvc_queue_streamon(&stream->queue, type);
> > >       handle->is_streaming = !ret;
> > >
> > > +     if (!handle->is_streaming)
> > > +             uvc_pm_put(stream);
> > > +
> > >  unlock:
> > >       mutex_unlock(&stream->mutex);
> > >
> > > @@ -875,6 +926,9 @@ static int uvc_ioctl_streamoff(struct file *file, void *fh,
> > >       ret = uvc_queue_streamoff(&stream->queue, type);
> > >       handle->is_streaming = !!ret;
> > >
> > > +     if (!handle->is_streaming)
> > > +             uvc_pm_put(stream);
> > > +
> > >  unlock:
> > >       mutex_unlock(&stream->mutex);
> > >
> > > @@ -928,6 +982,7 @@ static int uvc_ioctl_g_input(struct file *file, void *fh, unsigned int *input)
> > >  {
> > >       struct uvc_fh *handle = fh;
> > >       struct uvc_video_chain *chain = handle->chain;
> > > +     struct uvc_streaming *stream = handle->stream;
> > >       u8 *buf;
> > >       int ret;
> > >
> > > @@ -941,9 +996,16 @@ static int uvc_ioctl_g_input(struct file *file, void *fh, unsigned int *input)
> > >       if (!buf)
> > >               return -ENOMEM;
> > >
> > > +     ret = uvc_pm_get(stream);
> > > +     if (ret) {
> > > +             kfree(buf);
> > > +             return ret;
> > > +     }
> > > +
> > >       ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR, chain->selector->id,
> > >                            chain->dev->intfnum,  UVC_SU_INPUT_SELECT_CONTROL,
> > >                            buf, 1);
> > > +     uvc_pm_put(stream);
> > >       if (!ret)
> > >               *input = *buf - 1;
> > >
> > > @@ -956,6 +1018,7 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
> > >  {
> > >       struct uvc_fh *handle = fh;
> > >       struct uvc_video_chain *chain = handle->chain;
> > > +     struct uvc_streaming *stream = handle->stream;
> > >       u8 *buf;
> > >       int ret;
> > >
> > > @@ -977,10 +1040,17 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
> > >       if (!buf)
> > >               return -ENOMEM;
> > >
> > > +     ret = uvc_pm_get(stream);
> > > +     if (ret) {
> > > +             kfree(buf);
> > > +             return ret;
> > > +     }
> > > +
> > >       *buf = input + 1;
> > >       ret = uvc_query_ctrl(chain->dev, UVC_SET_CUR, chain->selector->id,
> > >                            chain->dev->intfnum, UVC_SU_INPUT_SELECT_CONTROL,
> > >                            buf, 1);
> > > +     uvc_pm_put(stream);
> > >       kfree(buf);
> > >
> > >       return ret;
> > > @@ -991,8 +1061,15 @@ static int uvc_ioctl_queryctrl(struct file *file, void *fh,
> > >  {
> > >       struct uvc_fh *handle = fh;
> > >       struct uvc_video_chain *chain = handle->chain;
> > > +     struct uvc_streaming *stream = handle->stream;
> > > +     int ret;
> > >
> > > -     return uvc_query_v4l2_ctrl(chain, qc);
> > > +     ret = uvc_pm_get(stream);
> > > +     if (ret)
> > > +             return ret;
> > > +     ret = uvc_query_v4l2_ctrl(chain, qc);
> > > +     uvc_pm_put(stream);
> > > +     return ret;
> > >  }
> > >
> > >  static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
> > > @@ -1000,10 +1077,15 @@ static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
> > >  {
> > >       struct uvc_fh *handle = fh;
> > >       struct uvc_video_chain *chain = handle->chain;
> > > +     struct uvc_streaming *stream = handle->stream;
> > >       struct v4l2_queryctrl qc = { qec->id };
> > >       int ret;
> > >
> > > +     ret = uvc_pm_get(stream);
> > > +     if (ret)
> > > +             return ret;
> > >       ret = uvc_query_v4l2_ctrl(chain, &qc);
> > > +     uvc_pm_put(stream);
> > >       if (ret)
> > >               return ret;
> > >
> > > @@ -1049,6 +1131,7 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
> > >  {
> > >       struct uvc_fh *handle = fh;
> > >       struct uvc_video_chain *chain = handle->chain;
> > > +     struct uvc_streaming *stream = handle->stream;
> > >       struct v4l2_ext_control *ctrl = ctrls->controls;
> > >       unsigned int i;
> > >       int ret;
> > > @@ -1073,22 +1156,30 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
> > >               return 0;
> > >       }
> > >
> > > +     ret = uvc_pm_get(stream);
> > > +     if (ret)
> > > +             return ret;
> > >       ret = uvc_ctrl_begin(chain);
> > > -     if (ret < 0)
> > > +     if (ret < 0) {
> > > +             uvc_pm_put(stream);
> > >               return ret;
> > > +     }
> > >
> > >       for (i = 0; i < ctrls->count; ++ctrl, ++i) {
> > >               ret = uvc_ctrl_get(chain, ctrl);
> > >               if (ret < 0) {
> > >                       uvc_ctrl_rollback(handle);
> > >                       ctrls->error_idx = i;
> > > -                     return ret;
> > > +                     goto done;
> > >               }
> > >       }
> > >
> > >       ctrls->error_idx = 0;
> > >
> > > -     return uvc_ctrl_rollback(handle);
> > > +     ret = uvc_ctrl_rollback(handle);
> > > +done:
> > > +     uvc_pm_put(stream);
> > > +     return ret;
> > >  }
> > >
> > >  static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
> > > @@ -1097,6 +1188,7 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
> > >  {
> > >       struct v4l2_ext_control *ctrl = ctrls->controls;
> > >       struct uvc_video_chain *chain = handle->chain;
> > > +     struct uvc_streaming *stream = handle->stream;
> > >       unsigned int i;
> > >       int ret;
> > >
> > > @@ -1104,9 +1196,15 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
> > >       if (ret < 0)
> > >               return ret;
> > >
> > > +     ret = uvc_pm_get(stream);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > >       ret = uvc_ctrl_begin(chain);
> > > -     if (ret < 0)
> > > +     if (ret < 0) {
> > > +             uvc_pm_put(stream);
> > >               return ret;
> > > +     }
> > >
> > >       for (i = 0; i < ctrls->count; ++ctrl, ++i) {
> > >               ret = uvc_ctrl_set(handle, ctrl);
> > > @@ -1114,16 +1212,20 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
> > >                       uvc_ctrl_rollback(handle);
> > >                       ctrls->error_idx = ioctl == VIDIOC_S_EXT_CTRLS ?
> > >                                                   ctrls->count : i;
> > > -                     return ret;
> > > +                     goto done;
> > >               }
> > >       }
> > >
> > >       ctrls->error_idx = 0;
> > >
> > >       if (ioctl == VIDIOC_S_EXT_CTRLS)
> > > -             return uvc_ctrl_commit(handle, ctrls);
> > > +             ret = uvc_ctrl_commit(handle, ctrls);
> > >       else
> > > -             return uvc_ctrl_rollback(handle);
> > > +             ret = uvc_ctrl_rollback(handle);
> > > +
> > > +done:
> > > +     uvc_pm_put(stream);
> > > +     return ret;
> > >  }
> > >
> > >  static int uvc_ioctl_s_ext_ctrls(struct file *file, void *fh,
> > > @@ -1147,8 +1249,16 @@ static int uvc_ioctl_querymenu(struct file *file, void *fh,
> > >  {
> > >       struct uvc_fh *handle = fh;
> > >       struct uvc_video_chain *chain = handle->chain;
> > > +     struct uvc_streaming *stream = handle->stream;
> > > +     int ret;
> > > +
> > > +     ret = uvc_pm_get(stream);
> > > +     if (ret)
> > > +             return ret;
> > > +     ret = uvc_query_v4l2_menu(chain, qm);
> > > +     uvc_pm_put(stream);
> > >
> > > -     return uvc_query_v4l2_menu(chain, qm);
> > > +     return ret;
> > >  }
> > >
> > >  static int uvc_ioctl_g_selection(struct file *file, void *fh,
> > >
> >
> > --
> > Regards,
> >
> > Laurent Pinchart
>
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda
