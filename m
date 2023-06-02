Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCEF71F831
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjFBBuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjFBBus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:50:48 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E59A3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:50:47 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id e33ad88a-00e7-11ee-a9de-005056bdf889;
        Fri, 02 Jun 2023 04:50:45 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 2 Jun 2023 04:50:44 +0300
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 01/43] gpio: ep93xx: split device in multiple
Message-ID: <ZHlK9EkHlLD7DDG7@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-2-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601053546.9574-2-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Jun 01, 2023 at 08:33:52AM +0300, Nikita Shubin kirjoitti:
> This prepares ep93xx SOC gpio to convert into device tree driver:
> - dropped banks and legacy defines
> - split AB IRQ and make it shared
> 
> We are relying on IRQ number information A, B ports have single shared
> IRQ, while F port have dedicated IRQ for each line.
> 
> Also we had to split single ep93xx platform_device into multiple, one
> for each port, without this we can't do a full working transition from
> legacy platform code into device tree capable. All GPIO_LOOKUP were
> change to match new chip namings.

First of all, check if you added In-Reply-to email header to the previous
thread, at least `b4` downloaded 188 messages in this one so far. Second,
the previous was kinda v0, while we usually assume that non-versioned series
is v1. This is a bit ambiguous.

...

> +		GPIO_LOOKUP_IDX("gpio-ep93xx.4", 1,	NULL, 1, GPIO_ACTIVE_HIGH),

TAB used instead of space.

...

>  struct device __init *ep93xx_init_devices(void)
>  {
>  	struct device *parent;
> +	int i;

It's unsigned, right?

> +	for (i = 0; i < ARRAY_SIZE(ep93xx_gpio_device); i++)
> +		platform_device_register(ep93xx_gpio_device[i]);

...

>  	writeb(eic->int_debounce,
> -	       epg->base + eic->irq_offset + EP93XX_INT_DEBOUNCE_OFFSET);
> +	       eic->base + EP93XX_INT_DEBOUNCE_OFFSET);

Now this can be a single line. Also some other cases may be optimized.

...

> +	void __iomem *intr = devm_platform_ioremap_resource_byname(pdev, "intr");

It's less error prone if the assignment is split from definition and moved
closer to its (first) user...

> +

...here.

> +	if (IS_ERR(intr))
> +		return PTR_ERR(intr);

...

> +	egc->eic = devm_kcalloc(dev, 1,
> +				sizeof(*egc->eic),
> +				GFP_KERNEL);

Why kcalloc(1), is this a part that will be (slightly) modified in the next
patches in the series?

> +	if (!egc->eic)
> +		return -ENOMEM;
>  
...

> +		irq = platform_get_irq(pdev, 0);

No return value check?

> +		ret = devm_request_irq(dev, irq,
> +				ep93xx_ab_irq_handler,
> +				IRQF_SHARED, gc->label, gc);
> +		if (ret) {
> +			dev_err(dev, "error requesting IRQ : %d\n", irq);
> +			return ret;

If it's soslely part of the ->probe() flow, you may use dev_err_probe().

> +		}
>  
> +		girq->parents[0] = irq;

...

>  		for (i = 0; i < girq->num_parents; i++) {
> +			irq = platform_get_irq(pdev, i);
> +			if (irq <= 0)

== 0 is never happen case. Why?

> +				continue;
> +
> +			girq->parents[i] = irq;
>  		}

> +	ret = bgpio_init(gc, &pdev->dev, 1, data, NULL, NULL, dir, NULL, 0);
> +	if (ret) {
> +		dev_err(&pdev->dev, "unable to init generic GPIO\n");
> +		return ret;

		return dev_err_probe(...);

>  	}

...

> +	if (platform_irq_count(pdev) > 0) {

Do you need this check?

> +		dev_dbg(&pdev->dev, "setting up irqs for %s\n", dev_name(&pdev->dev));
> +		ret = ep93xx_setup_irqs(pdev, egc);
> +		if (ret)
> +			dev_err(&pdev->dev, "setup irqs failed for %s\n", dev_name(&pdev->dev));

If it's an error, why continuing?

> +	}

-- 
With Best Regards,
Andy Shevchenko


