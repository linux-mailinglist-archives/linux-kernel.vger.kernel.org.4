Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4572D71F958
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 06:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbjFBEbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 00:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFBEbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 00:31:33 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA903F2;
        Thu,  1 Jun 2023 21:31:30 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126156168104.26.openmobile.ne.jp [126.156.168.104])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7997F4DA;
        Fri,  2 Jun 2023 06:31:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685680266;
        bh=9S9JYKY7cRm3zZqCOCmZP+h3+ydCaV86kXG8+VbfXGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q9UW+dDUVh5DA31FnP9O9ymemJUrgNqq1rNwOOSkQo8Y3AojRf962ZfhpiQE3/dBU
         dEITlaz3EaRv/JH107nz5/kOHcmkWznHQJKSRJESGnNQTuKFXZNQBugatoQ5pN8tzb
         4RF7T8+TILNdM35jimEqxWLhG/h/1BpvoXXnClDk=
Date:   Fri, 2 Jun 2023 07:31:26 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, martin.hecht@avnet.eu,
        linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 2/2] media: i2c: Add support for alvium camera
Message-ID: <20230602043126.GM22609@pendragon.ideasonboard.com>
References: <20230526173955.797226-1-tomm.merciai@gmail.com>
 <20230526173955.797226-3-tomm.merciai@gmail.com>
 <20230529074018.GD25984@pendragon.ideasonboard.com>
 <ZHcd09f5wOKjQdHX@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20230531113331.GC27043@pendragon.ideasonboard.com>
 <ZHjPyxColttdARQm@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZHjPyxColttdARQm@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

CC'ing Liam, Mark, Rob and Krzysztof. Sakari, there's also a question
for you below.

On Thu, Jun 01, 2023 at 07:05:15PM +0200, Tommaso Merciai wrote:
> On Wed, May 31, 2023 at 02:33:31PM +0300, Laurent Pinchart wrote:
> > On Wed, May 31, 2023 at 12:13:39PM +0200, Tommaso Merciai wrote:
> > > On Mon, May 29, 2023 at 10:40:18AM +0300, Laurent Pinchart wrote:
> > > > On Fri, May 26, 2023 at 07:39:44PM +0200, Tommaso Merciai wrote:
> > > > > The Alvium camera is shipped with sensor + isp in the same housing.
> > > > 
> > > > What ISP is that ?
> > > 
> > > The isp comes from Allied Vision, is called Alvium and is part of the camera.
> > > In real is a vision processor, this offers more functionality then an isp can do.
> > > It is not sold separately but is an integrated part of the camera itself
> > > which also takes care of the sensor abstraction.
> > > 
> > > > > The camera can be equipped with one out of various sensor and abstract
> > > > > the user from this. Camera is connected via MIPI CSI-2.
> > > > > 
> > > > > Most of the sensor's features are supported, with the main exception
> > > > > being fw update.
> > > > 
> > > > I assume you mean "camera module features" here, as firmware update
> > > > isn't a camera sensor feature.
> > > 
> > > Yep.
> > > 
> > > > > The driver provides all mandatory, optional and recommended V4L2 controls
> > > > > for maximum compatibility with libcamera
> > > > > 
> > > > > References:
> > > > >  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> > > > 
> > > > I'll do a partial review only as the patch is large, and will try to
> > > > review the rest in v2.
> > > 
> > > No problem.
> > > 
> > > > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > > > ---
> > > > >  drivers/media/i2c/Kconfig  |    9 +
> > > > >  drivers/media/i2c/Makefile |    1 +
> > > > >  drivers/media/i2c/alvium.c | 3547 ++++++++++++++++++++++++++++++++++++
> > > > >  drivers/media/i2c/alvium.h |  500 +++++
> > > > >  4 files changed, 4057 insertions(+)
> > > > >  create mode 100644 drivers/media/i2c/alvium.c
> > > > >  create mode 100644 drivers/media/i2c/alvium.h

[snip]

> > > > > diff --git a/drivers/media/i2c/alvium.c b/drivers/media/i2c/alvium.c
> > > > > new file mode 100644
> > > > > index 000000000000..e77fb6bda64b
> > > > > --- /dev/null
> > > > > +++ b/drivers/media/i2c/alvium.c
> > > > > @@ -0,0 +1,3547 @@

[snip]

> > > > > +static int alvium_probe(struct i2c_client *client)
> > > > > +{
> > > > > +	struct device *dev = &client->dev;
> > > > > +	struct v4l2_subdev *sd;
> > > > > +	struct alvium_dev *alvium;
> > > > > +	int ret;
> > > > > +
> > > > > +	alvium = devm_kzalloc(dev, sizeof(*alvium), GFP_KERNEL);
> > > > > +	if (!alvium)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	alvium->i2c_client = client;
> > > > > +	ret = alvium_get_dt_data(alvium);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	mutex_init(&alvium->lock);
> > > > > +
> > > > > +	sd = &alvium->sd;
> > > > > +
> > > > > +	/* init alvium sd */
> > > > > +	v4l2_i2c_subdev_init(sd, client, &alvium_subdev_ops);
> > > > > +
> > > > > +	sd->flags |= V4L2_SUBDEV_FL_HAS_EVENTS | V4L2_SUBDEV_FL_HAS_DEVNODE;
> > > > > +	alvium->pad.flags = MEDIA_PAD_FL_SOURCE;
> > > > > +	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
> > > > > +	sd->entity.ops = &alvium_sd_media_ops;
> > > > > +
> > > > > +	ret = media_entity_pads_init(&sd->entity, 1, &alvium->pad);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	sd->dev = dev;
> > > > > +
> > > > > +	ret = alvium_power_on(alvium);
> > > > 
> > > > The driver should use runtime PM (with autosuspend), and power on/off in
> > > > the .s_stream() handler.
> > > 
> > > Can we delay the pm implementation as a future patchset?
> > > Alvium pm would be tricky (cause is the boot time of the camera)
> > > and if is possible I want work on pm later.
> > > Let me know. Thanks! :)
> > 
> > With autosuspend the camera can remain powered up between stream stop
> > and stream start, if they happen quickly enough. An autosuspend delay of
> > a few seconds is usually a good value. It should be fairly easy to
> > implement runtime PM support, you just need to
> > 
> > - Call alvium_power_on() from the runtime PM resume handler and
> >   alvium_power_off() from the runtime PM suspend handler.
> > 
> > - Call pm_runtime_resume_and_get() and stream on time, and
> >   pm_runtime_mark_last_busy() and pm_runtime_put_autosuspend() at stream
> >   stop time.
> > 
> > - Initialize runtime PM at probe time (and clean up at remove time).
> >   There's a bit of boilerplate code needed to get that right, but it's
> >   not difficult. You can copy it from the imx290 driver.
> 
> Back to you to clarify this point.
> 
> Plan as you suggest is handling pm of camera using external
> regulator. Problem is that the boot time of the camera is around 5s.

5s ? Ouch !!

This has two consequences:

- Just probing the camera would take 5s, which is insanely long.
- There will be a 5s delay when starting video capture.

There's no 5s delay in the current code, so I assume things work fine
because the power regulator is always on, and turned on 5s or more
before the driver is loaded. That's pretty fragile.

That camera is clearly not a good fit for an embedded system that cares
about power consumption and performance, but we still have to support
it. The probe time issue isn't something we can fix, a 5s delay is
required.

The stream start issue can be alleviated by keeping the camera on, or
offering a way for userspace to turn it on ahead of stream start.
Runtime PM autosuspend will help with the former, and I would push the
autosuspend delay up as a result of the huge camera boot time. We don't
have a good solution of the latter at the moment, it used to be that
opening video nodes would power up the whole pipeline, but that has been
dropped some time ago in V4L2. Another API extension for this kind of
use cases would be useful I think. Sakari, any opinion ?

> Can I use:
>  - regulator-boot-on; To handle 5s of boot time during the probe
>  - add delay of 5s on power on?
> 
> What do you think?

I expect people to mark the camera regulator as regulator-always-on in DT to work
around the problem. regulator-boot-on is different, I don't think you
need it in this case. Its documentation states

  "This property is intended to only be used for regulators where
  software cannot read the state of the regulator."

This means that we shouldn't add an unconditional delay of 5s in the PM
runtime resume handler in the driver, as that would cause a huge penalty
if the regulator was already on. We could set the
regulator-enable-ramp-delay property to 5s, which would ensure that the
camera has time to boot whenever to regulator is turned on, but won't
cause any additional delay at every stream start. Trouble is, that's a
bit of a hack, as the 5s boot time is a property of the camera, not the
regulator.

Another option would be to add the delay in the driver, but condition it
on the state of the regulator. If the regulator is already on, the delay
would be skipped. This won't work if the supply is not always on and
shared between different devices though, as another device could turn it
on shortly before the camera driver runs the runtime PM resume handler,
and we would skip the delay in that case.

Any opinion from the regulator framework and DT bindings maintainers on
this topic ?

> > > > > +	if (ret)
> > > > > +		goto entity_cleanup;
> > > > > +
> > > > > +	ret = alvium_get_hw_info(alvium);
> > > > > +	if (ret) {
> > > > > +		dev_err(dev, "Device detection failed: %d\n", ret);
> > > > > +		goto err_poweroff;
> > > > > +	}
> > > > > +
> > > > > +	ret = alvium_hw_init(alvium);
> > > > > +	if (ret) {
> > > > > +		dev_err(dev, "hw_init fail %d\n", ret);
> > > > > +		goto entity_cleanup;
> > > > > +	}
> > > > > +
> > > > > +	ret = alvium_setup_mipi_fmt(alvium);
> > > > > +	if (ret) {
> > > > > +		dev_err(dev, "hw_init fail %d\n", ret);
> > > > > +		goto entity_cleanup;
> > > > > +	}
> > > > > +
> > > > > +	/* Setup initial frame interval*/
> > > > > +	alvium->frame_interval.numerator = 1;
> > > > > +	alvium->frame_interval.denominator = ALVIUM_DEFAULT_FR_HZ;
> > > > > +	alvium->fr = ALVIUM_DEFAULT_FR_HZ;
> > > > > +
> > > > > +	/* Setup the initial mode */
> > > > > +	alvium->mode.fmt = alvium_csi2_default_fmt;
> > > > > +	alvium->mode.width = alvium_csi2_default_fmt.width;
> > > > > +	alvium->mode.height = alvium_csi2_default_fmt.height;
> > > > > +	alvium->mode.crop.left = alvium->min_offx;
> > > > > +	alvium->mode.crop.top = alvium->min_offy;
> > > > > +	alvium->mode.crop.width = alvium_csi2_default_fmt.width;
> > > > > +	alvium->mode.crop.height = alvium_csi2_default_fmt.height;
> > > > > +
> > > > > +	ret = alvium_init_controls(alvium);
> > > > > +	if (ret)
> > > > > +		goto entity_cleanup;
> > > > > +
> > > > > +	ret = v4l2_async_register_subdev_sensor(sd);
> > > > > +	if (ret) {
> > > > > +		dev_err(dev,
> > > > > +			"failed to register async subdev: %d", ret);
> > > > > +		goto entity_cleanup;
> > > > > +	}
> > > > > +
> > > > > +	v4l2_info(sd, "%s: completed successfully\n", __func__);
> > > > > +	return 0;
> > > > > +
> > > > > +err_poweroff:
> > > > > +	alvium_power_off(alvium);
> > > > > +entity_cleanup:
> > > > > +	media_entity_cleanup(&sd->entity);
> > > > > +	mutex_destroy(&alvium->lock);
> > > > > +	return ret;
> > > > > +}

[snip]

-- 
Regards,

Laurent Pinchart
