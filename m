Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8899570E21D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbjEWQis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbjEWQip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:38:45 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818E3C2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:38:42 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 45539f91-f988-11ed-b972-005056bdfda7;
        Tue, 23 May 2023 19:38:39 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 23 May 2023 19:38:39 +0300
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "johan@kernel.org" <johan@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Message-ID: <ZGzsD_HMbMGhGwcr@surfacebook>
References: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
 <CACRpkdYz9ipNTo2ORXKWy5Q4uCpKL=9Gd+kK76pestX7Onuz-Q@mail.gmail.com>
 <b36fcdf1-45ab-0c06-efe4-237df0612466@alliedtelesis.co.nz>
 <CACRpkdbiSAFoJP_JB1d_6gQ+Xx7Y+mLAh=C6Za+fpyWuRe6Gbw@mail.gmail.com>
 <31a23398-9b0e-4a19-3576-84fcfd3ce4b5@alliedtelesis.co.nz>
 <ZGQH8/hH0Llx3rzZ@sol>
 <a61415db-fa3f-2fce-9c21-08d8dd026960@alliedtelesis.co.nz>
 <CAHp75VfSnb2DWX8iMZ7BiSnrEquZdbzvTD+bcHk_Oc_rh7ectw@mail.gmail.com>
 <604467c7-c5d6-38b1-be98-42c7da031416@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <604467c7-c5d6-38b1-be98-42c7da031416@alliedtelesis.co.nz>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, May 17, 2023 at 09:30:51PM +0000, Chris Packham kirjoitti:
> On 17/05/23 20:54, Andy Shevchenko wrote:
> > On Wed, May 17, 2023 at 2:50 AM Chris Packham
> > <Chris.Packham@alliedtelesis.co.nz> wrote:
> >> On 17/05/23 10:47, Kent Gibson wrote:

...

> >> The first is a userspace driver for a Power Over Ethernet Controller+PSE
> >> chipset (I'll refer to this as an MCU since the thing we talk to is
> >> really a micro controller with a vendor supplied firmware on it that
> >> does most of the PoE stuff). Communication to the MCU is based around
> >> commands sent via i2c. But there are a few extra GPIOs that are used to
> >> reset the MCU as well as provide a mechanism for quickly dropping power
> >> on certain events (e.g. if the temperature monitoring detects a problem).
> > Why does the MCU have no in-kernel driver?
> 
> There isn't any PoE PSE infrastructure in the kernel. I'm not really 
> sure what it'd look like either as the hardware designs are all highly 
> customized and often have very specialized requirements. Even the vendor 
> reference boards tend to use the i2c userspace interface and punt 
> everything to a specialist application.
> 
> Of course if anyone is thinking about adding PoE PSE support in-kernel 
> I'd be very keen to be involved.

But what do net subsystem guys know about this? Have you had a chance
to ask them?

> >> We do have a small kernel module that grabs the GPIOs based on the
> >> device tree and exports them with a known names (e.g. "poe-reset",
> >> "poe-dis") that the userspace driver can use.
> > So, besides that you repeat gpio-aggregator functionality, you already
> > have a "proxy" driver in the kernel. What prevents you from doing more
> > in-kernel?
> 
> Yes true. The main issue is that without total support for the class of 
> device in the kernel there's little more that you can do other than 
> exposing gpios (either as gpio_export_link() or some other bespoke 
> interface).
> 
> >>   Back when that code was
> >> written we did consider not exporting the GPIOs and instead having some
> >> other sysfs/ioctl interface into this kernel module but that seemed more
> >> work than just calling gpiod_export() for little gain. This is where
> >> adding the gpio-names property in our .dts would allow libgpiod to do
> >> something similar.
> >>
> >> Having the GPIOs in sysfs is also convenient as we can have a systemd
> >> ExecStopPost script that can drop power and/or reset the MCU if our
> >> application crashes.
> > I'm a bit lost. What your app is doing and how that is related to the
> > (userspace) drivers?
> 
> Probably one of the primary things it's doing is bringing the chip out 
> of reset by driving the GPIO (we don't want the PoE PSE supplying power 
> if nothing is monitoring the temperature of the system). There's also 
> some corner cases involving not resetting the PoE chipset on a hot restart.

So, do I understand correct the following?
There is a PoE PSE which has a proprietary user space driver and to make it
work reliably we have to add a quirk which utilizes the GPIO sysfs?

> >> I'm not sure if the GPIO chardev interface deals
> >> with releasing the GPIO lines if the process that requested them exits
> >> abnormally (I assume it does) and obviously our ExecStopPost script
> >> would need updating to use some of the libgpiod applications to do what
> >> it currently does with a simple 'echo 1 >.../poe-reset'
> >>
> >> The second application is a userspace driver for a L3 network switch
> >> (actually two of them for different silicon vendors). Again this needs
> >> to deal with resets for PHYs connected to the switch that the kernel has
> >> no visibility of as well as the GPIOs for the SFP cages. Again we have a
> >> slightly less simple kernel module that grabs all these GPIOs and
> >> exports them with known names. This time there are considerably more of
> >> these GPIOs (our largest system currently has 96 SFP+ ports with 4 GPIOs
> >> per port) so we're much more reliant on being able to do things like
> >> `for x in port*tx-dis; do echo 1 >$x; done`
> > Hmm... Have you talked to the net subsystem guys? I know that there is
> > a lot going on around SFP cage enumeration for some of the modules
> > (Marvell?) and perhaps they can advise something different.
> 
> Yes I'm aware of the switchdev work and I'm very enthusiastic about it 
> (as an aside I do have a fairly functional switchdev driver for some of 
> the older Marvell Poncat2 silicon, never quite got to submitting it 
> upstream before we ran out of time on the project).
> 
> Again the problem boils down to the fact that we have a userspace switch 
> driver (which uses a vendor supplied non-free SDK). So despite the 
> kernel having quite good support for SFPs I can't use it without a 
> netdev to attach it to.

That user space driver is using what from the kernel? GPIO sysfs?

> >> I'm sure both of these applications could be re-written around libgpiod
> >> but that would incur a significant amount of regression testing on
> >> existing platforms. And I still consider dealing with GPIO chips an
> >> extra headache that the applications don't need (particularly with the
> >> sheer number of them the SFP case).
> > It seems to me that having no in-kernel driver for your stuff is the
> > main point of all headache here. But I might be mistaken.
> 
> It certainly doesn't help, but I do think that is all orthogonal to the 
> fact that gpio_is_visible() changes things rather than just determining 
> if an attribute should be exported or not.

Sorry for being unhelpful here. But without understanding the issue we can't
propose better solutions.


-- 
With Best Regards,
Andy Shevchenko


