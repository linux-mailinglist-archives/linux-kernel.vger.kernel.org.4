Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF2E62E163
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbiKQQTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240043AbiKQQTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:19:01 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1228786ED;
        Thu, 17 Nov 2022 08:18:57 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 2CDC675;
        Thu, 17 Nov 2022 17:18:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1668701936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cvVuv/CFKqXK0IGORbzS8gsCb1jkg5g0Q6TdD8SyobY=;
        b=PZ66z5fBw1rR11hJ2eD3M5VCRPpL+oo45/qZ84B9tBCEYIWyvI60fWpNuUvZdNRo2IC5Mf
        45/wI71MzSdG7S+2+Fu6aMR9rGAWMgcE1EvJA3CGkAhR16f1wNBDOhlfPmBr++ireE0Qin
        uMZ3lgDhefkoI6fTz3q7jR9eM/IMmZ70RKo557C7sVwGhYzG/RjSsnGQ9KzTyllsE5tyGq
        S2ltp1qaNK7PZ3TcWNIMI4NmUAf6L31mx9C9HqaBRO9UMSdsJDcqJX39GE6fDQXBZ1+I7y
        IpPxse1jDGH7HjqstWHj6t1Xhjpp46AE7hBx6DiB4eNG29nO80BmLG/mjKSu6A==
MIME-Version: 1.0
Date:   Thu, 17 Nov 2022 17:18:55 +0100
From:   Michael Walle <michael@walle.cc>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org
Subject: Re: [PATCH v2 4/4] gpio: i8255: Migrate to regmap API
In-Reply-To: <61327a67cc308af413471a69a4810b2785e53e8e.1668129763.git.william.gray@linaro.org>
References: <cover.1668129763.git.william.gray@linaro.org>
 <61327a67cc308af413471a69a4810b2785e53e8e.1668129763.git.william.gray@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <5123090e11da67e57fb00984445ece2f@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-11-11 02:55, schrieb William Breathitt Gray:

> +    config.map = devm_regmap_init_mmio(dev, regs, 
> &gpiomm_regmap_config);
> +    if (IS_ERR(config.map))
> +        return PTR_ERR(config.map);

I've just skimmed over your patch and noticed you're using an mmio
regmap. Please note that for now, gpio-regmap unconditionally sets
.can_sleep to true in the gpiochip [1]. So the users would need to
use the _cansleep() variants. See a proposal below.

> +int devm_i8255_regmap_register(struct device *const dev,
> +			       const struct i8255_regmap_config *const config)
> +{
> +	struct gpio_regmap_config gpio_config = {0};
> +	unsigned long i;
> +	int err;
> +
> +	if (!config->parent)
> +		return -EINVAL;
> +
> +	if (!config->map)
> +		return -EINVAL;
> +
> +	if (!config->num_ppi)
> +		return -EINVAL;
> +
> +	for (i = 0; i < config->num_ppi; i++) {
> +		err = i8255_ppi_init(config->map, i * 4);
> +		if (err)
> +			return err;
> +	}
> +
> +	gpio_config.parent = config->parent;
> +	gpio_config.regmap = config->map;

I'd propose to add a new config flag to indicate that accesses to
the device will be fast:

gpio_config.regmap_has_fast_io = true;

which will then set gpio->can_sleep = false.

-michael

> +	gpio_config.ngpio = I8255_NGPIO * config->num_ppi;
> +	gpio_config.names = config->names;
> +	gpio_config.reg_dat_base = GPIO_REGMAP_ADDR(I8255_REG_DAT_BASE);
> +	gpio_config.reg_set_base = GPIO_REGMAP_ADDR(I8255_REG_DAT_BASE);
> +	gpio_config.reg_dir_in_base = 
> GPIO_REGMAP_ADDR(I8255_REG_DIR_IN_BASE);
> +	gpio_config.ngpio_per_reg = I8255_NGPIO_PER_REG;
> +	gpio_config.irq_domain = config->domain;
> +	gpio_config.reg_mask_xlate = i8255_reg_mask_xlate;
> +
> +	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_i8255_regmap_register, I8255);

[1] 
https://elixir.bootlin.com/linux/v6.1-rc5/source/drivers/gpio/gpio-regmap.c#L260
