Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24DE7363F7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjFTHFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjFTHFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:05:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4920BEB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:05:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f9189228bcso19198915e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687244730; x=1689836730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04zh36AvJbipRw33shUJK56XIsvBY+yjxSjK/IpcInY=;
        b=pVRj8ZNa+CHcw80+9IiyfhCGHM+LVg/cqHWIN/Mr+Koo/wowzbt3iwfwiG6HBc4Oi5
         MRMUNw61+oFadBUq7207Td4d0hq8kVaE/vVJCQ77dWLXv481VPvmuHDrQEmPgc+8lXGv
         HqA1qwqEL3YV3thkSwlE/BJCTZ3gpNW0UBFFlEir7rhzJWovLP6OpDHuVELXjPyj4G39
         frmRYQRtceV3aJYn37fnMGMmlAN/V0+h2WNAXT8cUSo8gEpmsfMdYnPrkdtqaDc7UUjJ
         c9KNeQrnWHee7nUcu1fLNd7TGEZQ6UuzRbYVz30LYJSf1kpHaJ3KQcG/Esn7E+NIpuMs
         Cmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687244730; x=1689836730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04zh36AvJbipRw33shUJK56XIsvBY+yjxSjK/IpcInY=;
        b=JSfOVFioGkJjZme3B/NL9zXGjMuH0YR1sRlk5yivZEJWx0qPRftLrMqW2gB1ocefu/
         qKZNiUsQeoZTUeJrAANmuezzgkwHNVVEcniivysnbsbfBv4A0X6EXQxB1/Dy6dQePiaQ
         FpaIcMdd+7ea/OGV8SJxpRiqxqwfnGgcmU95GJ7m1uDu0grxiPwhd30/B4/8lXksvn33
         5S4XwhBAuYL0EKkt82mYsT9MvcyOIj+Ay1zEsT5sKjfMYmHvFFB4Zjl6jEx8NGXz5/VZ
         +tfMw+wXluo80wUZlbi9qFRP0sol8MCAuhPJJDmlOfWsDJOcTPc+wicLp0AnfMv1gD8j
         v4+Q==
X-Gm-Message-State: AC+VfDx0l6ry0BQDQ0mjpi4dNJMEh97k7HB8l0cP5B+GfSEMMpGU1CKr
        JlHj3K8cGroko0mfNWo8jdgM9Pnr7EfJ+ODsYu/Dp1ddYeTTTiBs
X-Google-Smtp-Source: ACHHUZ70GU/k1IaUxTC0p5wUDRx4EiR/t5mGWrdG4FwgA8LfklmJYFRxH5rGeLs0WvjZehTF0hk+UZ3ABmLtZcIvUKI=
X-Received: by 2002:a05:600c:cc:b0:3f7:e520:dc86 with SMTP id
 u12-20020a05600c00cc00b003f7e520dc86mr7738643wmm.32.1687244730686; Tue, 20
 Jun 2023 00:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <202306110855.7TlBCIzI-lkp@intel.com> <CAHVXubhKstDeRDp8n-POR_eL0vh5DdHuWKHu7pN+X_j0rtG4Dw@mail.gmail.com>
 <CAKwvOd=yg5GE8eF5bFY4t2S-0Od3smH9iRB+2Ctkg=+WXM97ig@mail.gmail.com>
In-Reply-To: <CAKwvOd=yg5GE8eF5bFY4t2S-0Od3smH9iRB+2Ctkg=+WXM97ig@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 20 Jun 2023 09:05:19 +0200
Message-ID: <CAHVXubgVo=6czfDCdweAjc0NHbCk-_+zL+_MHca=3ax5Fo1HgQ@mail.gmail.com>
Subject: Re: ld.lld: error: relocation R_RISCV_HI20 cannot be used against
 symbol 'misaligned_access_speed'; recompile with -fPIC
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 6:40=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Jun 13, 2023 at 4:17=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > On Sun, Jun 11, 2023 at 2:11=E2=80=AFAM kernel test robot <lkp@intel.co=
m> wrote:
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git master
> > > head:   022ce8862dff83c859089cd14bc4dca0733e2f90
> > > commit: 8dc2a7e8027fbeca0c7df81d4c82e735a59b5741 riscv: Fix relocatab=
le kernels with early alternatives using -fno-pie
> > > date:   10 days ago
> > > config: riscv-randconfig-r022-20230611 (https://download.01.org/0day-=
ci/archive/20230611/202306110855.7TlBCIzI-lkp@intel.com/config)
> > > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.=
git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > > reproduce (this is a W=3D1 build):
> > >         mkdir -p ~/bin
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master=
/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install riscv cross compiling tool for clang build
> > >         # apt-get install binutils-riscv64-linux-gnu
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/?id=3D8dc2a7e8027fbeca0c7df81d4c82e735a59b5741
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/ker=
nel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout 8dc2a7e8027fbeca0c7df81d4c82e735a59b5741
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang ~/bin/mak=
e.cross W=3D1 O=3Dbuild_dir ARCH=3Driscv olddefconfig
> > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang ~/bin/mak=
e.cross W=3D1 O=3Dbuild_dir ARCH=3Driscv SHELL=3D/bin/bash
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202306110855.7TlBCIzI=
-lkp@intel.com/
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > > >> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symb=
ol 'misaligned_access_speed'; recompile with -fPIC
> > >    >>> defined in vmlinux.a(arch/riscv/kernel/cpufeature.o)
> > >    >>> referenced by errata.c:42 (arch/riscv/errata/thead/errata.c:42=
)
> > >    >>>               arch/riscv/errata/thead/errata.o:(thead_feature_=
probe_func) in archive vmlinux.a
> > > --
> > > >> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against sy=
mbol 'misaligned_access_speed'; recompile with -fPIC
> > >    >>> defined in vmlinux.a(arch/riscv/kernel/cpufeature.o)
> > >    >>> referenced by errata.c:42 (arch/riscv/errata/thead/errata.c:42=
)
> > >    >>>               arch/riscv/errata/thead/errata.o:(thead_feature_=
probe_func) in archive vmlinux.a
> > > --
> > > >> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symb=
ol 'riscv_cbom_block_size'; recompile with -fPIC
> > >    >>> defined in vmlinux.a(arch/riscv/mm/cacheflush.o)
> > >    >>> referenced by errata.c:42 (arch/riscv/errata/thead/errata.c:42=
)
> > >    >>>               arch/riscv/errata/thead/errata.o:(thead_errata_p=
atch_func) in archive vmlinux.a
> > > --
> > > >> ld.lld: error: relocation R_RISCV_LO12_S cannot be used against sy=
mbol 'riscv_cbom_block_size'; recompile with -fPIC
> > >    >>> defined in vmlinux.a(arch/riscv/mm/cacheflush.o)
> > >    >>> referenced by errata.c:42 (arch/riscv/errata/thead/errata.c:42=
)
> > >    >>>               arch/riscv/errata/thead/errata.o:(thead_errata_p=
atch_func) in archive vmlinux.a
> > > --
> > > >> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symb=
ol '__per_cpu_offset'; recompile with -fPIC
> > >    >>> defined in vmlinux.a(mm/percpu.o)
> > >    >>> referenced by errata.c:42 (arch/riscv/errata/thead/errata.c:42=
)
> > >    >>>               arch/riscv/errata/thead/errata.o:(thead_feature_=
probe_func) in archive vmlinux.a
> > > --
> > > >> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against sy=
mbol '__per_cpu_offset'; recompile with -fPIC
> > >    >>> defined in vmlinux.a(mm/percpu.o)
> > >    >>> referenced by errata.c:42 (arch/riscv/errata/thead/errata.c:42=
)
> > >    >>>               arch/riscv/errata/thead/errata.o:(thead_feature_=
probe_func) in archive vmlinux.a
> > >
> >
> > So I looked into those errors, the config is basically =3D RELOCATABLE =
+
> > MEDLOW - EARLY_ALTERNATIVES. Then errata/thead is not compiled as
>
> Thanks for taking a look.  Shouldn't CONFIG_RELOCATABLE be setting
> -fPIC? If so, why is LLD complaining about -fPIC not being used?
>
> arch/riscv/Makefile sets -fPIE if CONFIG_RELOCATABLE =3D=3D y.
>
> Is it possible that -fpie was dropped for these object files, or
> -fno-pic or -fno-pie was added to the cflags for these object files
> somehow?

There was a runtime issue where I had to drop the -fPIE for those
files because some part *may* be executed before the MMU is enabled,
so any access to a global symbol through the GOT needs a relocation
which is "done" only virtually.

commit 8dc2a7e8027f ("riscv: Fix relocatable kernels with early
alternatives using -fno-pie") added the -fno-pie flag, but not the
medany because the medany is correctly set in errata/thead/Makefile
only when EARLY_ALTERNATIVES is set.

So to me we do not need the medany flag if !EARLY_ALTERNATIVES since
the code is not executed with MMU off and then medlow should work.


>
> I've filed
> https://github.com/ClangBuiltLinux/linux/issues/1872
> to track this.
>
> > medany, which makes sense since we only need this code to be medany
> > when EARLY_ALTERNATIVES is enabled (because the code would be executed
> > with mmu off, which is not the case here).
> >
> > I can fix those errors by adding the medany flag, but I'm not sure
> > actually we want to do that since we do not need it and gcc does not
> > complain: any idea?
> >
> > Alex
> >
> >
> >
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
