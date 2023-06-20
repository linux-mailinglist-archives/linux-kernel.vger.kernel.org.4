Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7255E736923
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjFTKXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjFTKWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:22:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1A61FF2;
        Tue, 20 Jun 2023 03:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687256543; x=1718792543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RyZhsxOk7rJShqq7JUiZU4HJzC9GOQ4nijC5s3cKFlw=;
  b=Nk87oqI8L3B+aUuc3AUYqbHfceOcfc3U8LMK0WdEHu0qiiDHQX1gzkSF
   hiDW2yvuRqnlCJ2D454CTy2vdRzBRUGsPYFRv/Owq4vlyy48rF3GiHghJ
   XqO4Qm1Ih5SSC2J915yofI6q9CpGzr3XsseMJcK12/8TpuXBOLnsEG+V0
   Z//LkkidKD5D99ghNqUDZFH5xdmLVqo5nI5nuAPZPI4yoi0kNvYw7oLDh
   OjHHT0qasw2YjLbqJt3Hr69ZFaKRFlCxqzw6X83oKKx2DMzG4YXiEbwtR
   TBhoC+pB24HN7IaNq+RSoi/7KbsYTLSDQI8kNypO8iXkjDCNobgyMKy39
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="423487002"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="423487002"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:22:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="779368241"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="779368241"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jun 2023 03:22:11 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBYV0-0005ns-2j;
        Tue, 20 Jun 2023 10:22:10 +0000
Date:   Tue, 20 Jun 2023 18:21:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Besar Wicaksono <bwicaksono@nvidia.com>, suzuki.poulose@arm.com,
        robin.murphy@arm.com, ilkka@os.amperecomputing.com,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com
Cc:     oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, vsethi@nvidia.com, rwiley@nvidia.com,
        efunsten@nvidia.com, Besar Wicaksono <bwicaksono@nvidia.com>
Subject: Re: [PATCH v4] perf: arm_cspmu: Separate Arm and vendor module
Message-ID: <202306201854.S2tjTpWE-lkp@intel.com>
References: <20230620041438.32514-1-bwicaksono@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620041438.32514-1-bwicaksono@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230620/202306201854.S2tjTpWE-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230620/202306201854.S2tjTpWE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306201854.S2tjTpWE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/perf/arm_cspmu/arm_cspmu.c:386:30: warning: no previous prototype for 'arm_cspmu_impl_match_get' [-Wmissing-prototypes]
     386 | struct arm_cspmu_impl_match *arm_cspmu_impl_match_get(u32 pmiidr)
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~


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
