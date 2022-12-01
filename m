Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2788A63F089
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiLAMae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiLAMa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:30:27 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E4CB68C9;
        Thu,  1 Dec 2022 04:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669897825; x=1701433825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WA7HrCslX8Gj2DNul0k+rAI/etG0UhniwQU7QIeWfmo=;
  b=nOQawixEKMPQJ17wo4H92SxxQRpSlymE7M9/Ebs9QqyTjWJEiWRHKzSA
   bauNgIJbIGwd52E86Oq+fCBsYH5873UmJ4CwQiPvs6J8xFfR8BKqGrbBh
   70xiXUnP6VleAeBzRkw7IsaWhcQrR78x7YFVBXLgYiQdAPaAEzDPHohvu
   oYXHmyqFY2Bf5ZrIoI5afIyMx4zn16dfkZfOIpDWoVmyUzXu6FaR5Ss22
   Xp8/rK6CmOSh56/O3rQzeO5DK9qEU4wA83Ogd8MPxr2vUB2BefRcPBoot
   zBuNgpC5v+ctLF2axe0z2Uxjd41hYOGz7gNLCl1XccKNDj0ebxQVrGHXy
   w==;
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="125982533"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Dec 2022 05:30:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Dec 2022 05:30:13 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 1 Dec 2022 05:30:11 -0700
Date:   Thu, 1 Dec 2022 12:29:53 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        <linux-riscv@lists.infradead.org>, <aou@eecs.berkeley.edu>,
        <corbet@lwn.net>, <guoren@kernel.org>, <heiko@sntech.de>,
        <paul.walmsley@sifive.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] RISC-V: resort all extensions in consistent orders
Message-ID: <Y4ieQf4Q9ywJivDH@wendy>
References: <20221130234125.2722364-1-conor@kernel.org>
 <20221130234125.2722364-3-conor@kernel.org>
 <20221201090041.525op4sateq5wq4y@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221201090041.525op4sateq5wq4y@kamzik>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 10:00:41AM +0100, Andrew Jones wrote:
> On Wed, Nov 30, 2022 at 11:41:25PM +0000, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > Ordering between each and every list of extensions is wildly
> > inconsistent. Per discussion on the lists pick the following policy:
> > 
> > - The array defining order in /proc/cpuinfo follows a narrow
> >   interpretation of the ISA specifications, described in a comment
> >   immediately presiding it.
> > 
> > - All other lists of extensions are sorted alphabetically.
> > 
> > This will hopefully allow for easier review & future additions, and
> > reduce conflicts between patchsets as the number of extensions grows.
> > 
> > Link: https://lore.kernel.org/all/20221129144742.2935581-2-conor.dooley@microchip.com/
> > Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---

> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index 68b2bd0cc3bc..686d41b14206 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -161,12 +161,12 @@ device_initcall(riscv_cpuinfo_init);
> >   * New entries to this struct should follow the ordering rules described above.
> >   */
> >  static struct riscv_isa_ext_data isa_ext_arr[] = {
> > +	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> > +	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> >  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> >  	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> >  	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> >  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> > -	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> > -	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> >  	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> >  };
> 
> Technically we should have leave these in the wrong order if we want to be
> strict about the ISA string published to userspace, but I'm in favor of
> changing this array as necessary and hoping we teach userspace to use
> flexible parsers. Actually, IMO, we shouldn't teach userspace to parse
> this at all. We should instead create sysfs nodes:
> 
>  .../isa/zicbom
>  .../isa/zihintpause
>  .../isa/sscofpmf
> 
> and teach userspace to list .../isa/ to learn about extensions. That would
> also allow us to publish extension version numbers which we are not
> current doing with the proc isa string.
> 
>  .../isa/zicbom/major
>  .../isa/zicbom/minor
> 
> and we could add other properties if necessary too, e.g.
> 
>  .../isa/zicbom/block_size

Yah, this all kinda ties in with Palmer's RFC set that does the hwcap
stuff. Kinda been holding off on any thoughts on the isa string as a
valuable anything until that sees a proper respin.

> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 694267d1fe81..8a76a6ce70cf 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -199,12 +199,13 @@ void __init riscv_fill_hwcap(void)
> >  				this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
> >  				set_bit(*ext - 'a', this_isa);
> >  			} else {
> > +				/* sorted alphabetically */
> >  				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
> > +				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
> > +				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
> >  				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
> >  				SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
> >  				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
> > -				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
> > -				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
> >  			}
> >  #undef SET_ISA_EXT_MAP
> >  		}
> > @@ -284,6 +285,7 @@ static bool __init_or_module cpufeature_probe_zicbom(unsigned int stage)
> >   * This code may also be executed before kernel relocation, so we cannot use
> >   * addresses generated by the address-of operator as they won't be valid in
> >   * this context.
> > + * Tests, unless otherwise required, are to be added in alphabetical order.
> >   */
> >  static u32 __init_or_module cpufeature_probe(unsigned int stage)
> >  {
> > -- 
> > 2.38.1
> > 
> 
> I realize that I have a suggested-by tag in the commit message, but I

I did one thing as a "putting it out there" in the responses to another
series and you suggested something different entirely. Ordinarily, I'd
not put review comments in a suggested-by, but figured it was okay this
time.

> don't really have a strong opinion on how we order extensions where the
> order doesn't matter. A consistent policy of alphabetical or always at
> the bottom both work for me. I personally prefer alphabetical when
> reading the lists, but I realize we'll eventually merge stuff out of
> order and then that'll generate some churn to reorder (but hopefully not
> too frequently).

Think I said it at the yoke yesterday, but I don't think that this is
much of a problem. If it gets out of order, we just get someone that's
sending a patchset already to fix things up.

> My biggest concern is how much we need to care about the order of the
> string in proc and whether or not we're allowed to fix its order like
> we're doing with this patch. I hope we can, and I vote we do.

Being a bit hard-nosed about it:
- the spec has said for years that this order is not correct

- their parser cannot assume any given extension is even present, so the
  index at which the extension starts was only ever going to vary wildly

- to break a parser, it must expect to see extension Abcd before Efgh &
  that order has to change for them

- expecting that a given pair of extensions that appeared one after
  another would always do so is not something we should worry about
  breaking as it was always noted in the comment (and by the specs?)
  that new extensions would be added in alphabetical order (I'd like to
  think that if a clairvoyant wrote a parser and knew that there'd be
  nothing in the gap between the extensions we have now & what may be
  produced they'd also account for this re-ordering...)

- the re-order of sstc is going to land for v6.1 & the addition of sstc
  out of order landed in v6.0, so either that is an issue too or this is
  fine

I guess I sent the patches, so my opinion is fairly obvious, but I think
we change it & see if someone complains about an issue that something
other than a re-jig would break.

Thanks,
Conor.

