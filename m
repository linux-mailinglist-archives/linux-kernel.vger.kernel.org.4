Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EA35F6559
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJFLoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJFLoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:44:03 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0541A9DDA6;
        Thu,  6 Oct 2022 04:43:58 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id DB7D91252;
        Thu,  6 Oct 2022 13:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1665056636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQw0wDH4FecuagZPR9Xe1DTPLfd3Ze9IHb/ngKVf0nw=;
        b=B0gy8g+rxqinFTPXGVAP5q4IN2Tt7xqyZTEQ57opSwnr2vmOMyaupSULFZ6j2xXzDut47C
        f63jToeuSmUa0L0tNRjudJs0iZv/izJimN5hQw/Jipn7CRlQCH+OjRZV0gtSRlKFO++NEp
        iOIlkPXgGMoNwsUnxqrcx7BCOynKwcaaTIsdwt7luHCenpm2qhxU1ss0bGeV+xUrIC9BAX
        NF49d267A0sZ3T3SwBGW76C+PEMxIyD/yRhDsdAogMsQ5yBzal4+IXrMkymGHbAR5XBVWp
        kOZI3LCIoy4SzwlaLXJoAqGJ+8P0TvNP2Ygy4AlqTngKcSnRM4Av5c8Lusbq5Q==
MIME-Version: 1.0
Date:   Thu, 06 Oct 2022 13:43:56 +0200
From:   Michael Walle <michael@walle.cc>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     UNGLinuxDriver@microchip.com, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pinctrl: ocelot: Fix interrupt controller
In-Reply-To: <20220920193033.bpmyt6pdob5b45id@soft-dev3-1.localhost>
References: <20220909145942.844102-1-horatiu.vultur@microchip.com>
 <20220920120642.690340-1-michael@walle.cc>
 <20220920193033.bpmyt6pdob5b45id@soft-dev3-1.localhost>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <683fc322fddebe39a93a46aefcd5e2dd@walle.cc>
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

Am 2022-09-20 21:30, schrieb Horatiu Vultur:
> The 09/20/2022 14:06, Michael Walle wrote:
>> > When an external device generated a level based interrupt then the
>> > interrupt controller could miss the interrupt. The reason is that the
>> > interrupt controller can detect only link changes.
>> >
>> > In the following example, if there is a PHY that generates an interrupt
>> > then the following would happen. The GPIO detected that the interrupt
>> > line changed, and then the 'ocelot_irq_handler' was called. Here it
>> > detects which GPIO line saw the change and for that will call the
>> > following:
>> > 1. irq_mask
>> > 2. phy interrupt routine
>> > 3. irq_eoi
>> > 4. irq_unmask
>> >
>> > And this works fine for simple cases, but if the PHY generates many
>> > interrupts, for example when doing PTP timestamping, then the following
>> > could happen. Again the function 'ocelot_irq_handler' will be called
>> > and then from here the following could happen:
>> > 1. irq_mask
>> > 2. phy interrupt routine
>> > 3. irq_eoi
>> > 4. irq_unmask
>> >
>> > Right before step 3(irq_eoi), the PHY will generate another interrupt.
>> > Now the interrupt controller will acknowledge the change in the
>> > interrupt line. So we miss the interrupt.
>> >
>> > A solution will be to use 'handle_level_irq' instead of
>> > 'handle_fasteoi_irq', because for this will change routine order of
>> > handling the interrupt.
>> > 1. irq_mask
>> > 2. irq_ack
>> > 3. phy interrupt routine
>> > 4. irq_unmask
>> >
>> > And now if the PHY will generate a new interrupt before irq_unmask, the
>> > interrupt controller will detect this because it already acknowledge the
>> > change in interrupt line at step 2(irq_ack).
>> >
>> > But this is not the full solution because there is another issue. In
>> > case there are 2 PHYs that share the interrupt line. For example phy1
>> > generates an interrupt, then the following can happen:
>> > 1.irq_mask
>> > 2.irq_ack
>> > 3.phy0 interrupt routine
>> > 4.phy1 interrupt routine
>> > 5.irq_unmask
>> >
>> > In case phy0 will generate an interrupt while clearing the interrupt
>> > source in phy1, then the interrupt line will be kept down by phy0. So
>> > the interrupt controller will not see any changes in the interrupt line.
>> > The solution here is to update 'irq_unmask' such that it can detect if
>> > the interrupt line is still active or not. And if it is active then call
>> > again the procedure to clear the interrupts. But we don't want to do it
>> > every time, only if we know that the interrupt controller has not seen
>> > already that the interrupt line has changed.
>> >
>> > While at this, add support also for IRQ_TYPE_LEVEL_LOW.
>> 
>> Our board has a shared active low interrupt line, connected to a quad 
>> PHY
>> LAN8814 and two GPY215 PHYs. I've gave this a try but it doesn't seem 
>> to
>> work. It seems the interrupt fires multiple times. If I plug a cable 
>> in
>> one of the LAN8814 ports, I see that the interrupt count in
>> /proc/interrupts has increased by two. If I use a GPY215 port, I see 
>> about
>> 40 interrupts firing.
> 
> I really don't know why would see 40 interrupts on GPY215.

The GPY215 seems to be broken in this regard and hold the interrupt
line asserted even after its interrupt status register is read.

> But I can
> explain why you see 2 interrupts with LAN8814 ports.
> The reason is that the interrupt controller in the pinctrl detects 
> edges
> and not levels. So if we take an example: the PHY will generate an
> interrupt by pulling down the line. Then pinctrl detects this change in
> the line so will start interrupt handler rutine. It would mask, ack,
> call the PHY interrupt routine. At this point when the PHY clears the
> interrupt source, the interrupt line will be high. So the interrupt
> controller will see also this change. Then when the interrupt 
> controller
> will unmask the interrupt, it would generate a new one. And this is the
> second interrupt.
> I didn't know that is a big issue to get another interrupt. Because
> before it was possible to miss interrupts, so I thought it was a pretty
> fair trade.

Seeing 20 was definitely fishy, seeing two instead of one maybe not
so much. I guess it will create one spurious interrupt if none of
the registered handlers will care.

OTOH, the code below won't work in all cases anyway, right? It's just
best effort.

> Below I have a diff that I tried with LAN8814 PHYs and I could see that
> count in /proc/interrupts is increasing correctly.
> 
>> I've verified that there is only one low pulse on the interrupt line. 
>> I've
>> noticed though, that the number of interrupts seem to be correlating 
>> with
>> the length of the low pulse.
> ---
> diff --git a/drivers/pinctrl/pinctrl-ocelot.c 
> b/drivers/pinctrl/pinctrl-ocelot.c
> index c7df8c5fe5854..105771ff82e62 100644
> --- a/drivers/pinctrl/pinctrl-ocelot.c
> +++ b/drivers/pinctrl/pinctrl-ocelot.c
> @@ -1863,19 +1863,28 @@ static void ocelot_irq_unmask_level(struct
> irq_data *data)
>  	if (val & bit)
>  		ack = true;
> 
> +	/* Try to clear any rising edges */
> +	if (!active && ack)
> +		regmap_write_bits(info->map, REG(OCELOT_GPIO_INTR, info, gpio),
> +				  bit, bit);

Might we lose interrupts here, if the line would go active again right
after the read of the line state and before reading the "ack" bit?

> +
>  	/* Enable the interrupt now */
>  	gpiochip_enable_irq(chip, gpio);
>  	regmap_update_bits(info->map, REG(OCELOT_GPIO_INTR_ENA, info, gpio),
>  			   bit, bit);
> 
>  	/*
> -	 * In case the interrupt line is still active and the interrupt
> -	 * controller has not seen any changes in the interrupt line, then it
> -	 * means that there happen another interrupt while the line was 
> active.
> +	 * In case the interrupt line is still active then it means that
> +	 * there happen another interrupt while the line was active.
>  	 * So we missed that one, so we need to kick the interrupt again
>  	 * handler.
>  	 */
> -	if (active && !ack) {
> +	regmap_read(info->map, REG(OCELOT_GPIO_IN, info, gpio), &val);
> +	if ((!(val & bit) && trigger_level == IRQ_TYPE_LEVEL_LOW) ||
> +	      (val & bit && trigger_level == IRQ_TYPE_LEVEL_HIGH))
> +		active = true;

Why do you read the line state twice? What happens if the line state
changes right after you've read it?

> +
> +	if (active) {
>  		struct ocelot_irq_work *work;
> 
>  		work = kmalloc(sizeof(*work), GFP_ATOMIC);

So yes, maybe the trade-off that there will be two interrupts are
better than this additional patch. But it should be documented
somewhere, even if it's just a comment in this driver.

-michael
