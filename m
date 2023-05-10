Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0836FE814
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbjEJXX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbjEJXXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:23:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F48E45
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 16:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683761033; x=1715297033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=owMYhO0s+rr/YtNogvkkYbl04vO/j6AuZPt0IqqsS30=;
  b=jaD18d923SlYHOzSFEz1QLnweMCiE9OKvUYAqC1p2kUBOZFG0rCsyJOu
   DISZI7CBuzTrUqr0S9HQOEHEjchGyuI7Pb64XZZXa/Hjgwacv3tSBcoF7
   qA7++DFxQqnEGAp3YaUICh1lFY8XpiEV8C5EY8R4z1YOamr1qLaVECIvr
   ylwlnwHPblbsf2PvUGeZ4LmL08Fje9LH3w6/UGVTR8kgIb7/549yyGgVK
   i3sMPZ1x6C+5SqxcRlQfGeHt1/8dxGzE3O3I+tHe6EYbUAPir1Ya151P0
   lu3DMbAWSgomI3NjXDLS2tqgkeQnUCUKOj3rCyz0atB5mZqmKuNv7nrY2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="353428232"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="353428232"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 16:23:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="699481227"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="699481227"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 May 2023 16:23:49 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwt9w-0003ea-2Q;
        Wed, 10 May 2023 23:23:48 +0000
Date:   Thu, 11 May 2023 07:23:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Shavit <mshavit@google.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     oe-kbuild-all@lists.linux.dev, Michael Shavit <mshavit@google.com>,
        jean-philippe@linaro.org, nicolinc@nvidia.com, jgg@nvidia.com,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] iommu/arm-smmu-v3: Keep track of attached ssids
Message-ID: <202305110736.wdeuqPAi-lkp@intel.com>
References: <20230510205054.2667898-5-mshavit@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510205054.2667898-5-mshavit@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.4-rc1]
[also build test WARNING on linus/master next-20230510]
[cannot apply to joro-iommu/next arm-perf/for-next/perf]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Shavit/iommu-arm-smmu-v3-Move-cdtable-to-arm_smmu_master/20230511-045514
base:   ac9a78681b921877518763ba0e89202254349d1b
patch link:    https://lore.kernel.org/r/20230510205054.2667898-5-mshavit%40google.com
patch subject: [PATCH v1 4/5] iommu/arm-smmu-v3: Keep track of attached ssids
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230511/202305110736.wdeuqPAi-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2172fed7450d1bb8518b86b2b7113a1e42b4d456
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Michael-Shavit/iommu-arm-smmu-v3-Move-cdtable-to-arm_smmu_master/20230511-045514
        git checkout 2172fed7450d1bb8518b86b2b7113a1e42b4d456
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/iommu/arm/arm-smmu-v3/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305110736.wdeuqPAi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1857:5: warning: no previous prototype for 'arm_smmu_atc_inv_domain' [-Wmissing-prototypes]
    1857 | int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
         |     ^~~~~~~~~~~~~~~~~~~~~~~


vim +/arm_smmu_atc_inv_domain +1857 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

  1856	
> 1857	int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
  1858				    unsigned long iova, size_t size)
  1859	{
  1860		return arm_smmu_atc_inv_domain_ssid(smmu_domain, 0, iova, size);
  1861	}
  1862	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
