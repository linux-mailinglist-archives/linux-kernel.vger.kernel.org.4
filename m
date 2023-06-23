Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0750673C4C9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 01:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjFWX2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 19:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjFWX2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:28:36 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1075D26B8;
        Fri, 23 Jun 2023 16:28:28 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9B7C93F1;
        Sat, 24 Jun 2023 01:27:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687562869;
        bh=W7EGqqRFvcnTAJLtN/N66RH/J8cTPB8g7wHsfxKobjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sHAfq/yAnYw3aPZttAnvazlJovApbYbww4xQ7iGFM5jpY0FJvVQ7p1hi6eAT63AhF
         2DNUTiilSgCMMnuRMMHvnWx48dkAulRW0DjjnIlLtKjwKrA5j+JbOJa/P8jskh69HN
         5FrovwQwWNHPnP5fhM9ybuPD7zjZya8NmS+U6xKs=
Date:   Sat, 24 Jun 2023 02:28:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Benjamin Bara <bbara93@gmail.com>, benjamin.bara@skidata.com,
        jacopo.mondi@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mani@kernel.org, mchehab@kernel.org
Subject: Re: [PATCH 2/2] media: i2c: imx290: Add support for V4L2_CID_VTOTAL
Message-ID: <20230623232825.GB1669@pendragon.ideasonboard.com>
References: <CAPY8ntCx8QLX_jqtJeWzCQkApSR_+RY7jMM5pDNA7zewJa+eiA@mail.gmail.com>
 <20230609145648.1960398-1-bbara93@gmail.com>
 <CAPY8ntAZ9wumC3KeZQnWiB6AqAvc67n7+LNcj-LS26yTh15SvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPY8ntAZ9wumC3KeZQnWiB6AqAvc67n7+LNcj-LS26yTh15SvA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jun 09, 2023 at 04:41:25PM +0100, Dave Stevenson wrote:
> On Fri, 9 Jun 2023 at 15:56, Benjamin Bara <bbara93@gmail.com> wrote:
> > On Fri, 9 Jun 2023 at 16:21, Dave Stevenson <dave.stevenson@raspberrypi.com> wrote:
> > > On Fri, 9 Jun 2023 at 14:16, Benjamin Bara <bbara93@gmail.com> wrote:
> > > >
> > > > From: Benjamin Bara <benjamin.bara@skidata.com>
> > > >
> > > > The new V4L2_CID_VTOTAL control represents the VMAX register.
> > > > Implementing it simplifies calculations in user space, as it is
> > > > independent of the current mode (format height), meaning its value does
> > > > not change with format changes.
> > >
> > > I know Laurent suggested this change[1] so that (AIUI) exposure max
> > > limits are easier to compute around mode changes.
> > >
> > > I'm currently seeing this as a fair amount of boilerplate to be added
> > > to all drivers so that two controls provide effectively the same
> > > information,

Camera sensor drivers are already too complex, I think we need helpers
in the framework to handle all this. The goal is to decrease the
complexity in the drivers.

> > > and I'm not convinced it saves any significant effort in
> > > userspace. Can you (or Laurent) detail exactly what the issue is that
> > > the new control solves?
> >
> > Sure. My main problem with the current blanking controls is that it is
> > not clear what should happen in case of a format switch. I guess the
> > expected case is that the vertical blanking should stay constant, but
> > that might be implemented differently.
> > If so, this results in a change of the total frame duration. If we
> > switch to "total", a format switch would result to the same (required)
> > frame rate, as the blanking would be reduced instead. I guess this
> > represents the typical "use case" better, and clarifies implementation
> > things. Currently, it seems a little bit odd or unnecessary complicated
> > to me that I have to modify a blanking time and need to know the current
> > format to be able to achieve a certain frame rate. But maybe Laurent has
> > other issues.

My main issue with the VBLANK control is that its limits change
depending on the selected output resolution (and possibly other
parameters). This means that userspace has to query the limits every
time the sensor is configured, and have to assume that the maximum frame
duration will be affected. Both the kernel and the userspace code end up
being complex. This is especially frustrating given that most sensors
have a fixed maximum limit for the total vertical size.

> IMHO relying on any particular behaviour with regard frame duration
> over a mode change is optimistic based on my experience of sensor
> drivers. It's undocumented as to what to do, therefore there is no
> guarantee what will happen.
> 
> - Some update the ranges, and the control handler will reset the value
> to the default (whatever that is) if the current value is outside the
> valid range.
> - Some update the ranges and then call __v4l2_ctrl_s_ctrl to force the
> current value to a default chosen by the developer.
> - Some probably have other weird schemes!

I have to agree with this. Support for camera sensors in the kernel is
both good in the sense that we have lots of drivers, and abysmal in the
sense that no two drivers behave the same. OK, that's a bit of an
exageration, but there's definitely a wide range of slightly or
completely incompatible behaviours.

This is making our life very complicated in userspace, and I'm
interested in fixing this situation going forward. This means coming up
with a good infrastructure (userspace API, kernelspace API, and kernel
helpers) for new camera sensor drivers, and figuring out how existing
drivers can be moved to it. I'm not saying "if and how" as we don't have
the luxury of adding an "if" here. Any new infrastructure that would be
yet another option would be painful to support.

For this reason, I can we can define more precisely the expected
behaviour when configuring the camera sensor. I'm intentionally not
saying "changing the mode" here, as the "sensor mode" concept is
currently very ill-defined and is part of the issue. Don't get me wrong,
I don't believe we will be able to ensure that all new drivers expose
full configurability of all sensor parameters, but "selecting a mode"
isn't something that fits today's use cases when you consider link
frequencies, blanking, HDR and other interesting sensor features.

> I also see an issue in that some sensors change HTOTAL and/or
> PIXEL_RATE between modes, eg ov5647 changes both, and ov9282 changes
> PIXEL_RATE based on 8 /10 bit readout.
> If the line time (HTOTAL / PIXEL_RATE) changes between the modes, then
> userspace must recompute VBLANK/VTOTAL and EXPOSURE anyway if it
> wishes to retain the same frame rate and exposure. I don't see it
> being reasonable to expect the driver to do all that recomputation,
> and if it did then you may not end up with exactly the same result as
> before due to using units of line time. If you have to do it for some,
> then you may as well do it for all.

I agree that userspace shouldn't expect any particular parameter to be
preserved today, and shouldn't expect all parameters to be preserved
tomorrow. We may be able to define a set of rules that camera sensor
drivers must follow. If so, I expect those rules to cover only a small
subset of all possible parameter update situations, as variability in
hardware implementations won't make it possible to set everything in
stone.

I'm increasingly thinking that having to issue multiple ioctl calls to
set formats, selection rectangles and controls is one of the main
reasons why the current situation is horrible, and I may experiment with
a new API.

> > > Do we need to do the same for HBLANK as well, or do we live with an
> > > asymmetrical set of controls.
> >
> > I can add that in a v2 too, IMHO it makes sense to replace both
> > blankings with totals. So one can set HTOTAL to min and VTOTAL to the
> > required frame rate (simpler calculation now) and has the guarantee that
> > the frame rate stays constant during format switches (if the pixel rate
> > is high enough of course). I will then also adapt the doc accordingly.
> >
> > Hope this clarifies it.
> >
> > Regards,
> > Benjamin
> >
> > > Thanks
> > >   Dave
> > >
> > > [1] https://lists.libcamera.org/pipermail/libcamera-devel/2023-June/038170.html
> > >
> > > > Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> > > > ---
> > > >  drivers/media/i2c/imx290.c | 47 ++++++++++++++++++++++++++++++++++------------
> > > >  1 file changed, 35 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> > > > index 5ea25b7acc55..42938400efb0 100644
> > > > --- a/drivers/media/i2c/imx290.c
> > > > +++ b/drivers/media/i2c/imx290.c
> > > > @@ -255,6 +255,7 @@ struct imx290 {
> > > >         struct v4l2_ctrl *link_freq;
> > > >         struct v4l2_ctrl *hblank;
> > > >         struct v4l2_ctrl *vblank;
> > > > +       struct v4l2_ctrl *vtotal;
> > > >         struct v4l2_ctrl *exposure;
> > > >         struct {
> > > >                 struct v4l2_ctrl *hflip;
> > > > @@ -782,8 +783,7 @@ static void imx290_exposure_update(struct imx290 *imx290,
> > > >  {
> > > >         unsigned int exposure_max;
> > > >
> > > > -       exposure_max = imx290->vblank->val + mode->height -
> > > > -                      IMX290_EXPOSURE_OFFSET;
> > > > +       exposure_max = imx290->vtotal->val - IMX290_EXPOSURE_OFFSET;
> > > >         __v4l2_ctrl_modify_range(imx290->exposure, 1, exposure_max, 1,
> > > >                                  exposure_max);
> > > >  }
> > > > @@ -794,7 +794,7 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
> > > >                                              struct imx290, ctrls);
> > > >         const struct v4l2_mbus_framefmt *format;
> > > >         struct v4l2_subdev_state *state;
> > > > -       int ret = 0, vmax;
> > > > +       int ret = 0;
> > > >
> > > >         /*
> > > >          * Return immediately for controls that don't need to be applied to the
> > > > @@ -803,10 +803,22 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
> > > >         if (ctrl->flags & V4L2_CTRL_FLAG_READ_ONLY)
> > > >                 return 0;
> > > >
> > > > -       if (ctrl->id == V4L2_CID_VBLANK) {
> > > > -               /* Changing vblank changes the allowed range for exposure. */
> > > > +       /* Changing vtotal changes the allowed range for exposure. */
> > > > +       if (ctrl->id == V4L2_CID_VTOTAL)
> > > >                 imx290_exposure_update(imx290, imx290->current_mode);
> > > > -       }
> > > > +
> > > > +       /*
> > > > +        * vblank and vtotal depend on each other, therefore also update the
> > > > +        * other one.
> > > > +        */
> > > > +       if (ctrl->id == V4L2_CID_VBLANK &&
> > > > +           imx290->vtotal->val != ctrl->val + imx290->current_mode->height)
> > > > +               __v4l2_ctrl_s_ctrl(imx290->vtotal,
> > > > +                                  ctrl->val + imx290->current_mode->height);
> > > > +       if (ctrl->id == V4L2_CID_VTOTAL &&
> > > > +           imx290->vblank->val != ctrl->val - imx290->current_mode->height)
> > > > +               __v4l2_ctrl_s_ctrl(imx290->vblank,
> > > > +                                  ctrl->val - imx290->current_mode->height);
> > > >
> > > >         /* V4L2 controls values will be applied only when power is already up */
> > > >         if (!pm_runtime_get_if_in_use(imx290->dev))
> > > > @@ -821,9 +833,14 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
> > > >                 break;
> > > >
> > > >         case V4L2_CID_VBLANK:
> > > > -               ret = imx290_write(imx290, IMX290_VMAX,
> > > > -                                  ctrl->val + imx290->current_mode->height,
> > > > -                                  NULL);
> > > > +               /* vblank is updated by vtotal. */
> > > > +               break;
> > > > +
> > > > +       case V4L2_CID_VTOTAL:
> > > > +               ret = imx290_write(imx290, IMX290_VMAX, ctrl->val, NULL);
> > > > +               if (ret)
> > > > +                       goto err;
> > > > +
> > > >                 /*
> > > >                  * Due to the way that exposure is programmed in this sensor in
> > > >                  * relation to VMAX, we have to reprogramme it whenever VMAX is
> > > > @@ -834,9 +851,8 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
> > > >                 ctrl = imx290->exposure;
> > > >                 fallthrough;
> > > >         case V4L2_CID_EXPOSURE:
> > > > -               vmax = imx290->vblank->val + imx290->current_mode->height;
> > > >                 ret = imx290_write(imx290, IMX290_SHS1,
> > > > -                                  vmax - ctrl->val - 1, NULL);
> > > > +                                  imx290->vtotal->val - ctrl->val - 1, NULL);
> > > >                 break;
> > > >
> > > >         case V4L2_CID_TEST_PATTERN:
> > > > @@ -880,6 +896,7 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
> > > >                 break;
> > > >         }
> > > >
> > > > +err:
> > > >         pm_runtime_mark_last_busy(imx290->dev);
> > > >         pm_runtime_put_autosuspend(imx290->dev);
> > > >
> > > > @@ -911,11 +928,14 @@ static void imx290_ctrl_update(struct imx290 *imx290,
> > > >         unsigned int vblank_max = IMX290_VMAX_MAX - mode->height;
> > > >
> > > >         __v4l2_ctrl_s_ctrl(imx290->link_freq, mode->link_freq_index);
> > > > +       __v4l2_ctrl_s_ctrl(imx290->vblank, imx290->vtotal->val - mode->height);
> > > >
> > > >         __v4l2_ctrl_modify_range(imx290->hblank, hblank_min, hblank_max, 1,
> > > >                                  hblank_min);
> > > >         __v4l2_ctrl_modify_range(imx290->vblank, vblank_min, vblank_max, 1,
> > > >                                  vblank_min);
> > > > +       __v4l2_ctrl_modify_range(imx290->vtotal, mode->vmax_min,
> > > > +                                IMX290_VMAX_MAX, 1, mode->vmax_min);
> > > >  }
> > > >
> > > >  static int imx290_ctrl_init(struct imx290 *imx290)
> > > > @@ -947,7 +967,7 @@ static int imx290_ctrl_init(struct imx290 *imx290)
> > > >
> > > >         /*
> > > >          * Correct range will be determined through imx290_ctrl_update setting
> > > > -        * V4L2_CID_VBLANK.
> > > > +        * V4L2_CID_VTOTAL.
> > > >          */
> > > >         imx290->exposure = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
> > > >                                              V4L2_CID_EXPOSURE, 1, 65535, 1,
> > > > @@ -983,6 +1003,9 @@ static int imx290_ctrl_init(struct imx290 *imx290)
> > > >
> > > >         imx290->vblank = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
> > > >                                            V4L2_CID_VBLANK, 1, 1, 1, 1);
> > > > +       imx290->vtotal = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
> > > > +                                          V4L2_CID_VTOTAL, 1, IMX290_VMAX_MAX,
> > > > +                                          1, 1);
> > > >
> > > >         imx290->hflip = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
> > > >                                           V4L2_CID_HFLIP, 0, 1, 1, 0);
> > > >

-- 
Regards,

Laurent Pinchart
