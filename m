Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DE15E9398
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 16:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiIYOR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiIYOR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 10:17:26 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54F7329830;
        Sun, 25 Sep 2022 07:17:25 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id BA24792009C; Sun, 25 Sep 2022 16:17:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B3C1B92009B;
        Sun, 25 Sep 2022 15:17:22 +0100 (BST)
Date:   Sun, 25 Sep 2022 15:17:22 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH v6 09/17] mips: use fallback for random_get_entropy()
 instead of just c0 random
In-Reply-To: <YzAmvfQcY2/gGwFQ@zx2c4.com>
Message-ID: <alpine.DEB.2.21.2209251449290.29493@angie.orcam.me.uk>
References: <20220423212623.1957011-1-Jason@zx2c4.com> <20220423212623.1957011-10-Jason@zx2c4.com> <alpine.DEB.2.21.2204250113440.9383@angie.orcam.me.uk> <YmicjVbkcppfzE1E@zx2c4.com> <CAHmME9r-wTkNGVj0sBOM5LVY=jdAw99gne-1g-mwjBnk3q7VqQ@mail.gmail.com>
 <alpine.DEB.2.21.2206241407240.22231@angie.orcam.me.uk> <YzAmvfQcY2/gGwFQ@zx2c4.com>
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

Hi Jason,

> >  Unfortunately I'm a little stuck at the moment, especially as one of my
> > main MIPS machines (a 5Kc Malta system) died mid-May while operating.  It 
> > seems to be a faulty CPU core card and the base board may be fine, though 
> > I cannot know for sure as I only have one each and I don't have a logic 
> > analyser or at least a JTAG probe to peek at the system and see what's 
> > going on inside.
> > 
> >  If anyone knows a source of a replacement Malta, preferably with a 5Kc 
> > CoreLV CPU module or another 64-bit hard core card (a number of different 
> > ones have been made), then I'll appreciate if you let me know.  I feel 
> > rather depressed knowing that many if not most hit the scrapper already 
> > while they could still find a good use.  Somehow it is easier to get way 
> > more obsolete hardware from 1980/90s just because it was general purpose 
> > rather than niche.
> > 
> >  Otherwise I'll try to get back to this stuff later in the year with 
> > whatever I have that still runs, but don't hold your breath.  Sorry!
> 
> Just thought I'd poke you about this, on the off chance that you found
> some new hardware and feel like tinkering around with cycle counters
> again. Some old MIPS platforms were recently dropped, too, which makes
> me wonder whether there's some room for more simplification here.

 I have a replacement CPU module now, but it is not the same as the old 
one was and it has a built-in different system controller (a MIPS SOC-it 
IP implementation) rather than a discrete Galileo GT-64120A chip the 
original module had.

 And the system controller suffers from PCI handling issues, i.e. the 
YAMON firmware hangs in PCI enumeration if there are more than 2 buses 
present (my configuration used to have 3) and in Linux one of the option 
cards seems not to respond to MMIO accesses (a mapping error?), with 
exactly the same hardware configuration that worked just fine with the 
Galileo.  I had to pull some hardware to make the system boot at all.

 It's not clear to me yet if these are symptoms of hardware errata or bugs 
in the respective pieces of software, but I fear debugging fatal issues 
has to take precedence over optimisations for me, so I have to defer cycle 
counter tinkering yet more.

 NB the replacement CPU module is also 32-bit rather than 64-bit as the 
broken one was and therefore I'm still looking for a replacement 64-bit 
CPU module.  Malta CPU modules seem exceedingly scarce nowadays, it seems 
easier to track down a 30 years old MIPS R3000 DECstation machine, sigh...

  Maciej
