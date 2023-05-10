Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0A26FDB68
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbjEJKNW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 May 2023 06:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEJKNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:13:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 978292118;
        Wed, 10 May 2023 03:13:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BE051063;
        Wed, 10 May 2023 03:13:56 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 217DA3F5A1;
        Wed, 10 May 2023 03:13:09 -0700 (PDT)
Date:   Wed, 10 May 2023 11:13:06 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Maxim Kiselev' <bigunclemax@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Maxime Ripard <mripard@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 2/5] spi: sun6i: change OF match data to a struct
Message-ID: <20230510111306.52e30f26@donnerap.cambridge.arm.com>
In-Reply-To: <1592f46b0f794b24a87a964d7208da68@AcuMS.aculab.com>
References: <20230506232616.1792109-1-bigunclemax@gmail.com>
        <20230506232616.1792109-3-bigunclemax@gmail.com>
        <702d085b3b814759a344886364c518f8@AcuMS.aculab.com>
        <CALHCpMh84Q8RAh2Y+cHzAvsm4h5zBZY=9fPF6OVmtLNvX+ePxQ@mail.gmail.com>
        <1592f46b0f794b24a87a964d7208da68@AcuMS.aculab.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 08:55:27 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

Hi David,

> From: Maxim Kiselev
> > Sent: 10 May 2023 09:34
> > 
> > Hi, David
> >   
> > > Is it worth doing a structure copy at this point?
> > > The 'cfg' data is short and constant and it would make

Sorry, I don't really get the reason for this. Since the data is constant,
wouldn't it make much more sense to keep it there in the const section,
which we need anyway? What would a second copy bring us?

> > > the code that uses it smaller and faster.  

Smaller: Do you mean the generated code? Not sure that really matters, but
your sketch below hints that the C code would get larger, more error prone
(you mention yourself that you skipped over the error checking) and most
importantly harder to read.

Faster: Do you have numbers that back that up, or does that solve a
particular problem of yours?
This is programming a SPI controller transfer, which runs in the vicinity
of a few Mbits/s. I doubt that saving a few memory accesses (once
per transfer, not per word) matters even the slightest?
The actual MMIO access to program the controller registers already takes
a few dozen to a few hundred cycles, so I doubt that doing a struct copy
saves us anything here, in practice.

Besides: Copying the pointer is the most common pattern in the kernel, I
believe. I just sampled 21 SPI drivers in the tree, 17 out of them do
this. The other either copy the members of the struct into the driver data
(which would be an option for us, too), or immediately consume the data in
the probe() routine.

If you have some good reason to optimise this, please send a patch (on
top).

Cheers,
Andre.

> > 
> > I'm sorry but I don't fully understand what you are suggesting.
> > In patch 3\5 we extend the sun6i_spi_cfg structure with the has_clk_ctl field.  
> 
> You are still only adding a second integer.
> 
> I'm suggesting that instead of sspi->cfg being a pointer to the
> config data it is a copy of the config data.
> So the assignment below becomes (ignoring error checks)
> 	memcpy(&sspi->cfg, of_device_get_match_data(&pdev->dev), sizeof sspi->cfg);
> and the code that needs the values is:
> 	sspi->cfg.fifo_depth
> (etc)
> 
> 	David
> 
> > 
> > пн, 8 мая 2023 г. в 12:47, David Laight <David.Laight@aculab.com>:  
> > >
> > > From: Maksim Kiselev  
> > > > Sent: 07 May 2023 00:26
> > > >
> > > > As we're adding more properties to the OF match data, convert it to a
> > > > struct now.
> > > >  
> > > ...  
> > > > -     sspi->fifo_depth = (unsigned long)of_device_get_match_data(&pdev->dev);
> > > > +     sspi->cfg = of_device_get_match_data(&pdev->dev);  
> > >
> > > Is it worth doing a structure copy at this point?
> > > The 'cfg' data is short and constant and it would make
> > > the code that uses it smaller and faster.
> > >
> > >         David
> > >
> > > -
> > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > > Registration No: 1397386 (Wales)
> > >  
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

