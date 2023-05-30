Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E0C716738
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjE3PhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjE3PhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:37:07 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD7CC5;
        Tue, 30 May 2023 08:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7NYITIz6db6snx2MdjRgFoeMdJ74f0BhIRWjC9Mux08=; b=SQ6vmvCfXmyQcAkV4ntcK4044j
        HWy6/JadIzeVstvBgVCgievGqOjYv6V3ZcaNoD/VFCwH8iQ5sXzBFciehla1WnBLQkVhaMGXHuR3W
        HFYfJdyJcWst7NePb+JKsnmYGLHHRe0et5XYn6AY1L+6h2QcNfLwU7TwqnH6/Yfztae0=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:39366 helo=debian-acer)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q41P0-0006ul-6l; Tue, 30 May 2023 11:36:50 -0400
Date:   Tue, 30 May 2023 11:36:49 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     andy.shevchenko@gmail.com
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230530113649.73f28b9f6ba91f17ace1e12f@hugovil.com>
In-Reply-To: <ZHUpWQafRPHW1RJQ@surfacebook>
References: <20230529140711.896830-1-hugo@hugovil.com>
        <20230529140711.896830-8-hugo@hugovil.com>
        <ZHUpWQafRPHW1RJQ@surfacebook>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v4 7/9] serial: sc16is7xx: fix regression with GPIO
 configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 01:38:17 +0300
andy.shevchenko@gmail.com wrote:

> Mon, May 29, 2023 at 10:07:09AM -0400, Hugo Villeneuve kirjoitti:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> > and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> > changed the function of the GPIOs pins to act as modem control
> > lines without any possibility of selecting GPIO function.
> > 
> > As a consequence, applications that depends on GPIO lines configured
> > by default as GPIO pins no longer work as expected.
> > 
> > Also, the change to select modem control lines function was done only
> > for channel A of dual UART variants (752/762). This was not documented
> > in the log message.
> > 
> > Allow to specify GPIO or modem control line function in the device
> > tree, and for each of the ports (A or B).
> > 
> > Do so by using the new device-tree property named
> > "modem-control-line-ports" (property added in separate patch).
> > 
> > When registering GPIO chip controller, mask-out GPIO pins declared as
> > modem control lines according to this new "modem-control-line-ports"
> > DT property.
> > 
> > Boards that need to have GPIOS configured as modem control lines
> > should add that property to their device tree. Here is a list of
> > boards using the sc16is7xx driver in their device tree and that may
> > need to be modified:
> >     arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> >     mips/boot/dts/ingenic/cu1830-neo.dts
> >     mips/boot/dts/ingenic/cu1000-neo.dts
> 
> ...
> 
> > Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> > Fixes: 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> 
> Don't forget to refer to the dependency patches form this series.
> (I forgot how it should be done, IIRC the documentation about stable kernel
> patches can shed a light on this.)

Hi,
I will look into it.


> ...
> 
> > +	switch (mctrl_mask) {
> > +	case 0:
> > +		s->gpio_valid_mask = 0xFF;
> 
> GENMASK()
> 
> > +		break;
> > +	case SC16IS7XX_IOCONTROL_MODEM_A_BIT:
> > +		s->gpio_valid_mask = 0x0F;
> 
> GENMASK()
> 
> > +		break;
> > +	case SC16IS7XX_IOCONTROL_MODEM_B_BIT:
> > +		s->gpio_valid_mask = 0xF0;
> 
> GENMASK()

Ok done, altough even if in general I like the bit manipulation macros because they make the code easier to read/understand, I find it less obvious by using GENMASK in this case IMMO.


> > +		break;
> > +	default:
> > +		break;
> > +	}
> 
> ...
> 
> > +		of_property_for_each_u32(dev->of_node, "nxp,modem-control-line-ports",
> > +					 prop, p, u) {
> > +			if (u >= devtype->nr_uart)
> > +				continue;
> > +
> > +			/* Use GPIO lines as modem control lines */
> > +			if (u == 0)
> > +				mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_A_BIT;
> > +			else if (u == 1)
> > +				mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_B_BIT;
> > +		}
> 
> Can we use device properties, please?

I have converted this section to use device_property_count_u32() and device_property_read_u32_array(). Is that Ok?

> If you think about backporting to the earlier kernels (w/o properties in use in
> this driver), perhaps an additional followup for that?

I am not sure what you mean by this?
