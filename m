Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38F3721B07
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 01:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjFDXQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 19:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDXQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 19:16:25 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF158A9;
        Sun,  4 Jun 2023 16:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hJhugzfcI+7CDRUGK0Ajees/mgMNPJIh2H0o1K86D4k=; b=C+IeKdScF5v2GD97F/m6ZtMTX/
        z15kRDbwivWCuM9rcPMu+egUtWokTzXMyGcBsjRB62p13jNCd8HSmjz48ZJ4jyxehVUt51BwSlIZv
        tcILVrz1Tuqcw9lSc0gsTenJqAD/ICsGmoiHuDHN50JqwPO45HcMa3wNkIX/Q/CB6eYo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:49848 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q5wxK-0000Mo-HS; Sun, 04 Jun 2023 19:16:15 -0400
Date:   Sun, 4 Jun 2023 19:16:13 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Message-Id: <20230604191613.ea95fa9a1bc508525fe3bbd5@hugovil.com>
In-Reply-To: <2023060406-scarcity-clear-cc56@gregkh>
References: <20230602152626.284324-1-hugo@hugovil.com>
        <20230602152626.284324-6-hugo@hugovil.com>
        <2023060454-cotton-paramount-e33e@gregkh>
        <20230604134344.73dc3cbb57d335d4a0b4b33a@hugovil.com>
        <2023060406-scarcity-clear-cc56@gregkh>
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v7 5/9] serial: sc16is7xx: fix regression with GPIO
 configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2023 20:29:58 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sun, Jun 04, 2023 at 01:43:44PM -0400, Hugo Villeneuve wrote:
> > Here is what I suggest to silence the warning:
> > 
> > 	mctrl_mask = sc16is7xx_setup_mctrl_ports(dev);
> > 
> > #ifdef CONFIG_GPIOLIB
> > 	ret = sc16is7xx_setup_gpio_chip(dev, mctrl_mask);
> > 	if (ret)
> > 		goto out_thread;
> > #else
> > 	(void) mctrl_mask;
> > #endif
> 
> Eeek,  no, please no...
> 
> First off, please don't put #ifdef in .c files if at all possible.

Hi Greg,
Andy also made a similar comment, but couldn't suggest a valid
alternative when I asked him what to do about that.

Just as a sidenote, I didn't add those #ifdef, they were already
present in the driver in multiple places.

What would be your suggestion to get rid of those #ifdef, simply delete
them all?

If you suggest me what to do, I will be happy to submit a
future patch after this series is finalized to clean that aspect.


> Secondly, that (void) craziness is just that.  Rework this to not be an
> issue some other way please.
> 
> > I could also store (define new variable) mctrl_mask directly inside struct sc16is7xx_port...
> 
> Sure, that sounds best.

Ok, I will do that.


> > > And you have a real port here, no need to pass in a "raw" struct device,
> > > right?
> > 
> > The function operates globally on both ports (or nr_uart), not just a single port. That is why I pass the "raw" struct device, in order to extract the 
> > struct sc16is7xx_port from it:
> > 
> >     struct sc16is7xx_port *s = dev_get_drvdata(dev);
> > 
> > Inside the function, I also need the "raw" struc device. If we pass a struct sc16is7xx_port to the function, then I can get the "raw" struc device with this:
> > 
> > static u8 sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s)
> > {
> > 	struct device *dev = &s->p[0].port.dev;
> > 
> > But I find this more obfuscated and hard to understand than to simply pass a "raw" struct device...
> 
> You should never need a "raw" struct device for stuff (if so, something
> is really odd).  Except for error messages, but that's not really a big
> deal, right?

> Don't pass around struct device in a driver, use the real types as you
> know you have it and it saves odd casting around and it just doesn't
> look safe at all to do so.

If you look at the patch, you will see that I need "struct device *dev"
at two places in the sc16is7xx_setup_mctrl_ports() function to read the
device properties:

...
+static u8 sc16is7xx_setup_mctrl_ports(struct device *dev)
...
+	count = device_property_count_u32(dev,...
...
+	ret = device_property_read_u32_array(dev,
...

I do not understand why this is odd?


> And if you have that crazy s->p.... stuff in multiple places, the
> perhaps you might want to rethink the structure somehow?  Or at the very
> least, write an inline function to get it when needed.

I am not sure what you mean by that, since again that "crazy" stuff is
already used everywhere in this driver?


> Also, meta comment, you might want to use some \n characters in your
> emails, your lines are really long :)

Strange, I use sylpheed as a mail client, and the option "Wrap lines at
72 characters" is enabled by default, but somehow you must also check
the box "Wrap on input" for it to work, not very intuitive :) Thanks for
pointing that to me.

Hugo.
