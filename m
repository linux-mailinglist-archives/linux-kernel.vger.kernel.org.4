Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9821564A57A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiLLRFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiLLRFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:05:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A9510DD;
        Mon, 12 Dec 2022 09:05:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67D136115C;
        Mon, 12 Dec 2022 17:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B21C433F0;
        Mon, 12 Dec 2022 17:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670864704;
        bh=KmG4ro7h+VdOXjEslNq+8iBWKBTQ/RA7zskQtxL+RXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aj6vrtB3Y2skOx8SKPJd7krfhSKJ/utA+bWT4xTHarHMUD3/lISCtlvJqPHL60pzb
         gBefVSEqHgMTU2td3vxDOudSSqtIFyGEE3fjACq1ImpoFS6AbTSU4gyoNzKLtYmaUk
         8HFKc5bYSKCl0NPKxs5dwH01VjTI/AU8U1qEI6cnPh7ywjBflGg9Adm5tMcwnxVY3Q
         IzeAVMFpIdKeFQBwv3sUlGm3hpuFpURSm4Di7el+3ELuoTPiN3B+mdwleD0ujL+D77
         U47NENYSq9mwaTnfNquImIqO6NV+79DE502FuufTe2OhE4tXY8SzjLVoqYzGx34tUW
         xOp0Is+zD4lrA==
Date:   Mon, 12 Dec 2022 10:05:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/2] padata: Mark padata_work_init() as __ref
Message-ID: <Y5dfPgNF8E2EpNCM@dev-arch.thelio-3990X>
References: <20221207191657.2852229-1-nathan@kernel.org>
 <20221207191657.2852229-2-nathan@kernel.org>
 <CAK7LNARoxqSzjpM0twcssMkf9X_PppzqtUo_opq=CX+zixma8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARoxqSzjpM0twcssMkf9X_PppzqtUo_opq=CX+zixma8g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 10:07:24PM +0900, Masahiro Yamada wrote:
> On Thu, Dec 8, 2022 at 4:17 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > When building arm64 allmodconfig + ThinLTO with clang and a proposed
> > modpost update to account for -ffuncton-sections, the following warning
> > appears:
> >
> >   WARNING: modpost: vmlinux.o: section mismatch in reference: padata_work_init (section: .text.padata_work_init) -> padata_mt_helper (section: .init.text)
> >   WARNING: modpost: vmlinux.o: section mismatch in reference: padata_work_init (section: .text.padata_work_init) -> padata_mt_helper (section: .init.text)
> >
> > LLVM has optimized padata_work_init() to include the address of
> > padata_mt_helper() directly, which causes modpost to complain since
> > padata_work_init() is not __init, whereas padata_mt_helper() is. In
> > reality, padata_work_init() is only called with padata_mt_helper() as
> > the work_fn argument in code that is __init, so this warning will not
> > result in any problems. Silence it with __ref, which makes it clear to
> > modpost that padata_work_init() can only use padata_mt_helper() in
> > __init code.
> >
> > Suggested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> > Cc: Steffen Klassert <steffen.klassert@secunet.com>
> > Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> > Cc: linux-crypto@vger.kernel.org
> > ---
> >  kernel/padata.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/padata.c b/kernel/padata.c
> > index e5819bb8bd1d..4c3137fe8449 100644
> > --- a/kernel/padata.c
> > +++ b/kernel/padata.c
> > @@ -83,8 +83,8 @@ static struct padata_work *padata_work_alloc(void)
> >         return pw;
> >  }
> >
> > -static void padata_work_init(struct padata_work *pw, work_func_t work_fn,
> > -                            void *data, int flags)
> > +static __ref void padata_work_init(struct padata_work *pw, work_func_t work_fn,
> > +                                  void *data, int flags)
> >  {
> >         if (flags & PADATA_WORK_ONSTACK)
> >                 INIT_WORK_ONSTACK(&pw->pw_work, work_fn);
> >
> > base-commit: 76dcd734eca23168cb008912c0f69ff408905235
> > --
> > 2.38.1
> >
> 
> It took me a while to understand why LTO can embed
> padata_mt_helper's address into padata_work_init().

Sorry about that, I can try to expand on this in both the commit message
and in-code comment if I end up adding it.

> There are 3 call-sites to padata_work_init().
> 
> (1)  __init padata_work_alloc_mt()
>          -->  padata_work_init(..., padata_mt_helper, ...)
> 
> (2) padata_do_parallel()
>          -->  padata_work_init(..., padata_parallel_worker, ...)
> 
> (3) __init padata_do_multithreaded()
>         --> padata_work_init(..., padata_mt_helper, ...)
> 
> 
> The function call (2) is squashed away.
> 
> 
> With only (1) and (3) remaining, the 2nd parameter to
> padata_work_init() is always padata_mt_helper,
> therefore LLVM embeds padata_mt_hlper's address
> directly into padata_work_init().
> 
> I am not sure if the compiler should do this level of optimization
> because kernel/padata.c does not seem to be a special case.
> Perhaps, we might be hit with more cases that need __ref annotation,
> which is only required by LTO.

That's possible. I did only see this once instance in all my builds but
allmodconfig + ThinLTO might not be too interesting of a case,
since the sanitizers will be enabled, which makes optimization more
difficult. I could try to enable ThinLTO with some distribution
configurations to see if there are any more instances that crop up.

> One note is that, we could discard padata_work_init()
> because (1) and (3) are both annotated as __init.
> So, another way of fixing is
>    static __always_inline void padata_work_init(...)
> because the compiler would determine padata_work_init()
> would be small enough if the caller and callee belonged to
> the same section.
> 
> I do not have a strong opinion.
> Honestly, I do not know what the best approach would be to fix this.

Agreed to both points, it is really up to the padata maintainers.

> If we go with the __ref annotation, I can pick this, but
> at least can you add some comments?
> 
> 
> include/linux/init.h says:
> "optimally document why the __ref is needed and why it's OK"
> 
> 
> I think this is the case that needs some comments
> because LTO optimization looks too tricky to me.

Sure thing, I will send a v3 either Tuesday or Wednesday with an updated
commit message and code comment if we end up going this route.

Thank you for the review!

Cheers,
Nathan
