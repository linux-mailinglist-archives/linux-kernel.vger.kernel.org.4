Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D74A73AEF7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjFWDMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjFWDMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:12:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364E62136
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687489921; x=1719025921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yZC8i7vWYWDPTok3ig35v5onjbfZVwf1jsj+jEeYsfE=;
  b=Hf0oqCDPGutuTp3mgKERmkFC6qbbM42gvVambJgpWzxCb9Q7bnGdbe2S
   B+ppp3iTo5XzDhXCTeWHAeE6A/1+ax+ca/ptFzT5H36YkaXr/H4J/Jgjx
   O6M0o9wmoFvdmTiQM7ZwnCQyOijUsKuANMQPWrxenSz3CK2T/tvX2Qrht
   4SWBagJajA8Y/EaP1V+ulu4SJshtb6N+VnmX0xa/Pe4snMgq7xhxTG+WT
   0NdtZ6UmjU62/qE20zi+HD35h2nlz0lfVW03HMswOisdJ2vuDItrJ5k7q
   gV+k7QFTJdnuJ9j6oQdLTxrdIFuvp2MP6VFBeT4ywkJ5l3vzycGWRqCHm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="447048235"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="447048235"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 20:11:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="780464152"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="780464152"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2023 20:11:55 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCXDG-0007wd-1P;
        Fri, 23 Jun 2023 03:11:54 +0000
Date:   Fri, 23 Jun 2023 11:11:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
        samuel@sholland.org, guoren@kernel.org,
        christoph.muellner@vrull.eu, heiko@sntech.de,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v2 3/3] RISC-V: add T-Head vector errata handling
Message-ID: <202306231142.j8XLzSQL-lkp@intel.com>
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
config: riscv-randconfig-r042-20230622 (https://download.01.org/0day-ci/archive/20230623/202306231142.j8XLzSQL-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230623/202306231142.j8XLzSQL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306231142.j8XLzSQL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/alternative.h:9,
                    from arch/riscv/include/asm/errata_list.h:8,
                    from arch/riscv/include/asm/tlbflush.h:12,
                    from arch/riscv/include/asm/pgtable.h:112,
                    from arch/riscv/include/asm/uaccess.h:12,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/compat.h:17,
                    from arch/riscv/include/asm/elf.h:12,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/energy_model.h:5,
                    from kernel/sched/fair.c:23:
   arch/riscv/include/asm/vector.h: In function '__riscv_v_vstate_save':
>> arch/riscv/include/asm/vector.h:206:17: error: expected ':' or ')' before 'THEAD_VSETVLI_T4X0E8M8D1'
     206 |                 THEAD_VSETVLI_T4X0E8M8D1
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/alternative-macros.h:78:9: note: in definition of macro 'ALT_NEW_CONTENT'
      78 |         new_c "\n"                                                      \
         |         ^~~~~
   arch/riscv/include/asm/alternative-macros.h:104:9: note: in expansion of macro '__ALTERNATIVE_CFG'
     104 |         __ALTERNATIVE_CFG(old_c, new_c, vendor_id, patch_id, IS_ENABLED(CONFIG_k))
         |         ^~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/alternative-macros.h:152:9: note: in expansion of macro '_ALTERNATIVE_CFG'
     152 |         _ALTERNATIVE_CFG(old_content, new_content, vendor_id, patch_id, CONFIG_k)
         |         ^~~~~~~~~~~~~~~~
   arch/riscv/include/asm/vector.h:192:23: note: in expansion of macro 'ALTERNATIVE'
     192 |         asm volatile (ALTERNATIVE(
         |                       ^~~~~~~~~~~
   In file included from arch/riscv/include/asm/switch_to.h:11,
                    from kernel/sched/fair.c:51:
   arch/riscv/include/asm/vector.h:188:23: warning: unused variable 'vl' [-Wunused-variable]
     188 |         unsigned long vl;
         |                       ^~
   arch/riscv/include/asm/vector.h: In function '__riscv_v_vstate_restore':
   arch/riscv/include/asm/vector.h:239:17: error: expected ':' or ')' before 'THEAD_VSETVLI_T4X0E8M8D1'
     239 |                 THEAD_VSETVLI_T4X0E8M8D1
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/alternative-macros.h:78:9: note: in definition of macro 'ALT_NEW_CONTENT'
      78 |         new_c "\n"                                                      \
         |         ^~~~~
   arch/riscv/include/asm/alternative-macros.h:104:9: note: in expansion of macro '__ALTERNATIVE_CFG'
     104 |         __ALTERNATIVE_CFG(old_c, new_c, vendor_id, patch_id, IS_ENABLED(CONFIG_k))
         |         ^~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/alternative-macros.h:152:9: note: in expansion of macro '_ALTERNATIVE_CFG'
     152 |         _ALTERNATIVE_CFG(old_content, new_content, vendor_id, patch_id, CONFIG_k)
         |         ^~~~~~~~~~~~~~~~
   arch/riscv/include/asm/vector.h:225:23: note: in expansion of macro 'ALTERNATIVE'
     225 |         asm volatile (ALTERNATIVE(
         |                       ^~~~~~~~~~~
   arch/riscv/include/asm/vector.h:222:23: warning: unused variable 'vl' [-Wunused-variable]
     222 |         unsigned long vl;
         |                       ^~
   kernel/sched/fair.c: At top level:
   kernel/sched/fair.c:688:5: warning: no previous prototype for 'sched_update_scaling' [-Wmissing-prototypes]
     688 | int sched_update_scaling(void)
         |     ^~~~~~~~~~~~~~~~~~~~
--
   In file included from arch/riscv/include/asm/alternative.h:9,
                    from arch/riscv/include/asm/errata_list.h:8,
                    from arch/riscv/include/asm/tlbflush.h:12,
                    from arch/riscv/include/asm/pgtable.h:112,
                    from arch/riscv/include/asm/uaccess.h:12,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/sched/cputime.h:5,
                    from kernel/sched/build_utility.c:13:
   arch/riscv/include/asm/vector.h: In function '__riscv_v_vstate_save':
>> arch/riscv/include/asm/vector.h:206:17: error: expected ':' or ')' before 'THEAD_VSETVLI_T4X0E8M8D1'
     206 |                 THEAD_VSETVLI_T4X0E8M8D1
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/alternative-macros.h:78:9: note: in definition of macro 'ALT_NEW_CONTENT'
      78 |         new_c "\n"                                                      \
         |         ^~~~~
   arch/riscv/include/asm/alternative-macros.h:104:9: note: in expansion of macro '__ALTERNATIVE_CFG'
     104 |         __ALTERNATIVE_CFG(old_c, new_c, vendor_id, patch_id, IS_ENABLED(CONFIG_k))
         |         ^~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/alternative-macros.h:152:9: note: in expansion of macro '_ALTERNATIVE_CFG'
     152 |         _ALTERNATIVE_CFG(old_content, new_content, vendor_id, patch_id, CONFIG_k)
         |         ^~~~~~~~~~~~~~~~
   arch/riscv/include/asm/vector.h:192:23: note: in expansion of macro 'ALTERNATIVE'
     192 |         asm volatile (ALTERNATIVE(
         |                       ^~~~~~~~~~~
   In file included from arch/riscv/include/asm/switch_to.h:11,
                    from kernel/sched/build_utility.c:51:
   arch/riscv/include/asm/vector.h:188:23: warning: unused variable 'vl' [-Wunused-variable]
     188 |         unsigned long vl;
         |                       ^~
   arch/riscv/include/asm/vector.h: In function '__riscv_v_vstate_restore':
   arch/riscv/include/asm/vector.h:239:17: error: expected ':' or ')' before 'THEAD_VSETVLI_T4X0E8M8D1'
     239 |                 THEAD_VSETVLI_T4X0E8M8D1
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/alternative-macros.h:78:9: note: in definition of macro 'ALT_NEW_CONTENT'
      78 |         new_c "\n"                                                      \
         |         ^~~~~
   arch/riscv/include/asm/alternative-macros.h:104:9: note: in expansion of macro '__ALTERNATIVE_CFG'
     104 |         __ALTERNATIVE_CFG(old_c, new_c, vendor_id, patch_id, IS_ENABLED(CONFIG_k))
         |         ^~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/alternative-macros.h:152:9: note: in expansion of macro '_ALTERNATIVE_CFG'
     152 |         _ALTERNATIVE_CFG(old_content, new_content, vendor_id, patch_id, CONFIG_k)
         |         ^~~~~~~~~~~~~~~~
   arch/riscv/include/asm/vector.h:225:23: note: in expansion of macro 'ALTERNATIVE'
     225 |         asm volatile (ALTERNATIVE(
         |                       ^~~~~~~~~~~
   arch/riscv/include/asm/vector.h:222:23: warning: unused variable 'vl' [-Wunused-variable]
     222 |         unsigned long vl;
         |                       ^~


vim +206 arch/riscv/include/asm/vector.h

   184	
   185	static inline void __riscv_v_vstate_save(struct __riscv_v_ext_state *save_to,
   186						 void *datap)
   187	{
   188		unsigned long vl;
   189	
   190		riscv_v_enable();
   191		__vstate_csr_save(save_to);
   192		asm volatile (ALTERNATIVE(
   193			"nop\n\t"
   194			".option push\n\t"
   195			".option arch, +v\n\t"
   196			"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
   197			"vse8.v		v0, (%1)\n\t"
   198			"add		%1, %1, %0\n\t"
   199			"vse8.v		v8, (%1)\n\t"
   200			"add		%1, %1, %0\n\t"
   201			"vse8.v		v16, (%1)\n\t"
   202			"add		%1, %1, %0\n\t"
   203			"vse8.v		v24, (%1)\n\t"
   204			".option pop\n\t",
   205			"mv		t0, %1\n\t"
 > 206			THEAD_VSETVLI_T4X0E8M8D1
   207			THEAD_VSB_V_V0T0
   208			"addi		t0, t0, 128\n\t"
   209			THEAD_VSB_V_V8T0
   210			"addi		t0, t0, 128\n\t"
   211			THEAD_VSB_V_V16T0
   212			"addi		t0, t0, 128\n\t"
   213			THEAD_VSB_V_V24T0, THEAD_VENDOR_ID,
   214			ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
   215			: "=&r" (vl) : "r" (datap) : "t0", "t4", "memory");
   216		riscv_v_disable();
   217	}
   218	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
