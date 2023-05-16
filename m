Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD5670434C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjEPCQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjEPCQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:16:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5C04C24;
        Mon, 15 May 2023 19:16:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B649633EC;
        Tue, 16 May 2023 02:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0D8C433D2;
        Tue, 16 May 2023 02:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684203411;
        bh=VC0Lgt0I7EMYVJqPjsZ6wzgRD9QzgPlLiDwc/6s1x8E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TkkWzY+YZQUKVESw2wgzhKHKQ7Ky2aL+g4lv6hPQhq5I/XgITZV2j4gBSzuxM4BKI
         1NGIQSCTSkNEMGzwkzoP7ZUT0y+6RP4DLPtuGlU2CSG13DZR01HYQ6COuURdDp685E
         RCy+Zf5Qr/BZKyrM8k1Nf0E1QNNr0A7G9eTH7jHpOfcn9R/17JrUIEZIwi7WeEzo9l
         2J/fwk7zwPwRqcH62TGKAHS89fiXd1yCiaQMA+cBOTaHHPex5jd9CGbDA5RZgPJCpR
         TxMesfmpwhrln+xoBm3TnOYLuzVVgat46iCdEk8d7vaa+4sX3mb4uUrGlPQoe6VWLv
         Hiem31flC3aPA==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-546ee6030e5so6377268eaf.3;
        Mon, 15 May 2023 19:16:51 -0700 (PDT)
X-Gm-Message-State: AC+VfDyDSQtTKPjSag/2ooy8MIQK/q7MEf1LXcHxqixVoTb79QObevXH
        YLVC3EYAaI7iBm42D5dv+HK+iYrti1lPOAqYx7A=
X-Google-Smtp-Source: ACHHUZ7+RyqCGkwV4YXTr8F6RlzedtSBz4qNByRN560t7Q/ammZP0yd66uXBjMllfSJKlIbQnCpjRR9pPeDsJ/WnnlI=
X-Received: by 2002:a4a:271a:0:b0:54c:b94b:bc2e with SMTP id
 l26-20020a4a271a000000b0054cb94bbc2emr9564438oof.0.1684203410721; Mon, 15 May
 2023 19:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org> <20230514152739.962109-22-masahiroy@kernel.org>
 <93s3n008-7oon-30rq-5219-5r244919r38q@syhkavp.arg> <CABCJKuf91O4OtBQ62CRuCYHWrENdvjnzHdyH135qCt24rX4Lsg@mail.gmail.com>
In-Reply-To: <CABCJKuf91O4OtBQ62CRuCYHWrENdvjnzHdyH135qCt24rX4Lsg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 16 May 2023 11:16:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT_MakkY3hMaCJE=iFFc27tM-Xjw1fC_SQX8WycQRmouw@mail.gmail.com>
Message-ID: <CAK7LNAT_MakkY3hMaCJE=iFFc27tM-Xjw1fC_SQX8WycQRmouw@mail.gmail.com>
Subject: Re: [PATCH v5 21/21] kbuild: implement CONFIG_TRIM_UNUSED_KSYMS
 without recursion
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nicolas Pitre <nico@fluxnic.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 7:54=E2=80=AFAM Sami Tolvanen <samitolvanen@google.=
com> wrote:
>
> On Mon, May 15, 2023 at 2:39=E2=80=AFPM Nicolas Pitre <nico@fluxnic.net> =
wrote:
> >
> > On Mon, 15 May 2023, Masahiro Yamada wrote:
> >
> > > When CONFIG_TRIM_UNUSED_KSYMS is enabled, Kbuild recursively traverse=
s
> > > the directory tree to determine which EXPORT_SYMBOL to trim. If an
> > > EXPORT_SYMBOL turns out to be unused by anyone, Kbuild begins the
> > > second traverse, where some source files are recompiled with their
> > > EXPORT_SYMBOL() tuned into a no-op.
> > >
> > > Linus stated negative opinions about this slowness in commits:
> > >
> > >  - 5cf0fd591f2e ("Kbuild: disable TRIM_UNUSED_KSYMS option")
> > >  - a555bdd0c58c ("Kbuild: enable TRIM_UNUSED_KSYMS again, with some g=
uarding")
> > >
> > > We can do this better now. The final data structures of EXPORT_SYMBOL
> > > are generated by the modpost stage, so modpost can selectively emit
> > > KSYMTAB entries that are really used by modules.
> > >
> > > Commit 2cce989f8461 ("kbuild: unify two modpost invocations") is anot=
her
> > > ground-work to do this in a one-pass algorithm. With the list of modu=
les,
> > > modpost sets sym->used if it is used by a module. modpost emits KSYMT=
AB
> > > only for symbols with sym->used=3D=3Dtrue.
> > >
> > > BTW, Nicolas explained why the trimming was implemented with recursio=
n:
> > >
> > >   https://lore.kernel.org/all/2o2rpn97-79nq-p7s2-nq5-8p83391473r@syhk=
avp.arg/
> > >
> > > Actually, we never achieved that level of optimization where the chai=
n
> > > reaction of trimming comes into play because:
> > >
> > >  - CONFIG_LTO_CLANG cannot remove any unused symbols
> > >  - CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is enabled only for vmlinux,
> > >    but not modules
> >
> > I did achieve it using LTO with gcc back then. See the section called
> > "The tree that hides the forest" of https://lwn.net/Articles/746780/ fo=
r
> > example results.
>
> Clang can do similar optimizations, but not in relocatable links where
> the linker must obviously preserve all the globals.

Yeah, the issue is not in the compiler itself
but in the way CONFIG_LTO_CLANG was implemented.

If it had been implemented in the final link stage,
it would have required LTO running three times
with CONFIG_KALLSYMS=3Dy.
But scripts/generate_initcall_order.pl would
have been unneeded. And, maybe we would get slightly
better vmlinux.

I think the help message of CONFIG_LTO_CLANG_FULL is
a misleading advertisement.

We did not achieve such deeper trimming
that is described in this link:

  https://llvm.org/docs/LinkTimeOptimization.html


If I remember correctly, GCC LTO was implemented
in the final link stage. So, trimming was depper
but it ran three times.





> A while ago there
> was a suggestion of adding an option to LLD that allows one to pass a
> list of symbols to preserve in relocatable LTO links, which would
> allow us to better optimize vmlinux.o. However, I haven't had a chance
> to look into this deeper than this proof of concept:
>
> https://reviews.llvm.org/D142163


Interesting.

But, scripts/generate_initcall_order.pl is still needed, right?

--lto-export-symbol-list is a list of symbols,
but it does not specify the correct order?



Nocolas explained the chain reaction of
compiling modules with LTO, but I suspect it
because modules are always relocatable ELF.


The LWN article (https://lwn.net/Articles/746780/) is awesome
but I think the benefit of LTO is for vmlinux,
not for modules.



>
> > > If deeper trimming is required, we need to revisit this, but I guess
> > > that is unlikely to happen.
> >
> > Would have been nicer to keep this possibility as an option. The code i=
s
> > already there and working as intended. The build cost is intrinsic to
> > the approach of course. The actual bug is to impose that cost onto
> > people who didn't explicitly ask for it.
> >
> > But I'm no longer fighting this battle.
>
> I agree, this looks like a reasonable solution for now.
>
> Sami



--=20
Best Regards
Masahiro Yamada
