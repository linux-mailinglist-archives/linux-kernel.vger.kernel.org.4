Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD95654FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbiLWL61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbiLWL6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:58:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BFB2A52C;
        Fri, 23 Dec 2022 03:58:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A418FB81F79;
        Fri, 23 Dec 2022 11:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C92C433D2;
        Fri, 23 Dec 2022 11:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671796698;
        bh=7UDYSxlkDDaNW5ftAXb8G8ePe4j/p7uAI3fhM2qdCso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TqpAIqHv6kdmAZivRdBN1M1HG1iu9Ndn58Zyt94uFkM5LXDvjtg3X5YNuMqPCme7L
         MEOovVo9B29e7jXH904pZrslNgSyNTHKnzTXI9jeVcegUxfW5GXNuCOgzv/QuvySBH
         blbaDc3cqJDfvP/aLpXGH0z8dsNo2aFh7qyK9ESoJwJ4uf6Yx2uIMksH7UjMMED3dv
         aGqazSPi0KcVLZfOgr6pG4IO6n0cqMyZbh7HEyNKAACKn4FA+2RHKa4o96VdBVtXnI
         hewJTAdgPE2YtNI4s0CIS4smdKnzN2/8EllP9pyxHsIZLskWnpu5Q7C+4qFj9hmZuI
         n28jGg0wxDUjQ==
Date:   Fri, 23 Dec 2022 11:58:13 +0000
From:   Lee Jones <lee@kernel.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <Y6WX1Y9GZmvxqlCc@google.com>
References: <20221007153323.1326-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221007153323.1326-1-henning.schild@siemens.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Oct 2022, Henning Schild wrote:

> If we register a "leds-gpio" platform device for GPIO pins that do not
> exist we get a -EPROBE_DEFER and the probe will be tried again later.
> If there is no driver to provide that pin we will poll forever and also
> create a lot of log messages.
> 
> So check if that GPIO driver is configured, if so it will come up
> eventually. If not, we exit our probe function early and do not even
> bother registering the "leds-gpio". This method was chosen over "Kconfig
> depends" since this way we can add support for more devices and GPIO
> backends more easily without "depends":ing on all GPIO backends.
> 
> Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version of Siemens driver")
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---

What happened in versions 1 through 3?  Please provide a change-log.

>  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
> index b9eeb8702df0..fb8d427837db 100644
> --- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
> +++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
> @@ -77,6 +77,8 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
>  
>  	switch (plat->devmode) {
>  	case SIMATIC_IPC_DEVICE_127E:
> +		if (!IS_ENABLED(CONFIG_PINCTRL_BROXTON))
> +			return -ENODEV;

I see that there is an unfortunate precedent for this in the lines
below.  However, I also see that the commit which added it was not
reviewed by Pavel.

This is an interesting problem, due to the different devices we're
attempting to support in this single driver using different
GPIO/PINCTRL drivers, which is unusual.  We usually resolve these kinds of
issues as a Kconfig 'depends' line which covers the whole driver.

Would 'depends GPIO_F7188X || PINCTRL_BROXTON' be a suitable
replacement, I wonder?  If it's possible for SIMATIC_IPC_DEVICE_127E to
be probing when only GPIO_F7188X is enabled?  If so, this would result
in the same scenario.

It also seems wrong for -EPROBE_DEFER to loop indefinitely.  Surely in
some valid circumstances dependencies are never satisfied?

>  		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_127e;
>  		break;
>  	case SIMATIC_IPC_DEVICE_227G:
> -- 
> 2.35.1
> 

-- 
Lee Jones [李琼斯]
