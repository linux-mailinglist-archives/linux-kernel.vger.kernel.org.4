Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A29073CF25
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 10:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjFYIDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 04:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjFYIC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 04:02:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91174E52;
        Sun, 25 Jun 2023 01:02:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10A7F60B62;
        Sun, 25 Jun 2023 08:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB7EC433C8;
        Sun, 25 Jun 2023 08:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687680170;
        bh=Yn7ur0hSLgRRcuejzwOvXvGPThkAsc4tD6ZTogw5Dbk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VITkWm9+HFxZZGaLbiI0TbgwUuWrOm7vVonDHwKcmhh0Ez/L05hHn3Ei32oV0/Ipz
         A4lxW7STEyOgjMah1JrloMlux884tQaXIQePy0eBaTZ7Rp0iwnlikQOuy42B2YtPDS
         oeVh4DN/bldtBPjD1RCW6qRbt4IMQx882cizX5lghRJJ+z4DhP/CF7PO/FEip3a2gq
         3m6b6FUc4A6u8X5ystwZXJw+M5p2p9SRH/IH2tIwhMkfI5xd7Ml9bwursZnUt2Gh3P
         q8E3DG2lnOax4AUY+fQro5eUGWrxD6fL8gktT/OB0s5p11lD1RzUp2xH6Cxj8iRnb4
         fW8L6r6CJJ7fA==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-55e04a83465so1655056eaf.3;
        Sun, 25 Jun 2023 01:02:50 -0700 (PDT)
X-Gm-Message-State: AC+VfDzUtIILXlSK+XG8A3q2V29KDcFXUOH0O1LeHBe5pxDnfURm+/OW
        a2d95LyQxbafifo+AD74nz1PTY2el7h1OzFqHkc=
X-Google-Smtp-Source: ACHHUZ66qeBOQbYT6xqBwBk53SBAigcOVZD1snybv27WYy25h2Tl6o1VD3Lyob4H2XEggxc8JPEB+i3Z576D2dJAxHI=
X-Received: by 2002:a4a:dc19:0:b0:560:c7dd:e19e with SMTP id
 p25-20020a4adc19000000b00560c7dde19emr9398546oov.3.1687680169577; Sun, 25 Jun
 2023 01:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230119082250.151485-1-masahiroy@kernel.org> <CACPK8XeGsWN+2L57=dfQWOTSo8df7_qrxhwvV4Ho0rkhV=0vSw@mail.gmail.com>
 <CAK7LNAQWtDHOs=K+qznt5U1WiDv86tChkj4zOer4wtVRB974OA@mail.gmail.com>
In-Reply-To: <CAK7LNAQWtDHOs=K+qznt5U1WiDv86tChkj4zOer4wtVRB974OA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 25 Jun 2023 17:02:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS=UCo_o-B0mgsR+SDb0sYwvQo90uag5sJ1UmB+8NqLjQ@mail.gmail.com>
Message-ID: <CAK7LNAS=UCo_o-B0mgsR+SDb0sYwvQo90uag5sJ1UmB+8NqLjQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: remove checks for binutils older than 2.25
To:     Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kbuild@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 9:37=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Jan 19, 2023 at 9:12 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Thu, 19 Jan 2023 at 08:24, Masahiro Yamada <masahiroy@kernel.org> wr=
ote:
> > >
> > > Commit e4412739472b ("Documentation: raise minimum supported version =
of
> > > binutils to 2.25") allows us to remove the checks for old binutils.
> > >
> > > There is no more user for ld-ifversion. Remove it as well.
> >
> > ppc kernels fail to link with 2.27 under some configurations:
> >
> >  https://github.com/linuxppc/issues/issues/388
> >
> > We may want to use ld-ifversion to exclude that version.
>
>


Ping?




>
> For LLD, CONFIG option is directly checked.
>
>
> masahiro@zoe:~/ref/linux(master)$ git grep  CONFIG_LLD_VERSION
> Makefile:ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
> arch/riscv/Makefile:ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 150000),=
y)
> arch/x86/Makefile:ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
> scripts/Kbuild.include:# Usage: $(call test-lt, $(CONFIG_LLD_VERSION), 15=
0000)
>
>
>
>
>
>
>
>
>
>
>
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  arch/powerpc/Makefile     | 22 +---------------------
> > >  arch/powerpc/lib/Makefile |  2 +-
> > >  scripts/Makefile.compiler |  4 ----
> > >  3 files changed, 2 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > > index dc4cbf0a5ca9..3d265b16c0ae 100644
> > > --- a/arch/powerpc/Makefile
> > > +++ b/arch/powerpc/Makefile
> > > @@ -42,18 +42,13 @@ machine-$(CONFIG_PPC64) +=3D 64
> > >  machine-$(CONFIG_CPU_LITTLE_ENDIAN) +=3D le
> > >  UTS_MACHINE :=3D $(subst $(space),,$(machine-y))
> > >
> > > -# XXX This needs to be before we override LD below
> > > -ifdef CONFIG_PPC32
> > > -KBUILD_LDFLAGS_MODULE +=3D arch/powerpc/lib/crtsavres.o
> > > -else
> > > -ifeq ($(call ld-ifversion, -ge, 22500, y),y)
> > > +ifeq ($(CONFIG_PPC64)$(CONFIG_LD_IS_BFD),yy)
> > >  # Have the linker provide sfpr if possible.
> > >  # There is a corresponding test in arch/powerpc/lib/Makefile
> > >  KBUILD_LDFLAGS_MODULE +=3D --save-restore-funcs
> > >  else
> > >  KBUILD_LDFLAGS_MODULE +=3D arch/powerpc/lib/crtsavres.o
> > >  endif
> > > -endif
> > >
> > >  ifdef CONFIG_CPU_LITTLE_ENDIAN
> > >  KBUILD_CFLAGS  +=3D -mlittle-endian
> > > @@ -389,8 +384,6 @@ vdso_prepare: prepare0
> > >                 $(build)=3Darch/powerpc/kernel/vdso include/generated=
/vdso64-offsets.h)
> > >  endif
> > >
> > > -archprepare: checkbin
> > > -
> > >  archheaders:
> > >         $(Q)$(MAKE) $(build)=3Darch/powerpc/kernel/syscalls all
> > >
> > > @@ -405,16 +398,3 @@ else
> > >         $(eval KBUILD_CFLAGS +=3D -mstack-protector-guard-offset=3D$(=
shell awk '{if ($$2 =3D=3D "TASK_CANARY") print $$3;}' include/generated/as=
m-offsets.h))
> > >  endif
> > >  endif
> > > -
> > > -PHONY +=3D checkbin
> > > -# Check toolchain versions:
> > > -# - gcc-4.6 is the minimum kernel-wide version so nothing required.
> > > -checkbin:
> > > -       @if test "x${CONFIG_LD_IS_LLD}" !=3D "xy" -a \
> > > -               "x$(call ld-ifversion, -le, 22400, y)" =3D "xy" ; the=
n \
> > > -               echo -n '*** binutils 2.24 miscompiles weak symbols '=
 ; \
> > > -               echo 'in some circumstances.' ; \
> > > -               echo    '*** binutils 2.23 do not define the TOC symb=
ol ' ; \
> > > -               echo -n '*** Please use a different binutils version.=
' ; \
> > > -               false ; \
> > > -       fi
> > > diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> > > index 4de71cbf6e8e..c53618c34b70 100644
> > > --- a/arch/powerpc/lib/Makefile
> > > +++ b/arch/powerpc/lib/Makefile
> > > @@ -42,7 +42,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION)        +=3D =
error-inject.o
> > >  # 64-bit linker creates .sfpr on demand for final link (vmlinux),
> > >  # so it is only needed for modules, and only for older linkers which
> > >  # do not support --save-restore-funcs
> > > -ifeq ($(call ld-ifversion, -lt, 22500, y),y)
> > > +ifndef CONFIG_LD_IS_BFD
> > >  extra-$(CONFIG_PPC64)  +=3D crtsavres.o
> > >  endif
> > >
> > > diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> > > index 3d8adfd34af1..ad07a4efc253 100644
> > > --- a/scripts/Makefile.compiler
> > > +++ b/scripts/Makefile.compiler
> > > @@ -72,7 +72,3 @@ clang-min-version =3D $(call test-ge, $(CONFIG_CLAN=
G_VERSION), $1)
> > >  # ld-option
> > >  # Usage: KBUILD_LDFLAGS +=3D $(call ld-option, -X, -Y)
> > >  ld-option =3D $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$=
(2),$(3))
> > > -
> > > -# ld-ifversion
> > > -# Usage:  $(call ld-ifversion, -ge, 22252, y)
> > > -ld-ifversion =3D $(shell [ $(CONFIG_LD_VERSION)0 $(1) $(2)0 ] && ech=
o $(3) || echo $(4))
> > > --
> > > 2.34.1
> > >
>
>
>
> --
> Best Regards
> Masahiro Yamada



--=20
Best Regards
Masahiro Yamada
