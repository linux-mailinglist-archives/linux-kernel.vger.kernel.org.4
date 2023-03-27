Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8493B6C9EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjC0JIT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 05:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjC0JHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:07:45 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF0E199F;
        Mon, 27 Mar 2023 02:07:34 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pgip2-0003Ci-QW; Mon, 27 Mar 2023 11:07:24 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        Shane Francis <bigbeeshane@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: clock: update rk3588 clock definitions
Date:   Mon, 27 Mar 2023 11:07:23 +0200
Message-ID: <2874439.e9J7NaK4W3@diego>
In-Reply-To: <CABnpCuAqT-RtdmeaAqyB_CQkLa=vn8zxF_WkYRnj8FoGJLL=_Q@mail.gmail.com>
References: <20230326001535.149539-1-bigbeeshane@gmail.com>
 <87cz4v2nr1.fsf@bloch.sibelius.xs4all.nl>
 <CABnpCuAqT-RtdmeaAqyB_CQkLa=vn8zxF_WkYRnj8FoGJLL=_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 27. März 2023, 01:40:34 CEST schrieb Shane Francis:
> Hi Mark
> 
> > That code makes absolutely no sense.  This tries to transplant
> > phandles from one DTB into another DTB?  Mainline U-Boot has no code
> > like that.  I think this is just broken beyond repair.
> 
> Yeah its a dumb bit of code, my concern when looking at the R6S is that
> when devices look to get mainline support that are unable to change to
> another uboot build (such as when secure boot is involved)

when secure boot is involed, I'd think the whole device will be sufficiently
locked down to also disallow custom kernels. Otherwise that wouldn't be
a secure boot. (bootloader verifying kernel image + rootfs)


> those will
> have a hard time as this ABI breakage ship would have departed long
> ago. And the RK3588 support is very new..... I thought about raising it
> now.
> 
> The question for me is how (in the future) will devices with this SoC
> and cannot modify their uboot make use of the mainline kernel ?
> 
> I have looked into undoing this clock configuration during early kernel
> boot but the SoC seems to hard lock.
> 
> I apologise if raising this patch was a bad idea but like I stated to
> Krzysztof I am just onboarding this device as a hobby. However
> from an outside standpoint having a potential breakage like this
> because starting from 0 looked cleaner than 1 seems a bit odd to
> me.

In general we can't be on the "whim" of SoC vendors.

I.e. dt-bindings are supposed to be reviewed _first_ and not invented in
some SoC vendor's dark basement. That did work in the past with Rockchip
but in recent years they did loose most of their upstream momentum it
seems.

Because vendors often invent unpractical or even conflicting bindings on
their own.

So we're in a pickle here. As Peter said, _if_ we wanted to change the ids
one more time, to allow those vendor uboot hacks, now would be the time.

But then als Mark said, the current bindings are used already in a number
of different places and aren't broken per se.

So I guess either decision possibility is bad ;-)


Heiko


> On Sun, Mar 26, 2023 at 10:42 PM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >
> > > Date: Sun, 26 Mar 2023 22:02:39 +0200
> > > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > >
> > > On 26/03/2023 19:51, Shane Francis wrote:
> > > >> Bootloader also does not use mainline DTS, so where is exactly the problem?
> > > >
> > > > In this case uboot does load the target DTB, and it seems a common
> > > > function in rockchips
> > > > downstream boot process, see :
> > > >
> > > > https://github.com/rockchip-linux/u-boot/blob/ef1dd650042f61915c4859ecc94623a09a3529fa/arch/arm/mach-rockchip/kernel_dtb.c#L70
> > > >
> >
> > That code makes absolutely no sense.  This tries to transplant
> > phandles from one DTB into another DTB?  Mainline U-Boot has no code
> > like that.  I think this is just broken beyond repair.
> >
> > > U-Boot comes with its own DTB, so what does it means "loads the target
> > > DTB"? From where? The one appended to the kernel zImage? No, it cannot...
> > >
> > > Any component which operates on mainline DTB must conform to the
> > > bindings (with respect to the ABI), thus your arguments here mean you
> > > are not allowed to change ABI in the future. Never. This change,
> > > assuming original binding was broken, could be warranted.
> >
> > The current mainline binding isn't broken; 0 is a perfectly fine clock
> > index.  The RK3588 clock bindings are already used by U-Boot (too late
> > to fix for the 2023.4 release happening in a few days) and OpenBSD
> > (too late to fix for the 7.3 release that will happen a few weeks).
> > Changing the clock binding will just create more chaos.
> >
> > <rant>
> >
> > What is broken here is the development process.  Rockchip shouldn't be
> > maintaining these heavily modified forks of U-Boot and the Linux
> > kernel.  But at the same time mainline Linux developers should not be
> > asking for arbitrary changes to the device tree bindings just to
> > satisfy some unwritten rules.  The clock bindings were originaly
> > submitted with clock numbers identical to those that Rockchip uses:
> >
> >   https://lore.kernel.org/all/20220623160329.239501-2-sebastian.reichel@collabora.com/
> >
> > but then changed because a reviewer wanted them to start at 0 and
> > didn't want any holes:
> >
> >   https://lore.kernel.org/all/0841741a-22f6-40f6-c745-6065dfdbcb1d@linaro.org/
> >
> > This isn't the first example where this happened.  And it invariably
> > leads to confusion and breakage in projects that try to follow the
> > mainline Linux device tree bindings.
> >
> > </rant>
> 




