Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17ACD700163
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbjELHYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240109AbjELHYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:24:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DDC10DF;
        Fri, 12 May 2023 00:24:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 755A765358;
        Fri, 12 May 2023 07:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5535C4339B;
        Fri, 12 May 2023 07:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683876239;
        bh=HfUj4/s95uvz7Tk19IO4GOkQ3Gb/dTDAKkge/PI7650=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PoS6M9j6GwJZ1fGGcuJ9aBlIkZjBIoigcpC8senelnx9LAnakyrGNBJrx5rHZ1MfW
         DufeI6ryHogGxT+C51Lv47GclZasRDxkv9L7GHPPGJOMFg9jv+DS6vR2Z8KfwxBsXt
         5q8XCTLAoPYyA4JwApx5jAfQ4FYlPbUkQ3dK4CfHHl9CkvkhMPThHkwsjst0oxi9Di
         21uAuf5HcSQIcXVVxL7FTY+f4+vKdWtUTosPSHEJPhIhm6rS/BevKytGiS7NcqUvuk
         uqI81+07qGFhboi0/QcA7oDEeY4Ay20B/k59lBQtBRbsCbqjj/kuH/YMxevnZDiC08
         4843IJbPnp5UA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pxN8c-0002Co-QC; Fri, 12 May 2023 09:24:27 +0200
Date:   Fri, 12 May 2023 09:24:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy.shevchenko@gmail.com,
        maz@kernel.org, Ben Brown <ben.brown@alliedtelesis.co.nz>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Message-ID: <ZF3pqvOVv6eZl62y@hovoldconsulting.com>
References: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 04:28:06PM +1200, Chris Packham wrote:
> Calling gpiod_to_irq() creates an irq_desc for the GPIO. This is not
> something that should happen when just exporting the GPIO via sysfs. The
> effect of this was observed as triggering a warning in
> gpiochip_disable_irq() when kexec()ing after exporting a GPIO.

You need a better explanation as to why this is an issue. What does the
warning look like for example?

> Remove the call to gpiod_to_irq() from gpio_is_visible(). The actual
> intended creation of the irq_desc comes via edge_store() when requested
> by the user.

And why does that avoid whatever problem you're seeing?

> Fixes: ebbeba120ab2 ("gpio: sysfs: fix gpio attribute-creation race")

This is clearly not the right Fixes tag. The above commit only moved the
creation of the attribute to before registering the sysfs device and
specifically gpiod_to_irq() was used also prior to that commit.

As a matter of fact, back then there was no call to
irq_create_mapping() in gpiod_to_irq() either. That was added years
later by commit

	dc749a09ea5e ("gpiolib: allow gpio irqchip to map irqs dynamically")

> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     This is technically a v2 of
>     https://lore.kernel.org/lkml/20230510001151.3946931-1-chris.packham@alliedtelesis.co.nz/
>     but the solution is so different it's probably best to treat it as a new
>     patch.
> 
>  drivers/gpio/gpiolib-sysfs.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
> index 530dfd19d7b5..f859dcd1cbf3 100644
> --- a/drivers/gpio/gpiolib-sysfs.c
> +++ b/drivers/gpio/gpiolib-sysfs.c
> @@ -362,8 +362,6 @@ static umode_t gpio_is_visible(struct kobject *kobj, struct attribute *attr,
>  		if (!show_direction)
>  			mode = 0;
>  	} else if (attr == &dev_attr_edge.attr) {
> -		if (gpiod_to_irq(desc) < 0)
> -			mode = 0;
>  		if (!show_direction && test_bit(FLAG_IS_OUT, &desc->flags))
>  			mode = 0;
>  	}

Johan
