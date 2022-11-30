Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E340763E38B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 23:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiK3WiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 17:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiK3Wh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 17:37:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EC643848;
        Wed, 30 Nov 2022 14:37:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0A1C61E0F;
        Wed, 30 Nov 2022 22:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F59C433D6;
        Wed, 30 Nov 2022 22:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669847878;
        bh=wBJggPu6LEiCX32dXU3wBuz4z4f1m5wgizBQVClgrRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sdfn9F8Y5LEqFHHvrUouhm7+w7eSEiFZ9qjZWrfNiVQtQD///hEuuxYZYQsc1hbA0
         2XX1vOYwmtw/z6cK5q7L6gM2xrzM4+RkCr3Yfljj+JJPxFtHVZXl01IJzy1CLRsnfC
         lSfM0zUG3rdwU6ZRrkEElKs4vOvf9ZLpdPHs3oG2ZucB7EaXxOhpDcE5JsxIMqudyn
         BpUQWM1xP2K/XbjyKfgmmbsxV7xOjf7GY7QO+1J2LuFRG6YuOOc3EU5ILfvxZWa3Hr
         ibsdMVYTuuckkvJVNMWzbBwTPnAUFskagqWh+aiZYH/foPZNCERQUEzHlmDOvun6oF
         4amgxs2OjihSA==
Date:   Wed, 30 Nov 2022 15:37:55 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/2] padata: Do not mark padata_mt_helper() as __init
Message-ID: <Y4fbQ2POgXFrsHhF@dev-arch.thelio-3990X>
References: <20221129190123.872394-1-nathan@kernel.org>
 <20221129190123.872394-2-nathan@kernel.org>
 <CAK7LNATMtRu00GYwJW_VvTSTcY6eqnx=4EEj8PFC5adrnHunSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATMtRu00GYwJW_VvTSTcY6eqnx=4EEj8PFC5adrnHunSw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 07:20:47AM +0900, Masahiro Yamada wrote:
> On Wed, Nov 30, 2022 at 4:02 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > When building arm64 allmodconfig + ThinLTO with clang and a proposed
> > modpost update to account for -ffuncton-sections, the following warning
> > appears:
> 
> 
> 
> How to enable -ffuncton-sections for ARCH=arm64 ?
> (in other words, how to set CONFIG_LD_DEAD_CODE_DATA_ELIMINATION ?)

clang LTO implies -fdata-sections and -ffunction-sections.

$ cat foo.c
int foo(void)
{
        return 0;
}

$ cat bar.c
extern int foo(void);

int bar(void)
{
        return foo();
}

$ clang -c -o foo.{o,c}
$ clang -c -o bar.{o,c}
$ ld.lld -r -o foobar {foo,bar}.o
$ llvm-readelf -s foobar

Symbol table '.symtab' contains 9 entries:
   Num:    Value          Size Type    Bind   Vis       Ndx Name
     0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   UND
     1: 0000000000000000     0 FILE    LOCAL  DEFAULT   ABS foo.c
     2: 0000000000000000     0 SECTION LOCAL  DEFAULT     1 .text
     3: 0000000000000000     0 SECTION LOCAL  DEFAULT     3 .eh_frame
     4: 0000000000000000     0 SECTION LOCAL  DEFAULT     5 .llvm_addrsig
     5: 0000000000000000     0 FILE    LOCAL  DEFAULT   ABS bar.c
     6: 0000000000000000     0 SECTION LOCAL  DEFAULT     2 .comment
     7: 0000000000000000     8 FUNC    GLOBAL DEFAULT     1 foo
     8: 0000000000000010    11 FUNC    GLOBAL DEFAULT     1 bar

$ clang -flto -c -o foo.{o,c}
$ clang -flto -c -o bar.{o,c}
$ ld.lld -r -o foobar {foo,bar}.o
$ llvm-readelf -s foobar

Symbol table '.symtab' contains 10 entries:
   Num:    Value          Size Type    Bind   Vis       Ndx Name
     0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   UND
     1: 0000000000000000     0 FILE    LOCAL  DEFAULT   ABS ld-temp.o
     2: 0000000000000000     0 SECTION LOCAL  DEFAULT     1 .text
     3: 0000000000000000     0 SECTION LOCAL  DEFAULT     2 .text.foo
     4: 0000000000000000     0 SECTION LOCAL  DEFAULT     3 .text.bar
     5: 0000000000000000     0 SECTION LOCAL  DEFAULT     6 .eh_frame
     6: 0000000000000000     0 SECTION LOCAL  DEFAULT     8 .llvm_addrsig
     7: 0000000000000000     0 SECTION LOCAL  DEFAULT     5 .comment
     8: 0000000000000000     8 FUNC    GLOBAL DEFAULT     2 foo
     9: 0000000000000000    13 FUNC    GLOBAL DEFAULT     3 bar

> In upstream, it is only possible for mips and powerpc.
> 
> ./arch/mips/Kconfig:82: select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> ./arch/powerpc/Kconfig:237: select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> 
> 
> 
> Is there another proposal to add it for arm64,
> or is this about a downstream kernel?
> 
> 
> 
> 
> 
> >
> >   WARNING: modpost: vmlinux.o: section mismatch in reference: padata_work_init (section: .text.padata_work_init) -> padata_mt_helper (section: .init.text)
> >   WARNING: modpost: vmlinux.o: section mismatch in reference: padata_work_init (section: .text.padata_work_init) -> padata_mt_helper (section: .init.text)
> >
> > In both cases, an __init function calls padata_work_init(), which is not
> > marked __init, with padata_mt_helper(), another __init function, as a
> > work function argument.
> >
> > padata_work_init() is called from non-init paths, otherwise it could be
> > marked __init to resolve the warning. Instead, remove __init from
> > padata_mt_helper() to resolve the warning.
> >
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
> > index e5819bb8bd1d..c2271d7e446d 100644
> > --- a/kernel/padata.c
> > +++ b/kernel/padata.c
> > @@ -45,7 +45,7 @@ struct padata_mt_job_state {
> >  };
> >
> >  static void padata_free_pd(struct parallel_data *pd);
> > -static void __init padata_mt_helper(struct work_struct *work);
> > +static void padata_mt_helper(struct work_struct *work);
> >
> >  static int padata_index_to_cpu(struct parallel_data *pd, int cpu_index)
> >  {
> > @@ -425,7 +425,7 @@ static int padata_setup_cpumasks(struct padata_instance *pinst)
> >         return err;
> >  }
> >
> > -static void __init padata_mt_helper(struct work_struct *w)
> > +static void padata_mt_helper(struct work_struct *w)
> >  {
> >         struct padata_work *pw = container_of(w, struct padata_work, pw_work);
> >         struct padata_mt_job_state *ps = pw->pw_data;
> > --
> > 2.38.1
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
