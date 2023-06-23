Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E9F73B02D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjFWFlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFWFlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:41:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0771A4;
        Thu, 22 Jun 2023 22:41:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6001B6198B;
        Fri, 23 Jun 2023 05:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8786C433CC;
        Fri, 23 Jun 2023 05:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687498871;
        bh=qPapvU2ug5XUbs86vSozf1HW7Fb3vlj9IaJ8Cc/jUhc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nc6tMgv5HOQX4XZ9WiULPUOvoFoQr1wOklN1Ab/DKOFOR1LR/VPo6fglicjtk6nQL
         7bVs+K3n1Om48IszfVTJzdmt95vDF3BJ5Al5CXjce8zVZdF6qix6H9GdjnK2VA102z
         J/86+fiwxg0uUj3IDhln0JWz+sIJbKakfNjmgc70IlepZwLrPZuIFgknJYptlfgwWb
         IXmHDWFKkSZOOeCbUhT+VEoL58A5djkE7LxWdfejRtdKZP36sg4kPw6IbH0hb8GnAQ
         Yvg3Q+LFIYX8Cy1J0DOJKdLSZWGkDivSNYSuCUw1Cc5Hf8XmASjR/4GA1eA0SbBzud
         Ug1f50gFCOaRQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1a9a42edfc9so187059fac.0;
        Thu, 22 Jun 2023 22:41:11 -0700 (PDT)
X-Gm-Message-State: AC+VfDxIevFXfO3gn/NErQ5d1srMadBFygS/4AD71hCwmCwDv3+Xf9Ac
        3zhPysUZgi7QK9vJRDiA5rIUhm6HcjrzDzFsq3g=
X-Google-Smtp-Source: ACHHUZ7cMLVT4f0AnUJoGvZXjHjFR76NxU3gpI2Rf4Fsv/8GBKrljZEFaW5o+/iwXTDhjTp30q16bid6On7xomQ1uyE=
X-Received: by 2002:a05:6871:288:b0:1a6:c3d3:969c with SMTP id
 i8-20020a056871028800b001a6c3d3969cmr19108557oae.45.1687498870905; Thu, 22
 Jun 2023 22:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230409145358.2538266-1-masahiroy@kernel.org>
 <20230531213319.GA2201875@dev-arch.thelio-3990X> <20230602152519.GA3007575@dev-arch.thelio-3990X>
 <CAK7LNARjB8vgk-hsZmGqB0mwz=OBgyDtqBKJ2cueE+yQ02CQiA@mail.gmail.com> <CAFP8O3J1aiAgKzZ82erJseb_wwU7F2=+T0xCZ0BbcFKJOAQfUg@mail.gmail.com>
In-Reply-To: <CAFP8O3J1aiAgKzZ82erJseb_wwU7F2=+T0xCZ0BbcFKJOAQfUg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 23 Jun 2023 14:40:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT+zj7fpE_-QewdCVFzz3smZq7V6XART+yOqKcAZCiTFA@mail.gmail.com>
Message-ID: <CAK7LNAT+zj7fpE_-QewdCVFzz3smZq7V6XART+yOqKcAZCiTFA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add $(CLANG_CFLAGS) to KBUILD_CPPFLAGS
To:     Fangrui Song <maskray@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rini <trini@konsulko.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 2:07=E2=80=AFAM Fangrui Song <maskray@google.com> w=
rote:
>
> On Sat, Jun 3, 2023 at 9:33=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
> >
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
> Drive-by reply from
> https://github.com/ClangBuiltLinux/continuous-integration2/pull/585
>
> Hi Masahiro, one nit:) If the patch still has time to adjust the
> commit message, perhaps consider replacing
>
> -target aarch64-linux-gnu with --target=3Daarch64-linux-gnu
>
> as the former is a deprecated driver option since Clang 3.x (long time ag=
o).
>
> > Assuming you use an x86 build machine, compare the following:
>
> You may drop "Assuming you use an x86 build machine" and add
> --target=3Dx86_64-linux-gnu to the `clang -dM -E -x c /dev/null` command
> :)

Thanks for the suggestion, but I do not want to change the commit ID
unless there is something terribly wrong.

Nathan recorded the commit ID in the CBL bug tracker.



--=20
Best Regards
Masahiro Yamada
