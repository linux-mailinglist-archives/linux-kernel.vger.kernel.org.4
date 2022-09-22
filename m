Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC215E5AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 07:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiIVFfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 01:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIVFfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 01:35:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FF3AE859;
        Wed, 21 Sep 2022 22:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663824905; x=1695360905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WbsPdoDDj+mIs1fxH99tKp0beojLYTi0zXyU5RR6UfY=;
  b=WhpWmG4zTXCAKqse5BdRGCXbjFzTHuOmAOW4AmR0mQamk97pWgUaYzU0
   VSeWqEIbAYdd/EBfafIgfqm6tH9ZvbX8/wzGklI3EQe/PV/z4CPsn4YxP
   JlxbeJl6quUNBM2SBFVRR8V5LWBinmb6d+NU7cV58CgIB0x3MtVx6rpVi
   b3OGNEAxKuEFCsyuXD9hzwj0EIaYPk3ucPGeo2jEplz2raUqOxqn6Lnzx
   azhFPOFIEPs/oCQuIVgbsS4GXxYgQ2r6Oc+/Yx7aOxaNVQVp6O6xouHX+
   /L/tlEF6uoMqhCZdobR56Wn5u0KK1LPtedOXqVHJABdoxT/CPT7PBAOtr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="326520943"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="326520943"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 22:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="762045591"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Sep 2022 22:35:02 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obErW-0004Ly-16;
        Thu, 22 Sep 2022 05:35:02 +0000
Date:   Thu, 22 Sep 2022 13:34:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Wei Yongjun <weiyongjun@huaweicloud.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: Introduce spi_get_device_match_data() helper
Message-ID: <202209221302.UKxElkNH-lkp@intel.com>
References: <20220921204520.23984-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921204520.23984-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on linus/master v6.0-rc6 next-20220921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/spi-Introduce-spi_get_device_match_data-helper/20220922-044658
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: s390-randconfig-s031-20220921 (https://download.01.org/0day-ci/archive/20220922/202209221302.UKxElkNH-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/4d7a10e29738f98137b08b2dcc0297535dd92a11
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/spi-Introduce-spi_get_device_match_data-helper/20220922-044658
        git checkout 4d7a10e29738f98137b08b2dcc0297535dd92a11
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi.c:367:40: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct device *dev @@     got struct device const * @@
   drivers/spi/spi.c:367:40: sparse:     expected struct device *dev
   drivers/spi/spi.c:367:40: sparse:     got struct device const *

vim +367 drivers/spi/spi.c

   362	
   363	const void *spi_get_device_match_data(const struct spi_device *sdev)
   364	{
   365		const void *match;
   366	
 > 367		match = device_get_match_data(&sdev->dev);
   368		if (match)
   369			return match;
   370	
   371		return (const void *)spi_get_device_id(sdev)->driver_data;
   372	}
   373	EXPORT_SYMBOL_GPL(spi_get_device_match_data);
   374	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
