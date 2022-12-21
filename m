Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB97652E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiLUIn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLUIn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:43:56 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8793A18E17;
        Wed, 21 Dec 2022 00:43:52 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 4FE021BF203;
        Wed, 21 Dec 2022 08:43:47 +0000 (UTC)
Date:   Wed, 21 Dec 2022 09:43:47 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Shravan.Chippa@microchip.com
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/5] media: i2c: imx334: modify link frequency as for
 the configureation
Message-ID: <20221221084347.3d4f73txlcgiisvz@uno.localdomain>
References: <20221219061526.3169369-1-shravan.chippa@microchip.com>
 <20221219061526.3169369-2-shravan.chippa@microchip.com>
 <20221219144414.lfusj67ojjk2phkv@uno.localdomain>
 <PH0PR11MB5611CA9634C1A7A66434703C81EA9@PH0PR11MB5611.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5611CA9634C1A7A66434703C81EA9@PH0PR11MB5611.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan

On Tue, Dec 20, 2022 at 11:11:15AM +0000, Shravan.Chippa@microchip.com wrote:
>
>
> > -----Original Message-----
> > From: Jacopo Mondi <jacopo@jmondi.org>
> > Sent: 19 December 2022 08:14 PM
> > To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> > Cc: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> > mchehab@kernel.org; linux-media@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v7 1/5] media: i2c: imx334: modify link frequency as for
> > the configureation
> >
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> > content is safe
> >
> > Hi Shravan
> >
> > On Mon, Dec 19, 2022 at 11:45:22AM +0530, shravan kumar wrote:
> > > From: Shravan Chippa <shravan.chippa@microchip.com>
> > >
> > > Currently imx334 sensor driver is configured for 1782Mbps/lane for
> > > 3840x2160@60 resolution with reqired reg mode values but if we run the
> > > command "v4l2-ctl --all -d /dev/v4l-subdevX" it is showing incorrect
> > > link frequeny, This is because of the incorrect value of
> > > IMX334_LINK_FREQ witch is 891000000. it should be 1782000000.
> > >
> > > In general with the value of 891000000 link frequency it is not
> > > possible to configure 3840x2160@60 resolution.
> > >
> > > Fixes: 9746b11715c3 ("media: i2c: Add imx334 camera sensor driver")
> > >
> > > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> > > ---
> > >  drivers/media/i2c/imx334.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
> > > index 7b0a9086447d..acc9f9f15e47 100644
> > > --- a/drivers/media/i2c/imx334.c
> > > +++ b/drivers/media/i2c/imx334.c
> > > @@ -49,7 +49,7 @@
> > >  #define IMX334_INCLK_RATE    24000000
> > >
> > >  /* CSI2 HW configuration */
> > > -#define IMX334_LINK_FREQ     891000000
> > > +#define IMX334_LINK_FREQ     1782000000
> >
> > Is this your reasoning ?
> >
> > width: 3840
> > hblank: 560
> > height: 2160
> > vblank: 2340
> > bpp: 12
> > fps: 60
> > lanes: 4
> >
> > Total bandwidth: (3840 + 560) * (2160 + 2340) * 60 * 12 = 14.256.000.000
> > Bandwidth per lane = Total / 4 = 3.564.000.000 mipi clock =
> > Bandwidth_per_lane / 2 = 1.782.000.000
> >
> > Two questions:
> >
> > - Should you update the pixel clock as well ? It is currently set to
> >   594000000 while as per the above reasoning it should be doubled too.
> >
> > - Where is the sensor's clock tree programmed in the driver ?
> >   It's kind of weird that the pixel_clock and link_freq in the driver
> >   are half of what they theoretically should be...
> >
> >
> As per my understanding.
> the mode_3840x2160_regs[] array value which is written through the i2c bus is 4k resolution, 60fps,  link frequency 1782Mbps per lane
> but the vblank value is dynamic from user space.
> Min-90 to Max-130000, default value is 2340. With the default value, we will get 30fps.

Ah, it's 30, not 60. So my calculations above should be halved

>
> if we set vblank value from user space it will change FPS.
>

Sure, but the link frequency stays the same, and it should be computed
with the FPS resulting from the current blankings

> Total bandwidth: (3840 + 560) * (2160 + 2340) * 30 * 12 = 7.128.000.000

Correct

> Bandwidth per lane = Total / 4 = 1.782.000.000

Correct.

But with CID_LINK_FREQ you're reporting the bus link frequency, not
the lane bandwidth. As MIPI CSI-2 uses DDR read mode, two bits per
clock cycle are transmitted, hence the bus frequency is half of the lane
bandwidth.

TL;DR you don't need this patch, the current value is correct as it is in my
understanding.

Thanks
  j

>
> Thanks,
> Shravan
>
> >
> > >  #define IMX334_NUM_DATA_LANES        4
> > >
> > >  #define IMX334_REG_MIN               0x00
> > > --
> > > 2.34.1
> > >
