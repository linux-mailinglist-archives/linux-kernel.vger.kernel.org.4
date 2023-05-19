Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C01D708E28
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 05:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjESDL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 23:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjESDL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 23:11:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627EB19B
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 20:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684465884; x=1716001884;
  h=date:from:to:cc:subject:message-id;
  bh=j9zvseqXnVvuNvrtpOOJpqtlYm0UYmg1riVhP1Xm198=;
  b=l8FZz7nXjA9l6xnok+hggopOFNy65SI94Q+ZlNMiOV9NzooVG9bHblp5
   MzdYhObg/+6QQTsL76rjFCNvJXTPXzpuOLw11RKvpFYb0xncJeK/pTA4B
   RQXrS0UumI0toCr8f/u4YbWF3X8PaAH1f8kqHOedb598rXkwIftO1hQHg
   FEEMHzQWBN6GeJ5RrZRdIordkI91dibOfG1eT8yzbAjDq7PWjLjLVWl9n
   jVRN/LSojx8Y12vpinb3Zh/ctMsKZ3Hsv1DI6zSO2mxVXZq41KI7jI8VH
   mCXx/74nhhGvChmRQcxY+zMYNU1JeQL8PWCV/MiRnAr7EGAZdhsbBbkZO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="336857129"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="336857129"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 20:10:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="702372697"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="702372697"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 May 2023 20:10:56 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pzqW8-000AY2-0x;
        Fri, 19 May 2023 03:10:56 +0000
Date:   Fri, 19 May 2023 11:10:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD REGRESSION
 9bb839a83e1bbbfd4f7f20827aafd0a39fad00c7
Message-ID: <20230519031023.9N09H%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230517200055/lkp-src/repo/*/paulmck-rcu
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 9bb839a83e1bbbfd4f7f20827aafd0a39fad00c7  rcuscale: Measure grace-period kthread CPU time

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202305190202.SIUCU7Ko-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202305190259.Rm6JC6Nz-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

kernel/rcu/rcuscale.c:340:20: error: incompatible function pointer types initializing 'struct task_struct *(*)(void)' with an expression of type 'void (void)' [-Werror,-Wincompatible-function-pointer-types]
kernel/rcu/rcuscale.c:340:20: error: use of undeclared identifier 'get_rcu_tasks_trace_gp_kthread'; did you mean 'show_rcu_tasks_trace_gp_kthread'?
kernel/rcu/rcuscale.c:340:27: error: 'get_rcu_tasks_trace_gp_kthread' undeclared here (not in a function); did you mean 'show_rcu_tasks_trace_gp_kthread'?

Unverified Error/Warning (likely false positive, please contact us if interested):

kernel/scftorture.c:437 scftorture_invoke_one() warn: possible memory leak of 'scfcp'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- csky-randconfig-c032-20230517
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- csky-randconfig-r021-20230517
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a001
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a003
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a005
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a012
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a014
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a016
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- i386-randconfig-c001
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- i386-randconfig-c021
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- i386-randconfig-m021
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- ia64-allmodconfig
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- loongarch-allmodconfig
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- loongarch-randconfig-r011-20230517
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- m68k-allmodconfig
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- microblaze-randconfig-m031-20230517
|   `-- kernel-scftorture.c-scftorture_invoke_one()-warn:possible-memory-leak-of-scfcp
|-- mips-allmodconfig
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- powerpc-allmodconfig
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- powerpc-randconfig-s043-20230517
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- riscv-allmodconfig
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- s390-allmodconfig
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- sh-allmodconfig
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-a002
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-a004
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-a006
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-a011
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-a013
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-a015
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-c002
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-c022
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-m001
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-s021
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-s022
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-s023
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-x051
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-x053
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-x055
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-x061
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- x86_64-randconfig-x063
|   `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
`-- x86_64-randconfig-x065
    `-- kernel-rcu-rcuscale.c:error:get_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
clang_recent_errors
|-- i386-randconfig-a002
|   |-- kernel-rcu-rcuscale.c:error:incompatible-function-pointer-types-initializing-struct-task_struct-(-)(void)-with-an-expression-of-type-void-(void)-Werror-Wincompatible-function-pointer-types
|   `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread
|-- i386-randconfig-a004
|   |-- kernel-rcu-rcuscale.c:error:incompatible-function-pointer-types-initializing-struct-task_struct-(-)(void)-with-an-expression-of-type-void-(void)-Werror-Wincompatible-function-pointer-types
|   `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread
|-- i386-randconfig-a006
|   |-- kernel-rcu-rcuscale.c:error:incompatible-function-pointer-types-initializing-struct-task_struct-(-)(void)-with-an-expression-of-type-void-(void)-Werror-Wincompatible-function-pointer-types
|   `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread
|-- i386-randconfig-a011
|   |-- kernel-rcu-rcuscale.c:error:incompatible-function-pointer-types-initializing-struct-task_struct-(-)(void)-with-an-expression-of-type-void-(void)-Werror-Wincompatible-function-pointer-types
|   `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread
|-- i386-randconfig-a013
|   |-- kernel-rcu-rcuscale.c:error:incompatible-function-pointer-types-initializing-struct-task_struct-(-)(void)-with-an-expression-of-type-void-(void)-Werror-Wincompatible-function-pointer-types
|   `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread
|-- i386-randconfig-a015
|   |-- kernel-rcu-rcuscale.c:error:incompatible-function-pointer-types-initializing-struct-task_struct-(-)(void)-with-an-expression-of-type-void-(void)-Werror-Wincompatible-function-pointer-types
|   `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread
|-- riscv-randconfig-r001-20230517
|   `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread
|-- x86_64-randconfig-a001
|   |-- kernel-rcu-rcuscale.c:error:incompatible-function-pointer-types-initializing-struct-task_struct-(-)(void)-with-an-expression-of-type-void-(void)-Werror-Wincompatible-function-pointer-types
|   `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread
|-- x86_64-randconfig-a003
|   |-- kernel-rcu-rcuscale.c:error:incompatible-function-pointer-types-initializing-struct-task_struct-(-)(void)-with-an-expression-of-type-void-(void)-Werror-Wincompatible-function-pointer-types
|   `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread
|-- x86_64-randconfig-a005
|   |-- kernel-rcu-rcuscale.c:error:incompatible-function-pointer-types-initializing-struct-task_struct-(-)(void)-with-an-expression-of-type-void-(void)-Werror-Wincompatible-function-pointer-types
|   `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread
|-- x86_64-randconfig-a012
|   |-- kernel-rcu-rcuscale.c:error:incompatible-function-pointer-types-initializing-struct-task_struct-(-)(void)-with-an-expression-of-type-void-(void)-Werror-Wincompatible-function-pointer-types
|   `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread
|-- x86_64-randconfig-a014
|   |-- kernel-rcu-rcuscale.c:error:incompatible-function-pointer-types-initializing-struct-task_struct-(-)(void)-with-an-expression-of-type-void-(void)-Werror-Wincompatible-function-pointer-types
|   `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread
|-- x86_64-randconfig-a016
|   |-- kernel-rcu-rcuscale.c:error:incompatible-function-pointer-types-initializing-struct-task_struct-(-)(void)-with-an-expression-of-type-void-(void)-Werror-Wincompatible-function-pointer-types
|   `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread
|-- x86_64-randconfig-x052
|   |-- kernel-rcu-rcuscale.c:error:incompatible-function-pointer-types-initializing-struct-task_struct-(-)(void)-with-an-expression-of-type-void-(void)-Werror-Wincompatible-function-pointer-types
|   `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread
|-- x86_64-randconfig-x054
|   |-- kernel-rcu-rcuscale.c:error:incompatible-function-pointer-types-initializing-struct-task_struct-(-)(void)-with-an-expression-of-type-void-(void)-Werror-Wincompatible-function-pointer-types
|   `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread
|-- x86_64-randconfig-x056
|   |-- kernel-rcu-rcuscale.c:error:incompatible-function-pointer-types-initializing-struct-task_struct-(-)(void)-with-an-expression-of-type-void-(void)-Werror-Wincompatible-function-pointer-types
|   `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread
|-- x86_64-randconfig-x062
|   |-- kernel-rcu-rcuscale.c:error:incompatible-function-pointer-types-initializing-struct-task_struct-(-)(void)-with-an-expression-of-type-void-(void)-Werror-Wincompatible-function-pointer-types
|   `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread
|-- x86_64-randconfig-x064
|   |-- kernel-rcu-rcuscale.c:error:incompatible-function-pointer-types-initializing-struct-task_struct-(-)(void)-with-an-expression-of-type-void-(void)-Werror-Wincompatible-function-pointer-types
|   `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread
`-- x86_64-randconfig-x066
    |-- kernel-rcu-rcuscale.c:error:incompatible-function-pointer-types-initializing-struct-task_struct-(-)(void)-with-an-expression-of-type-void-(void)-Werror-Wincompatible-function-pointer-types
    `-- kernel-rcu-rcuscale.c:error:use-of-undeclared-identifier-get_rcu_tasks_trace_gp_kthread

elapsed time: 732m

configs tested: 155
configs skipped: 6

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230517   gcc  
alpha                randconfig-r006-20230517   gcc  
alpha                randconfig-r022-20230517   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                  randconfig-r023-20230517   gcc  
arc                  randconfig-r043-20230517   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                  randconfig-r003-20230517   gcc  
arm                  randconfig-r013-20230517   clang
arm                  randconfig-r036-20230517   gcc  
arm                  randconfig-r046-20230517   clang
arm                        vexpress_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230517   clang
csky                                defconfig   gcc  
csky                 randconfig-r001-20230517   gcc  
csky                 randconfig-r021-20230517   gcc  
hexagon              randconfig-r041-20230517   clang
hexagon              randconfig-r045-20230517   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230517   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r036-20230517   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r004-20230517   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230517   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230517   gcc  
m68k                                defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                 randconfig-r015-20230517   gcc  
m68k                 randconfig-r034-20230517   gcc  
microblaze   buildonly-randconfig-r001-20230517   gcc  
microblaze   buildonly-randconfig-r003-20230517   gcc  
microblaze           randconfig-r012-20230517   gcc  
microblaze           randconfig-r031-20230517   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230517   gcc  
mips                         cobalt_defconfig   gcc  
mips                 randconfig-r023-20230517   clang
nios2                               defconfig   gcc  
nios2                randconfig-r013-20230517   gcc  
nios2                randconfig-r025-20230517   gcc  
openrisc     buildonly-randconfig-r004-20230517   gcc  
openrisc             randconfig-r035-20230517   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r016-20230517   gcc  
parisc               randconfig-r024-20230517   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                    sam440ep_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230517   clang
riscv                randconfig-r002-20230517   clang
riscv                randconfig-r005-20230517   clang
riscv                randconfig-r014-20230517   gcc  
riscv                randconfig-r026-20230517   gcc  
riscv                randconfig-r042-20230517   gcc  
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230517   gcc  
s390         buildonly-randconfig-r005-20230517   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r021-20230517   gcc  
s390                 randconfig-r022-20230517   gcc  
s390                 randconfig-r026-20230517   gcc  
s390                 randconfig-r044-20230517   gcc  
sh                               allmodconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh           buildonly-randconfig-r006-20230517   gcc  
sh                         microdev_defconfig   gcc  
sh                   randconfig-r015-20230517   gcc  
sh                   randconfig-r024-20230517   gcc  
sh                           se7722_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r033-20230517   gcc  
sparc64              randconfig-r004-20230517   gcc  
sparc64              randconfig-r016-20230517   gcc  
sparc64              randconfig-r033-20230517   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-x051   gcc  
x86_64                        randconfig-x052   clang
x86_64                        randconfig-x053   gcc  
x86_64                        randconfig-x054   clang
x86_64                        randconfig-x055   gcc  
x86_64                        randconfig-x056   clang
x86_64                        randconfig-x061   gcc  
x86_64                        randconfig-x062   clang
x86_64                        randconfig-x063   gcc  
x86_64                        randconfig-x064   clang
x86_64                        randconfig-x065   gcc  
x86_64                        randconfig-x066   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r002-20230517   gcc  
xtensa               randconfig-r012-20230517   gcc  
xtensa               randconfig-r025-20230517   gcc  
xtensa               randconfig-r034-20230517   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
