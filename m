Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D0F62B0FE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 03:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiKPCDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 21:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiKPCDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:03:13 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FFD2B279
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 18:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=C0edP+5CzoBoY1VtDJ8nkSRH0n15MuNEUdduoWWkmOI=; b=BE6zCEeEupkNpUp9VzwLtnSNrX
        TZ/f2e2fQm8aoRGmcXQaJvbdYrEI7s9CSRzuaBJUUAb94KnjO0dYIZwi4EbRn++r179LYP3Z/AKiN
        C7kXuK934IrssyFAL0Ods0Di/znnJG2WcaidWJhwz3KmdNOIQaXuio93UmjdOuIcU6nM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ov7ld-002WGx-JA; Wed, 16 Nov 2022 03:03:09 +0100
Date:   Wed, 16 Nov 2022 03:03:09 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mvebu: switch to using gpiod API in pm-board code
Message-ID: <Y3RE3RjTRZ0uw4wZ@lunn.ch>
References: <Y3Qc6et/d+vhd71Q@google.com>
 <Y3Q4hVn3GEOm4nMq@lunn.ch>
 <Y3Q/k0hoPcnQhS8L@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Q/k0hoPcnQhS8L@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 05:40:35PM -0800, Dmitry Torokhov wrote:
> On Wed, Nov 16, 2022 at 02:10:29AM +0100, Andrew Lunn wrote:
> > > -		ret = gpio_direction_output(pic_gpios[i], 0);
> > > -		if (ret < 0) {
> > > -			gpio_free(pic_gpios[i]);
> > > +		pic_gpios[i] = fwnode_gpiod_get_index(of_fwnode_handle(np),
> > > +						      "ctrl", i, GPIOD_OUT_HIGH,
> > > +						      name);
> > 
> > The old code passes value=0 to gpio_direction_output(). For
> > fwnode_gpiod_get_index() you pass GPIOD_OUT_HIGH. Is this correct?
> 
> Yes, gpiod API works on logical states, whereas old gpio API used signal
> levels. In arch/arm/boot/dts/armada-xp-gp.dts ctrl-gpios are described
> as "active low":
> 
> 	cpus {
> 		pm_pic {
> 			ctrl-gpios = <&gpio0 16 GPIO_ACTIVE_LOW>,
> 				     <&gpio0 17 GPIO_ACTIVE_LOW>,
> 				     <&gpio0 18 GPIO_ACTIVE_LOW>;
> 		};
> 	};
> 
> so gpiolib will translate GPIOD_OUT_HIGH to 0 when setting final state
> of the pin.

Ah, yes. I knew that once, but it has gotten forgotten.

Thanks for the explanation and reminder.

       Andrew
