Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713B65BCD9F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiISNtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiISNtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:49:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3CF2DAA3;
        Mon, 19 Sep 2022 06:49:23 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3E06D9BA;
        Mon, 19 Sep 2022 15:49:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663595360;
        bh=N1LVG0MXObEOzn3wAb8ucps7CX6MhaStUY9Gll/LMYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZrZP6r3x5Ai0F1Y3DZPRAorq0kuyTi7Kphb86o1+MgIxakQCZFkLY35TYczLuZbcX
         JnTDMYDaja2NkwTvQsJfcqLsa7wdr39DLxlbkXjG+trokP2E+JZxQBt41t3wJ21zin
         5WcZ4H3K9RFp1OXDokRGtuVubRBWxyZibbHd77JI=
Date:   Mon, 19 Sep 2022 16:49:06 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>, Jimmy Su <jimmy.su@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Arec Kao <arec.kao@intel.com>,
        Marek Vasut <marex@denx.de>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add Omnivision OV4689 image sensor driver
Message-ID: <YyhzUvu0Ky8+VohC@pendragon.ideasonboard.com>
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <CAPY8ntCA3jbpBOiNfoft58sHPeTFSLoLop0VUmkOCWP3cX_rdw@mail.gmail.com>
 <87czbwp9xx.fsf@gmail.com>
 <YygOzWAHyoP+KwTv@paasikivi.fi.intel.com>
 <87wn9zreic.fsf@gmail.com>
 <YyhE5voxRz7gEYHY@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YyhE5voxRz7gEYHY@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Sep 19, 2022 at 10:31:02AM +0000, Sakari Ailus wrote:
> On Mon, Sep 19, 2022 at 10:01:06AM +0300, Mikhail Rudenko wrote:
> > On 2022-09-19 at 06:40 GMT, Sakari Ailus wrote:
> > > On Fri, Sep 16, 2022 at 12:27:42AM +0300, Mikhail Rudenko wrote:
> > >> On 2022-09-14 at 10:58 +01, Dave Stevenson wrote:
> > >> > On Sun, 11 Sept 2022 at 21:02, Mikhail Rudenko wrote:
> > >> >>
> > >> >> Hello,
> > >> >>
> > >> >> this series implements support for Omnivision OV4689 image
> > >> >> sensor. The Omnivision OV4689 is a high performance, 1/3-inch, 4
> > >> >> megapixel image sensor. Ihis chip supports high frame rate speeds up
> > >> >> to 90 fps at 2688x1520 resolution. It is programmable through an I2C
> > >> >> interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
> > >> >> connection.
> > >> >>
> > >> >> The driver is based on Rockchip BSP kernel [1]. It implements 4-lane CSI-2
> > >> >> and single 2688x1520 @ 30 fps mode. The driver was tested on Rockchip
> > >> >> 3399-based FriendlyElec NanoPi M4 board with MCAM400 camera
> > >> >> module.
> > >> >> While porting the driver, I stumbled upon two issues:
> > 
> > [snip]
> > 
> > >> >> (2) The original driver exposes analog gain range 0x0 - 0x7ff, but the
> > >> >> gain is not linear across that range. Instead, it is piecewise linear
> > >> >> (and discontinuous). 0x0-0xff register values result in 0x-2x gain,
> > >> >> 0x100-0x1ff to 0x-4x, 0x300-0x3ff to 0x-8x, and 0x700-0x7ff to 0x-16x,
> > >> >> with more linear segments in between. Rockchip's camera engine code
> > >> >> chooses one of the above segments depenging on the desired gain
> > >> >> value. The question is, how should we proceed keeping in mind
> > >> >> libcamera use case? Should the whole 0x0-0x7ff be exposed as-is and
> > >> >> libcamera will do the mapping, or the driver will do the mapping
> > >> >> itself and expose some logical gain units not tied to the actual gain
> > >> >> register value? Meanwhile, this driver conservatively exposes only
> > >> >> 0x0-0xf8 gain register range.
> > >> >
> > >> > The datasheet linked above says "for the gain formula, please contact
> > >> > your local OmniVision FAE" :-(
> > >> > I would assume that the range is from 1x rather than 0x - people
> > >> > rarely want a totally black image that 0x would give. Or is it ranges
> > >> > of 1x - 2x, 2x - 4x, 4x - 8x, and 8x - 16x?
> > >>
> > >> A picture is worth a thousand words, so I've attached the results of my
> > >> experimentation with the gain register. They were obtained with Rockchip
> > >> 3399, with AEC, AGC and black level subtraction disabled. The image was
> > >> converted from 10-bit RGGB to 8-bit YUV 4:2:0 by the Rockchip ISP.

Is that full or limited range YUV ?

> > > Based on that it looks like their medication may have been a little too
> > > strong.
> > >
> > > Could this be implemented so that the control value would be linear linear
> > > but its range would correspond 1x--16x values?
> > >
> > > libcamera will be able to cope with that.
> > 
> > According to the following fragment of the Rockchip camera engine sensor
> > configuration file for ov4689 [1]
> > 
> >     <Linear index="1" type="double" size="[4 7]">
> >        [1 2 128 0 1 128 255
> >         2 4 64 -248 1 376 504
> >         4 8 32 -756 1 884 1012
> >         8 16 16 -1784 1 1912 2040]
> >     </Linear>,
> > 
> > it uses gain register value range 128-255 for gain 1x-2x, 376-504 for
> > gain 2x-4x, 884-1024 for 4x-8x, and 1912-2040 for 8x-16x. Do you suggest

That looks *really* weird. I would have understood [384, 511], [896,
1023] and [1920, 2047], but not those intervals.

The driver hardcodes bit 0x3503[2] to 1, which means "sensor gain
format". Maybe setting it to 0 ("real gain format") would produce saner
results ?

> > to implement this calculation in the sensor driver and expose some
> > linear "logical" gain to userspace (ranging, e.g., 128-2048 for gains
> > 1x-16x)?
> 
> Yes. This way the user space can somehow work without knowing this special
> implementation, even though the granularity changes over the range. I guess
> the granularity would need to be known in libcamera but that's a separate
> issue.

I can live with that.

-- 
Regards,

Laurent Pinchart
