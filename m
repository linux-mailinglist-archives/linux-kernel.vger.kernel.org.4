Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1839172347E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjFFB3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFFB3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:29:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BAC8F;
        Mon,  5 Jun 2023 18:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF63962BD8;
        Tue,  6 Jun 2023 01:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7BFC4339B;
        Tue,  6 Jun 2023 01:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686014984;
        bh=C0DDZu22AqHPphiQCzwpTPnx6kZVphyanDDks3Ob+wI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pmdxcfBoDLu2PNR7rr73koQ18T7ToCFDWXwT99Yjo/AUDPfcGOd6sWJZr9BMLHG/y
         lm2MPuB9wH/Jsd5rdDOeADB1ww/2I+lf7eiXyDmwUeCFyyMXSbo9iR3W6t66pnSdeb
         NRkdOxCdhu07JI9pWWMXOUyhlWVAcGPnJj+KcNKWf/XeFL/sYr9iUDZpOi7Eyg/o1/
         18CcLcuCkRcHV0xNYftuL1vRnACT9T5ClmQiY/L+WM63xdkw4iWz5sNAgVjlqTqctg
         jDEg3342wLGEQgLbENAew3J0Baiawb3tpuXAUKeZ2R3Ve8LsEysf1ZdrFaRgfT9qIh
         m/miKnXg+0RAw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-19f6f8c8283so5858438fac.3;
        Mon, 05 Jun 2023 18:29:44 -0700 (PDT)
X-Gm-Message-State: AC+VfDzv13RWnkra1Sp7LsYG238oLfSxVm+u5//UrjeveGpNDhUNpYV0
        KQaTgRJOW8/23P+0WKNQ8fqGaRV6n/xPZA4cVe0=
X-Google-Smtp-Source: ACHHUZ60sg0dzOOGNZIIJ+bH/VEhUE4AnmEm3IFgco5rKbUOFpspxPteTOfCSgkr+3F8uFTspjUyQvMzstCuBJBtGbs=
X-Received: by 2002:a05:6870:c79c:b0:19f:9f91:fa4a with SMTP id
 dy28-20020a056870c79c00b0019f9f91fa4amr669334oab.55.1686014983373; Mon, 05
 Jun 2023 18:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230409145358.2538266-1-masahiroy@kernel.org>
 <20230531213319.GA2201875@dev-arch.thelio-3990X> <20230602152519.GA3007575@dev-arch.thelio-3990X>
 <CAK7LNARjB8vgk-hsZmGqB0mwz=OBgyDtqBKJ2cueE+yQ02CQiA@mail.gmail.com> <20230605152149.GA2476659@dev-arch.thelio-3990X>
In-Reply-To: <20230605152149.GA2476659@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 6 Jun 2023 10:29:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR2KwypUvsn+WTJRLAkmjvNQA3=aD9f4tfHYCR7TonbjQ@mail.gmail.com>
Message-ID: <CAK7LNAR2KwypUvsn+WTJRLAkmjvNQA3=aD9f4tfHYCR7TonbjQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add $(CLANG_CFLAGS) to KBUILD_CPPFLAGS
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rini <trini@konsulko.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
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

On Tue, Jun 6, 2023 at 12:21=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Sun, Jun 04, 2023 at 01:32:21AM +0900, Masahiro Yamada wrote:
> > On Sat, Jun 3, 2023 at 12:25=E2=80=AFAM Nathan Chancellor <nathan@kerne=
l.org> wrote:
> > >
> > > On Wed, May 31, 2023 at 02:33:23PM -0700, Nathan Chancellor wrote:
> > > > Hi Masahiro,
> > > >
> > > > On Sun, Apr 09, 2023 at 11:53:57PM +0900, Masahiro Yamada wrote:
> > > > > When preprocessing arch/*/kernel/vmlinux.lds.S, the target triple=
 is
> > > > > not passed to $(CPP) because we add it only to KBUILD_{C,A}FLAGS.
> > > > >
> > > > > As a result, the linker script is preprocessed with predefined ma=
cros
> > > > > for the build host instead of the target.
> > > > >
> > > > > Assuming you use an x86 build machine, compare the following:
> > > > >
> > > > >  $ clang -dM -E -x c /dev/null
> > > > >  $ clang -dM -E -x c /dev/null -target aarch64-linux-gnu
> > > > >
> > > > > There is no actual problem presumably because our linker scripts =
do not
> > > > > rely on such predefined macros, but it is better to define correc=
t ones.
> > > > >
> > > > > Move $(CFLAGS_CFLAGS) to KBUILD_CPPFLAGS, so that all *.c, *.S, *=
.lds.S
> > > > > will be processed with the proper target triple.
> > > > >
> > > > > Reported-by: Tom Rini <trini@konsulko.com>
> > > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > > ---
> > > > >
> > > > >  scripts/Makefile.clang | 3 +--
> > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> > > > > index 70b354fa1cb4..93ca059cc3b8 100644
> > > > > --- a/scripts/Makefile.clang
> > > > > +++ b/scripts/Makefile.clang
> > > > > @@ -38,6 +38,5 @@ CLANG_FLAGS       +=3D -Werror=3Dunknown-warnin=
g-option
> > > > >  CLANG_FLAGS        +=3D -Werror=3Dignored-optimization-argument
> > > > >  CLANG_FLAGS        +=3D -Werror=3Doption-ignored
> > > > >  CLANG_FLAGS        +=3D -Werror=3Dunused-command-line-argument
> > > > > -KBUILD_CFLAGS      +=3D $(CLANG_FLAGS)
> > > > > -KBUILD_AFLAGS      +=3D $(CLANG_FLAGS)
> > > > > +KBUILD_CPPFLAGS    +=3D $(CLANG_FLAGS)
> > > > >  export CLANG_FLAGS
> > > > > --
> > > > > 2.37.2
> > > > >
> > > >
> > > > I am doubling back to this change, as the lack of '--target' in
> > > > KBUILD_CPPFLAGS is now an active bug with clang-17 due to a new cha=
nge
> > > > that rejects '-mbig-endian' and '-mlittle-endian' when not supporte=
d by
> > > > the target, which breaks the arm64 vDSO build when preprocessing it=
s
> > > > linker script:
> > > >
> > > >   # Turn on CONFIG_CPU_BIG_ENDIAN in menuconfig
> > > >   $ make -skj"$(nproc)" ARCH=3Darm64 LLVM=3D1 O=3Dbuild mrproper vi=
rtconfig menuconfig arch/arm64/kernel/vdso/
> > > >   ...
> > > >   clang: error: unsupported option '-mbig-endian' for target 'x86_6=
4-pc-linux-gnu'
> > > >   make[3]: *** [.../scripts/Makefile.build:387: arch/arm64/kernel/v=
dso/vdso.lds] Error 1
> > > >   ...
> > > >
> > > >   https://github.com/llvm/llvm-project/commit/d81ce04587c006b673119=
8956c522c93d0df1050
> > > >   https://github.com/ClangBuiltLinux/linux/issues/1859
> > > >
> > > > This change resolves that issue. I was able to figure out why those=
 new
> > > > warnings appeared for ARCH=3Dmips, it is the shell invocation for
> > > > CHECKFLAGS. The following diff resolves it for me:
> > > >
> > > > diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> > > > index a7a4ee66a9d3..ef7b05ae92ce 100644
> > > > --- a/arch/mips/Makefile
> > > > +++ b/arch/mips/Makefile
> > > > @@ -346,7 +346,7 @@ KBUILD_CFLAGS +=3D -fno-asynchronous-unwind-tab=
les
> > > >  KBUILD_LDFLAGS               +=3D -m $(ld-emul)
> > > >
> > > >  ifdef CONFIG_MIPS
> > > > -CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/nu=
ll | \
> > > > +CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) =
-dM -E -x c /dev/null | \
> > > >       grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
> > > >       sed -e "s/^\#define /-D'/" -e "s/ /'=3D'/" -e "s/$$/'/" -e 's=
/\$$/&&/g')
> > > >  endif
> > > >
> > > > I will run this change plus that diff through my build matrix to se=
e if
> > > > any other issues pop up. If not, I will respond with some tags and
> > > > perhaps this could be taken as a fix for 6.4 so that it could
> > > > potentially be backported?
> > >
> > > I found two more issues lurking in PowerPC. I have attached suggested
> > > patches for all the issues I have uncovered to this email, please fee=
l
> > > free to use them or do something different if you feel there is a bet=
ter
> > > fix. With those issues resolved in one way or another, consider the
> > > original change:
> > >
> > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > >
> > > If it would work better for you, I am more than happy to take over th=
is
> > > series as well.
> > >
> > > Cheers,
> > > Nathan
> >
> > Thanks. All the three patches look good to me.
> >
> > I will apply them, then mine on top.
>
> Thanks, sounds like a good plan!
>
> > A nit:
> >
> > The first patch for mips will introduce the warning
> > as $(KBUILD_CPPFLAGS) does not contain $(CLANG_FLAGS)
> > at this point.
> > Then, it will be fixed again when my patch is applied.
> >
> > The two must be squashed together to avoid the regression,
> > but I think it is OK as-is.
>
> Hmmm, what warning would be introduced? KBUILD_CPPFLAGS is being added
> to the CHECKFLAGS invocation, rather than replacing KBUILD_CFLAGS, so
> '--target' should always be present (first via KBUILD_CFLAGS then via
> KBUILD_CPPFLAGS), right?



Sorry, I wrongly read your code.

You are right, you added $(KBUILD_CPPFLAGS)
in addition to $(KBUILD_CFLAGS).




Maybe, we can drop $(KBUILD_CFLAGS) (as a follow-up)
because this $(shell ) invocation is only interested
in preprocessor macros.


diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index ef7b05ae92ce..e563cca6b663 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -346,7 +346,7 @@ KBUILD_CFLAGS +=3D -fno-asynchronous-unwind-tables
 KBUILD_LDFLAGS         +=3D -m $(ld-emul)

 ifdef CONFIG_MIPS
-CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM
-E -x c /dev/null | \
+CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CPPFLAGS) -dM -E -x c /dev/null | \
        grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
        sed -e "s/^\#define /-D'/" -e "s/ /'=3D'/" -e "s/$$/'/" -e 's/\$$/&=
&/g')
 endif









>
> > The second patch for powerpc reminded me of
> > converting $(CC) to $(LD) for linking vDSO.
> > I do not remember why powerpc vDSO still uses $(CC).
>
> Nick tried to make the conversion some time ago but ran into issues with
> GNU ld crashing:
>
> https://lore.kernel.org/lkml/20200901222523.1941988-1-ndesaulniers@google=
.com/
> https://lore.kernel.org/lkml/b2066ccd-2b81-6032-08e3-41105b400f75@csgroup=
.eu/
>
> It might be easier to do this now that the PowerPC vDSO has been
> combined into one directory, but we have not had time to sit down and
> actually work on it.
>
> Cheers,
> Nathan



--=20
Best Regards
Masahiro Yamada
