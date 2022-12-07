Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0F6646158
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiLGS66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLGS6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:58:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEA93AC0B;
        Wed,  7 Dec 2022 10:58:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 606B061BC2;
        Wed,  7 Dec 2022 18:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01996C433D6;
        Wed,  7 Dec 2022 18:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670439531;
        bh=tileNfIVVSzSkC6hGTUe9h984/Ujy2+taCQu+sbD3EM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZTOQvX+ZEFGW9ZgdU02BHVvgAgQ5IXPrg8Ro2U9dF/A7aynlgp91rKsVEfkZJCa3p
         WsK/udxDrqaHgQ0KH18sjNrXrT5pv5oMCGdcEtsHSXfOR11RzbA8NyWcDTcWF48I7x
         Dm6W5Kh/B6XSaJa/w7qjPYBTL8fPhfQdETdR/xNL/4ItIl2jfjk6r0WlxJU4xNJNil
         bUu6fNdZFVF9sv7z8zImG4Pm8IlpCixieuJm1DxwmBoQFAwdWmm6tuSnG0nPaJz01f
         rXy2cQ0Uw4ocHw7vZLmWikzqfeRjsAMk2efTWAubfz/oFNfCLBYf8sr/KZIwaQAc20
         /7YJqlEQJ5E1w==
Date:   Wed, 7 Dec 2022 11:58:49 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/2] padata: Do not mark padata_mt_helper() as __init
Message-ID: <Y5DiaT8+eQDLfJcW@dev-arch.thelio-3990X>
References: <20221129190123.872394-1-nathan@kernel.org>
 <20221129190123.872394-2-nathan@kernel.org>
 <CAK7LNASdOhcTqbnRibPumMH1o+78dxBjLuzLK+JS+AiHyTiY6A@mail.gmail.com>
 <20221206201526.al3tpbdvd244cvl5@parnassus.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206201526.al3tpbdvd244cvl5@parnassus.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 03:15:26PM -0500, Daniel Jordan wrote:
> On Thu, Dec 01, 2022 at 07:35:59AM +0900, Masahiro Yamada wrote:
> > On Wed, Nov 30, 2022 at 4:02 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > When building arm64 allmodconfig + ThinLTO with clang and a proposed
> > > modpost update to account for -ffuncton-sections, the following warning
> > > appears:
> > >
> > >   WARNING: modpost: vmlinux.o: section mismatch in reference: padata_work_init (section: .text.padata_work_init) -> padata_mt_helper (section: .init.text)
> > >   WARNING: modpost: vmlinux.o: section mismatch in reference: padata_work_init (section: .text.padata_work_init) -> padata_mt_helper (section: .init.text)
> > >
> > > In both cases, an __init function calls padata_work_init(), which is not
> > > marked __init, with padata_mt_helper(), another __init function, as a
> > > work function argument.
> > >
> > > padata_work_init() is called from non-init paths, otherwise it could be
> > > marked __init to resolve the warning. Instead, remove __init from
> > > padata_mt_helper() to resolve the warning.
> > >
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > ---
> > > Cc: Steffen Klassert <steffen.klassert@secunet.com>
> > > Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> > > Cc: linux-crypto@vger.kernel.org
> > > ---
> > >  kernel/padata.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/padata.c b/kernel/padata.c
> > > index e5819bb8bd1d..c2271d7e446d 100644
> > > --- a/kernel/padata.c
> > > +++ b/kernel/padata.c
> > > @@ -45,7 +45,7 @@ struct padata_mt_job_state {
> > >  };
> > >
> > >  static void padata_free_pd(struct parallel_data *pd);
> > > -static void __init padata_mt_helper(struct work_struct *work);
> > > +static void padata_mt_helper(struct work_struct *work);
> > >
> > >  static int padata_index_to_cpu(struct parallel_data *pd, int cpu_index)
> > >  {
> > > @@ -425,7 +425,7 @@ static int padata_setup_cpumasks(struct padata_instance *pinst)
> > >         return err;
> > >  }
> > >
> > > -static void __init padata_mt_helper(struct work_struct *w)
> > > +static void padata_mt_helper(struct work_struct *w)
> > >  {
> > >         struct padata_work *pw = container_of(w, struct padata_work, pw_work);
> > >         struct padata_mt_job_state *ps = pw->pw_data;
> > > --
> > > 2.38.1
> > >
> > 
> > This patch seems wrong.
> > 
> > padata_work_init() does not reference to padata_mt_helper()
> > 
> > 
> > padata_work_alloc_mt() and padata_do_multithreaded() do.
> 
> I see LLVM optimizing padata_work_init by embedding padata_mt_helper's
> address in its text, which runs afoul of modpost.
> 
> I agree with Masahiro, the warning is a false positive since only __init
> functions ever cause the embedded address to be used.
> 
> We have __ref for situations like this.  That way, padata_mt_helper can
> stay properly __init.

Ah, thank you for pointing out __ref, that seems to be exactly what we
want here. I will send a v2 marking padata_work_init() as __ref shortly.

Cheers,
Nathan
