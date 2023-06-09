Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BB3729D8D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240514AbjFIO5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241713AbjFIO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:57:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D1C3C0B;
        Fri,  9 Jun 2023 07:56:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so3293634a12.2;
        Fri, 09 Jun 2023 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686322616; x=1688914616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzFk5e6FU4vaw3ghwnQ+N3gSwXd4BJt0wdQ5gDBNr9g=;
        b=di+OCGvnTt3zZGp8y7OX50WkKcMQa9Owlgdq/OFmMbS5PcXhxwx8jGcCjrHwMOwdwb
         2dRnOCyP7Yr7pwY+4pr12w+kuebNlmSrsnjxiUe9NMVmuW/MSNRJSMTTAmT9S0cRHhgO
         mwNBjqX/l2j2in+OoaxKsZkY2Bo8CWH5V7l9kgChx/Y8lsq/mXlSSnLthIObc+P4PFEx
         PkaPgAElcbe07UWAWZ+ygxobn8kiCW89v+FzIo3cFsrfXjYTfqFfFwSx/FDXYkpjIHDD
         VXqhbEtN2J6IViE5n7HdH/YdIRfekzA/m1xvgBSnbJGATvE28+fr0K9IaI7eDp2eW7Ib
         kvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322616; x=1688914616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzFk5e6FU4vaw3ghwnQ+N3gSwXd4BJt0wdQ5gDBNr9g=;
        b=jfJ4H23ru36G90j9vRYpDgATqB4BbPt+RIv9WIev187NH1qrBSkoNN18ZkUYV4cg0O
         7KHyJA/Z+kDbXHrDduI8XPrfo9iw+mDsLhhFTOMIIpQ55bqEekkCFAsR58Z/AMxBIRqi
         Mc3ibZ6qPkkJHCCCtK2/H8JSy+1kVlTwCeO3d8duvx686xHJyQFQlzMSdFjvH/59pc3t
         DqtJYW+RtgQx/uyocuBD88JTBVQoxO5PBac52Qfva9axw61keTQrnoTsyZvZX+ELmU3w
         5ikcuXkVuLkHTfNn6bl8cKDLo2cQlAMAG7nsw6QwKwJcJME8NIHZhNC7LhgEL1oRnaJn
         butg==
X-Gm-Message-State: AC+VfDyY+CuWkoF44h7/M9mkQ29c65eBYjigTxfs3Jh3CzFrouhNodf1
        h8lphQ7nj3hO1f2GhBpE2hA=
X-Google-Smtp-Source: ACHHUZ7yLGXKZjTTcs9Ynq0E0QrqpmUdMDFWRMwHf0aGznb9knf83o8w0SHxzJ4YlIg0N+jvjRiqXw==
X-Received: by 2002:a17:907:9802:b0:973:cb21:8479 with SMTP id ji2-20020a170907980200b00973cb218479mr2193199ejc.70.1686322615963;
        Fri, 09 Jun 2023 07:56:55 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709060eea00b009745edfb7cbsm1388188eji.45.2023.06.09.07.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:56:55 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     dave.stevenson@raspberrypi.com
Cc:     bbara93@gmail.com, benjamin.bara@skidata.com,
        jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mani@kernel.org, mchehab@kernel.org
Subject: [PATCH 2/2] media: i2c: imx290: Add support for V4L2_CID_VTOTAL
Date:   Fri,  9 Jun 2023 16:56:48 +0200
Message-Id: <20230609145648.1960398-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAPY8ntCx8QLX_jqtJeWzCQkApSR_+RY7jMM5pDNA7zewJa+eiA@mail.gmail.com>
References: <CAPY8ntCx8QLX_jqtJeWzCQkApSR_+RY7jMM5pDNA7zewJa+eiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

thanks for the feedback!

On Fri, 9 Jun 2023 at 16:21, Dave Stevenson <dave.stevenson@raspberrypi.com> wrote:
> On Fri, 9 Jun 2023 at 14:16, Benjamin Bara <bbara93@gmail.com> wrote:
> >
> > From: Benjamin Bara <benjamin.bara@skidata.com>
> >
> > The new V4L2_CID_VTOTAL control represents the VMAX register.
> > Implementing it simplifies calculations in user space, as it is
> > independent of the current mode (format height), meaning its value does
> > not change with format changes.
>
> I know Laurent suggested this change[1] so that (AIUI) exposure max
> limits are easier to compute around mode changes.
>
> I'm currently seeing this as a fair amount of boilerplate to be added
> to all drivers so that two controls provide effectively the same
> information, and I'm not convinced it saves any significant effort in
> userspace. Can you (or Laurent) detail exactly what the issue is that
> the new control solves?

Sure. My main problem with the current blanking controls is that it is
not clear what should happen in case of a format switch. I guess the
expected case is that the vertical blanking should stay constant, but
that might be implemented differently.
If so, this results in a change of the total frame duration. If we
switch to "total", a format switch would result to the same (required)
frame rate, as the blanking would be reduced instead. I guess this
represents the typical "use case" better, and clarifies implementation
things. Currently, it seems a little bit odd or unnecessary complicated
to me that I have to modify a blanking time and need to know the current
format to be able to achieve a certain frame rate. But maybe Laurent has
other issues.

> Do we need to do the same for HBLANK as well, or do we live with an
> asymmetrical set of controls.

I can add that in a v2 too, IMHO it makes sense to replace both
blankings with totals. So one can set HTOTAL to min and VTOTAL to the
required frame rate (simpler calculation now) and has the guarantee that
the frame rate stays constant during format switches (if the pixel rate
is high enough of course). I will then also adapt the doc accordingly.

Hope this clarifies it.

Regards,
Benjamin

> Thanks
>   Dave
>
> [1] https://lists.libcamera.org/pipermail/libcamera-devel/2023-June/038170.html
>
> > Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> > ---
> >  drivers/media/i2c/imx290.c | 47 ++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 35 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> > index 5ea25b7acc55..42938400efb0 100644
> > --- a/drivers/media/i2c/imx290.c
> > +++ b/drivers/media/i2c/imx290.c
> > @@ -255,6 +255,7 @@ struct imx290 {
> >         struct v4l2_ctrl *link_freq;
> >         struct v4l2_ctrl *hblank;
> >         struct v4l2_ctrl *vblank;
> > +       struct v4l2_ctrl *vtotal;
> >         struct v4l2_ctrl *exposure;
> >         struct {
> >                 struct v4l2_ctrl *hflip;
> > @@ -782,8 +783,7 @@ static void imx290_exposure_update(struct imx290 *imx290,
> >  {
> >         unsigned int exposure_max;
> >
> > -       exposure_max = imx290->vblank->val + mode->height -
> > -                      IMX290_EXPOSURE_OFFSET;
> > +       exposure_max = imx290->vtotal->val - IMX290_EXPOSURE_OFFSET;
> >         __v4l2_ctrl_modify_range(imx290->exposure, 1, exposure_max, 1,
> >                                  exposure_max);
> >  }
> > @@ -794,7 +794,7 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
> >                                              struct imx290, ctrls);
> >         const struct v4l2_mbus_framefmt *format;
> >         struct v4l2_subdev_state *state;
> > -       int ret = 0, vmax;
> > +       int ret = 0;
> >
> >         /*
> >          * Return immediately for controls that don't need to be applied to the
> > @@ -803,10 +803,22 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
> >         if (ctrl->flags & V4L2_CTRL_FLAG_READ_ONLY)
> >                 return 0;
> >
> > -       if (ctrl->id == V4L2_CID_VBLANK) {
> > -               /* Changing vblank changes the allowed range for exposure. */
> > +       /* Changing vtotal changes the allowed range for exposure. */
> > +       if (ctrl->id == V4L2_CID_VTOTAL)
> >                 imx290_exposure_update(imx290, imx290->current_mode);
> > -       }
> > +
> > +       /*
> > +        * vblank and vtotal depend on each other, therefore also update the
> > +        * other one.
> > +        */
> > +       if (ctrl->id == V4L2_CID_VBLANK &&
> > +           imx290->vtotal->val != ctrl->val + imx290->current_mode->height)
> > +               __v4l2_ctrl_s_ctrl(imx290->vtotal,
> > +                                  ctrl->val + imx290->current_mode->height);
> > +       if (ctrl->id == V4L2_CID_VTOTAL &&
> > +           imx290->vblank->val != ctrl->val - imx290->current_mode->height)
> > +               __v4l2_ctrl_s_ctrl(imx290->vblank,
> > +                                  ctrl->val - imx290->current_mode->height);
> >
> >         /* V4L2 controls values will be applied only when power is already up */
> >         if (!pm_runtime_get_if_in_use(imx290->dev))
> > @@ -821,9 +833,14 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
> >                 break;
> >
> >         case V4L2_CID_VBLANK:
> > -               ret = imx290_write(imx290, IMX290_VMAX,
> > -                                  ctrl->val + imx290->current_mode->height,
> > -                                  NULL);
> > +               /* vblank is updated by vtotal. */
> > +               break;
> > +
> > +       case V4L2_CID_VTOTAL:
> > +               ret = imx290_write(imx290, IMX290_VMAX, ctrl->val, NULL);
> > +               if (ret)
> > +                       goto err;
> > +
> >                 /*
> >                  * Due to the way that exposure is programmed in this sensor in
> >                  * relation to VMAX, we have to reprogramme it whenever VMAX is
> > @@ -834,9 +851,8 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
> >                 ctrl = imx290->exposure;
> >                 fallthrough;
> >         case V4L2_CID_EXPOSURE:
> > -               vmax = imx290->vblank->val + imx290->current_mode->height;
> >                 ret = imx290_write(imx290, IMX290_SHS1,
> > -                                  vmax - ctrl->val - 1, NULL);
> > +                                  imx290->vtotal->val - ctrl->val - 1, NULL);
> >                 break;
> >
> >         case V4L2_CID_TEST_PATTERN:
> > @@ -880,6 +896,7 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
> >                 break;
> >         }
> >
> > +err:
> >         pm_runtime_mark_last_busy(imx290->dev);
> >         pm_runtime_put_autosuspend(imx290->dev);
> >
> > @@ -911,11 +928,14 @@ static void imx290_ctrl_update(struct imx290 *imx290,
> >         unsigned int vblank_max = IMX290_VMAX_MAX - mode->height;
> >
> >         __v4l2_ctrl_s_ctrl(imx290->link_freq, mode->link_freq_index);
> > +       __v4l2_ctrl_s_ctrl(imx290->vblank, imx290->vtotal->val - mode->height);
> >
> >         __v4l2_ctrl_modify_range(imx290->hblank, hblank_min, hblank_max, 1,
> >                                  hblank_min);
> >         __v4l2_ctrl_modify_range(imx290->vblank, vblank_min, vblank_max, 1,
> >                                  vblank_min);
> > +       __v4l2_ctrl_modify_range(imx290->vtotal, mode->vmax_min,
> > +                                IMX290_VMAX_MAX, 1, mode->vmax_min);
> >  }
> >
> >  static int imx290_ctrl_init(struct imx290 *imx290)
> > @@ -947,7 +967,7 @@ static int imx290_ctrl_init(struct imx290 *imx290)
> >
> >         /*
> >          * Correct range will be determined through imx290_ctrl_update setting
> > -        * V4L2_CID_VBLANK.
> > +        * V4L2_CID_VTOTAL.
> >          */
> >         imx290->exposure = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
> >                                              V4L2_CID_EXPOSURE, 1, 65535, 1,
> > @@ -983,6 +1003,9 @@ static int imx290_ctrl_init(struct imx290 *imx290)
> >
> >         imx290->vblank = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
> >                                            V4L2_CID_VBLANK, 1, 1, 1, 1);
> > +       imx290->vtotal = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
> > +                                          V4L2_CID_VTOTAL, 1, IMX290_VMAX_MAX,
> > +                                          1, 1);
> >
> >         imx290->hflip = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
> >                                           V4L2_CID_HFLIP, 0, 1, 1, 0);
> >
> > --
> > 2.34.1
> >
