Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4145681662
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbjA3Q3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbjA3Q3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:29:17 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705795FD1;
        Mon, 30 Jan 2023 08:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675096156; x=1706632156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uOmtD6DCGmXjAqhlbykYDDLsIlNqsOOlSUyaWVTsLu8=;
  b=FOvTT9jJGOsKQPRiwwKgBGdsIpHBKpRtrcOU5cEvo26rRi6C7vUAfPIt
   mpY3jXgciAdYqWozUNQE6D/6z7AN3tAVCTGYrvvF8XmmG12nhUSz6/sF3
   jPLOa8cBxKaOOwWjfdlbeASLyJhZjveQcsbmnN4AZxoRfO2uEZj1I11Vx
   Ji2IbwsxuZN1Av1+e8/aeJxqyKnyFrubxz8PKmi3i+yO/ci7J1aNsVEqa
   Qd4zjDPmu1MCAQtQ/UJ2/V/QMmQJ22R3uNtYexRTbVhsxpqn0Rd1+LRs6
   T2bJkaD627qDFmPrxdlJQdOH6B0ufDtVlnV/cbuTxYovyR815+9vaYqXv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="328879381"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="328879381"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 08:29:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="664153599"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="664153599"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 Jan 2023 08:29:09 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMX1o-0003kM-2p;
        Mon, 30 Jan 2023 16:29:08 +0000
Date:   Tue, 31 Jan 2023 00:28:17 +0800
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
Subject: Re: [PATCH V8 5/6] arm64/perf: Add branch stack support in ARMV8 PMU
Message-ID: <202301310047.b5iv9hM8-lkp@intel.com>
References: <20230123125956.1350336-6-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123125956.1350336-6-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on tip/perf/core acme/perf/core linus/master v6.2-rc6 next-20230130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/drivers-perf-arm_pmu-Add-new-sched_task-callback/20230123-210254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230123125956.1350336-6-anshuman.khandual%40arm.com
patch subject: [PATCH V8 5/6] arm64/perf: Add branch stack support in ARMV8 PMU
config: arm64-randconfig-r016-20230130 (https://download.01.org/0day-ci/archive/20230131/202301310047.b5iv9hM8-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/0deba04ac45f8632b8579cb5cbf908b9f4428402
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anshuman-Khandual/drivers-perf-arm_pmu-Add-new-sched_task-callback/20230123-210254
        git checkout 0deba04ac45f8632b8579cb5cbf908b9f4428402
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/arm64/kernel/asm-offsets.c:15:
   In file included from include/linux/kvm_host.h:45:
   In file included from arch/arm64/include/asm/kvm_host.h:36:
   In file included from include/kvm/arm_pmu.h:11:
>> arch/arm64/include/asm/perf_event.h:280:20: warning: function 'has_branch_stack' has internal linkage but is not defined [-Wundefined-internal]
   static inline bool has_branch_stack(struct perf_event *event);
                      ^
   arch/arm64/include/asm/perf_event.h:284:16: note: used here
           WARN_ON_ONCE(!has_branch_stack(event));
                         ^
   1 warning generated.
--
   In file included from arch/arm64/kernel/asm-offsets.c:15:
   In file included from include/linux/kvm_host.h:45:
   In file included from arch/arm64/include/asm/kvm_host.h:36:
   In file included from include/kvm/arm_pmu.h:11:
>> arch/arm64/include/asm/perf_event.h:280:20: warning: function 'has_branch_stack' has internal linkage but is not defined [-Wundefined-internal]
   static inline bool has_branch_stack(struct perf_event *event);
                      ^
   arch/arm64/include/asm/perf_event.h:284:16: note: used here
           WARN_ON_ONCE(!has_branch_stack(event));
                         ^
   1 warning generated.


vim +/has_branch_stack +280 arch/arm64/include/asm/perf_event.h

   279	
 > 280	static inline bool has_branch_stack(struct perf_event *event);
   281	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
