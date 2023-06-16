Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BA3732554
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241119AbjFPCjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 22:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjFPCjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:39:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21F1297A;
        Thu, 15 Jun 2023 19:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686883149; x=1718419149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pzWK+3N8OVojlhb7ZbBZC2yBcASqhqN8Hpy+nQhF7h8=;
  b=fqdlzGgLFX/KqzzL4Suaw0oz1N250T5sJKl+wjCUjEcqS6zqg1KMBrO8
   qC5J4/4MeNcPQrSPLuqVojPM9ZVubBlWs4iapoasiP2wikB7/1X/f1qRl
   F/P56wSz1Q61HuisxgkKZUU67ph8G0l8G72Imf0sXNQS84LXVULPO8vWi
   lkP59D2g0uCtRQv0M4DDEWSy2xX8rhY47uajWSyuVzbItS+xIFsidZIfO
   U/qORy4apUvadvjFjpNK02MbA7+Ct/tNxZ2GmCAAMeYjUnAH++dLkDU3Z
   LuYBc6FyaE7C7trIU6fsTn2aPEDXF4PWboeNfK6fwKfQmOqcFxtBDhhhY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="348805548"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="348805548"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 19:39:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="857209759"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="857209759"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2023 19:39:04 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9zMd-0000hn-2k;
        Fri, 16 Jun 2023 02:39:03 +0000
Date:   Fri, 16 Jun 2023 10:38:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V12 07/10] arm64/perf: Add PERF_ATTACH_TASK_DATA to
 events with has_branch_stack()
Message-ID: <202306161016.jJeqG6mc-lkp@intel.com>
References: <20230615133239.442736-8-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615133239.442736-8-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on tip/perf/core acme/perf/core linus/master v6.4-rc6 next-20230615]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/drivers-perf-arm_pmu-Add-new-sched_task-callback/20230615-223352
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230615133239.442736-8-anshuman.khandual%40arm.com
patch subject: [PATCH V12 07/10] arm64/perf: Add PERF_ATTACH_TASK_DATA to events with has_branch_stack()
config: arm-randconfig-r004-20230615 (https://download.01.org/0day-ci/archive/20230616/202306161016.jJeqG6mc-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add arm64 https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
        git fetch arm64 for-next/core
        git checkout arm64/for-next/core
        b4 shazam https://lore.kernel.org/r/20230615133239.442736-8-anshuman.khandual@arm.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/perf/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306161016.jJeqG6mc-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/perf/arm_pmuv3.c:148:45: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     148 |         [C(DTLB)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR,
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:134:44: note: expanded from macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR'
     134 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR                         0x004F
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:140:2: note: previous initialization is here
     140 |         PERF_CACHE_MAP_ALL_UNSUPPORTED,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:43:31: note: expanded from macro 'PERF_CACHE_MAP_ALL_UNSUPPORTED'
      43 |                 [0 ... C(RESULT_MAX) - 1] = CACHE_OP_UNSUPPORTED,       \
         |                                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:35:31: note: expanded from macro 'CACHE_OP_UNSUPPORTED'
      35 | #define CACHE_OP_UNSUPPORTED            0xFFFF
         |                                         ^~~~~~
   drivers/perf/arm_pmuv3.c:149:42: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     149 |         [C(DTLB)][C(OP_READ)][C(RESULT_MISS)]   = ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:131:50: note: expanded from macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD'
     131 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD                  0x004C
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:140:2: note: previous initialization is here
     140 |         PERF_CACHE_MAP_ALL_UNSUPPORTED,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:43:31: note: expanded from macro 'PERF_CACHE_MAP_ALL_UNSUPPORTED'
      43 |                 [0 ... C(RESULT_MAX) - 1] = CACHE_OP_UNSUPPORTED,       \
         |                                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:35:31: note: expanded from macro 'CACHE_OP_UNSUPPORTED'
      35 | #define CACHE_OP_UNSUPPORTED            0xFFFF
         |                                         ^~~~~~
   drivers/perf/arm_pmuv3.c:150:43: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     150 |         [C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]  = ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:132:50: note: expanded from macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR'
     132 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR                  0x004D
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:140:2: note: previous initialization is here
     140 |         PERF_CACHE_MAP_ALL_UNSUPPORTED,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:43:31: note: expanded from macro 'PERF_CACHE_MAP_ALL_UNSUPPORTED'
      43 |                 [0 ... C(RESULT_MAX) - 1] = CACHE_OP_UNSUPPORTED,       \
         |                                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:35:31: note: expanded from macro 'CACHE_OP_UNSUPPORTED'
      35 | #define CACHE_OP_UNSUPPORTED            0xFFFF
         |                                         ^~~~~~
   drivers/perf/arm_pmuv3.c:152:44: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     152 |         [C(NODE)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:148:46: note: expanded from macro 'ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD'
     148 | #define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD                      0x0060
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:140:2: note: previous initialization is here
     140 |         PERF_CACHE_MAP_ALL_UNSUPPORTED,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:43:31: note: expanded from macro 'PERF_CACHE_MAP_ALL_UNSUPPORTED'
      43 |                 [0 ... C(RESULT_MAX) - 1] = CACHE_OP_UNSUPPORTED,       \
         |                                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:35:31: note: expanded from macro 'CACHE_OP_UNSUPPORTED'
      35 | #define CACHE_OP_UNSUPPORTED            0xFFFF
         |                                         ^~~~~~
   drivers/perf/arm_pmuv3.c:153:45: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     153 |         [C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR,
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:149:46: note: expanded from macro 'ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR'
     149 | #define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR                      0x0061
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:140:2: note: previous initialization is here
     140 |         PERF_CACHE_MAP_ALL_UNSUPPORTED,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:43:31: note: expanded from macro 'PERF_CACHE_MAP_ALL_UNSUPPORTED'
      43 |                 [0 ... C(RESULT_MAX) - 1] = CACHE_OP_UNSUPPORTED,       \
         |                                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:35:31: note: expanded from macro 'CACHE_OP_UNSUPPORTED'
      35 | #define CACHE_OP_UNSUPPORTED            0xFFFF
         |                                         ^~~~~~
   drivers/perf/arm_pmuv3.c:714:3: error: call to undeclared function 'armv8pmu_branch_enable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     714 |                 armv8pmu_branch_enable(event);
         |                 ^
   drivers/perf/arm_pmuv3.c:720:3: error: call to undeclared function 'armv8pmu_branch_disable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     720 |                 armv8pmu_branch_disable(event);
         |                 ^
   drivers/perf/arm_pmuv3.c:805:4: error: call to undeclared function 'armv8pmu_branch_read'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     805 |                         armv8pmu_branch_read(cpuc, event);
         |                         ^
   drivers/perf/arm_pmuv3.c:805:4: note: did you mean 'armv8pmu_pmcr_read'?
   drivers/perf/arm_pmuv3.c:430:19: note: 'armv8pmu_pmcr_read' declared here
     430 | static inline u32 armv8pmu_pmcr_read(void)
         |                   ^
   drivers/perf/arm_pmuv3.c:912:3: error: call to undeclared function 'armv8pmu_branch_reset'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     912 |                 armv8pmu_branch_reset();
         |                 ^
   drivers/perf/arm_pmuv3.c:987:3: error: call to undeclared function 'armv8pmu_branch_reset'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     987 |                 armv8pmu_branch_reset();
         |                 ^
   drivers/perf/arm_pmuv3.c:1026:8: error: call to undeclared function 'armv8pmu_branch_attr_valid'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1026 |                 if (!armv8pmu_branch_attr_valid(event))
         |                      ^
   drivers/perf/arm_pmuv3.c:1148:2: error: call to undeclared function 'armv8pmu_branch_probe'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1148 |         armv8pmu_branch_probe(cpu_pmu);
         |         ^
>> drivers/perf/arm_pmuv3.c:1195:9: error: call to undeclared function 'armv8pmu_task_ctx_cache_alloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1195 |                 ret = armv8pmu_task_ctx_cache_alloc(cpu_pmu);
         |                       ^
>> drivers/perf/arm_pmuv3.c:1201:4: error: call to undeclared function 'armv8pmu_task_ctx_cache_free'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1201 |                         armv8pmu_task_ctx_cache_free(cpu_pmu);
         |                         ^
   55 warnings and 9 errors generated.


vim +/armv8pmu_task_ctx_cache_alloc +1195 drivers/perf/arm_pmuv3.c

  1176	
  1177	static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
  1178	{
  1179		struct armv8pmu_probe_info probe = {
  1180			.pmu = cpu_pmu,
  1181			.present = false,
  1182		};
  1183		int ret;
  1184	
  1185		ret = smp_call_function_any(&cpu_pmu->supported_cpus,
  1186					    __armv8pmu_probe_pmu,
  1187					    &probe, 1);
  1188		if (ret)
  1189			return ret;
  1190	
  1191		if (!probe.present)
  1192			return -ENODEV;
  1193	
  1194		if (cpu_pmu->has_branch_stack) {
> 1195			ret = armv8pmu_task_ctx_cache_alloc(cpu_pmu);
  1196			if (ret)
  1197				return ret;
  1198	
  1199			ret = branch_records_alloc(cpu_pmu);
  1200			if (ret) {
> 1201				armv8pmu_task_ctx_cache_free(cpu_pmu);
  1202				return ret;
  1203			}
  1204		}
  1205		return 0;
  1206	}
  1207	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
