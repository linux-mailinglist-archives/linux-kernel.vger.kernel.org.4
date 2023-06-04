Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA48721940
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 20:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjFDSaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 14:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjFDSaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 14:30:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AC0AB;
        Sun,  4 Jun 2023 11:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BE1F60EAB;
        Sun,  4 Jun 2023 18:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88032C433EF;
        Sun,  4 Jun 2023 18:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685903401;
        bh=kxsomFjsOAjnBRkBjyMWAFWDP5rHAxHvBrACL6M2log=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LiYZhJr09wNN2Z3m5zJBGOXol0IkquTe0Y239i4CvEU4oPvGUJWJ097Dr1TM3n/2Y
         WbiTNydY2FNGqyB9Rkm0H3i5AGoftW0MDFcsDonqCFS2g9Bamcvkby5KlUtwUCgKXa
         I6YZBV37/vlU6IghSGwKgnThF07K8B9oIixECHeY=
Date:   Sun, 4 Jun 2023 20:29:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 5/9] serial: sc16is7xx: fix regression with GPIO
 configuration
Message-ID: <2023060406-scarcity-clear-cc56@gregkh>
References: <20230602152626.284324-1-hugo@hugovil.com>
 <20230602152626.284324-6-hugo@hugovil.com>
 <2023060454-cotton-paramount-e33e@gregkh>
 <20230604134344.73dc3cbb57d335d4a0b4b33a@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604134344.73dc3cbb57d335d4a0b4b33a@hugovil.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2023 at 01:43:44PM -0400, Hugo Villeneuve wrote:
> Here is what I suggest to silence the warning:
> 
> 	mctrl_mask = sc16is7xx_setup_mctrl_ports(dev);
> 
> #ifdef CONFIG_GPIOLIB
> 	ret = sc16is7xx_setup_gpio_chip(dev, mctrl_mask);
> 	if (ret)
> 		goto out_thread;
> #else
> 	(void) mctrl_mask;
> #endif

Eeek,  no, please no...

First off, please don't put #ifdef in .c files if at all possible.
Secondly, that (void) craziness is just that.  Rework this to not be an
issue some other way please.

> I could also store (define new variable) mctrl_mask directly inside struct sc16is7xx_port...

Sure, that sounds best.

> > And you have a real port here, no need to pass in a "raw" struct device,
> > right?
> 
> The function operates globally on both ports (or nr_uart), not just a single port. That is why I pass the "raw" struct device, in order to extract the 
> struct sc16is7xx_port from it:
> 
>     struct sc16is7xx_port *s = dev_get_drvdata(dev);
> 
> Inside the function, I also need the "raw" struc device. If we pass a struct sc16is7xx_port to the function, then I can get the "raw" struc device with this:
> 
> static u8 sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s)
> {
> 	struct device *dev = &s->p[0].port.dev;
> 
> But I find this more obfuscated and hard to understand than to simply pass a "raw" struct device...

You should never need a "raw" struct device for stuff (if so, something
is really odd).  Except for error messages, but that's not really a big
deal, right?

Don't pass around struct device in a driver, use the real types as you
know you have it and it saves odd casting around and it just doesn't
look safe at all to do so.

And if you have that crazy s->p.... stuff in multiple places, then
perhaps you might want to rethink the structure somehow?  Or at the very
least, write an inline function to get it when needed.

Also, meta comment, you might want to use some \n characters in your
emails, your lines are really long :)

thanks,

greg k-h
