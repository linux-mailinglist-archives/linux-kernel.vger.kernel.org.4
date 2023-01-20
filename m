Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C362675A27
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjATQjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjATQjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:39:23 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AD94699;
        Fri, 20 Jan 2023 08:39:20 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1AE58FF809;
        Fri, 20 Jan 2023 16:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674232759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RTcqpcvjSuMhMocjoOJ/438aoJ+MVvQH8jGg8nUJVFs=;
        b=UgsGEBFradR2vJ/uKQZyFKy1n+VNMKyvJZRXJqKyf3d7Njiz/zvui1+dBOQYGl5fM6mAN/
        2CD9WCo5y8OYzN/4Yzn6kCtKs4oRdouV2/up6CLL0CD9up7v3OJDFcBId9T2ilf7jtsp4J
        7/FfC9xL0AJbVJtZnQmYcStq16Si0gSijHaepuRGbP0eLiaJst+3ftZylEuEhmmQ/ykO8x
        +C3Oyy8EDrdNvZS202w/pB7SlZbDroPwH978z7DJfrtiK7nZJ53A2XstOvnM0A0H9MpSH8
        S5vEH2DVT2RgUC+mxc4PSCu9zCBW0xM8+lgeg/2lsf3v3kkVuxqLE6eSHhlH2Q==
Date:   Fri, 20 Jan 2023 17:39:17 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     Hugo Villeneuve <hugo@hugovil.com>, a.zummo@towertech.it,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 09/14] rtc: pcf2127: set PWRMNG value for PCF2131
Message-ID: <Y8rDtWEoepkd1D1u@mail.local>
References: <20221215150214.1109074-1-hugo@hugovil.com>
 <20221215150214.1109074-10-hugo@hugovil.com>
 <CAH+2xPDpdDZzE7z-caaVV53fy+RQCcYweNyYFu133YOyao2e6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+2xPDpdDZzE7z-caaVV53fy+RQCcYweNyYFu133YOyao2e6A@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 07/01/2023 19:36:06+0100, Bruno Thomsen wrote:
> Den tor. 15. dec. 2022 kl. 16.19 skrev Hugo Villeneuve <hugo@hugovil.com>:
> >
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Default PWRMNG[2:0] bits are set to 000b for PCF2127/29, but to
> > 111b for PCF2131.
> >
> > Set these bits to 000b to select same mode as PCF2127/29.
> >
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> 
> I think it's a good idea[1] but there have been concerns about
> setting default values in the past[2]. In case somebody needs
> a different behaviour they should add a device tree property.
> 
> [1] https://lore.kernel.org/linux-rtc/20190910143945.9364-1-bruno.thomsen@gmail.com/
> [2] https://lore.kernel.org/linux-rtc/20191211163354.GC1463890@piout.net/

I confirm this is still my point of view and I won't take this patch as
this may break existing users.

> 
> > ---
> >  drivers/rtc/rtc-pcf2127.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > index 68af4d0438b8..241189ee4a05 100644
> > --- a/drivers/rtc/rtc-pcf2127.c
> > +++ b/drivers/rtc/rtc-pcf2127.c
> > @@ -53,6 +53,7 @@
> >  #define PCF2127_BIT_CTRL3_BLF                  BIT(2)
> >  #define PCF2127_BIT_CTRL3_BF                   BIT(3)
> >  #define PCF2127_BIT_CTRL3_BTSE                 BIT(4)
> > +#define PCF2127_CTRL3_PWRMNG_MASK              GENMASK(7, 5)
> >  /* Control register 4 */
> >  #define PCF2131_REG_CTRL4              0x03
> >  #define PCF2131_BIT_CTRL4_TSF4                 BIT(4)
> > @@ -1129,6 +1130,20 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> >         regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
> >                                 PCF2127_BIT_CTRL1_POR_OVRD);
> >
> > +       /* Make sure PWRMNG[2:0] is set to 000b. This is the default for
> > +        * PCF2127/29, but not for PCF2131 (default of 111b).
> > +        *
> > +        * PWRMNG[2:0]  = 000b:
> > +        *   battery switch-over function is enabled in standard mode;
> > +        *   battery low detection function is enabled
> > +        */
> > +       ret = regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL3,
> > +                               PCF2127_CTRL3_PWRMNG_MASK);
> > +       if (ret < 0) {
> > +               dev_err(dev, "PWRMNG config failed\n");
> > +               return ret;
> > +       }
> > +
> >         ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_clkout, &val);
> >         if (ret < 0)
> >                 return ret;
> > --
> > 2.30.2
> >

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
