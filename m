Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E945FDC0F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJMOHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiJMOHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:07:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16A4EB767;
        Thu, 13 Oct 2022 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665670044; x=1697206044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vY6uO+jNAn+tvpv420fuR5jFnTNlc58jFDt7ZOWjCi4=;
  b=fwtWfL5mBBNRW1f7+3jY5PrjGX0NKtwyX2D8Bmoar/TzhRr2SYMkSW2L
   dMAmfxW7g608IBDseJWFjjNIgw2xP9qAUUO97cwrPx5J/JhL8hTojD4zo
   +99xvvAPzezn8KSk8Kbu25l+4aD4Lqpv+4i/mZ5n3ArsEhb0kuJY4mT/j
   MWKXEHdkZ2XsayWAXXLsh1AUZOQ27SWfXpE4hBb+BTgh2p0I8lyCB3CuX
   8vRLmJuopu4YJYbrqugvBrL5/5v5ByMfWDfcnksLtq9tRgJemSXWNUsfw
   fV0zmXHA1fNxRdK6kNwDOyepzYmRyGBm8ovvtZxbD/XoPJnXJSB3W94pE
   w==;
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="195240749"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Oct 2022 07:07:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 13 Oct 2022 07:07:13 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Thu, 13 Oct 2022 07:07:13 -0700
Date:   Thu, 13 Oct 2022 16:11:49 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Michael Walle <michael@walle.cc>
CC:     <UNGLinuxDriver@microchip.com>, <andy.shevchenko@gmail.com>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] pinctrl: ocelot: Fix interrupt controller
Message-ID: <20221013141149.zrcdtcfragerxdyw@soft-dev3-1>
References: <20220909145942.844102-1-horatiu.vultur@microchip.com>
 <20220920120642.690340-1-michael@walle.cc>
 <20220920193033.bpmyt6pdob5b45id@soft-dev3-1.localhost>
 <683fc322fddebe39a93a46aefcd5e2dd@walle.cc>
 <20221007094938.qqf7exuthvz5gkdq@soft-dev3-1.localhost>
 <994b3dfd8d5d2c0c11c2bf6f299564c1@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <994b3dfd8d5d2c0c11c2bf6f299564c1@walle.cc>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/13/2022 09:30, Michael Walle wrote:

Hi Michael,

> > We lose the interrupt here, as the HW will not generate another one
> > but at later point we read again the line status. And if the line is
> > active then we kick again the interrupt handler again.
> 
> Ahh, thanks for explaining. That also explains the read below.
> 
> Will you send a proper patch?

No worries. Yes, I will do that.

> 
> -michael
> 
> > 
> > > 
> > > > +
> > > >       /* Enable the interrupt now */
> > > >       gpiochip_enable_irq(chip, gpio);
> > > >       regmap_update_bits(info->map, REG(OCELOT_GPIO_INTR_ENA, info, gpio),
> > > >                          bit, bit);
> > > >
> > > >       /*
> > > > -      * In case the interrupt line is still active and the interrupt
> > > > -      * controller has not seen any changes in the interrupt line, then it
> > > > -      * means that there happen another interrupt while the line was
> > > > active.
> > > > +      * In case the interrupt line is still active then it means that
> > > > +      * there happen another interrupt while the line was active.
> > > >        * So we missed that one, so we need to kick the interrupt again
> > > >        * handler.
> > > >        */
> > > > -     if (active && !ack) {
> > > > +     regmap_read(info->map, REG(OCELOT_GPIO_IN, info, gpio), &val);
> > > > +     if ((!(val & bit) && trigger_level == IRQ_TYPE_LEVEL_LOW) ||
> > > > +           (val & bit && trigger_level == IRQ_TYPE_LEVEL_HIGH))
> > > > +             active = true;
> > > 
> > > Why do you read the line state twice? What happens if the line state
> > > changes right after you've read it?
> > 
> > Here we need to read again the status because we might have clear the
> > ack of interrupt.
> > If the line becomes active right after this read, then the HW will
> > generate another interrupt as the interrupt is enabled and ack is
> > cleared.
> > 
> > > 
> > > > +
> > > > +     if (active) {
> > > >               struct ocelot_irq_work *work;
> > > >
> > > >               work = kmalloc(sizeof(*work), GFP_ATOMIC);
> > > 
> > > So yes, maybe the trade-off that there will be two interrupts are
> > > better than this additional patch. But it should be documented
> > > somewhere, even if it's just a comment in this driver.
> > > 
> > > -michael

-- 
/Horatiu
