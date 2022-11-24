Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB78637D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 17:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiKXQVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 11:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKXQVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 11:21:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C0C16F0F9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 08:20:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2B18B82877
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 16:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F8AC433C1;
        Thu, 24 Nov 2022 16:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669306856;
        bh=r3P3R+q3tIY6iLKezMsVYtpb8aRdE95+sqsfCj5ASeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZSxklj9AF6r1B9EZtFwKy/+IeunBhP/iH1lu6dwCwtMvsNtxlJgrvMXDKqHQGPcR
         QKhfavdvnb2lCkwd0V2xWAvHqZszKLuzFcautEvSQ6LGdtOr8h58OEO4rPqgQ4beGr
         XdQhEp4yfXYw+qCY/ZkBLBMXBpBzyNWiOMaVbCl5+tTjKvl/B3ClUP4y3zDqHRo2WR
         fuWYUR85RETKgmunJSNXbTBvN9GxhIl1dzuAiM2ay9gVAirTTb6fCM5zBI45JFnipK
         Vh8yq3OcK/vn6N984VLnbxzMDuH7h/ZbuS9pgSys5D93eqG47sMak5CWKag/ByAR8y
         h+0PNhEa9lGEw==
Date:   Fri, 25 Nov 2022 00:11:05 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] riscv: vdso: remove hardcoded 0x800 .text section
 start addr
Message-ID: <Y3+XmWazrB0RURfI@xhacker>
References: <20221123161805.1579-1-jszhang@kernel.org>
 <20221124103255.33prhf3gf6xtwlsk@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221124103255.33prhf3gf6xtwlsk@kamzik>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 11:32:55AM +0100, Andrew Jones wrote:
> On Thu, Nov 24, 2022 at 12:18:05AM +0800, Jisheng Zhang wrote:
> > It seems the hardcoded 0x800 isn't necessary, but removing it brings a
> 
> s/, but/and/
> 
> > small vdso.so and aligns with other architectures.
> 
> This commit message didn't really satisfy my desire to understand why
> the comment and '. = 0x800' were there in the first place and if its safe
> to remove now, so I tried to do some of my own digging. I found
> 
> commit 5b9304933730 ("x86 vDSO: generate vdso-syms.lds")
> commit f6b46ebf904f ("x86 vDSO: new layout")
> 
> which removes the comment and hard coding for x86 by changing the vdso
> Makefile. Then looking at
> 
> commit 9031fefde6f2 ("arm64: VDSO support")
> 
> we see that it starts with the new Makefile approach and doesn't bother
> with the hard coding from the start. As riscv also started with the new
> Makefile approach it also could have dropped the hard coding from the
> start (I guess).
> 
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/kernel/vdso/vdso.lds.S | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
> > index 150b1a572e61..7be7e618d59c 100644
> > --- a/arch/riscv/kernel/vdso/vdso.lds.S
> > +++ b/arch/riscv/kernel/vdso/vdso.lds.S
> > @@ -31,13 +31,7 @@ SECTIONS
> >  
> >  	.rodata		: { *(.rodata .rodata.* .gnu.linkonce.r.*) }
> >  
> > -	/*
> > -	 * This linker script is used both with -r and with -shared.
> > -	 * For the layouts to match, we need to skip more than enough
> > -	 * space for the dynamic symbol table, etc. If this amount is
> > -	 * insufficient, ld -shared will error; simply increase it here.
> > -	 */
> > -	. = 0x800;
> > +	. = ALIGN(4);
> 
> I realize 4 is used here now because I questioned the 16, but after doing
> my digging I think a larger alignment may be better. Loading the text may
> be done with 8 byte or larger reads, so having the section aligned to a
> larger size would be better reading it. We might as well use 16, like
> arm64 does, and like you had before?
> 
> Also, having enough separation between data and text seems to be
> important for cache reasons, based on the comment in
> ./arch/x86/entry/vdso/vdso-layout.lds.S and other vdso history.
> Maybe we should move .note, .eh_frame_hdr, and .eh_frame below
> .rodata like x86 has it?
> 

Thank you so much for pointing out the two commits and above
separation, new version will be sent out soon.
