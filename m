Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BCA73495C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 01:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjFRXmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 19:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRXmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 19:42:10 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09D5B99;
        Sun, 18 Jun 2023 16:42:09 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 374A892009C; Mon, 19 Jun 2023 01:42:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3123692009B;
        Mon, 19 Jun 2023 00:42:08 +0100 (BST)
Date:   Mon, 19 Jun 2023 00:42:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     Sam Ravnborg <sam@ravnborg.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-parport@lists.infradead.org
Subject: Re: [PATCH] parport_pc: don't allow driver for SPARC32
In-Reply-To: <a05558c3-8d5c-c389-ba4c-be134c75ac1c@infradead.org>
Message-ID: <alpine.DEB.2.21.2306190000530.14084@angie.orcam.me.uk>
References: <20230406160548.25721-1-rdunlap@infradead.org> <alpine.DEB.2.21.2304062039260.44308@angie.orcam.me.uk> <20230406203207.GA1534216@ravnborg.org> <alpine.DEB.2.21.2304062144520.44308@angie.orcam.me.uk> <20230407200313.GA1655046@ravnborg.org>
 <alpine.DEB.2.21.2304072142290.62619@angie.orcam.me.uk> <a05558c3-8d5c-c389-ba4c-be134c75ac1c@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2023, Randy Dunlap wrote:

> >  There are PC-style PCI (and PCIe) parallel ports in the form of option 
> > cards being sold; I have one in my RISC-V machine (and I had to go through 
> > the hassle of figuring out why the heck I am not able to select the driver 
> > in configuration; a situation analogous to what Randy's change wants to 
> > arrange).  You can plug one into any machine that has PCI slots and my 
> > understanding from Linux Kconfig files is there are such 32-bit SPARC 
> > machines in existence or the dependency on PCI wouldn't offer the driver.  
> > Otherwise just don't enable CONFIG_PCI for 32-bit SPARC.
> > 
> 
> If there are 32-bit Sparc machines with PCI slots, we must not have any
> users with parallel ports or we should have heard about it IMO.

 I wouldn't be surprised, parallel ports are not that common nowadays, let 
alone used.  Myself I haven't used a parallel printer for ages now, though 
I still own a couple of odd other parallel devices, such as a ROM emulator 
or the firmware download port of an old MIPS development board (actually a 
regular Super I/O parallel port of said device hijacked by an onboard FPGA 
for this second purpose if enabled with an onboard rocker switch).  That's 
not the usual stuff people tend to use I suppose.

> >> An alternative fix, and better I think, would be to audit all archs
> >> and let the relevant ones select ARCH_MIGHT_HAVE_PC_PARPORT, so we
> >> avoided the ugly "|| (PCI && !S390 && !SPARC32)" case for PARPORT_PC.

 I should have noted this before: ARCH_MIGHT_HAVE_PC_PARPORT is for true 
ISA or Super I/O parallel ports only.  We handle true PCI implementations 
in a generic platform-agnostic way, as long as the platform implements PCI 
I/O commands in the host bridge.  The latter requirement only excludes a 
bunch of platforms, most notably S390 and recent 64-bit POWER systems.

 With Niklas's HAS_IOPORT patches the S390 special case will soon be gone.

> >  It's only S390 that is special in that it has a limited set of specially 
> > crafted PCI options it can ever support (or so I am told; something about 
> > the firmware or suchlike).
> 
> >From my reading, if a Sparc32 machine has a PCI port, it might be able to
> have a parallel port. However, even with Maciej's suggested code change
> instead of my patch, the ebus code is not being compiled for Sparc32 -- only
> for Sparc64, so more changes are needed beyond Maciej's suggestion.
> 
> But the documentation that I found refers to Ebus on Sparc4 machines.

 Well, even though I came across a bunch of SPARC machines in the past I'm 
not familiar enough with the platform to have an idea what SPARC4 refers 
to.  You can enable CONFIG_PCI for a SPARC32 kernel however, which I infer 
from there are 32-bit SPARC machines in existence with PCI connectivity.  
That I find enough for a potential PC-style parallel port configuration 
with such a system, for as many ports as the availability of slots allows.

> >  Any other platform that has PCI slots will handle PC-style PCI parallel 
> > port option cards just fine, as long as it supports PCI I/O read/write 
> > commands (some systems such as POWER9 machines don't; Niklas Schnelle has 
> > been recently working on a generic way to exclude drivers for devices that 
> > require PCI port I/O from being offered with systems that have no support 
> > for PCI port I/O).
> > 
> >  Let me know if you find anything here unclear or have any other questions 
> > or comments.
> 
> /me wishes that we had a Sparc maintainer.

 What happened to DaveM?

 In any case after a couple of iterations I have made a succesful build of 
a 32-bit SPARC toolchain now, which I was able to verify a fix with I have 
outlined earlier in this thread.  Posted as archived at: 
<https://lore.kernel.org/r/alpine.DEB.2.21.2306182347101.14084@angie.orcam.me.uk/>.

  Maciej
