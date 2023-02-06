Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE10968C520
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBFRur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBFRup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:50:45 -0500
Received: from mail.multiname.org (h4.multiname.org [94.130.68.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C72C6E8D;
        Mon,  6 Feb 2023 09:50:40 -0800 (PST)
Received: from raab.fritz.box (unknown [IPv6:2a02:1748:dd5c:fec0:221:9bff:fe61:eebd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.multiname.org (Postfix) with ESMTPSA id 4P9YhF1lp1zPLtZK;
        Mon,  6 Feb 2023 18:50:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ccbib.org; s=20220806;
        t=1675705837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pgvTjhZIwd6T+wktgzrpaQ8ZtztqyWgYUhrRnVzADg4=;
        b=XIyBBB6faefzJGcYtdv4HqL3IT3Tx/eQDGwY8zjt+tBnBeVtkDj2PCpOEFjetuLUwXYmcp
        mT85mOI+Jj8Q+YoqxHWoG402COupTeGrIY+JQVum0h3iYRpIq/W+chfiKqc5kuxGls40qo
        OozLsYRfSMaJgq4+SO7pwWJCVayJ/+Mf11PXeceo7ZTmNsJSm0+kogbFz7SY5UNtlvyKiP
        840pyJQj0lCrORamWaKpI1B3a8Wb6CxeYE77Dw4fHeSIsN+btC04xMWkGsZ6GLjswmkmmD
        CI8HwNIY7OaMOkvInb4u0yESiHw2rymhavrBLP0IY8vIjrFvyYqNo7+kuje72pixnga/K2
        t9JAIO8V+/tcliLOYvvaRVhaByNowJESYeFWnkrIdOrW/qraQqMgSfBhp1y3A2iM3S53Lr
        KrCGVc0yBmrlGrfgblOHmMNQx9HLIe9rGkJSdtRrgTTMD5Yd/vNwNUriNL5thH1Chg53R/
        TYNbmxrSlZhevtGfo/mXx5y4UagPOI5i8Co9SOVQyTf3s4UMejMUVMEPVzWqfX5MZI81mp
        rm4OPr7ZgD7CZsGCjua2PjoJ3BzXrOBJ6vNQf3OWhSwbpsAZ+sMOJwk/NBZ9/ymmhrF96j
        SwzF56A3q0qdXYtCnQE2vSVA2b4ZLfbzAeRxjvU7Irjj2OxtRhFN4=
Message-ID: <cd836eb7dba528ab97f580876cd6ad7d90287582.camel@ccbib.org>
Subject: Re: [PATCH 1/2] iio: dht11: forked a driver version that polls
 sensor's signal from GPIO
From:   Harald Geyer <harald@ccbib.org>
To:     pelzi@flying-snail.de
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 06 Feb 2023 18:50:36 +0100
In-Reply-To: <3648e749-76de-01d3-f598-cb73de70d58a@feldner-bv.de>
References: <Y9groXq2oI6lqFea@debian-qemu.internal.flying-snail.de>
         <ee14f0c8bfbae887d21f827baece8b6e@ccbib.org>
         <d03ec6a7-62c0-0a82-a0f0-d2030ed5723d@feldner-bv.de>
         <9219a1dd4371a106f9eda9c90ef96066f9ff6446.camel@ccbib.org>
         <3648e749-76de-01d3-f598-cb73de70d58a@feldner-bv.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, dem 05.02.2023 um 18:46 +0100 schrieb
pelzi@flying-snail.de:
> As it turned out, on my Allwinner H3 based BananaPi M2 Zero, it is
> required to explicitly set a low IRQ debounce filter time, as there
> is
> a default debounce filter active that appears to filter something
> around 150µs. This causes IRQs from DTH11/22 devices to be filtered
> out, evenly over the transmission time.

Well, now this is embarrassing:
I actually have " input-debounce = <1>;" in the custom DTS for my
A20 based board. I completely forgot about this.

> Are there any useful next steps arising from this observation?
> Perhaps at least some Documentation?

dht11 is far from the only bitbanging driver. Not sure where to put
this. Maybe bring this up with the sunxi maintainers?

> I'm even concerned about the default
> setting being used by
> 
> arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> 
> As far as I understand, this setting applies to the full IRQ bank,
> appearently including GPIOs usable for UARTs including the separate
> UART used for debugging (CON3).

Without actually reading the data sheet I'm fairly confident, that
debouncing only happens in GPIO mode but not for any hardware
peripherals. At least UARTs don't generate an interrupt for every
bit.

> OTOH, applying the dt overlay below relaxes a filter and could make
> bounces show up in applications that do not currently experience
> bouncing artefacts.

Most drivers have their own debouncing logic in software. Some extra
load aside it shouldn't have any negative impact.

In the end it is up to the board and SoC DTS maintainers to decide
on sane defaults and maybe add some comments to their files.

HTH,
Harald


> Obviously, a polling version of the driver is not required in this
> case,
> I vote to rejecting it.
> 
> Cheers
> 
> Andreas
> 
> 
> // Definitions for dht11 module
> /*
> Adapted from dht11.dts for Raspberrypi, by Keith Hall
> Adapted by pelzi.
> */
> /dts-v1/;
> /plugin/;
> 
> / {
> 
>          fragment@0 {
>                  target-path = "/";
>                  __overlay__ {
> 
>                          temperature_humidity: dht11@6 {
>                                  compatible = "dht22", "dht11";
>                                  pinctrl-names = "default";
>                                  pinctrl-0 = <&dht11_pins>;
>                                  gpios = <&pio 0 6 0>; /* PA6 (PIN
> 7), 
> active high */
>                                  status = "okay";
>                          };
> 
>                  };
>          };
> 
>          fragment@1 {
>                  target = <&pio>;
>                  __overlay__ {
>                          input-debounce = <5 0>; /* 5µs debounce on
> IRQ 
> bank 0, default on bank 1 */
>                          dht11_pins: dht11_pins {
>                                  pins = "PA6";
>                                  function = "gpio_in";
>                                  /*bias-pull-up; not required for 3-
> pin 
> version of sensor */
>                          };
>                  };
>          };
> 
>          __overrides__ {
>                  gpiopin =       <&dht11_pins>,"pins:0",
> <&temperature_humidity>,"gpios:8";
>          };
> };
> 
> Am 02.02.23 um 21:53 schrieb Harald Geyer:
> > Am Mittwoch, dem 01.02.2023 um 13:51 +0100 schrieb
> > pelzi@flying-snail.de:
> > > I understand that the first priority is in finding out if there
> > > is
> > > actually a proper
> > > use case for a polling implementation at all. Only then, it might
> > > be
> > > worth to extend
> > > the existing dht11 module by an polling alternative.
> > > 
> > > Am 31.01.23 um 11:18 schrieb harald@ccbib.org:
> > > > On 2023-01-30 21:42, Andreas Feldner wrote:
> > > > > On a BananaPi M2 Zero, the existing, IRQ based dht11 driver
> > > > > is
> > > > > not
> > > > > working,
> > > > > but missing most IRQs.
> > > > That's quite surprising as the driver works well on many
> > > > similar
> > > > systems
> > > > based on Allwinner SoCs. I suspect the problem is with your
> > > > setup.
> > > > Maybe
> > > > some other (polling?) driver is slowing everything down.
> > > Can you give me a hint how to look for signs of such a situation?
> > The obvious things to try:
> > 
> > Enabling debug output for the dht11 driver, to look into which
> > interrupts are actually missing: Is it a "block" of interrupts?
> > Are they randomly distributed? Are they somewhat equally spaced?
> > This should give some hints about the nature of the problem.
> > 
> > Try to reproduce the problem on a minimal system:
> > Unload as many modules as possible.
> > Maybe just use a system on a ram disk.
> > As little user space programms running as possbile.
> > You might find OpenWRT helpful.
> > 
> > Try other kernel versions. (Unlikely, but it might be some
> > completely unrelated regression.)
> > 
> > Implement debugging output in your polling driver to investigate,
> > why *that* performs so bad. It probably is the same issue.
> > 
> > If this doesn't lead anywhere, then it is a tough problem, so
> > let's for now assume, you find something.
> > 
> > 
> > > BTW I took some pride in building the board's system image from
> > > reproduceable sources: Debian kernel package
> > > linux-image-5.10.0-20-armmp-lpae, and the device tree from ﻿﻿﻿﻿
> > > 
> > > arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> > > 
> > > So the setup should be reproducible, unlike other approaches
> > > advertised
> > > in the BananaPi forum...
> > > 
> > > What I did is
> > > 
> > > - check /proc/interrupts. The highest volume interrupts there are
> > > two
> > > instances of sunxi-mmc, one generating about 50 interrupts per
> > > second,
> > > the other about 25. Those (and most) interrupts are GICv2, but
> > > the
> > > GPIO
> > > releated are sunxi-pio-{level,edge}
> > > 
> > > - check dmesg: literally no messages apart from dht11_poll itself
> > > 
> > > - check top: sugov:0 is reported to eat 10% of one cpu, but I
> > > understand
> > > that's expected and an artifact anyway. Changing the scaling
> > > governor
> > > to
> > > "performance" eliminates this, but does not help in making the
> > > irq
> > > driven dht11 work.
> > > 
> > > - check vmstat: ir is between 50 and 200 apart from short spikes,
> > > those
> > > probably related to a certain cron job
> > > 
> > > - check sysstat cpu, mem, threads, mutex: each of the 4 cores has
> > > a
> > > low
> > > performance (a factor of 15 lower than a Raspberrypi 3), but
> > > constant,
> > > low stddev, etc. No surprises running e.g. 8 threads instead of
> > > 4.
> > > 
> > > So, apart from the fact that it is missing about 3/4 of the IRQs
> > > the
> > > dht11 driver should get, I have no indication that something
> > > might be
> > > wrong with the board or its setup. Where else should I look?
> > There are many possible issues, that are difficult to investigate
> > directly. E.g. cache poisoning, some code disabling interrupts just
> > a bit to long etc. Thus the use of minimal systems.
> > 
> > > > > Following the hints in Harald Geyer's comments I
> > > > > tried to implement a version of the driver that is polling
> > > > > the
> > > > > GPIO
> > > > > sensor in a busy loop, not using IRQ altogether.
> > > > IIRC one readout takes about 80 milliseconds. That's a very
> > > > long
> > > > time for
> > > > a busy loop. I doubt this is acceptable for inclusion in the
> > > > kernel. Of
> > > > course also Jonathan's comments apply.
> > > Seems to be a bit less, just in case that matters. Given the
> > > timing
> > > chart I'd expect
> > > 
> > > on average: 200µs + 40 * 100µs = 4,2ms
> > > 
> > > worst case (device trying to send all one-bits): 200µs + 40 *
> > > 120µs =
> > > 5,0ms
> > > 
> > Ack.
> > 
> > Good luck,
> > Harald
> > 
> > 


