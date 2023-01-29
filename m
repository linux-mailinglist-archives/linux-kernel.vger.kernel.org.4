Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D53867FF4C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 14:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjA2NGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 08:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjA2NGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 08:06:07 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9237B1E5EA;
        Sun, 29 Jan 2023 05:06:02 -0800 (PST)
Received: from ideasonboard.com (host-212-171-97-20.pool212171.interbusiness.it [212.171.97.20])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9BBFC327;
        Sun, 29 Jan 2023 14:05:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674997560;
        bh=IW7Jzg4uvMKHkGW9e8JbWz5TgBn3wz6lgFae71RROV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o9utlLVFX8KmyH0dE7hH4jz7AOV7L2AN/ZNWuK4ytns3cE86dwRcBXZUgMWmrJa8h
         sRyMxf81xzeRIMV4ZAR2WpQFlXYG1dBvro4zhhvqLWidPrW9qUCRlp2IowX4dNXD55
         Q8qAi1rId/JBGVScu8wH2DCOGvk4YoONeK7QqeCk=
Date:   Sun, 29 Jan 2023 14:05:48 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] media: i2c: ov2685: Make reset gpio optional
Message-ID: <20230129130548.bsqcnjh2lfu4bn2y@uno.localdomain>
References: <20230129-ov2685-improvements-v1-0-f281bd49399c@z3ntu.xyz>
 <20230129-ov2685-improvements-v1-1-f281bd49399c@z3ntu.xyz>
 <20230129112249.lf2vb7pthrv4nien@uno.localdomain>
 <2543677.Lt9SDvczpP@g550jk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2543677.Lt9SDvczpP@g550jk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca

On Sun, Jan 29, 2023 at 12:49:03PM +0100, Luca Weiss wrote:
> On Sonntag, 29. Jänner 2023 12:22:49 CET Jacopo Mondi wrote:
> > Hi Luca
> >
> > On Sun, Jan 29, 2023 at 10:42:35AM +0100, Luca Weiss wrote:
> > > In some setups XSHUTDOWN is connected to DOVDD when it's unused,
> > > therefore treat the reset gpio as optional.
> >
> > I don't have a datasheet for this sensor, but OV sensors usually have
> > to gpio lines to control powerdown and reset. Datasheets usually
> > suggest to hook one of the 2 to DOVDD and control the other from the
> > SoC. How is the sensor hooked up in your design ? No gpio lines is
> > controlled by the SoC ?
>
> It looks like this sensor only has XSHUTDOWN pin and no extra reset pin.
>

Ack, I see the same for OV2680 (for which I have a datasheet)

> In my setup there's the normal I2C & CSI & mclk hookups, but the supply lines
> and shutdown line are all just connected to regulator-fixed, so gpio-
> controlled on/off regulators.
>
> >
> > Another question is if we need to software-reset the sensor if no gpio
> > line is hooked up to XSHUTDOWN.
>
> The datasheet mentions it resets itself during power up (so when the supplies
> are turned on), so I don't think we need to add anything.
>

Thanks for the clarification!

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Thanks
   j


> Regards
> Luca
>
> >
> > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > ---
> > >
> > >  drivers/media/i2c/ov2685.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
> > > index a3b524f15d89..a422f4c8a2eb 100644
> > > --- a/drivers/media/i2c/ov2685.c
> > > +++ b/drivers/media/i2c/ov2685.c
> > > @@ -734,7 +734,7 @@ static int ov2685_probe(struct i2c_client *client,
> > >
> > >  	if (clk_get_rate(ov2685->xvclk) != OV2685_XVCLK_FREQ)
> > >
> > >  		dev_warn(dev, "xvclk mismatched, modes are based on
> 24MHz\n");
> > >
> > > -	ov2685->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> > > +	ov2685->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> > > GPIOD_OUT_LOW);>
> > >  	if (IS_ERR(ov2685->reset_gpio)) {
> > >
> > >  		dev_err(dev, "Failed to get reset-gpios\n");
> > >  		return -EINVAL;
> > >
> > > --
> > > 2.39.1
>
>
>
>
