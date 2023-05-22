Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255F170B7FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjEVIsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjEVIsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:48:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5C7CD;
        Mon, 22 May 2023 01:48:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4B2F61EEE;
        Mon, 22 May 2023 08:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFA8C4339C;
        Mon, 22 May 2023 08:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684745280;
        bh=dhkdseplp2rrgwJ8+a1C+wai/ckiWP/ufdoDWmarcBE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j08MVD/ZML3gIaAMOu28RtCcr+8udcM/LreSdpZ9fKlSKWvGdlA3tRaE0bXfJVb8P
         yVhb11VmZtOIQcXBEcjGq3/P6+KO7xi/aPdietUgUwM2l1MQ2KfVpTPe3mV3joTygH
         a5f3X01rHjvyGCx0lDexQbx0vGtr4VRbGxNxOlMnkQbAbXa7XPIDMToQzs49nejwIV
         YGue4tQdk9bdAc6XKJfRWHIPnntSdb5ZY8fOOxtead29y3pE1xQtpV1T+6sN3CpKZE
         rUAbzp62g6N5jnjjk/V1EHk41+pbQ0LntOceSXgQgRdNfkDwgDWLvvg005XJ1qlj6b
         JDE2tv0GuC7bQ==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-510d967249aso9652477a12.1;
        Mon, 22 May 2023 01:47:59 -0700 (PDT)
X-Gm-Message-State: AC+VfDx/+vPFV59y68GyUwN2mo0RNX1PJ7s4z/zFD2lCp0H7930VXIav
        ZCEMvPf55KcNs832+SyHRmJo12+E5V5XUbG+IRg=
X-Google-Smtp-Source: ACHHUZ4N/bkRduc2PnEwH6IzxhGOPmnL3dIVGwcrnIbp2yQ/rkAEGxKtZpuuXJsIzKYsdt9rQzrVqL3VvejvU5M2JRw=
X-Received: by 2002:aa7:c40b:0:b0:50b:d75d:5dca with SMTP id
 j11-20020aa7c40b000000b0050bd75d5dcamr8356986edq.42.1684745278235; Mon, 22
 May 2023 01:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230517-genkey-v1-1-b887424da4a8@google.com> <202305181712.xjvv1fbD-lkp@intel.com>
 <CAKwvOd=hoKFMC40U-Pd=2dBJ4zT4P60OgJpHvNmH+zdGAd_J-Q@mail.gmail.com>
In-Reply-To: <CAKwvOd=hoKFMC40U-Pd=2dBJ4zT4P60OgJpHvNmH+zdGAd_J-Q@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 22 May 2023 16:47:46 +0800
X-Gmail-Original-Message-ID: <CAJF2gTReoP+mFqf4TLjAgE0JJ2vvX8p7SnC2-sdjx+PMK-U+ig@mail.gmail.com>
Message-ID: <CAJF2gTReoP+mFqf4TLjAgE0JJ2vvX8p7SnC2-sdjx+PMK-U+ig@mail.gmail.com>
Subject: Re: [PATCH] certs: buffer stderr from openssl unless error
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Philip Li <philip.li@intel.com>, oe-kbuild-all@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>, linux-csky@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        yunhai.syh@alibaba-inc.com,
        Cooper Qu <cooper.qu@linux.alibaba.com>,
        xlf194833@alibaba-inc.com
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

F.Y.I., our compiler team, would put an eye on this.

On Fri, May 19, 2023 at 6:37=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, May 18, 2023 at 3:23=E2=80=AFAM kernel test robot <lkp@intel.com>=
 wrote:
> >
> > Hi,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/ndesaulniers-goo=
gle-com/certs-buffer-stderr-from-openssl-unless-error/20230518-004753
> > base:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
> > patch link:    https://lore.kernel.org/r/20230517-genkey-v1-1-b887424da=
4a8%40google.com
> > patch subject: [PATCH] certs: buffer stderr from openssl unless error
> > config: csky-randconfig-m041-20230517
> > compiler: csky-linux-gcc (GCC) 12.1.0
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
>
> ^ should encourage `mkdir ~/bin`; the debian docker container doesn't
> have `~/bin`.
>
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/intel-lab-lkp/linux/commit/0e437a41fdb41c8=
4834de6776bf38951b197792a
> >         git remote add linux-review https://github.com/intel-lab-lkp/li=
nux
> >         git fetch --no-tags linux-review ndesaulniers-google-com/certs-=
buffer-stderr-from-openssl-unless-error/20230518-004753
>
> ^ holy crap that takes forever. maybe recommend `b4 shazam <lore link>`?
>
> >         git checkout 0e437a41fdb41c84834de6776bf38951b197792a
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.c=
ross W=3D1 O=3Dbuild_dir ARCH=3Dcsky olddefconfig
>
> ^ should use `~/bin/make.cross` since `~/bin` may not exist in $PATH.
>
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.c=
ross W=3D1 O=3Dbuild_dir ARCH=3Dcsky SHELL=3D/bin/bash
>
> Hi Philip,
> I've run into some issues with make.cross when trying to install the
> csky toolchain. Maybe you can help?
>
> ```
> $ COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0
> ~/bin/make.cross W=3D1 O=3Dbuild_dir ARCH=3Dcsky olddefconfig
> Compiler will be installed in /root/0day
> make: gcc: No such file or directory
> lftpget -c https://download.01.org/0day-ci/cross-package/./gcc-12.1.0-nol=
ibc/x86_64-gcc-12.1.0-nolibc_csky-linux.tar.xz
> /linux
> tar Jxf /root/0day/gcc-12.1.0-nolibc/x86_64-gcc-12.1.0-nolibc_csky-linux.=
tar.xz
> -C /root/0day
> Please update: libc6 or glibc
> ldd /root/0day/gcc-12.1.0-nolibc/csky-linux/bin/csky-linux-gcc
> /root/0day/gcc-12.1.0-nolibc/csky-linux/bin/csky-linux-gcc:
> /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.32' not found
> (required by /root/0day/gcc-12.1.0-nolibc/csky-linux/bin/csky-linux-gcc)
> /root/0day/gcc-12.1.0-nolibc/csky-linux/bin/csky-linux-gcc:
> /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.33' not found
> (required by /root/0day/gcc-12.1.0-nolibc/csky-linux/bin/csky-linux-gcc)
> setup_crosstool failed
>
> $ ldd -v /lib/x86_64-linux-gnu/libc.so.6
> /lib64/ld-linux-x86-64.so.2 (0x00007f11f3478000)
> linux-vdso.so.1 (0x00007ffcf45b2000)
>
> Version information:
> /lib/x86_64-linux-gnu/libc.so.6:
> ld-linux-x86-64.so.2 (GLIBC_2.3) =3D> /lib64/ld-linux-x86-64.so.2
> ld-linux-x86-64.so.2 (GLIBC_PRIVATE) =3D> /lib64/ld-linux-x86-64.so.2
>
> $ cat /etc/debian_version
> 11.6
> ```
> Perhaps I MUST update my debian container to 11.7?
>
> Are the 0day toolchains not statically linked? Can they use the ones
> from kernel.org which are?
> https://mirrors.edge.kernel.org/pub/tools/crosstool/
>
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202305181712.xjvv1fbD-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    At main.c:152:
> >    - SSL error:FFFFFFFF80000002:system library::No such file or directo=
ry: ../crypto/bio/bss_file.c:67
> >    - SSL error:10000080:BIO routines::no such file: ../crypto/bio/bss_f=
ile.c:75
> > >> extract-cert: certs/signing_key.pem: No such file or directory
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Best Regards
 Guo Ren
