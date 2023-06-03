Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38252721137
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 18:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjFCQXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 12:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFCQXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 12:23:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB39BB;
        Sat,  3 Jun 2023 09:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F40E60A5C;
        Sat,  3 Jun 2023 16:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D07C433D2;
        Sat,  3 Jun 2023 16:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685809426;
        bh=DObsz3X+0kn7tZFIPV9cliWFhjZ6iUIjxIfHma3XYL0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UCFgp98SdKOVsIR1BxEP/Dzd22rz0GDezMPMQsX/SvJER7775F19V7zXsYQvrRmNf
         OLOtbGWex39BrLMhqXW4HzdGvxb/hMEyQ/cx8JlF+V0HODERyWEWfBKxyfrzGn+CCe
         xw8vq+8G7RRoKbIXD40gNGtuHD9LonU98pJi76Bir+osx8MOCR4tZJUPZspU/jHoMA
         F7rfb+cMgiRUgXbOStsKn203sg4dZ1fgfEXeGCFMW/LbhOCR1qn+zaGLxKAc5E45po
         TsAoGgamclTE0lQZEEMYgs0et2nWQPc03a9C4vq8U0dbRcAxQ93k3zwqMA1LYt5yel
         nF7OU7HwCdgkg==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-39810ce3e13so2817413b6e.2;
        Sat, 03 Jun 2023 09:23:45 -0700 (PDT)
X-Gm-Message-State: AC+VfDzdu1zIsxqevxDDbxRaU/9oEEx2J2aArxTEs2YL99TR/bLEpCXA
        572AO9BBOcVqJB1RscIc1L0Jor8QhLabR3Lyblo=
X-Google-Smtp-Source: ACHHUZ6hpsnGhpLz5li3DNJ1xqZ+qYnxy/iQ6EoGUJb9CJqHof4FygP0R3CUvd7v2nFld3aY5CKwjJEL8ZPOXyU4kpI=
X-Received: by 2002:aca:120d:0:b0:39a:a65c:42a2 with SMTP id
 13-20020aca120d000000b0039aa65c42a2mr397218ois.49.1685809425224; Sat, 03 Jun
 2023 09:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230409145358.2538266-1-masahiroy@kernel.org> <20230531213319.GA2201875@dev-arch.thelio-3990X>
In-Reply-To: <20230531213319.GA2201875@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 4 Jun 2023 01:23:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNASeNAx5a1P9fkf+8+Fj4HFujPN=57fWtAoc7XL97LdkxA@mail.gmail.com>
Message-ID: <CAK7LNASeNAx5a1P9fkf+8+Fj4HFujPN=57fWtAoc7XL97LdkxA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add $(CLANG_CFLAGS) to KBUILD_CPPFLAGS
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rini <trini@konsulko.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 6:33=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> Hi Masahiro,
>
> On Sun, Apr 09, 2023 at 11:53:57PM +0900, Masahiro Yamada wrote:
> > When preprocessing arch/*/kernel/vmlinux.lds.S, the target triple is
> > not passed to $(CPP) because we add it only to KBUILD_{C,A}FLAGS.
> >
> > As a result, the linker script is preprocessed with predefined macros
> > for the build host instead of the target.
> >
> > Assuming you use an x86 build machine, compare the following:
> >
> >  $ clang -dM -E -x c /dev/null
> >  $ clang -dM -E -x c /dev/null -target aarch64-linux-gnu
> >
> > There is no actual problem presumably because our linker scripts do not
> > rely on such predefined macros, but it is better to define correct ones=
.
> >
> > Move $(CFLAGS_CFLAGS) to KBUILD_CPPFLAGS, so that all *.c, *.S, *.lds.S
> > will be processed with the proper target triple.
> >
> > Reported-by: Tom Rini <trini@konsulko.com>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/Makefile.clang | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> > index 70b354fa1cb4..93ca059cc3b8 100644
> > --- a/scripts/Makefile.clang
> > +++ b/scripts/Makefile.clang
> > @@ -38,6 +38,5 @@ CLANG_FLAGS +=3D -Werror=3Dunknown-warning-option
> >  CLANG_FLAGS  +=3D -Werror=3Dignored-optimization-argument
> >  CLANG_FLAGS  +=3D -Werror=3Doption-ignored
> >  CLANG_FLAGS  +=3D -Werror=3Dunused-command-line-argument
> > -KBUILD_CFLAGS        +=3D $(CLANG_FLAGS)
> > -KBUILD_AFLAGS        +=3D $(CLANG_FLAGS)
> > +KBUILD_CPPFLAGS      +=3D $(CLANG_FLAGS)
> >  export CLANG_FLAGS
> > --
> > 2.37.2
> >
>
> I am doubling back to this change, as the lack of '--target' in
> KBUILD_CPPFLAGS is now an active bug with clang-17 due to a new change
> that rejects '-mbig-endian' and '-mlittle-endian' when not supported by
> the target, which breaks the arm64 vDSO build when preprocessing its
> linker script:
>
>   # Turn on CONFIG_CPU_BIG_ENDIAN in menuconfig
>   $ make -skj"$(nproc)" ARCH=3Darm64 LLVM=3D1 O=3Dbuild mrproper virtconf=
ig menuconfig arch/arm64/kernel/vdso/
>   ...
>   clang: error: unsupported option '-mbig-endian' for target 'x86_64-pc-l=
inux-gnu'
>   make[3]: *** [.../scripts/Makefile.build:387: arch/arm64/kernel/vdso/vd=
so.lds] Error 1
>   ...
>
>   https://github.com/llvm/llvm-project/commit/d81ce04587c006b6731198956c5=
22c93d0df1050
>   https://github.com/ClangBuiltLinux/linux/issues/1859
>
> This change resolves that issue.

Ah. Now we have a good reason to apply this patch.



> I was able to figure out why those new
> warnings appeared for ARCH=3Dmips, it is the shell invocation for
> CHECKFLAGS. The following diff resolves it for me:
>
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index a7a4ee66a9d3..ef7b05ae92ce 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -346,7 +346,7 @@ KBUILD_CFLAGS +=3D -fno-asynchronous-unwind-tables
>  KBUILD_LDFLAGS         +=3D -m $(ld-emul)
>
>  ifdef CONFIG_MIPS
> -CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
> +CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E=
 -x c /dev/null | \
>         grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
>         sed -e "s/^\#define /-D'/" -e "s/ /'=3D'/" -e "s/$$/'/" -e 's/\$$=
/&&/g')
>  endif


Agree. This is the right fix because this $(shell ...) retrieves
the predefined macros of the compiler.
So, KBUILD_CPPFLAGS is correct.



> I will run this change plus that diff through my build matrix to see if
> any other issues pop up. If not, I will respond with some tags and
> perhaps this could be taken as a fix for 6.4 so that it could
> potentially be backported?
>
> Cheers,
> Nathan



--=20
Best Regards
Masahiro Yamada
