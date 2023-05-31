Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61F17185CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjEaPMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjEaPMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:12:07 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7118098;
        Wed, 31 May 2023 08:12:05 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96f6e83e12fso913778366b.1;
        Wed, 31 May 2023 08:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685545924; x=1688137924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CTdqRfLBom0cidYn3F0sDgflNgidjQs82LcMLkG63oA=;
        b=mp3O5SwAMoTG8QIWgtemb6F4C8xQLUJLgAyqCqJz/21oGuogKNwc9KQF89dYNXXmjd
         EwffKmoK+NDyQUN/jDFLyw/LRle6oUT/k6k62WpXodhHmdxC9930i13BCcUm2iG8ZsIM
         6KleqaC4hTew1MXaLS8ioU8+dE87e3D1Tr/+iAwpDsQx14vJ/r20Je4sIuwomYE7gZ/Z
         4Z8mIx/TGYmDSUkfb1lQrGtDIYnkmEG1BuSsMpfA6Z/zpquB9rpam6NcexTJn0Hea2M6
         k/mc7Fr4BoSX/AYVlZiugyKtzq4FQ0IxfpK7BmIPumK7CBa6RQXf5DzWzDSP/lj36Llj
         VRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685545924; x=1688137924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTdqRfLBom0cidYn3F0sDgflNgidjQs82LcMLkG63oA=;
        b=RBwCJpIowGyH5bzdN43BIUjmayzgXjbVfyIN2CQy81f2Ym0erXAejzYy1H5QotWUkt
         EQwgbNnVUPQsA4mqZ5TQukCt635yEcRDTR+SeW6sWDIV6bt7H+hdRSJsKaHnkx46srYK
         NphFzCXNw1fPv6fgHagfJy8mnjDWvr5z5iU28jCBPPPVFNUWSOcWJ0dE1mVvUIJDHyYu
         /KFaGQX/GDY66Sy4eQV+yD55PwoPKdMw9tZhoVWIvE5LbAvKvN0YmHTxbXPgJa32Ltc6
         HxZmVPrP2H31VtLj5DZm6UdVtQlkOrL0J3tVmlN9VnqNCwpyHIrY6ps40OgXIaJ710fR
         nEOg==
X-Gm-Message-State: AC+VfDzCUYSDRE95wvAtOHeTy5KQkrFhnsZVsxvWTV1DqAdP8YIfDhkw
        PkaSZ8TU65i5Hqw3jSS1hjQ=
X-Google-Smtp-Source: ACHHUZ6aUH6UzSTlpXEEehKVx1V3F2dZR4bkO9Ka3oqswdSuLbRI1YyN2K4Po9Rfzo2zyP3kQLErgg==
X-Received: by 2002:a17:907:3f05:b0:974:1eeb:1ab8 with SMTP id hq5-20020a1709073f0500b009741eeb1ab8mr5802241ejc.13.1685545923650;
        Wed, 31 May 2023 08:12:03 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090603c700b0096a68648329sm9077568eja.214.2023.05.31.08.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 08:12:03 -0700 (PDT)
Date:   Wed, 31 May 2023 17:12:00 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Message-ID: <ZHdjwAnAlgb6c2dN@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230526173955.797226-1-tomm.merciai@gmail.com>
 <20230526173955.797226-3-tomm.merciai@gmail.com>
 <20230529074018.GD25984@pendragon.ideasonboard.com>
 <ZHcd09f5wOKjQdHX@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20230531113331.GC27043@pendragon.ideasonboard.com>
 <ZHdXV4SPOW0dxtcG@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20230531144258.GB24749@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531144258.GB24749@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Wed, May 31, 2023 at 05:42:58PM +0300, Laurent Pinchart wrote:
> Hi Tommaso,
> 
> On Wed, May 31, 2023 at 04:19:03PM +0200, Tommaso Merciai wrote:
> > On Wed, May 31, 2023 at 02:33:31PM +0300, Laurent Pinchart wrote:
> > > On Wed, May 31, 2023 at 12:13:39PM +0200, Tommaso Merciai wrote:
> > > > On Mon, May 29, 2023 at 10:40:18AM +0300, Laurent Pinchart wrote:
> > > > > On Fri, May 26, 2023 at 07:39:44PM +0200, Tommaso Merciai wrote:
> > > > > > The Alvium camera is shipped with sensor + isp in the same housing.
> > > > > 
> > > > > What ISP is that ?
> > > > 
> > > > The isp comes from Allied Vision, is called Alvium and is part of the camera.
> > > > In real is a vision processor, this offers more functionality then an isp can do.
> > > > It is not sold separately but is an integrated part of the camera itself
> > > > which also takes care of the sensor abstraction.
> > > > 
> > > > > > The camera can be equipped with one out of various sensor and abstract
> > > > > > the user from this. Camera is connected via MIPI CSI-2.
> > > > > > 
> > > > > > Most of the sensor's features are supported, with the main exception
> > > > > > being fw update.
> > > > > 
> > > > > I assume you mean "camera module features" here, as firmware update
> > > > > isn't a camera sensor feature.
> > > > 
> > > > Yep.
> > > > 
> > > > > > The driver provides all mandatory, optional and recommended V4L2 controls
> > > > > > for maximum compatibility with libcamera
> > > > > > 
> > > > > > References:
> > > > > >  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> > > > > 
> > > > > I'll do a partial review only as the patch is large, and will try to
> > > > > review the rest in v2.
> > > > 
> > > > No problem.
> > > > 
> > > > > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > > > > ---
> > > > > >  drivers/media/i2c/Kconfig  |    9 +
> > > > > >  drivers/media/i2c/Makefile |    1 +
> > > > > >  drivers/media/i2c/alvium.c | 3547 ++++++++++++++++++++++++++++++++++++
> > > > > >  drivers/media/i2c/alvium.h |  500 +++++
> > > > > >  4 files changed, 4057 insertions(+)
> > > > > >  create mode 100644 drivers/media/i2c/alvium.c
> > > > > >  create mode 100644 drivers/media/i2c/alvium.h
> 
> [snip]
> 
> > > > > > diff --git a/drivers/media/i2c/alvium.c b/drivers/media/i2c/alvium.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..e77fb6bda64b
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/media/i2c/alvium.c
> > > > > > @@ -0,0 +1,3547 @@
> 
> [snip]
> 
> > > > > > +static int alvium_set_streamon_delay(struct alvium_dev *alvium)
> > > > > > +{
> > > > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > > > +	int ret;
> > > > > > +	u64 streamon_delay;
> > > > > > +
> > > > > > +	if (!alvium->bcrm_addr)
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * CSI2 receivers sometimes need some delay before are ready to
> > > > > > +	 * get data. This register set delay before camera start
> > > > > > +	 * capturing frames in us.
> > > > > 
> > > > > If the CSI-2 receiver needs a delay, it should be handled by the CSI-2
> > > > > receiver driver, not here.
> > > > 
> > > > My bad, bad description/bad name.
> > > > 
> > > > This regs is an optional delay that alvium introduces between switching
> > > > from lp to hs mode.
> > > > Some mipi receivers require this delay on the sender side.
> > > > 
> > > > I plan to switch to the following name: alliedvision,lp2hs-delay-us
> > > > and fix the comment with the above comment^
> > > > 
> > > > This is more clear, what do you think about?
> > > 
> > > It's a bit clearer, but still not fully :-) Does this delay correspond
> > > to one of the MIPI D-PHY timing parameters ? If so, which one ?
> > 
> > Thanks to Martin Hecht I'm able to provide you a clearer description:
> > 
> > Alvium normally delivers a continous clock even when it is not streaming.
> 
> That's an interesting design choice.
> 
> > The purpose of this reg is force a DPhy reset for the period described by
> > the us on the reg before it starts streaming. To be clear, with that value
> > bigger than 0 the Alvium forces a dphy-reset on all lanes for that period.
> > That means all lanes go up into low power state.
> > This may help a csi2 rx ip to reset if that IP can't deal with a continous clock.
> 
> No CSI-2 receiver can possibly handle this :-) If the camera power can't
> be turned on only after the CSI-2 receiver is started (as obviously the
> camera can't output a HS clock when it's not powered on), then the
> receiver wouldn't be able to synchronize.
> 
> Thanks for the explanation. Could you record this in the DT bindings ?

Ofc, Thanks!

Regards,
Tommaso

> 
> > > > > > +	 */
> > > > > > +	streamon_delay = (u64)alvium->streamon_delay;
> > > > > > +
> > > > > > +	ret = alvium_i2c_write_reg_hshake(alvium,
> > > > > > +				  alvium->bcrm_addr +
> > > > > > +				  REG_BCRM_STREAM_ON_DELAY_32RW,
> > > > > > +				  4, streamon_delay);
> > > > > > +	if (ret) {
> > > > > > +		dev_err(dev, "Fail to set streamon delay reg\n");
> > > > > > +		return ret;
> > > > > > +	}
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> 
> [snip]
> 
> -- 
> Regards,
> 
> Laurent Pinchart
