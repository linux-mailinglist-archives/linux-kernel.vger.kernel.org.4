Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE6D6F0A33
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244051AbjD0QsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243777AbjD0QsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:48:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4BFE53
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:48:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A69E6119E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC8DC433EF;
        Thu, 27 Apr 2023 16:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682614086;
        bh=Fjhg5vXcihi/WrXqdSfid0cuDkGzLDHodDK58m4OXgw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dgkwh4oHexvnoBpiKn/k7Jc8dkEYdg8k8ng5LXhX++sbK37YAVJ4Oo2NG/wKFwarB
         oiJvuGWUeIKO8u7I0oq1V28VObNvcyYU9bL3G+YrSgo/EfPDBXpljT5neDRJIJ5Cqk
         PGYOXRvCQdJk2xqP0Ncms5y5gCUKNHf7f3a+x/mtmcWO4iqL3qeu3aSTyox8Db90uH
         dZS86fYYWh91nyTSW+bDryDKPBaPnHgV16HO/SWCARl6aZdHkizBXi68V56s92kKkb
         8bfl3PDzEvLcRBY5cKSWzF3meOZnxX2h3+zRpS0CgoFT/ogLfDZTzCHRxsJ2Vwm/Q1
         nFeFiiibM4sjg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 60B3A15405AD; Thu, 27 Apr 2023 09:48:06 -0700 (PDT)
Date:   Thu, 27 Apr 2023 09:48:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2023.04.26a] BUILD REGRESSION
 56b38a90a12f76e463a7381d8cff854926fa2b59
Message-ID: <53c2f720-8489-49a2-bb23-f61424adc910@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230427162805.KbWyR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427162805.KbWyR%lkp@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 12:28:05AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.04.26a
> branch HEAD: 56b38a90a12f76e463a7381d8cff854926fa2b59  rcu-tasks: Stop rcu_tasks_invoke_cbs() from using never-onlined CPUs
> 
> Error/Warning reports:
> 
> https://lore.kernel.org/oe-kbuild-all/202304271412.cbmTIpbf-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202304271416.DjRKPeoJ-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202304271446.dk8ruOnO-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202304271448.5uG6ip4V-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202304271836.Rr0pBtSE-lkp@intel.com
> 
> Error/Warning: (recently discovered and may have been fixed)
> 
> arch/arm/kernel/smp.c:385:1: warning: function declared 'noreturn' should not return [-Winvalid-noreturn]
> arch/loongarch/kernel/process.c:68:1: warning: 'noreturn' function does return
> arch/powerpc/kernel/smp.c:1768:1: error: function declared 'noreturn' should not return [-Werror,-Winvalid-noreturn]
> arch/x86/kernel/nmi.c:441:6: warning: no previous prototype for 'set_nmi_torture' [-Wmissing-prototypes]
> arch/x86/kernel/nmi.c:441:6: warning: no previous prototype for function 'set_nmi_torture' [-Wmissing-prototypes]

These appear to be from some other commits, some of which are admittedly
my debug commits.

> Unverified Error/Warning (likely false positive, please contact us if interested):
> 
> kernel/rcu/tree.c:2149 rcu_do_batch() error: uninitialized symbol 'jlimit'.

This is a false positive, as discussed recently with Dan Carpenter:

https://lore.kernel.org/all/90f95e84-842c-4273-90a3-93afd5353fd2@kili.mountain/

							Thanx, Paul

> Error/Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> |-- i386-randconfig-a001
> |   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
> |-- i386-randconfig-c001
> |   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
> |-- i386-randconfig-m021
> |   |-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
> |   `-- kernel-rcu-tree.c-rcu_do_batch()-error:uninitialized-symbol-jlimit-.
> |-- loongarch-randconfig-r012-20230427
> |   `-- arch-loongarch-kernel-process.c:warning:noreturn-function-does-return
> |-- x86_64-kexec
> |   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
> |-- x86_64-randconfig-a011
> |   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
> |-- x86_64-randconfig-a013
> |   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
> |-- x86_64-randconfig-a015
> |   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
> |-- x86_64-randconfig-c002
> |   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
> `-- x86_64-randconfig-m001
>     `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-set_nmi_torture
> clang_recent_errors
> |-- arm-milbeaut_m10v_defconfig
> |   `-- arch-arm-kernel-smp.c:warning:function-declared-noreturn-should-not-return
> |-- i386-allnoconfig
> |   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-function-set_nmi_torture
> |-- powerpc-buildonly-randconfig-r003-20230427
> |   `-- arch-powerpc-kernel-smp.c:error:function-declared-noreturn-should-not-return-Werror-Winvalid-noreturn
> |-- x86_64-randconfig-a005
> |   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-function-set_nmi_torture
> |-- x86_64-randconfig-a014
> |   `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-function-set_nmi_torture
> `-- x86_64-randconfig-a016
>     `-- arch-x86-kernel-nmi.c:warning:no-previous-prototype-for-function-set_nmi_torture
> 
> elapsed time: 723m
> 
> configs tested: 109
> configs skipped: 9
> 
> tested configs:
> alpha                            allyesconfig   gcc  
> alpha                               defconfig   gcc  
> arc                              allyesconfig   gcc  
> arc                          axs101_defconfig   gcc  
> arc                                 defconfig   gcc  
> arc                  randconfig-r002-20230427   gcc  
> arc                  randconfig-r043-20230427   gcc  
> arc                        vdk_hs38_defconfig   gcc  
> arm                              allmodconfig   gcc  
> arm                              allyesconfig   gcc  
> arm          buildonly-randconfig-r006-20230427   gcc  
> arm                                 defconfig   gcc  
> arm                           imxrt_defconfig   gcc  
> arm                   milbeaut_m10v_defconfig   clang
> arm                       netwinder_defconfig   clang
> arm                  randconfig-r011-20230427   gcc  
> arm                  randconfig-r046-20230427   gcc  
> arm64                            allyesconfig   gcc  
> arm64                               defconfig   gcc  
> csky                                defconfig   gcc  
> csky                 randconfig-r015-20230427   gcc  
> hexagon      buildonly-randconfig-r003-20230427   clang
> hexagon              randconfig-r003-20230427   clang
> hexagon              randconfig-r004-20230427   clang
> hexagon              randconfig-r041-20230427   clang
> hexagon              randconfig-r045-20230427   clang
> i386                              allnoconfig   clang
> i386                             allyesconfig   gcc  
> i386                              debian-10.3   gcc  
> i386                                defconfig   gcc  
> i386                          randconfig-a001   gcc  
> i386                          randconfig-a002   clang
> i386                          randconfig-a003   gcc  
> i386                          randconfig-a004   clang
> i386                          randconfig-a005   gcc  
> i386                          randconfig-a006   clang
> i386                          randconfig-a011   clang
> i386                          randconfig-a012   gcc  
> i386                          randconfig-a013   clang
> i386                          randconfig-a014   gcc  
> i386                          randconfig-a015   clang
> i386                          randconfig-a016   gcc  
> ia64                             allmodconfig   gcc  
> ia64         buildonly-randconfig-r004-20230427   gcc  
> ia64                                defconfig   gcc  
> loongarch                        allmodconfig   gcc  
> loongarch                         allnoconfig   gcc  
> loongarch                           defconfig   gcc  
> loongarch            randconfig-r013-20230427   gcc  
> loongarch            randconfig-r016-20230427   gcc  
> loongarch            randconfig-r025-20230427   gcc  
> m68k                             allmodconfig   gcc  
> m68k                                defconfig   gcc  
> microblaze   buildonly-randconfig-r005-20230427   gcc  
> microblaze           randconfig-r001-20230427   gcc  
> microblaze           randconfig-r012-20230427   gcc  
> mips                             allmodconfig   gcc  
> mips                             allyesconfig   gcc  
> nios2                               defconfig   gcc  
> nios2                randconfig-r034-20230427   gcc  
> nios2                randconfig-r036-20230427   gcc  
> parisc                              defconfig   gcc  
> parisc               randconfig-r024-20230427   gcc  
> parisc64                            defconfig   gcc  
> powerpc                          allmodconfig   gcc  
> powerpc                           allnoconfig   gcc  
> powerpc                 mpc834x_itx_defconfig   gcc  
> powerpc                 mpc836x_rdk_defconfig   clang
> powerpc              randconfig-r026-20230427   clang
> powerpc                     redwood_defconfig   gcc  
> riscv                            allmodconfig   gcc  
> riscv                             allnoconfig   gcc  
> riscv                               defconfig   gcc  
> riscv                randconfig-r021-20230427   clang
> riscv                randconfig-r022-20230427   clang
> riscv                randconfig-r042-20230427   clang
> riscv                          rv32_defconfig   gcc  
> s390                             allmodconfig   gcc  
> s390                             allyesconfig   gcc  
> s390                                defconfig   gcc  
> s390                 randconfig-r006-20230427   gcc  
> s390                 randconfig-r044-20230427   clang
> sh                               allmodconfig   gcc  
> sh                          landisk_defconfig   gcc  
> sh                   secureedge5410_defconfig   gcc  
> sparc        buildonly-randconfig-r002-20230427   gcc  
> sparc                               defconfig   gcc  
> sparc                randconfig-r005-20230427   gcc  
> um                                  defconfig   gcc  
> um                             i386_defconfig   gcc  
> um                           x86_64_defconfig   gcc  
> x86_64                            allnoconfig   gcc  
> x86_64                           allyesconfig   gcc  
> x86_64                              defconfig   gcc  
> x86_64                                  kexec   gcc  
> x86_64                        randconfig-a001   clang
> x86_64                        randconfig-a002   gcc  
> x86_64                        randconfig-a003   clang
> x86_64                        randconfig-a004   gcc  
> x86_64                        randconfig-a005   clang
> x86_64                        randconfig-a006   gcc  
> x86_64                        randconfig-a011   gcc  
> x86_64                        randconfig-a012   clang
> x86_64                        randconfig-a013   gcc  
> x86_64                        randconfig-a014   clang
> x86_64                        randconfig-a015   gcc  
> x86_64                        randconfig-a016   clang
> x86_64                               rhel-8.3   gcc  
> xtensa               randconfig-r033-20230427   gcc  
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
