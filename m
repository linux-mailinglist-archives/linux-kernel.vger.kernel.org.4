Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E375F858D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 16:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJHOJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 10:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJHOJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 10:09:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC75A4A825
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 07:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D93CB807E6
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 14:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5F1C433D7;
        Sat,  8 Oct 2022 14:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665238152;
        bh=zJVPFG6XZLenlyMofKsPI2XuAeVMXJmB4xAfWWJgPfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GauvcItOhNGZ6o53rM4v/lx4D0kpVgjEPtLtTYNOknFn2Cf895R5wTbtcxev04Biy
         qheAFTZFSrmWZB2Wg7Rj6nlgtVpS+V2Hry8b69h/SirmV3TwnhssDFsgEQe/rJp6o/
         +k7Lp21hXWcAYo52xxSYx9RzZhovPIVHVsZPOpIb1aHXfGGG3JQdwT5jhjPiTNtQdS
         JJEKXBoVc7YOf/EaF3Ug+KyrIjhx8i+U4w7k1ibef8aGcrn2oOQ7I31v7Q9wh5cUJ0
         kAOPPMpcjnHYDVBODTLW/09NLaKetTCOx3KABB4Knq0MyxX/7buxBr0TceOfPB3n35
         0KK6v+hp1IU/w==
Date:   Sat, 8 Oct 2022 21:59:37 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] riscv: move riscv_noncoherent_supported() out of
 ZICBOM probe
Message-ID: <Y0GCST9IQcKws9Yh@xhacker>
References: <20221006070818.3616-1-jszhang@kernel.org>
 <20221006070818.3616-2-jszhang@kernel.org>
 <Y0F1uH71Ll7YGygB@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0F1uH71Ll7YGygB@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 02:06:00PM +0100, Conor Dooley wrote:
> On Thu, Oct 06, 2022 at 03:08:11PM +0800, Jisheng Zhang wrote:
> > It's a bit wired to call riscv_noncoherent_supported() once when
> > insmod a module. Move the calling out of feature patch func.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/kernel/cpufeature.c | 7 +------
> >  arch/riscv/kernel/setup.c      | 4 ++++
> >  2 files changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 3b5583db9d80..03611b3ef45e 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -272,12 +272,7 @@ static bool __init_or_module cpufeature_probe_zicbom(unsigned int stage)
> >  	case RISCV_ALTERNATIVES_EARLY_BOOT:
> >  		return false;
> >  	default:
> > -		if (riscv_isa_extension_available(NULL, ZICBOM)) {
> > -			riscv_noncoherent_supported();
> > -			return true;
> > -		} else {
> > -			return false;
> > -		}
> > +		return riscv_isa_extension_available(NULL, ZICBOM);
> >  	}
> >  #endif
> >  
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 2dfc463b86bb..1a055c3f5d9d 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -299,6 +299,10 @@ void __init setup_arch(char **cmdline_p)
> >  	riscv_init_cbom_blocksize();
> >  	riscv_fill_hwcap();
> >  	apply_boot_alternatives();
> > +#ifdef CONFIG_RISCV_DMA_NONCOHERENT
> > +	if (riscv_isa_extension_available(NULL, ZICBOM))
> > +		riscv_noncoherent_supported();
> > +#endif
> 
> I have a personal bias against ifdefs where possible, maybe @Heiko
> remembers why riscv_noncoherent_supported() was not defined as something
> like `void riscv_noncoherent_support(void){}` for when that CONFIG is
> not enabled? If it was this could become a an IS_ENABLED & we wouldn't
> have to be so careful about wrapping it's usage in ifdefs.

Good idea. Will do in newer version.

> 
> Your change in isolation makes sense to me though, so:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Conor.
> 
> >  }
> >  
> >  static int __init topology_init(void)
> > -- 
> > 2.37.2
> > 
