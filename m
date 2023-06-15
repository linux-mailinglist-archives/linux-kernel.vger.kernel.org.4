Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9A67323C4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbjFOXnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjFOXnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:43:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94742944;
        Thu, 15 Jun 2023 16:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686872581; x=1718408581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r6vXAZRMM8jz4HYHkJuenkNailiSitrdhhkjTx4UB9o=;
  b=hxVgGTMcPkZ8kusNYLS1URC/yN6TWhkhGk+RzcW0bK56fq6KqRuImhPO
   O4UlIAuYAFfob021bLRHPid/Miy8kpnb8oUlsGJMzlxKPTVaAHFfm71MV
   UdAnAbkJ1LMiAeiRfbtxXoHJDNcgwBT1hDT6mVXuAip/eCko53Rw9sXer
   pRw1pbzwlLb56M5t9JuwCQC1eVvU1rfHM6P0UYGXUp/38RQTZK77rEHBk
   RmbND76DaUivT1TEjxY2MW5kPbMIjPna1PJp8+GRQFjv1Di6GWbxQngvw
   CpTpGvHOJURIAwcKxbkrkEQeYOB3gGkm1hqYvzUopExpX24O/XXJVPzh2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="424998491"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="424998491"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 16:43:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="782675963"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="782675963"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2023 16:42:56 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9wcC-0000WL-0W;
        Thu, 15 Jun 2023 23:42:56 +0000
Date:   Fri, 16 Jun 2023 07:42:01 +0800
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
Subject: Re: [PATCH V12 05/10] arm64/perf: Add branch stack support in ARMV8
 PMU
Message-ID: <202306160706.Uei5XDoi-lkp@intel.com>
References: <20230615133239.442736-6-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615133239.442736-6-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/20230615133239.442736-6-anshuman.khandual%40arm.com
patch subject: [PATCH V12 05/10] arm64/perf: Add branch stack support in ARMV8 PMU
config: arm-randconfig-r004-20230615 (https://download.01.org/0day-ci/archive/20230616/202306160706.Uei5XDoi-lkp@intel.com/config)
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
        b4 shazam https://lore.kernel.org/r/20230615133239.442736-6-anshuman.khandual@arm.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/perf/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306160706.Uei5XDoi-lkp@intel.com/

All errors (new ones prefixed by >>):

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
   drivers/perf/arm_pmuv3.c:147:44: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     147 |         [C(DTLB)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:133:44: note: expanded from macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD'
     133 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD                         0x004E
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
>> drivers/perf/arm_pmuv3.c:714:3: error: call to undeclared function 'armv8pmu_branch_enable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     714 |                 armv8pmu_branch_enable(event);
         |                 ^
>> drivers/perf/arm_pmuv3.c:720:3: error: call to undeclared function 'armv8pmu_branch_disable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     720 |                 armv8pmu_branch_disable(event);
         |                 ^
>> drivers/perf/arm_pmuv3.c:801:4: error: call to undeclared function 'armv8pmu_branch_read'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     801 |                         armv8pmu_branch_read(cpuc, event);
         |                         ^
   drivers/perf/arm_pmuv3.c:801:4: note: did you mean 'armv8pmu_pmcr_read'?
   drivers/perf/arm_pmuv3.c:430:19: note: 'armv8pmu_pmcr_read' declared here
     430 | static inline u32 armv8pmu_pmcr_read(void)
         |                   ^
>> drivers/perf/arm_pmuv3.c:908:3: error: call to undeclared function 'armv8pmu_branch_reset'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     908 |                 armv8pmu_branch_reset();
         |                 ^
   drivers/perf/arm_pmuv3.c:983:3: error: call to undeclared function 'armv8pmu_branch_reset'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     983 |                 armv8pmu_branch_reset();
         |                 ^
>> drivers/perf/arm_pmuv3.c:1021:34: error: call to undeclared function 'armv8pmu_branch_attr_valid'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1021 |         if (has_branch_stack(event) && !armv8pmu_branch_attr_valid(event))
         |                                         ^
>> drivers/perf/arm_pmuv3.c:1140:2: error: call to undeclared function 'armv8pmu_branch_probe'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1140 |         armv8pmu_branch_probe(cpu_pmu);
         |         ^
   55 warnings and 7 errors generated.


vim +/armv8pmu_branch_enable +714 drivers/perf/arm_pmuv3.c

   701	
   702	static void armv8pmu_enable_event(struct perf_event *event)
   703	{
   704		/*
   705		 * Enable counter and interrupt, and set the counter to count
   706		 * the event that we're interested in.
   707		 */
   708		armv8pmu_disable_event_counter(event);
   709		armv8pmu_write_event_type(event);
   710		armv8pmu_enable_event_irq(event);
   711		armv8pmu_enable_event_counter(event);
   712	
   713		if (has_branch_stack(event))
 > 714			armv8pmu_branch_enable(event);
   715	}
   716	
   717	static void armv8pmu_disable_event(struct perf_event *event)
   718	{
   719		if (has_branch_stack(event))
 > 720			armv8pmu_branch_disable(event);
   721	
   722		armv8pmu_disable_event_counter(event);
   723		armv8pmu_disable_event_irq(event);
   724	}
   725	
   726	static void armv8pmu_start(struct arm_pmu *cpu_pmu)
   727	{
   728		struct perf_event_context *ctx;
   729		int nr_user = 0;
   730	
   731		ctx = perf_cpu_task_ctx();
   732		if (ctx)
   733			nr_user = ctx->nr_user;
   734	
   735		if (sysctl_perf_user_access && nr_user)
   736			armv8pmu_enable_user_access(cpu_pmu);
   737		else
   738			armv8pmu_disable_user_access();
   739	
   740		/* Enable all counters */
   741		armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
   742	}
   743	
   744	static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
   745	{
   746		/* Disable all counters */
   747		armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
   748	}
   749	
   750	static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
   751	{
   752		u32 pmovsr;
   753		struct perf_sample_data data;
   754		struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
   755		struct pt_regs *regs;
   756		int idx;
   757	
   758		/*
   759		 * Get and reset the IRQ flags
   760		 */
   761		pmovsr = armv8pmu_getreset_flags();
   762	
   763		/*
   764		 * Did an overflow occur?
   765		 */
   766		if (!armv8pmu_has_overflowed(pmovsr))
   767			return IRQ_NONE;
   768	
   769		/*
   770		 * Handle the counter(s) overflow(s)
   771		 */
   772		regs = get_irq_regs();
   773	
   774		/*
   775		 * Stop the PMU while processing the counter overflows
   776		 * to prevent skews in group events.
   777		 */
   778		armv8pmu_stop(cpu_pmu);
   779		for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
   780			struct perf_event *event = cpuc->events[idx];
   781			struct hw_perf_event *hwc;
   782	
   783			/* Ignore if we don't have an event. */
   784			if (!event)
   785				continue;
   786	
   787			/*
   788			 * We have a single interrupt for all counters. Check that
   789			 * each counter has overflowed before we process it.
   790			 */
   791			if (!armv8pmu_counter_has_overflowed(pmovsr, idx))
   792				continue;
   793	
   794			hwc = &event->hw;
   795			armpmu_event_update(event);
   796			perf_sample_data_init(&data, 0, hwc->last_period);
   797			if (!armpmu_event_set_period(event))
   798				continue;
   799	
   800			if (has_branch_stack(event) && !WARN_ON(!cpuc->branches)) {
 > 801				armv8pmu_branch_read(cpuc, event);
   802				perf_sample_save_brstack(&data, event, &cpuc->branches->branch_stack);
   803			}
   804	
   805			/*
   806			 * Perf event overflow will queue the processing of the event as
   807			 * an irq_work which will be taken care of in the handling of
   808			 * IPI_IRQ_WORK.
   809			 */
   810			if (perf_event_overflow(event, &data, regs))
   811				cpu_pmu->disable(event);
   812		}
   813		armv8pmu_start(cpu_pmu);
   814	
   815		return IRQ_HANDLED;
   816	}
   817	
   818	static int armv8pmu_get_single_idx(struct pmu_hw_events *cpuc,
   819					    struct arm_pmu *cpu_pmu)
   820	{
   821		int idx;
   822	
   823		for (idx = ARMV8_IDX_COUNTER0; idx < cpu_pmu->num_events; idx++) {
   824			if (!test_and_set_bit(idx, cpuc->used_mask))
   825				return idx;
   826		}
   827		return -EAGAIN;
   828	}
   829	
   830	static int armv8pmu_get_chain_idx(struct pmu_hw_events *cpuc,
   831					   struct arm_pmu *cpu_pmu)
   832	{
   833		int idx;
   834	
   835		/*
   836		 * Chaining requires two consecutive event counters, where
   837		 * the lower idx must be even.
   838		 */
   839		for (idx = ARMV8_IDX_COUNTER0 + 1; idx < cpu_pmu->num_events; idx += 2) {
   840			if (!test_and_set_bit(idx, cpuc->used_mask)) {
   841				/* Check if the preceding even counter is available */
   842				if (!test_and_set_bit(idx - 1, cpuc->used_mask))
   843					return idx;
   844				/* Release the Odd counter */
   845				clear_bit(idx, cpuc->used_mask);
   846			}
   847		}
   848		return -EAGAIN;
   849	}
   850	
   851	static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
   852					  struct perf_event *event)
   853	{
   854		struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
   855		struct hw_perf_event *hwc = &event->hw;
   856		unsigned long evtype = hwc->config_base & ARMV8_PMU_EVTYPE_EVENT;
   857	
   858		/* Always prefer to place a cycle counter into the cycle counter. */
   859		if (evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) {
   860			if (!test_and_set_bit(ARMV8_IDX_CYCLE_COUNTER, cpuc->used_mask))
   861				return ARMV8_IDX_CYCLE_COUNTER;
   862			else if (armv8pmu_event_is_64bit(event) &&
   863				   armv8pmu_event_want_user_access(event) &&
   864				   !armv8pmu_has_long_event(cpu_pmu))
   865					return -EAGAIN;
   866		}
   867	
   868		/*
   869		 * Otherwise use events counters
   870		 */
   871		if (armv8pmu_event_is_chained(event))
   872			return	armv8pmu_get_chain_idx(cpuc, cpu_pmu);
   873		else
   874			return armv8pmu_get_single_idx(cpuc, cpu_pmu);
   875	}
   876	
   877	static void armv8pmu_clear_event_idx(struct pmu_hw_events *cpuc,
   878					     struct perf_event *event)
   879	{
   880		int idx = event->hw.idx;
   881	
   882		clear_bit(idx, cpuc->used_mask);
   883		if (armv8pmu_event_is_chained(event))
   884			clear_bit(idx - 1, cpuc->used_mask);
   885	}
   886	
   887	static int armv8pmu_user_event_idx(struct perf_event *event)
   888	{
   889		if (!sysctl_perf_user_access || !armv8pmu_event_has_user_read(event))
   890			return 0;
   891	
   892		/*
   893		 * We remap the cycle counter index to 32 to
   894		 * match the offset applied to the rest of
   895		 * the counter indices.
   896		 */
   897		if (event->hw.idx == ARMV8_IDX_CYCLE_COUNTER)
   898			return ARMV8_IDX_CYCLE_COUNTER_USER;
   899	
   900		return event->hw.idx;
   901	}
   902	
   903	static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
   904	{
   905		struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
   906	
   907		if (sched_in && armpmu->has_branch_stack)
 > 908			armv8pmu_branch_reset();
   909	}
   910	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
