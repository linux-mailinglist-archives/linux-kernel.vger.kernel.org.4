Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3BA6E1666
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 23:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjDMVVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 17:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDMVVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 17:21:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED698A52;
        Thu, 13 Apr 2023 14:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681420870; x=1712956870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AKA702wfwd4hTzA6smF9r2CZKN4Rw0ra4U6x0QD6JK8=;
  b=X8ycxHK4W8av08LzrQSxwxU2EyciMWxixQmkJItki/gh6ajsTLxxDCjy
   k3Z2Iim4lKs9WtVHhW3vnGAc9msThRVeOHpJYPrFzKki3z1Gjx5fhRnMQ
   +cMqp+Y39rnhSRTAs7Ik14vfCHhZrSEz3G8S+Hr+eCmIgFxPtfkeRwIFP
   u09cPhWwRuFVzG603k7YejSMsRsygfP5m/rpTkHFQqcHC6ir5zX9irWRM
   +SpHADWpXP2RtweBwRNzw08b6BqMxYtG5Tf3gwi5Er9NLI7nmYt+6FDYk
   aJfZhc8E6eysZxcSnfHRVSTJa4FAqNm9uhhfxQpoXtDTmmZ2B+RFV3eDA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="333062564"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="333062564"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 14:21:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="800938703"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="800938703"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 Apr 2023 14:21:03 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pn4NK-000YxN-2T;
        Thu, 13 Apr 2023 21:21:02 +0000
Date:   Fri, 14 Apr 2023 05:20:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH 4/4] riscv: Enable perf counters user access only through
 perf
Message-ID: <202304140522.RGhxahvD-lkp@intel.com>
References: <20230413161725.195417-5-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413161725.195417-5-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on acme/perf/core tip/master tip/auto-latest linus/master v6.3-rc6]
[cannot apply to next-20230413]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/perf-Fix-wrong-comment-about-default-event_idx/20230414-002232
patch link:    https://lore.kernel.org/r/20230413161725.195417-5-alexghiti%40rivosinc.com
patch subject: [PATCH 4/4] riscv: Enable perf counters user access only through perf
config: riscv-randconfig-r021-20230412 (https://download.01.org/0day-ci/archive/20230414/202304140522.RGhxahvD-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8ca9b21cbf2c0b91ee35356c01aef9da7d874e55
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alexandre-Ghiti/perf-Fix-wrong-comment-about-default-event_idx/20230414-002232
        git checkout 8ca9b21cbf2c0b91ee35356c01aef9da7d874e55
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304140522.RGhxahvD-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   arch/riscv/kernel/perf_event.c: In function 'arch_perf_update_userpage':
>> arch/riscv/kernel/perf_event.c:8:35: error: implicit declaration of function 'to_riscv_pmu' [-Werror=implicit-function-declaration]
       8 |         struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
         |                                   ^~~~~~~~~~~~
>> arch/riscv/kernel/perf_event.c:8:35: warning: initialization of 'struct riscv_pmu *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>> arch/riscv/kernel/perf_event.c:24:34: error: invalid use of undefined type 'struct riscv_pmu'
      24 |         userpg->pmc_width = rvpmu->ctr_get_width(event->hw.idx) + 1;
         |                                  ^~
   cc1: some warnings being treated as errors


vim +/to_riscv_pmu +8 arch/riscv/kernel/perf_event.c

     4	
     5	void arch_perf_update_userpage(struct perf_event *event,
     6				       struct perf_event_mmap_page *userpg, u64 now)
     7	{
   > 8		struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
     9		struct clock_read_data *rd;
    10		unsigned int seq;
    11		u64 ns;
    12	
    13		userpg->cap_user_time = 0;
    14		userpg->cap_user_time_zero = 0;
    15		userpg->cap_user_time_short = 0;
    16		userpg->cap_user_rdpmc =
    17			!!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
    18	
    19		/*
    20		 * The counters are 64-bit but the priv spec doesn't mandate all the
    21		 * bits to be implemented: that's why, counter width can vary based on
    22		 * the cpu vendor.
    23		 */
  > 24		userpg->pmc_width = rvpmu->ctr_get_width(event->hw.idx) + 1;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
