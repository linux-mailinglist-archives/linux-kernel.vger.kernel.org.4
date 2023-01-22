Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A95676B78
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 08:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjAVH2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 02:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVH2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 02:28:05 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6508313530;
        Sat, 21 Jan 2023 23:28:04 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 845BC68AA6; Sun, 22 Jan 2023 08:27:59 +0100 (CET)
Date:   Sun, 22 Jan 2023 08:27:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        guoren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH v6 1/6] riscv: mm: dma-noncoherent: Switch using
 function pointers for cache management
Message-ID: <20230122072759.GA3703@lst.de>
References: <CA+V-a8uF1s+dwKC_+apL+CBiHN8w_J0n_G2dqsgiAUZVEibfqg@mail.gmail.com> <9017adf0-acd4-4c43-8aea-3579b214b477@app.fastmail.com> <CA+V-a8u6jvR=EDeE3mAbDr6-06NoBJ7mwmi_Y9qVyHT+aC-9rg@mail.gmail.com> <45d6eb0c-cbe3-4a83-aa12-3483638473ae@app.fastmail.com> <20230110070144.GG10289@lst.de> <02988e70-b099-46fd-b260-2d537c50543a@app.fastmail.com> <20230113054807.GA23179@lst.de> <ea4cb121-97e9-4365-861a-b3635fd34721@app.fastmail.com> <20230121143733.GA7415@lst.de> <6a64b0b5-0ebc-43a5-a3d8-483a845a0b5e@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a64b0b5-0ebc-43a5-a3d8-483a845a0b5e@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 08:30:23PM +0100, Arnd Bergmann wrote:
> > That feels really odd, and might be worth a bug report to the
> > PPC maintainers.
> 
> Right, my first step would be to change all of the current
> outliers to use the same set of operations where possible.

Sounds good.

> > I'd rather avoid multiple callbacks if we can.  But maybe solve
> > the simple problem first and just pass the paddr and then
> > iterate from there.
> 
> Ok, fair enough. This means we can't easily put the kmap_atomic()
> into common code for highmem, though the per-page loop would
> still work.

Yes.  Given how messy many of the ops are I think one step at a time
is always good.

> I was thinking of using STATIC_CALL() as an optimization here, which
> I find easier to read and understand than alternatives. One advantage
> here is that this allows the actual cache operations to be declared
> locally in the architecture without letting drivers call them,
> but still update the common code to work without indirect branches.
> 
> The main downside is that this is currently only optimized on
> powerpc and x86, both of which don't actually need CPU specific
> callbacks. ARC, ARM, and MIPS on the other hand already
> have indirect function pointers, RISC-V would likely benefit the
> most from either alternatives or static_call, as it already
> uses alternatives and has one implementation that is clearly
> preferred over the others.

For now I'd just keep doing direct calls into the arch code, just
for the lower level invalidate, writeback, invalidate+writeback
calls as that helps cementinc the logic of which of those to use
in well documented core code.

And I'm not really sure I'd like to go beyond that - making it too
easy pluggable will make people feel more comfortable doing stupid
things here.  And yes, maybe that's personal because I've warned
the RISC-V people years ago that they'll need architectural
cache management instructions yesterday and the answer was that
no one is going to use them on modern CPUs.  *sigh*
