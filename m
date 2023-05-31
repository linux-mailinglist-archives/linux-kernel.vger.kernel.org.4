Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E7F718679
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjEaPfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbjEaPfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:35:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF1C125
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:35:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DAEE63D74
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401D3C433EF;
        Wed, 31 May 2023 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685547329;
        bh=42ueuOloMTrR83m/Gh8uGpcqRw+cPzbULNgMppbwAGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YijHQ/gg4GqRMnuRtLZDvcke0aYPr8921yqDSiufV00WSIyrIkrxKbRS1klV/0pj+
         SQe55XVBYAUmk2E4Hbr7GeSkslQhl1e3BXlvr3t3LRj1i64Zp0u0jRbGmhKstTWinZ
         yGYIiCR4MrJqVxcknKyv4v9dBSbx+fMesbYCbS58RBHder1kH7DDE+2Asd5fUZZLWI
         V7PXDWmyX9V7K0hOPF2ytry/pKHl9LHqkybK0CrixATMrl87lKvvk+dfYCjC2tn2WD
         g8F0gpKyVFL36ZZYGYvgth41BjUrJ+B63g46q7KeLd4wCx7lwX63S3Q5JdN5BJDxhf
         407HRFoMn4nSA==
Date:   Wed, 31 May 2023 23:24:13 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 4/6] riscv: mm: pass noncoherent or not to
 riscv_noncoherent_supported()
Message-ID: <ZHdmnfJvF1N5rgvx@xhacker>
References: <20230526165958.908-1-jszhang@kernel.org>
 <20230526165958.908-5-jszhang@kernel.org>
 <20230529-gainfully-ribbon-48520d25ef6e@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230529-gainfully-ribbon-48520d25ef6e@wendy>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 12:13:10PM +0100, Conor Dooley wrote:
> Hey Jisheng,

Hi Conor,

> 
> On Sat, May 27, 2023 at 12:59:56AM +0800, Jisheng Zhang wrote:
> > We will soon take different actions by checking the HW is noncoherent
> > or not, I.E ZICBOM/ERRATA_THEAD_CMO or not.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/errata/thead/errata.c    | 19 +++++++++++--------
> >  arch/riscv/include/asm/cacheflush.h |  4 ++--
> >  arch/riscv/kernel/setup.c           |  6 +++++-
> >  arch/riscv/mm/dma-noncoherent.c     | 10 ++++++----
> >  4 files changed, 24 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> > index be84b14f0118..c192b80a5166 100644
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
> > @@ -36,21 +36,24 @@ static bool errata_probe_pbmt(unsigned int stage,
> >  static bool errata_probe_cmo(unsigned int stage,
> >  			     unsigned long arch_id, unsigned long impid)
> >  {
> > -	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_CMO))
> > -		return false;
> > -
> > -	if (arch_id != 0 || impid != 0)
> > -		return false;
> > +	bool cmo;
> >  
> >  	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> >  		return false;
> >  
> > +	if (IS_ENABLED(CONFIG_ERRATA_THEAD_CMO) &&
> > +	    (arch_id == 0 && impid == 0))
> > +		cmo = true;
> > +	else
> > +		cmo = false;
> > +
> >  	if (stage == RISCV_ALTERNATIVES_BOOT) {
> > -		riscv_cbom_block_size = L1_CACHE_BYTES;
> > -		riscv_noncoherent_supported();
> > +		if (cmo)
> > +			riscv_cbom_block_size = L1_CACHE_BYTES;
> > +		riscv_noncoherent_supported(cmo);
> >  	}
> >  
> > -	return true;
> > +	return cmo;
> 
> I don't really understand the changes that you are making to this
> function, so that is tries really hard to call
> riscv_noncoherent_supported(). Why do we need to always call the function
> in the erratum's probe function, if the erratum is not detected, given

In one unified kernel Image, to support both coherent and noncoherent
platforms(currently, either T-HEAD CMO or ZICBOM), we need to let the
kmalloc meet both cases, specifically, ARCH_DMA_MINALIGN aligned.
Once we know the underlying HW is coherent, I.E neither T-HEAD CMO nor
ZICBOM, we need to notice kmalloc we are safe to reduce the alignment
to 1. The notice action is done in patch 5:

+       } else {
+               dma_cache_alignment = 1;


> that riscv_noncoherent_supported() is called immediately after
> apply_boot_alternatives() in setup_arch()?
> 
> >  }
> >  
> >  static bool errata_probe_pmu(unsigned int stage,
> > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> > index 8091b8bf4883..9d056c9b625a 100644
> > --- a/arch/riscv/include/asm/cacheflush.h
> > +++ b/arch/riscv/include/asm/cacheflush.h
> > @@ -54,9 +54,9 @@ extern unsigned int riscv_cboz_block_size;
> >  void riscv_init_cbo_blocksizes(void);
> >  
> >  #ifdef CONFIG_RISCV_DMA_NONCOHERENT
> > -void riscv_noncoherent_supported(void);
> > +void riscv_noncoherent_supported(bool cmo);
> 
> I think it would "read better" if you renamed this variable to
> "have_cmo".
> 
> >  #else
> > -static inline void riscv_noncoherent_supported(void) {}
> > +static inline void riscv_noncoherent_supported(bool cmo) {}
> >  #endif
> >  
> >  /*
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 36b026057503..565f3e20169b 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -264,6 +264,7 @@ static void __init parse_dtb(void)
> >  
> >  void __init setup_arch(char **cmdline_p)
> >  {
> > +	bool cmo;
> >  	parse_dtb();
> >  	setup_initial_init_mm(_stext, _etext, _edata, _end);
> >  
> > @@ -298,7 +299,10 @@ void __init setup_arch(char **cmdline_p)
> >  	apply_boot_alternatives();
> >  	if (IS_ENABLED(CONFIG_RISCV_ISA_ZICBOM) &&
> >  	    riscv_isa_extension_available(NULL, ZICBOM))
> > -		riscv_noncoherent_supported();
> > +		cmo = true;
> > +	else
> > +		cmo = false;
> > +	riscv_noncoherent_supported(cmo);
> 
> As a nit, could you put a newline before the call to
> riscv_noncoherent_supported()?
> 
> >  }
> >  
> >  static int __init topology_init(void)
> > diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> > index d51a75864e53..0e172e2b4751 100644
> > --- a/arch/riscv/mm/dma-noncoherent.c
> > +++ b/arch/riscv/mm/dma-noncoherent.c
> > @@ -72,9 +72,11 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> >  	dev->dma_coherent = coherent;
> >  }
> >  
> > -void riscv_noncoherent_supported(void)
> > +void riscv_noncoherent_supported(bool cmo)
> >  {
> > -	WARN(!riscv_cbom_block_size,
> > -	     "Non-coherent DMA support enabled without a block size\n");
> > -	noncoherent_supported = true;
> > +	if (cmo) {
> > +		WARN(!riscv_cbom_block_size,
> > +		     "Non-coherent DMA support enabled without a block size\n");
> > +		noncoherent_supported = true;
> > +	}
> 
> The other places that we do a WARN() because of screwed up devicetrees
> for CMO things, we do a WARN_TAINT(CPU_OUT_OF_SPEC). Should we do the
> same here too?
> 
> Cheers,
> Conor.


