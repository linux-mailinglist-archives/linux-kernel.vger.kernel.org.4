Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7FB5BB5F5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 05:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiIQDpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 23:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIQDo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 23:44:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47A53D5B2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 20:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663386297; x=1694922297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AC5wnii6Fg80ze8oiZurueSnr0pXH0g3PuvD0DaCL6s=;
  b=R3/kq+PX9bdY7prNUe1RIkUaEMpzN/YbliJpaHVp+XklyD+/v/Rv0FAD
   7mTEgLvhixSmatc20cpkGWMRG1b/OksxCi/2btkR9zMW90vJ/GvWcURvv
   TWqQ+Owg+qWs7zubhIJPCjVY75pPwlwwZ7/BZkWSCwtbDMBfoHgW9AeXc
   2oL8uPG8WKBQnfkYuP8zULAUSueoPQqbyezl9/J5bsf5mlnE37FEywtmq
   evexaNbQNnLV6Tv0oqdRTHCiCSh3lB7LZq9AC95jIGgldm3pvSkDkztnL
   +ScIEFpIHU2gHgfWWuVxcUFX2SRvr+ZIPGOpsGylnxJpOSFcuvyWso/4J
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="363082726"
X-IronPort-AV: E=Sophos;i="5.93,322,1654585200"; 
   d="scan'208";a="363082726"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 20:44:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,322,1654585200"; 
   d="scan'208";a="686363703"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Sep 2022 20:44:54 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZOlB-0002Ri-1V;
        Sat, 17 Sep 2022 03:44:53 +0000
Date:   Sat, 17 Sep 2022 11:44:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "brookxu.cn" <brookxu.cn@gmail.com>, robin.murphy@arm.com,
        joro@8bytes.org, will@kernel.org
Cc:     kbuild-all@lists.01.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/iova: using separate rcache for SAC and DAC
Message-ID: <202209171115.TzR7T0b4-lkp@intel.com>
References: <20220916154613.104965-1-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916154613.104965-1-brookxu.cn@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi brookxu.cn",

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v6.0-rc5]
[also build test ERROR on linus/master next-20220916]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/brookxu-cn/iommu-iova-using-separate-rcache-for-SAC-and-DAC/20220916-234845
base:    80e78fcce86de0288793a0ef0f6acf37656ee4cf
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220917/202209171115.TzR7T0b4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/fa50a31c6b74157cac20cd44b3717c19b934ff76
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review brookxu-cn/iommu-iova-using-separate-rcache-for-SAC-and-DAC/20220916-234845
        git checkout fa50a31c6b74157cac20cd44b3717c19b934ff76
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iommu/iova.c: In function 'iova_rcache_get':
>> drivers/iommu/iova.c:902:24: error: expected ';' before '}' token
     902 |         return iova_pfn
         |                        ^
         |                        ;
     903 | }
         | ~                       


vim +902 drivers/iommu/iova.c

   878	
   879	/*
   880	 * Try to satisfy IOVA allocation range from rcache.  Fail if requested
   881	 * size is too big or the DMA limit we are given isn't satisfied by the
   882	 * top element in the magazine.
   883	 */
   884	static unsigned long iova_rcache_get(struct iova_domain *iovad,
   885					     unsigned long size,
   886					     unsigned long limit_pfn)
   887	{
   888		unsigned int log_size = order_base_2(size);
   889		unsigned long iova_pfn;
   890		unsigned int index;
   891	
   892		if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE || !iovad->rcaches)
   893			return 0;
   894	
   895		iova_pfn = __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
   896	
   897		if (!iova_pfn && limit_pfn > DMA_BIT_MASK(32)) {
   898			index = log_size + IOVA_RANGE_CACHE_MAX_SIZE;
   899			iova_pfn = __iova_rcache_get(&iovad->rcaches[index], limit_pfn - size);
   900		}
   901	
 > 902		return iova_pfn
   903	}
   904	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
