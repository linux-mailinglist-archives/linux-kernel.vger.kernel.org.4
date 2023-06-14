Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567727307A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbjFNSwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbjFNSvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:51:51 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6161BFD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:51:49 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-62fe6580f17so6385946d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686768708; x=1689360708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMedmrS/p/Qxyg4JgB/GvkpfboCL/ncS9ZcNdcAtbBw=;
        b=UG4Ark6caifqCaop3OHayxIjvEQgvufpDyjCM5L8BzrCuHdw77DcbxB1Imy4IC8a6j
         qvmAc0+3PaU06ELv685Mw+4bpeFCSRW4PK0s3SwzOLqsQIqSTsTQDCDK55ajqHSTwWyI
         sC1grb6BoLFLS9oBhZjp7CwWT1Qj/GTT8FSkUDr1tpPWQ3jJGvoabANwtbxO28cdXcWN
         q5pi37Hc0VstR2/usj/5HwMeK/470ocHhii58WQZ94lV5Efc2lLbP3RlR0G0BH9Lj5F7
         0GZpUwwCktMWI22h/AtlmWfX/W74AcOIAfLEb3gulcqM0Mj+/DkKbCGs4YII5Svee66w
         mSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686768708; x=1689360708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMedmrS/p/Qxyg4JgB/GvkpfboCL/ncS9ZcNdcAtbBw=;
        b=OYf+NG5N2k3eAaVw7ourPETFWWMALxSV+olm33aYpwm91pHZGwhwVacdD6DI1rJKR0
         ebGezGYJq/VkRVQ8wKxCo3UCUmkMRIMH6wbAQPOJL3RNm5fGvDkbxEUtDlY2FRb1REDB
         2UdeRAU+qjmWz8bnAe0oxi+/5CsOplTVJRignN3LUwJ/KYmE/DPQqXA2y6+p8wVFwAsM
         FHWW8t2uzAEIYEpJDM/izcFZ/x4kC0RIRWhMLIYXINdwRayDN+7pp4Ql5wTkV+gwh+J7
         3Cr+Tnc2sGmjFX7ZgEJQgwdfidPN46iefnZ9BTnHy/J1+KKKnf5RFnyOMhsr4ejexpMM
         zcJg==
X-Gm-Message-State: AC+VfDzvBq1QQXhMKplzm2uZabZh8sJHPF3irA4O9Sv+qmF+q/XLdtyi
        /hJ2391zDBn8MJeqs0xalXdrT0Gm2qJ9j00p+hswPeTPlHZm8AM3BuhaqA==
X-Google-Smtp-Source: ACHHUZ7Wkp+teTCfoC7m4bCxnObJ2J7WNCIxCxch4HFFrKMCzde4tlGFIeZg71wvQEahtaEBZ2MTaSm/h278vtrJV8I=
X-Received: by 2002:a05:6214:224a:b0:61b:75e0:6a19 with SMTP id
 c10-20020a056214224a00b0061b75e06a19mr18911317qvc.14.1686768708272; Wed, 14
 Jun 2023 11:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <202305230231.3Wb7Q68G-lkp@intel.com> <edf2ec88-3586-bbb1-fbf1-9451393c12ec@csgroup.eu>
 <CAKwvOdm3vNxp9GZrxs6s4h73pHgHD=sJjaPziGzxcr+K7iGd-g@mail.gmail.com> <5fd58e1e-9e5f-4bd7-2153-aa0055a3f6c5@csgroup.eu>
In-Reply-To: <5fd58e1e-9e5f-4bd7-2153-aa0055a3f6c5@csgroup.eu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 14 Jun 2023 14:51:36 -0400
Message-ID: <CAKwvOdmrQKx=gTbcRuSRGBjd2q8Zf5YvpOuzoVJg4ovL96w4yg@mail.gmail.com>
Subject: Re: arch/powerpc/math-emu/fcmpu.c:13:2: warning: variable 'A_c' set
 but not used
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kernel test robot <lkp@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 2:26=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 14/06/2023 =C3=A0 18:04, Nick Desaulniers a =C3=A9crit :
> > On Wed, Jun 14, 2023 at 10:11=E2=80=AFAM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >>
> >> Hi,
> >>
> >> Le 22/05/2023 =C3=A0 21:00, kernel test robot a =C3=A9crit :
> >>> Hi Christophe,
> >>>
> >>> FYI, the error/warning still remains.
> >>>
> >>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git master
> >>> head:   44c026a73be8038f03dbdeef028b642880cf1511
> >>> commit: 7245fc5bb7a966852d5bd7779d1f5855530b461a powerpc/math-emu: Re=
move -w build flag and fix warnings
> >>> date:   9 months ago
> >>> config: powerpc-randconfig-r022-20230522 (https://download.01.org/0da=
y-ci/archive/20230523/202305230231.3Wb7Q68G-lkp@intel.com/config)
> >>> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project =
b0fb98227c90adf2536c9ad644a74d5e92961111)
> >>> reproduce (this is a W=3D1 build):
> >>>           wget https://raw.githubusercontent.com/intel/lkp-tests/mast=
er/sbin/make.cross -O ~/bin/make.cross
> >>>           chmod +x ~/bin/make.cross
> >>>           # install powerpc cross compiling tool for clang build
> >>>           # apt-get install binutils-powerpc-linux-gnu
> >>>           # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git/commit/?id=3D7245fc5bb7a966852d5bd7779d1f5855530b461a
> >>>           git remote add linus https://git.kernel.org/pub/scm/linux/k=
ernel/git/torvalds/linux.git
> >>>           git fetch --no-tags linus master
> >>>           git checkout 7245fc5bb7a966852d5bd7779d1f5855530b461a
> >>>           # save the config file
> >>>           mkdir build_dir && cp config build_dir/.config
> >>>           COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cr=
oss W=3D1 O=3Dbuild_dir ARCH=3Dpowerpc olddefconfig
> >>>           COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cr=
oss W=3D1 O=3Dbuild_dir ARCH=3Dpowerpc SHELL=3D/bin/bash arch/powerpc/math-=
emu/
> >>>
> >>> If you fix the issue, kindly add following tag where applicable
> >>> | Reported-by: kernel test robot <lkp@intel.com>
> >>> | Closes: https://lore.kernel.org/oe-kbuild-all/202305230231.3Wb7Q68G=
-lkp@intel.com/
> >>>
> >>> All warnings (new ones prefixed by >>):
> >>>
> >>>>> arch/powerpc/math-emu/fcmpu.c:13:2: warning: variable 'A_c' set but=
 not used [-Wunused-but-set-variable]
> >>
> >> This code is imported, and there is no plan to make any change to it.
> >> Can you desactivate that warning ?
> >
> > If the code is imported, and we don't plan to push fixes upstream,
> > does it make sense to just set -Wno-unusued-but-set-variable in
> > arch/powerpc/math-emu/Makefile?
>
> Yes, that's done already but clang ignores it apparently.
>
> >
> > Wait, what?!
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/powerpc/math-emu/Makefile#n20
> > arch/powerpc/math-emu/Makefile already has -Wunused-but-set-variable
> > in ccflags-remove-y. But if KBUILD_EXTRA_WARN is set for W=3D1 builds,
> > -Wunused-but-set-variable is added back, but only for math.o and
> > math_efp.o.  The warning above comes from building fcmpu.o.  So how
> > did  -Wunused-but-set-variable get set in the first place?
>
> Indeed.
>
> I looked once more and found out that:
>
>    clang -Wp,-MMD,arch/powerpc/math-emu/.fcmpu.o.d -nostdinc
> -I./arch/powerpc/include -I./arch/powerpc/include/generated  -I./include
> -I./arch/powerpc/include/uapi -I./arch/powerpc/include/generated/uapi
> -I./include/uapi -I./include/generated/uapi -include
> ./include/linux/compiler-version.h -include ./include/linux/kconfig.h
> -include ./include/linux/compiler_types.h -D__KERNEL__ -I ./arch/powerpc
> -DHAVE_AS_ATHIGH=3D1 -fmacro-prefix-map=3D./=3D -Wundef -DKBUILD_EXTRA_WA=
RN1
> -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs
> -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE
> -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int
> -Werror=3Dreturn-type -Wno-format-security -funsigned-char -std=3Dgnu11
> --target=3Dpowerpc64le-linux-gnu -fintegrated-as
> -Werror=3Dunknown-warning-option -Werror=3Dignored-optimization-argument
> -Werror=3Doption-ignored -Werror=3Dunused-command-line-argument -mbig-end=
ian
> -m32 -msoft-float -pipe -mcpu=3Dpowerpc -mno-prefixed -mno-pcrel
> -mno-altivec -mno-vsx -mno-mma -mno-spe -fno-asynchronous-unwind-tables
> -mbig-endian -fno-delete-null-pointer-checks -Wno-frame-address
> -Wno-address-of-packed-member -O2 -Wframe-larger-than=3D1024
> -fno-stack-protector -Wno-gnu -Wno-unused-but-set-variable
> -Wno-unused-const-variable -ftrivial-auto-var-init=3Dzero
> -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
> -pg -Wdeclaration-after-statement -Wvla -Wno-pointer-sign
> -Wcast-function-type -Wimplicit-fallthrough -fno-strict-overflow
> -fno-stack-check -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types
> -Wextra -Wunused -Wno-unused-parameter -Wmissing-format-attribute
> -Wold-style-definition -Wmissing-include-dirs -Wunused-const-variable
> -Wno-missing-field-initializers -Wno-sign-compare -Wno-type-limits
> -Wno-shift-negative-value -g -Werror
> -DKBUILD_MODFILE=3D'"arch/powerpc/math-emu/fcmpu"'
> -DKBUILD_BASENAME=3D'"fcmpu"' -DKBUILD_MODNAME=3D'"fcmpu"'
> -D__KBUILD_MODNAME=3Dkmod_fcmpu -c -o arch/powerpc/math-emu/fcmpu.o
> arch/powerpc/math-emu/fcmpu.c   ; ./tools/objtool/objtool --mcount
> --uaccess --sec-address   arch/powerpc/math-emu/fcmpu.o
>
>
> If you move -Wunused before -Wno-unused-but-set-variable, then you don't
> have the warning/error anymore. So what ? What the hell is clang
> behaving that way ?

It's re-enabling ALL of the members of the -Wunused group without
having checked to see if any more specific members were already
disabled.

>
> GCC documentation is explicit, see
> https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html :
>
>    The combined effect of positive and negative forms is that more
> specific options have priority over less specific ones, independently of
> their position in the command-line.

Ah, nice citation. I did not know that was the expected behavior of
this group diagnostics.  Indeed, there's a behavior difference here.
https://godbolt.org/z/13MxqrjcW

>
> Can clang be fixed ?

Filed:
https://github.com/llvm/llvm-project/issues/63315

>
> Christophe



--=20
Thanks,
~Nick Desaulniers
