Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FD65F766A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiJGJpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJGJpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:45:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00B933E1D;
        Fri,  7 Oct 2022 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665135907; x=1696671907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Ire7ZsaBoZrk4q5Oev/H2q9lfYP9QG/ubwbSlN/mx4=;
  b=NsHPj4dsFVOU2E5pS5w05ScN77haCPJiMIdM8KO5dYtvb2glhB8oDCoo
   KtoBFz+sRjG3mCM3Jkdsf/5HV64H2ks20v5dk1Mop7R+/8uvnDP94Y2wX
   9fttYgFXEs33ANQbF+fI+AXF5CLl/OrzV/O1tDSzJ3q1i9wuLELBkWB4s
   W1bpohE4EviVWzkinwl5UfcKLQfI8fymqIUhcDO7DmFzwHbqz0b4oMyJo
   V0PkEpv7NsaPL+vEupR5s5jTAcnNayUxc6Bq1CuGEKpUxTT8gqNhsEEul
   sQ2YIEdUj8OKxo1Z0k6LI8QEIPNbPi+sBVN8yZ9VRdX0etWYhoRmGkIFR
   A==;
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="183703352"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Oct 2022 02:45:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 7 Oct 2022 02:45:06 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 7 Oct 2022 02:45:05 -0700
Date:   Fri, 7 Oct 2022 11:49:38 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Michael Walle <michael@walle.cc>
CC:     <UNGLinuxDriver@microchip.com>, <andy.shevchenko@gmail.com>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] pinctrl: ocelot: Fix interrupt controller
Message-ID: <20221007094938.qqf7exuthvz5gkdq@soft-dev3-1.localhost>
References: <20220909145942.844102-1-horatiu.vultur@microchip.com>
 <20220920120642.690340-1-michael@walle.cc>
 <20220920193033.bpmyt6pdob5b45id@soft-dev3-1.localhost>
 <683fc322fddebe39a93a46aefcd5e2dd@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <683fc322fddebe39a93a46aefcd5e2dd@walle.cc>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/06/2022 13:43, Michael Walle wrote:

Hi Walle,

> Seeing 20 was definitely fishy, seeing two instead of one maybe not
> so much. I guess it will create one spurious interrupt if none of
> the registered handlers will care.
> 
> OTOH, the code below won't work in all cases anyway, right? It's just
> best effort.

I was expecting to work in all cases, but if you found some cases that
would not work, please point them out.

> 
> > Below I have a diff that I tried with LAN8814 PHYs and I could see that
> > count in /proc/interrupts is increasing correctly.
> > 
> > > I've verified that there is only one low pulse on the interrupt line.
> > > I've
> > > noticed though, that the number of interrupts seem to be correlating
> > > with
> > > the length of the low pulse.
> > ---
> > diff --git a/drivers/pinctrl/pinctrl-ocelot.c
> > b/drivers/pinctrl/pinctrl-ocelot.c
> > index c7df8c5fe5854..105771ff82e62 100644
> > --- a/drivers/pinctrl/pinctrl-ocelot.c
> > +++ b/drivers/pinctrl/pinctrl-ocelot.c
> > @@ -1863,19 +1863,28 @@ static void ocelot_irq_unmask_level(struct
> > irq_data *data)
> >       if (val & bit)
> >               ack = true;
> > 
> > +     /* Try to clear any rising edges */
> > +     if (!active && ack)
> > +             regmap_write_bits(info->map, REG(OCELOT_GPIO_INTR, info, gpio),
> > +                               bit, bit);
> 
> Might we lose interrupts here, if the line would go active again right
> after the read of the line state and before reading the "ack" bit?

We lose the interrupt here, as the HW will not generate another one
but at later point we read again the line status. And if the line is
active then we kick again the interrupt handler again.

> 
> > +
> >       /* Enable the interrupt now */
> >       gpiochip_enable_irq(chip, gpio);
> >       regmap_update_bits(info->map, REG(OCELOT_GPIO_INTR_ENA, info, gpio),
> >                          bit, bit);
> > 
> >       /*
> > -      * In case the interrupt line is still active and the interrupt
> > -      * controller has not seen any changes in the interrupt line, then it
> > -      * means that there happen another interrupt while the line was
> > active.
> > +      * In case the interrupt line is still active then it means that
> > +      * there happen another interrupt while the line was active.
> >        * So we missed that one, so we need to kick the interrupt again
> >        * handler.
> >        */
> > -     if (active && !ack) {
> > +     regmap_read(info->map, REG(OCELOT_GPIO_IN, info, gpio), &val);
> > +     if ((!(val & bit) && trigger_level == IRQ_TYPE_LEVEL_LOW) ||
> > +           (val & bit && trigger_level == IRQ_TYPE_LEVEL_HIGH))
> > +             active = true;
> 
> Why do you read the line state twice? What happens if the line state
> changes right after you've read it?

Here we need to read again the status because we might have clear the
ack of interrupt.
If the line becomes active right after this read, then the HW will
generate another interrupt as the interrupt is enabled and ack is
cleared.

> 
> > +
> > +     if (active) {
> >               struct ocelot_irq_work *work;
> > 
> >               work = kmalloc(sizeof(*work), GFP_ATOMIC);
> 
> So yes, maybe the trade-off that there will be two interrupts are
> better than this additional patch. But it should be documented
> somewhere, even if it's just a comment in this driver.
> 
> -michael

-- 
/Horatiu
