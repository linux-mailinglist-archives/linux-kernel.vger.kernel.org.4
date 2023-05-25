Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832F0710EFF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241401AbjEYPDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241195AbjEYPDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:03:07 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA1F18D;
        Thu, 25 May 2023 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3aiLXOZs4J8vLwjD9tm8yL///nMM3TFDYH2UjhnUtjA=; b=yeV6kVRGXgdBBkEgy9EOOpxSPe
        U+QULcnfTnUjO3ghZ8C1PF3MJEiRYw5xoR6uAGepJbiMXyepzp3VmSQ1+yf8OaWb1D1a6PgUQ5mpf
        /5yqRdQm0EjfJxAneB/r2NOmoT8qBmUbFNcT3d757NHI6MdUUeZW57U409ER6ThVHIv4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52768 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q2CUR-0000BG-UZ; Thu, 25 May 2023 11:02:56 -0400
Date:   Thu, 25 May 2023 11:02:55 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     andy.shevchenko@gmail.com
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230525110255.6ffe0a0c3f88ae03c3fc5f25@hugovil.com>
In-Reply-To: <ZG9EWEwb077qyBIi@surfacebook>
References: <20230525040324.3773741-1-hugo@hugovil.com>
        <20230525040324.3773741-9-hugo@hugovil.com>
        <ZG9EWEwb077qyBIi@surfacebook>
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
Subject: Re: [PATCH v3 08/11] serial: sc16is7xx: fix regression with GPIO
 configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 14:19:52 +0300
andy.shevchenko@gmail.com wrote:

> Thu, May 25, 2023 at 12:03:22AM -0400, Hugo Villeneuve kirjoitti:
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
> 
> > This new patch allows to specify GPIO or modem control line function
> > in the device tree, and for each of the ports (A or B).
> 
> Imperative mood as stated in documentation, please.
> Like "Allow to specify...".
> 
> > This is done by using the new device-tree property named
> > "modem-control-line-ports" (property added in separate patch).
> > 
> > We also now reduce the number of exported GPIOs according to the
> > modem-status-line-port DT property.

Just noticed a mistake:
s/modem-status-line-port/modem-control-line-ports

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
> > +#ifdef CONFIG_GPIOLIB
> 
> I'm wondering if we can avoid adding new ifdefferies...

I am simply following waht was already done in the existing driver.

Are you suggesting that we need to remove all these #defines? If not, what exactly do you suggest?


> > +	s->gpio_configured = devtype->nr_gpio;
> 
> The name of the variable is a bit vague WRT its content.
> Shouldn't be as simple as the rvalue, i.e. s->nr_gpio?

Maybe the name could be improved (and/or comments).

devtype->nr_gpio is the maximum "theoretical" number of GPIOs supported by the chip.

s->gpio_configured is the number of GPIOs that are configured or requested according to the presence (or not) of the modem-control-line-ports property.

I wanted to avoid using the same name to avoid potential confusion.

Maybe devtype->nr_gpio could be renamed to devtype->nr_gpio_max and s->gpio_configured to s->nr_gpio_requested or s->nr_gpio_configured?


> > +#endif /* CONFIG_GPIOLIB */
> 
> ...
> 
> > +		of_property_for_each_u32(dev->of_node, "nxp,modem-control-line-ports",
> > +					 prop, p, u)
> 
> The driver so far is agnostic to property provider. Please keep it that way,
> i.e. no of_ APIs.

The driver, before my patches, was already using the exact same function of_property_for_each_u32() to process the irda-mode-ports property, so I don't understand your comment.

But what do you suggest instead of of_property_for_each_u32()? And do we need to change it also for processing the irda-mode-ports property?


> > +			if (u < devtype->nr_uart) {
> 
> Hmm... What other can it be?

Again, this is similar to the handling of the irda-mode-ports property.

But I am not sure I understand your question/concern?

I think this check is important, because if someone puts the following property in a DT:

    nxp,modem-control-line-ports = <0 1>;

but the variant only supports 1 port, then the check is usefull, no?


> 
> > +				/* Use GPIO lines as modem control lines */
> > +				if (u == 0)
> > +					val |= SC16IS7XX_IOCONTROL_MODEM_A_BIT;
> > +				else if (u == 1)
> > +					val |= SC16IS7XX_IOCONTROL_MODEM_B_BIT;
> > +
> > +#ifdef CONFIG_GPIOLIB
> > +				if (s->gpio_configured >=
> > +				    SC16IS7XX_GPIOS_PER_BANK)
> 
> On one line it will be better to read. Esp. taking into account the above remark.

Fixed.

 
> > +					s->gpio_configured -=
> > +						SC16IS7XX_GPIOS_PER_BANK;
> 
> Ditto.

Fixed.

> 
> > +#endif /* CONFIG_GPIOLIB */
> > +			}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 
