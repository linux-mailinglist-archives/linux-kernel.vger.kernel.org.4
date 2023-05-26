Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4735E712C87
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242927AbjEZSfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242415AbjEZSek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:34:40 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755C7E6D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:32 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id f3177185-fbf3-11ed-b3cf-005056bd6ce9;
        Fri, 26 May 2023 21:34:29 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 26 May 2023 21:34:29 +0300
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 08/11] serial: sc16is7xx: fix regression with GPIO
 configuration
Message-ID: <ZHD7taBP0UthlPKp@surfacebook>
References: <20230525040324.3773741-1-hugo@hugovil.com>
 <20230525040324.3773741-9-hugo@hugovil.com>
 <ZG9EWEwb077qyBIi@surfacebook>
 <20230525110255.6ffe0a0c3f88ae03c3fc5f25@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525110255.6ffe0a0c3f88ae03c3fc5f25@hugovil.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, May 25, 2023 at 11:02:55AM -0400, Hugo Villeneuve kirjoitti:
> On Thu, 25 May 2023 14:19:52 +0300
> andy.shevchenko@gmail.com wrote:
> > Thu, May 25, 2023 at 12:03:22AM -0400, Hugo Villeneuve kirjoitti:

...

> > I'm wondering if we can avoid adding new ifdefferies...
> 
> I am simply following waht was already done in the existing driver.
> 
> Are you suggesting that we need to remove all these #defines? If not, what
> exactly do you suggest?

I was wondering and have nothing to suggest here. It seems a burden we have to
cope with for now.

> > > +	s->gpio_configured = devtype->nr_gpio;
> > 
> > The name of the variable is a bit vague WRT its content.
> > Shouldn't be as simple as the rvalue, i.e. s->nr_gpio?
> 
> Maybe the name could be improved (and/or comments).
> 
> devtype->nr_gpio is the maximum "theoretical" number of GPIOs supported by
> the chip.
> 
> s->gpio_configured is the number of GPIOs that are configured or requested
> according to the presence (or not) of the modem-control-line-ports property.
> 
> I wanted to avoid using the same name to avoid potential confusion.
> 
> Maybe devtype->nr_gpio could be renamed to devtype->nr_gpio_max and
> s->gpio_configured to s->nr_gpio_requested or s->nr_gpio_configured?

Maybe, but first try the approach with valid mask being involved. It may be
that we won't need this variable at all.

...

> > > +		of_property_for_each_u32(dev->of_node, "nxp,modem-control-line-ports",
> > > +					 prop, p, u)
> > 
> > The driver so far is agnostic to property provider. Please keep it that way,
> > i.e. no of_ APIs.
> 
> The driver, before my patches, was already using the exact same function
> of_property_for_each_u32() to process the irda-mode-ports property, so I
> don't understand your comment.

This is unfortunate. I missed that one, but i don't care about IrDA so much.

> But what do you suggest instead of of_property_for_each_u32()? And do we need
> to change it also for processing the irda-mode-ports property?

device_property_read_u32_array().

Independently on the IrDA case, this one is more important and would have
consequences if we avoid agnostic APIs.

...

> > > +			if (u < devtype->nr_uart) {
> > 
> > Hmm... What other can it be?
> 
> Again, this is similar to the handling of the irda-mode-ports property.
> 
> But I am not sure I understand your question/concern?
> 
> I think this check is important, because if someone puts the following
> property in a DT:
> 
>     nxp,modem-control-line-ports = <0 1>;
> 
> but the variant only supports 1 port, then the check is usefull, no?

But you have below checks for u value. Wouldn't be enough?

> > > +				/* Use GPIO lines as modem control lines */
> > > +				if (u == 0)
> > > +					val |= SC16IS7XX_IOCONTROL_MODEM_A_BIT;
> > > +				else if (u == 1)
> > > +					val |= SC16IS7XX_IOCONTROL_MODEM_B_BIT;
> > > +

-- 
With Best Regards,
Andy Shevchenko


