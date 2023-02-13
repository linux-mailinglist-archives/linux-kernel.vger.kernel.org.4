Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDCF6944EA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjBML5B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Feb 2023 06:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBML5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:57:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AC7F1353E;
        Mon, 13 Feb 2023 03:56:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 890A44B3;
        Mon, 13 Feb 2023 03:57:40 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D2A73F703;
        Mon, 13 Feb 2023 03:56:56 -0800 (PST)
Date:   Mon, 13 Feb 2023 11:56:52 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     pelzi@flying-snail.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: allwinner: minimize irq debounce filter per
 default
Message-ID: <20230213115652.3ab4f25c@donnerap.cambridge.arm.com>
In-Reply-To: <20230213091803.bxle6ly2sapodsbs@houat>
References: <Y+FaVorMl37F5Dve@debian-qemu.internal.flying-snail.de>
        <20230207011608.2ce24d17@slackpad.lan>
        <d0534762-3785-ec2d-8d1e-aba0e39f701b@feldner-bv.de>
        <20230209202952.673d5a60@slackpad.lan>
        <20230210082936.qefzz4fsp3jpalvp@houat>
        <20230210094425.474cfba5@donnerap.cambridge.arm.com>
        <20230210100620.z6j7rvkiwyu7paij@houat>
        <20230210101814.2d36ae57@donnerap.cambridge.arm.com>
        <20230213084329.ulckaigwd7dof37u@houat>
        <c3dda403-6963-040a-3827-443edf0a377a@flying-snail.de>
        <20230213091803.bxle6ly2sapodsbs@houat>
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

On Mon, 13 Feb 2023 10:18:03 +0100
Maxime Ripard <maxime@cerno.tech> wrote:

Hi,

> On Mon, Feb 13, 2023 at 09:49:55AM +0100, pelzi@flying-snail.de wrote:
> > Am 13.02.23 um 09:43 schrieb Maxime Ripard:  
> > > On Fri, Feb 10, 2023 at 10:18:14AM +0000, Andre Przywara wrote:  
> > > > > > Not sure if you were actually arguing this, but the change I sketched
> > > > > > above (interpreting 0 as 24MHz/1) is separate though, as the current
> > > > > > default is "no DT property", and not 0. There is no input-debounce
> > > > > > property user in the kernel tree at the moment, so we wouldn't break
> > > > > > anyone. The only thing that would change is if a downstream user was
> > > > > > relying on "0" being interpreted as "skip the setup", which isn't
> > > > > > really documented and could be argued to be an implementation detail.
> > > > > > 
> > > > > > So I'd suggest to implement 0 as "lowest possible", and documenting that
> > > > > > and the 32KHz/1 default if no property is given.  
> > > > > Ah, my bad.
> > > > > 
> > > > > There's another thing to consider: there's already a generic per-pin
> > > > > input-debounce property in pinctrl.
> > > > > 
> > > > > Since we can't control it per pin but per bank, we moved it to the
> > > > > controller back then, but there's always been this (implicit)
> > > > > expectation that it was behaving the same way.
> > > > > 
> > > > > And the generic, per-pin, input-debounce documentation says:
> > > > >   
> > > > > > Takes the debounce time in usec as argument or 0 to disable debouncing  
> > > > > I agree that silently ignoring it is not great, but interpreting 0 as
> > > > > the lowest possible is breaking that behaviour which, I believe, is a
> > > > > worse outcome.  
> > > > Is it really? If I understand the hardware manuals correctly, we cannot
> > > > really turn that feature off, so isn't the lowest possible time period (24
> > > > MHz/1 at the moment) the closest we can get to "turn it off"? So
> > > > implementing this would bring us actually closer to the documented
> > > > behaviour? Or did I get the meaning of this time period wrong?
> > > > At least that's my understanding of how it fixed Andreas' problem: 1µs
> > > > is still not "off", but much better than the 31µs of the default. The new
> > > > 0 would then be 0.041µs.  
> > > My point was that the property we share the name (and should share the
> > > semantics with) documents 0 as disabled. We would have a behavior that
> > > doesn't disable it. It's inconsistent.
> > > 
> > > The reason doesn't really matter, we would share the same name but have
> > > a completely different behavior, this is super confusing to me.  
> > 
> > I got the point. As far as I can tell from the datasheet, it is not possible
> > to actually switch off input-debounce. But as a debounce filter is actually
> > a low-pass filter, setting the cut-off frequency as high as possible,
> > appears to be the equivalent to switching it off.  
> 
> It's not really a matter of hardware here, it's a matter of driver
> behavior vs generic behavior from the framework. The hardware obviously
> influences the former, but it's marginal in that discussion.
> 
> As that whole discussion shows, whether the frequency would be high
> enough is application dependent, and thus we cannot just claim that it's
> equivalent in all circumstances.
> 
> Making such an assumption will just bite someone else down the road,
> except this time we will have users (you, I'd assume) relying on that
> behavior so we wouldn't be able to address it.
> 
> But I also agree with the fact that doing nothing with 0 is bad UX and
> confusing as well.
> 
> I still think that we can address both by just erroring out on 0 /
> printing an error message so that it's obvious that we can't support it,
> and we wouldn't change the semantics of the property either.
> 
> And then you can set the actual debouncing time you need instead of
> "whatever" in the device tree.

I am on the same page with regards to discouraging 0 as a proper value, and
that we should warn if this is being used.
However I think we should at the same time try to still get as low as
possible when 0 is specified. The debounce property uses microseconds as
the unit, but even the AW hardware allows us to go lower than this. So we
would leave that on the table, somewhat needlessly: input-debounce = <1>
would give us 1333 ns, when the lowest possible is about 42 ns (1/24MHz).

So what about the following:
We document that 0 does not mean off, but tries to get as low as possible.
If the driver sees 0, it issues a warning, but still tries to lower the
debounce period as much as possible, and reports that, like:
[1.2345678] 1c20800.pinctrl: cannot turn off debouncing, setting to 41.7 ns

Alternatively we use a different property name, if that is a concern. We
could then use nanoseconds as a unit value, and then can error out on 0.
Re-using input-debounce is somewhat dodgy anyway, since the generic
property is for a single value only, per pin (in the pinmux DT node, not
in the controller node), whereas we use an array of some non-obvious
subset of ports.

Cheers,
Andre
