Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB97C6E0830
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjDMHtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjDMHtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:49:06 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DE78681;
        Thu, 13 Apr 2023 00:48:43 -0700 (PDT)
Received: (Authenticated sender: kamel.bouhara@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id AE60524000B;
        Thu, 13 Apr 2023 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681372108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LG1yvbZ/8Ykm65T3A7p+0iJ7bw5PRw9QVbZEYZc/EXQ=;
        b=Kogai0N/yCTSPArbOnvsxufaMcuZAOB27I9JvCpiq1PkCkzAE5EtEL5fdkxvevopLbAMg6
        PqcI3u/1VgRh+cWCJDUzMcHJT+1IJkDDWTI9bEv1dDVlxnNKGWmbYpZcI9+EIFjRngAMs/
        VbbzGMSc34QXaAdazdNWbE8ogQKpS7PHiZ/Up2ie3RuCtftO13bCrXABp9WMdqIMjmQlyx
        PnvIhevU3Dc1QCZVTOENGT6SfjGLSFcAgYaPRkotdvC568nWmcCDvcCqu+goW7w1waU6JE
        36jTEN3Djk9L2Q4bCevsziT6q+Kc0UUnP7POHvqihv7fIp0HGGdWP+C3O3QP9A==
MIME-Version: 1.0
Date:   Thu, 13 Apr 2023 09:48:26 +0200
From:   kamel.bouhara@bootlin.com
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        metux IT consult <lkml@metux.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        stratos-dev@op-lists.linaro.org
Subject: Re: [PATCH] gpio: aggregator: Add interrupt support
In-Reply-To: <c987d0bf744150ca05bd952f5f9e5fb3244d27b0.1633350340.git.geert+renesas@glider.be>
References: <c987d0bf744150ca05bd952f5f9e5fb3244d27b0.1633350340.git.geert+renesas@glider.be>
Message-ID: <58f91e983ac95b7f252606ecac12f016@bootlin.com>
X-Sender: kamel.bouhara@bootlin.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 2021-10-04 14:44, Geert Uytterhoeven a écrit :

Hello,

What is the status for this patch, is there any remaining
changes to be made ?

Kind regards,
--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

> Currently the GPIO Aggregator does not support interrupts.  This means
> that kernel drivers going from a GPIO to an IRQ using gpiod_to_irq(),
> and userspace applications using line events do not work.
> 
> Add interrupt support by providing a gpio_chip.to_irq() callback, which
> just calls into the parent GPIO controller.
> 
> Note that this does not implement full interrupt controller (irq_chip)
> support, so using e.g. gpio-keys with "interrupts" instead of "gpios"
> still does not work.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> I would prefer to avoid implementing irq_chip support, until there is a
> real use case for this.
> 
> This has been tested with gpio-keys and gpiomon on the Koelsch
> development board:
> 
>   - gpio-keys, using a DT overlay[1]:
> 
> 	$ overlay add r8a7791-koelsch-keyboard-controlled-led
> 	$ echo gpio-aggregator > 
> /sys/devices/platform/frobnicator/driver_override
> 	$ echo frobnicator > /sys/bus/platform/drivers/gpio-aggregator/bind
> 
> 	$ gpioinfo frobnicator
> 	gpiochip12 - 3 lines:
> 		line   0:      "light"      "light"  output  active-high [used]
> 		line   1:         "on"         "On"   input   active-low [used]
> 		line   2:        "off"        "Off"   input   active-low [used]
> 
> 	$ echo 255 > /sys/class/leds/light/brightness
> 	$ echo 0 > /sys/class/leds/light/brightness
> 
> 	$ evtest /dev/input/event0
> 
>   - gpiomon, using the GPIO sysfs API:
> 
> 	$ echo keyboard > /sys/bus/platform/drivers/gpio-keys/unbind
> 	$ echo e6055800.gpio 2,6 > 
> /sys/bus/platform/drivers/gpio-aggregator/new_device
> 	$ gpiomon gpiochip12 0 1
> 
> [1] "ARM: dts: koelsch: Add overlay for keyboard-controlled LED"
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/commit/?h=topic/renesas-overlays&id=c78d817869e63a3485bb4ab98aeea6ce368a396e
> ---
>  drivers/gpio/gpio-aggregator.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-aggregator.c 
> b/drivers/gpio/gpio-aggregator.c
> index 34e35b64dcdc0581..2ff867d2a3630d3b 100644
> --- a/drivers/gpio/gpio-aggregator.c
> +++ b/drivers/gpio/gpio-aggregator.c
> @@ -374,6 +374,13 @@ static int gpio_fwd_set_config(struct gpio_chip
> *chip, unsigned int offset,
>  	return gpiod_set_config(fwd->descs[offset], config);
>  }
> 
> +static int gpio_fwd_to_irq(struct gpio_chip *chip, unsigned int 
> offset)
> +{
> +	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
> +
> +	return gpiod_to_irq(fwd->descs[offset]);
> +}
> +
>  /**
>   * gpiochip_fwd_create() - Create a new GPIO forwarder
>   * @dev: Parent device pointer
> @@ -414,7 +421,8 @@ static struct gpiochip_fwd
> *gpiochip_fwd_create(struct device *dev,
>  	for (i = 0; i < ngpios; i++) {
>  		struct gpio_chip *parent = gpiod_to_chip(descs[i]);
> 
> -		dev_dbg(dev, "%u => gpio-%d\n", i, desc_to_gpio(descs[i]));
> +		dev_dbg(dev, "%u => gpio %d irq %d\n", i,
> +			desc_to_gpio(descs[i]), gpiod_to_irq(descs[i]));
> 
>  		if (gpiod_cansleep(descs[i]))
>  			chip->can_sleep = true;
> @@ -432,6 +440,7 @@ static struct gpiochip_fwd
> *gpiochip_fwd_create(struct device *dev,
>  	chip->get_multiple = gpio_fwd_get_multiple_locked;
>  	chip->set = gpio_fwd_set;
>  	chip->set_multiple = gpio_fwd_set_multiple_locked;
> +	chip->to_irq = gpio_fwd_to_irq;
>  	chip->base = -1;
>  	chip->ngpio = ngpios;
>  	fwd->descs = descs;
