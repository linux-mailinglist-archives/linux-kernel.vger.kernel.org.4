Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9308D73B918
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjFWNtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjFWNsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:48:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA5726BD
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687528110; x=1719064110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fTE3/RwlDADn/1fdTPrzBhWxZmKbGCIKmzOMK9NG++c=;
  b=U9hQ7DH37D7FK4vlG65Rkd5vMB9fgOZksD1tULqefczN2HtaeJDPevnK
   +ALiPfBoQ9GKeybSuHqiXUbXch0Xi7Fme9Qc1+w4k6P8Lt470gCpQ5SZ6
   K82Skwqq0EUYdAwAZFJuDAqpVHB2QojN3rr7N3zDoLo5rnnZPPI0PbmuV
   nodhIW5iSx3Oa3nRdVHG7eYukn30MhMFVRHH5lAO1XnVOsmeJbGXq3p2t
   cDedX3b/5OlUxEUkL+nzFlNsDPSmW+e8LxyzRVp+UQPYNFF3E9vGomx4I
   EuNPcbxzbkll8wT4yzgMAxN7h6FQ5+M4C5YgmTlKMqqjY+yFigaQ42GVh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="364212132"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="364212132"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 06:48:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="805209568"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="805209568"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2023 06:48:09 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCh8y-0008Ib-1n;
        Fri, 23 Jun 2023 13:48:08 +0000
Date:   Fri, 23 Jun 2023 21:47:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
        samuel@sholland.org, guoren@kernel.org,
        christoph.muellner@vrull.eu, heiko@sntech.de,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v2 3/3] RISC-V: add T-Head vector errata handling
Message-ID: <202306232111.5WpYab2n-lkp@intel.com>
References: <20230622231305.631331-4-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622231305.631331-4-heiko@sntech.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230622]
[cannot apply to linus/master v6.4-rc7 v6.4-rc6 v6.4-rc5 v6.4-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiko-Stuebner/RISC-V-move-vector-available-status-into-a-dedicated-variable/20230623-081314
base:   next-20230622
patch link:    https://lore.kernel.org/r/20230622231305.631331-4-heiko%40sntech.de
patch subject: [PATCH v2 3/3] RISC-V: add T-Head vector errata handling
config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20230623/202306232111.5WpYab2n-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230623/202306232111.5WpYab2n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306232111.5WpYab2n-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/riscv/include/asm/vector.h: Assembler messages:
>> arch/riscv/include/asm/vector.h:162: Error: unrecognized opcode `slliw a4,a4,1'
>> arch/riscv/include/asm/vector.h:194: Error: unrecognized opcode `srliw t4,a1,1'
>> arch/riscv/include/asm/vector.h:169: Error: attempt to move .org backwards
   arch/riscv/include/asm/vector.h:203: Error: attempt to move .org backwards
--
   arch/riscv/include/asm/vector.h: Assembler messages:
>> arch/riscv/include/asm/vector.h:162: Error: unrecognized opcode `slliw a4,a4,1'
>> arch/riscv/include/asm/vector.h:169: Error: attempt to move .org backwards
--
   arch/riscv/include/asm/vector.h: Assembler messages:
>> arch/riscv/include/asm/vector.h:194: Error: unrecognized opcode `srliw t4,a1,1'
>> arch/riscv/include/asm/vector.h:162: Error: unrecognized opcode `slliw a4,a4,1'
   arch/riscv/include/asm/vector.h:203: Error: attempt to move .org backwards
>> arch/riscv/include/asm/vector.h:169: Error: attempt to move .org backwards


vim +162 arch/riscv/include/asm/vector.h

03c3fcd9941a17 Greentime Hu   2023-06-05  150  
03c3fcd9941a17 Greentime Hu   2023-06-05  151  static __always_inline void __vstate_csr_restore(struct __riscv_v_ext_state *src)
03c3fcd9941a17 Greentime Hu   2023-06-05  152  {
5255e253b722bb Heiko Stuebner 2023-06-23  153  	register u32 t1 asm("t1") = (SR_FS);
5255e253b722bb Heiko Stuebner 2023-06-23  154  
5255e253b722bb Heiko Stuebner 2023-06-23  155  	/*
5255e253b722bb Heiko Stuebner 2023-06-23  156  	 * Similar to __vstate_csr_save above, restore values for the
5255e253b722bb Heiko Stuebner 2023-06-23  157  	 * separate VXRM and VXSAT CSRs from the vcsr variable.
5255e253b722bb Heiko Stuebner 2023-06-23  158  	 */
5255e253b722bb Heiko Stuebner 2023-06-23  159  	asm volatile (ALTERNATIVE(
03c3fcd9941a17 Greentime Hu   2023-06-05  160  		".option push\n\t"
03c3fcd9941a17 Greentime Hu   2023-06-05  161  		".option arch, +v\n\t"
03c3fcd9941a17 Greentime Hu   2023-06-05 @162  		"vsetvl	 x0, %2, %1\n\t"
03c3fcd9941a17 Greentime Hu   2023-06-05  163  		".option pop\n\t"
03c3fcd9941a17 Greentime Hu   2023-06-05  164  		"csrw	" __stringify(CSR_VSTART) ", %0\n\t"
03c3fcd9941a17 Greentime Hu   2023-06-05  165  		"csrw	" __stringify(CSR_VCSR) ", %3\n\t"
5255e253b722bb Heiko Stuebner 2023-06-23  166  		__nops(6),
5255e253b722bb Heiko Stuebner 2023-06-23  167  		"csrs	sstatus, t1\n\t"
5255e253b722bb Heiko Stuebner 2023-06-23  168  		".option push\n\t"
5255e253b722bb Heiko Stuebner 2023-06-23 @169  		".option arch, +v\n\t"
5255e253b722bb Heiko Stuebner 2023-06-23  170  		"vsetvl	 x0, %2, %1\n\t"
5255e253b722bb Heiko Stuebner 2023-06-23  171  		".option pop\n\t"
5255e253b722bb Heiko Stuebner 2023-06-23  172  		"csrw	" __stringify(CSR_VSTART) ", %0\n\t"
5255e253b722bb Heiko Stuebner 2023-06-23  173  		"srliw	t4, %3, " __stringify(VCSR_VXRM_SHIFT) "\n\t"
5255e253b722bb Heiko Stuebner 2023-06-23  174  		"andi	t4, t4, " __stringify(VCSR_VXRM_MASK) "\n\t"
5255e253b722bb Heiko Stuebner 2023-06-23  175  		"csrw	" __stringify(THEAD_C9XX_CSR_VXRM) ", t4\n\t"
5255e253b722bb Heiko Stuebner 2023-06-23  176  		"andi	%3, %3, " __stringify(VCSR_VXSAT_MASK) "\n\t"
5255e253b722bb Heiko Stuebner 2023-06-23  177  		"csrw	" __stringify(THEAD_C9XX_CSR_VXSAT) ", %3\n\t"
5255e253b722bb Heiko Stuebner 2023-06-23  178  		"csrc	sstatus, t1\n\t",
5255e253b722bb Heiko Stuebner 2023-06-23  179  		THEAD_VENDOR_ID,
5255e253b722bb Heiko Stuebner 2023-06-23  180  		ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
03c3fcd9941a17 Greentime Hu   2023-06-05  181  		: : "r" (src->vstart), "r" (src->vtype), "r" (src->vl),
5255e253b722bb Heiko Stuebner 2023-06-23  182  		    "r" (src->vcsr), "r"(t1) : "t4");
03c3fcd9941a17 Greentime Hu   2023-06-05  183  }
03c3fcd9941a17 Greentime Hu   2023-06-05  184  
03c3fcd9941a17 Greentime Hu   2023-06-05  185  static inline void __riscv_v_vstate_save(struct __riscv_v_ext_state *save_to,
03c3fcd9941a17 Greentime Hu   2023-06-05  186  					 void *datap)
03c3fcd9941a17 Greentime Hu   2023-06-05  187  {
03c3fcd9941a17 Greentime Hu   2023-06-05  188  	unsigned long vl;
03c3fcd9941a17 Greentime Hu   2023-06-05  189  
03c3fcd9941a17 Greentime Hu   2023-06-05  190  	riscv_v_enable();
03c3fcd9941a17 Greentime Hu   2023-06-05  191  	__vstate_csr_save(save_to);
5255e253b722bb Heiko Stuebner 2023-06-23  192  	asm volatile (ALTERNATIVE(
5255e253b722bb Heiko Stuebner 2023-06-23  193  		"nop\n\t"
03c3fcd9941a17 Greentime Hu   2023-06-05 @194  		".option push\n\t"
03c3fcd9941a17 Greentime Hu   2023-06-05  195  		".option arch, +v\n\t"
03c3fcd9941a17 Greentime Hu   2023-06-05  196  		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
03c3fcd9941a17 Greentime Hu   2023-06-05  197  		"vse8.v		v0, (%1)\n\t"
03c3fcd9941a17 Greentime Hu   2023-06-05  198  		"add		%1, %1, %0\n\t"
03c3fcd9941a17 Greentime Hu   2023-06-05  199  		"vse8.v		v8, (%1)\n\t"
03c3fcd9941a17 Greentime Hu   2023-06-05  200  		"add		%1, %1, %0\n\t"
03c3fcd9941a17 Greentime Hu   2023-06-05  201  		"vse8.v		v16, (%1)\n\t"
03c3fcd9941a17 Greentime Hu   2023-06-05  202  		"add		%1, %1, %0\n\t"
03c3fcd9941a17 Greentime Hu   2023-06-05  203  		"vse8.v		v24, (%1)\n\t"
5255e253b722bb Heiko Stuebner 2023-06-23  204  		".option pop\n\t",
5255e253b722bb Heiko Stuebner 2023-06-23  205  		"mv		t0, %1\n\t"
5255e253b722bb Heiko Stuebner 2023-06-23  206  		THEAD_VSETVLI_T4X0E8M8D1
5255e253b722bb Heiko Stuebner 2023-06-23  207  		THEAD_VSB_V_V0T0
5255e253b722bb Heiko Stuebner 2023-06-23  208  		"addi		t0, t0, 128\n\t"
5255e253b722bb Heiko Stuebner 2023-06-23  209  		THEAD_VSB_V_V8T0
5255e253b722bb Heiko Stuebner 2023-06-23  210  		"addi		t0, t0, 128\n\t"
5255e253b722bb Heiko Stuebner 2023-06-23  211  		THEAD_VSB_V_V16T0
5255e253b722bb Heiko Stuebner 2023-06-23  212  		"addi		t0, t0, 128\n\t"
5255e253b722bb Heiko Stuebner 2023-06-23  213  		THEAD_VSB_V_V24T0, THEAD_VENDOR_ID,
5255e253b722bb Heiko Stuebner 2023-06-23  214  		ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
5255e253b722bb Heiko Stuebner 2023-06-23  215  		: "=&r" (vl) : "r" (datap) : "t0", "t4", "memory");
03c3fcd9941a17 Greentime Hu   2023-06-05  216  	riscv_v_disable();
03c3fcd9941a17 Greentime Hu   2023-06-05  217  }
03c3fcd9941a17 Greentime Hu   2023-06-05  218  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
