Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC3E6C91C4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 01:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCZABB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 20:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCZABA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 20:01:00 -0400
Received: from cynthia.allandria.com (cynthia.allandria.com [50.242.82.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53BC1FEA;
        Sat, 25 Mar 2023 17:00:58 -0700 (PDT)
Received: from flar by cynthia.allandria.com with local (Exim 4.84_2)
        (envelope-from <flar@allandria.com>)
        id 1pgDoe-0008NV-KE; Sat, 25 Mar 2023 17:00:56 -0700
Date:   Sat, 25 Mar 2023 17:00:56 -0700
From:   Brad Boyer <flar@allandria.com>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nubus: Don't list card resources by default
Message-ID: <20230326000056.GA31801@allandria.com>
References: <5b7c473247d66776343d82a55b9815195b1b11fb.1679551394.git.fthain@linux-m68k.org>
 <CAMuHMdUJ6kbpYGTjyY5dX+-YRv3pL0ydG3HQ-H1khyeqLOa05A@mail.gmail.com>
 <072fd894-ec50-ae5f-2be5-ebbeb0e7b39b@linux-m68k.org>
 <20230324085927.GA6354@allandria.com>
 <0cd7f288-ba43-7764-01a7-2e1e5c7a1640@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cd7f288-ba43-7764-01a7-2e1e5c7a1640@linux-m68k.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 10:35:52AM +1100, Finn Thain wrote:
> On Fri, 24 Mar 2023, Brad Boyer wrote:
> > On Fri, Mar 24, 2023 at 10:13:51AM +1100, Finn Thain wrote:
> > > That really depends on how the proc entries get used. I think it's 
> > > probably going to be developers who would use them so I consider all 
> > > of this to be outside of the UAPI and subject to change. But it would 
> > > be nice to hear from other developers on that point.
> > 
> > I don't know of anything that currently uses them, but there's a number 
> > of potential uses depending on how far we want to take things. A real 
> > video driver for X.org for some of the more advanced cards could take 
> > advantage of some of the secondary information made available. I've got 
> > a number of NuBus video cards with some acceleration capabilities that 
> > were pretty advanced for the time.
> 
> Good point. I had not considered Xorg drivers. But I'm not sure why 
> userspace drivers would access /proc when they already need /dev/mem or 
> some more modern graphics API to be implemented by an in-kernel driver.

I suppose so. I haven't looked at any of that in years. Back in the
past a ton of that was being done outside the kernel. X.org used to
manually parse the PCI tree and do a bunch of stuff on its own.

> > There's even a driver in the ROM on video cards that could be used, but 
> > that also requires more emulation of the MacOS environment. KVM could 
> > potentially need more information if we got it running on m68k, although 
> > I doubt any real Mac has enough RAM to make that useful.
> 
> You only need a few MB to run MacOS (or an early Linux distro). So I 
> rather think that KVM could be workable with 64 or 128 MB of RAM.
> 
> The /proc/bus/nubus/boards file is not affected by this patch, so userland 
> tools could still identify the available boards if need be.

That's probably enough, then. Device pass-through would be the main
place that would need more, but it would need full access to all
the slot memory anyway. That might even be a bad idea in general due
to the lack of an IOMMU. There are DMA capable cards which would then
have access to system memory. The kernel side of KVM doesn't look too
painful to implement, and m68k doesn't have some of the strange issues
of older x86 chips for running a VM.

> > I haven't looked at a Radius Rocket (a Mac on a card) to see if it has 
> > anything useful in these, but I wouldn't be surprised if there are 
> > useful things there. I've never tried to boot Linux on a system with one 
> > installed or booting Linux on the card itself. I have booted a second 
> > instance of the MacOS on one, and I seem to recall it shows up as a 
> > Q900. I have a couple x86 system cards that were intended to run DOS as 
> > well. There was an Apple II card for the LC slot, but I don't own one. 
> > LC slot cards show up in software as NuBus, as I recall.
> > 
> 
> I think those cards are in the same category as video cards in the sense 
> that userspace drivers would need /dev/mem.

Probably. I was just thinking that having some of the information
already parsed out might be useful. It's hard to say without having
anything written to use it.

> > It wouldn't be in userspace, but we could end up needing to pull 
> > firmware out of them for a number of different cards. I've got a couple 
> > SCSI cards that would need to have firmware loaded at runtime, and the 
> > ROM would have the default version even if we also allow a firmware file 
> > to override that. Based on the existing qlogicpti.c code, the ISP 1000 
> > chip (found on ATTO SiliconExpress IV cards) needs firmware. The older 
> > SiliconExpress cards all appear to use various ESP chips, so they likely 
> > don't need anything special. I suspect the various MCP based cards have 
> > useful things on the ROM for a driver to use. They each have a 68000 
> > chip on them running A/ROSE, which is presumably loaded from firmware as 
> > well. I have both ethernet and serial cards based on this platform. It 
> > appears that a driver for the specific card has to be loaded into A/ROSE 
> > on the card after it boots.
> > 
> 
> I had not considered that /proc could be used that way. Unfortunately, the 
> length of procfs entries is limited to PAGESIZE. Larger entries are listed 
> but have length 0. So I think this isn't going to fly.
> 
> Probably /dev/mem or a MacOS utility, or a ROM dump created by a MacOS 
> utility, would be needed to extract firmware from the MacOS ROM, such as 
> the firmware used by the IOP co-processors (which are standard equipment 
> on some models). The same solutions (though not ideal) could also work for 
> slot resources.

To be honest, anything in the kernel should have an explicit API out
of the NuBus infrastructure rather than poking at these virtual files.
That could be done without pre-loading all this stuff into memory. A
similar API out of the core macintosh support code could do the same
for the system ROM.

I was looking into a more complete IOP driver, and wrote a few parts 
of it. Doing it right will require reloading the embedded kernel into
each IOP as well as the individual channel drivers. Those are in the
ROM somewhere, as well as updated versions in system files. That's the
only practical way to pull an IOP out of bypass mode, as otherwise it
requires making a request that includes information that was passed
in when it was originally put into bypass mode. While we could probably
extract that out of IOP memory, it's not entirely clear (and definitely
undocumented) where it keeps that. We currently only use the individual
channel API calls (and only for ADB), but there's a whole separate IOP
kernel API that does a bunch of other useful stuff like managing bypass
mode and doing data transfer.

However, the system ROM doesn't use exactly the same structure as a
NuBus expansion ROM. That might complicate such work. It might be
easier to use the firmware infrastructure to load them from files
and extract the drivers from the latest system software that still
supported anything with an IOP. The updated IOP drivers are each
separate resources in the system file that could be extracted with
native developer utilities in MacOS. Then we presumably have the
latest. I've never found any hint that the IOP hardware was any
different between models that have them.

> > I've got a bunch of cards that I've never even looked at the resources 
> > built into the ROM chips, so I'm guessing on what might or might not be 
> > useful. At one point I was buying every card I could find that looked 
> > interesting, and many of them I've never tested. I have crates full of 
> > stuff, plus a bunch stacked up that came in original boxes.
> > 
> > Checking them is disabled now, but some Macs have fake NuBus resources 
> > for some of the onboard devices that show up as if they were in a 
> > virtual NuBus slot 0. Scanning that apparently caused problems on some 
> > models (presumably a bus error, since it would be accessing invalid 
> > addresses). Really old kernels had code to scan that protected by a 
> > compile time option.
> > 
> 
> I can't figure out why procfs access to the slot resources from pseudo 
> slot 0 would be desirable (?)

I'm not sure. Someone clearly thought it was useful in the past. I don't
think I have any models with anything interesting there. I suspect the
main thing would be an equivalent to the ROM on a video card for the
built-in display adapter on those systems.

	Brad Boyer
	flar@allandria.com

