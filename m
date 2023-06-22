Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF82C73962E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 06:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjFVEKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 00:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjFVEKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 00:10:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C917CDD;
        Wed, 21 Jun 2023 21:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687407033; x=1718943033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OpwDpPau9AQnWP8p0KdWhexr5emxOCDtM5hNbv3OmHY=;
  b=UkzyzI8u1zgD7q/bApStxyDDvf1rSJpNawbGiAz9AGfVfJ7NawmhtS1R
   QIfnVOSZBTQnp8ENwnLA0B1QsTuwlc/sft0Bwon5KjMtDRV/dHVHuVTOL
   eQ09XXEOczMsMDAPSwT5RqI/QXmajYQNrwS70f2MJ3CFFLQijf4edmVG7
   Rm0pbPtdkSKLZbAYJfruy0jMmAh4k8WQIQ4TEsLE2hjy6RvuRkN32o41J
   ajIoWGu1kwwPyF74AQqNlo4DarozMUILumLw2OhfyfHkcmlkHzfhMzNz4
   p1mAZ27FIu6LgczZZmdxVFjC9hHCArwAXiLBpHbK28En0LFqJFN/jwipj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="360397917"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="360397917"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 21:10:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="804627027"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="804627027"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jun 2023 21:10:29 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCBeO-0007Jv-1j;
        Thu, 22 Jun 2023 04:10:28 +0000
Date:   Thu, 22 Jun 2023 12:10:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Besar Wicaksono <bwicaksono@nvidia.com>, suzuki.poulose@arm.com,
        robin.murphy@arm.com, ilkka@os.amperecomputing.com,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, vsethi@nvidia.com, rwiley@nvidia.com,
        efunsten@nvidia.com, Besar Wicaksono <bwicaksono@nvidia.com>
Subject: Re: [PATCH v4] perf: arm_cspmu: Separate Arm and vendor module
Message-ID: <202306221135.Z877Um2S-lkp@intel.com>
References: <20230620041438.32514-1-bwicaksono@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620041438.32514-1-bwicaksono@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Besar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ea8d1c062a0e876e999e4f347daeb598d5e677ab]

url:    https://github.com/intel-lab-lkp/linux/commits/Besar-Wicaksono/perf-arm_cspmu-Separate-Arm-and-vendor-module/20230620-121723
base:   ea8d1c062a0e876e999e4f347daeb598d5e677ab
patch link:    https://lore.kernel.org/r/20230620041438.32514-1-bwicaksono%40nvidia.com
patch subject: [PATCH v4] perf: arm_cspmu: Separate Arm and vendor module
config: arm64-randconfig-r011-20230621 (https://download.01.org/0day-ci/archive/20230622/202306221135.Z877Um2S-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230622/202306221135.Z877Um2S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306221135.Z877Um2S-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/perf/arm_cspmu/arm_cspmu.c:386:30: warning: no previous prototype for function 'arm_cspmu_impl_match_get' [-Wmissing-prototypes]
     386 | struct arm_cspmu_impl_match *arm_cspmu_impl_match_get(u32 pmiidr)
         |                              ^
   drivers/perf/arm_cspmu/arm_cspmu.c:386:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     386 | struct arm_cspmu_impl_match *arm_cspmu_impl_match_get(u32 pmiidr)
         | ^
         | static 
   1 warning generated.


vim +/arm_cspmu_impl_match_get +386 drivers/perf/arm_cspmu/arm_cspmu.c

   385	
 > 386	struct arm_cspmu_impl_match *arm_cspmu_impl_match_get(u32 pmiidr)
   387	{
   388		struct arm_cspmu_impl_match *match = impl_match;
   389	
   390		for (; match->pmiidr_val; match++) {
   391			u32 mask = match->pmiidr_mask;
   392	
   393			if ((match->pmiidr_val & mask) == (pmiidr & mask))
   394				break;
   395		}
   396	
   397		return match;
   398	}
   399	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
