Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF15B69A490
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 04:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjBQDuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 22:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjBQDuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 22:50:03 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3ED5A3A9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 19:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676605801; x=1708141801;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=05O6cSg+JQ9YwG+lChcj9FgnMTs6Ki+tvxmgDv2EFcw=;
  b=hFnJBd/kO3bu+wliV4lmOlzTjEdIteYyTv8XZ5rhNsAlDQBrw5+/aFJo
   oj2R3HypDznfQGI6+zufBmtNQJUfiFGuaP4xKqihZhZzWqC3xyCJmQf7u
   VBm9R8lFFF5s+7rPQjMlCmLPDnv6RjK4pH2PPp1JPDYUhYDJZ3tPZbpWs
   IvVrgu/v3QTRd+hxQUccBlAIBJFq+DDCisgCGScGyDw/DGdba+AvJRrnk
   7nnAb5TBjoXTJ2DYHPpRcDQ9xMW+7v7GSHVuR6n4TGyeb62cU5HAueZ52
   GI2jA5iI2h/FxNJGWFqWx09swdQsCcSWDNtNuKFi7BUYhAObQ5mx04Yrk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="331903904"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="331903904"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 19:50:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="915946647"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="915946647"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2023 19:49:59 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSrl0-000B5j-09;
        Fri, 17 Feb 2023 03:49:58 +0000
Date:   Fri, 17 Feb 2023 11:49:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>
Subject: drivers/iommu/io-pgtable-arm.c:330:8: error: instruction requires
 the following: RV64I Base Instruction Set
Message-ID: <202302171144.sffQigLX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ac88fa4605ec98e545fb3ad0154f575fda2de5f
commit: 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1 riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
date:   3 months ago
config: riscv-buildonly-randconfig-r003-20230216 (https://download.01.org/0day-ci/archive/20230217/202302171144.sffQigLX-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8292493c22c8e28b6e67a01e0f5c6db1cf231eb1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/iommu/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302171144.sffQigLX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iommu/io-pgtable-arm.c:330:8: error: instruction requires the following: RV64I Base Instruction Set
           old = cmpxchg64_relaxed(ptep, curr, new);
                 ^
   include/linux/atomic/atomic-instrumented.h:1968:2: note: expanded from macro 'cmpxchg64_relaxed'
           arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
           ^
   include/linux/atomic/atomic-arch-fallback.h:60:32: note: expanded from macro 'arch_cmpxchg64_relaxed'
   #define arch_cmpxchg64_relaxed arch_cmpxchg64
                                  ^
   arch/riscv/include/asm/cmpxchg.h:354:2: note: expanded from macro 'arch_cmpxchg64'
           arch_cmpxchg((ptr), (o), (n));                                  \
           ^
   arch/riscv/include/asm/cmpxchg.h:344:23: note: expanded from macro 'arch_cmpxchg'
           (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
                                ^
   arch/riscv/include/asm/cmpxchg.h:324:4: note: expanded from macro '__cmpxchg'
                           "0:     lr.d %0, %2\n"                          \
                           ^
   <inline asm>:1:5: note: instantiated into assembly here
           0:      lr.d s4, 0(s0)
                   ^
>> drivers/iommu/io-pgtable-arm.c:330:8: error: instruction requires the following: RV64I Base Instruction Set
           old = cmpxchg64_relaxed(ptep, curr, new);
                 ^
   include/linux/atomic/atomic-instrumented.h:1968:2: note: expanded from macro 'cmpxchg64_relaxed'
           arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
           ^
   include/linux/atomic/atomic-arch-fallback.h:60:32: note: expanded from macro 'arch_cmpxchg64_relaxed'
   #define arch_cmpxchg64_relaxed arch_cmpxchg64
                                  ^
   arch/riscv/include/asm/cmpxchg.h:354:2: note: expanded from macro 'arch_cmpxchg64'
           arch_cmpxchg((ptr), (o), (n));                                  \
           ^
   arch/riscv/include/asm/cmpxchg.h:344:23: note: expanded from macro 'arch_cmpxchg'
           (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
                                ^
   arch/riscv/include/asm/cmpxchg.h:326:5: note: expanded from macro '__cmpxchg'
                           "       sc.d.rl %1, %z4, %2\n"                  \
                            ^
   <inline asm>:3:2: note: instantiated into assembly here
           sc.d.rl a0, s6, 0(s0)
           ^
   2 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
   Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=y] && !GENERIC_ATOMIC64 [=y])
   Selected by [y]:
   - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=y] && !GENERIC_ATOMIC64 [=y])


vim +330 drivers/iommu/io-pgtable-arm.c

c896c132b01895 Laurent Pinchart   2014-12-14  310  
fb3a95795da53d Robin Murphy       2017-06-22  311  static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
fb3a95795da53d Robin Murphy       2017-06-22  312  					     arm_lpae_iopte *ptep,
2c3d273eabe8b1 Robin Murphy       2017-06-22  313  					     arm_lpae_iopte curr,
9abe2ac834851a Hector Martin      2021-11-20  314  					     struct arm_lpae_io_pgtable *data)
fb3a95795da53d Robin Murphy       2017-06-22  315  {
2c3d273eabe8b1 Robin Murphy       2017-06-22  316  	arm_lpae_iopte old, new;
9abe2ac834851a Hector Martin      2021-11-20  317  	struct io_pgtable_cfg *cfg = &data->iop.cfg;
e1d3c0fd701df8 Will Deacon        2014-11-14  318  
9abe2ac834851a Hector Martin      2021-11-20  319  	new = paddr_to_iopte(__pa(table), data) | ARM_LPAE_PTE_TYPE_TABLE;
fb3a95795da53d Robin Murphy       2017-06-22  320  	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
fb3a95795da53d Robin Murphy       2017-06-22  321  		new |= ARM_LPAE_PTE_NSTABLE;
e1d3c0fd701df8 Will Deacon        2014-11-14  322  
77f3445866c39d Will Deacon        2017-06-23  323  	/*
77f3445866c39d Will Deacon        2017-06-23  324  	 * Ensure the table itself is visible before its PTE can be.
77f3445866c39d Will Deacon        2017-06-23  325  	 * Whilst we could get away with cmpxchg64_release below, this
77f3445866c39d Will Deacon        2017-06-23  326  	 * doesn't have any ordering semantics when !CONFIG_SMP.
77f3445866c39d Will Deacon        2017-06-23  327  	 */
77f3445866c39d Will Deacon        2017-06-23  328  	dma_wmb();
2c3d273eabe8b1 Robin Murphy       2017-06-22  329  
2c3d273eabe8b1 Robin Murphy       2017-06-22 @330  	old = cmpxchg64_relaxed(ptep, curr, new);
2c3d273eabe8b1 Robin Murphy       2017-06-22  331  
4f41845b340783 Will Deacon        2019-06-25  332  	if (cfg->coherent_walk || (old & ARM_LPAE_PTE_SW_SYNC))
2c3d273eabe8b1 Robin Murphy       2017-06-22  333  		return old;
2c3d273eabe8b1 Robin Murphy       2017-06-22  334  
2c3d273eabe8b1 Robin Murphy       2017-06-22  335  	/* Even if it's not ours, there's no point waiting; just kick it */
41e1eb2546e9c8 Isaac J. Manjarres 2021-06-16  336  	__arm_lpae_sync_pte(ptep, 1, cfg);
2c3d273eabe8b1 Robin Murphy       2017-06-22  337  	if (old == curr)
2c3d273eabe8b1 Robin Murphy       2017-06-22  338  		WRITE_ONCE(*ptep, new | ARM_LPAE_PTE_SW_SYNC);
2c3d273eabe8b1 Robin Murphy       2017-06-22  339  
2c3d273eabe8b1 Robin Murphy       2017-06-22  340  	return old;
e1d3c0fd701df8 Will Deacon        2014-11-14  341  }
e1d3c0fd701df8 Will Deacon        2014-11-14  342  

:::::: The code at line 330 was first introduced by commit
:::::: 2c3d273eabe8b1ed3b3cffe2c79643b1bf7e2d4a iommu/io-pgtable-arm: Support lockless operation

:::::: TO: Robin Murphy <robin.murphy@arm.com>
:::::: CC: Will Deacon <will.deacon@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
