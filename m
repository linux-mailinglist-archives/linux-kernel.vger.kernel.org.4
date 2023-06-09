Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB65B729EDB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241855AbjFIPmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241835AbjFIPlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:41:45 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8439C30FA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:41:43 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-789de11638fso753858241.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1686325302; x=1688917302;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cm75s2Uw0sWRXx3eS3+jU6a3nDprcdWnY2ruGVGhlAw=;
        b=IRSMjpfHk6MKepeCVaPPE0dc0EbXFdCzlUPOvlYLwvs0vKdo3owXG/imhb4WR9Veym
         9r0BoX6HXDfqi4C7r3PwgE603khbl2qU/4VVgJlasu4xv+DpVBOzqga/zcPsgYyTwOj8
         wXupZwNCIY2dAMOsng2D1mCaFPiXlZOiNQNs2iPJGvDKfM4py2gqs3Eb9Y2sf3/Kh5qu
         aLMlB025LeSsfKIm4DRqhGBqPXUfGXW/FMke+ELGxjH6u00Ecz2uKgMzi9TvXSpGSp3a
         52MNjeotwZw3Pkt9UaMhfE6LceB0qblXP66KDT2EcqykZUEwW/Qs38NVQpR8qEsb/jYg
         tcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686325302; x=1688917302;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cm75s2Uw0sWRXx3eS3+jU6a3nDprcdWnY2ruGVGhlAw=;
        b=XfTDArxkS4AHrhc4qxKwjkMeqeUYiVqPjDVOS6/5BMR7EENtdaRhA3LcmOSuQXrSJB
         0x1/JFFF//S6wsm7n/CJqdeuz8yu0mqiwZDn8cTUESLrpSnY+zBybnA6G1sFxNsExfXH
         EoRdiIG585l6hDqZz9i694r/DJXj8vxstloWnR6DVoqowIpunrjyfADqG/bkOMNAvQXh
         NBXiwKFk6T9zB5sbJa0KW6kN7apcQE2rmcUfCE0u1I3/IiNuTPak4wueTXsgDtm4tECh
         18m9RvcItuaz/C+wWSrAcljBoBEflaiRJERNFVxm10TaDEVtWg8QoUjIz8XPFbXcPkxn
         ylKg==
X-Gm-Message-State: AC+VfDzisAjxX96FEAi6614AlHkA1NY9bm3ndRWQfiz88cyMmBmj4dlL
        6nVyR+7QnDKmsQfgzywlsibo1UPp/zre7GN6PTH7CA==
X-Google-Smtp-Source: ACHHUZ7qTp49J0AQ7nkVlLJXsBafhewOGyzSufXScSLr00z+sBM0V4tT8lKmAmXfpAH7WALdLm71P1oK6dCj4cVdDvk=
X-Received: by 2002:a05:6102:303a:b0:434:3cf1:96e with SMTP id
 v26-20020a056102303a00b004343cf1096emr1433478vsa.1.1686325302542; Fri, 09 Jun
 2023 08:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAPY8ntCx8QLX_jqtJeWzCQkApSR_+RY7jMM5pDNA7zewJa+eiA@mail.gmail.com>
 <20230609145648.1960398-1-bbara93@gmail.com>
In-Reply-To: <20230609145648.1960398-1-bbara93@gmail.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 9 Jun 2023 16:41:25 +0100
Message-ID: <CAPY8ntAZ9wumC3KeZQnWiB6AqAvc67n7+LNcj-LS26yTh15SvA@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: i2c: imx290: Add support for V4L2_CID_VTOTAL
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     benjamin.bara@skidata.com, jacopo.mondi@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mani@kernel.org, mchehab@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin

On Fri, 9 Jun 2023 at 15:56, Benjamin Bara <bbara93@gmail.com> wrote:
>
> Hi Dave,
>
> thanks for the feedback!
>
> On Fri, 9 Jun 2023 at 16:21, Dave Stevenson <dave.stevenson@raspberrypi.com> wrote:
> > On Fri, 9 Jun 2023 at 14:16, Benjamin Bara <bbara93@gmail.com> wrote:
> > >
> > > From: Benjamin Bara <benjamin.bara@skidata.com>
> > >
> > > The new V4L2_CID_VTOTAL control represents the VMAX register.
> > > Implementing it simplifies calculations in user space, as it is
> > > independent of the current mode (format height), meaning its value does
> > > not change with format changes.
> >
> > I know Laurent suggested this change[1] so that (AIUI) exposure max
> > limits are easier to compute around mode changes.
> >
> > I'm currently seeing this as a fair amount of boilerplate to be added
> > to all drivers so that two controls provide effectively the same
> > information, and I'm not convinced it saves any significant effort in
> > userspace. Can you (or Laurent) detail exactly what the issue is that
> > the new control solves?
>
> Sure. My main problem with the current blanking controls is that it is
> not clear what should happen in case of a format switch. I guess the
> expected case is that the vertical blanking should stay constant, but
> that might be implemented differently.
> If so, this results in a change of the total frame duration. If we
> switch to "total", a format switch would result to the same (required)
> frame rate, as the blanking would be reduced instead. I guess this
> represents the typical "use case" better, and clarifies implementation
> things. Currently, it seems a little bit odd or unnecessary complicated
> to me that I have to modify a blanking time and need to know the current
> format to be able to achieve a certain frame rate. But maybe Laurent has
> other issues.

IMHO relying on any particular behaviour with regard frame duration
over a mode change is optimistic based on my experience of sensor
drivers. It's undocumented as to what to do, therefore there is no
guarantee what will happen.
- Some update the ranges, and the control handler will reset the value
to the default (whatever that is) if the current value is outside the
valid range.
- Some update the ranges and then call __v4l2_ctrl_s_ctrl to force the
current value to a default chosen by the developer.
- Some probably have other weird schemes!

I also see an issue in that some sensors change HTOTAL and/or
PIXEL_RATE between modes, eg ov5647 changes both, and ov9282 changes
PIXEL_RATE based on 8 /10 bit readout.
If the line time (HTOTAL / PIXEL_RATE) changes between the modes, then
userspace must recompute VBLANK/VTOTAL and EXPOSURE anyway if it
wishes to retain the same frame rate and exposure. I don't see it
being reasonable to expect the driver to do all that recomputation,
and if it did then you may not end up with exactly the same result as
before due to using units of line time. If you have to do it for some,
then you may as well do it for all.

Cheers
  Dave

> > Do we need to do the same for HBLANK as well, or do we live with an
> > asymmetrical set of controls.
>
> I can add that in a v2 too, IMHO it makes sense to replace both
> blankings with totals. So one can set HTOTAL to min and VTOTAL to the
> required frame rate (simpler calculation now) and has the guarantee that
> the frame rate stays constant during format switches (if the pixel rate
> is high enough of course). I will then also adapt the doc accordingly.
>
> Hope this clarifies it.
>
> Regards,
> Benjamin
>
> > Thanks
> >   Dave
> >
> > [1] https://lists.libcamera.org/pipermail/libcamera-devel/2023-June/038170.html
> >
> > > Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> > > ---
> > >  drivers/media/i2c/imx290.c | 47 ++++++++++++++++++++++++++++++++++------------
> > >  1 file changed, 35 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> > > index 5ea25b7acc55..42938400efb0 100644
> > > --- a/drivers/media/i2c/imx290.c
> > > +++ b/drivers/media/i2c/imx290.c
> > > @@ -255,6 +255,7 @@ struct imx290 {
> > >         struct v4l2_ctrl *link_freq;
> > >         struct v4l2_ctrl *hblank;
> > >         struct v4l2_ctrl *vblank;
> > > +       struct v4l2_ctrl *vtotal;
> > >         struct v4l2_ctrl *exposure;
> > >         struct {
> > >                 struct v4l2_ctrl *hflip;
> > > @@ -782,8 +783,7 @@ static void imx290_exposure_update(struct imx290 *imx290,
> > >  {
> > >         unsigned int exposure_max;
> > >
> > > -       exposure_max = imx290->vblank->val + mode->height -
> > > -                      IMX290_EXPOSURE_OFFSET;
> > > +       exposure_max = imx290->vtotal->val - IMX290_EXPOSURE_OFFSET;
> > >         __v4l2_ctrl_modify_range(imx290->exposure, 1, exposure_max, 1,
> > >                                  exposure_max);
> > >  }
> > > @@ -794,7 +794,7 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
> > >                                              struct imx290, ctrls);
> > >         const struct v4l2_mbus_framefmt *format;
> > >         struct v4l2_subdev_state *state;
> > > -       int ret = 0, vmax;
> > > +       int ret = 0;
> > >
> > >         /*
> > >          * Return immediately for controls that don't need to be applied to the
> > > @@ -803,10 +803,22 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
> > >         if (ctrl->flags & V4L2_CTRL_FLAG_READ_ONLY)
> > >                 return 0;
> > >
> > > -       if (ctrl->id == V4L2_CID_VBLANK) {
> > > -               /* Changing vblank changes the allowed range for exposure. */
> > > +       /* Changing vtotal changes the allowed range for exposure. */
> > > +       if (ctrl->id == V4L2_CID_VTOTAL)
> > >                 imx290_exposure_update(imx290, imx290->current_mode);
> > > -       }
> > > +
> > > +       /*
> > > +        * vblank and vtotal depend on each other, therefore also update the
> > > +        * other one.
> > > +        */
> > > +       if (ctrl->id == V4L2_CID_VBLANK &&
> > > +           imx290->vtotal->val != ctrl->val + imx290->current_mode->height)
> > > +               __v4l2_ctrl_s_ctrl(imx290->vtotal,
> > > +                                  ctrl->val + imx290->current_mode->height);
> > > +       if (ctrl->id == V4L2_CID_VTOTAL &&
> > > +           imx290->vblank->val != ctrl->val - imx290->current_mode->height)
> > > +               __v4l2_ctrl_s_ctrl(imx290->vblank,
> > > +                                  ctrl->val - imx290->current_mode->height);
> > >
> > >         /* V4L2 controls values will be applied only when power is already up */
> > >         if (!pm_runtime_get_if_in_use(imx290->dev))
> > > @@ -821,9 +833,14 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
> > >                 break;
> > >
> > >         case V4L2_CID_VBLANK:
> > > -               ret = imx290_write(imx290, IMX290_VMAX,
> > > -                                  ctrl->val + imx290->current_mode->height,
> > > -                                  NULL);
> > > +               /* vblank is updated by vtotal. */
> > > +               break;
> > > +
> > > +       case V4L2_CID_VTOTAL:
> > > +               ret = imx290_write(imx290, IMX290_VMAX, ctrl->val, NULL);
> > > +               if (ret)
> > > +                       goto err;
> > > +
> > >                 /*
> > >                  * Due to the way that exposure is programmed in this sensor in
> > >                  * relation to VMAX, we have to reprogramme it whenever VMAX is
> > > @@ -834,9 +851,8 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
> > >                 ctrl = imx290->exposure;
> > >                 fallthrough;
> > >         case V4L2_CID_EXPOSURE:
> > > -               vmax = imx290->vblank->val + imx290->current_mode->height;
> > >                 ret = imx290_write(imx290, IMX290_SHS1,
> > > -                                  vmax - ctrl->val - 1, NULL);
> > > +                                  imx290->vtotal->val - ctrl->val - 1, NULL);
> > >                 break;
> > >
> > >         case V4L2_CID_TEST_PATTERN:
> > > @@ -880,6 +896,7 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
> > >                 break;
> > >         }
> > >
> > > +err:
> > >         pm_runtime_mark_last_busy(imx290->dev);
> > >         pm_runtime_put_autosuspend(imx290->dev);
> > >
> > > @@ -911,11 +928,14 @@ static void imx290_ctrl_update(struct imx290 *imx290,
> > >         unsigned int vblank_max = IMX290_VMAX_MAX - mode->height;
> > >
> > >         __v4l2_ctrl_s_ctrl(imx290->link_freq, mode->link_freq_index);
> > > +       __v4l2_ctrl_s_ctrl(imx290->vblank, imx290->vtotal->val - mode->height);
> > >
> > >         __v4l2_ctrl_modify_range(imx290->hblank, hblank_min, hblank_max, 1,
> > >                                  hblank_min);
> > >         __v4l2_ctrl_modify_range(imx290->vblank, vblank_min, vblank_max, 1,
> > >                                  vblank_min);
> > > +       __v4l2_ctrl_modify_range(imx290->vtotal, mode->vmax_min,
> > > +                                IMX290_VMAX_MAX, 1, mode->vmax_min);
> > >  }
> > >
> > >  static int imx290_ctrl_init(struct imx290 *imx290)
> > > @@ -947,7 +967,7 @@ static int imx290_ctrl_init(struct imx290 *imx290)
> > >
> > >         /*
> > >          * Correct range will be determined through imx290_ctrl_update setting
> > > -        * V4L2_CID_VBLANK.
> > > +        * V4L2_CID_VTOTAL.
> > >          */
> > >         imx290->exposure = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
> > >                                              V4L2_CID_EXPOSURE, 1, 65535, 1,
> > > @@ -983,6 +1003,9 @@ static int imx290_ctrl_init(struct imx290 *imx290)
> > >
> > >         imx290->vblank = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
> > >                                            V4L2_CID_VBLANK, 1, 1, 1, 1);
> > > +       imx290->vtotal = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
> > > +                                          V4L2_CID_VTOTAL, 1, IMX290_VMAX_MAX,
> > > +                                          1, 1);
> > >
> > >         imx290->hflip = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
> > >                                           V4L2_CID_HFLIP, 0, 1, 1, 0);
> > >
> > > --
> > > 2.34.1
> > >
