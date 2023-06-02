Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBA271F7D2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjFBBZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjFBBZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:25:25 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428D5128;
        Thu,  1 Jun 2023 18:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=P+9xx+lxqjJqqH4Qc1R78OLgrho1+Lwvhwigj9XgAQo=; b=FrNHW+8tenbCqVS+f9KbjiK4YP
        nXZYdoUv4hnWhq959/PsMspnctRjUFZLwxAP72Nbs73i5uY7e7yxg7eoVapO4l4s3T/1aE0oz8yh/
        abiuFG61hhOXF3CQLGB//p8bB5hN9TYXbRU1hM87wtz8DGssv2q7fLO8juKlPM+06ihE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:46512 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q4tXX-0000RT-DK; Thu, 01 Jun 2023 21:25:16 -0400
Date:   Thu, 1 Jun 2023 21:25:14 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org
Message-Id: <20230601212514.28914aee77ae9a513904ee6b@hugovil.com>
In-Reply-To: <20230601204140.3b45c9b97efb36431d058ba7@hugovil.com>
References: <20230601201844.3739926-1-hugo@hugovil.com>
        <20230601201844.3739926-6-hugo@hugovil.com>
        <ZHkN5kEa6yqHdDeL@surfacebook>
        <20230601204140.3b45c9b97efb36431d058ba7@hugovil.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v6 5/9] serial: sc16is7xx: fix regression with GPIO
 configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 20:41:40 -0400
Hugo Villeneuve <hugo@hugovil.com> wrote:

> On Fri, 2 Jun 2023 00:30:14 +0300
> andy.shevchenko@gmail.com wrote:
> 
> > Thu, Jun 01, 2023 at 04:18:40PM -0400, Hugo Villeneuve kirjoitti:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> > > and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> > > changed the function of the GPIOs pins to act as modem control
> > > lines without any possibility of selecting GPIO function.
> > > 
> > > As a consequence, applications that depends on GPIO lines configured
> > > by default as GPIO pins no longer work as expected.
> > > 
> > > Also, the change to select modem control lines function was done only
> > > for channel A of dual UART variants (752/762). This was not documented
> > > in the log message.
> > > 
> > > Allow to specify GPIO or modem control line function in the device
> > > tree, and for each of the ports (A or B).
> > > 
> > > Do so by using the new device-tree property named
> > > "modem-control-line-ports" (property added in separate patch).
> > > 
> > > When registering GPIO chip controller, mask-out GPIO pins declared as
> > > modem control lines according to this new "modem-control-line-ports"
> > > DT property.
> > > 
> > > Boards that need to have GPIOS configured as modem control lines
> > > should add that property to their device tree. Here is a list of
> > > boards using the sc16is7xx driver in their device tree and that may
> > > need to be modified:
> > >     arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> > >     mips/boot/dts/ingenic/cu1830-neo.dts
> > >     mips/boot/dts/ingenic/cu1000-neo.dts
> > 
> > Almost good, a few remarks and if addressed as suggested,
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > 
> > Thank you!
> > 
> > ...
> > 
> > > +	if (!s->gpio_valid_mask)
> > 
> > I would use == 0, but it's up to you. Both will work equally.
> 
> Hi,
> done.
> 
> > > +		return 0;
> > 
> > ...
> > 
> > > +static int sc16is7xx_setup_mctrl_ports(struct device *dev)
> > 
> > Not sure why int if you always return an unsigned value.
> > Otherwise return an error code when it's no defined mask
> > and check it in the caller.
> 
> Changed return type to u8.
> 
>  
> > > +{
> > > +	struct sc16is7xx_port *s = dev_get_drvdata(dev);
> > > +	int i;
> > > +	int ret;
> > > +	int count;
> > > +	u32 mctrl_port[2];
> > > +	u8 mctrl_mask = 0;
> > 
> > I would return 0 directly in the first two cases and split an assignment closer
> > to the first user.
> > 
> > > +	count = device_property_count_u32(dev, "nxp,modem-control-line-ports");
> > > +	if (count < 0 || count > ARRAY_SIZE(mctrl_port))
> > > +		return mctrl_mask;
> > 
> > 		return 0;
> 
> Done.
> 
> 
> > > +	ret = device_property_read_u32_array(dev, "nxp,modem-control-line-ports",
> > > +					     mctrl_port, count);
> > > +	if (ret)
> > > +		return mctrl_mask;
> > 
> > 		return 0;
> 
> Done.
> 
> 
> > 	mctrl_mask = 0;
> 
> Done.
> 
>  
> > > +	for (i = 0; i < count; i++) {
> > > +		/* Use GPIO lines as modem control lines */
> > > +		if (mctrl_port[i] == 0)
> > > +			mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_A_BIT;
> > > +		else if (mctrl_port[i] == 1)
> > > +			mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_B_BIT;
> > > +	}
> > 
> > > +	if (!mctrl_mask)
> > > +		return mctrl_mask;
> > 
> > Maybe positive one?
> > 	if (mctrl_mask)
> > 		regmap_update_bits(...);
> 
> I used negative to save on indentation, but it also fits by converting it to positive, so done.
> 
>  
> > > +	regmap_update_bits(s->regmap,
> > > +			   SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
> > > +			   SC16IS7XX_IOCONTROL_MODEM_A_BIT |
> > > +			   SC16IS7XX_IOCONTROL_MODEM_B_BIT, mctrl_mask);
> > > +
> > > +	return mctrl_mask;
> > > +}
> > 
> > ...
> > 
> > >  	unsigned long freq = 0, *pfreq = dev_get_platdata(dev);
> > >  	unsigned int val;
> > > +	u8 mctrl_mask = 0;
> > 
> > This assignment is redundant, so you simply can define it
> > 
> > >  	u32 uartclk = 0;
> > 
> > 	u8 mctrl_mask;
> 
> Done.
> 
> I will send a V7 soon with your Reviewed-by tag.

Hi Andy,
Greg did not yet respond to my email about the proposed tags, but if the new order of the patches and the stable tags I added seems ok to you, I will resend V7. It will then probably easier for Greg to comment directly on V7 for the stable tags (Cc:).

Hugo.
