Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37105691C93
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjBJKSV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Feb 2023 05:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjBJKST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:18:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1561F6CC63;
        Fri, 10 Feb 2023 02:18:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48C4A4B3;
        Fri, 10 Feb 2023 02:19:00 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 487C03F8C6;
        Fri, 10 Feb 2023 02:18:16 -0800 (PST)
Date:   Fri, 10 Feb 2023 10:18:14 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Andreas Feldner <andreas@feldner-bv.de>,
        Andreas Feldner <pelzi@flying-snail.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: allwinner: minimize irq debounce filter per
 default
Message-ID: <20230210101814.2d36ae57@donnerap.cambridge.arm.com>
In-Reply-To: <20230210100620.z6j7rvkiwyu7paij@houat>
References: <Y+FaVorMl37F5Dve@debian-qemu.internal.flying-snail.de>
        <20230207011608.2ce24d17@slackpad.lan>
        <d0534762-3785-ec2d-8d1e-aba0e39f701b@feldner-bv.de>
        <20230209202952.673d5a60@slackpad.lan>
        <20230210082936.qefzz4fsp3jpalvp@houat>
        <20230210094425.474cfba5@donnerap.cambridge.arm.com>
        <20230210100620.z6j7rvkiwyu7paij@houat>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 11:06:20 +0100
Maxime Ripard <maxime@cerno.tech> wrote:

> On Fri, Feb 10, 2023 at 09:44:25AM +0000, Andre Przywara wrote:
> > On Fri, 10 Feb 2023 09:29:36 +0100
> > Maxime Ripard <maxime@cerno.tech> wrote:
> > 
> > Hi Maxime,
> > 
> > thanks for the reply!
> >   
> > > On Thu, Feb 09, 2023 at 08:29:52PM +0000, Andre Przywara wrote:  
> > > > > >>   &pio {
> > > > > >> +	/* 1ï¿½s debounce filter on both IRQ banks */    
> > > > > > Is that supposed to be <micro> in UTF-8? It seems to have got lost in
> > > > > > translation, or is that just me?    
> > > > > O yes, the Greek character slipped into the comment.    
> > > > > >> +	input-debounce = <1 1>;    
> > > > > > As mentioned above, I am not so sure this is generic enough to put it
> > > > > > here for PA. And what is the significance of "1 us", in particular? Is
> > > > > > that just the smallest value?      
> > > > > 
> > > > > Yes indeed it's a bit more complicated than I feel it needs to be. The
> > > > > configuration is taken as microseconds and translated into the best
> > > > > matching clock and divider by the driver. However, 0 is not translated
> > > > > to the lowest divider of the high speed clock as would be logical if
> > > > > you ask for zero microseconds, but to "leave at default". The default
> > > > > of the board is 0 in the register, translating to lowest divider on the
> > > > > _low_ speed clock.    
> > > > 
> > > > I'd say the "if (!debounce) continue;" code is just to defend against
> > > > the division by zero, which would be the next statement to execute.
> > > > 
> > > > We might want to change that to interpret 0 as "lowest possible", which
> > > > would be 24MHz/1. Please feel free to send a patch in this regard, and
> > > > CC: Maxime, to get some input on that idea.    
> > > 
> > > I never had any complaint on that part either, so the default looks sane
> > > to me.
> > > 
> > > If some board needs a higher debouncing rate, then we should obviously
> > > set it up in the device tree of that board, but changing it for every
> > > user also introduces the risk of breaking other boards that actually
> > > require a lower debouncing frequency.  
> > 
> > Yeah, we definitely should keep the default at 32KHz/1, as this is also
> > the hardware reset value.
> > 
> > Not sure if you were actually arguing this, but the change I sketched
> > above (interpreting 0 as 24MHz/1) is separate though, as the current
> > default is "no DT property", and not 0. There is no input-debounce
> > property user in the kernel tree at the moment, so we wouldn't break
> > anyone. The only thing that would change is if a downstream user was
> > relying on "0" being interpreted as "skip the setup", which isn't
> > really documented and could be argued to be an implementation detail.
> > 
> > So I'd suggest to implement 0 as "lowest possible", and documenting that
> > and the 32KHz/1 default if no property is given.  
> 
> Ah, my bad.
> 
> There's another thing to consider: there's already a generic per-pin
> input-debounce property in pinctrl.
> 
> Since we can't control it per pin but per bank, we moved it to the
> controller back then, but there's always been this (implicit)
> expectation that it was behaving the same way.
> 
> And the generic, per-pin, input-debounce documentation says:
> 
> > Takes the debounce time in usec as argument or 0 to disable debouncing  
> 
> I agree that silently ignoring it is not great, but interpreting 0 as
> the lowest possible is breaking that behaviour which, I believe, is a
> worse outcome.

Is it really? If I understand the hardware manuals correctly, we cannot
really turn that feature off, so isn't the lowest possible time period (24
MHz/1 at the moment) the closest we can get to "turn it off"? So
implementing this would bring us actually closer to the documented
behaviour? Or did I get the meaning of this time period wrong?
At least that's my understanding of how it fixed Andreas' problem: 1µs
is still not "off", but much better than the 31µs of the default. The new
0 would then be 0.041µs.

Cheers,
Andre

> So I'm not sure what's the best course of action here. Rejecting the
> configuration entirely would prevent the entire pinctrl driver from
> probing which sounds really bad. Maybe we could just print an error that
> we rejected it to make it more obvious?
> 
> Maxime

