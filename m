Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211A1678A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjAWWJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjAWWJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:09:12 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA67FF0A;
        Mon, 23 Jan 2023 14:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=u5mEA9fTKwHUW5DRXPq23i4R949KNCYG4QT28VraxFs=; b=ObgYyqvjX+VdUY24KCHfpSwHSG
        x8294RODKpUEleuF5CBDx9tFXbxucymMJ+0SQpvHOHtOaV9SLU/4avAk8hffp5CWC6DN291im6wTE
        pfRgr02PcLg3rm2kUIzSdR5cJfAH44I14WNLX2W6xO3KG2oq0fLffeA5IRK0NJU8UXjg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41510 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pK4yS-0005qP-1g; Mon, 23 Jan 2023 17:07:33 -0500
Date:   Mon, 23 Jan 2023 17:07:31 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Bruno Thomsen <bruno.thomsen@gmail.com>, a.zummo@towertech.it,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230123170731.6064430c50f5fb7b484d8734@hugovil.com>
In-Reply-To: <Y8rDtWEoepkd1D1u@mail.local>
References: <20221215150214.1109074-1-hugo@hugovil.com>
        <20221215150214.1109074-10-hugo@hugovil.com>
        <CAH+2xPDpdDZzE7z-caaVV53fy+RQCcYweNyYFu133YOyao2e6A@mail.gmail.com>
        <Y8rDtWEoepkd1D1u@mail.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 09/14] rtc: pcf2127: set PWRMNG value for PCF2131
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 17:39:17 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Hello,
> 
> On 07/01/2023 19:36:06+0100, Bruno Thomsen wrote:
> > Den tor. 15. dec. 2022 kl. 16.19 skrev Hugo Villeneuve <hugo@hugovil.com>:
> > >
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > >
> > > Default PWRMNG[2:0] bits are set to 000b for PCF2127/29, but to
> > > 111b for PCF2131.
> > >
> > > Set these bits to 000b to select same mode as PCF2127/29.
> > >
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> > 
> > I think it's a good idea[1] but there have been concerns about
> > setting default values in the past[2]. In case somebody needs
> > a different behaviour they should add a device tree property.
> > 
> > [1] https://lore.kernel.org/linux-rtc/20190910143945.9364-1-bruno.thomsen@gmail.com/
> > [2] https://lore.kernel.org/linux-rtc/20191211163354.GC1463890@piout.net/
> 
> I confirm this is still my point of view and I won't take this patch as
> this may break existing users.

Patch dropped.

 
> > 
> > > ---
> > >  drivers/rtc/rtc-pcf2127.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > > index 68af4d0438b8..241189ee4a05 100644
> > > --- a/drivers/rtc/rtc-pcf2127.c
> > > +++ b/drivers/rtc/rtc-pcf2127.c
> > > @@ -53,6 +53,7 @@
> > >  #define PCF2127_BIT_CTRL3_BLF                  BIT(2)
> > >  #define PCF2127_BIT_CTRL3_BF                   BIT(3)
> > >  #define PCF2127_BIT_CTRL3_BTSE                 BIT(4)
> > > +#define PCF2127_CTRL3_PWRMNG_MASK              GENMASK(7, 5)
> > >  /* Control register 4 */
> > >  #define PCF2131_REG_CTRL4              0x03
> > >  #define PCF2131_BIT_CTRL4_TSF4                 BIT(4)
> > > @@ -1129,6 +1130,20 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> > >         regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
> > >                                 PCF2127_BIT_CTRL1_POR_OVRD);
> > >
> > > +       /* Make sure PWRMNG[2:0] is set to 000b. This is the default for
> > > +        * PCF2127/29, but not for PCF2131 (default of 111b).
> > > +        *
> > > +        * PWRMNG[2:0]  = 000b:
> > > +        *   battery switch-over function is enabled in standard mode;
> > > +        *   battery low detection function is enabled
> > > +        */
> > > +       ret = regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL3,
> > > +                               PCF2127_CTRL3_PWRMNG_MASK);
> > > +       if (ret < 0) {
> > > +               dev_err(dev, "PWRMNG config failed\n");
> > > +               return ret;
> > > +       }
> > > +
> > >         ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_clkout, &val);
> > >         if (ret < 0)
> > >                 return ret;
> > > --
> > > 2.30.2
> > >
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
