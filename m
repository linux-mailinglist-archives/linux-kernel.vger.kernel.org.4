Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A8A6ED5C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 22:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjDXUCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 16:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjDXUCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 16:02:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E719F4EDE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:01:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7543362840
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 20:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67998C433EF;
        Mon, 24 Apr 2023 20:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682366517;
        bh=6OAnvmZc+28c5ShNZbv4gzUw8fjiV+jwmwVUxdiV03E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+hoSYVlRXq6RAcX+589h9KgTN+JTf2p5NzATk8PwebCSEiIyvwJ/PziUbZw3KATO
         7Y8LsQyD8nyCC59mP1zQfOcMNhXM0O8CrK4DRSb4GBSb0r3zn+oRGi84zEnUc26fIP
         s6FXPCVWaARui/Jaygey+F7gxPYtEr4SbeyastFVj4apK3K7KFfMsZGR1EWkOouePi
         owAgY6V2SiqNAI8LERS8JGm49823vpBaPB2BsfsGFf8sJ7wjujxj0Pagka4nzbvSHP
         jARgCyfQs06oMPGVvnOaqqbXeOKe8tU3icMRQziU5G4/cqrdnbVOjMJoqTIIYO1sqy
         3ZAmDMoNuQZSQ==
Date:   Mon, 24 Apr 2023 13:01:55 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Borislav Petkov <bp@alien8.de>, kernel test robot <lkp@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: arch/mips/include/asm/timex.h:75:10: error: instruction requires
 a CPU feature not currently enabled
Message-ID: <20230424200155.GA2605117@dev-arch.thelio-3990X>
References: <202304170748.Fg9VIgGd-lkp@intel.com>
 <20230419223707.GAZEBtE1vZGy5B4EUR@fat_crate.local>
 <20230419231834.GA1269248@dev-arch.thelio-3990X>
 <C6A730FC-C7B5-4A32-92CD-98FDA632782C@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C6A730FC-C7B5-4A32-92CD-98FDA632782C@flygoat.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 12:41:50AM +0100, Jiaxun Yang wrote:
> 
> 
> > 2023年4月20日 00:18，Nathan Chancellor <nathan@kernel.org> 写道：
> > 
> > + Jiaxun, who has been looking into MIPS + LLVM issues recently and has
> > been a big help :)
> 
> I think this patch[1] may fix the problem.

I have the following patch stack:

$ git log --oneline origin/master^..
c6cd9f17692e MIPS: Replace assembly isa level directives with macros
60508ba7d92f MIPS: Limit MIPS_MT_SMP support by ISA reversion
c9e250105de4 MIPS: Fallback CPU -march CFLAG to ISA level if unsupported
49c0420e59bb MIPS: Remove cc-option checks for -march=octeon
b7ea7e959023 MIPS: Detect toolchain support of o32 ABI with 64 bit CPU
51f2d93245ba MIPS: Detect toolchain support of workarounds in Kconfig
7382a07eb105 MIPS: Add toolchain feature dependency for microMIPS smartMIPS
de0621fbedd3 MIPS: Move various toolchain ASE check to Kconfig
3b85b9b39960 Add linux-next specific files for 20230424

but with the robot's configuration, I still see that error. I notice
that the 'if (sel == 0)' branch of ___read_32bit_c0_register() has no
'.set push' directive, could that matter here?

Cheers,
Nathan

> [1]: https://patchwork.kernel.org/project/linux-mips/patch/20230411111225.55725-2-jiaxun.yang@flygoat.com/
> 
> > 
> > On Thu, Apr 20, 2023 at 12:37:07AM +0200, Borislav Petkov wrote:
> >> + Thomas.
> >> 
> >> On Mon, Apr 17, 2023 at 07:57:04AM +0800, kernel test robot wrote:
> >>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >>> head:   6a8f57ae2eb07ab39a6f0ccad60c760743051026
> >>> commit: aba5b397cad7d398b385aaf5029f99f41b690466 hamradio: baycom_epp: Do not use x86-specific rdtsc()
> >>> date:   4 months ago
> >>> config: mips-buildonly-randconfig-r001-20230417 (https://download.01.org/0day-ci/archive/20230417/202304170748.Fg9VIgGd-lkp@intel.com/config)
> >>> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 9638da200e00bd069e6dd63604e14cbafede9324)
> >> 
> >> Where do I get clang 17?
> > 
> > I think they intend for you to get it via their make.cross script but
> > this issue reproduces with clang 16.0.2 from
> > https://mirrors.edge.kernel.org/pub/tools/llvm/ for me locally.
> > 
> >> In any case, this
> >> 
> >> "error: instruction requires a CPU feature not currently enabled"
> >> 
> >> sounds like clang is trying to generate invalid code for the wrong
> >> target. .config issue?
> > 
> > I am far from a MIPS expert but this usually means that there is some
> > assembler directive that we are missing to allow access to certain
> > instructions in newer ISA versions than the one specified via '-march'.
> > I have no idea if that is the case here or not but I do see the correct
> > target flags when building with V=1, so it is not something obvious like
> > that. I can double back to this later this week or next week if nobody
> > else is able to.
> > 
> > Regardless, this seems like a pre-existing issue that was just exposed
> > by your patch, not the root cause of it.
> > 
> > Cheers,
> > Nathan
> > 
> >>> reproduce (this is a W=1 build):
> >>>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>>        chmod +x ~/bin/make.cross
> >>>        # install mips cross compiling tool for clang build
> >>>        # apt-get install binutils-mipsel-linux-gnu
> >>>        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aba5b397cad7d398b385aaf5029f99f41b690466
> >>>        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >>>        git fetch --no-tags linus master
> >>>        git checkout aba5b397cad7d398b385aaf5029f99f41b690466
> >>>        # save the config file
> >>>        mkdir build_dir && cp config build_dir/.config
> >>>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
> >>>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/hamradio/
> >>> 
> >>> If you fix the issue, kindly add following tag where applicable
> >>> | Reported-by: kernel test robot <lkp@intel.com>
> >>> | Link: https://lore.kernel.org/oe-kbuild-all/202304170748.Fg9VIgGd-lkp@intel.com/
> >>> 
> >>> All errors (new ones prefixed by >>):
> >>> 
> >>>   In file included from drivers/net/hamradio/baycom_epp.c:29:
> >>>   In file included from include/linux/module.h:13:
> >>>   In file included from include/linux/stat.h:19:
> >>>   In file included from include/linux/time.h:60:
> >>>   In file included from include/linux/time32.h:13:
> >>>   In file included from include/linux/timex.h:67:
> >>>>> arch/mips/include/asm/timex.h:75:10: error: instruction requires a CPU feature not currently enabled
> >>>                   return read_c0_count();
> >>>                          ^
> >>>   arch/mips/include/asm/mipsregs.h:1712:26: note: expanded from macro 'read_c0_count'
> >>>   #define read_c0_count()         __read_32bit_c0_register($9, 0)
> >>>                                   ^
> >>>   arch/mips/include/asm/mipsregs.h:1453:2: note: expanded from macro '__read_32bit_c0_register'
> >>>           ___read_32bit_c0_register(source, sel, __volatile__)
> >>>           ^
> >>>   arch/mips/include/asm/mipsregs.h:1419:4: note: expanded from macro '___read_32bit_c0_register'
> >>>                           "mfc0\t%0, " #source "\n\t"                     \
> >>>                           ^
> >>>   <inline asm>:1:2: note: instantiated into assembly here
> >>>           mfc0    $4, $9
> >>>           ^
> >>>   In file included from drivers/net/hamradio/baycom_epp.c:29:
> >>>   In file included from include/linux/module.h:13:
> >>>   In file included from include/linux/stat.h:19:
> >>>   In file included from include/linux/time.h:60:
> >>>   In file included from include/linux/time32.h:13:
> >>>   In file included from include/linux/timex.h:67:
> >>>>> arch/mips/include/asm/timex.h:75:10: error: instruction requires a CPU feature not currently enabled
> >>>                   return read_c0_count();
> >>>                          ^
> >>>   arch/mips/include/asm/mipsregs.h:1712:26: note: expanded from macro 'read_c0_count'
> >>>   #define read_c0_count()         __read_32bit_c0_register($9, 0)
> >>>                                   ^
> >>>   arch/mips/include/asm/mipsregs.h:1453:2: note: expanded from macro '__read_32bit_c0_register'
> >>>           ___read_32bit_c0_register(source, sel, __volatile__)
> >>>           ^
> >>>   arch/mips/include/asm/mipsregs.h:1419:4: note: expanded from macro '___read_32bit_c0_register'
> >>>                           "mfc0\t%0, " #source "\n\t"                     \
> >>>                           ^
> >>>   <inline asm>:1:2: note: instantiated into assembly here
> >>>           mfc0    $2, $9
> >>>           ^
> >>>   In file included from drivers/net/hamradio/baycom_epp.c:29:
> >>>   In file included from include/linux/module.h:13:
> >>>   In file included from include/linux/stat.h:19:
> >>>   In file included from include/linux/time.h:60:
> >>>   In file included from include/linux/time32.h:13:
> >>>   In file included from include/linux/timex.h:67:
> >>>>> arch/mips/include/asm/timex.h:75:10: error: instruction requires a CPU feature not currently enabled
> >>>                   return read_c0_count();
> >>>                          ^
> >>>   arch/mips/include/asm/mipsregs.h:1712:26: note: expanded from macro 'read_c0_count'
> >>>   #define read_c0_count()         __read_32bit_c0_register($9, 0)
> >>>                                   ^
> >>>   arch/mips/include/asm/mipsregs.h:1453:2: note: expanded from macro '__read_32bit_c0_register'
> >>>           ___read_32bit_c0_register(source, sel, __volatile__)
> >>>           ^
> >>>   arch/mips/include/asm/mipsregs.h:1419:4: note: expanded from macro '___read_32bit_c0_register'
> >>>                           "mfc0\t%0, " #source "\n\t"                     \
> >>>                           ^
> >>>   <inline asm>:1:2: note: instantiated into assembly here
> >>>           mfc0    $2, $9
> >>>           ^
> >>>   In file included from drivers/net/hamradio/baycom_epp.c:29:
> >>>   In file included from include/linux/module.h:13:
> >>>   In file included from include/linux/stat.h:19:
> >>>   In file included from include/linux/time.h:60:
> >>>   In file included from include/linux/time32.h:13:
> >>>   In file included from include/linux/timex.h:67:
> >>>>> arch/mips/include/asm/timex.h:75:10: error: instruction requires a CPU feature not currently enabled
> >>>                   return read_c0_count();
> >>>                          ^
> >>>   arch/mips/include/asm/mipsregs.h:1712:26: note: expanded from macro 'read_c0_count'
> >>>   #define read_c0_count()         __read_32bit_c0_register($9, 0)
> >>>                                   ^
> >>>   arch/mips/include/asm/mipsregs.h:1453:2: note: expanded from macro '__read_32bit_c0_register'
> >>>           ___read_32bit_c0_register(source, sel, __volatile__)
> >>>           ^
> >>>   arch/mips/include/asm/mipsregs.h:1419:4: note: expanded from macro '___read_32bit_c0_register'
> >>>                           "mfc0\t%0, " #source "\n\t"                     \
> >>>                           ^
> >>>   <inline asm>:1:2: note: instantiated into assembly here
> >>>           mfc0    $2, $9
> >>>           ^
> >>>   4 errors generated.
> >>> 
> >>> 
> >>> vim +75 arch/mips/include/asm/timex.h
> >>> 
> >>> 9c9b415c50bc29 Ralf Baechle       2013-09-12  71  
> >>> 06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  72  static inline cycles_t get_cycles(void)
> >>> 06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  73  {
> >>> 06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  74   if (can_use_mips_counter(read_c0_prid()))
> >>> 9c9b415c50bc29 Ralf Baechle       2013-09-12 @75   return read_c0_count();
> >>> 06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  76   else
> >>> 06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  77   return 0; /* no usable counter */
> >>> 9c9b415c50bc29 Ralf Baechle       2013-09-12  78  }
> >>> 1c99c6a7c3c599 Jason A. Donenfeld 2022-04-08  79  #define get_cycles get_cycles
> >>> 9c9b415c50bc29 Ralf Baechle       2013-09-12  80  
> >>> 
> >>> :::::: The code at line 75 was first introduced by commit
> >>> :::::: 9c9b415c50bc298ac61412dff856eae2f54889ee MIPS: Reimplement get_cycles().
> >>> 
> >>> :::::: TO: Ralf Baechle <ralf@linux-mips.org>
> >>> :::::: CC: Ralf Baechle <ralf@linux-mips.org>
> >>> 
> >>> -- 
> >>> 0-DAY CI Kernel Test Service
> >>> https://github.com/intel/lkp-tests
> >> 
> >> -- 
> >> Regards/Gruss,
> >>    Boris.
> >> 
> >> https://people.kernel.org/tglx/notes-about-netiquette
> 
