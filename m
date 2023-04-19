Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EACD6E8510
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjDSWjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjDSWi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:38:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D842D67
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:38:19 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB4621EC0441;
        Thu, 20 Apr 2023 00:37:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681943832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=e2nxhtM7sdVgJkzeRNHHbRxRGhYfRsAKbHTG5fXaiKo=;
        b=b0gnktga5O8oFwmeE8fK4bFfjt3JNydK9X+gQnTky9WjYRrrB+WgX4jRq1UdkbdCMuS4OL
        IH1V3EyR/GgEsP8mDdOqKcXnpRW/ZddQ+Dp6x7r0TAxDDX9y/AR6U5fupQXizslz6k44oQ
        4q+sS4M7f+PCXfpBUxOQ3l7KOh81C6k=
Date:   Thu, 20 Apr 2023 00:37:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: arch/mips/include/asm/timex.h:75:10: error: instruction requires
 a CPU feature not currently enabled
Message-ID: <20230419223707.GAZEBtE1vZGy5B4EUR@fat_crate.local>
References: <202304170748.Fg9VIgGd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202304170748.Fg9VIgGd-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Thomas.

On Mon, Apr 17, 2023 at 07:57:04AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   6a8f57ae2eb07ab39a6f0ccad60c760743051026
> commit: aba5b397cad7d398b385aaf5029f99f41b690466 hamradio: baycom_epp: Do not use x86-specific rdtsc()
> date:   4 months ago
> config: mips-buildonly-randconfig-r001-20230417 (https://download.01.org/0day-ci/archive/20230417/202304170748.Fg9VIgGd-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 9638da200e00bd069e6dd63604e14cbafede9324)

Where do I get clang 17?

In any case, this

"error: instruction requires a CPU feature not currently enabled"

sounds like clang is trying to generate invalid code for the wrong
target. .config issue?

> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mipsel-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aba5b397cad7d398b385aaf5029f99f41b690466
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout aba5b397cad7d398b385aaf5029f99f41b690466
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/hamradio/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202304170748.Fg9VIgGd-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/net/hamradio/baycom_epp.c:29:
>    In file included from include/linux/module.h:13:
>    In file included from include/linux/stat.h:19:
>    In file included from include/linux/time.h:60:
>    In file included from include/linux/time32.h:13:
>    In file included from include/linux/timex.h:67:
> >> arch/mips/include/asm/timex.h:75:10: error: instruction requires a CPU feature not currently enabled
>                    return read_c0_count();
>                           ^
>    arch/mips/include/asm/mipsregs.h:1712:26: note: expanded from macro 'read_c0_count'
>    #define read_c0_count()         __read_32bit_c0_register($9, 0)
>                                    ^
>    arch/mips/include/asm/mipsregs.h:1453:2: note: expanded from macro '__read_32bit_c0_register'
>            ___read_32bit_c0_register(source, sel, __volatile__)
>            ^
>    arch/mips/include/asm/mipsregs.h:1419:4: note: expanded from macro '___read_32bit_c0_register'
>                            "mfc0\t%0, " #source "\n\t"                     \
>                            ^
>    <inline asm>:1:2: note: instantiated into assembly here
>            mfc0    $4, $9
>            ^
>    In file included from drivers/net/hamradio/baycom_epp.c:29:
>    In file included from include/linux/module.h:13:
>    In file included from include/linux/stat.h:19:
>    In file included from include/linux/time.h:60:
>    In file included from include/linux/time32.h:13:
>    In file included from include/linux/timex.h:67:
> >> arch/mips/include/asm/timex.h:75:10: error: instruction requires a CPU feature not currently enabled
>                    return read_c0_count();
>                           ^
>    arch/mips/include/asm/mipsregs.h:1712:26: note: expanded from macro 'read_c0_count'
>    #define read_c0_count()         __read_32bit_c0_register($9, 0)
>                                    ^
>    arch/mips/include/asm/mipsregs.h:1453:2: note: expanded from macro '__read_32bit_c0_register'
>            ___read_32bit_c0_register(source, sel, __volatile__)
>            ^
>    arch/mips/include/asm/mipsregs.h:1419:4: note: expanded from macro '___read_32bit_c0_register'
>                            "mfc0\t%0, " #source "\n\t"                     \
>                            ^
>    <inline asm>:1:2: note: instantiated into assembly here
>            mfc0    $2, $9
>            ^
>    In file included from drivers/net/hamradio/baycom_epp.c:29:
>    In file included from include/linux/module.h:13:
>    In file included from include/linux/stat.h:19:
>    In file included from include/linux/time.h:60:
>    In file included from include/linux/time32.h:13:
>    In file included from include/linux/timex.h:67:
> >> arch/mips/include/asm/timex.h:75:10: error: instruction requires a CPU feature not currently enabled
>                    return read_c0_count();
>                           ^
>    arch/mips/include/asm/mipsregs.h:1712:26: note: expanded from macro 'read_c0_count'
>    #define read_c0_count()         __read_32bit_c0_register($9, 0)
>                                    ^
>    arch/mips/include/asm/mipsregs.h:1453:2: note: expanded from macro '__read_32bit_c0_register'
>            ___read_32bit_c0_register(source, sel, __volatile__)
>            ^
>    arch/mips/include/asm/mipsregs.h:1419:4: note: expanded from macro '___read_32bit_c0_register'
>                            "mfc0\t%0, " #source "\n\t"                     \
>                            ^
>    <inline asm>:1:2: note: instantiated into assembly here
>            mfc0    $2, $9
>            ^
>    In file included from drivers/net/hamradio/baycom_epp.c:29:
>    In file included from include/linux/module.h:13:
>    In file included from include/linux/stat.h:19:
>    In file included from include/linux/time.h:60:
>    In file included from include/linux/time32.h:13:
>    In file included from include/linux/timex.h:67:
> >> arch/mips/include/asm/timex.h:75:10: error: instruction requires a CPU feature not currently enabled
>                    return read_c0_count();
>                           ^
>    arch/mips/include/asm/mipsregs.h:1712:26: note: expanded from macro 'read_c0_count'
>    #define read_c0_count()         __read_32bit_c0_register($9, 0)
>                                    ^
>    arch/mips/include/asm/mipsregs.h:1453:2: note: expanded from macro '__read_32bit_c0_register'
>            ___read_32bit_c0_register(source, sel, __volatile__)
>            ^
>    arch/mips/include/asm/mipsregs.h:1419:4: note: expanded from macro '___read_32bit_c0_register'
>                            "mfc0\t%0, " #source "\n\t"                     \
>                            ^
>    <inline asm>:1:2: note: instantiated into assembly here
>            mfc0    $2, $9
>            ^
>    4 errors generated.
> 
> 
> vim +75 arch/mips/include/asm/timex.h
> 
> 9c9b415c50bc29 Ralf Baechle       2013-09-12  71  
> 06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  72  static inline cycles_t get_cycles(void)
> 06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  73  {
> 06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  74  	if (can_use_mips_counter(read_c0_prid()))
> 9c9b415c50bc29 Ralf Baechle       2013-09-12 @75  		return read_c0_count();
> 06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  76  	else
> 06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  77  		return 0;	/* no usable counter */
> 9c9b415c50bc29 Ralf Baechle       2013-09-12  78  }
> 1c99c6a7c3c599 Jason A. Donenfeld 2022-04-08  79  #define get_cycles get_cycles
> 9c9b415c50bc29 Ralf Baechle       2013-09-12  80  
> 
> :::::: The code at line 75 was first introduced by commit
> :::::: 9c9b415c50bc298ac61412dff856eae2f54889ee MIPS: Reimplement get_cycles().
> 
> :::::: TO: Ralf Baechle <ralf@linux-mips.org>
> :::::: CC: Ralf Baechle <ralf@linux-mips.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
