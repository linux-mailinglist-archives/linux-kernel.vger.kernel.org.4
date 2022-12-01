Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5024663E68B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLAAdD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Nov 2022 19:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiLAAdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:33:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9BCA41981;
        Wed, 30 Nov 2022 16:32:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67E7AD6E;
        Wed, 30 Nov 2022 16:33:01 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D8763F67D;
        Wed, 30 Nov 2022 16:32:50 -0800 (PST)
Date:   Thu, 1 Dec 2022 00:31:02 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Conor Dooley <conor@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        ajones@ventanamicro.com, heiko@sntech.de, samuel@sholland.org,
        wens@csie.org, jernej.skrabec@gmail.com,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, jszhang@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, apatel@ventanamicro.com,
        Atish Patra <atishp@rivosinc.com>, christianshewitt@gmail.com,
        Conor Dooley <conor.dooley@microchip.com>, guoren@kernel.org,
        heinrich.schuchardt@canonical.com, linus.walleij@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        stano.jakubek@gmail.com
Subject: Re: [PATCH v2 12/12] riscv: defconfig: Enable the Allwinner D1
 platform and drivers
Message-ID: <20221201003102.1b131a2d@slackpad.lan>
In-Reply-To: <mhng-f034544d-5b0a-47c5-8e45-3dbcefc0aaaa@palmer-ri-x1c9a>
References: <BBF52D3D-B8D3-4895-B316-33555E22C56B@kernel.org>
        <mhng-f034544d-5b0a-47c5-8e45-3dbcefc0aaaa@palmer-ri-x1c9a>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Wed, 30 Nov 2022 12:24:08 -0800 (PST)
Palmer Dabbelt <palmer@dabbelt.com> wrote:

Hi,

> On Mon, 28 Nov 2022 22:54:18 PST (-0800), Conor Dooley wrote:
> >
> >
> > On 29 November 2022 06:49:25 GMT, Andrew Jones <ajones@ventanamicro.com> wrote:  
> >>On Mon, Nov 28, 2022 at 09:17:38PM +0000, Conor Dooley wrote:  
> >>> On 28/11/2022 21:11, Heiko Stübner wrote:  
> >>> > Am Samstag, 26. November 2022, 17:40:11 CET schrieb Conor Dooley:  
> >>> >> On Fri, Nov 25, 2022 at 05:46:56PM -0600, Samuel Holland wrote:  
> >>> >>> Now that several D1-based boards are supported, enable the platform in
> >>> >>> our defconfig. Build in the drivers which are necessary to boot, such as
> >>> >>> the pinctrl, MMC, RTC (which provides critical clocks), SPI (for flash),
> >>> >>> and watchdog (which may be left enabled by the bootloader).  
> >>> >>
> >>> >> All of that looks good.
> >>> >>  
> >>> >>> Other common
> >>> >>> onboard peripherals are enabled as modules.  
> >>> >>
> >>> >> This I am not sure about though. I'll leave that to Palmer since I'm
> >>> >> pretty sure it was him that said it, but I thought the plan was only
> >>> >> turning on stuff required to boot to a console & things that are
> >>> >> generally useful rather than enabling modules for everyone's "random"
> >>> >> drivers. Palmer?  
> >>> > 
> >>> > Isn't the defconfig meant as a starting point to get working systems
> >>> > with minimal config effort? At least that was always the way to go on arm
> >>> > so far :-) .
> >>> > 
> >>> > So having boot-required drivers built-in with the rest enabled as modules
> >>> > for supported boards will allow people to boot theirs without headaches.
> >>> > 
> >>> > Disabling unneeded drivers if you're starved for storage space in a special
> >>> > project is always easier than hunting down all the drivers to enable for a
> >>> > specific board.   
> >>> 
> >>> I wouldn't mind being able to turn on all the PolarFire SoC stuff and
> >>> yeah, that would be the way that arm64 does it. But I do recall hearing
> >>> that I should not turn stuff on this way, when I initially tried to
> >>> turn stuff on via selects, got a nack and asked if I could do this instead.
> >>> 
> >>> But it may be that I misremember, which is why I appealed to the Higher
> >>> Powers for clarification :)  
> >>
> >>FWIW, I don't worry too much about modules in defconfig because I always
> >>immediately apply a 'LSMOD=$PWD/L localmodconfig' to it, where the L
> >>file is an lsmod output which only includes modules I need.  
> >
> > idk, defconfig to me is not about you or I, it's about A Developer that gets an SBC or a devkit and their experience.
> > Or alternatively, someone's CI ;)
> > I'd like to put everything in, but I recall that being shot down, that's all.  
> 
> The whole "who is defconfig for" discussion always ends up kind of 
> vague, but IIUC it's generally aimed at kernel hackers as opposed to end 
> users -- so it's not meant to be a disto config, that's why we have 
> things like the debug options turned on.  I tend to think of it as a "if 
> a patch submitter is going to test only one config, then what do I want 
> in it?" and let that determine what goes in defconfig.

Yes, this is also the guideline for arm64. On top of that it's supposed
to be a sane common config to be used to reproduce bugs. A common
question from maintainers is "Does it happen with defconfig?". If not,
what does it take on top of defconfig to get there?
The idea is that people can run the same config and thus the same image
on *their* boards, regardless of the particular platform.

> IMO having defconfig contain the drivers necessary to boot every common 
> dev board as =y, and having =m for anything else on those boards also 
> seem reasonable.  That will make the transition from vendor/distro 
> kernels to upstream a bit smoother, which is always good.  I guess 
> there's some slight build time and image size issues, but aside from 
> some very small systems that shouldn't be too bad for kernel developers 
> -- and if we really end up with another popular system with 6MiB of RAM 
> we can just stick another tiny defconfig in there for it.
> 
> I actually don't use modules when doing kernel development because I 
> find it easier to track things when they're packed into a single binary, 

Originally arm64 included most drivers as [=y], but this grew too big
quickly, so it was scaled back to be able to boot from the board's mass
storage (SD card, SATA, NVMe), with non-essential drivers included as
modules. And yes, most people just build and use the Image, which keeps
the build effort reasonable.
Also required features to make systemd happy, and to enable other core
distro features, were included, so that such kernels can boot distro
userland without losing significant functionality.

> but I don't think it's necessary to steer everyone that way.
> 
> Adding some of the Arm folks here, in case they have thoughts.  The best 
> bet is probably to try and do something similar, though my worry is that 
> the answer is something like "target standard platforms" and we don't 
> have any.

No such thing on arm64 either :-(

Cheers,
Andre
