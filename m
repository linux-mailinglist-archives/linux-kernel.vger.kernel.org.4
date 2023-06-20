Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C747369F3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjFTKxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjFTKxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:53:41 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44323101;
        Tue, 20 Jun 2023 03:53:40 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A466410FE;
        Tue, 20 Jun 2023 12:53:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687258382;
        bh=I0BPPwNAumQeRerMbaf7O4uwBZloklDsd4XDwA4fhfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pSx9rsaKGPU1EbVfBTj4Jwl+hOYM1P1TnYSte1zICAPOceh0pwj6Xiu5i3wFF7H1J
         wkkMi7pUsD6JBPHZrjJGrWFQjaTiHnpWPNfP6tm2C2XZ+X/H/wfTRQyIeOkJwII4LZ
         o5kU72xzOwnIzdVZmex2mtvoWRJtNufcvy/cr540=
Date:   Tue, 20 Jun 2023 13:53:35 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        jacopo.mondi@ideasonboard.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Shawn Tu <shawnx.tu@intel.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v5 3/3] media: i2c: Add support for alvium camera
Message-ID: <20230620105335.GC26467@pendragon.ideasonboard.com>
References: <20230608083127.545750-1-tomm.merciai@gmail.com>
 <20230608083127.545750-4-tomm.merciai@gmail.com>
 <ZILuNrA9cMaI9ihP@kekkonen.localdomain>
 <ZIMklWtBW8fx/Ddd@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <ZJAy4vRxI9uEUwQj@kekkonen.localdomain>
 <20230619142458.GE10462@pendragon.ideasonboard.com>
 <ZJExEwhVK+8IVaB8@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20230620094328.GA26467@pendragon.ideasonboard.com>
 <ZJGB7vkJpxd3JrSh@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJGB7vkJpxd3JrSh@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
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

On Tue, Jun 20, 2023 at 12:39:42PM +0200, Tommaso Merciai wrote:
> On Tue, Jun 20, 2023 at 12:43:28PM +0300, Laurent Pinchart wrote:
> > On Tue, Jun 20, 2023 at 06:54:43AM +0200, Tommaso Merciai wrote:
> > > On Mon, Jun 19, 2023 at 05:24:58PM +0300, Laurent Pinchart wrote:
> > > > On Mon, Jun 19, 2023 at 10:50:10AM +0000, Sakari Ailus wrote:
> > > > > On Fri, Jun 09, 2023 at 03:09:41PM +0200, Tommaso Merciai wrote:
> > > > > > On Fri, Jun 09, 2023 at 09:17:42AM +0000, Sakari Ailus wrote:
> > > > > > > On Thu, Jun 08, 2023 at 10:31:16AM +0200, Tommaso Merciai wrote:
> > > > > > > > The Alvium camera is shipped with sensor + isp in the same housing.
> > > > > > > > The camera can be equipped with one out of various sensor and abstract
> > > > > > > > the user from this. Camera is connected via MIPI CSI-2.
> > > > > > > > 
> > > > > > > > Most of the camera module features are supported, with the main exception
> > > > > > > > being fw update.
> > > > > > > > 
> > > > > > > > The driver provides all mandatory, optional and recommended V4L2 controls
> > > > > > > > for maximum compatibility with libcamera
> > > > > > > > 
> > > > > > > > References:
> > > > > > > >  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> > > > > > > > 
> > > > > > > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > > > > > > ---
> > > > > > > > Changes since v2:
> > > > > > > >  - Removed gpios/clock handling as suggested by LPinchart
> > > > > > > >  - Added vcc-ext-in supply support as suggested by LPinchart
> > > > > > > >  - Fixed alvium_setup_mipi_fmt funct as suggested by CJAILLET
> > > > > > > >  - Removed upside_down/hshake_bit priv data as suggested by CJAILLET
> > > > > > > >  - Fixed commit body as suggested by LPinchart
> > > > > > > >  - Mv alvium_set_streamon_delay to yalvium_set_lp2hs_delay
> > > > > > > >  - Fixed comment on lp2hs prop as suggested by LPinchart
> > > > > > > >  - Added pm resume/suspend functs as suggested by LPinchart
> > > > > > > >  - Dropped alvium_link_setup/alvium_s_power as suggested by LPinchart
> > > > > > > >  - Fixed regs defines as suggested by LPinchart
> > > > > > > >  - Fixed typedef as suggested by LPinchart
> > > > > > > >  - Dropped bcrm_v/fw_v from priv data as suggested by LPinchart
> > > > > > > >  - Now driver use the subdev active state to store the active format and crop
> > > > > > > >    as suggested by LPinchart
> > > > > > > >  - Dropped alvium_is_csi2/i2c_to_alvium as suggested by LPinchart
> > > > > > > > 
> > > > > > > > Changes since v3:
> > > > > > > >  - Fixed warnings Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > > 
> > > > > > > > Changes since v4:
> > > > > > > >  - Removed print into alvium_get_dt_data for alliedvision,lp2hs-delay-us as
> > > > > > > >    suggested by CDooley
> > > > > > > > 
> > > > > > > >  drivers/media/i2c/Kconfig       |   10 +
> > > > > > > >  drivers/media/i2c/Makefile      |    1 +
> > > > > > > >  drivers/media/i2c/alvium-csi2.c | 3479 +++++++++++++++++++++++++++++++
> > > > > > > >  drivers/media/i2c/alvium-csi2.h |  485 +++++
> > > > > > > >  4 files changed, 3975 insertions(+)
> > > > > > > >  create mode 100644 drivers/media/i2c/alvium-csi2.c
> > > > > > > >  create mode 100644 drivers/media/i2c/alvium-csi2.h
> > > > 
> > > > [snip]
> > > > 
> > > > > > > > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..52c9263075cf
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/drivers/media/i2c/alvium-csi2.c
> > > > > > > > @@ -0,0 +1,3479 @@
> > > > 
> > > > [snip]
> > > > 
> > > > > > > > +static int alvium_get_img_width_params(struct alvium_dev *alvium)
> > > > > > > > +{
> > > > > > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > > > > > +	int ret;
> > > > > > > > +	u64 val;
> > > > > > > > +
> > > > > > > > +	if (!alvium->bcrm_addr)
> > > > > > > > +		return -EINVAL;
> > > > > > > > +
> > > > > > > > +	ret = alvium_read(alvium,
> > > > > > > > +			  REG_BCRM_IMG_WIDTH_MIN_R,
> > > > > > > > +			  &val);
> > > > > > > > +	if (ret) {
> > > > > > > > +		dev_err(dev, "Fail to read img min width reg\n");
> > > > > > > > +		return ret;
> > > > > > > > +	}
> > > > > > > 
> > > > > > > Could you add a macro that assigns the value to the variable (or a struct
> > > > > > > field in this case) when the read is successful? Add the print if you think
> > > > > > > you need it.
> > > > > > 
> > > > > > I don't get this comment.
> > > > > > Can you explain me better your plan please.
> > > > > 
> > > > > You have exactly the same pattern repeated over and over in a number of
> > > > > functions. I'd like you to add a macro (or a function) that takes what
> > > > > varies as arguments, and call that function here. It would reduce a lot of
> > > > > the repeated lines code here.
> > > > > 
> > > > > ...
> > > > 
> > > > The best option is to print an error message in alvium_read() and drop
> > > > all error messages from the callers.
> > > 
> > > What about don't print anything? We already have prints that comes from
> > > CCI API if some errors occurs. Laurent suggest me this into some
> > > previous comments. Let me know.
> > 
> > We need to print something somewhere as silent failures are bad. The
> > messages printed by the CCI helpers are good enough, so no need to print
> > anything specific in the alvium driver.
> 
> Oooks I'll follow your way on v7, thanks Laurent.
> My plan is to switch to the following implementation:
> 
> 
> static int alvium_get_img_width_params(struct alvium_dev *alvium)
> {
> 	struct device *dev = &alvium->i2c_client->dev;
> 	u64 val;
> 	int ret = 0;
> 
> 	if (!alvium->bcrm_addr)
> 		return -EINVAL;
> 
> 	alvium_read(alvium, REG_BCRM_IMG_WIDTH_MIN_R, &val, &ret);
> 	alvium->img_min_width = val;
> 	dev_dbg(dev, "Min img width: %d\n", alvium->img_min_width);
> 
> 	alvium_read(alvium, REG_BCRM_IMG_WIDTH_MAX_R, &val, NULL);

I assume you mean &ret and not NULL here.

> 	alvium->img_max_width = val;
> 	dev_dbg(dev, "Max img width: %d\n", alvium->img_max_width);
> 
> 	alvium_read(alvium, REG_BCRM_IMG_WIDTH_INC_R, &val, &ret);
> 	alvium->img_inc_width = val;
> 	dev_dbg(dev, "img width increment: %d px\n", alvium->img_inc_width);
> 
> 	return ret;
> }
> 
> Like you suggest. :)
> What do you think about?

I would probably drop the debug messages, or at least group them all in
a single message at the end of the function to print all three values.
You should also not print the values if an error occurs during the
reads, as they will be undefined.

In general, while debug messages are useful, they should be used with
parcimony. Printing every single parameter passed by userspace, or
adding a debug message at the beginning of every function, would make
the kernel log very noisy and doesn't bring that much value.

-- 
Regards,

Laurent Pinchart
