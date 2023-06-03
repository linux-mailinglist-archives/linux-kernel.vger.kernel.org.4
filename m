Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A217212A9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 22:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjFCUY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 16:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjFCUY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 16:24:58 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D832E132
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 13:24:56 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id b367a8af-024c-11ee-abf4-005056bdd08f;
        Sat, 03 Jun 2023 23:24:54 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 23:24:54 +0300
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 14/43] power: reset: Add a driver for the ep93xx reset
Message-ID: <ZHuhlguJxvBzPFUp@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-15-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601053546.9574-15-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Jun 01, 2023 at 08:34:05AM +0300, Nikita Shubin kirjoitti:
> Implement the reset behaviour of the various EP93xx SoCS in drivers/power/reset.
> 
> It used to be located in arch/arm/mach-ep93xx.

...

> +config POWER_RESET_EP93XX
> +	bool "Cirrus EP93XX reset driver" if COMPILE_TEST

Can you elaborate this construction, please?

> +	depends on MFD_SYSCON
> +	default ARCH_EP93XX
> +	help
> +	  This driver provides restart support for Cirrus EP93XX SoC.
> +
> +	  Say Y here if you have a Cirrus EP93XX SoC and you wish
> +	  to have restart support.

...

Missing bits.h

> +#include <linux/delay.h>
> +#include <linux/notifier.h>

> +#include <linux/of_device.h>

Wrong header. One is mod_devicetable.h, dunno what other implicit dependencies
you have in mind when added this.

> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>

> +#include <linux/soc/cirrus/ep93xx.h>

...

> +	struct notifier_block *res_han;
> +	struct device *dev = &pdev->dev;

Longer lines first?

> +	int err;
> +
> +	res_han = devm_kzalloc(&pdev->dev, sizeof(*res_han), GFP_KERNEL);

You have dev, use it.

> +	if (!res_han)
> +		return -ENOMEM;

...

> +	err = register_restart_handler(res_han);
> +	if (err)
> +		dev_err(dev, "can't register restart notifier (err=%d)\n", err);

		return dev_err_probe(...);

> +	return err;
> +}

-- 
With Best Regards,
Andy Shevchenko


