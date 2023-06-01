Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3912C719180
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjFADwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjFADwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:52:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FBE93
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 20:52:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86F4B63FD0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD3FC433EF;
        Thu,  1 Jun 2023 03:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685591529;
        bh=C0KPLWX2jAX6THR8E6lvmZKKCHRjFAq1tbAVmqRVbaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FStga2fiml0wxrYT64ofLfgS+HEF84LgBA4HyAtjbCfkm3fDT++giMQ0GG1qHpIRE
         aJhL1wDGgEcG5H8SNghOleJdkCCDWLn5SgJkmwi3LINBoHO0YHCpKMzhUQ1y1Veaks
         JKVrNdD3iL+OYaayVS1UZ6TvP1FE/Z58+BpzaaCTYvWOlEM65RoJozxf/v4Tzf/3ji
         RWd97a/lhjJ/tL5cHR6d7+GQVQfUblXKMfq7t3cKsEOYL3xtegjJgH3/l4kSovwMDP
         k+L/4tx+XykdnXgnkx8S9finlOy1/XpED5ksoZ1GuONsGZ0M1w9TkMosqnBTxlEjuk
         ZN+bY7ZPfFmeQ==
Date:   Thu, 1 Jun 2023 11:40:54 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 4/6] riscv: mm: pass noncoherent or not to
 riscv_noncoherent_supported()
Message-ID: <ZHgTRuoHgbpy20wu@xhacker>
References: <20230526165958.908-1-jszhang@kernel.org>
 <20230526165958.908-5-jszhang@kernel.org>
 <20230529-gainfully-ribbon-48520d25ef6e@wendy>
 <ZHdmnfJvF1N5rgvx@xhacker>
 <ZHdnliDU7ikKaFoX@xhacker>
 <20230531-applied-antacid-77abfb5b2e55@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230531-applied-antacid-77abfb5b2e55@spud>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 05:28:56PM +0100, Conor Dooley wrote:
> On Wed, May 31, 2023 at 11:28:22PM +0800, Jisheng Zhang wrote:
> > On Wed, May 31, 2023 at 11:24:19PM +0800, Jisheng Zhang wrote:
> > > On Mon, May 29, 2023 at 12:13:10PM +0100, Conor Dooley wrote:
> > > > On Sat, May 27, 2023 at 12:59:56AM +0800, Jisheng Zhang wrote:
> > > > > We will soon take different actions by checking the HW is noncoherent
> > > > > or not, I.E ZICBOM/ERRATA_THEAD_CMO or not.
> > > > > 
> > > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > > > ---
> > > > >  arch/riscv/errata/thead/errata.c    | 19 +++++++++++--------
> > > > >  arch/riscv/include/asm/cacheflush.h |  4 ++--
> > > > >  arch/riscv/kernel/setup.c           |  6 +++++-
> > > > >  arch/riscv/mm/dma-noncoherent.c     | 10 ++++++----
> > > > >  4 files changed, 24 insertions(+), 15 deletions(-)
> > > > > 
> > > > > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> > > > > index be84b14f0118..c192b80a5166 100644
> > > > > --- a/arch/riscv/errata/thead/errata.c
> > > > > +++ b/arch/riscv/errata/thead/errata.c
> > > > > @@ -36,21 +36,24 @@ static bool errata_probe_pbmt(unsigned int stage,
> > > > >  static bool errata_probe_cmo(unsigned int stage,
> > > > >  			     unsigned long arch_id, unsigned long impid)
> > > > >  {
> > > > > -	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_CMO))
> > > > > -		return false;
> > > > > -
> > > > > -	if (arch_id != 0 || impid != 0)
> > > > > -		return false;
> > > > > +	bool cmo;
> > > > >  
> > > > >  	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> > > > >  		return false;
> > > > >  
> > > > > +	if (IS_ENABLED(CONFIG_ERRATA_THEAD_CMO) &&
> > > > > +	    (arch_id == 0 && impid == 0))
> > > > > +		cmo = true;
> > > > > +	else
> > > > > +		cmo = false;
> > > > > +
> > > > >  	if (stage == RISCV_ALTERNATIVES_BOOT) {
> > > > > -		riscv_cbom_block_size = L1_CACHE_BYTES;
> > > > > -		riscv_noncoherent_supported();
> > > > > +		if (cmo)
> > > > > +			riscv_cbom_block_size = L1_CACHE_BYTES;
> > > > > +		riscv_noncoherent_supported(cmo);
> > > > >  	}
> > > > >  
> > > > > -	return true;
> > > > > +	return cmo;
> > > > 
> > > > I don't really understand the changes that you are making to this
> > > > function, so that is tries really hard to call
> > > > riscv_noncoherent_supported(). Why do we need to always call the function
> > > > in the erratum's probe function, if the erratum is not detected, given
> > > 
> > > In one unified kernel Image, to support both coherent and noncoherent
> > > platforms(currently, either T-HEAD CMO or ZICBOM), we need to let the
> > > kmalloc meet both cases, specifically, ARCH_DMA_MINALIGN aligned.
> > 
> > seems adding three words can make it better:
> > 
> > kmalloc meet both cases at the beginning, specifically ...
> > 
> > > Once we know the underlying HW is coherent, I.E neither T-HEAD CMO nor
> > > ZICBOM, we need to notice kmalloc we are safe to reduce the alignment
> > > to 1. The notice action is done in patch 5:
> > > 
> > > +       } else {
> > > +               dma_cache_alignment = 1;
> > > 
> > > 
> > > > that riscv_noncoherent_supported() is called immediately after
> > > > apply_boot_alternatives() in setup_arch()?
> 
> This bit here is the key part of my confusion. You try really hard in
> the errata stuff to call riscv_noncoherent_supported(), which I do
> understand is because of the other branch that you add to the function
> later in the series.
> 
> What I do not understand is why we are not able to rely on the call to
> it in setup_arch() to trigger it when we do not have T-HEAD CMOs or
> Zicbom.
> You've explained why you want to make sure it always gets called during
> boot, but my question is about why it looks like it is being called more
> than once.
> 
> Actually, now that I think of it, what happens on a T-HEAD system where
> there is no T-HEAD CMOs, but there is Zicbom. In theory, this could
> exist.
> Bear with me here a moment in case I am completely wrong, snippet is
> from setup_arch()
> 	apply_boot_alternatives();
> On my example system, this will trigger, eventually sending us into
> errata_probe_cmo(), where we will call riscv_noncoherent_supported()
> with false, setting dma_cache_alignment to 1.
> 
> 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZICBOM) &&
> 	    riscv_isa_extension_available(NULL, ZICBOM))
> 		cmo = true;
> 
> On this system, this will be true.
> 
> 	else
> 		cmo = false;
> 	riscv_noncoherent_supported(cmo);
> 
> now riscv_noncoherent_supported() is called with true, and we have
> dma_cache_alignment = 1 still. Is that not problematic? Or the inverse,
> where the T-HEAD system has its custom CMOs and there is no Zicbom, it
> gets called twice with different args too.
> 

Thank you Conor. You pointed out a bug in my series. It looks like we
need to defer the dma_cache_alignment modification a bit until T-HEAD
CMO probing is done, but we also need to think carefully about T-HEAD
related CONFIG option is disabled. I will take care this case in v2
once Catalin's series is merged.
