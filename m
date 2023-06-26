Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31B573D629
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 05:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjFZDMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 23:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjFZDMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 23:12:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A0F1AD;
        Sun, 25 Jun 2023 20:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6714B60C76;
        Mon, 26 Jun 2023 03:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C842AC433C0;
        Mon, 26 Jun 2023 03:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687749124;
        bh=wWBs10Ysex4s8hvKQS9fyjF9aZurVb4Ni2hIgn1/qBE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U1rakJdKEGgjf5w/H2VXLdl5yU94lilMmayksH/AcUiTeDioPAKv1HLxjC6TL90Je
         uizaD/i81fNrpMfYk53GEwj2789GCQIoTFFYOxRsrW5OZHSHBJUSm7LSiLPs8sYLAZ
         Zekm9a6s6d4e65F5rDP9WLKyW7Lf89DmuGgi0PJCD+jQ0eenNoK3N4QdhrLkIY3k6y
         27gXMPLyXxHxvjxq85p3DJTcGqkyzERWYx16+Tr2nWshOnPfLlEpIKmjwOCUl86YOm
         NIFhqNjjg9ob/tJ3Kakqp3rd+WPtA1ITJoE2dfA4KDiTmU2c11I2E118Hpd6AVbyJR
         sZPeTNWRb3Fqg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1aa34b210c9so2853532fac.0;
        Sun, 25 Jun 2023 20:12:04 -0700 (PDT)
X-Gm-Message-State: AC+VfDwXxQ+ZmXchOZrLHGLWimFBSnoLHx3NtIR5ok/GT0sTVc1m7mCh
        kcb95jJNrlcNE0poaYrgfSbgCQYhnohmZzL0JAI=
X-Google-Smtp-Source: ACHHUZ5akDJt4/QMGTbhWDOzWJ27b8+VU6Y3Vav9G/w/Hntsv0w/QGj2t244uVIpTVcxYUDh3HccG/1910xyYoAaFJQ=
X-Received: by 2002:a05:6870:7342:b0:1b0:2bff:b9b5 with SMTP id
 r2-20020a056870734200b001b02bffb9b5mr3183440oal.47.1687749124047; Sun, 25 Jun
 2023 20:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230119082250.151485-1-masahiroy@kernel.org> <CACPK8XeGsWN+2L57=dfQWOTSo8df7_qrxhwvV4Ho0rkhV=0vSw@mail.gmail.com>
 <CAK7LNAQWtDHOs=K+qznt5U1WiDv86tChkj4zOer4wtVRB974OA@mail.gmail.com>
 <CAK7LNAS=UCo_o-B0mgsR+SDb0sYwvQo90uag5sJ1UmB+8NqLjQ@mail.gmail.com> <CTM7K580U3T2.261RJKV58M653@wheely>
In-Reply-To: <CTM7K580U3T2.261RJKV58M653@wheely>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 26 Jun 2023 12:11:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNARx4exTpkCeR47T+XdF5-a7nLZ19p0R4tvnqyOT5y92XQ@mail.gmail.com>
Message-ID: <CAK7LNARx4exTpkCeR47T+XdF5-a7nLZ19p0R4tvnqyOT5y92XQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: remove checks for binutils older than 2.25
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org,
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

On Mon, Jun 26, 2023 at 10:58=E2=80=AFAM Nicholas Piggin <npiggin@gmail.com=
> wrote:
>
> On Sun Jun 25, 2023 at 6:02 PM AEST, Masahiro Yamada wrote:
> > On Thu, Jan 19, 2023 at 9:37=E2=80=AFPM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > On Thu, Jan 19, 2023 at 9:12 PM Joel Stanley <joel@jms.id.au> wrote:
> > > >
> > > > On Thu, 19 Jan 2023 at 08:24, Masahiro Yamada <masahiroy@kernel.org=
> wrote:
> > > > >
> > > > > Commit e4412739472b ("Documentation: raise minimum supported vers=
ion of
> > > > > binutils to 2.25") allows us to remove the checks for old binutil=
s.
> > > > >
> > > > > There is no more user for ld-ifversion. Remove it as well.
> > > >
> > > > ppc kernels fail to link with 2.27 under some configurations:
> > > >
> > > >  https://github.com/linuxppc/issues/issues/388
> > > >
> > > > We may want to use ld-ifversion to exclude that version.
> > >
> > >
> >
> >
> > Ping?
> >
> >
> >
> >
> > >
> > > For LLD, CONFIG option is directly checked.
>
> Yeah, doesn't seem too difficult to add new linker version tests if neede=
d.
>
> > >
> > >
> > > masahiro@zoe:~/ref/linux(master)$ git grep  CONFIG_LLD_VERSION
> > > Makefile:ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
> > > arch/riscv/Makefile:ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 1500=
00),y)
> > > arch/x86/Makefile:ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000=
),y)
> > > scripts/Kbuild.include:# Usage: $(call test-lt, $(CONFIG_LLD_VERSION)=
, 150000)
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > > > >
> > > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > > ---
> > > > >
> > > > >  arch/powerpc/Makefile     | 22 +---------------------
> > > > >  arch/powerpc/lib/Makefile |  2 +-
> > > > >  scripts/Makefile.compiler |  4 ----
> > > > >  3 files changed, 2 insertions(+), 26 deletions(-)
> > > > >
> > > > > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > > > > index dc4cbf0a5ca9..3d265b16c0ae 100644
> > > > > --- a/arch/powerpc/Makefile
> > > > > +++ b/arch/powerpc/Makefile
> > > > > @@ -42,18 +42,13 @@ machine-$(CONFIG_PPC64) +=3D 64
> > > > >  machine-$(CONFIG_CPU_LITTLE_ENDIAN) +=3D le
> > > > >  UTS_MACHINE :=3D $(subst $(space),,$(machine-y))
> > > > >
> > > > > -# XXX This needs to be before we override LD below
> > > > > -ifdef CONFIG_PPC32
> > > > > -KBUILD_LDFLAGS_MODULE +=3D arch/powerpc/lib/crtsavres.o
> > > > > -else
> > > > > -ifeq ($(call ld-ifversion, -ge, 22500, y),y)
> > > > > +ifeq ($(CONFIG_PPC64)$(CONFIG_LD_IS_BFD),yy)
> > > > >  # Have the linker provide sfpr if possible.
> > > > >  # There is a corresponding test in arch/powerpc/lib/Makefile
> > > > >  KBUILD_LDFLAGS_MODULE +=3D --save-restore-funcs
> > > > >  else
> > > > >  KBUILD_LDFLAGS_MODULE +=3D arch/powerpc/lib/crtsavres.o
> > > > >  endif
> > > > > -endif
> > > > >
> > > > >  ifdef CONFIG_CPU_LITTLE_ENDIAN
> > > > >  KBUILD_CFLAGS  +=3D -mlittle-endian
> > > > > @@ -389,8 +384,6 @@ vdso_prepare: prepare0
> > > > >                 $(build)=3Darch/powerpc/kernel/vdso include/gener=
ated/vdso64-offsets.h)
> > > > >  endif
> > > > >
> > > > > -archprepare: checkbin
> > > > > -
> > > > >  archheaders:
> > > > >         $(Q)$(MAKE) $(build)=3Darch/powerpc/kernel/syscalls all
> > > > >
> > > > > @@ -405,16 +398,3 @@ else
> > > > >         $(eval KBUILD_CFLAGS +=3D -mstack-protector-guard-offset=
=3D$(shell awk '{if ($$2 =3D=3D "TASK_CANARY") print $$3;}' include/generat=
ed/asm-offsets.h))
> > > > >  endif
> > > > >  endif
> > > > > -
> > > > > -PHONY +=3D checkbin
> > > > > -# Check toolchain versions:
> > > > > -# - gcc-4.6 is the minimum kernel-wide version so nothing requir=
ed.
> > > > > -checkbin:
> > > > > -       @if test "x${CONFIG_LD_IS_LLD}" !=3D "xy" -a \
> > > > > -               "x$(call ld-ifversion, -le, 22400, y)" =3D "xy" ;=
 then \
> > > > > -               echo -n '*** binutils 2.24 miscompiles weak symbo=
ls ' ; \
> > > > > -               echo 'in some circumstances.' ; \
> > > > > -               echo    '*** binutils 2.23 do not define the TOC =
symbol ' ; \
> > > > > -               echo -n '*** Please use a different binutils vers=
ion.' ; \
> > > > > -               false ; \
> > > > > -       fi
> > > > > diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefil=
e
> > > > > index 4de71cbf6e8e..c53618c34b70 100644
> > > > > --- a/arch/powerpc/lib/Makefile
> > > > > +++ b/arch/powerpc/lib/Makefile
> > > > > @@ -42,7 +42,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION)        +=
=3D error-inject.o
> > > > >  # 64-bit linker creates .sfpr on demand for final link (vmlinux)=
,
> > > > >  # so it is only needed for modules, and only for older linkers w=
hich
> > > > >  # do not support --save-restore-funcs
> > > > > -ifeq ($(call ld-ifversion, -lt, 22500, y),y)
> > > > > +ifndef CONFIG_LD_IS_BFD
> > > > >  extra-$(CONFIG_PPC64)  +=3D crtsavres.o
> > > > >  endif
>
> This test got inverted for LLD now AFAIKS?


In my understanding,
For a BFD linker, use --save-restore-funcs.
Otherwise (i.e. CONFIG_LD_IS_BFD is unset), link crtsavres.o to modules.

I hope I did not change the logic.



>
> Does LLVM support --save-restore-funcs and supply .sfpr already I
> wonder? We could remove this stuff entirely.

I don't know.

If LLVM 11.0.0  (the minimum supported LLVM version) supports
--save-restore-funcs, you can remove this check entirely.
Even so, it should be done in a follow-up patch.


This patch is just dropping dead code for BFD linker < 2.25,
which is now unsupported. Nothing else has changed (I believe).





--=20
Best Regards
Masahiro Yamada
