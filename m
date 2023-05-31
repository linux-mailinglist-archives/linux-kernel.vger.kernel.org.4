Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA277173F8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjEaC7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjEaC7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:59:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D6310B;
        Tue, 30 May 2023 19:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685501940; x=1717037940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BALmWeeuedFL0DVbHkciqCqCoX3nMmYQLv8f1PS7hc8=;
  b=JHDtSqH+NTDhC1i5kPNP2xt4iuz/N9gWd1XZ+lRuqhRENlUwXzETW7en
   MP47chDRAVAQyHjarYERRRreifZSuRXJ1JTldozhPFGVgaboJixGbJ0fY
   u46V+S00JxFaEDX96q87+n9QY8Gpka9wuxP7gwb/hURZEVeCNqEYBT8vc
   HkDdDRmEaA2sxf9iF0x57zjJc4NBhf9FTPB9/jjo9YwIZe0XUi7rTuGsF
   q6AmGXPjrxH8e7J1Cu7wsdnWefGj8LIImoju3fcHsqkYVUcWFqgUIxRkp
   lLVWWNk/uEcC/XYjEANmMcV4PWewT8in98IRA/DpaoAtgByqK5dK6lXNx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="335465190"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="335465190"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 19:59:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="953432382"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="953432382"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 May 2023 19:58:55 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4C35-00011j-0T;
        Wed, 31 May 2023 02:58:55 +0000
Date:   Wed, 31 May 2023 10:58:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: Re: [PATCH v3 1/7] driver/perf: Add identifier sysfs file for CMN
Message-ID: <202305311005.YR2SisSe-lkp@intel.com>
References: <1685438374-33287-2-git-send-email-renyu.zj@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685438374-33287-2-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jing,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/perf/core]
[also build test WARNING on acme/perf/core arm-perf/for-next/perf linus/master v6.4-rc4 next-20230530]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jing-Zhang/driver-perf-Add-identifier-sysfs-file-for-CMN/20230530-172139
base:   tip/perf/core
patch link:    https://lore.kernel.org/r/1685438374-33287-2-git-send-email-renyu.zj%40linux.alibaba.com
patch subject: [PATCH v3 1/7] driver/perf: Add identifier sysfs file for CMN
config: hexagon-buildonly-randconfig-r006-20230530 (https://download.01.org/0day-ci/archive/20230531/202305311005.YR2SisSe-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c7483d062f1b91e98b028fa720b8a98b94ec9bc5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jing-Zhang/driver-perf-Add-identifier-sysfs-file-for-CMN/20230530-172139
        git checkout c7483d062f1b91e98b028fa720b8a98b94ec9bc5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/perf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305311005.YR2SisSe-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/perf/arm-cmn.c:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/perf/arm-cmn.c:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/perf/arm-cmn.c:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/perf/arm-cmn.c:2379:41: warning: unused variable 'arm_cmn600_data' [-Wunused-const-variable]
   static const struct arm_cmn_device_data arm_cmn600_data = {
                                           ^
>> drivers/perf/arm-cmn.c:2384:41: warning: unused variable 'arm_cmn650_data' [-Wunused-const-variable]
   static const struct arm_cmn_device_data arm_cmn650_data = {
                                           ^
>> drivers/perf/arm-cmn.c:2389:41: warning: unused variable 'arm_cmn700_data' [-Wunused-const-variable]
   static const struct arm_cmn_device_data arm_cmn700_data = {
                                           ^
>> drivers/perf/arm-cmn.c:2394:41: warning: unused variable 'arm_ci700_data' [-Wunused-const-variable]
   static const struct arm_cmn_device_data arm_ci700_data = {
                                           ^
   10 warnings generated.


vim +/arm_cmn600_data +2379 drivers/perf/arm-cmn.c

  2378	
> 2379	static const struct arm_cmn_device_data arm_cmn600_data = {
  2380		.model_name = "arm_cmn600",
  2381		.model = CMN600
  2382	};
  2383	
> 2384	static const struct arm_cmn_device_data arm_cmn650_data = {
  2385		.model_name = "arm_cmn650",
  2386		.model = CMN650
  2387	};
  2388	
> 2389	static const struct arm_cmn_device_data arm_cmn700_data = {
  2390		.model_name = "arm_cmn700",
  2391		.model = CMN700
  2392	};
  2393	
> 2394	static const struct arm_cmn_device_data arm_ci700_data = {
  2395		.model_name = "arm_ci700",
  2396		.model = CI700
  2397	};
  2398	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
