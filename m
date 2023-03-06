Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E2C6AD30E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 00:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCFXyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 18:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCFXyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 18:54:11 -0500
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B70C5329B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 15:54:10 -0800 (PST)
Received: from localhost (88-113-24-128.elisa-laajakaista.fi [88.113.24.128])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 2f0d44cd-bc7a-11ed-b972-005056bdfda7;
        Tue, 07 Mar 2023 01:54:08 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Tue, 7 Mar 2023 01:54:07 +0200
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] gpio: fxl6408: add I2C GPIO expander driver
Message-ID: <ZAZ9H4Eh/TUzuJan@surfacebook>
References: <20230306083446.41082-1-francesco@dolcini.it>
 <20230306083446.41082-3-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306083446.41082-3-francesco@dolcini.it>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 06, 2023 at 09:34:46AM +0100, Francesco Dolcini kirjoitti:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> Support Fairchild (now ON Semiconductor) fxl6408 which has 8 GPIO lines
> and is controlled by I2C bus.

Is it really GPIO expander and not a (semi-)featured pin control with GPIO
capability?

Can we have a Datasheet: tag here?

> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

...

> +	help
> +	  GPIO driver for Fairchild Semiconductor FXL6408 GPIO expander

Checkpatch usually complains on the help < 3 lines.
You may add the module name for M choice.

...

> + * Author: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

> + *

Unneeded blank line.

...

> +#include <linux/gpio.h>

No way. This must not be in any code.

...

> +#include <linux/of_platform.h>

Why?
For discrete components make sure you have not an OF-centric code.

...

> +static const struct regmap_range rd_range[] = {
> +	{ FXL6408_REG_DEVICE_ID, FXL6408_REG_DEVICE_ID },
> +	{ FXL6408_REG_IO_DIR, FXL6408_REG_OUTPUT },
> +	{ FXL6408_REG_INPUT_STATUS, FXL6408_REG_INPUT_STATUS }

In all definitions where the entry is _not_ a terminator, leave the trailing
comma in place.

> +};

...

> +	};

> +	gpio_config.regmap = devm_regmap_init_i2c(client, &regmap);

> +

This blank line is misplaced. Should be before devm_regmap_init_i2c() call.

> +	if (IS_ERR(gpio_config.regmap)) {

> +		dev_err(dev, "failed to allocate register map\n");
> +		return PTR_ERR(gpio_config.regmap);

	return dev_err_probe();

> +	}

...

> +	/* Disable High-Z of outputs, so that our OUTPUT updates
> +	 * actually take effect.
> +	 */

/*
 * This is correct style for multi-line
 * comments. Yours needs to be fixed.
 */

...

> +	ret = regmap_write(gpio_config.regmap, FXL6408_REG_OUTPUT_HIGH_Z, 0);
> +	if (ret) {

> +		dev_err(dev, "failed to write 'output high Z' register\n");
> +		return ret;

	return dev_err_probe(...);

> +	}

...

> +static const struct i2c_device_id fxl6408_id[] = {
> +	{ "fxl6408", 0 },
> +	{ },

But no comma for a terminator entry.
 
> +};

...

> +

Unneeded blank line.

> +module_i2c_driver(fxl6408_driver);

-- 
With Best Regards,
Andy Shevchenko


