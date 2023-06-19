Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28D4735F35
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 23:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjFSV02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 17:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFSV01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 17:26:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90915E5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 14:26:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b4fef08cfdso18826085ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 14:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687209985; x=1689801985;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0F/HmPYrX2+2YXjhicna2U9ZXZVghOWwV5+8A0s6ZuM=;
        b=oXWJFMrLryRiRcluWQ0ExLJUaukON7mv7BNPPv/Xp426GKqT2t0kdEK8NR1TMrvMd1
         Pdiw//+MthS3dl2hx07aMzM9qbrsXkjS5gniypxOlxjnaje9uV8YC5bRxYLmABgVDv0k
         /la8eBBD6jHW2nVJgcb1qxDxjfUPiHodRKYoCnxG/3SH9vl+Nc7L2zroggSi1qt8A5zy
         P6uKY5IQcRFRMI6sST8vyr4FZMlrjkKWabNYdVPIP4mCQ2fn+JB+bjIi6lx1feSJ1lqs
         x6yPK+WAe8/ia4B5ZDJg3/0TA5yoHsxRmA4cDswU/0GpKrJ2sQTXWM9InZeJOYw+N40A
         QF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687209985; x=1689801985;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0F/HmPYrX2+2YXjhicna2U9ZXZVghOWwV5+8A0s6ZuM=;
        b=OiygRFCeGEHlY3kzM6y+ZtbJLwCSU6vs8ySD6dJN9thBbl590eVj2pp6Fnqq31unze
         c21jFdmigFjdymVIkaJ8y+Xk+fxoBhnLWq5I6wR1J3l83zR+CZblgb19tddfEd1Z/a+6
         68oVqQUHEaqny23nPMcklqH9/GkJtU0z3JCFXiHlMNseZ4KaReN37FQ8MXcKo1XqQ7W2
         4YeCuagSzbpKJToMgz9h6VWToQb0JrbcABcQaOZ514CpRSZD/9x1czV0TEGaEGRjm6qT
         nW95q4fxkBk5BAgbNrEtv9MO9LciPNMwvm5I44WY1EG05TCXik/h/v7sXBXwrfOLXrsD
         T3RA==
X-Gm-Message-State: AC+VfDwa3Sqk3eVsWum77hyPvcpKJ+0asynX9MaqKcxIRaqKFPs12MYh
        yWcumInQsVwokFco0cUDl7QzlKSc6oXWEkKN7ZE=
X-Google-Smtp-Source: ACHHUZ5nrTxKbGcep4MMwAasKKXH7oF6DEVGKf3/Wh7QTJ3SnsRwMA3iCd5tLojnKjaVjo1s2UhcmQ==
X-Received: by 2002:a17:902:f688:b0:1b4:5699:aab8 with SMTP id l8-20020a170902f68800b001b45699aab8mr6984381plg.29.1687209984924;
        Mon, 19 Jun 2023 14:26:24 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id z8-20020a1709027e8800b001b5620c2c59sm266765pla.159.2023.06.19.14.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 14:26:24 -0700 (PDT)
Date:   Mon, 19 Jun 2023 14:26:24 -0700 (PDT)
X-Google-Original-Date: Mon, 19 Jun 2023 14:26:19 PDT (-0700)
Subject:     Re: ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol 'misaligned_access_speed'; recompile with -fPIC
In-Reply-To: <CAKwvOd=yg5GE8eF5bFY4t2S-0Od3smH9iRB+2Ctkg=+WXM97ig@mail.gmail.com>
CC:     alexghiti@rivosinc.com, lkp@intel.com, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     ndesaulniers@google.com
Message-ID: <mhng-5f0a04c3-5e31-49a6-9366-c8817396becb@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 09:40:28 PDT (-0700), ndesaulniers@google.com wrote:
> On Tue, Jun 13, 2023 at 4:17 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>>
>> On Sun, Jun 11, 2023 at 2:11 AM kernel test robot <lkp@intel.com> wrote:
>> >
>> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> > head:   022ce8862dff83c859089cd14bc4dca0733e2f90
>> > commit: 8dc2a7e8027fbeca0c7df81d4c82e735a59b5741 riscv: Fix relocatable kernels with early alternatives using -fno-pie
>> > date:   10 days ago
>> > config: riscv-randconfig-r022-20230611 (https://download.01.org/0day-ci/archive/20230611/202306110855.7TlBCIzI-lkp@intel.com/config)
>> > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
>> > reproduce (this is a W=1 build):
>> >         mkdir -p ~/bin
>> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>> >         chmod +x ~/bin/make.cross
>> >         # install riscv cross compiling tool for clang build
>> >         # apt-get install binutils-riscv64-linux-gnu
>> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8dc2a7e8027fbeca0c7df81d4c82e735a59b5741
>> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> >         git fetch --no-tags linus master
>> >         git checkout 8dc2a7e8027fbeca0c7df81d4c82e735a59b5741
>> >         # save the config file
>> >         mkdir build_dir && cp config build_dir/.config
>> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
>> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash
>> >
>> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> > the same patch/commit), kindly add following tags
>> > | Reported-by: kernel test robot <lkp@intel.com>
>> > | Closes: https://lore.kernel.org/oe-kbuild-all/202306110855.7TlBCIzI-lkp@intel.com/
>> >
>> > All errors (new ones prefixed by >>):
>> >
>> > >> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol 'misaligned_access_speed'; recompile with -fPIC
>> >    >>> defined in vmlinux.a(arch/riscv/kernel/cpufeature.o)
>> >    >>> referenced by errata.c:42 (arch/riscv/errata/thead/errata.c:42)
>> >    >>>               arch/riscv/errata/thead/errata.o:(thead_feature_probe_func) in archive vmlinux.a
>> > --
>> > >> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol 'misaligned_access_speed'; recompile with -fPIC
>> >    >>> defined in vmlinux.a(arch/riscv/kernel/cpufeature.o)
>> >    >>> referenced by errata.c:42 (arch/riscv/errata/thead/errata.c:42)
>> >    >>>               arch/riscv/errata/thead/errata.o:(thead_feature_probe_func) in archive vmlinux.a
>> > --
>> > >> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol 'riscv_cbom_block_size'; recompile with -fPIC
>> >    >>> defined in vmlinux.a(arch/riscv/mm/cacheflush.o)
>> >    >>> referenced by errata.c:42 (arch/riscv/errata/thead/errata.c:42)
>> >    >>>               arch/riscv/errata/thead/errata.o:(thead_errata_patch_func) in archive vmlinux.a
>> > --
>> > >> ld.lld: error: relocation R_RISCV_LO12_S cannot be used against symbol 'riscv_cbom_block_size'; recompile with -fPIC
>> >    >>> defined in vmlinux.a(arch/riscv/mm/cacheflush.o)
>> >    >>> referenced by errata.c:42 (arch/riscv/errata/thead/errata.c:42)
>> >    >>>               arch/riscv/errata/thead/errata.o:(thead_errata_patch_func) in archive vmlinux.a
>> > --
>> > >> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol '__per_cpu_offset'; recompile with -fPIC
>> >    >>> defined in vmlinux.a(mm/percpu.o)
>> >    >>> referenced by errata.c:42 (arch/riscv/errata/thead/errata.c:42)
>> >    >>>               arch/riscv/errata/thead/errata.o:(thead_feature_probe_func) in archive vmlinux.a
>> > --
>> > >> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol '__per_cpu_offset'; recompile with -fPIC
>> >    >>> defined in vmlinux.a(mm/percpu.o)
>> >    >>> referenced by errata.c:42 (arch/riscv/errata/thead/errata.c:42)
>> >    >>>               arch/riscv/errata/thead/errata.o:(thead_feature_probe_func) in archive vmlinux.a
>> >
>>
>> So I looked into those errors, the config is basically = RELOCATABLE +
>> MEDLOW - EARLY_ALTERNATIVES. Then errata/thead is not compiled as
>
> Thanks for taking a look.  Shouldn't CONFIG_RELOCATABLE be setting
> -fPIC? If so, why is LLD complaining about -fPIC not being used?
>
> arch/riscv/Makefile sets -fPIE if CONFIG_RELOCATABLE == y.
>
> Is it possible that -fpie was dropped for these object files, or
> -fno-pic or -fno-pie was added to the cflags for these object files
> somehow?
>
> I've filed
> https://github.com/ClangBuiltLinux/linux/issues/1872
> to track this.

Using R_RISCV_{HI20,LO12_I,LO12_S} to refer to non-absolute symbols in a 
PIE shouldn't be allowed, it's not going to produce the right answer at 
runtime.

We've got a lot of complicated bits in the build scripts so it's worth 
checking to make sure that `-fPIE` actually manifests in the link step.  
If it is and GNU LD isn't complaining then I think we've likely got a 
linker bug.

>> medany, which makes sense since we only need this code to be medany
>> when EARLY_ALTERNATIVES is enabled (because the code would be executed
>> with mmu off, which is not the case here).
>>
>> I can fix those errors by adding the medany flag, but I'm not sure
>> actually we want to do that since we do not need it and gcc does not
>> complain: any idea?
>>
>> Alex
>>
>>
>>
>> > --
>> > 0-DAY CI Kernel Test Service
>> > https://github.com/intel/lkp-tests/wiki
>>
>
>
> -- 
> Thanks,
> ~Nick Desaulniers
