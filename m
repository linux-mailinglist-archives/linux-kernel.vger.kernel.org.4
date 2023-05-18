Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB95708BC5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjERWhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjERWhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:37:07 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5478DE66
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:37:05 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7576eb88a46so236469285a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684449424; x=1687041424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEfc9ma1f8j7tQqY19VjZCuXlgV6oSU0kGv3ixpbTuE=;
        b=kWFa3A7ILY4qw61+vrmBTr6QKp1DufrhkX66vEQtvObqKO6K/p6G8BrQ/FDf905CR7
         0V89+g2Hk5I0dXmG/74xSAkAUFOHcx+pa4xXvaOYGtLGoNTbXPEO61bdV2SZskKyvFxT
         S95vbP0lTtugn6WIdlivdzYlAGQdVWKOClEM2ulVKtP+EfuM2V3hUB4QdqUORbvr/7YZ
         XdHFitHF1XhqSmNpM526K1o6GgKuwdzptWp8jTdH21aVKlXh5YwLgcYnwAgfiBeahHCX
         kSsE6cGWbhfLIEWBdhxvtijM3rQ8aBoQbffQm/ns19NtgZCok6+/b02vqKLhXnlDzjfR
         Anpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684449424; x=1687041424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEfc9ma1f8j7tQqY19VjZCuXlgV6oSU0kGv3ixpbTuE=;
        b=F0b+/wek4HjLB2agkheCwEfCL9Wkoq413T9hGY0LqohPKKBjiSbjWW1BLyIloogxvb
         2taCv7TkU8gypdegP5jceMkOMdmLuNO8szrucRtjE9Jt0JxWQ8OBjADQCk++VoRDnMKj
         S55mVwsCkp+kPjKcs+TnvURc2ejsv2p+5tbgF1Jdqm7Z6a+913HabE/yAFLG7cn6+v88
         frX+6JAzAGe8cXFFT44v9qmgJvVmDxl8iN/JvgF4cHsroe7cMnB9eS6cp28VNPQkrJLs
         OwUbOcXH+xdRPbmeXPUivOYAE+1z9rzgXTzTl63n8N+2W4GyrgXa9u2MTQl/fEqX2OwD
         QHYQ==
X-Gm-Message-State: AC+VfDxEexcP+KalKUX1UMd2E4B/PUgteR6KRVhngqDdKdc95lnoTkml
        jFCOl3Wf7oyiT0dksCVB2Jn0EcJzr2D35dNo6PlaOw==
X-Google-Smtp-Source: ACHHUZ5ouQKNUOrZRSfgoFcXPayagljSi/J0aDnMbpJJxW3USWQyhsr0WvRyRtIo8wYAtBsLtf+p+DLyS3DhnPGR3dY=
X-Received: by 2002:a05:6214:1d0d:b0:616:516e:f3ea with SMTP id
 e13-20020a0562141d0d00b00616516ef3eamr1112741qvd.51.1684449424296; Thu, 18
 May 2023 15:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230517-genkey-v1-1-b887424da4a8@google.com> <202305181712.xjvv1fbD-lkp@intel.com>
In-Reply-To: <202305181712.xjvv1fbD-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 May 2023 15:36:53 -0700
Message-ID: <CAKwvOd=hoKFMC40U-Pd=2dBJ4zT4P60OgJpHvNmH+zdGAd_J-Q@mail.gmail.com>
Subject: Re: [PATCH] certs: buffer stderr from openssl unless error
To:     Philip Li <philip.li@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 3:23=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/ndesaulniers-googl=
e-com/certs-buffer-stderr-from-openssl-unless-error/20230518-004753
> base:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
> patch link:    https://lore.kernel.org/r/20230517-genkey-v1-1-b887424da4a=
8%40google.com
> patch subject: [PATCH] certs: buffer stderr from openssl unless error
> config: csky-randconfig-m041-20230517
> compiler: csky-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross

^ should encourage `mkdir ~/bin`; the debian docker container doesn't
have `~/bin`.

>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/0e437a41fdb41c848=
34de6776bf38951b197792a
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review ndesaulniers-google-com/certs-bu=
ffer-stderr-from-openssl-unless-error/20230518-004753

^ holy crap that takes forever. maybe recommend `b4 shazam <lore link>`?

>         git checkout 0e437a41fdb41c84834de6776bf38951b197792a
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dcsky olddefconfig

^ should use `~/bin/make.cross` since `~/bin` may not exist in $PATH.

>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dcsky SHELL=3D/bin/bash

Hi Philip,
I've run into some issues with make.cross when trying to install the
csky toolchain. Maybe you can help?

```
$ COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0
~/bin/make.cross W=3D1 O=3Dbuild_dir ARCH=3Dcsky olddefconfig
Compiler will be installed in /root/0day
make: gcc: No such file or directory
lftpget -c https://download.01.org/0day-ci/cross-package/./gcc-12.1.0-nolib=
c/x86_64-gcc-12.1.0-nolibc_csky-linux.tar.xz
/linux
tar Jxf /root/0day/gcc-12.1.0-nolibc/x86_64-gcc-12.1.0-nolibc_csky-linux.ta=
r.xz
-C /root/0day
Please update: libc6 or glibc
ldd /root/0day/gcc-12.1.0-nolibc/csky-linux/bin/csky-linux-gcc
/root/0day/gcc-12.1.0-nolibc/csky-linux/bin/csky-linux-gcc:
/lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.32' not found
(required by /root/0day/gcc-12.1.0-nolibc/csky-linux/bin/csky-linux-gcc)
/root/0day/gcc-12.1.0-nolibc/csky-linux/bin/csky-linux-gcc:
/lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.33' not found
(required by /root/0day/gcc-12.1.0-nolibc/csky-linux/bin/csky-linux-gcc)
setup_crosstool failed

$ ldd -v /lib/x86_64-linux-gnu/libc.so.6
/lib64/ld-linux-x86-64.so.2 (0x00007f11f3478000)
linux-vdso.so.1 (0x00007ffcf45b2000)

Version information:
/lib/x86_64-linux-gnu/libc.so.6:
ld-linux-x86-64.so.2 (GLIBC_2.3) =3D> /lib64/ld-linux-x86-64.so.2
ld-linux-x86-64.so.2 (GLIBC_PRIVATE) =3D> /lib64/ld-linux-x86-64.so.2

$ cat /etc/debian_version
11.6
```
Perhaps I MUST update my debian container to 11.7?

Are the 0day toolchains not statically linked? Can they use the ones
from kernel.org which are?
https://mirrors.edge.kernel.org/pub/tools/crosstool/

>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202305181712.xjvv1fbD-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    At main.c:152:
>    - SSL error:FFFFFFFF80000002:system library::No such file or directory=
: ../crypto/bio/bss_file.c:67
>    - SSL error:10000080:BIO routines::no such file: ../crypto/bio/bss_fil=
e.c:75
> >> extract-cert: certs/signing_key.pem: No such file or directory
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki



--=20
Thanks,
~Nick Desaulniers
