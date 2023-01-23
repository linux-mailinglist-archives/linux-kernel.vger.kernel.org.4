Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DFF677E55
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjAWOqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAWOqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:46:46 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3089029;
        Mon, 23 Jan 2023 06:46:45 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 37A2D68BEB; Mon, 23 Jan 2023 15:46:39 +0100 (CET)
Date:   Mon, 23 Jan 2023 15:46:38 +0100
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
Message-ID: <20230123144638.GB31126@lst.de>
References: <CA+V-a8u6jvR=EDeE3mAbDr6-06NoBJ7mwmi_Y9qVyHT+aC-9rg@mail.gmail.com> <45d6eb0c-cbe3-4a83-aa12-3483638473ae@app.fastmail.com> <20230110070144.GG10289@lst.de> <02988e70-b099-46fd-b260-2d537c50543a@app.fastmail.com> <20230113054807.GA23179@lst.de> <ea4cb121-97e9-4365-861a-b3635fd34721@app.fastmail.com> <20230121143733.GA7415@lst.de> <6a64b0b5-0ebc-43a5-a3d8-483a845a0b5e@app.fastmail.com> <20230122072759.GA3703@lst.de> <7ad668ba-d6f3-4ef9-9335-e42bfe8d4cce@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ad668ba-d6f3-4ef9-9335-e42bfe8d4cce@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 12:04:35PM +0100, Arnd Bergmann wrote:
> > And I'm not really sure I'd like to go beyond that - making it too
> > easy pluggable will make people feel more comfortable doing stupid
> > things here. 
> 
> I fear the bigger risk is still making the functions callable
> from device driver code than it is to make the functions
> globally settable.
> 
> You introduced the mips version in f8c55dc6e828 ("MIPS: use generic
> dma noncoherent ops for simple noncoherent platforms"), which
> was clearly meant as an implementation detail, yet we already
> have a driver that slipped in with 3bdffa8ffb45 ("Input: Add
> N64 controller driver") that just calls this directly rather
> than using the dma-mapping interface.

MIPS actually has a bit of a history of these odd bypasses that
it seems like this driver copied.  rmk has been very worried by
this bypassing, and in general I agree.  But there's only so
much we can do except for auditing drivers.  Especially as none of
these helpers is exported and built-in only drivers are quite rare.

> > And yes, maybe that's personal because I've warned
> > the RISC-V people years ago that they'll need architectural
> > cache management instructions yesterday and the answer was that
> > no one is going to use them on modern CPUs.  *sigh*
> 
> To be fair, from the ISA point of view, it really shouldn't
> be necessary as long as you have a sane SoC design.
> In practice there are always chips that are cutting corners,
> or use the new CPU core as a drop-in for an existing
> design. Arm SBSA tried to enforce the same thing and also
> failed for pretty much the same reason.

Not wiring up IP blocks for cache coherency is cheap.  So it totally
makes sense for dirt cheap SOCs, or even for low performance periphals
in general.  The GPU folks also believe they can make some things
faster by deliberately turning coherency off on SOCs that support
coherency.

In addition to that cache maintainance is absolutely needed for NVDIMM
support.
