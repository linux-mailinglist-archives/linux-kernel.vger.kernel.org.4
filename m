Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD5E6766C5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 15:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjAUOhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 09:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjAUOhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 09:37:40 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236441B0;
        Sat, 21 Jan 2023 06:37:38 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 33DEE68CFE; Sat, 21 Jan 2023 15:37:33 +0100 (CET)
Date:   Sat, 21 Jan 2023 15:37:33 +0100
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
Message-ID: <20230121143733.GA7415@lst.de>
References: <20230106185526.260163-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <6f7d06ef-d74d-4dfc-9b77-6ae83e0d7816@app.fastmail.com> <CA+V-a8uF1s+dwKC_+apL+CBiHN8w_J0n_G2dqsgiAUZVEibfqg@mail.gmail.com> <9017adf0-acd4-4c43-8aea-3579b214b477@app.fastmail.com> <CA+V-a8u6jvR=EDeE3mAbDr6-06NoBJ7mwmi_Y9qVyHT+aC-9rg@mail.gmail.com> <45d6eb0c-cbe3-4a83-aa12-3483638473ae@app.fastmail.com> <20230110070144.GG10289@lst.de> <02988e70-b099-46fd-b260-2d537c50543a@app.fastmail.com> <20230113054807.GA23179@lst.de> <ea4cb121-97e9-4365-861a-b3635fd34721@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea4cb121-97e9-4365-861a-b3635fd34721@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 06:04:37PM +0100, Arnd Bergmann wrote:
> Having looked at this some more, I see that the powerpc
> version is a bit problematic here as well: this one
> flushes the partial cache lines before and after the
> DMA transfer, while only invalidating the full
> cache lines.

That feels really odd, and might be worth a bug report to the
PPC maintainers.

> Obviously there is no winning either way if the same
> cache line gets written by both CPU and device, I'm
> just trying to figure out what behavior we actually
> want here.

There isn't, and that's why we require DMAed regions to be cache line
aligned.

> Aside from the question for how to handle flush vs invalidate
> on DMA_FROM_DEVICE, I'm still trying to figure out how to
> best handle highmem with architecture specific cache management
> operations. The easy approach would be to leave that up
> to the architecture, passing only a physical address to
> the flush function.

I suspect that is a good enough first step.  Especially as I remember
that some architectures have physical address based cache management
anyway (unless we removed them in the meantime).

> A nicer interface might be to move the
> loop over highmem pages out into common code, flush
> lowmem pages by virtual addresss, and have a separate
> callback for highmem pages that takes a page pointer,
> like

I'd rather avoid multiple callbacks if we can.  But maybe solve
the simple problem first and just pass the paddr and then
iterate from there.

> 
> struct dma_cache_ops {
>         void (*dma_cache_wback_inv)(void *start, unsigned long sz);
>         void (*dma_cache_inv)(void *start, unsigned long sz);
>         void (*dma_cache_wback)(void *start, unsigned long sz);
> #ifdef CONFIG_HIGHMEM
>         void (*dma_cache_wback_inv_high_page)(struct page *, size_t start, unsigned long sz);
>         void (*dma_cache_inv_high_page)(struct page *, size_t start, unsigned long sz);
>         void (*dma_cache_wback_high_page)(struct page *, size_t start, unsigned long sz);

Btw, I really don't think these should be indirect calls.  
For sane architectures there should be exactly one way to call them,
and the onces that have different implementations really should be
using alternatives instead of expensive indirect calls.
