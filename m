Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570865BE535
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiITMGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiITMGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:06:50 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A996866A41;
        Tue, 20 Sep 2022 05:06:48 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 983431CAC;
        Tue, 20 Sep 2022 14:06:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1663675606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GGJm4OddW5ycYbBK3aai1KOzFQZUa2U+B9jqRthWOQA=;
        b=EQPe+GDNHi8nwoB/SDtJPkZ5m7ExT+DPRvCTXDGaE8RQhPj4+si7TaSUzMKd3mwuGcZ8dg
        Gw40DfeOdOI+/AUUBv+7N3dpi5hKZqnpVrQRx4hem+hGspR51R+U/55Kpw1IlTg9vQxDad
        iUgumadC/h9J8iEySv489XK9lqt6SWGIFRVydvf3VKWxzXTQuS1k2U+MQw7h11IdmkHy2E
        UXo2yK9aJ6jngSy1dIVVx4mx40RITJnVJCT/ShDrqDRil7uHyR2LKHzCm1UkNQoFT9OIpI
        dgBQl0GS4zrNzfYVz6cfqmziwLPckjV6gpZARzqEL6v0sDBuTO1crOOPQf7RFA==
From:   Michael Walle <michael@walle.cc>
To:     horatiu.vultur@microchip.com
Cc:     UNGLinuxDriver@microchip.com, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v3] pinctrl: ocelot: Fix interrupt controller
Date:   Tue, 20 Sep 2022 14:06:42 +0200
Message-Id: <20220920120642.690340-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220909145942.844102-1-horatiu.vultur@microchip.com>
References: <20220909145942.844102-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horatiu,

> When an external device generated a level based interrupt then the
> interrupt controller could miss the interrupt. The reason is that the
> interrupt controller can detect only link changes.
> 
> In the following example, if there is a PHY that generates an interrupt
> then the following would happen. The GPIO detected that the interrupt
> line changed, and then the 'ocelot_irq_handler' was called. Here it
> detects which GPIO line saw the change and for that will call the
> following:
> 1. irq_mask
> 2. phy interrupt routine
> 3. irq_eoi
> 4. irq_unmask
> 
> And this works fine for simple cases, but if the PHY generates many
> interrupts, for example when doing PTP timestamping, then the following
> could happen. Again the function 'ocelot_irq_handler' will be called
> and then from here the following could happen:
> 1. irq_mask
> 2. phy interrupt routine
> 3. irq_eoi
> 4. irq_unmask
> 
> Right before step 3(irq_eoi), the PHY will generate another interrupt.
> Now the interrupt controller will acknowledge the change in the
> interrupt line. So we miss the interrupt.
> 
> A solution will be to use 'handle_level_irq' instead of
> 'handle_fasteoi_irq', because for this will change routine order of
> handling the interrupt.
> 1. irq_mask
> 2. irq_ack
> 3. phy interrupt routine
> 4. irq_unmask
> 
> And now if the PHY will generate a new interrupt before irq_unmask, the
> interrupt controller will detect this because it already acknowledge the
> change in interrupt line at step 2(irq_ack).
> 
> But this is not the full solution because there is another issue. In
> case there are 2 PHYs that share the interrupt line. For example phy1
> generates an interrupt, then the following can happen:
> 1.irq_mask
> 2.irq_ack
> 3.phy0 interrupt routine
> 4.phy1 interrupt routine
> 5.irq_unmask
> 
> In case phy0 will generate an interrupt while clearing the interrupt
> source in phy1, then the interrupt line will be kept down by phy0. So
> the interrupt controller will not see any changes in the interrupt line.
> The solution here is to update 'irq_unmask' such that it can detect if
> the interrupt line is still active or not. And if it is active then call
> again the procedure to clear the interrupts. But we don't want to do it
> every time, only if we know that the interrupt controller has not seen
> already that the interrupt line has changed.
> 
> While at this, add support also for IRQ_TYPE_LEVEL_LOW.

Our board has a shared active low interrupt line, connected to a quad PHY
LAN8814 and two GPY215 PHYs. I've gave this a try but it doesn't seem to
work. It seems the interrupt fires multiple times. If I plug a cable in
one of the LAN8814 ports, I see that the interrupt count in
/proc/interrupts has increased by two. If I use a GPY215 port, I see about
40 interrupts firing.

I've verified that there is only one low pulse on the interrupt line. I've
noticed though, that the number of interrupts seem to be correlating with
the length of the low pulse.

-michael
