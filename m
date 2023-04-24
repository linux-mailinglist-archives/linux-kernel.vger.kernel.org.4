Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82DD6DDC69
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjDKNmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjDKNmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:42:46 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5038BAC;
        Tue, 11 Apr 2023 06:42:44 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id ED9CB321;
        Tue, 11 Apr 2023 15:42:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1681220560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZ/3AiR5wKOvx5Zl/F4+bP51DgLLVwlnzMNwvAPy1CM=;
        b=JRXIX3av1txQH6nBKk+l7fk43DQP36KVMSlzvFEaiUWKu2M7sFHiVHpKwxMKFMxqZK+Ybv
        QAFnNKqHU/pvR/nwvChB8iEptjlmqYzgEIWXmZUicfPeEXGDqNFn4My8HNlWU770qBqPnQ
        Go+K8W1/+4aCTxs6Q5ctm5yrRgdu/4iZ3UYutMalFqw254D95FazcPwcKaegYGR7hGaotg
        wvhanilmvNpkjKaxm9zmFVxDiVt05hCmfyAI+jmiZm0IpL4D6T90QNLV3pB6Neq5RcLZOZ
        2fmeBZNuy1OfNhv4Jvf6IijarggOFr3+NF8vP0jL9tCGQb2TZswprqSqjJw1TA==
MIME-Version: 1.0
Date:   Tue, 11 Apr 2023 15:42:39 +0200
From:   Michael Walle <michael@walle.cc>
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     andy.shevchenko@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
In-Reply-To: <MN2PR03MB516879DCD6600827AEE2BDC9E7949@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230327130010.8342-1-okan.sahin@analog.com>
 <20230327130010.8342-3-okan.sahin@analog.com>
 <CACRpkda5G5b+At5s1WFudpQBQ6LDQxhE3fZj7eBhkZ=thvnQhg@mail.gmail.com>
 <MN2PR03MB51682210CADA6E33FB99052CE7939@MN2PR03MB5168.namprd03.prod.outlook.com>
 <CACRpkdZJA0DyzgLxm9HFeHO03rqNUff=avuV=VrGuJkkOg6wNQ@mail.gmail.com>
 <25e1fda4b6df2d10444d7eca3cd0e387@walle.cc>
 <CACRpkdYKEid8-0-7sBECNgSyW3kMRCsv3DeBVUzxo4z6p+Grnw@mail.gmail.com>
 <ZDBivYlwJ6zgaFTg@surfacebook>
 <MN2PR03MB516879DCD6600827AEE2BDC9E7949@MN2PR03MB5168.namprd03.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a3ca3e705b5b8668cd511fc15681c75f@walle.cc>
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

Am 2023-04-09 16:25, schrieb Sahin, Okan:
>> Fri, Apr 07, 2023 at 03:48:25PM +0200, Linus Walleij kirjoitti:
>>> On Wed, Apr 5, 2023 at 3:57 PM Michael Walle <michael@walle.cc> 
>>> wrote:
>>> 
>>> > OTOH I'm not sure the driver is doing it correctly, because it also
>>> > seems to switch the pullup resisters together with the direction.
>>> > I'm not sure that is correct. So there might be just one register
>>> > involved after all and the GPIO_REGMAP should work again.
>>> 
>>> I'm pretty sure that should be in the .set_config() callback.
>>> 
>>> > Also, according to the datasheet this has some nv memory (to set the
>>> > initial state of the GPIOs [?]). So it should really be a
>>> > multi-function device. I'm not sure if this has to be considered
>>> > right from the beginning or if the device support can start with
>>> > GPIO only and later be transitioned to a full featured MFD (probably with nvmem
>> support).
>>> 
>>> That's a bit of a soft definition.
>>> 
>>> If the chip is *only* doing GPIO and nvram it can be a GPIO-only
>>> device I think.
>>> 
>>> The precedent is a ton of ethernet drivers with nvram for storing 
>>> e.g.
>>> the MAC address. We don't make all of those into MFDs, as the nvram 
>>> is
>>> closely tied to the one and only function of the block.
>> 
>> I agree with Linus. This should be part of the actual (main) driver 
>> for the chip as many
>> do (like USB to serial adapters that have GPIO capability).

You mean the gpio driver is calling nvmem_register()? Yeah I agree, that
should work.

> I think gpio_regmap is not suitable for this driver as Michael stated.
> https://www.analog.com/media/en/technical-documentation/data-sheets/ds4520.pdf
> Please check block diagram. There are two input registers that control
> gpio state
> so gpio_regmap does not look ok for this. Am I missing something?

You mean F8/F9? That will work as they are for different GPIOs. What
doesn't work with gpio-regmap is when you need to modify two different
registers for one GPIO. Have a look at gpio_regmap_get() and
gpio_regmap_set(). If the default gpio_regmap_simple_xlate() doesn't 
work
you can use your own .xlate() op.

> Also, at this point I am not planning to add nvmem support.

That is a pity, because that is the whole use case for this gpio 
expander,
no? "Programmable Replacement for Mechanical Jumpers and Switches"

-michael
