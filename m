Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EBE6D7E30
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjDEN5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbjDEN5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:57:13 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3745FC8;
        Wed,  5 Apr 2023 06:57:09 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 3FC54254;
        Wed,  5 Apr 2023 15:57:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1680703025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RWMKgUasvY7/ukIcrTxVdr1TVXErPO1KhzaokcDzqyI=;
        b=onzov+H2UG9qQV1AhON4idtUM1DOyzv/FPa85whMlfX6g8Wt+5vmEWJgbBNK2hWyJHTk/T
        KT6uRUFKG+E4ud1aqCGrqxWDB8mVRzl4q6OuykS+Ir6+qdAt7H1j/SShzB0zwqOIZ8yKet
        JlnR/A4YLPU7ruUMWVngb4Y0qlrpaYqMhWr9uR+Wo8BxMnqJkg7np5XcQBVXvQtGx+VMGi
        7qNjigCtoZhQWGih/2iup13KEo49bOstWYQ9lUP51Hgk7L1DhVR2IXSDahlvMmMf4lx9qr
        SHqTktCcs3BuTkVHyA2Gql/eklTYomiM/k2G0jeuE/1J6f9OYM6PlvJ+2YQ0cw==
MIME-Version: 1.0
Date:   Wed, 05 Apr 2023 15:57:05 +0200
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Sahin, Okan" <Okan.Sahin@analog.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
In-Reply-To: <CACRpkdZJA0DyzgLxm9HFeHO03rqNUff=avuV=VrGuJkkOg6wNQ@mail.gmail.com>
References: <20230327130010.8342-1-okan.sahin@analog.com>
 <20230327130010.8342-3-okan.sahin@analog.com>
 <CACRpkda5G5b+At5s1WFudpQBQ6LDQxhE3fZj7eBhkZ=thvnQhg@mail.gmail.com>
 <MN2PR03MB51682210CADA6E33FB99052CE7939@MN2PR03MB5168.namprd03.prod.outlook.com>
 <CACRpkdZJA0DyzgLxm9HFeHO03rqNUff=avuV=VrGuJkkOg6wNQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <25e1fda4b6df2d10444d7eca3cd0e387@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-04-05 15:20, schrieb Linus Walleij:
> On Tue, Apr 4, 2023 at 4:36 PM Sahin, Okan <Okan.Sahin@analog.com> 
> wrote:
> 
>> >The driver is pretty straight-forward, but I think this can use the generic
>> >GPIO_REGMAP helpers in drivers/gpio/gpio-regmap.c check other drivers selecting
>> >this helper library for inspiration.
> (..)
>> Thank you for your contribution. Should I add select GPIO_REGMAP into 
>> Kconfig?
> 
> Yes but that is not all, you also need to make use of the library 
> helpers
> provided in include/linux/gpio/regmap.h.
> 
> Find examples of other drivers doing this by e.g.:
> git grep gpio_regmap_register
> 
> drivers/gpio/gpio-sl28cpld.c:   return
> PTR_ERR_OR_ZERO(devm_gpio_regmap_register(&pdev->dev, &config));
> drivers/gpio/gpio-tn48m.c:      return
> PTR_ERR_OR_ZERO(devm_gpio_regmap_register(&pdev->dev, &config));
> drivers/pinctrl/bcm/pinctrl-bcm63xx.c:  return
> PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &grc));
> 
> ^Look what these are doing

This driver is doing two register writes/reads for setting the
direction, that's something which isn't supported in GPIO_REGMAP.
OTOH I'm not sure the driver is doing it correctly, because it also
seems to switch the pullup resisters together with the direction.
I'm not sure that is correct. So there might be just one register
involved after all and the GPIO_REGMAP should work again.

Also, according to the datasheet this has some nv memory (to set the
initial state of the GPIOs [?]). So it should really be a multi-function
device. I'm not sure if this has to be considered right from the
beginning or if the device support can start with GPIO only and later
be transitioned to a full featured MFD (probably with nvmem support).

-michael
