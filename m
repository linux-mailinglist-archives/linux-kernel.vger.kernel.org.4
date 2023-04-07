Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367DB6DB5A4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjDGVBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjDGVBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:01:50 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFEA283FB;
        Fri,  7 Apr 2023 14:01:40 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B238E92009C; Fri,  7 Apr 2023 23:01:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id AB65592009B;
        Fri,  7 Apr 2023 22:01:38 +0100 (BST)
Date:   Fri, 7 Apr 2023 22:01:38 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Sam Ravnborg <sam@ravnborg.org>
cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-parport@lists.infradead.org
Subject: Re: [PATCH] parport_pc: don't allow driver for SPARC32
In-Reply-To: <20230407200313.GA1655046@ravnborg.org>
Message-ID: <alpine.DEB.2.21.2304072142290.62619@angie.orcam.me.uk>
References: <20230406160548.25721-1-rdunlap@infradead.org> <alpine.DEB.2.21.2304062039260.44308@angie.orcam.me.uk> <20230406203207.GA1534216@ravnborg.org> <alpine.DEB.2.21.2304062144520.44308@angie.orcam.me.uk> <20230407200313.GA1655046@ravnborg.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2023, Sam Ravnborg wrote:

> > > Randy's suggestion is fine, as we avoid building parport support
> > > for sparc32. If someone shows up and need parport support
> > > for sparc32 then we could look into how to enable it.
> > > Until then, we are better helped avoiding building the driver.
> > 
> >  I disagree.  Why artificially prevent perfectly good hardware from 
> > working with a perfectly good driver especially as the fix is just a 
> > trivial exercise?  And I offered a solution.
> 
> There is no sparc32 with a PC style parallel port, so the parport_pc
> have no value for a sparc32 machine.

 There are PC-style PCI (and PCIe) parallel ports in the form of option 
cards being sold; I have one in my RISC-V machine (and I had to go through 
the hassle of figuring out why the heck I am not able to select the driver 
in configuration; a situation analogous to what Randy's change wants to 
arrange).  You can plug one into any machine that has PCI slots and my 
understanding from Linux Kconfig files is there are such 32-bit SPARC 
machines in existence or the dependency on PCI wouldn't offer the driver.  
Otherwise just don't enable CONFIG_PCI for 32-bit SPARC.

 Apologies if I wasn't clear enough with my reasoning, although I think 
the lone presence of the PCI dependency in Kconfig ought have to make it 
clear.

> The sparc32 machines have the parport_sunbpp driver for their parallel
> port.

 That's an onboard device or an SBus option card though, right?

> An alternative fix, and better I think, would be to audit all archs
> and let the relevant ones select ARCH_MIGHT_HAVE_PC_PARPORT, so we
> avoided the ugly "|| (PCI && !S390 && !SPARC32)" case for PARPORT_PC.

 It's only S390 that is special in that it has a limited set of specially 
crafted PCI options it can ever support (or so I am told; something about 
the firmware or suchlike).

 Any other platform that has PCI slots will handle PC-style PCI parallel 
port option cards just fine, as long as it supports PCI I/O read/write 
commands (some systems such as POWER9 machines don't; Niklas Schnelle has 
been recently working on a generic way to exclude drivers for devices that 
require PCI port I/O from being offered with systems that have no support 
for PCI port I/O).

 Let me know if you find anything here unclear or have any other questions 
or comments.

  Maciej
