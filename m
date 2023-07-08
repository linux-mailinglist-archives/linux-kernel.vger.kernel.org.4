Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F161E74BEFD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 21:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjGHTgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 15:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjGHTgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 15:36:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C701B3
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 12:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688844997; x=1720380997;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XrSPqfRIhmkmeqWYN/whmgvL9/lC37owCO5J8gQMTVQ=;
  b=Gw7402hHrzCDQdwMcIMQ6s7l9AsdQqJLgr+oXpoivYiNa83aH2XV+F1Z
   R4h9vRaBjcttLAussuYh9OToYaICQXeTwTqXuCbfCBvzlZEW1aBfXjv+F
   0Vv5RjoGJYvpqU63RtfNs+SieuFqZP/dTzPo9G+YwrKINZjaHS9FG9Hbq
   w3zNHzMHb72IeG6AlauYw00q3KWdLjffTNgccyGihVuqKxJcj7bUR8Lpi
   SPSoiPHjWVXDFNXSz0jqtCobnFO6phb24YNpnWlK9GpmnD0IUrSslLbbJ
   WszBRM0+uWmIxDPaiWTgiTbY7Y0xdYpPbLVyGZ2icomqjTrFuIJPDaKI/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10765"; a="427780020"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="427780020"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2023 12:36:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10765"; a="894330679"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="894330679"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Jul 2023 12:36:34 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qIDjN-0002sg-0u;
        Sat, 08 Jul 2023 19:36:33 +0000
Date:   Sun, 9 Jul 2023 03:36:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yimin Gu <ustcymgu@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: arch/riscv/mm/init.c:1204:48: sparse: sparse: cast truncates bits
 from constant value (100000000 becomes 0)
Message-ID: <202307090340.NydZlDAr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yimin,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8689f4f2ea561dd080118eeb05c0255ac9542905
commit: b5e2c507b06c9d36411845149162a804ae7b04a9 riscv: Kconfig: Allow RV32 to build with no MMU
date:   3 months ago
config: riscv-randconfig-r091-20230709 (https://download.01.org/0day-ci/archive/20230709/202307090340.NydZlDAr-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230709/202307090340.NydZlDAr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307090340.NydZlDAr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zihintpause'
>> arch/riscv/mm/init.c:1204:48: sparse: sparse: cast truncates bits from constant value (100000000 becomes 0)
--
   WARNING: invalid argument to '-march': '_zihintpause'
   fs/ext4/mballoc.c: note: in included file (through include/linux/timex.h, include/linux/time32.h, include/linux/time.h, ...):
>> arch/riscv/include/asm/timex.h:25:16: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/riscv/include/asm/timex.h:25:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   arch/riscv/include/asm/timex.h:25:16: sparse:     expected void const volatile [noderef] __iomem *addr
   arch/riscv/include/asm/timex.h:25:16: sparse:     got unsigned int [usertype] *
>> arch/riscv/include/asm/timex.h:25:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   arch/riscv/include/asm/timex.h:25:16: sparse:     expected void const volatile [noderef] __iomem *addr
   arch/riscv/include/asm/timex.h:25:16: sparse:     got unsigned int [usertype] *
   fs/ext4/mballoc.c:1217:9: sparse: sparse: context imbalance in 'ext4_mb_init_cache' - different lock contexts for basic block
   fs/ext4/mballoc.c:2127:5: sparse: sparse: context imbalance in 'ext4_mb_try_best_found' - different lock contexts for basic block
   fs/ext4/mballoc.c:2155:5: sparse: sparse: context imbalance in 'ext4_mb_find_by_goal' - different lock contexts for basic block
   fs/ext4/mballoc.c:2448:12: sparse: sparse: context imbalance in 'ext4_mb_good_group_nolock' - wrong count at exit
   fs/ext4/mballoc.c:2670:58: sparse: sparse: context imbalance in 'ext4_mb_regular_allocator' - different lock contexts for basic block
   fs/ext4/mballoc.c:2942:13: sparse: sparse: context imbalance in 'ext4_mb_seq_structs_summary_start' - wrong count at exit
   fs/ext4/mballoc.c:3322:17: sparse: sparse: context imbalance in 'ext4_discard_work' - different lock contexts for basic block
   fs/ext4/mballoc.c:3525:17: sparse: sparse: context imbalance in 'ext4_mb_release' - different lock contexts for basic block
   fs/ext4/mballoc.c:3647:26: sparse: sparse: context imbalance in 'ext4_free_data_in_buddy' - wrong count at exit
   fs/ext4/mballoc.c:3852:15: sparse: sparse: context imbalance in 'ext4_mb_mark_diskspace_used' - different lock contexts for basic block
   fs/ext4/mballoc.c:3964:9: sparse: sparse: context imbalance in 'ext4_mb_mark_bb' - different lock contexts for basic block
   fs/ext4/mballoc.c:4240:13: sparse: sparse: context imbalance in 'ext4_discard_allocated_blocks' - different lock contexts for basic block
   fs/ext4/mballoc.c:4542:13: sparse: sparse: context imbalance in 'ext4_mb_put_pa' - different lock contexts for basic block
   fs/ext4/mballoc.c:4926:9: sparse: sparse: context imbalance in 'ext4_mb_discard_group_preallocations' - different lock contexts for basic block
   fs/ext4/mballoc.c:5017:9: sparse: sparse: context imbalance in 'ext4_discard_preallocations' - different lock contexts for basic block
   fs/ext4/mballoc.c:5084:9: sparse: sparse: context imbalance in 'ext4_mb_show_ac' - different lock contexts for basic block
   fs/ext4/mballoc.c:5313:9: sparse: sparse: context imbalance in 'ext4_mb_discard_lg_preallocations' - different lock contexts for basic block
   fs/ext4/mballoc.c:5084:9: sparse: sparse: context imbalance in 'ext4_mb_new_blocks' - different lock contexts for basic block
   fs/ext4/mballoc.c:5910:9: sparse: sparse: context imbalance in 'ext4_mb_clear_bb' - different lock contexts for basic block
   fs/ext4/mballoc.c:6309:15: sparse: sparse: context imbalance in 'ext4_group_add_blocks' - different lock contexts for basic block
   fs/ext4/mballoc.c:3601:40: sparse: sparse: context imbalance in 'ext4_trim_extent' - wrong count at exit
   fs/ext4/mballoc.c:6400:9: sparse: sparse: context imbalance in 'ext4_try_to_trim_range' - different lock contexts for basic block
   fs/ext4/mballoc.c:6418:1: sparse: sparse: context imbalance in 'ext4_trim_all_free' - different lock contexts for basic block
   fs/ext4/mballoc.c:6560:1: sparse: sparse: context imbalance in 'ext4_mballoc_query_range' - different lock contexts for basic block
--
   WARNING: invalid argument to '-march': '_zihintpause'
>> drivers/clocksource/timer-clint.c:82:24: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/clocksource/timer-clint.c:82:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/clocksource/timer-clint.c:82:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/clocksource/timer-clint.c:82:24: sparse:     got unsigned int [usertype] *
   drivers/clocksource/timer-clint.c:80:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/clocksource/timer-clint.c:80:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/clocksource/timer-clint.c:80:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/clocksource/timer-clint.c:80:22: sparse:     got unsigned int [usertype] *
   drivers/clocksource/timer-clint.c:237:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void * @@     got struct clock_event_device [noderef] __percpu * @@
   drivers/clocksource/timer-clint.c:237:36: sparse:     expected void *
   drivers/clocksource/timer-clint.c:237:36: sparse:     got struct clock_event_device [noderef] __percpu *

vim +1204 arch/riscv/mm/init.c

671f9a3e2e24cd Anup Patel      2019-06-28  1154  
e53d28180d4d0f Nick Kossifidis 2021-04-19  1155  /*
e53d28180d4d0f Nick Kossifidis 2021-04-19  1156   * reserve_crashkernel() - reserves memory for crash kernel
e53d28180d4d0f Nick Kossifidis 2021-04-19  1157   *
e53d28180d4d0f Nick Kossifidis 2021-04-19  1158   * This function reserves memory area given in "crashkernel=" kernel command
e53d28180d4d0f Nick Kossifidis 2021-04-19  1159   * line parameter. The memory reserved is used by dump capture kernel when
e53d28180d4d0f Nick Kossifidis 2021-04-19  1160   * primary kernel is crashing.
e53d28180d4d0f Nick Kossifidis 2021-04-19  1161   */
e53d28180d4d0f Nick Kossifidis 2021-04-19  1162  static void __init reserve_crashkernel(void)
e53d28180d4d0f Nick Kossifidis 2021-04-19  1163  {
e53d28180d4d0f Nick Kossifidis 2021-04-19  1164  	unsigned long long crash_base = 0;
e53d28180d4d0f Nick Kossifidis 2021-04-19  1165  	unsigned long long crash_size = 0;
e53d28180d4d0f Nick Kossifidis 2021-04-19  1166  	unsigned long search_start = memblock_start_of_DRAM();
e53d28180d4d0f Nick Kossifidis 2021-04-19  1167  	unsigned long search_end = memblock_end_of_DRAM();
e53d28180d4d0f Nick Kossifidis 2021-04-19  1168  
e53d28180d4d0f Nick Kossifidis 2021-04-19  1169  	int ret = 0;
e53d28180d4d0f Nick Kossifidis 2021-04-19  1170  
d414cb379ac35e Jisheng Zhang   2022-03-23  1171  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
d414cb379ac35e Jisheng Zhang   2022-03-23  1172  		return;
5640975003d023 Nick Kossifidis 2021-04-19  1173  	/*
5640975003d023 Nick Kossifidis 2021-04-19  1174  	 * Don't reserve a region for a crash kernel on a crash kernel
5640975003d023 Nick Kossifidis 2021-04-19  1175  	 * since it doesn't make much sense and we have limited memory
5640975003d023 Nick Kossifidis 2021-04-19  1176  	 * resources.
5640975003d023 Nick Kossifidis 2021-04-19  1177  	 */
5640975003d023 Nick Kossifidis 2021-04-19  1178  	if (is_kdump_kernel()) {
5640975003d023 Nick Kossifidis 2021-04-19  1179  		pr_info("crashkernel: ignoring reservation request\n");
5640975003d023 Nick Kossifidis 2021-04-19  1180  		return;
5640975003d023 Nick Kossifidis 2021-04-19  1181  	}
5640975003d023 Nick Kossifidis 2021-04-19  1182  
e53d28180d4d0f Nick Kossifidis 2021-04-19  1183  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
e53d28180d4d0f Nick Kossifidis 2021-04-19  1184  				&crash_size, &crash_base);
e53d28180d4d0f Nick Kossifidis 2021-04-19  1185  	if (ret || !crash_size)
e53d28180d4d0f Nick Kossifidis 2021-04-19  1186  		return;
e53d28180d4d0f Nick Kossifidis 2021-04-19  1187  
e53d28180d4d0f Nick Kossifidis 2021-04-19  1188  	crash_size = PAGE_ALIGN(crash_size);
e53d28180d4d0f Nick Kossifidis 2021-04-19  1189  
a7259df7670240 Mike Rapoport   2021-09-02  1190  	if (crash_base) {
a7259df7670240 Mike Rapoport   2021-09-02  1191  		search_start = crash_base;
a7259df7670240 Mike Rapoport   2021-09-02  1192  		search_end = crash_base + crash_size;
a7259df7670240 Mike Rapoport   2021-09-02  1193  	}
a7259df7670240 Mike Rapoport   2021-09-02  1194  
e53d28180d4d0f Nick Kossifidis 2021-04-19  1195  	/*
e53d28180d4d0f Nick Kossifidis 2021-04-19  1196  	 * Current riscv boot protocol requires 2MB alignment for
e53d28180d4d0f Nick Kossifidis 2021-04-19  1197  	 * RV64 and 4MB alignment for RV32 (hugepage size)
decf89f86ecd3c Nick Kossifidis 2021-11-26  1198  	 *
decf89f86ecd3c Nick Kossifidis 2021-11-26  1199  	 * Try to alloc from 32bit addressible physical memory so that
decf89f86ecd3c Nick Kossifidis 2021-11-26  1200  	 * swiotlb can work on the crash kernel.
e53d28180d4d0f Nick Kossifidis 2021-04-19  1201  	 */
decf89f86ecd3c Nick Kossifidis 2021-11-26  1202  	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
decf89f86ecd3c Nick Kossifidis 2021-11-26  1203  					       search_start,
decf89f86ecd3c Nick Kossifidis 2021-11-26 @1204  					       min(search_end, (unsigned long) SZ_4G));
decf89f86ecd3c Nick Kossifidis 2021-11-26  1205  	if (crash_base == 0) {
decf89f86ecd3c Nick Kossifidis 2021-11-26  1206  		/* Try again without restricting region to 32bit addressible memory */
a7259df7670240 Mike Rapoport   2021-09-02  1207  		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
a7259df7670240 Mike Rapoport   2021-09-02  1208  						search_start, search_end);
e53d28180d4d0f Nick Kossifidis 2021-04-19  1209  		if (crash_base == 0) {
e53d28180d4d0f Nick Kossifidis 2021-04-19  1210  			pr_warn("crashkernel: couldn't allocate %lldKB\n",
e53d28180d4d0f Nick Kossifidis 2021-04-19  1211  				crash_size >> 10);
e53d28180d4d0f Nick Kossifidis 2021-04-19  1212  			return;
e53d28180d4d0f Nick Kossifidis 2021-04-19  1213  		}
decf89f86ecd3c Nick Kossifidis 2021-11-26  1214  	}
e53d28180d4d0f Nick Kossifidis 2021-04-19  1215  
e53d28180d4d0f Nick Kossifidis 2021-04-19  1216  	pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld MB)\n",
e53d28180d4d0f Nick Kossifidis 2021-04-19  1217  		crash_base, crash_base + crash_size, crash_size >> 20);
e53d28180d4d0f Nick Kossifidis 2021-04-19  1218  
e53d28180d4d0f Nick Kossifidis 2021-04-19  1219  	crashk_res.start = crash_base;
e53d28180d4d0f Nick Kossifidis 2021-04-19  1220  	crashk_res.end = crash_base + crash_size - 1;
e53d28180d4d0f Nick Kossifidis 2021-04-19  1221  }
e53d28180d4d0f Nick Kossifidis 2021-04-19  1222  

:::::: The code at line 1204 was first introduced by commit
:::::: decf89f86ecd3c3c3de81c562010d5797bea3de1 riscv: try to allocate crashkern region from 32bit addressible memory

:::::: TO: Nick Kossifidis <mick@ics.forth.gr>
:::::: CC: Palmer Dabbelt <palmer@rivosinc.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
