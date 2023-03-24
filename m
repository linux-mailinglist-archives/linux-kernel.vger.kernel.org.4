Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F216C8806
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjCXWFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjCXWEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:04:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7BA1F483;
        Fri, 24 Mar 2023 15:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679695485; x=1711231485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZQpATWAgpEfOHRwSw8qlhWylXSqgSyK9oPTTEvQRcTA=;
  b=lbmgLRR+LzYMHT7BH1lYPmtKbREJqhaEHWMGvhmED2q2NBIygQw5Jxx6
   SDSGonwDldT1es6I0U72hRNhAgVGZt1cjZhsDiPTyNWqqj0VnGZq1XLwJ
   Hk0VIoI/0RLRKJ8Vyzhg1vet63EFmSVPP7HzaEUzF6uh8rMKvbcZGp6n7
   onBx3DfjB1s6nO5ekSQpMF/jsJhMqDuX/EHL+n3IUuDT4prBbHmjuO+fx
   dMbGfE4Gi9Lfkagu8mZ8so/zp7kAPQJwtlfAeI641WuYK/gtRgLtjviaR
   Bc1kClxLfgsZXUQrJf3k2ZvauympUf6hgEAkaylgyBFfHuGxJx+mFw7rI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="338616643"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="338616643"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 15:04:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="806827965"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="806827965"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2023 15:04:40 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfpWU-000Fh7-2n;
        Fri, 24 Mar 2023 22:04:34 +0000
Date:   Sat, 25 Mar 2023 06:03:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Liang Kan <kan.liang@linux.intel.com>,
        linux-cxl@vger.kernel.org, peterz@infradead.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        will@kernel.org, dan.j.williams@intel.com, linuxarm@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2 4/5] cxl: CXL Performance Monitoring Unit driver
Message-ID: <202303250546.ijiFKIpM-lkp@intel.com>
References: <20230324171313.18448-5-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324171313.18448-5-Jonathan.Cameron@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on acme/perf/core]
[also build test WARNING on tip/perf/core cxl/next cxl/pending linus/master v6.3-rc3 next-20230324]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Cameron/cxl-Add-function-to-count-regblocks-of-a-given-type/20230325-011827
base:   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
patch link:    https://lore.kernel.org/r/20230324171313.18448-5-Jonathan.Cameron%40huawei.com
patch subject: [PATCH v2 4/5] cxl: CXL Performance Monitoring Unit driver
config: i386-randconfig-a004 (https://download.01.org/0day-ci/archive/20230325/202303250546.ijiFKIpM-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a04f0052a1fa10bda54569c8c7b3ab7fe60ca975
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jonathan-Cameron/cxl-Add-function-to-count-regblocks-of-a-given-type/20230325-011827
        git checkout a04f0052a1fa10bda54569c8c7b3ab7fe60ca975
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/cxl/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303250546.ijiFKIpM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/cxl/cpmu.c:101:8: error: implicit declaration of function 'readq' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           val = readq(base + CPMU_CAP_REG);
                 ^
   drivers/cxl/cpmu.c:559:3: error: implicit declaration of function 'writeq' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   writeq(0, base + CPMU_FREEZE_REG);
                   ^
   drivers/cxl/cpmu.c:578:3: error: implicit declaration of function 'writeq' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   writeq(GENMASK(63, 0), base + CPMU_FREEZE_REG);
                   ^
>> drivers/cxl/cpmu.c:578:10: warning: shift count is negative [-Wshift-count-negative]
                   writeq(GENMASK(63, 0), base + CPMU_FREEZE_REG);
                          ^~~~~~~~~~~~~~
   include/linux/bits.h:37:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:35:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:605:3: error: implicit declaration of function 'writeq' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   writeq(cfg, base + CPMU_FILTER_CFG_REG(hwc->idx, 0));
                   ^
   drivers/cxl/cpmu.c:608:8: error: implicit declaration of function 'readq' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           cfg = readq(base + CPMU_COUNTER_CFG_REG(hwc->idx));
                 ^
   drivers/cxl/cpmu.c:630:2: error: implicit declaration of function 'writeq' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           writeq(cfg, base + CPMU_COUNTER_CFG_REG(hwc->idx));
           ^
   drivers/cxl/cpmu.c:648:9: error: implicit declaration of function 'readq' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return readq(base + CPMU_COUNTER_REG(event->hw.idx));
                  ^
   drivers/cxl/cpmu.c:689:8: error: implicit declaration of function 'readq' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           cfg = readq(base + CPMU_COUNTER_CFG_REG(hwc->idx));
                 ^
   drivers/cxl/cpmu.c:692:2: error: implicit declaration of function 'writeq' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           writeq(cfg, base + CPMU_COUNTER_CFG_REG(hwc->idx));
           ^
   drivers/cxl/cpmu.c:709:2: error: implicit declaration of function 'writeq' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           writeq(0, base + CPMU_EVENT_CAP_REG(idx));
           ^
   drivers/cxl/cpmu.c:761:15: error: implicit declaration of function 'readq' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           overflowed = readq(base + CPMU_OVERFLOW_REG);
                        ^
   drivers/cxl/cpmu.c:780:2: error: implicit declaration of function 'writeq' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           writeq(overflowed, base + CPMU_OVERFLOW_REG);
           ^
   1 warning and 12 errors generated.


vim +578 drivers/cxl/cpmu.c

   564	
   565	static void cpmu_pmu_disable(struct pmu *pmu)
   566	{
   567		struct cpmu_info *info = pmu_to_cpmu_info(pmu);
   568		void __iomem *base = info->base;
   569	
   570		if (info->freeze_for_enable) {
   571			/*
   572			 * Whilst bits above number of counters are RsvdZ
   573			 * they are unlikely to be repurposed given
   574			 * number of counters is allowed to be 64 leaving
   575			 * no reserved bits.  Hence this is only slightly
   576			 * naughty.
   577			 */
 > 578			writeq(GENMASK(63, 0), base + CPMU_FREEZE_REG);
   579			return;
   580		}
   581	}
   582	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
