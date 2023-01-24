Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B23F67A298
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjAXTYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjAXTYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:24:12 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0994C0D4;
        Tue, 24 Jan 2023 11:24:09 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id jr19so12771993qtb.7;
        Tue, 24 Jan 2023 11:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H02SARdJbOG9xHDyO4rUQCOtJbYpCr4eHoKUBzaYL6Q=;
        b=C85m29M5lfrN780bOuZp0hcwIYmhYNu3EpCIUC5yO+IBjLEzwdVRSVjTss3vblrmTO
         QATRwCNI055bWM2lULIfOOg1dTqsEtj7/x7T1aWQXczPgKAwNSvro1yvrqREynp/BY/P
         KCaRyB+7mmWH8uudnalwE0g3WeJObVQUlFbuEeWGqTCVSunmEBNWkBuLcYyiLF42Vtmy
         RPulL5QO653p3sT6zUEPCUTuzW7byd4bJ25Zu1OWQrd6lmUoZ5zcCDRim4IH3f+b86bn
         ouQqN8M07iSpAjiG/YPu8/E92l+z8fEj7WBhCG8QWP3Gxr0Yp1uN7SVASIBkYK1h1+2f
         wlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H02SARdJbOG9xHDyO4rUQCOtJbYpCr4eHoKUBzaYL6Q=;
        b=ZXvsY/QtCX6teDGJhJCudc2ff2u7z5xDIFyPd5FjqeBr998VmpiruP90c779cR5XF7
         CA/trV9TUC6f63bb5UFSZT2bMY9XhfDFTiWWbxzUhkLw6aaulk/R+4i2LvxWjSTcg8N2
         lUyy5Om2qjCZT117rbkiN1eKYnEFt8w+nWMx/v7fc/FxeTj9OUhy9TTWpMkne3nfQN4g
         aT0m6/0D68/UYbx4+sLjRDEI8Ynklr0RZt5NgE626BjmVknpbJeSJWV86SwET0mPL0V/
         YKLRYoS35symo+vJb6MihdtXMZZsqJQwH1R6Zz+LPlHF26RGLZWY5SCpXdk1qSw4AYPb
         nXYA==
X-Gm-Message-State: AFqh2kqdCoADQETvzDTL1XtH2jwVN5eGoiICh5sgN7X3GWKc4YvajZN6
        57l2XoUznVhsmF+WG8Wrv+NhVOdXZdZ/4HvfKrE=
X-Google-Smtp-Source: AMrXdXslw37tCOS4eF39s7VAH4eqhhJOdfda7JWGinfdntqqz+u1IqaESuA5KlGI4tYZV1Y805Xd6YqiehtmiIrtbbI=
X-Received: by 2002:ac8:774d:0:b0:3b6:6669:dd20 with SMTP id
 g13-20020ac8774d000000b003b66669dd20mr850987qtu.93.1674588248442; Tue, 24 Jan
 2023 11:24:08 -0800 (PST)
MIME-Version: 1.0
References: <20230124021118.154078-3-nphamcs@gmail.com> <202301241402.CeUdAtDh-lkp@intel.com>
In-Reply-To: <202301241402.CeUdAtDh-lkp@intel.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 24 Jan 2023 11:23:57 -0800
Message-ID: <CAKEwX=P0RvicKMEWAzb+48V2Y1Cai8tdMc8oCS0GY8qoiv0g=w@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] cachestat: implement cachestat syscall
To:     kernel test robot <lkp@intel.com>
Cc:     akpm@linux-foundation.org, oe-kbuild-all@lists.linux.dev,
        hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
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

On Mon, Jan 23, 2023 at 10:49 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Nhat,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on 1440f576022887004f719883acb094e7e0dd4944]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230124-101311
> base:   1440f576022887004f719883acb094e7e0dd4944
> patch link:    https://lore.kernel.org/r/20230124021118.154078-3-nphamcs%40gmail.com
> patch subject: [PATCH v7 2/3] cachestat: implement cachestat syscall
> config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20230124/202301241402.CeUdAtDh-lkp@intel.com/config)
> compiler: mips-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/f902a360bb453bd6885cd89d4f9ad4a40205fd15
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230124-101311
>         git checkout f902a360bb453bd6885cd89d4f9ad4a40205fd15
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips prepare
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> <stdin>:1565:2: warning: #warning syscall cachestat not implemented [-Wcpp]
> --
> >> <stdin>:1565:2: warning: #warning syscall cachestat not implemented [-Wcpp]
> --
>    scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
>    scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
>    scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>    arch/mips/kernel/asm-offsets.c:26:6: warning: no previous prototype for 'output_ptreg_defines' [-Wmissing-prototypes]
>       26 | void output_ptreg_defines(void)
>          |      ^~~~~~~~~~~~~~~~~~~~
>    arch/mips/kernel/asm-offsets.c:78:6: warning: no previous prototype for 'output_task_defines' [-Wmissing-prototypes]
>       78 | void output_task_defines(void)
>          |      ^~~~~~~~~~~~~~~~~~~
>    arch/mips/kernel/asm-offsets.c:92:6: warning: no previous prototype for 'output_thread_info_defines' [-Wmissing-prototypes]
>       92 | void output_thread_info_defines(void)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/kernel/asm-offsets.c:108:6: warning: no previous prototype for 'output_thread_defines' [-Wmissing-prototypes]
>      108 | void output_thread_defines(void)
>          |      ^~~~~~~~~~~~~~~~~~~~~
>    arch/mips/kernel/asm-offsets.c:136:6: warning: no previous prototype for 'output_thread_fpu_defines' [-Wmissing-prototypes]
>      136 | void output_thread_fpu_defines(void)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/kernel/asm-offsets.c:179:6: warning: no previous prototype for 'output_mm_defines' [-Wmissing-prototypes]
>      179 | void output_mm_defines(void)
>          |      ^~~~~~~~~~~~~~~~~
>    arch/mips/kernel/asm-offsets.c:213:6: warning: no previous prototype for 'output_sc_defines' [-Wmissing-prototypes]
>      213 | void output_sc_defines(void)
>          |      ^~~~~~~~~~~~~~~~~
>    arch/mips/kernel/asm-offsets.c:248:6: warning: no previous prototype for 'output_signal_defined' [-Wmissing-prototypes]
>      248 | void output_signal_defined(void)
>          |      ^~~~~~~~~~~~~~~~~~~~~
>    arch/mips/kernel/asm-offsets.c:315:6: warning: no previous prototype for 'output_pbe_defines' [-Wmissing-prototypes]
>      315 | void output_pbe_defines(void)
>          |      ^~~~~~~~~~~~~~~~~~
>    arch/mips/kernel/asm-offsets.c:327:6: warning: no previous prototype for 'output_pm_defines' [-Wmissing-prototypes]
>      327 | void output_pm_defines(void)
>          |      ^~~~~~~~~~~~~~~~~
>    arch/mips/kernel/asm-offsets.c:341:6: warning: no previous prototype for 'output_kvm_defines' [-Wmissing-prototypes]
>      341 | void output_kvm_defines(void)
>          |      ^~~~~~~~~~~~~~~~~~
>    arch/mips/kernel/asm-offsets.c:385:6: warning: no previous prototype for 'output_cps_defines' [-Wmissing-prototypes]
>      385 | void output_cps_defines(void)
>          |      ^~~~~~~~~~~~~~~~~~
> >> <stdin>:1565:2: warning: #warning syscall cachestat not implemented [-Wcpp]
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests

I need to add the new syscall to mips' syscall table
(arch/mips/kernel/syscalls/syscall_n32.tbl etc.)
