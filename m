Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217ED65C4EF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjACRRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbjACRQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:16:34 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230FE12D;
        Tue,  3 Jan 2023 09:16:30 -0800 (PST)
Received: from ideasonboard.com (unknown [IPv6:2001:b07:5d2e:52c9:c40c:10ff:feac:d8bd])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0844B108;
        Tue,  3 Jan 2023 18:16:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672766188;
        bh=ofo4GzrdVQH1obFaHFxzJfhNyKBzO3Qcag5f/hPBy7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QzbLQbl3ybe4jiXkLKxS0/caADsDAUvE82NG4MKmovwR2T7hcr76IXTuxE2SMoskk
         rruEpykXx15XijwjtKqG56yGU/08VEZBwVcjfLCDtP/8P5Nbx1Z6X0ft49WtUR5s3g
         YTkLgN9MQSZcCmbyiTdz6HUfTg2J43L/7ibHIn7w=
Date:   Tue, 3 Jan 2023 18:16:24 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Robert Mader <robert.mader@collabora.com>
Cc:     linux-kernel@vger.kernel.org, nicholas@rothemail.net,
        javierm@redhat.com, Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: i2c: imx258: Parse and register properties
Message-ID: <20230103171624.qx6hm2exs3d5lg53@uno.localdomain>
References: <20221225154234.378555-1-robert.mader@collabora.com>
 <20230102140631.hadlh3stozecnzpj@uno.localdomain>
 <20f405f3-0a82-5d2f-2b0d-ce0d510b5098@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20f405f3-0a82-5d2f-2b0d-ce0d510b5098@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert

On Tue, Jan 03, 2023 at 03:11:44PM +0100, Robert Mader wrote:
> On 02.01.23 15:06, Jacopo Mondi wrote:
> > Hi Robert
> >
> > On Sun, Dec 25, 2022 at 04:42:34PM +0100, Robert Mader wrote:
> > > Analogous to e.g. the imx219. This enables propagating
> > > V4L2_CID_CAMERA_SENSOR_ROTATION values so that libcamera
> > > can detect the correct rotation from the device tree
> > > and propagate it further to e.g. Pipewire.
> > >
> > > Signed-off-by: Robert Mader <robert.mader@collabora.com>
> > > ---
> > >   drivers/media/i2c/imx258.c | 13 ++++++++++++-
> > >   1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> > > index eab5fc1ee2f7..85819043d1e3 100644
> > > --- a/drivers/media/i2c/imx258.c
> > > +++ b/drivers/media/i2c/imx258.c
> > > @@ -9,6 +9,7 @@
> > >   #include <linux/pm_runtime.h>
> > >   #include <media/v4l2-ctrls.h>
> > >   #include <media/v4l2-device.h>
> > > +#include <media/v4l2-fwnode.h>
> > >   #include <asm/unaligned.h>
> > >
> > >   #define IMX258_REG_VALUE_08BIT		1
> > > @@ -1149,6 +1150,7 @@ static int imx258_init_controls(struct imx258 *imx258)
> > >   {
> > >   	struct i2c_client *client = v4l2_get_subdevdata(&imx258->sd);
> > >   	struct v4l2_ctrl_handler *ctrl_hdlr;
> > > +	struct v4l2_fwnode_device_properties props;
> > Might be nicer to move this one line up
>
>  Can you say what's your reasoning? I personally slightly prefer
> alphabetical order, but no strong opinion :)
>

I've often been instructed to try to respect the inverse-xmas-tree
order when declaring variables, if possible. I now realize it's a sort
of cargo cult, as the rule is not written anywhere, so I can't ask
you to comply with what seems to be a personal preference :)

> > >   	s64 vblank_def;
> > >   	s64 vblank_min;
> > >   	s64 pixel_rate_min;

And anyway this breaks the rule already, so up to you, really

> > > @@ -1156,7 +1158,7 @@ static int imx258_init_controls(struct imx258 *imx258)
> > >   	int ret;
> > >
> > >   	ctrl_hdlr = &imx258->ctrl_handler;
> > > -	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 8);
> > > +	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 10);
> > I count 9 controls being registered before this patch, not 8. Do I
> > count them right ?
> >
> > If that's case, as v4l2_ctrl_new_fwnode_properties()
> > can register up to two controls (V4L2_CID_ROTATION and
> > V4L2_CID_ORIENTATION) I would pre-reserve 11 controls not 10 to avoid
> > relocations.
>
> Indeed, looks like bumping this was forgotten in
> c6f9d67e2ac625e331f6a7f5715d2f809ff0a922
>

Sorry, not your fault but since you're here... You can either make a
patch that fixes the existing number of controls first then apply
this one on top, or address the issue here, maybe with a small mention in
the commit message along the lines of:

While at it, reserve space for 3 additional controls even if
v4l2_ctrl_new_fwnode_properties() can only register 2 of
them, to fix the existing implementation which reserve space for 8
controls but actually registers 9.

Thanks
  j

> > >   	if (ret)
> > >   		return ret;
> > >
> > > @@ -1232,6 +1234,15 @@ static int imx258_init_controls(struct imx258 *imx258)
> > >   		goto error;
> > >   	}
> > >
> > > +	ret = v4l2_fwnode_device_parse(&client->dev, &props);
> > > +	if (ret)
> > > +		goto error;
> > > +
> > > +	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx258_ctrl_ops,
> > > +					      &props);
> > > +	if (ret)
> > > +		goto error;
> > > +
> > The rest looks good to me!
> >
> > Thanks
> >     j
> Thanks!
>
> --
> Robert Mader
> Consultant Software Developer
>
> Collabora Ltd.
> Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
> Registered in England & Wales, no. 5513718
>
