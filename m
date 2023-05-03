Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5FB6F55AE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjECKN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjECKN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:13:26 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3D8CE;
        Wed,  3 May 2023 03:13:24 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 92F233EF;
        Wed,  3 May 2023 12:13:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1683108801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TPDO4Om9yjcPWH9ANN/EN8sQlVWPtQhVOQp30fzdMYU=;
        b=p3mhAlx624E1Mtm8WvgkKyTUyjuOahHgpQXF5nZZyo+SHTN5KqDgeMixTXiorRE8qQAB30
        wYQp/nM3+XwSugMK6j0O9lJKtchxZEhV4lqjF5Bvfq7ITplzXRwg6iVUcRse6K2NPfSDHC
        fOhkuL+95YK70nmOdQq5zdbVuZFiYvEgrUEAAV0egGJFiB+kBhuRIqWwbYIU5F6vl15A4H
        c44MijOSQazd49AD0kCVQp/eX7lIEeco9dXPCYVF3dj6idZxnto1wrOLFzxhnevYLyPZSB
        FsDSYFGCPEMIV3V3LHDiqstlPN3m9WC9akKH8AbFweM8YK1FeaEUFTwEutl4ZA==
MIME-Version: 1.0
Date:   Wed, 03 May 2023 12:13:21 +0200
From:   Michael Walle <michael@walle.cc>
To:     Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] gpio: max7317: Add gpio expander driver
In-Reply-To: <bb2bce8b-4d99-1a15-3a34-055ee7637fe2@emlix.com>
References: <20230403114033.8336-1-edmund.berenson@emlix.com>
 <20230403114033.8336-2-edmund.berenson@emlix.com>
 <CACRpkdbnj-BiA8D0e4nza-za-E8g_AEBNjR4b3gWUZpw70U33g@mail.gmail.com>
 <bb2bce8b-4d99-1a15-3a34-055ee7637fe2@emlix.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <14574305d829de5befd39828b0b29cfe@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-05-03 10:37, schrieb Edmund Berenson:
> On 4/4/23 16:05, Linus Walleij wrote:
>> On Mon, Apr 3, 2023 at 1:41 PM Edmund Berenson
>> <edmund.berenson@emlix.com> wrote:
>> 
>>> Add driver for maxim MAX7317 SPI-Interfaced 10 Port
>>> GPIO Expander.
>>> 
>>> v2: adjust driver to use regmap
>>> 
>>> Co-developed-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
>>> Signed-off-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
>>> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
>> 
>> Notwithstanding the other comments from Bartosz, this seems like
>> a driver that should be using the regmap GPIO helper library.
>> git grep GPIO_REGMAP will show you examples of other drivers
>> that use this and how it is used.
>> 
>> Yours,
>> Linus Walleij
> 
> Hi,
> 
> thanks for the review and suggestion. I tried following your suggestion 
> and use
> GPIO_REGMAP to implement the driver.
> 
> Unfortunately I ran into two issues
> 1. reg_set_base == 0: for the devcie reg_set base is 0x0. In 
> gpio-regmap there
> are several tests for !reg_set_base. There doesn't seem a way to 
> distinguish
> between is set to 0 and is not set. :)

That's what GPIO_REGMAP_ADDR(addr) is for :)

> 2. input/output direction: to set a gpio pin to input one has to write 
> 0x1 to
> the corresponding output register. The issue starts when I configure a 
> port to
> be an output, set output to 0x1, check the direction of the pin, doing 
> so trough
> sysfs the system will now assume the pin is an input and I can't set 
> its values
> anymore. Avoiding this I would like to track the direction of the pin 
> separately
> from the device register, which is atm done in the corresponding 
> bespoke in/out
> functions.

I can't follow you here exactly. But I've briefly looked at the 
datasheet
and the output is an open drain one. Just like the one we are currently
discussing in [1]. Here too, there seems to be no direction register,
although it is mentioned in the datasheet. But Table 1. Register Address 
Map
is super confusing, so please correct me if I'm wrong.

Since we now have already two different chips with this OD output and 
always
active input buffer, it makes sense to add support to gpio-regmap for 
these
kind of devices. To me it is still unclear wether we need the direction 
at
all. Linus answered my question yesterday, but I haven't found time to 
dig
into that topic myself. Please go ahead and make some suggestions :)

> I could probably solve both of these issues trough the reg_mask_xlate 
> function
> but I believe this would introduce unneeded obscurity in the driver.
> 
> I do not believe there are any other easy obvious/better fixes for 
> this. (or
> maybe you prove me wrong :))
> Would you be okay for this driver to stick with direct regmap usage? 
> (obviously
> fixing the review suggestions)

-michael

[1] https://lore.kernel.org/r/20230502084406.3529645-1-michael@walle.cc/
