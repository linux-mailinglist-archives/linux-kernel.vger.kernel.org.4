Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6B265A340
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 09:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiLaIgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 03:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLaIgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 03:36:04 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5584D1145
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 00:36:03 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bk16so8750502wrb.11
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 00:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xRvy8oO39JOzDKdsh3QNHLbIdKU2kzaSMxLVfuymv7s=;
        b=TJUbR3uuauG2QvzeiFsk1SaHBP0WD5E5Q+HyTFRWqv6cMDsWwj1IY4lbDg0guZJkBz
         nMrSRHr49wiz0ha2FOPb5WU4DGaVPJRYIXDUunrUoJWIgKX1uOOY0BIL1fE06rn2VNHT
         uILGC6p7RbiIixd1d0jQubpB0t7DPysjEIOMqvyqxlKeunYJyU+koHh3WZ9qoTQh+quS
         Wtc5TKwmCqgdBkjRVEkeVkV9CBSxa2jfTQWXU6T0csUK/S9IoP7wdl4BCUwNpoet7S34
         uaE+C1WaUHwq0n31BzcIgKUIHIhgoAeeWIAaMN/ZkGPAdRIgcIouS4N2HHKsgyzibRC5
         nA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRvy8oO39JOzDKdsh3QNHLbIdKU2kzaSMxLVfuymv7s=;
        b=Za09buH+IfNRBuxZIonZ2CLdlB2eE+zykNXVDE44Ps3qigcLvd6HK17nGN3ofnlTj/
         b7dlPUvymlb8dLpJI09ApOPWRQ/DML55jm1ZH+g7fvIuKxX1h8qmFlD2CSoJxMO7RJek
         UzND+/K+P1GFrZL0zNQlSZygEEVw7+qroODbbgNBwJAXLcnnIzwxyKht4S6Jvc3HMM+9
         wSmO3RGaE+SvY3RSkv7clKe5D2S6dlEbpzzNs7KLqNTRWddS+hUN3p8I3Bc7eB2tWx/o
         tyNtyE783xDnemMpfzfBYmacP26KOqyuqlh+133rsPuiAuojrEU/Ch/mEfbJ0Uy79I+i
         WkdA==
X-Gm-Message-State: AFqh2kp8gIZ49CIrXGrSK7quDEYCEakhf7Dtt4MxzUGU3SVNBmw8eF6i
        iAmgcb8ymtbeKloeSUpqNX+tYV0cvNKwx1KK4J4=
X-Google-Smtp-Source: AMrXdXvSdbIabREV/E2VrX0Gcx4yCE3QDQBhrdQaoKCgIT46j7qIN6+NkGwYwAqb5nsibf+LfrWXyMehlB6B0SxPZlw=
X-Received: by 2002:adf:e890:0:b0:276:70cc:7b47 with SMTP id
 d16-20020adfe890000000b0027670cc7b47mr1242913wrm.131.1672475761713; Sat, 31
 Dec 2022 00:36:01 -0800 (PST)
MIME-Version: 1.0
References: <20221216192149.3902877-4-nphamcs@gmail.com> <202212170645.rxqFnDky-lkp@intel.com>
In-Reply-To: <202212170645.rxqFnDky-lkp@intel.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Sat, 31 Dec 2022 00:35:50 -0800
Message-ID: <CAKEwX=OD_waeK-A1ZkvJ92oNtcdtK8DS5wf2jhw8prwNoHkPgQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] cachestat: implement cachestat syscall
To:     kernel test robot <lkp@intel.com>
Cc:     akpm@linux-foundation.org, oe-kbuild-all@lists.linux.dev,
        hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 2:27 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Nhat,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on shuah-kselftest/next]
> [also build test ERROR on akpm-mm/mm-everything linus/master v6.1 next-20221216]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/cachestat-a-new-syscall-for-page-cache-state-of-files/20221217-032254
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
> patch link:    https://lore.kernel.org/r/20221216192149.3902877-4-nphamcs%40gmail.com
> patch subject: [PATCH v4 3/4] cachestat: implement cachestat syscall
> config: s390-allmodconfig
> compiler: s390-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/85fdb04584b3d9a3b90d2c63794ec65e8d996b18
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Nhat-Pham/cachestat-a-new-syscall-for-page-cache-state-of-files/20221217-032254
>         git checkout 85fdb04584b3d9a3b90d2c63794ec65e8d996b18
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/kvm/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from include/uapi/asm-generic/mman.h:5,
>                     from ./arch/s390/include/generated/uapi/asm/mman.h:1,
>                     from include/uapi/linux/mman.h:5,
>                     from include/linux/fs.h:49,
>                     from include/linux/huge_mm.h:8,
>                     from include/linux/mm.h:737,
>                     from include/linux/kvm_host.h:16,
>                     from arch/s390/kvm/kvm-s390.h:17,
>                     from arch/s390/kvm/gaccess.c:16:
> >> include/uapi/asm-generic/mman-common.h:16:25: error: expected identifier before numeric constant
>       16 | #define PROT_NONE       0x0             /* page can not be accessed */
>          |                         ^~~
>    arch/s390/kvm/gaccess.c:493:9: note: in expansion of macro 'PROT_NONE'
>      493 |         PROT_NONE,
>          |         ^~~~~~~~~
>    arch/s390/kvm/gaccess.c: In function 'trans_exc_ending':
> >> arch/s390/kvm/gaccess.c:516:17: error: duplicate case value
>      516 |                 case PROT_TYPE_LA:
>          |                 ^~~~
>    arch/s390/kvm/gaccess.c:509:17: note: previously used here
>      509 |                 case PROT_NONE:
>          |                 ^~~~
>    In file included from include/linux/compiler_types.h:79,
>                     from <command-line>:
> >> include/linux/compiler_attributes.h:223:41: warning: attribute 'fallthrough' not preceding a case label or default label
>      223 | # define fallthrough                    __attribute__((__fallthrough__))
>          |                                         ^~~~~~~~~~~~~
>    arch/s390/kvm/gaccess.c:515:25: note: in expansion of macro 'fallthrough'
>      515 |                         fallthrough;
>          |                         ^~~~~~~~~~~
>
>
> vim +16 include/uapi/asm-generic/mman-common.h
>
> 5f6164f3092832 include/asm-generic/mman.h             Michael S. Tsirkin 2006-02-15   9
> 5f6164f3092832 include/asm-generic/mman.h             Michael S. Tsirkin 2006-02-15  10  #define PROT_READ      0x1             /* page can be read */
> 5f6164f3092832 include/asm-generic/mman.h             Michael S. Tsirkin 2006-02-15  11  #define PROT_WRITE     0x2             /* page can be written */
> 5f6164f3092832 include/asm-generic/mman.h             Michael S. Tsirkin 2006-02-15  12  #define PROT_EXEC      0x4             /* page can be executed */
> 5f6164f3092832 include/asm-generic/mman.h             Michael S. Tsirkin 2006-02-15  13  #define PROT_SEM       0x8             /* page may be used for atomic ops */
> d41938d2cbee92 include/uapi/asm-generic/mman-common.h Dave Martin        2019-12-11  14  /*                     0x10               reserved for arch-specific use */
> d41938d2cbee92 include/uapi/asm-generic/mman-common.h Dave Martin        2019-12-11  15  /*                     0x20               reserved for arch-specific use */
> 5f6164f3092832 include/asm-generic/mman.h             Michael S. Tsirkin 2006-02-15 @16  #define PROT_NONE      0x0             /* page can not be accessed */
> 5f6164f3092832 include/asm-generic/mman.h             Michael S. Tsirkin 2006-02-15  17  #define PROT_GROWSDOWN 0x01000000      /* mprotect flag: extend change to start of growsdown vma */
> 5f6164f3092832 include/asm-generic/mman.h             Michael S. Tsirkin 2006-02-15  18  #define PROT_GROWSUP   0x02000000      /* mprotect flag: extend change to end of growsup vma */
> 5f6164f3092832 include/asm-generic/mman.h             Michael S. Tsirkin 2006-02-15  19
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

These build errors (and the ones reported by the later kernel test robot emails)
seem to come from my refactoring, which adds:

#include <uapi/linux/mman.h>

to include/linux/fs.h. Several other files (which chain-include fs.h)
also define
several same constants elsewhere. This include seems unnecessary, as
I can just replace it with:

struct cachestat;

This should be fixed in the next version of the patch series.
