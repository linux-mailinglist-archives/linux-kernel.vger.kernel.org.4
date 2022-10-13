Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC5A5FD58B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 09:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJMHad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 03:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJMHab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 03:30:31 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CC583F13;
        Thu, 13 Oct 2022 00:30:28 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id D0DF0124C;
        Thu, 13 Oct 2022 09:30:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1665646225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dWQKMf8oHDqlDBjs4uvnl/JyggLVUs+DUCx52N0nFiw=;
        b=kL2zuzA841Gbro7E/MV5Hnc+MBh4x6rWFCvJG8mSs4adpOKrPhTzq8OmGqPy+NEajTTcgx
        t0yWlg/5hPQf+tLiK+a36I2qxMQsXjxKzkFAC95i2fXDmp6eg+zbB+uOA+NW0uTfFSd7fr
        Be97bJCZoEiGlLakaUNzw0yxKAYx/2PTxVjSJFx0aLkwNW6nVn4WOxa+pg0RyHWTx/euaf
        w1XmwW4Ix0ZcoWEJ9hVwREsjKwVVAjqks6hkHczFL0AF5paulhLmi7yaxedIA9b4MkD9MA
        2pX9zmx/hcE6B5ABO5GWbP8fLUUcSSgb1metZBsBPXwPhYHRSoP5KgKsJgpocA==
MIME-Version: 1.0
Date:   Thu, 13 Oct 2022 09:30:25 +0200
From:   Michael Walle <michael@walle.cc>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     UNGLinuxDriver@microchip.com, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pinctrl: ocelot: Fix interrupt controller
In-Reply-To: <20221007094938.qqf7exuthvz5gkdq@soft-dev3-1.localhost>
References: <20220909145942.844102-1-horatiu.vultur@microchip.com>
 <20220920120642.690340-1-michael@walle.cc>
 <20220920193033.bpmyt6pdob5b45id@soft-dev3-1.localhost>
 <683fc322fddebe39a93a46aefcd5e2dd@walle.cc>
 <20221007094938.qqf7exuthvz5gkdq@soft-dev3-1.localhost>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <994b3dfd8d5d2c0c11c2bf6f299564c1@walle.cc>
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

Hi Horatiu,

Am 2022-10-07 11:49, schrieb Horatiu Vultur:
> The 10/06/2022 13:43, Michael Walle wrote:
> 
> Hi Walle,
> 
>> Seeing 20 was definitely fishy, seeing two instead of one maybe not
>> so much. I guess it will create one spurious interrupt if none of
>> the registered handlers will care.
>> 
>> OTOH, the code below won't work in all cases anyway, right? It's just
>> best effort.
> 
> I was expecting to work in all cases, but if you found some cases that
> would not work, please point them out.
> 
>> 
>> > Below I have a diff that I tried with LAN8814 PHYs and I could see that
>> > count in /proc/interrupts is increasing correctly.
>> >
>> > > I've verified that there is only one low pulse on the interrupt line.
>> > > I've
>> > > noticed though, that the number of interrupts seem to be correlating
>> > > with
>> > > the length of the low pulse.
>> > ---
>> > diff --git a/drivers/pinctrl/pinctrl-ocelot.c
>> > b/drivers/pinctrl/pinctrl-ocelot.c
>> > index c7df8c5fe5854..105771ff82e62 100644
>> > --- a/drivers/pinctrl/pinctrl-ocelot.c
>> > +++ b/drivers/pinctrl/pinctrl-ocelot.c
>> > @@ -1863,19 +1863,28 @@ static void ocelot_irq_unmask_level(struct
>> > irq_data *data)
>> >       if (val & bit)
>> >               ack = true;
>> >
>> > +     /* Try to clear any rising edges */
>> > +     if (!active && ack)
>> > +             regmap_write_bits(info->map, REG(OCELOT_GPIO_INTR, info, gpio),
>> > +                               bit, bit);
>> 
>> Might we lose interrupts here, if the line would go active again right
>> after the read of the line state and before reading the "ack" bit?
> 
> We lose the interrupt here, as the HW will not generate another one
> but at later point we read again the line status. And if the line is
> active then we kick again the interrupt handler again.

Ahh, thanks for explaining. That also explains the read below.

Will you send a proper patch?

-michael

> 
>> 
>> > +
>> >       /* Enable the interrupt now */
>> >       gpiochip_enable_irq(chip, gpio);
>> >       regmap_update_bits(info->map, REG(OCELOT_GPIO_INTR_ENA, info, gpio),
>> >                          bit, bit);
>> >
>> >       /*
>> > -      * In case the interrupt line is still active and the interrupt
>> > -      * controller has not seen any changes in the interrupt line, then it
>> > -      * means that there happen another interrupt while the line was
>> > active.
>> > +      * In case the interrupt line is still active then it means that
>> > +      * there happen another interrupt while the line was active.
>> >        * So we missed that one, so we need to kick the interrupt again
>> >        * handler.
>> >        */
>> > -     if (active && !ack) {
>> > +     regmap_read(info->map, REG(OCELOT_GPIO_IN, info, gpio), &val);
>> > +     if ((!(val & bit) && trigger_level == IRQ_TYPE_LEVEL_LOW) ||
>> > +           (val & bit && trigger_level == IRQ_TYPE_LEVEL_HIGH))
>> > +             active = true;
>> 
>> Why do you read the line state twice? What happens if the line state
>> changes right after you've read it?
> 
> Here we need to read again the status because we might have clear the
> ack of interrupt.
> If the line becomes active right after this read, then the HW will
> generate another interrupt as the interrupt is enabled and ack is
> cleared.
> 
>> 
>> > +
>> > +     if (active) {
>> >               struct ocelot_irq_work *work;
>> >
>> >               work = kmalloc(sizeof(*work), GFP_ATOMIC);
>> 
>> So yes, maybe the trade-off that there will be two interrupts are
>> better than this additional patch. But it should be documented
>> somewhere, even if it's just a comment in this driver.
>> 
>> -michael
