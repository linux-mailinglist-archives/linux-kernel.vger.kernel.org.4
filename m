Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F0A5E79C3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiIWLjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiIWLjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:39:00 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A21813746C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:38:58 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 31B9992009C; Fri, 23 Sep 2022 13:38:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 2B7E692009B;
        Fri, 23 Sep 2022 12:38:57 +0100 (BST)
Date:   Fri, 23 Sep 2022 12:38:57 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Make port I/O string accessors actually work
In-Reply-To: <c4ee195a-cf1f-44f6-b3b6-241d04e01fb9@www.fastmail.com>
Message-ID: <alpine.DEB.2.21.2209231211350.29493@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2209220223080.29493@angie.orcam.me.uk> <c4ee195a-cf1f-44f6-b3b6-241d04e01fb9@www.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022, Arnd Bergmann wrote:

> > Fix port I/O string accessors such as `insb', `outsb', etc. which use 
> > the physical PCI port I/O address rather than the corresponding memory 
> > mapping to get at the requested location, which in turn breaks at least 
> > accesses made by our parport driver to a PCIe parallel port such as:
> >
> > PCI parallel port detected: 1415:c118, I/O at 0x1000(0x1008), IRQ 20
> > parport0: PC-style at 0x1000 (0x1008), irq 20, using FIFO 
> > [PCSPP,TRISTATE,COMPAT,EPP,ECP]
> 
> The patch looks correct to me, but I'm curious: Are you actually
> using a parport device on your system, or just testing it to
> make it work?

 I do, e.g. I have a MIPS Malta development board that uses an otherwise 
standard Super I/O parallel port for firmware downloads and have had a 
need recently to use it in the course of addressing a firmware bug.  This 
is how I actually triggered this bug; the Oops is from a download attempt.

 For the time being I resorted to using the only other parallel port I 
have in my lab, which is in my 25 years old x86 box, but I'd rather rely 
on a fast modern machine that is subject to less risk to fail.  And I 
found my HiFive Unmatched board a perfect fit for this purpose.

 I have a pair of Grammar Engine ROM emulators too that have both a serial 
and a parallel port for the purpose of image downloads, either of which 
can be used, except that the parallel interface is lightning fast compared 
to the serial one (so possibly the best arrangement is to use the serial 
port for control and the parallel one for data).  I haven't used them for 
a while now, but there's another firmware bug I plan to get at sometime, 
with my Broadcom SWARM development board.

 So yes, I have an ongoing interest in working parallel ports.

> > +#define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), 
> > buffer, count)
> > +#define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), 
> > buffer, count)
> > +#define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), 
> > buffer, count)
> > 
> 
> I don't see anything actually risc-v specific in these definitions,
> and it would be great to make the asm-generic version do the
> right thing here. As far as I can tell, the only difference is
> the barriers in the risc-v version, and we should really have the
> same in the generic code anyway.

 Fine with me as the next step, but we need to fix the bug at hand first 
and get the fix backported with the RISC-V port.

 Thanks for your review!

  Maciej
