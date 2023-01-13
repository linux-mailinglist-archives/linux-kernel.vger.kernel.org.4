Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094E4668BBE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjAMFud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbjAMFt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:49:27 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A5769532;
        Thu, 12 Jan 2023 21:48:12 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 49E8868D07; Fri, 13 Jan 2023 06:48:07 +0100 (CET)
Date:   Fri, 13 Jan 2023 06:48:07 +0100
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
Message-ID: <20230113054807.GA23179@lst.de>
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230106185526.260163-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <6f7d06ef-d74d-4dfc-9b77-6ae83e0d7816@app.fastmail.com> <CA+V-a8uF1s+dwKC_+apL+CBiHN8w_J0n_G2dqsgiAUZVEibfqg@mail.gmail.com> <9017adf0-acd4-4c43-8aea-3579b214b477@app.fastmail.com> <CA+V-a8u6jvR=EDeE3mAbDr6-06NoBJ7mwmi_Y9qVyHT+aC-9rg@mail.gmail.com> <45d6eb0c-cbe3-4a83-aa12-3483638473ae@app.fastmail.com> <20230110070144.GG10289@lst.de> <02988e70-b099-46fd-b260-2d537c50543a@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02988e70-b099-46fd-b260-2d537c50543a@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 04:03:06PM +0100, Arnd Bergmann wrote:
> To clarify: I was looking at arch_sync_dma_for_device(), which
> changed from 'invalidate' to 'clean' last June in commit
> c50f11c6196f ("arm64: mm: Don't invalidate FROM_DEVICE buffers
> at start of DMA transfer"). I don't see  a revert for that.
> 
> The one that was reverted recently is arch_dma_prep_coherent, which
> was changed and reverted in
> 
> c44094eee32 Aug 23 2022 flush->clean
> b7d9aae4048 Dec 6  2022 clean->flush
> 
> I'm primarily interested in the streaming mappings (arch_sync_*)
> at the moment.

Oh, true.  I've been confused about the two changes.

> Agreed, that's why I particularly don't like the idea of giving SoC
> specific L2$ drivers the option of making custom choices here.

Yes, moving this into individual drivers is an absolute no-go. 

> The arch_dma_prep_coherent() change is arguably arm64 specific
> because it is only needed for machines sharing memory with EL3
> firmware that enforces buffer ownership, but even for that it would
> be nice to have a central definition and some architecture specific
> flag that picks one behavior or the other. Same thing for the
> speculative access difference.

Yes.

> I looked at all the implementations now and put them in a table[1]
> to see what the differences are. The only bit that I think needs
> discussion is the dma_sync_single_for_device(DMA_FROM_DEVICE) op
> that I mentioned above. I see that arm64, csky, powerpc, riscv
> and parisc all write out at least partical cache lines first to
> avoid losing dirty data in the part that is not written by the
> device[2][3], while the other ones don't[4]. 

I'm tempted to declare [4] buggy until proof of the inverse.

> I also see that at least arc, arm, mips and riscv all want
> CPU specific cache management operations to be registered
> at boot time. While Russell had some concerns about your
> suggestion to generalize the arm version, we could start
> by moving the abstracted riscv version into
> kernel/dma/direct.c and make sure it can be shared with
> at least mips and arc, provided that we can agree on the
> DMA_FROM_DEVICE behavior.

Yes, I'd really like to start out with a common version and then
move bits over.  There's also some interesting bits about handling
highmem for architectures that needs virtual addresss for flushing
that might be worth sharing, too.

Thіs should be a new file in kernel/dma/ as it's not only used by
dma-direct but also by dma-iommu, and to keep the code nicely
separated.

Can you give it a go?
