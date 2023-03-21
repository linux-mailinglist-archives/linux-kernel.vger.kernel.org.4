Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A8C6C38BC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCUR47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjCUR4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:56:50 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83C455076;
        Tue, 21 Mar 2023 10:56:22 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E8B9310B;
        Tue, 21 Mar 2023 18:56:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679421380;
        bh=qUl73zAreteh4tygAoGY7Wt9PYd+S1ypY5ZT9bhJVDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ukY4KOk9jKXfhWRu9zVGMpIr/bv06kOTxC29OWXxgVm1lx2a3/fmFsR6yTJSDAL1+
         i/jvAoX1V6kkOPDMliwQFhhQwCHFL0q11rTNW33BXwL9i0mdgI+mT6PSrCLelhqGOK
         dOYCC2e0R88jo66EuMNyCWo+/ECyv1Sh1m4OQ4vc=
Date:   Tue, 21 Mar 2023 19:56:26 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, changhuang.liang@starfivetech.com
Subject: Re: [PATCH v2 6/6] media: starfive: Add Starfive Camera Subsystem
 driver
Message-ID: <20230321175626.GD20234@pendragon.ideasonboard.com>
References: <20230310120553.60586-1-jack.zhu@starfivetech.com>
 <20230310120553.60586-7-jack.zhu@starfivetech.com>
 <20230312124339.GD2545@pendragon.ideasonboard.com>
 <650b6882-ea02-e4c8-1f73-9e5bdeab290d@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <650b6882-ea02-e4c8-1f73-9e5bdeab290d@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

On Tue, Mar 21, 2023 at 08:56:34PM +0800, Jack Zhu wrote:
> On 2023/3/12 20:43, Laurent Pinchart wrote:
> > Hi Jack,
> > 
> > Thank you for the patch.
> > 
> > I'll do a partial review here as the patch is huge and I'm lacking time
> > at the moment.
> 
> Thank you for the review and your time.
> 
> > On Fri, Mar 10, 2023 at 08:05:53PM +0800, Jack Zhu wrote:
> >> Add the driver for Starfive Camera Subsystem found on
> >> Starfive JH7110 SoC. It is used for handing image sensor
> >> data.
> >> 
> >> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> >> ---
> >>  drivers/media/platform/Kconfig                |    1 +
> >>  drivers/media/platform/Makefile               |    1 +
> >>  drivers/media/platform/starfive/Kconfig       |   18 +
> >>  drivers/media/platform/starfive/Makefile      |   14 +
> >>  drivers/media/platform/starfive/stf_camss.c   |  728 +++++++++
> >>  drivers/media/platform/starfive/stf_camss.h   |  104 ++
> >>  drivers/media/platform/starfive/stf_common.h  |  149 ++
> >>  drivers/media/platform/starfive/stf_isp.c     | 1079 ++++++++++++++
> >>  drivers/media/platform/starfive/stf_isp.h     |  183 +++
> >>  .../media/platform/starfive/stf_isp_hw_ops.c  | 1286 ++++++++++++++++
> >>  drivers/media/platform/starfive/stf_video.c   | 1286 ++++++++++++++++
> >>  drivers/media/platform/starfive/stf_video.h   |   89 ++
> >>  drivers/media/platform/starfive/stf_vin.c     | 1314 +++++++++++++++++
> >>  drivers/media/platform/starfive/stf_vin.h     |  194 +++
> >>  .../media/platform/starfive/stf_vin_hw_ops.c  |  357 +++++
> >>  include/uapi/linux/stf_isp_ioctl.h            |  127 ++
> >>  16 files changed, 6930 insertions(+)
> >>  create mode 100644 drivers/media/platform/starfive/Kconfig
> >>  create mode 100644 drivers/media/platform/starfive/Makefile
> >>  create mode 100644 drivers/media/platform/starfive/stf_camss.c
> >>  create mode 100644 drivers/media/platform/starfive/stf_camss.h
> >>  create mode 100644 drivers/media/platform/starfive/stf_common.h
> >>  create mode 100644 drivers/media/platform/starfive/stf_isp.c
> >>  create mode 100644 drivers/media/platform/starfive/stf_isp.h
> >>  create mode 100644 drivers/media/platform/starfive/stf_isp_hw_ops.c
> >>  create mode 100644 drivers/media/platform/starfive/stf_video.c
> >>  create mode 100644 drivers/media/platform/starfive/stf_video.h
> >>  create mode 100644 drivers/media/platform/starfive/stf_vin.c
> >>  create mode 100644 drivers/media/platform/starfive/stf_vin.h
> >>  create mode 100644 drivers/media/platform/starfive/stf_vin_hw_ops.c
> >>  create mode 100644 include/uapi/linux/stf_isp_ioctl.h

[snip]

> >> diff --git a/drivers/media/platform/starfive/stf_camss.c b/drivers/media/platform/starfive/stf_camss.c
> >> new file mode 100644
> >> index 000000000000..525f2d80c5eb
> >> --- /dev/null
> >> +++ b/drivers/media/platform/starfive/stf_camss.c
> >> @@ -0,0 +1,728 @@

[snip]

> >> +/*
> >> + * stfcamss_find_sensor - Find a linked media entity which represents a sensor
> >> + * @entity: Media entity to start searching from
> >> + *
> >> + * Return a pointer to sensor media entity or NULL if not found
> >> + */
> >> +struct media_entity *stfcamss_find_sensor(struct media_entity *entity)
> > 
> > From a camss point of view, the source is the csi2rx. You shouldn't
> > need to access the sensor directly, only the csi2rx. If you think you
> > have a need to access the sensor, please explain why and we can discuss
> > it.
> 
> need to use format and bpp of sensor to configure isp HW.

You can obtain the same information from the ISP sink pad:


+----------+       +------------+       +-----------+
|          |       |            |       |           | 
| Sensor [0| ----> |0] csi2rx [1| ----> |0]   ISP   |
|          |       |            |       |           |
+----------+       +------------+       +-----------+

(I'm not entirely sure if the csi2rx and ISP pad numbers are correct,
but that's the idea.)

The csi2rx can't modify the format (size and bpp), so the format on the
sensor's pad 0, csi2rx pad 0, csi2rx pad 1 and ISP pad 0 must be
identical.

In isp_sensor_fmt_to_index(), the ISP driver doesn't need to get the
format from the sensor, it can use the format on ISP pad 0 instead.

In video_enum_framesizes(), the ISP driver shouldn't look at the format
on the ISP input at all, it must enumerate all sizes that the video node
supports, regardless of what is connected to its input.

video_enum_frameintervals() should be dropped, the ISP itself has no
notion of frame interval. Userspace can query and configure the frame
rate from the sensor subdev directly.

In video_pipeline_s_fmt(), the ISP driver shouldn't look at the format
on the ISP input at all either. It must accept any format supported by
the ISP. It's only when starting streaming that the pipeline is
validated to make sure the formats configured on all subdevs match. I
recommend reading https://git.ideasonboard.org/doc/mc-v4l2.git for an
overview of how Media Controller-based drivers should behave. The
documentation describes how the API is meant to be used from userspace,
but the operating principles apply to driver development too.

video_subscribe_event() and video_unsubscribe_event() should also be
dropped, events from the sensor can be accessed by userspace on the
sensor subdev directly.

vin_set_stream() should call .s_stream() on the csi2rx, not the sensor.
The csi2rx .s_stream() handler will forward the call to the sensor.

> >> +{
> >> +	struct media_pad *pad;
> >> +
> >> +	while (1) {
> >> +		if (!entity->pads)
> >> +			return NULL;
> >> +
> >> +		pad = &entity->pads[0];
> >> +		if (!(pad->flags & MEDIA_PAD_FL_SINK))
> >> +			return NULL;
> >> +
> >> +		pad = media_pad_remote_pad_first(pad);
> >> +		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
> >> +			return NULL;
> >> +
> >> +		entity = pad->entity;
> >> +
> >> +		if (entity->function == MEDIA_ENT_F_CAM_SENSOR)
> >> +			return entity;
> >> +	}
> >> +}

[snip]

> >> diff --git a/include/uapi/linux/stf_isp_ioctl.h b/include/uapi/linux/stf_isp_ioctl.h
> >> new file mode 100644
> >> index 000000000000..3f302ef235d2
> >> --- /dev/null
> >> +++ b/include/uapi/linux/stf_isp_ioctl.h
> >> @@ -0,0 +1,127 @@

[snip]

> >> +enum _STF_ISP_IOCTL {
> > 
> > Device-specific ioctls are allowed, but they must all be clearly
> > documented.
> 
> OK, I will add annotations for these ioctls.
> 
> > 
> >> +	STF_ISP_IOCTL_LOAD_FW = BASE_VIDIOC_PRIVATE + 1,
> > 
> > Why can't you use the Linux kernel firmware API ?
> 
> The ioctl is used for loading config file, it is different from
> the Linux kernel firmware API. I will rename it.

Could you explain what the config file is used for ?

> >> +	STF_ISP_IOCTL_DMABUF_ALLOC,
> >> +	STF_ISP_IOCTL_DMABUF_FREE,
> >> +	STF_ISP_IOCTL_GET_HW_VER,
> > 
> > Not used, drop them.
> 
> OK, will drop them.
> 
> > 
> >> +	STF_ISP_IOCTL_REG,
> > 
> > Setting registers from userspace isn't allowed. No exception.
> 
> OK, will fix.
> 
> > 
> >> +	STF_ISP_IOCTL_SHADOW_LOCK,
> >> +	STF_ISP_IOCTL_SHADOW_UNLOCK,
> >> +	STF_ISP_IOCTL_SHADOW_UNLOCK_N_TRIGGER,
> >> +	STF_ISP_IOCTL_SET_USER_CONFIG_ISP,
> > 
> > I'm not sure what these ioctls do exactly as documentation is missing,
> > but I don't think they are the right API. Please describe the problem
> > you're trying to solve, and we'll find a good API.
> 
> These were used for debugging, I will drop them. Thanks.
> 
> >> +	STF_ISP_IOCTL_MAX
> >> +};

[snip]

-- 
Regards,

Laurent Pinchart
