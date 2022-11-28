Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2C663B217
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiK1TTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiK1TTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:19:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7B72701
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:19:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0576B80D84
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F06AC433D6;
        Mon, 28 Nov 2022 19:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669663184;
        bh=wwhiPDZvy9BYZzrmMVEGTga8TykXovqTCIVplJR4AY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NtfDWal8scRDcXDBQUfig851n5GT8MTyhNPFZwIunzV16X+OFd3UVRq4lcTG7tJ2O
         dXU6D2Hoz1L3U31teGlwvlse5pDcB6SZYj8eDB9SCMSGYwZqK/nM2/xeEUIgYRVE0x
         cUVg8HJwoO57x0PkFs+J6pQDBH6dD2p4ko2IbR8HAFDWrWyvdTdwRlstvLetJh8Io7
         +jucjPXwQ3PMQD9xJG5Zc+4IWYSpNchSs7J7apR4UqC++qOhzNUNkuG/cbGP4QCWpg
         tm5AYwBNNXALdDIY+KKBhdQs1Bc34SBJ2FETfD95MwfTIZjNGWXRCYkK3UN9UACArZ
         Q/Lb6X17CPdQg==
Date:   Mon, 28 Nov 2022 19:19:39 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] riscv: Fix NR_CPUS range conditions
Message-ID: <Y4UJy0xL4Cj9tH2W@spud>
References: <20221126061557.3541-1-samuel@sholland.org>
 <Y4IxdOPWhLLg5rwd@spud>
 <20221128183559.5ei5fx4cl4mo3ioj@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128183559.5ei5fx4cl4mo3ioj@kamzik>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 07:35:59PM +0100, Andrew Jones wrote:
> On Sat, Nov 26, 2022 at 03:32:04PM +0000, Conor Dooley wrote:
> > On Sat, Nov 26, 2022 at 12:15:56AM -0600, Samuel Holland wrote:
> > > The conditions reference the symbol SBI_V01, which does not exist. The
> > > correct symbol is RISCV_SBI_V01.
> > 
> > Huh, good spot.
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Yeah, huh. It never occurred to me that we don't have some sort of symbol
> referencing checking in kconfig. Or maybe we do and I just don't know how

kismet, but that does the opposite. Randy Dunlap is the only person I
see fiddling with that stuff usually, so perhaps he knows? +CC them
either way.

> to enable it? Anyway, this issue made me wonder how many more dangling
> references we may have. I wrote a script to look for them and found 29,
> including this one. I'm not exactly sure how to report them since they
> touch so many different places. For now, I've opened this kernel BZ
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=216748
> 
> > 
> > > 
> > > Fixes: e623715f3d67 ("RISC-V: Increase range and default value of NR_CPUS")
> > > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > > ---
> > > 
> > >  arch/riscv/Kconfig | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index fec54872ab45..acbfe34c6a00 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -319,9 +319,9 @@ config SMP
> > >  config NR_CPUS
> > >  	int "Maximum number of CPUs (2-512)"
> > >  	depends on SMP
> > > -	range 2 512 if !SBI_V01
> > > -	range 2 32 if SBI_V01 && 32BIT
> > > -	range 2 64 if SBI_V01 && 64BIT
> > > +	range 2 512 if !RISCV_SBI_V01
> > > +	range 2 32 if RISCV_SBI_V01 && 32BIT
> > > +	range 2 64 if RISCV_SBI_V01 && 64BIT
> 
> And for this patch,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> Thanks,
> drew
