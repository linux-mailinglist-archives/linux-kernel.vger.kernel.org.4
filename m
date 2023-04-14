Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3B16E1A04
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 04:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjDNCK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 22:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjDNCKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 22:10:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECF9469F;
        Thu, 13 Apr 2023 19:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681438219; x=1712974219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IeRnQ+CQcJwGbjz4GOR0Cyk0yJ9hc73wDuZH6+tv/hs=;
  b=VVh5p2RbrIAjo6tMF+mJPdfARgoKhekd7hod6ZelYODYXzZVmz546dW5
   p24eJOussYsgk/0qrTZvsYAO1LMo/m/48X3NayRYmyJsOzmXJ1IBjDd4f
   UJPJydPvr1rQHE3lXOpc8byGJfNaAaILFDCWn/j70QlI0yYI26qlLWcZD
   HbWyE8VJJgUbXksrDTbGxyPzQgW9nnSe8V7B9Jy0RTOzo1Fy96hgBXiY+
   2aEas+MNdEcHPPIuBdoulp2UoqrHc4mVgS6Q5dmMa25udtlMLV/ZQGxGS
   1Ym8FfJBCQAmD4MZOnsAyWs0umkxwVQASDrq/WzJK5nXFWPzONLFSEUXm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="372222356"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="372222356"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 19:10:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="720102853"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="720102853"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 13 Apr 2023 19:10:11 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pn8t8-000Z8D-0o;
        Fri, 14 Apr 2023 02:10:10 +0000
Date:   Fri, 14 Apr 2023 10:09:43 +0800
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
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH 4/4] riscv: Enable perf counters user access only through
 perf
Message-ID: <202304140904.9oAVhFHu-lkp@intel.com>
References: <20230413161725.195417-5-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413161725.195417-5-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
config: riscv-randconfig-r036-20230412 (https://download.01.org/0day-ci/archive/20230414/202304140904.9oAVhFHu-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 9638da200e00bd069e6dd63604e14cbafede9324)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/8ca9b21cbf2c0b91ee35356c01aef9da7d874e55
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alexandre-Ghiti/perf-Fix-wrong-comment-about-default-event_idx/20230414-002232
        git checkout 8ca9b21cbf2c0b91ee35356c01aef9da7d874e55
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304140904.9oAVhFHu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/riscv/kernel/perf_event.c:8:28: error: call to undeclared function 'to_riscv_pmu'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
                                     ^
>> arch/riscv/kernel/perf_event.c:8:20: error: incompatible integer to pointer conversion initializing 'struct riscv_pmu *' with an expression of type 'int' [-Wint-conversion]
           struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
                             ^       ~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/kernel/perf_event.c:24:27: error: incomplete definition of type 'struct riscv_pmu'
           userpg->pmc_width = rvpmu->ctr_get_width(event->hw.idx) + 1;
                               ~~~~~^
   arch/riscv/kernel/perf_event.c:8:9: note: forward declaration of 'struct riscv_pmu'
           struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
                  ^
   3 errors generated.


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
