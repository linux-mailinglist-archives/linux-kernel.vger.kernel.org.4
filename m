Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5944C72113E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 18:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjFCQdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 12:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFCQdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 12:33:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D670D8;
        Sat,  3 Jun 2023 09:32:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06E6160A5C;
        Sat,  3 Jun 2023 16:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C00C4339B;
        Sat,  3 Jun 2023 16:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685809978;
        bh=lzSQzFxj4VGogLWnYC/NLk/1q4dN8KT5Vbju2mrt8xU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=saXSm5U+tqlIi9dS1AT89Fl9WLXQWQEE3FAyQ16Cshg2licdOkqIPvn/4d0A2e9iO
         SjqcCuCKhdc1YoTlqyyjF+QOMso6I5CAiovZ8rrdkgkdQerlIaX4wNNSUhQjevXgZ1
         eEe5Dzit7Uo9reJ7Apch2+4DzModSusDGdDqtWzEly9U5nmDeoe+LDFDYmFjxNPz4d
         FW8gZwQcLRMuiDIpTkypIjYxSwANTUA0QeYLof7k3LnqX1gsJouRbNk/uTs9hsFZRX
         krL73DKJxymgm02iRTLeUN0PPUCv/Zn735DYwWsdBKOsPDSb7P5OSwF7sUwL8WuoVb
         M4ESGOQ66/sqQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-555536b85a0so1644455eaf.2;
        Sat, 03 Jun 2023 09:32:58 -0700 (PDT)
X-Gm-Message-State: AC+VfDw/WvwZWN9jEyIoBS4JrlcFb50Ldv9hHxC8P749ZzsaElubg5RF
        b79nbWFEiVcTm0lvc6gVgIfY4JKyFmrKNYxX+q0=
X-Google-Smtp-Source: ACHHUZ7WRBNkYowA0BQL72/N3gA0JGFZGoM1RblEidD4LI73bpyH2rKQa4d7822bNeuqws/XwXKtqPFsRR/RT7wYu8U=
X-Received: by 2002:a4a:374c:0:b0:547:5593:d6 with SMTP id r73-20020a4a374c000000b00547559300d6mr7501367oor.5.1685809977529;
 Sat, 03 Jun 2023 09:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230409145358.2538266-1-masahiroy@kernel.org>
 <20230531213319.GA2201875@dev-arch.thelio-3990X> <20230602152519.GA3007575@dev-arch.thelio-3990X>
In-Reply-To: <20230602152519.GA3007575@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 4 Jun 2023 01:32:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNARjB8vgk-hsZmGqB0mwz=OBgyDtqBKJ2cueE+yQ02CQiA@mail.gmail.com>
Message-ID: <CAK7LNARjB8vgk-hsZmGqB0mwz=OBgyDtqBKJ2cueE+yQ02CQiA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add $(CLANG_CFLAGS) to KBUILD_CPPFLAGS
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rini <trini@konsulko.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 3, 2023 at 12:25=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Wed, May 31, 2023 at 02:33:23PM -0700, Nathan Chancellor wrote:
> > Hi Masahiro,
> >
> > On Sun, Apr 09, 2023 at 11:53:57PM +0900, Masahiro Yamada wrote:
> > > When preprocessing arch/*/kernel/vmlinux.lds.S, the target triple is
> > > not passed to $(CPP) because we add it only to KBUILD_{C,A}FLAGS.
> > >
> > > As a result, the linker script is preprocessed with predefined macros
> > > for the build host instead of the target.
> > >
> > > Assuming you use an x86 build machine, compare the following:
> > >
> > >  $ clang -dM -E -x c /dev/null
> > >  $ clang -dM -E -x c /dev/null -target aarch64-linux-gnu
> > >
> > > There is no actual problem presumably because our linker scripts do n=
ot
> > > rely on such predefined macros, but it is better to define correct on=
es.
> > >
> > > Move $(CFLAGS_CFLAGS) to KBUILD_CPPFLAGS, so that all *.c, *.S, *.lds=
.S
> > > will be processed with the proper target triple.
> > >
> > > Reported-by: Tom Rini <trini@konsulko.com>
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  scripts/Makefile.clang | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> > > index 70b354fa1cb4..93ca059cc3b8 100644
> > > --- a/scripts/Makefile.clang
> > > +++ b/scripts/Makefile.clang
> > > @@ -38,6 +38,5 @@ CLANG_FLAGS       +=3D -Werror=3Dunknown-warning-op=
tion
> > >  CLANG_FLAGS        +=3D -Werror=3Dignored-optimization-argument
> > >  CLANG_FLAGS        +=3D -Werror=3Doption-ignored
> > >  CLANG_FLAGS        +=3D -Werror=3Dunused-command-line-argument
> > > -KBUILD_CFLAGS      +=3D $(CLANG_FLAGS)
> > > -KBUILD_AFLAGS      +=3D $(CLANG_FLAGS)
> > > +KBUILD_CPPFLAGS    +=3D $(CLANG_FLAGS)
> > >  export CLANG_FLAGS
> > > --
> > > 2.37.2
> > >
> >
> > I am doubling back to this change, as the lack of '--target' in
> > KBUILD_CPPFLAGS is now an active bug with clang-17 due to a new change
> > that rejects '-mbig-endian' and '-mlittle-endian' when not supported by
> > the target, which breaks the arm64 vDSO build when preprocessing its
> > linker script:
> >
> >   # Turn on CONFIG_CPU_BIG_ENDIAN in menuconfig
> >   $ make -skj"$(nproc)" ARCH=3Darm64 LLVM=3D1 O=3Dbuild mrproper virtco=
nfig menuconfig arch/arm64/kernel/vdso/
> >   ...
> >   clang: error: unsupported option '-mbig-endian' for target 'x86_64-pc=
-linux-gnu'
> >   make[3]: *** [.../scripts/Makefile.build:387: arch/arm64/kernel/vdso/=
vdso.lds] Error 1
> >   ...
> >
> >   https://github.com/llvm/llvm-project/commit/d81ce04587c006b6731198956=
c522c93d0df1050
> >   https://github.com/ClangBuiltLinux/linux/issues/1859
> >
> > This change resolves that issue. I was able to figure out why those new
> > warnings appeared for ARCH=3Dmips, it is the shell invocation for
> > CHECKFLAGS. The following diff resolves it for me:
> >
> > diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> > index a7a4ee66a9d3..ef7b05ae92ce 100644
> > --- a/arch/mips/Makefile
> > +++ b/arch/mips/Makefile
> > @@ -346,7 +346,7 @@ KBUILD_CFLAGS +=3D -fno-asynchronous-unwind-tables
> >  KBUILD_LDFLAGS               +=3D -m $(ld-emul)
> >
> >  ifdef CONFIG_MIPS
> > -CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null |=
 \
> > +CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM =
-E -x c /dev/null | \
> >       grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
> >       sed -e "s/^\#define /-D'/" -e "s/ /'=3D'/" -e "s/$$/'/" -e 's/\$$=
/&&/g')
> >  endif
> >
> > I will run this change plus that diff through my build matrix to see if
> > any other issues pop up. If not, I will respond with some tags and
> > perhaps this could be taken as a fix for 6.4 so that it could
> > potentially be backported?
>
> I found two more issues lurking in PowerPC. I have attached suggested
> patches for all the issues I have uncovered to this email, please feel
> free to use them or do something different if you feel there is a better
> fix. With those issues resolved in one way or another, consider the
> original change:
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
>
> If it would work better for you, I am more than happy to take over this
> series as well.
>
> Cheers,
> Nathan

Thanks. All the three patches look good to me.

I will apply them, then mine on top.




A nit:

The first patch for mips will introduce the warning
as $(KBUILD_CPPFLAGS) does not contain $(CLANG_FLAGS)
at this point.
Then, it will be fixed again when my patch is applied.

The two must be squashed together to avoid the regression,
but I think it is OK as-is.




The second patch for powerpc reminded me of
converting $(CC) to $(LD) for linking vDSO.
I do not remember why powerpc vDSO still uses $(CC).




--
Best Regards
Masahiro Yamada
