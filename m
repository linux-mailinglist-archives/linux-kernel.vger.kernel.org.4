Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686465BEDA4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiITT0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiITT0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:26:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B729501B3;
        Tue, 20 Sep 2022 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663701971; x=1695237971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U1i4KKG54erJ7qy10D3Cu5MhJaA3JhI4yYQxdJTJq4E=;
  b=yyjQfW0mQs1uTyY46i7FlcX7oBAgnU1Wzfba+zkN5ZAmFiQ1vntEedZA
   o9SJeBdxww5MIMHUqNz3jewjVUu8Uk0V7gCojtfdTahOH86nDRK8EmeF3
   0kV7GWoSekdrBvyJboRYj5mFmUNtiG3iYvxVdOK+shRIuH9I3yYUD91cE
   awIJGoHTGufLgSzvBxeMDw9zeawcbZWkRW1QqzQNy7mXgwqL1KMV0Sq99
   SrbHlMLPaXezWty1gm2OMC1KYM6NtOfMkU0wXfL87PIBeBpM9wutO5T7D
   xZOHbUFlcW3r518zQ/KscUyIlhiaTetQ2UmAw5gGKdCLkHcTUTmI0VXGi
   g==;
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="178108389"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Sep 2022 12:26:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 20 Sep 2022 12:26:08 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 20 Sep 2022 12:26:08 -0700
Date:   Tue, 20 Sep 2022 21:30:33 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Michael Walle <michael@walle.cc>
CC:     <UNGLinuxDriver@microchip.com>, <andy.shevchenko@gmail.com>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] pinctrl: ocelot: Fix interrupt controller
Message-ID: <20220920193033.bpmyt6pdob5b45id@soft-dev3-1.localhost>
References: <20220909145942.844102-1-horatiu.vultur@microchip.com>
 <20220920120642.690340-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220920120642.690340-1-michael@walle.cc>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 09/20/2022 14:06, Michael Walle wrote:
> 
> Hi Horatiu,

Hi Walle,

> 
> > When an external device generated a level based interrupt then the
> > interrupt controller could miss the interrupt. The reason is that the
> > interrupt controller can detect only link changes.
> >
> > In the following example, if there is a PHY that generates an interrupt
> > then the following would happen. The GPIO detected that the interrupt
> > line changed, and then the 'ocelot_irq_handler' was called. Here it
> > detects which GPIO line saw the change and for that will call the
> > following:
> > 1. irq_mask
> > 2. phy interrupt routine
> > 3. irq_eoi
> > 4. irq_unmask
> >
> > And this works fine for simple cases, but if the PHY generates many
> > interrupts, for example when doing PTP timestamping, then the following
> > could happen. Again the function 'ocelot_irq_handler' will be called
> > and then from here the following could happen:
> > 1. irq_mask
> > 2. phy interrupt routine
> > 3. irq_eoi
> > 4. irq_unmask
> >
> > Right before step 3(irq_eoi), the PHY will generate another interrupt.
> > Now the interrupt controller will acknowledge the change in the
> > interrupt line. So we miss the interrupt.
> >
> > A solution will be to use 'handle_level_irq' instead of
> > 'handle_fasteoi_irq', because for this will change routine order of
> > handling the interrupt.
> > 1. irq_mask
> > 2. irq_ack
> > 3. phy interrupt routine
> > 4. irq_unmask
> >
> > And now if the PHY will generate a new interrupt before irq_unmask, the
> > interrupt controller will detect this because it already acknowledge the
> > change in interrupt line at step 2(irq_ack).
> >
> > But this is not the full solution because there is another issue. In
> > case there are 2 PHYs that share the interrupt line. For example phy1
> > generates an interrupt, then the following can happen:
> > 1.irq_mask
> > 2.irq_ack
> > 3.phy0 interrupt routine
> > 4.phy1 interrupt routine
> > 5.irq_unmask
> >
> > In case phy0 will generate an interrupt while clearing the interrupt
> > source in phy1, then the interrupt line will be kept down by phy0. So
> > the interrupt controller will not see any changes in the interrupt line.
> > The solution here is to update 'irq_unmask' such that it can detect if
> > the interrupt line is still active or not. And if it is active then call
> > again the procedure to clear the interrupts. But we don't want to do it
> > every time, only if we know that the interrupt controller has not seen
> > already that the interrupt line has changed.
> >
> > While at this, add support also for IRQ_TYPE_LEVEL_LOW.
> 
> Our board has a shared active low interrupt line, connected to a quad PHY
> LAN8814 and two GPY215 PHYs. I've gave this a try but it doesn't seem to
> work. It seems the interrupt fires multiple times. If I plug a cable in
> one of the LAN8814 ports, I see that the interrupt count in
> /proc/interrupts has increased by two. If I use a GPY215 port, I see about
> 40 interrupts firing.

I really don't know why would see 40 interrupts on GPY215. But I can
explain why you see 2 interrupts with LAN8814 ports.
The reason is that the interrupt controller in the pinctrl detects edges
and not levels. So if we take an example: the PHY will generate an
interrupt by pulling down the line. Then pinctrl detects this change in
the line so will start interrupt handler rutine. It would mask, ack,
call the PHY interrupt routine. At this point when the PHY clears the
interrupt source, the interrupt line will be high. So the interrupt
controller will see also this change. Then when the interrupt controller
will unmask the interrupt, it would generate a new one. And this is the
second interrupt.
I didn't know that is a big issue to get another interrupt. Because
before it was possible to miss interrupts, so I thought it was a pretty
fair trade.

Below I have a diff that I tried with LAN8814 PHYs and I could see that
count in /proc/interrupts is increasing correctly.

> 
> I've verified that there is only one low pulse on the interrupt line. I've
> noticed though, that the number of interrupts seem to be correlating with
> the length of the low pulse.
---
diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index c7df8c5fe5854..105771ff82e62 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1863,19 +1863,28 @@ static void ocelot_irq_unmask_level(struct irq_data *data)
 	if (val & bit)
 		ack = true;
 
+	/* Try to clear any rising edges */
+	if (!active && ack)
+		regmap_write_bits(info->map, REG(OCELOT_GPIO_INTR, info, gpio),
+				  bit, bit);
+
 	/* Enable the interrupt now */
 	gpiochip_enable_irq(chip, gpio);
 	regmap_update_bits(info->map, REG(OCELOT_GPIO_INTR_ENA, info, gpio),
 			   bit, bit);
 
 	/*
-	 * In case the interrupt line is still active and the interrupt
-	 * controller has not seen any changes in the interrupt line, then it
-	 * means that there happen another interrupt while the line was active.
+	 * In case the interrupt line is still active then it means that
+	 * there happen another interrupt while the line was active.
 	 * So we missed that one, so we need to kick the interrupt again
 	 * handler.
 	 */
-	if (active && !ack) {
+	regmap_read(info->map, REG(OCELOT_GPIO_IN, info, gpio), &val);
+	if ((!(val & bit) && trigger_level == IRQ_TYPE_LEVEL_LOW) ||
+	      (val & bit && trigger_level == IRQ_TYPE_LEVEL_HIGH))
+		active = true;
+
+	if (active) {
 		struct ocelot_irq_work *work;
 
 		work = kmalloc(sizeof(*work), GFP_ATOMIC);
---
> 
> -michael

-- 
/Horatiu
