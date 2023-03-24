Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BD36C860B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjCXTjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 15:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjCXTji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:39:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E7916331
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679686773; x=1711222773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mEO8F9qBo8jetofq3ZYYYAKaUbuAJ4bhSSQ1NtxMlSc=;
  b=YNxXS1mIMJKhug/3ax59R7m9V8Bigen3hTM1lNLsKzSx/AaUxK8xrjSp
   I5wOYKMRJZcvyPTomDTd+YvDXk44oDMA+dWplzC0IbDuPA//bTFsWbEbi
   BzLvclwrZ2BT2fYYwOOamMdkb2Q1gU+GCCV7biiDF2GGel0X1186tfZo/
   HIDedyNY/zfK5NhUhripkmw8KAqNYdC9Sid34793xv1FjzF6hhd0E038q
   g6urCN9L8Jgb0kfhP7Tch0Dgc+VAihzF6SADacQkQ9GNTxVVblugp/mJq
   pSiZbqU94v4waUGWdUajn8mEatxnHnsmz6OvvRs9ja+CQJtBrX0y83/0v
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="342260568"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="342260568"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 12:39:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="806792457"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="806792457"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2023 12:39:30 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfnG5-000FbU-2x;
        Fri, 24 Mar 2023 19:39:29 +0000
Date:   Sat, 25 Mar 2023 03:39:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Disable EL2 traps for BRBE instructions executed
 in EL1
Message-ID: <202303250356.K6CxtK2u-lkp@intel.com>
References: <20230324055127.2228330-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324055127.2228330-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on arm/for-next arm/fixes kvmarm/next soc/for-next xilinx-xlnx/master linus/master v6.3-rc3 next-20230324]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/arm64-Disable-EL2-traps-for-BRBE-instructions-executed-in-EL1/20230324-135312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230324055127.2228330-1-anshuman.khandual%40arm.com
patch subject: [PATCH] arm64: Disable EL2 traps for BRBE instructions executed in EL1
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20230325/202303250356.K6CxtK2u-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/457bbac085c7f83be1a63b54f6caf32b820503eb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anshuman-Khandual/arm64-Disable-EL2-traps-for-BRBE-instructions-executed-in-EL1/20230324-135312
        git checkout 457bbac085c7f83be1a63b54f6caf32b820503eb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303250356.K6CxtK2u-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/kernel/head.S:27:
   arch/arm64/include/asm/kernel-pgtable.h:126:41: warning: "PUD_SHIFT" is not defined, evaluates to 0 [-Wundef]
     126 | #define ARM64_MEMSTART_SHIFT            PUD_SHIFT
         |                                         ^~~~~~~~~
   arch/arm64/include/asm/kernel-pgtable.h:139:5: note: in expansion of macro 'ARM64_MEMSTART_SHIFT'
     139 | #if ARM64_MEMSTART_SHIFT < SECTION_SIZE_BITS
         |     ^~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/head.S: Assembler messages:
>> arch/arm64/kernel/head.S:577: Error: undefined symbol HFGITR_EL2_nBRBIALL used as an immediate value
>> arch/arm64/kernel/head.S:577: Error: undefined symbol HFGITR_EL2_nBRBINJ used as an immediate value


vim +577 arch/arm64/kernel/head.S

034edabe6cf1d0 Laura Abbott    2014-11-21  526  
034edabe6cf1d0 Laura Abbott    2014-11-21  527  /*
034edabe6cf1d0 Laura Abbott    2014-11-21  528   * end early head section, begin head code that is also used for
034edabe6cf1d0 Laura Abbott    2014-11-21  529   * hotplug and needs to have the same protections as the text region
034edabe6cf1d0 Laura Abbott    2014-11-21  530   */
d54170812ef1c8 Mark Rutland    2023-02-20  531  	.section ".idmap.text","a"
f80fb3a3d50843 Ard Biesheuvel  2016-01-26  532  
9703d9d7f77ce1 Catalin Marinas 2012-03-05  533  /*
ecbb11ab3ebc02 Mark Rutland    2020-11-13  534   * Starting from EL2 or EL1, configure the CPU to execute at the highest
ecbb11ab3ebc02 Mark Rutland    2020-11-13  535   * reachable EL supported by the kernel in a chosen default state. If dropping
ecbb11ab3ebc02 Mark Rutland    2020-11-13  536   * from EL2 to EL1, configure EL2 before configuring EL1.
828e9834e9a5b7 Matthew Leach   2013-10-11  537   *
d87a8e65b51011 Mark Rutland    2020-11-13  538   * Since we cannot always rely on ERET synchronizing writes to sysregs (e.g. if
d87a8e65b51011 Mark Rutland    2020-11-13  539   * SCTLR_ELx.EOS is clear), we place an ISB prior to ERET.
828e9834e9a5b7 Matthew Leach   2013-10-11  540   *
b65e411d6cc2f1 Marc Zyngier    2022-06-30  541   * Returns either BOOT_CPU_MODE_EL1 or BOOT_CPU_MODE_EL2 in x0 if
b65e411d6cc2f1 Marc Zyngier    2022-06-30  542   * booted in EL1 or EL2 respectively, with the top 32 bits containing
b65e411d6cc2f1 Marc Zyngier    2022-06-30  543   * potential context flags. These flags are *not* stored in __boot_cpu_mode.
3dcf60bbfd284e Ard Biesheuvel  2023-01-11  544   *
3dcf60bbfd284e Ard Biesheuvel  2023-01-11  545   * x0: whether we are being called from the primary boot path with the MMU on
9703d9d7f77ce1 Catalin Marinas 2012-03-05  546   */
ecbb11ab3ebc02 Mark Rutland    2020-11-13  547  SYM_FUNC_START(init_kernel_el)
3dcf60bbfd284e Ard Biesheuvel  2023-01-11  548  	mrs	x1, CurrentEL
3dcf60bbfd284e Ard Biesheuvel  2023-01-11  549  	cmp	x1, #CurrentEL_EL2
d87a8e65b51011 Mark Rutland    2020-11-13  550  	b.eq	init_el2
d87a8e65b51011 Mark Rutland    2020-11-13  551  
d87a8e65b51011 Mark Rutland    2020-11-13  552  SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
31a32b49b80f79 Marc Zyngier    2021-04-08  553  	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
9d7c13e5dde312 Ard Biesheuvel  2023-01-11  554  	pre_disable_mmu_workaround
31a32b49b80f79 Marc Zyngier    2021-04-08  555  	msr	sctlr_el1, x0
9cf71728931a40 Matthew Leach   2013-10-11  556  	isb
d87a8e65b51011 Mark Rutland    2020-11-13  557  	mov_q	x0, INIT_PSTATE_EL1
d87a8e65b51011 Mark Rutland    2020-11-13  558  	msr	spsr_el1, x0
d87a8e65b51011 Mark Rutland    2020-11-13  559  	msr	elr_el1, lr
d87a8e65b51011 Mark Rutland    2020-11-13  560  	mov	w0, #BOOT_CPU_MODE_EL1
d87a8e65b51011 Mark Rutland    2020-11-13  561  	eret
9703d9d7f77ce1 Catalin Marinas 2012-03-05  562  
d87a8e65b51011 Mark Rutland    2020-11-13  563  SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
3dcf60bbfd284e Ard Biesheuvel  2023-01-11  564  	msr	elr_el2, lr
3dcf60bbfd284e Ard Biesheuvel  2023-01-11  565  
3dcf60bbfd284e Ard Biesheuvel  2023-01-11  566  	// clean all HYP code to the PoC if we booted at EL2 with the MMU on
3dcf60bbfd284e Ard Biesheuvel  2023-01-11  567  	cbz	x0, 0f
3dcf60bbfd284e Ard Biesheuvel  2023-01-11  568  	adrp	x0, __hyp_idmap_text_start
3dcf60bbfd284e Ard Biesheuvel  2023-01-11  569  	adr_l	x1, __hyp_text_end
d54170812ef1c8 Mark Rutland    2023-02-20  570  	adr_l	x2, dcache_clean_poc
d54170812ef1c8 Mark Rutland    2023-02-20  571  	blr	x2
3dcf60bbfd284e Ard Biesheuvel  2023-01-11  572  0:
78869f0f0552d0 David Brazdil   2020-12-02  573  	mov_q	x0, HCR_HOST_NVHE_FLAGS
78869f0f0552d0 David Brazdil   2020-12-02  574  	msr	hcr_el2, x0
22043a3c082a58 Dave Martin     2017-10-31  575  	isb
78869f0f0552d0 David Brazdil   2020-12-02  576  
e2df464173f0b5 Marc Zyngier    2021-02-08 @577  	init_el2_state
22043a3c082a58 Dave Martin     2017-10-31  578  
712c6ff4dba491 Marc Zyngier    2012-10-19  579  	/* Hypervisor stub */
78869f0f0552d0 David Brazdil   2020-12-02  580  	adr_l	x0, __hyp_stub_vectors
712c6ff4dba491 Marc Zyngier    2012-10-19  581  	msr	vbar_el2, x0
d87a8e65b51011 Mark Rutland    2020-11-13  582  	isb
78869f0f0552d0 David Brazdil   2020-12-02  583  
ae4b7e38e9a947 Marc Zyngier    2022-06-30  584  	mov_q	x1, INIT_SCTLR_EL1_MMU_OFF
ae4b7e38e9a947 Marc Zyngier    2022-06-30  585  
31a32b49b80f79 Marc Zyngier    2021-04-08  586  	/*
31a32b49b80f79 Marc Zyngier    2021-04-08  587  	 * Fruity CPUs seem to have HCR_EL2.E2H set to RES1,
31a32b49b80f79 Marc Zyngier    2021-04-08  588  	 * making it impossible to start in nVHE mode. Is that
31a32b49b80f79 Marc Zyngier    2021-04-08  589  	 * compliant with the architecture? Absolutely not!
31a32b49b80f79 Marc Zyngier    2021-04-08  590  	 */
31a32b49b80f79 Marc Zyngier    2021-04-08  591  	mrs	x0, hcr_el2
31a32b49b80f79 Marc Zyngier    2021-04-08  592  	and	x0, x0, #HCR_E2H
31a32b49b80f79 Marc Zyngier    2021-04-08  593  	cbz	x0, 1f
31a32b49b80f79 Marc Zyngier    2021-04-08  594  
ae4b7e38e9a947 Marc Zyngier    2022-06-30  595  	/* Set a sane SCTLR_EL1, the VHE way */
9d7c13e5dde312 Ard Biesheuvel  2023-01-11  596  	pre_disable_mmu_workaround
ae4b7e38e9a947 Marc Zyngier    2022-06-30  597  	msr_s	SYS_SCTLR_EL12, x1
ae4b7e38e9a947 Marc Zyngier    2022-06-30  598  	mov	x2, #BOOT_CPU_FLAG_E2H
ae4b7e38e9a947 Marc Zyngier    2022-06-30  599  	b	2f
31a32b49b80f79 Marc Zyngier    2021-04-08  600  
31a32b49b80f79 Marc Zyngier    2021-04-08  601  1:
9d7c13e5dde312 Ard Biesheuvel  2023-01-11  602  	pre_disable_mmu_workaround
ae4b7e38e9a947 Marc Zyngier    2022-06-30  603  	msr	sctlr_el1, x1
ae4b7e38e9a947 Marc Zyngier    2022-06-30  604  	mov	x2, xzr
ae4b7e38e9a947 Marc Zyngier    2022-06-30  605  2:
d87a8e65b51011 Mark Rutland    2020-11-13  606  	mov	w0, #BOOT_CPU_MODE_EL2
ae4b7e38e9a947 Marc Zyngier    2022-06-30  607  	orr	x0, x0, x2
9703d9d7f77ce1 Catalin Marinas 2012-03-05  608  	eret
ecbb11ab3ebc02 Mark Rutland    2020-11-13  609  SYM_FUNC_END(init_kernel_el)
9703d9d7f77ce1 Catalin Marinas 2012-03-05  610  
9703d9d7f77ce1 Catalin Marinas 2012-03-05  611  	/*
9703d9d7f77ce1 Catalin Marinas 2012-03-05  612  	 * This provides a "holding pen" for platforms to hold all secondary
9703d9d7f77ce1 Catalin Marinas 2012-03-05  613  	 * cores are held until we're ready for them to initialise.
9703d9d7f77ce1 Catalin Marinas 2012-03-05  614  	 */
c63d9f82db9439 Mark Brown      2020-02-18  615  SYM_FUNC_START(secondary_holding_pen)
3dcf60bbfd284e Ard Biesheuvel  2023-01-11  616  	mov	x0, xzr
ecbb11ab3ebc02 Mark Rutland    2020-11-13  617  	bl	init_kernel_el			// w0=cpu_boot_mode
005e12676af09a Ard Biesheuvel  2022-06-24  618  	mrs	x2, mpidr_el1
b03cc885328e3c Ard Biesheuvel  2016-04-18  619  	mov_q	x1, MPIDR_HWID_BITMASK
005e12676af09a Ard Biesheuvel  2022-06-24  620  	and	x2, x2, x1
b1c98297fe0c6e Ard Biesheuvel  2015-03-10  621  	adr_l	x3, secondary_holding_pen_release
9703d9d7f77ce1 Catalin Marinas 2012-03-05  622  pen:	ldr	x4, [x3]
005e12676af09a Ard Biesheuvel  2022-06-24  623  	cmp	x4, x2
9703d9d7f77ce1 Catalin Marinas 2012-03-05  624  	b.eq	secondary_startup
9703d9d7f77ce1 Catalin Marinas 2012-03-05  625  	wfe
9703d9d7f77ce1 Catalin Marinas 2012-03-05  626  	b	pen
c63d9f82db9439 Mark Brown      2020-02-18  627  SYM_FUNC_END(secondary_holding_pen)
652af899799354 Mark Rutland    2013-10-24  628  
652af899799354 Mark Rutland    2013-10-24  629  	/*
652af899799354 Mark Rutland    2013-10-24  630  	 * Secondary entry point that jumps straight into the kernel. Only to
652af899799354 Mark Rutland    2013-10-24  631  	 * be used where CPUs are brought online dynamically by the kernel.
652af899799354 Mark Rutland    2013-10-24  632  	 */
c63d9f82db9439 Mark Brown      2020-02-18  633  SYM_FUNC_START(secondary_entry)
3dcf60bbfd284e Ard Biesheuvel  2023-01-11  634  	mov	x0, xzr
ecbb11ab3ebc02 Mark Rutland    2020-11-13  635  	bl	init_kernel_el			// w0=cpu_boot_mode
652af899799354 Mark Rutland    2013-10-24  636  	b	secondary_startup
c63d9f82db9439 Mark Brown      2020-02-18  637  SYM_FUNC_END(secondary_entry)
9703d9d7f77ce1 Catalin Marinas 2012-03-05  638  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
