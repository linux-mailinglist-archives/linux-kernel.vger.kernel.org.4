Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7613B6C7C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjCXKEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjCXKE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:04:26 -0400
X-Greylist: delayed 1803 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Mar 2023 03:04:24 PDT
Received: from cynthia.allandria.com (cynthia.allandria.com [50.242.82.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E45C1B2C4;
        Fri, 24 Mar 2023 03:04:24 -0700 (PDT)
Received: from flar by cynthia.allandria.com with local (Exim 4.84_2)
        (envelope-from <flar@allandria.com>)
        id 1pfdGh-0001xM-91; Fri, 24 Mar 2023 01:59:27 -0700
Date:   Fri, 24 Mar 2023 01:59:27 -0700
From:   Brad Boyer <flar@allandria.com>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nubus: Don't list card resources by default
Message-ID: <20230324085927.GA6354@allandria.com>
References: <5b7c473247d66776343d82a55b9815195b1b11fb.1679551394.git.fthain@linux-m68k.org>
 <CAMuHMdUJ6kbpYGTjyY5dX+-YRv3pL0ydG3HQ-H1khyeqLOa05A@mail.gmail.com>
 <072fd894-ec50-ae5f-2be5-ebbeb0e7b39b@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <072fd894-ec50-ae5f-2be5-ebbeb0e7b39b@linux-m68k.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 10:13:51AM +1100, Finn Thain wrote:
> On Thu, 23 Mar 2023, Geert Uytterhoeven wrote:
> > On Thu, Mar 23, 2023 at 7:02???AM Finn Thain <fthain@linux-m68k.org> wrote:
> > > --- a/drivers/nubus/nubus.c
> > > +++ b/drivers/nubus/nubus.c
> > > @@ -34,6 +34,9 @@
> > >
> > >  LIST_HEAD(nubus_func_rsrcs);
> > >
> > > +bool procfs_rsrcs;
> > > +module_param(procfs_rsrcs, bool, 0444);
> > 
> > With the expanded functionality, is "rsrcs" still a good name?
> > Perhaps this should be an integer, so you can define different
> > levels? E.g.
> >   - 0 = just devices
> >   - 1 = above + boards + public resources
> >   - 2 = above + private resources
> 
> That really depends on how the proc entries get used. I think it's 
> probably going to be developers who would use them so I consider all of 
> this to be outside of the UAPI and subject to change. But it would be nice 
> to hear from other developers on that point.

I don't know of anything that currently uses them, but there's a number
of potential uses depending on how far we want to take things. A real
video driver for X.org for some of the more advanced cards could take
advantage of some of the secondary information made available. I've
got a number of NuBus video cards with some acceleration capabilities
that were pretty advanced for the time. There's even a driver in the
ROM on video cards that could be used, but that also requires more
emulation of the MacOS environment. KVM could potentially need more
information if we got it running on m68k, although I doubt any real
Mac has enough RAM to make that useful. I haven't looked at a Radius
Rocket (a Mac on a card) to see if it has anything useful in these,
but I wouldn't be surprised if there are useful things there. I've
never tried to boot Linux on a system with one installed or booting
Linux on the card itself. I have booted a second instance of the MacOS
on one, and I seem to recall it shows up as a Q900. I have a couple
x86 system cards that were intended to run DOS as well. There was
an Apple II card for the LC slot, but I don't own one. LC slot cards
show up in software as NuBus, as I recall.

It wouldn't be in userspace, but we could end up needing to pull
firmware out of them for a number of different cards. I've got a couple
SCSI cards that would need to have firmware loaded at runtime, and the
ROM would have the default version even if we also allow a firmware
file to override that. Based on the existing qlogicpti.c code, the
ISP 1000 chip (found on ATTO SiliconExpress IV cards) needs firmware.
The older SiliconExpress cards all appear to use various ESP chips,
so they likely don't need anything special. I suspect the various MCP
based cards have useful things on the ROM for a driver to use. They
each have a 68000 chip on them running A/ROSE, which is presumably
loaded from firmware as well. I have both ethernet and serial cards
based on this platform. It appears that a driver for the specific
card has to be loaded into A/ROSE on the card after it boots.

I've got a bunch of cards that I've never even looked at the resources
built into the ROM chips, so I'm guessing on what might or might not
be useful. At one point I was buying every card I could find that
looked interesting, and many of them I've never tested. I have crates
full of stuff, plus a bunch stacked up that came in original boxes.

Checking them is disabled now, but some Macs have fake NuBus resources
for some of the onboard devices that show up as if they were in a
virtual NuBus slot 0. Scanning that apparently caused problems on some
models (presumably a bus error, since it would be accessing invalid
addresses). Really old kernels had code to scan that protected by a
compile time option.

> Regarding terminology, the files in /proc/bus/nubus/*/ are termed 
> "records" or "entries" while the subdirectories may represent boards, slot 
> resources or tables of entries. So a parameter like "proc_entries" (in 
> effect nubus.proc_entries) might be more apt than "procfs_rsrcs".
> 
> Linux "devices" correspond to the "functional resources" offered by a 
> card. (Other resources have other purposes.)
> 
> I don't know where the "local/private" designation originates from. It's 
> not to be found in Apple's book, "Designing Cards and Drivers for the 
> Macintosh". AFAIK, there's no distinction between "public" and "private" 
> like you might expect to find between the slot resources needed by Apple's 
> Slot Manager and those needed by 3rd party drivers. E.g. the 
> NUBUS_RESID_MAC_ADDRESS and NUBUS_RESID_GAMMADIR slot resources were 
> Apple-defined, even though nubus.c describes them as "local/private".

The split looks pretty artificial to me. I don't remember any details,
as I don't think I was looking at that part of the code at the time.

	Brad Boyer
	flar@allandria.com

