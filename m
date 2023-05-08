Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF816FB395
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjEHPRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjEHPRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:17:32 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99076A2
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 08:17:31 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 71d38cae-edb3-11ed-b3cf-005056bd6ce9;
        Mon, 08 May 2023 18:17:29 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Mon, 8 May 2023 18:17:28 +0300
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ARM: omap1: Fix up the Nokia 770 board device IRQs
Message-ID: <ZFkSiM9GRfN5n7n4@surfacebook>
References: <20230430-nokia770-regression-v3-0-a6d0a89ffa8b@linaro.org>
 <20230430-nokia770-regression-v3-3-a6d0a89ffa8b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430-nokia770-regression-v3-3-a6d0a89ffa8b@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, May 05, 2023 at 01:16:57PM +0200, Linus Walleij kirjoitti:
> The platform devices on the Nokia 770 is using some
> board-specific IRQs that get statically assigned to platform
> devices in the boardfile.
> 
> This does not work with dynamic IRQ chip bases.
> 
> Utilize the NULL device to define some board-specific
> GPIO lookups and use these to immediately look up the
> same GPIOs, convert to IRQ numbers and pass as resources
> to the devices. This is ugly but should work.

...

> +static struct gpiod_lookup_table nokia770_irq_gpio_table = {
> +	.dev_id = NULL,
> +	.table = {
> +		/* GPIO used by SPI device 1 */
> +		GPIO_LOOKUP("gpio-0-15", 15, "ads7846_irq",
> +			    GPIO_ACTIVE_HIGH),
> +		/* GPIO used for retu IRQ */
> +		GPIO_LOOKUP("gpio-48-63", 15, "retu_irq",
> +			    GPIO_ACTIVE_HIGH),
> +		/* GPIO used for tahvo IRQ */
> +		GPIO_LOOKUP("gpio-32-47", 8, "tahvo_irq",
> +			    GPIO_ACTIVE_HIGH),

Missing terminator.

> +	},
> +};

-- 
With Best Regards,
Andy Shevchenko


