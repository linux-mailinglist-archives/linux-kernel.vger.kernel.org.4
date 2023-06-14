Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D460730488
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjFNQFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjFNQEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:04:50 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8451BEC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:04:49 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-62de0e82a07so19128506d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686758688; x=1689350688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+yno5ZdAMwferMqd2TLytY+ZQNkjo8dJsMMhlqbl50=;
        b=ugRUKAKSeixsT0gVxhGuCfuSlx4ItfdDqIVpDYp6ndojs3JTKj+GZeUQ9TJM2nW8YB
         qkYG/PC7JTLLeOWc0b+EazC8Mm5x+fbtd1IrQTnwc62SFQdFa0FS0IT9CZ45HUzTefGK
         mJCl+WHOtshwD256Zp3BwiZWdpx07r3u6WCbAmUaO5BFZdGgmiQXi1wl+nURVxlOjF8E
         BF8cKxps+VNviA6H7SIyQFMFzDKE9Z5k4/olVeHddk9cs9MVpl8z7PR7Uy9vHi/xhNVt
         EfQw8ozrXgCl/4bO1hTcYVlrELMjKpin6gAUF4r2IPoVeD1/pg6jcdsBke8hr5m2GGwl
         qMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686758688; x=1689350688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+yno5ZdAMwferMqd2TLytY+ZQNkjo8dJsMMhlqbl50=;
        b=JKfRikefyarCOFzUSdwlQWkiuD0gIeJRdM5Ml6Sfjm3Z8XcpZ++2zcmiobv+vWrCIQ
         SxHpMS2hnkRk+tZtJIX7bq/IbXZIz1z95ik43zkRFMeKZcCZcSiuWpOWeoqbit8/9Hba
         TtIx8uQ8vWygUfmpGEV+7moz4hGXIihtjUdCsVNmk5yYjL3KK34qSv1xiV2ETh/ksYX9
         Ioci2EVe0tkOCoZ5vvVYHmYTozRrGLqEDkRN5DVM7AoANGUGqA1XXkPBe2Ud4csWusb9
         X55jbv0ibMvk/oxPWorCSDm3whnx6+d6614/fp/R8yAqETF0nmSRjw7D96tv5JWdrpD1
         NAbA==
X-Gm-Message-State: AC+VfDw2WT4847EaV46d3kJlcMIlln4+tiFLzA6iPsYu7Jv14NPfxoWr
        3EqXstfAaDS5ehyvPNH0dK9CK4Qlyrp0JpYM0OIr6rPL0W+gjhxxLSrlyg==
X-Google-Smtp-Source: ACHHUZ6IC1Fq+VOrxsYn33ZUZ141xkcHJ9dV9IFuBMhWgqqDPg6I6zRraY5Bybr/0hXHZ66TuDmmF24oif1TejdOGq0=
X-Received: by 2002:ad4:5c85:0:b0:626:273e:c356 with SMTP id
 o5-20020ad45c85000000b00626273ec356mr22533723qvh.14.1686758687973; Wed, 14
 Jun 2023 09:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <202305230231.3Wb7Q68G-lkp@intel.com> <edf2ec88-3586-bbb1-fbf1-9451393c12ec@csgroup.eu>
In-Reply-To: <edf2ec88-3586-bbb1-fbf1-9451393c12ec@csgroup.eu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 14 Jun 2023 12:04:36 -0400
Message-ID: <CAKwvOdm3vNxp9GZrxs6s4h73pHgHD=sJjaPziGzxcr+K7iGd-g@mail.gmail.com>
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

On Wed, Jun 14, 2023 at 10:11=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Hi,
>
> Le 22/05/2023 =C3=A0 21:00, kernel test robot a =C3=A9crit :
> > Hi Christophe,
> >
> > FYI, the error/warning still remains.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   44c026a73be8038f03dbdeef028b642880cf1511
> > commit: 7245fc5bb7a966852d5bd7779d1f5855530b461a powerpc/math-emu: Remo=
ve -w build flag and fix warnings
> > date:   9 months ago
> > config: powerpc-randconfig-r022-20230522 (https://download.01.org/0day-=
ci/archive/20230523/202305230231.3Wb7Q68G-lkp@intel.com/config)
> > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b0=
fb98227c90adf2536c9ad644a74d5e92961111)
> > reproduce (this is a W=3D1 build):
> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/=
sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # install powerpc cross compiling tool for clang build
> >          # apt-get install binutils-powerpc-linux-gnu
> >          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git/commit/?id=3D7245fc5bb7a966852d5bd7779d1f5855530b461a
> >          git remote add linus https://git.kernel.org/pub/scm/linux/kern=
el/git/torvalds/linux.git
> >          git fetch --no-tags linus master
> >          git checkout 7245fc5bb7a966852d5bd7779d1f5855530b461a
> >          # save the config file
> >          mkdir build_dir && cp config build_dir/.config
> >          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross=
 W=3D1 O=3Dbuild_dir ARCH=3Dpowerpc olddefconfig
> >          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross=
 W=3D1 O=3Dbuild_dir ARCH=3Dpowerpc SHELL=3D/bin/bash arch/powerpc/math-emu=
/
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202305230231.3Wb7Q68G-l=
kp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >>> arch/powerpc/math-emu/fcmpu.c:13:2: warning: variable 'A_c' set but n=
ot used [-Wunused-but-set-variable]
>
> This code is imported, and there is no plan to make any change to it.
> Can you desactivate that warning ?

If the code is imported, and we don't plan to push fixes upstream,
does it make sense to just set -Wno-unusued-but-set-variable in
arch/powerpc/math-emu/Makefile?

Wait, what?!
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/powerpc/math-emu/Makefile#n20
arch/powerpc/math-emu/Makefile already has -Wunused-but-set-variable
in ccflags-remove-y. But if KBUILD_EXTRA_WARN is set for W=3D1 builds,
-Wunused-but-set-variable is added back, but only for math.o and
math_efp.o.  The warning above comes from building fcmpu.o.  So how
did  -Wunused-but-set-variable get set in the first place?

commit 78c73c80fd86 ("powerpc/math-emu: Inhibit W=3D1 warnings")
seems to have cleaned up this code for W=3D1 with GCC. This report is a
result of W=3D1 with CC=3Dclang.

>
> Thanks
> Christophe
>
> >             FP_DECL_D(A);
> >             ^
> >     include/math-emu/double.h:73:23: note: expanded from macro 'FP_DECL=
_D'
> >     #define FP_DECL_D(X)            _FP_DECL(2,X)
> >                                     ^
> >     include/math-emu/op-common.h:28:14: note: expanded from macro '_FP_=
DECL'
> >       _FP_I_TYPE X##_c=3D0, X##_s=3D0, X##_e=3D0; \
> >                  ^
> >     <scratch space>:124:1: note: expanded from here
> >     A_c
> >     ^
> >>> arch/powerpc/math-emu/fcmpu.c:14:2: warning: variable 'B_c' set but n=
ot used [-Wunused-but-set-variable]
> >             FP_DECL_D(B);
> >             ^
> >     include/math-emu/double.h:73:23: note: expanded from macro 'FP_DECL=
_D'
> >     #define FP_DECL_D(X)            _FP_DECL(2,X)
> >                                     ^
> >     include/math-emu/op-common.h:28:14: note: expanded from macro '_FP_=
DECL'
> >       _FP_I_TYPE X##_c=3D0, X##_s=3D0, X##_e=3D0; \
> >                  ^
> >     <scratch space>:130:1: note: expanded from here
> >     B_c
> >     ^
> >>> arch/powerpc/math-emu/fcmpu.c:15:2: warning: variable '_fex' set but =
not used [-Wunused-but-set-variable]
> >             FP_DECL_EX;
> >             ^
> >     include/math-emu/soft-fp.h:94:24: note: expanded from macro 'FP_DEC=
L_EX'
> >     #define FP_DECL_EX int _fex =3D 0
> >                            ^
> >     arch/powerpc/math-emu/fcmpu.c:11:1: warning: no previous prototype =
for function 'fcmpu' [-Wmissing-prototypes]
> >     fcmpu(u32 *ccr, int crfD, void *frA, void *frB)
> >     ^
> >     arch/powerpc/math-emu/fcmpu.c:10:1: note: declare 'static' if the f=
unction is not intended to be used outside of this translation unit
> >     int
> >     ^
> >     static
> >     4 warnings generated.
> > --
> >>> arch/powerpc/math-emu/fctiw.c:14:2: warning: variable '_fex' set but =
not used [-Wunused-but-set-variable]
> >             FP_DECL_EX;
> >             ^
> >     include/math-emu/soft-fp.h:94:24: note: expanded from macro 'FP_DEC=
L_EX'
> >     #define FP_DECL_EX int _fex =3D 0
> >                            ^
> >     arch/powerpc/math-emu/fctiw.c:11:1: warning: no previous prototype =
for function 'fctiw' [-Wmissing-prototypes]
> >     fctiw(u32 *frD, void *frB)
> >     ^
> >     arch/powerpc/math-emu/fctiw.c:10:1: note: declare 'static' if the f=
unction is not intended to be used outside of this translation unit
> >     int
> >     ^
> >     static
> >     2 warnings generated.
> > --
> >>> arch/powerpc/math-emu/fctiwz.c:14:2: warning: variable '_fex' set but=
 not used [-Wunused-but-set-variable]
> >             FP_DECL_EX;
> >             ^
> >     include/math-emu/soft-fp.h:94:24: note: expanded from macro 'FP_DEC=
L_EX'
> >     #define FP_DECL_EX int _fex =3D 0
> >                            ^
> >     arch/powerpc/math-emu/fctiwz.c:11:1: warning: no previous prototype=
 for function 'fctiwz' [-Wmissing-prototypes]
> >     fctiwz(u32 *frD, void *frB)
> >     ^
> >     arch/powerpc/math-emu/fctiwz.c:10:1: note: declare 'static' if the =
function is not intended to be used outside of this translation unit
> >     int
> >     ^
> >     static
> >     2 warnings generated.
> > --
> >>> arch/powerpc/math-emu/fsel.c:14:2: warning: variable '_fex' set but n=
ot used [-Wunused-but-set-variable]
> >             FP_DECL_EX;
> >             ^
> >     include/math-emu/soft-fp.h:94:24: note: expanded from macro 'FP_DEC=
L_EX'
> >     #define FP_DECL_EX int _fex =3D 0
> >                            ^
> >     arch/powerpc/math-emu/fsel.c:11:1: warning: no previous prototype f=
or function 'fsel' [-Wmissing-prototypes]
> >     fsel(u32 *frD, void *frA, u32 *frB, u32 *frC)
> >     ^
> >     arch/powerpc/math-emu/fsel.c:10:1: note: declare 'static' if the fu=
nction is not intended to be used outside of this translation unit
> >     int
> >     ^
> >     static
> >     2 warnings generated.
> >
> >
> > vim +/A_c +13 arch/powerpc/math-emu/fcmpu.c
> >
> > ^1da177e4c3f41 arch/ppc/math-emu/fcmpu.c     Linus Torvalds 2005-04-16 =
  9
> > ^1da177e4c3f41 arch/ppc/math-emu/fcmpu.c     Linus Torvalds 2005-04-16 =
 10  int
> > ^1da177e4c3f41 arch/ppc/math-emu/fcmpu.c     Linus Torvalds 2005-04-16 =
 11  fcmpu(u32 *ccr, int crfD, void *frA, void *frB)
> > ^1da177e4c3f41 arch/ppc/math-emu/fcmpu.c     Linus Torvalds 2005-04-16 =
 12  {
> > ^1da177e4c3f41 arch/ppc/math-emu/fcmpu.c     Linus Torvalds 2005-04-16 =
@13    FP_DECL_D(A);
> > ^1da177e4c3f41 arch/ppc/math-emu/fcmpu.c     Linus Torvalds 2005-04-16 =
@14    FP_DECL_D(B);
> > d2b194ed820880 arch/powerpc/math-emu/fcmpu.c Kumar Gala     2008-06-04 =
@15    FP_DECL_EX;
> > ^1da177e4c3f41 arch/ppc/math-emu/fcmpu.c     Linus Torvalds 2005-04-16 =
 16    int code[4] =3D { (1 << 3), (1 << 1), (1 << 2), (1 << 0) };
> > ^1da177e4c3f41 arch/ppc/math-emu/fcmpu.c     Linus Torvalds 2005-04-16 =
 17    long cmp;
> > ^1da177e4c3f41 arch/ppc/math-emu/fcmpu.c     Linus Torvalds 2005-04-16 =
 18
> >
> > :::::: The code at line 13 was first introduced by commit
> > :::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2
> >
> > :::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
> > :::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>
> >



--=20
Thanks,
~Nick Desaulniers
