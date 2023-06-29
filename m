Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808D9741DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjF2CDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjF2CDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:03:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B6E1FC1;
        Wed, 28 Jun 2023 19:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688004191; x=1719540191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MqID3aXABUv7nc8CmrZcB8I0Vz3+y578ADvOER6lS44=;
  b=JlJ3riuJ1I25WpwwluRx2/bcM20XZ8SfPB0nxU/3rFNFTp8+BIt6eZ8+
   PMjxwoXzesFrd+DxKrg0ga+2YAwwG6KUAoetZFRR5zlz+zyXjkqv+Oxut
   EWouaL7/eT9BAHCS+pjexntJm0EfnF9HIQsgfn1j+X/uMwjsfcgNF2oH1
   UmNlkE5reiAVQKk+8l/B11dPgn2dGG1k8AFan1kKfAfmlZWfaZWVF2XWL
   p22Qsbm5zV1SpS/CoGzNqdDkP6eRm5HiPvKTz0EQjXDbnfLCH+etijwrH
   jiXoU+C1eRsSf6xX3MU3Nv1BajX5+aCoOvuMr13cVVzL0X756nuz7KIEA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="392726375"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="392726375"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 19:03:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="1047611857"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="1047611857"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2023 19:03:04 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEgzv-000DgL-2I;
        Thu, 29 Jun 2023 02:03:03 +0000
Date:   Thu, 29 Jun 2023 10:02:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix scaling for hybrid capable
 system with disabled E-cores
Message-ID: <202306290948.ThmHeSqf-lkp@intel.com>
References: <20230628225341.3718351-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628225341.3718351-1-srinivas.pandruvada@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linus/master v6.4 next-20230628]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Srinivas-Pandruvada/cpufreq-intel_pstate-Fix-scaling-for-hybrid-capable-system-with-disabled-E-cores/20230629-065506
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230628225341.3718351-1-srinivas.pandruvada%40linux.intel.com
patch subject: [PATCH] cpufreq: intel_pstate: Fix scaling for hybrid capable system with disabled E-cores
config: i386-buildonly-randconfig-r004-20230628 (https://download.01.org/0day-ci/archive/20230629/202306290948.ThmHeSqf-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230629/202306290948.ThmHeSqf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306290948.ThmHeSqf-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cpufreq/intel_pstate.c:1975:10: error: use of undeclared identifier 'HYBRID_SCALING_FACTOR'
                   return HYBRID_SCALING_FACTOR;
                          ^
>> drivers/cpufreq/intel_pstate.c:1979:10: error: call to undeclared function 'core_get_scaling'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                   return core_get_scaling();
                          ^
   drivers/cpufreq/intel_pstate.c:1979:10: note: did you mean 'core_get_val'?
   drivers/cpufreq/intel_pstate.c:1932:12: note: 'core_get_val' declared here
   static u64 core_get_val(struct cpudata *cpudata, int pstate)
              ^
>> drivers/cpufreq/intel_pstate.c:1990:9: error: call to undeclared function 'intel_pstate_cppc_get_scaling'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           return intel_pstate_cppc_get_scaling(cpu);
                  ^
>> drivers/cpufreq/intel_pstate.c:2350:17: error: use of undeclared identifier 'core_get_scaling'; did you mean 'core_get_val'?
           .get_scaling = core_get_scaling,
                          ^~~~~~~~~~~~~~~~
                          core_get_val
   drivers/cpufreq/intel_pstate.c:1932:12: note: 'core_get_val' declared here
   static u64 core_get_val(struct cpudata *cpudata, int pstate)
              ^
>> drivers/cpufreq/intel_pstate.c:2350:17: error: incompatible function pointer types initializing 'int (*)(void)' with an expression of type 'u64 (struct cpudata *, int)' (aka 'unsigned long long (struct cpudata *, int)') [-Werror,-Wincompatible-function-pointer-types]
           .get_scaling = core_get_scaling,
                          ^~~~~~~~~~~~~~~~
   drivers/cpufreq/intel_pstate.c:2380:17: error: use of undeclared identifier 'core_get_scaling'; did you mean 'core_get_val'?
           .get_scaling = core_get_scaling,
                          ^~~~~~~~~~~~~~~~
                          core_get_val
   drivers/cpufreq/intel_pstate.c:1932:12: note: 'core_get_val' declared here
   static u64 core_get_val(struct cpudata *cpudata, int pstate)
              ^
   drivers/cpufreq/intel_pstate.c:2380:17: error: incompatible function pointer types initializing 'int (*)(void)' with an expression of type 'u64 (struct cpudata *, int)' (aka 'unsigned long long (struct cpudata *, int)') [-Werror,-Wincompatible-function-pointer-types]
           .get_scaling = core_get_scaling,
                          ^~~~~~~~~~~~~~~~
   7 errors generated.


vim +/HYBRID_SCALING_FACTOR +1975 drivers/cpufreq/intel_pstate.c

  1967	
  1968	static int hwp_get_cpu_scaling(int cpu)
  1969	{
  1970		u8 cpu_type = 0;
  1971	
  1972		smp_call_function_single(cpu, hybrid_get_type, &cpu_type, 1);
  1973		/* P-cores have a smaller perf level-to-freqency scaling factor. */
  1974		if (cpu_type == 0x40)
> 1975			return HYBRID_SCALING_FACTOR;
  1976	
  1977		/* Use default core scaling for E-cores */
  1978		if (cpu_type == 0x20)
> 1979			return core_get_scaling();
  1980	
  1981		/*
  1982		 * If reached here, it means that, this system is either non
  1983		 * hybrid system (like Tiger Lake) or hybrid capable system (like
  1984		 * Alder Lake or Raptor Lake) with no E cores (CPUID for hybrid
  1985		 * support is 0).
  1986		 * All non hybrid systems, don't publish nominal_frequency
  1987		 * field (means nominal frequency = 0), In that case
  1988		 * the legacy core scaling is used.
  1989		 */
> 1990		return intel_pstate_cppc_get_scaling(cpu);
  1991	}
  1992	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
