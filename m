Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179E05B4E71
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiIKLeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiIKLd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:33:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16C4356CF
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:33:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5F39B80B31
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 11:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD87C433C1;
        Sun, 11 Sep 2022 11:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662896032;
        bh=40E5jgUZpkmLz8W0NJaBZXS48w+/4s3GYagJsQ0DMcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ttapryJ+p/Cw9kYkk+y+zbRa83YdGp8OivsQgGG4FagNakdhKwthLwAZX6iDm1kkG
         IeMntRyw/3A/dtbYOUcJi3gifLnp21Ffp9ETyKPBfalreD1htZ7+jPXP3SqiCfcXuc
         xajOlwYYPycd74LvHSS1bPnXNr/3bQnJ1hq2chnFumLXUbG54iyj5liu0GP0JwPWva
         6Gyc2wNKsxGl/gxpdwUyPYHufOm83kAar28Y1mLUQrTd5LZOYXVsUM9vxiyp9ZGfW8
         qvwCn5WvsKodHfG7V19XEBzhE6//ucOYuPRNe3HnKn4/AvLlcn32GXhKOxMeClsEph
         TnzHQpwCY2fGQ==
Date:   Sun, 11 Sep 2022 04:33:50 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>, rong.a.chen@intel.com,
        philip.li@intel.com
Cc:     "Jason A. Donenfeld" <zx2c4@kernel.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: machine_kexec_file.c:undefined reference to `__tsan_memset'
Message-ID: <Yx3HnuEDyFG0+G62@dev-arch.thelio-3990X>
References: <202209111930.zTjXeajS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209111930.zTjXeajS-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Intel folks,

On Sun, Sep 11, 2022 at 07:24:28PM +0800, kernel test robot wrote:
> Hi Jason,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

Please do not report any more instances of undefined references to
__tsan_mem*() to kernel developers. It is a compiler change that causes
this, kernel changes cannot be responsible for it so it is just going to
cause unnecessary noise and concern.

A patch series to fix this is a work in progress:

https://github.com/ClangBuiltLinux/linux/issues/1704
https://lore.kernel.org/20220909073840.45349-1-elver@google.com/

Cheers,
Nathan

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b96fbd602d35739b5cdb49baa02048f2c41fdab1
> commit: b7133757da4c4c17d625970f6da3d76af12a8867 crypto: s390 - do not depend on CRYPTO_HW for SIMD implementations
> date:   9 weeks ago
> config: s390-randconfig-r044-20220909 (https://download.01.org/0day-ci/archive/20220911/202209111930.zTjXeajS-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 1546df49f5a6d09df78f569e4137ddb365a3e827)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b7133757da4c4c17d625970f6da3d76af12a8867
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout b7133757da4c4c17d625970f6da3d76af12a8867
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    s390x-linux-ld: arch/s390/kernel/dumpstack.o: in function `show_regs':
>    dumpstack.c:(.text+0x674): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/dumpstack.o: in function `die':
>    dumpstack.c:(.text+0x892): undefined reference to `__tsan_memset'
>    s390x-linux-ld: DWARF error: could not find abbrev number 1210904
>    arch/s390/kernel/guarded_storage.o: in function `__se_sys_s390_guarded_storage':
>    guarded_storage.c:(.text+0x53e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: DWARF error: could not find abbrev number 1864652
>    arch/s390/kernel/sthyi.o:sthyi.c:(.text+0xdc): more undefined references to `__tsan_memset' follow
>    s390x-linux-ld: arch/s390/kernel/sthyi.o: in function `sthyi_fill':
>    sthyi.c:(.text+0x206): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: sthyi.c:(.text+0x238): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: sthyi.c:(.text+0x2ea): undefined reference to `__tsan_memset'
>    s390x-linux-ld: sthyi.c:(.text+0xbf6): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: DWARF error: could not find abbrev number 9927
>    arch/s390/kernel/ipl_vmparm.o: in function `ipl_block_get_ascii_vmparm':
>    ipl_vmparm.c:(.text+0x6c): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: DWARF error: could not find abbrev number 95
>    arch/s390/kernel/unwind_bc.o: in function `__unwind_start':
>    unwind_bc.c:(.text+0x5e4): undefined reference to `__tsan_memset'
>    s390x-linux-ld: DWARF error: invalid or unhandled FORM value: 0x23
>    arch/s390/kernel/smp.o: in function `smp_ctl_set_clear_bit':
>    smp.c:(.text+0x15a4): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/smp.o: in function `smp_ctl_bit_callback':
>    smp.c:(.text+0x16dc): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/smp.o: in function `__cpu_up':
>    smp.c:(.text+0x2296): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: smp.c:(.text+0x22a8): undefined reference to `__tsan_memset'
>    s390x-linux-ld: smp.c:(.text+0x25aa): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/smp.o: in function `__cpu_disable':
>    smp.c:(.text+0x2a28): undefined reference to `__tsan_memset'
>    s390x-linux-ld: DWARF error: could not find abbrev number 8626
>    arch/s390/kernel/stacktrace.o: in function `arch_stack_walk':
>    stacktrace.c:(.text+0x38): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/stacktrace.o: in function `arch_stack_walk_reliable':
>    stacktrace.c:(.text+0x134): undefined reference to `__tsan_memset'
>    s390x-linux-ld: DWARF error: could not find abbrev number 73
>    arch/s390/kernel/nospec-sysfs.o: in function `cpu_show_spectre_v1':
>    nospec-sysfs.c:(.text+0x2a): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/nospec-sysfs.o: in function `cpu_show_spectre_v2':
>    nospec-sysfs.c:(.text+0x9e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: nospec-sysfs.c:(.text+0xbe): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: nospec-sysfs.c:(.text+0xde): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: DWARF error: could not find abbrev number 2692
>    arch/s390/kernel/module.o: in function `module_frob_arch_sections':
>    module.c:(.text+0x478): undefined reference to `__tsan_memset'
>    s390x-linux-ld: DWARF error: could not find abbrev number 123
>    arch/s390/kernel/kprobes.o: in function `copy_instruction':
>    kprobes.c:(.text+0x12c): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/kprobes.o: in function `arch_prepare_kprobe':
>    kprobes.c:(.text+0x5fa): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: DWARF error: could not find abbrev number 11596
>    arch/s390/kernel/ftrace.o: in function `ftrace_plt_init':
>    ftrace.c:(.init.text+0x50): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: DWARF error: could not find abbrev number 274
>    arch/s390/kernel/crash_dump.o: in function `elfcorehdr_alloc':
>    crash_dump.c:(.text+0xa4a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: crash_dump.c:(.text+0xb10): undefined reference to `__tsan_memset'
>    s390x-linux-ld: crash_dump.c:(.text+0xb9c): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.text+0xbb8): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.text+0xc80): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.text+0xc9c): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.text+0xd2a): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/crash_dump.o:crash_dump.c:(.text+0xd46): more undefined references to `__tsan_memcpy' follow
>    s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `elfcorehdr_alloc':
>    crash_dump.c:(.text+0xdb2): undefined reference to `__tsan_memset'
>    s390x-linux-ld: crash_dump.c:(.text+0xdc4): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.text+0xdd6): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.text+0xde8): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.text+0xe08): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.text+0xe7c): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.text+0xe98): undefined reference to `__tsan_memset'
>    s390x-linux-ld: crash_dump.c:(.text+0xebc): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.text+0xece): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.text+0xee0): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.text+0xef2): undefined reference to `__tsan_memset'
>    s390x-linux-ld: crash_dump.c:(.text+0xf7c): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.text+0xfb8): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.text+0x104e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.text+0x1118): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.text+0x11e2): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/crash_dump.o:crash_dump.c:(.text+0x12a8): more undefined references to `__tsan_memcpy' follow
>    s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `elfcorehdr_alloc':
>    crash_dump.c:(.text+0x15d0): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `elfcorehdr_read':
>    crash_dump.c:(.text+0x18b0): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `elfcorehdr_read_notes':
>    crash_dump.c:(.text+0x1920): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `get_vmcoreinfo_old':
>    crash_dump.c:(.text+0x197e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: crash_dump.c:(.text+0x1ade): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/crash_dump.o: in function `save_area_add_regs':
>    crash_dump.c:(.init.text+0x182): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.init.text+0x194): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.init.text+0x1a6): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.init.text+0x1b8): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: crash_dump.c:(.init.text+0x1ca): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/crash_dump.o:crash_dump.c:(.init.text+0x2ea): more undefined references to `__tsan_memcpy' follow
>    s390x-linux-ld: DWARF error: could not find abbrev number 80348352
>    arch/s390/kernel/machine_kexec_file.o: in function `kexec_file_add_components':
> >> machine_kexec_file.c:(.text+0x30): undefined reference to `__tsan_memset'
> >> s390x-linux-ld: machine_kexec_file.c:(.text+0x110): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/kernel/machine_kexec_file.o: in function `kexec_file_add_initrd':
>    machine_kexec_file.c:(.text+0x270): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/machine_kexec_file.o: in function `kexec_file_add_purgatory':
>    machine_kexec_file.c:(.text+0x3e0): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/kernel/machine_kexec_file.o: in function `kexec_file_add_ipl_report':
>    machine_kexec_file.c:(.text+0x5e0): undefined reference to `__tsan_memset'
>    s390x-linux-ld: DWARF error: could not find abbrev number 4017695074
>    arch/s390/kernel/kexec_image.o: in function `kexec_file_add_kernel_image':
> >> kexec_image.c:(.text+0x70): undefined reference to `__tsan_memset'
>    s390x-linux-ld: DWARF error: could not find abbrev number 87
>    arch/s390/kernel/kexec_elf.o: in function `kexec_file_add_kernel_elf':
> >> kexec_elf.c:(.text+0x352): undefined reference to `__tsan_memset'
>    s390x-linux-ld: DWARF error: could not find abbrev number 1885236
>    arch/s390/kernel/trace.o:trace.c:(.text+0xba): more undefined references to `__tsan_memset' follow
>    s390x-linux-ld: DWARF error: could not find abbrev number 10151
>    arch/s390/mm/extmem.o: in function `segment_type':
>    extmem.c:(.text+0x550): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/mm/extmem.o: in function `segment_load':
>    extmem.c:(.text+0x60e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: extmem.c:(.text+0x85c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: extmem.c:(.text+0xc80): undefined reference to `__tsan_memset'
>    s390x-linux-ld: extmem.c:(.text+0xfe4): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/mm/extmem.o: in function `segment_modify_shared':
>    extmem.c:(.text+0x1750): undefined reference to `__tsan_memset'
>    s390x-linux-ld: extmem.c:(.text+0x1998): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/mm/extmem.o: in function `segment_unload':
>    extmem.c:(.text+0x1d4e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: extmem.c:(.text+0x1f96): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/mm/extmem.o: in function `segment_save':
>    extmem.c:(.text+0x21ac): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/mm/extmem.o:extmem.c:(.text+0x21be): more undefined references to `__tsan_memset' follow
>    s390x-linux-ld: DWARF error: could not find abbrev number 3642308623
>    arch/s390/mm/maccess.o: in function `s390_kernel_write':
>    maccess.c:(.text+0x4e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/mm/maccess.o: in function `memcpy_absolute':
>    maccess.c:(.text+0x462): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: maccess.c:(.text+0x4ca): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/mm/maccess.o: in function `xlate_dev_mem_ptr':
>    maccess.c:(.text+0x962): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: maccess.c:(.text+0x9d2): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: DWARF error: could not find abbrev number 704951
>    arch/s390/mm/pgalloc.o: in function `page_table_free':
>    pgalloc.c:(.text+0xc3a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/mm/pgalloc.o: in function `__tlb_remove_table':
>    pgalloc.c:(.text+0x10c8): undefined reference to `__tsan_memset'
>    s390x-linux-ld: DWARF error: could not find abbrev number 12578
>    arch/s390/mm/extable.o: in function `fixup_exception':
>    extable.c:(.text+0x20e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: DWARF error: could not find abbrev number 12654
>    arch/s390/mm/dump_pagetables.o: in function `ptdump_check_wx':
>    dump_pagetables.c:(.text+0x5a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: dump_pagetables.c:(.text+0xa0): undefined reference to `__tsan_memset'
>    s390x-linux-ld: dump_pagetables.c:(.text+0xb8): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/mm/dump_pagetables.o: in function `pt_dump_init':
>    dump_pagetables.c:(.text+0x7c8): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: dump_pagetables.c:(.text+0x7f8): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: dump_pagetables.c:(.text+0x82a): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: dump_pagetables.c:(.text+0x85e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/mm/dump_pagetables.o: in function `ptdump_show':
>    dump_pagetables.c:(.text+0x96e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: dump_pagetables.c:(.text+0x9b4): undefined reference to `__tsan_memset'
>    s390x-linux-ld: DWARF error: could not find abbrev number 10066
>    arch/s390/mm/gmap.o: in function `gmap_put':
>    gmap.c:(.text+0x6a4): undefined reference to `__tsan_memset'
>    s390x-linux-ld: gmap.c:(.text+0x6b6): undefined reference to `__tsan_memset'
>    s390x-linux-ld: gmap.c:(.text+0x7d6): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/mm/gmap.o:gmap.c:(.text+0x7e8): more undefined references to `__tsan_memset' follow
>    s390x-linux-ld: DWARF error: could not find abbrev number 1066736
>    arch/s390/crypto/sha256_s390.o: in function `sha256_export':
> >> sha256_s390.c:(.text+0x140): undefined reference to `__tsan_memcpy'
> >> s390x-linux-ld: sha256_s390.c:(.text+0x152): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/crypto/sha256_s390.o: in function `sha256_import':
>    sha256_s390.c:(.text+0x1c4): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: sha256_s390.c:(.text+0x1d6): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/crypto/sha256_s390.o: in function `sha256_s390_init':
> >> sha256_s390.c:(.init.text+0x74): undefined reference to `__tsan_memset'
>    s390x-linux-ld: DWARF error: could not find abbrev number 87
>    arch/s390/crypto/sha_common.o: in function `s390_sha_update':
> >> sha_common.c:(.text+0xa6): undefined reference to `__tsan_memcpy'
> >> s390x-linux-ld: sha_common.c:(.text+0x13e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/crypto/sha_common.o: in function `s390_sha_final':
>    sha_common.c:(.text+0x28e): undefined reference to `__tsan_memcpy'
> >> s390x-linux-ld: sha_common.c:(.text+0x2a4): undefined reference to `__tsan_memset'
>    s390x-linux-ld: DWARF error: could not find abbrev number 1238827
>    arch/s390/crypto/sha3_512_s390.o: in function `sha3_512_init':
> >> sha3_512_s390.c:(.text+0x30): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/crypto/sha3_512_s390.o: in function `sha3_512_export':
> >> sha3_512_s390.c:(.text+0xc0): undefined reference to `__tsan_memcpy'
> >> s390x-linux-ld: sha3_512_s390.c:(.text+0xd2): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/crypto/sha3_512_s390.o: in function `sha3_512_import':
>    sha3_512_s390.c:(.text+0x17c): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: sha3_512_s390.c:(.text+0x18e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/crypto/sha3_512_s390.o: in function `sha3_384_init':
>    sha3_512_s390.c:(.text+0x1f0): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/crypto/sha3_512_s390.o: in function `sha3_384_import':
>    sha3_512_s390.c:(.text+0x29c): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: sha3_512_s390.c:(.text+0x2ae): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/crypto/sha3_512_s390.o: in function `init':
> >> sha3_512_s390.c:(.init.text+0x74): undefined reference to `__tsan_memset'
>    s390x-linux-ld: DWARF error: could not find abbrev number 43
>    arch/s390/crypto/crc32-vx.o: in function `crc32le_vx_update':
> >> crc32-vx.c:(.text+0xa8): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/crypto/crc32-vx.o: in function `crc32le_vx_finup':
>    crc32-vx.c:(.text+0x288): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/crypto/crc32-vx.o: in function `crc32le_vx_digest':
>    crc32-vx.c:(.text+0x424): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/crypto/crc32-vx.o: in function `crc32be_vx_update':
>    crc32-vx.c:(.text+0x658): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/crypto/crc32-vx.o: in function `crc32be_vx_finup':
>    crc32-vx.c:(.text+0x838): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/crypto/crc32-vx.o:crc32-vx.c:(.text+0x9d4): more undefined references to `__tsan_memcpy' follow
>    s390x-linux-ld: DWARF error: could not find abbrev number 1172571
>    arch/s390/crypto/arch_random.o: in function `s390_arch_get_random_long':
>    arch_random.c:(.text+0x2ce): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch_random.c:(.text+0x30c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/crypto/arch_random.o: in function `arch_rng_refill_buffer':
>    arch_random.c:(.text+0x408): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch_random.c:(.text+0x442): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/crypto/arch_random.o: in function `s390_arch_random_init':
>    arch_random.c:(.init.text+0x2c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: arch/s390/crypto/arch_random.o:arch_random.c:(.init.text+0x80): more undefined references to `__tsan_memset' follow
>    s390x-linux-ld: DWARF error: could not find abbrev number 1403790468
>    arch/s390/net/bpf_jit_comp.o: in function `bpf_int_jit_compile':
>    bpf_jit_comp.c:(.text+0x208): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: bpf_jit_comp.c:(.text+0x270): undefined reference to `__tsan_memset'
>    s390x-linux-ld: bpf_jit_comp.c:(.text+0x45e): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: arch/s390/net/bpf_jit_comp.o: in function `jit_fill_hole':
>    bpf_jit_comp.c:(.text+0x9744): undefined reference to `__tsan_memset'
>    s390x-linux-ld: DWARF error: could not find abbrev number 8135
>    kernel/fork.o: in function `trace_event_raw_event_task_newtask':
>    fork.c:(.text+0x14e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: fork.c:(.text+0x204): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/fork.o: in function `trace_event_raw_event_task_rename':
>    fork.c:(.text+0x28e): undefined reference to `__tsan_memset'
>    s390x-linux-ld: fork.c:(.text+0x344): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/fork.o: in function `vm_area_alloc':
>    fork.c:(.text+0x4b0): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/fork.o: in function `vm_area_dup':
>    fork.c:(.text+0x58a): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: fork.c:(.text+0x5a2): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: fork.c:(.text+0x5d8): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/fork.o: in function `arch_dup_task_struct':
>    fork.c:(.text+0xe40): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/fork.o: in function `mm_alloc':
>    fork.c:(.text+0xeea): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/fork.o: in function `mm_init':
>    fork.c:(.text+0xf3c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: fork.c:(.text+0x1002): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/fork.o: in function `copy_process':
>    fork.c:(.text+0x2878): undefined reference to `__tsan_memset'
>    s390x-linux-ld: fork.c:(.text+0x2994): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/fork.o:fork.c:(.text+0x2bfc): more undefined references to `__tsan_memset' follow
>    s390x-linux-ld: kernel/fork.o: in function `dup_mm':
>    fork.c:(.text+0x43c2): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: fork.c:(.text+0x4928): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: fork.c:(.text+0x4940): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: fork.c:(.text+0x497a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/fork.o: in function `create_io_thread':
>    fork.c:(.text+0x4e74): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/fork.o: in function `kernel_clone':
>    fork.c:(.text+0x4ef8): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/fork.o: in function `kernel_thread':
>    fork.c:(.text+0x54a4): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/fork.o: in function `user_mode_thread':
>    fork.c:(.text+0x5534): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/fork.o:fork.c:(.text+0x55a8): more undefined references to `__tsan_memset' follow
>    s390x-linux-ld: kernel/fork.o: in function `sysctl_max_threads':
>    fork.c:(.text+0x6068): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/fork.o: in function `dup_task_struct':
>    fork.c:(.text+0x6772): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/fork.o: in function `copy_sighand':
>    fork.c:(.text+0x6934): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/fork.o: in function `copy_signal':
>    fork.c:(.text+0x6c66): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/fork.o: in function `copy_seccomp':
>    fork.c:(.text+0x6eaa): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/fork.o: in function `copy_clone_args_from_user':
>    fork.c:(.text+0x74a4): undefined reference to `__tsan_memset'
>    s390x-linux-ld: fork.c:(.text+0x7552): undefined reference to `__tsan_memset'
>    s390x-linux-ld: fork.c:(.text+0x766a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: fork.c:(.text+0x78c0): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/fork.o: in function `fork_init':
>    fork.c:(.init.text+0x1a0): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/fork.o: in function `fork_idle':
>    fork.c:(.init.text+0x2b0): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: fork.c:(.init.text+0x316): undefined reference to `__tsan_memset'
>    s390x-linux-ld: fork.c:(.init.text+0x338): undefined reference to `__tsan_memset'
>    s390x-linux-ld: fork.c:(.init.text+0x36a): undefined reference to `__tsan_memset'
>    s390x-linux-ld: fork.c:(.init.text+0x39c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: DWARF error: could not find abbrev number 14327
>    kernel/panic.o: in function `print_tainted':
>    panic.c:(.text+0x2de): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: panic.c:(.text+0x416): undefined reference to `__tsan_memcpy'
>    s390x-linux-ld: kernel/panic.o: in function `warn_slowpath_fmt':
>    panic.c:(.text+0xbac): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/panic.o: in function `panic':
>    panic.c:(.text.unlikely.+0x2c): undefined reference to `__tsan_memset'
>    s390x-linux-ld: DWARF error: could not find abbrev number 51
>    kernel/cpu.o: in function `trace_event_raw_event_cpuhp_enter':
>    cpu.c:(.text+0x242): undefined reference to `__tsan_memset'
>    s390x-linux-ld: kernel/cpu.o: in function `trace_event_raw_event_cpuhp_multi_enter':
>    cpu.c:(.text+0x352): undefined reference to `__tsan_memset'
> ..
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
> 
