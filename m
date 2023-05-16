Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B003704A27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjEPKKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjEPKJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:09:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910D12719;
        Tue, 16 May 2023 03:09:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F16C16374A;
        Tue, 16 May 2023 10:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DF8C4339E;
        Tue, 16 May 2023 10:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684231784;
        bh=UzWc5Lwm75FxyK+w8YmzHI/DvA777osEnR4l5zmjBh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OaXk2JUlwNc9953eKu4k6Tz88/RHcSQ8rAN8NQIWm6MZ7UtyQPb+nTSAEsZhCXBVf
         +XANWEmW4zXYMNZvFxACRsTpj47X29nqAcf9nIfyqGzYR3tsiiwqtLonq1fVvXFLwY
         EaqnQpFCrX5dV0ZfIPMxoNV5xeYCcHKO5+xnaYQnjMmLtEiCoDYZMRML44IgvRNpXN
         8ji3D//H6icA/jIND8ED/ofji+rWgN/sytWNwUR3Q0pRQi+0zQTOsE51S3fyJwOn8f
         EcpwXoYvQBP9mBGIYa2llUd5CdqZ3WeOFo/1knvE6ImJ46qrJ7FHALZW92M/3m+xfW
         a0TNvvur6xjTQ==
Date:   Tue, 16 May 2023 11:09:36 +0100
From:   Lee Jones <lee@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tglx@linutronix.de, linus.walleij@linaro.org,
        vkoul@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] irqchip/cs42l43: Add support for the cs42l43 IRQs
Message-ID: <20230516100936.GF10825@google.com>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-8-ckeepax@opensource.cirrus.com>
 <86o7mpmvqq.wl-maz@kernel.org>
 <20230512153933.GH68926@ediswmail.ad.cirrus.com>
 <86mt29mt2m.wl-maz@kernel.org>
 <20230515112554.GA10825@google.com>
 <86h6scmzf7.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86h6scmzf7.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023, Marc Zyngier wrote:

> On Mon, 15 May 2023 12:25:54 +0100,
> Lee Jones <lee@kernel.org> wrote:
> > 
> > On Fri, 12 May 2023, Marc Zyngier wrote:
> > 
> > > On Fri, 12 May 2023 16:39:33 +0100,
> > > Charles Keepax <ckeepax@opensource.cirrus.com> wrote:
> > > > 
> > > > On Fri, May 12, 2023 at 04:10:05PM +0100, Marc Zyngier wrote:
> > > > > On Fri, 12 May 2023 13:28:35 +0100,
> > > > > Charles Keepax <ckeepax@opensource.cirrus.com> wrote:
> > > > > > 
> > > > > > The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> > > > > > (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> > > > > > for portable applications. It provides a high dynamic range, stereo
> > > > > > DAC for headphone output, two integrated Class D amplifiers for
> > > > > > loudspeakers, and two ADCs for wired headset microphone input or
> > > > > > stereo line input. PDM inputs are provided for digital microphones.
> > > > > > 
> > > > > > The IRQ chip provides IRQ functionality both to other parts of the
> > > > > > cs42l43 device and to external devices that wish to use its IRQs.
> > > > > 
> > > > > Sorry, but this isn't much of an interrupt controller driver. A modern
> > > > > interrupt controller driver is firmware-driven (DT or ACPI, pick your
> > > > > poison), uses irq domains, and uses the irqchip API.
> > > > > 
> > > > 
> > > > Apologies but I really need a little help clarifying the issues
> > > > here. I am totally happy to fix things up but might need a couple
> > > > pointers.
> > > > 
> > > > 1) uses the irqchip API / uses irq domains
> > > > 
> > > > The driver does use both the irqchip API and domains, what
> > > > part of the IRQ API are we not using that we should be?
> > > > 
> > > > The driver registers an irq domain using
> > > > irq_domain_create_linear.  It requests its parent IRQ using
> > > > request_threaded_irq. It passes IRQs onto the devices requesting
> > > > IRQs from it using handle_nested_irq and irq_find_mapping.
> > > > 
> > > > Is the objection here that regmap is making these calls for us,
> > > > rather than them being hard coded into this driver?
> > > 
> > > That's one of the reasons. Look at the existing irqchip drivers: they
> > > have nothing in common with yours. The regmap irqchip abstraction may
> > > be convenient for what you are doing, but the result isn't really an
> > > irqchip driver. It is something that is a small bit of a larger device
> > > and not an interrupt controller driver on its own. The irqchip
> > > subsystem is there for "first class" interrupt controllers.
> > 
> > I'm not aware of another subsystem that deals with !IRQChip level IRQ
> > controllers.  Where do simple or "second class" interrupt controllers
> > go?
> 
> This isn't an interrupt controller. This is internal signalling, local
> to a single component that has been artificially broken into discrete
> bits, including an interrupt controller. The only *real* interrupts
> here are the GPIOs.
> 
> I'm happy to see an interrupt controller for the GPIOs. But the rest
> is just internal muck that doesn't really belong here. Where should it

You should have been a poet! =;-)

> go? Together with the rest of the stuff that manages the block as a
> whole. Which looks like the MFD subsystem to me.

Very well.  Let's see this "muck" in a patch please!

-- 
Lee Jones [李琼斯]
