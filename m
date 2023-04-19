Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0945C6E85FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 01:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjDSXhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 19:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDSXhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 19:37:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9871B2D62;
        Wed, 19 Apr 2023 16:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 314D263AA2;
        Wed, 19 Apr 2023 23:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAB3C433EF;
        Wed, 19 Apr 2023 23:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681947432;
        bh=RiJ8sZ4WJ7UP8H/LsivAO4Ph8LGZecE5A2kFeALbdlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g/HNMFE3cV1lmfiJJLo0zG9dTyRVVtMRJJzo13C1YO8PtnV8bzZHXkkzOwTxzPaIA
         1rxSt03W4s1Xul0xSnleXAazIoJuD84e0q2lUvZ+u28hBiAa3zM18HIoK72QyJHqpW
         suGYAzGdwXNe7JFLclUiB7sXCmaBMk66cdqtcDd6+2E/cwPegZiVtTijvYHPcq8qhe
         LIJLcLFbs3zu1XPufO7yDh7EgGqhFIX4wbp9PtZRh5tXdPugMCxGX/NCuZH32M4oXQ
         4v9Qf7rmvI9aiHZIC8YyfKXduvP0WT9oh4bLWg98sGydFVCbDMmW8dglPcl/w3/S+o
         jvpYBM6bTPghw==
Date:   Wed, 19 Apr 2023 16:37:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        jpoimboe@kernel.org, peterz@infradead.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] MIPS: Mark check_bugs{,_early}() as __init
Message-ID: <20230419233710.GA1314058@dev-arch.thelio-3990X>
References: <20230419-mips-check_bugs-init-attribute-v1-1-91e6eed55b89@kernel.org>
 <CAKwvOdmuQBnZR_pB5bUdsF+OoB_4pxBT9TNFF83fZhzwZ1gbxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmuQBnZR_pB5bUdsF+OoB_4pxBT9TNFF83fZhzwZ1gbxw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 03:03:31PM -0700, Nick Desaulniers wrote:
> On Wed, Apr 19, 2023 at 11:43 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > After commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
> > forcibly"), a compiler may choose not to inline a function marked with
> > just 'inline'. If check_bugs() is not inlined into start_kernel(), which
> > occurs when building with clang after commit 9ea7e6b62c2b ("init: Mark
> > [arch_call_]rest_init() __noreturn"), modpost complains with:
> >
> >   WARNING: modpost: vmlinux.o: section mismatch in reference: check_bugs (section: .text) -> check_bugs32 (section: .init.text)
> >
> > check_bugs() is only called from start_kernel(), which itself is marked
> > __init, so mark check_bugs() as __init as well to clear up the warning
> > and make everything work properly.
> >
> > While there is currently no warning about check_bugs_early(), it could
> > have the same problem, as it is called from arch_setup() and calls
> > check_bugs64_early(), both marked __init. Mark it as __init for the same
> > reason as above.
> >
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> > NOTE: This is based on v6.3-rc7, as the issue shows up due to a patch in
> > the tip tree, but this appears to be an ancient issue that could have
> > showed up at any point (hence why no explicit Fixes tag), so I chose a
> > base that should allow either the MIPS or tip folks to apply this patch.
> 
> Probably for the MIPS tree.
> 
> >
> > Additionally, I was tempted to remove the explicit 'inline' since the
> > compiler is free to do whatever it wants anyways but this is a static
> > function in a header so we would need to add '__maybe_unused', which is
> > already added with 'inline' in a normal build so I just left it alone.
> > ---
> >  arch/mips/include/asm/bugs.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/mips/include/asm/bugs.h b/arch/mips/include/asm/bugs.h
> > index d72dc6e1cf3c..9b9bf9bc7d24 100644
> > --- a/arch/mips/include/asm/bugs.h
> > +++ b/arch/mips/include/asm/bugs.h
> > @@ -24,13 +24,13 @@ extern void check_bugs64_early(void);
> >  extern void check_bugs32(void);
> >  extern void check_bugs64(void);
> >
> > -static inline void check_bugs_early(void)
> > +static inline void __init check_bugs_early(void)
> >  {
> >         if (IS_ENABLED(CONFIG_CPU_R4X00_BUGS64))
> >                 check_bugs64_early();
> >  }
> 
> If the only call site is in arch/mips/kernel/setup.c, then perhaps we
> can move the definition of check_bugs_early there and mark it static
> __init and drop inline?

Sure, we could even go a step further and just copy the body into the
one call site ourselves, I see little reason for this to be a dedicated
function. That is probably best done in a separate patch altogether in
lieu of just adding __init.

> Unless we foresee other callers potentially in the future?  Patch
> otherwise LGTM.  Thanks for the patch!

Seems unlikely, I did a super scientific survey of several different
revisions (:P) and check_bugs_early() is called once in each one:

v3.0:arch/mips/kernel/setup.c:    check_bugs_early();
v3.5:arch/mips/kernel/setup.c:    check_bugs_early();
v3.10:arch/mips/kernel/setup.c:    check_bugs_early();
v4.0:arch/mips/kernel/setup.c:    check_bugs_early();
v4.5:arch/mips/kernel/setup.c:    check_bugs_early();
v5.0:arch/mips/kernel/setup.c:    check_bugs_early();
v4.10:arch/mips/kernel/setup.c:    check_bugs_early();
v5.5:arch/mips/kernel/setup.c:    check_bugs_early();
v5.10:arch/mips/kernel/setup.c:    check_bugs_early();
v6.0:arch/mips/kernel/setup.c:    check_bugs_early();

I'll do whatever Thomas would prefer.

> >
> > -static inline void check_bugs(void)
> > +static inline void __init check_bugs(void)
> >  {
> >         unsigned int cpu = smp_processor_id();
> >
> >
> > ---
> > base-commit: 6a8f57ae2eb07ab39a6f0ccad60c760743051026
> > change-id: 20230419-mips-check_bugs-init-attribute-026103bdb255
> >
> > Best regards,
> > --
> > Nathan Chancellor <nathan@kernel.org>
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
