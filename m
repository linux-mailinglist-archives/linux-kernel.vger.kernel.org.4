Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB2A718536
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbjEaOnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbjEaOnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:43:06 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0605ED9;
        Wed, 31 May 2023 07:43:01 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126205251136.34.openmobile.ne.jp [126.205.251.136])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 98F3B7F5;
        Wed, 31 May 2023 16:42:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685544158;
        bh=sYnvbp5YqSxneWSBkhI7BOpxc2bk2K6XTPgvmAUbjdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DyjPGZMVK0x52B3SNYcfNMWEcy+wR1MEsCI556HH9fq4Vm5lRlDjiyX3X8KRTEvrH
         DnQo8SxM/cTvqtq5013suNJwiMDfptxtLYVdTIaQ/iY6jpzYxOP45POBDG324pEmU+
         Yk7rGBFudHyD/zKQA1x7irVIhEkVizye9kTjv2Sw=
Date:   Wed, 31 May 2023 17:42:58 +0300
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
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 2/2] media: i2c: Add support for alvium camera
Message-ID: <20230531144258.GB24749@pendragon.ideasonboard.com>
References: <20230526173955.797226-1-tomm.merciai@gmail.com>
 <20230526173955.797226-3-tomm.merciai@gmail.com>
 <20230529074018.GD25984@pendragon.ideasonboard.com>
 <ZHcd09f5wOKjQdHX@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20230531113331.GC27043@pendragon.ideasonboard.com>
 <ZHdXV4SPOW0dxtcG@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZHdXV4SPOW0dxtcG@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Wed, May 31, 2023 at 04:19:03PM +0200, Tommaso Merciai wrote:
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

> > > > > +static int alvium_set_streamon_delay(struct alvium_dev *alvium)
> > > > > +{
> > > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > > +	int ret;
> > > > > +	u64 streamon_delay;
> > > > > +
> > > > > +	if (!alvium->bcrm_addr)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	/*
> > > > > +	 * CSI2 receivers sometimes need some delay before are ready to
> > > > > +	 * get data. This register set delay before camera start
> > > > > +	 * capturing frames in us.
> > > > 
> > > > If the CSI-2 receiver needs a delay, it should be handled by the CSI-2
> > > > receiver driver, not here.
> > > 
> > > My bad, bad description/bad name.
> > > 
> > > This regs is an optional delay that alvium introduces between switching
> > > from lp to hs mode.
> > > Some mipi receivers require this delay on the sender side.
> > > 
> > > I plan to switch to the following name: alliedvision,lp2hs-delay-us
> > > and fix the comment with the above comment^
> > > 
> > > This is more clear, what do you think about?
> > 
> > It's a bit clearer, but still not fully :-) Does this delay correspond
> > to one of the MIPI D-PHY timing parameters ? If so, which one ?
> 
> Thanks to Martin Hecht I'm able to provide you a clearer description:
> 
> Alvium normally delivers a continous clock even when it is not streaming.

That's an interesting design choice.

> The purpose of this reg is force a DPhy reset for the period described by
> the us on the reg before it starts streaming. To be clear, with that value
> bigger than 0 the Alvium forces a dphy-reset on all lanes for that period.
> That means all lanes go up into low power state.
> This may help a csi2 rx ip to reset if that IP can't deal with a continous clock.

No CSI-2 receiver can possibly handle this :-) If the camera power can't
be turned on only after the CSI-2 receiver is started (as obviously the
camera can't output a HS clock when it's not powered on), then the
receiver wouldn't be able to synchronize.

Thanks for the explanation. Could you record this in the DT bindings ?

> > > > > +	 */
> > > > > +	streamon_delay = (u64)alvium->streamon_delay;
> > > > > +
> > > > > +	ret = alvium_i2c_write_reg_hshake(alvium,
> > > > > +				  alvium->bcrm_addr +
> > > > > +				  REG_BCRM_STREAM_ON_DELAY_32RW,
> > > > > +				  4, streamon_delay);
> > > > > +	if (ret) {
> > > > > +		dev_err(dev, "Fail to set streamon delay reg\n");
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	return 0;
> > > > > +}

[snip]

-- 
Regards,

Laurent Pinchart
