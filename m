Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554F965D23B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbjADMQr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Jan 2023 07:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239054AbjADMQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:16:44 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E5DF5AA
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 04:16:41 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pD2h2-0006Bl-K6; Wed, 04 Jan 2023 13:16:28 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] riscv: use VA+PA variant of CMO macros for DMA synchorization
Date:   Wed, 04 Jan 2023 13:16:27 +0100
Message-ID: <2135147.irdbgypaU6@diego>
In-Reply-To: <bcce507a31662004262fa3bbe911f1b1ff7f27af.camel@icenowy.me>
References: <20230104074146.578485-1-uwu@icenowy.me> <CAJF2gTTO3jx8FqMVRmfgkjO02sCVx2SVbe-Sn1uKXojyn8RDaA@mail.gmail.com> <bcce507a31662004262fa3bbe911f1b1ff7f27af.camel@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 4. Januar 2023, 10:27:53 CET schrieb Icenowy Zheng:
> 在 2023-01-04星期三的 17:24 +0800，Guo Ren写道：
> > On Wed, Jan 4, 2023 at 4:59 PM Icenowy Zheng <uwu@icenowy.me> wrote:
> > > 
> > > 在 2023-01-04星期三的 16:50 +0800，Guo Ren写道：
> > > > On Wed, Jan 4, 2023 at 3:43 PM Icenowy Zheng <uwu@icenowy.me>
> > > > wrote:
> > > > > 
> > > > > DMA synchorization is done on PA and the VA is calculated from
> > > > > the
> > > > > PA.
> > > > > 
> > > > > Use the alternative macro variant that takes both VA and PA as
> > > > > parameters, thus in case the ISA extension used support PA
> > > > > directly, the
> > > > > overhead for re-converting VA to PA can be omitted.
> > > > > 
> > > > > Suggested-by: Guo Ren <guoren@kernel.org>
> > > > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > > > ---
> > > > >  arch/riscv/mm/dma-noncoherent.c | 8 ++++----
> > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/arch/riscv/mm/dma-noncoherent.c
> > > > > b/arch/riscv/mm/dma-
> > > > > noncoherent.c
> > > > > index d919efab6eba..a751f4aece62 100644
> > > > > --- a/arch/riscv/mm/dma-noncoherent.c
> > > > > +++ b/arch/riscv/mm/dma-noncoherent.c
> > > > > @@ -19,13 +19,13 @@ void arch_sync_dma_for_device(phys_addr_t
> > > > > paddr, size_t size,
> > > > > 
> > > > >         switch (dir) {
> > > > >         case DMA_TO_DEVICE:
> > > > > -               ALT_CMO_OP(clean, vaddr, size,
> > > > > riscv_cbom_block_size);
> > > > > +               ALT_CMO_OP_VPA(clean, vaddr, paddr, size,
> > > > > riscv_cbom_block_size);
> > > > ALT_CMO_OP -> ALT_CMO_OP_VPA, is the renaming necessary?
> > > 
> > > I didn't rename the original ALT_CMO_OP, ALT_CMO_OP_VPA is
> > > something
> > > new.
> > The ##_VPA is really strange.
> > 
> > How about:
> > ALT_CMO_OP          -> ALT_CMO_OP_VA
> > ALT_CMO_OP_VPA -> ALT_CMO_OP
> 
> It's thus a much bigger change.
> 
> If you are not fond of _VPA, I can rename it to _VA_PA.

before you spend too much time on this, there is currently a parallel
discussion running about including all the other different vendor-
specific cache management.

See [0] and the thread before that for reference.

The consensus seems to be that cache-handling itself is not fast anyway,
and therefore to reduce complexity for the cache handling and move
non-zicbom cache-handling into a indirect function call that the can be
overridden at runtime.


Heiko

[0] https://lore.kernel.org/all/43aee000-5b89-4d94-98d2-b37b1a18a83e@app.fastmail.com/


