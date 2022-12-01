Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DC763EE5D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiLAKtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiLAKse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:48:34 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DF913D46;
        Thu,  1 Dec 2022 02:47:20 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1p0h5t-0000rB-MD; Thu, 01 Dec 2022 11:47:05 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        aou@eecs.berkeley.edu, corbet@lwn.net, guoren@kernel.org,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 2/3] RISC-V: resort all extensions in consistent orders
Date:   Thu, 01 Dec 2022 11:47:04 +0100
Message-ID: <46873028.fMDQidcC6G@diego>
In-Reply-To: <20221201090041.525op4sateq5wq4y@kamzik>
References: <20221130234125.2722364-1-conor@kernel.org> <20221130234125.2722364-3-conor@kernel.org> <20221201090041.525op4sateq5wq4y@kamzik>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 1. Dezember 2022, 10:00:41 CET schrieb Andrew Jones:
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
> > I could not decide between adding an alphabetical comment to each
> > alphabetical site or not. I did it anyway. Scream if you hate it!
> > 
> > I also moved a static branch thingy in this version, but that should not
> > matter, right? riightt?
> 
> riiighttt. And it goes away with [1] anyway.
> 
> [1] https://lore.kernel.org/all/20221006070818.3616-1-jszhang@kernel.org/

I'm not sure what became of that series since mid october, though noting
that tightly coupling the patching to extensions alone might cause issues [2]
which some of the "features" like fast-unaligned access, that are not directly
bound to a isa-extension but to an implementation detail

[2] https://lore.kernel.org/all/1991071.yIU609i1g2@phil/


> 
> > ---
> >  arch/riscv/include/asm/hwcap.h | 12 +++++++-----
> >  arch/riscv/kernel/cpu.c        |  4 ++--
> >  arch/riscv/kernel/cpufeature.c |  6 ++++--
> >  3 files changed, 13 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > index b22525290073..ce522aad641a 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -51,14 +51,15 @@ extern unsigned long elf_hwcap;
> >   * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
> >   * extensions while all the multi-letter extensions should define the next
> >   * available logical extension id.
> > + * Entries are sorted alphabetically.
> >   */
> >  enum riscv_isa_ext_id {
> >  	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
> > +	RISCV_ISA_EXT_SSTC,
> > +	RISCV_ISA_EXT_SVINVAL,
> >  	RISCV_ISA_EXT_SVPBMT,
> >  	RISCV_ISA_EXT_ZICBOM,
> >  	RISCV_ISA_EXT_ZIHINTPAUSE,
> > -	RISCV_ISA_EXT_SSTC,
> > -	RISCV_ISA_EXT_SVINVAL,
> >  	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
> >  };
> 
> Unrelated to this patch, but every time I look at this enum I want to post
> the diff below, but I haven't bothered, because this enum also goes away
> with [1].
> 
> @@ -59,8 +59,9 @@ enum riscv_isa_ext_id {
>         RISCV_ISA_EXT_ZIHINTPAUSE,
>         RISCV_ISA_EXT_SSTC,
>         RISCV_ISA_EXT_SVINVAL,
> -       RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
> +       RISCV_ISA_EXT_ID_MAX
>  };
> +static_assert(RISCV_ISA_EXT_ID_MAX <= RISCV_ISA_EXT_MAX);

that sounds like a very reasonable idea ... what's keeping you? :-)


Heiko


