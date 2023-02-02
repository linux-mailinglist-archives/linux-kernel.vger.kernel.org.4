Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7F3688896
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjBBUxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBBUxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:53:40 -0500
Received: from mail.multiname.org (h4.multiname.org [94.130.68.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6EE820C0;
        Thu,  2 Feb 2023 12:53:35 -0800 (PST)
Received: from raab.fritz.box (unknown [IPv6:2a02:1748:dd5c:fec0:221:9bff:fe61:eebd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.multiname.org (Postfix) with ESMTPSA id 4P79x82c1fzPLtZ3;
        Thu,  2 Feb 2023 21:53:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ccbib.org; s=20220806;
        t=1675371212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fcfs/jm/jBXmkn9R9xK8ZL6qp9KpPkXu/dbzTp+JAMI=;
        b=oE0QGnR5kQ4uzOThwvheH0wWypMZxZdaiyBRZ6bG1w8Sl7zvPI9Ox2qHtilYtZRx8veMaM
        YuvW9cAtd2dArmT9mATTIXK+rxlS0/lXhzNVDqqrNMMcuABxgRzt2KISjcly2Y8/EL5gXX
        ff8H3/ZOlxVe2aUiR8pTeKyrzH7nHsIK1mqxk20bRz3x3Ke6e1Z34iEPV7qPfW+/JG56wv
        Uz/vPm1h0lqPZ9XfFeTjdF1H9/vZeM5GuSN2EL6EGh38Ynr1BDtRaXKAOd4f3yd2IjzI/T
        erRtfKp3l7kXGwdBnHdosmv/slkUN2I/ekJlVoNb4migbV1wzM5xpBwyEEMTrcfVO2UbR8
        3ArEAStOSSTCgHS9hUq9mhYBSKM3EWtFczR9J/OVy20YfsJCHGOnqnSCAChICGrIPgi6F3
        yfd70CYlj94hEfCd1Tk96nIuo+/hN1/QLuzh3PWzCmaVt1zENl36y/vScHZfh94UERHaom
        Mmd7gSm5ot9UY8f3RhPCBSTnBSLUZ5fZJZyYLDCU5DuyllpS/Tpe3oWXC2ZWcOsf0zCUVB
        Hc6AQVJ8riMej8Jl8jvsSRwmdDNQFazm2AQ953DKoz2y2Xfrdj4K+D4SOIxuv2EtK4YuJW
        yJPlAHi1O8h1hQojHFxCAFVG7Zk5KEDBJFj7arRuNOt1bNYXgjZcc=
Message-ID: <9219a1dd4371a106f9eda9c90ef96066f9ff6446.camel@ccbib.org>
Subject: Re: [PATCH 1/2] iio: dht11: forked a driver version that polls
 sensor's signal from GPIO
From:   Harald Geyer <harald@ccbib.org>
To:     pelzi@flying-snail.de
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 02 Feb 2023 21:53:31 +0100
In-Reply-To: <d03ec6a7-62c0-0a82-a0f0-d2030ed5723d@feldner-bv.de>
References: <Y9groXq2oI6lqFea@debian-qemu.internal.flying-snail.de>
         <ee14f0c8bfbae887d21f827baece8b6e@ccbib.org>
         <d03ec6a7-62c0-0a82-a0f0-d2030ed5723d@feldner-bv.de>
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

Am Mittwoch, dem 01.02.2023 um 13:51 +0100 schrieb
pelzi@flying-snail.de:
> I understand that the first priority is in finding out if there is 
> actually a proper
> use case for a polling implementation at all. Only then, it might be 
> worth to extend
> the existing dht11 module by an polling alternative.
> 
> Am 31.01.23 um 11:18 schrieb harald@ccbib.org:
> > On 2023-01-30 21:42, Andreas Feldner wrote:
> > > On a BananaPi M2 Zero, the existing, IRQ based dht11 driver is
> > > not 
> > > working,
> > > but missing most IRQs.
> > 
> > That's quite surprising as the driver works well on many similar
> > systems
> > based on Allwinner SoCs. I suspect the problem is with your setup.
> > Maybe
> > some other (polling?) driver is slowing everything down.
> 
> Can you give me a hint how to look for signs of such a situation?

The obvious things to try:

Enabling debug output for the dht11 driver, to look into which
interrupts are actually missing: Is it a "block" of interrupts?
Are they randomly distributed? Are they somewhat equally spaced?
This should give some hints about the nature of the problem.

Try to reproduce the problem on a minimal system:
Unload as many modules as possible.
Maybe just use a system on a ram disk.
As little user space programms running as possbile.
You might find OpenWRT helpful.

Try other kernel versions. (Unlikely, but it might be some
completely unrelated regression.)

Implement debugging output in your polling driver to investigate,
why *that* performs so bad. It probably is the same issue.

If this doesn't lead anywhere, then it is a tough problem, so
let's for now assume, you find something.


> BTW I took some pride in building the board's system image from 
> reproduceable sources: Debian kernel package 
> linux-image-5.10.0-20-armmp-lpae, and the device tree from ﻿﻿﻿﻿
> 
> arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> 
> So the setup should be reproducible, unlike other approaches
> advertised 
> in the BananaPi forum...
> 
> What I did is
> 
> - check /proc/interrupts. The highest volume interrupts there are two
> instances of sunxi-mmc, one generating about 50 interrupts per
> second, 
> the other about 25. Those (and most) interrupts are GICv2, but the
> GPIO 
> releated are sunxi-pio-{level,edge}
> 
> - check dmesg: literally no messages apart from dht11_poll itself
> 
> - check top: sugov:0 is reported to eat 10% of one cpu, but I
> understand 
> that's expected and an artifact anyway. Changing the scaling governor
> to 
> "performance" eliminates this, but does not help in making the irq 
> driven dht11 work.
> 
> - check vmstat: ir is between 50 and 200 apart from short spikes,
> those 
> probably related to a certain cron job
> 
> - check sysstat cpu, mem, threads, mutex: each of the 4 cores has a
> low 
> performance (a factor of 15 lower than a Raspberrypi 3), but
> constant, 
> low stddev, etc. No surprises running e.g. 8 threads instead of 4.
> 
> So, apart from the fact that it is missing about 3/4 of the IRQs the 
> dht11 driver should get, I have no indication that something might be
> wrong with the board or its setup. Where else should I look?

There are many possible issues, that are difficult to investigate
directly. E.g. cache poisoning, some code disabling interrupts just
a bit to long etc. Thus the use of minimal systems.

> 
> > > Following the hints in Harald Geyer's comments I
> > > tried to implement a version of the driver that is polling the
> > > GPIO
> > > sensor in a busy loop, not using IRQ altogether.
> > 
> > IIRC one readout takes about 80 milliseconds. That's a very long
> > time for
> > a busy loop. I doubt this is acceptable for inclusion in the
> > kernel. Of
> > course also Jonathan's comments apply.
> 
> Seems to be a bit less, just in case that matters. Given the timing 
> chart I'd expect
> 
> on average: 200µs + 40 * 100µs = 4,2ms
> 
> worst case (device trying to send all one-bits): 200µs + 40 * 120µs =
> 5,0ms
> 

Ack.

Good luck,
Harald


