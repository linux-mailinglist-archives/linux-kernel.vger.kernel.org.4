Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB9E6F537C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjECIkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjECIjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:39:33 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138E04EF6;
        Wed,  3 May 2023 01:39:11 -0700 (PDT)
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 62D0C5F901;
        Wed,  3 May 2023 10:38:20 +0200 (CEST)
Message-ID: <bb2bce8b-4d99-1a15-3a34-055ee7637fe2@emlix.com>
Date:   Wed, 3 May 2023 10:37:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] gpio: max7317: Add gpio expander driver
Content-Language: de-DE, en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Michael Walle <michael@walle.cc>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230403114033.8336-1-edmund.berenson@emlix.com>
 <20230403114033.8336-2-edmund.berenson@emlix.com>
 <CACRpkdbnj-BiA8D0e4nza-za-E8g_AEBNjR4b3gWUZpw70U33g@mail.gmail.com>
From:   Edmund Berenson <edmund.berenson@emlix.com>
In-Reply-To: <CACRpkdbnj-BiA8D0e4nza-za-E8g_AEBNjR4b3gWUZpw70U33g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/23 16:05, Linus Walleij wrote:
> On Mon, Apr 3, 2023 at 1:41 PM Edmund Berenson
> <edmund.berenson@emlix.com> wrote:
> 
>> Add driver for maxim MAX7317 SPI-Interfaced 10 Port
>> GPIO Expander.
>>
>> v2: adjust driver to use regmap
>>
>> Co-developed-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
>> Signed-off-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
>> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
> 
> Notwithstanding the other comments from Bartosz, this seems like
> a driver that should be using the regmap GPIO helper library.
> git grep GPIO_REGMAP will show you examples of other drivers
> that use this and how it is used.
> 
> Yours,
> Linus Walleij

Hi,

thanks for the review and suggestion. I tried following your suggestion and use
GPIO_REGMAP to implement the driver.

Unfortunately I ran into two issues
1. reg_set_base == 0: for the devcie reg_set base is 0x0. In gpio-regmap there
are several tests for !reg_set_base. There doesn't seem a way to distinguish
between is set to 0 and is not set. :)

2. input/output direction: to set a gpio pin to input one has to write 0x1 to
the corresponding output register. The issue starts when I configure a port to
be an output, set output to 0x1, check the direction of the pin, doing so trough
sysfs the system will now assume the pin is an input and I can't set its values
anymore. Avoiding this I would like to track the direction of the pin separately
from the device register, which is atm done in the corresponding bespoke in/out
functions.

I could probably solve both of these issues trough the reg_mask_xlate function
but I believe this would introduce unneeded obscurity in the driver.

I do not believe there are any other easy obvious/better fixes for this. (or
maybe you prove me wrong :))
Would you be okay for this driver to stick with direct regmap usage? (obviously
fixing the review suggestions)

BR
Edmund

-- 
Edmund Berenson, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source
