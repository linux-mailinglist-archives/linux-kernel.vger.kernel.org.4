Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAE5736930
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjFTKYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjFTKXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:23:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E47A19AB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 03:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687256591; x=1718792591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ZYsZOvfPxA0b3dXDGRauovDUG8AX9HxRyYI5k76mgY=;
  b=XA0JbBcg/3sRGFFK66ESewd7LKf/eNmWW2MSQuskrygZuKJc0q8Bsyx6
   K43XlxDb4y+KyAnNkEquUxwEq77Hu6XFAN+6rVHlfarQDyO0B4v/nNA8J
   58DiawNi3+WjtVMcT4l809gmdn5iYCq3ndWiDSBLDynU6F/+z2k9DeGaS
   2NNshG93bMHZ3Fx7t4qTnyDZYZaxfNIHE8oYGS5OIEnEJ88M4vzUS4jr3
   ONe5inF1Wo4o4tWaLQ6iuV/Qyg1M5OezTMt1/3IvCG7IrlfvII6q0Qf3e
   2jiHVAOrE137Y1Bn5v4L/JSAY5JHnPcEucR4vOy1gKie8v+OrqkA5Tk5K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="339432945"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="339432945"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:22:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="826937107"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="826937107"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jun 2023 03:22:11 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBYV0-0005nu-2o;
        Tue, 20 Jun 2023 10:22:10 +0000
Date:   Tue, 20 Jun 2023 18:21:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Shavit <mshavit@google.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     oe-kbuild-all@lists.linux.dev, Michael Shavit <mshavit@google.com>,
        jean-philippe@linaro.org, nicolinc@nvidia.com, jgg@nvidia.com,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/13] iommu/arm-smmu-v3: Keep track of attached ssids
Message-ID: <202306201817.Cn7Xxzds-lkp@intel.com>
References: <20230614154304.2860121-8-mshavit@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614154304.2860121-8-mshavit@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b6dad5178ceaf23f369c3711062ce1f2afc33644]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Shavit/iommu-arm-smmu-v3-Move-ctx_desc-out-of-s1_cfg/20230614-234725
base:   b6dad5178ceaf23f369c3711062ce1f2afc33644
patch link:    https://lore.kernel.org/r/20230614154304.2860121-8-mshavit%40google.com
patch subject: [PATCH v3 07/13] iommu/arm-smmu-v3: Keep track of attached ssids
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230620/202306201817.Cn7Xxzds-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230620/202306201817.Cn7Xxzds-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306201817.Cn7Xxzds-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1863:5: warning: no previous prototype for 'arm_smmu_atc_inv_domain' [-Wmissing-prototypes]
    1863 | int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: In function 'arm_smmu_attach_dev':
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2456:31: error: 'struct arm_smmu_master' has no member named 'domain'
    2456 |                         master->domain = NULL;
         |                               ^~


vim +/arm_smmu_atc_inv_domain +1863 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

  1862	
> 1863	int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
  1864				    unsigned long iova, size_t size)
  1865	{
  1866		return arm_smmu_atc_inv_domain_ssid(smmu_domain, 0, iova, size);
  1867	}
  1868	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
