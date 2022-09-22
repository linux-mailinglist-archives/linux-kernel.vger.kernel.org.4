Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589CC5E59B6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 05:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiIVDqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 23:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIVDqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 23:46:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229E2AB07B;
        Wed, 21 Sep 2022 20:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663818362; x=1695354362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1rOUWn5+Poqdr1KJIdzYBTSvCQo/efJbpeLzXjk66Kc=;
  b=cdilDlc//ywakJMtj27PGvgm6Ctut8T2Qvdv7d4t7sIrSICSyKIEUbjx
   X5Bcomn+owcwHL1KN0v00fafXwcf8oIPh3Un8aAqNOGyb3eNs+BaqpYqg
   nPB5I98+aPAoU7u/ksOAVYAajqPZ3DolITU5TVIwNVxxQZXSkzb7Fxnhn
   0ZzxVkZ8oSrXXNx1P47HW2FIBYh4L+Rjk+neDADzQWCpL/Onf/F63Wn+s
   qwWAdAYjOdU4td5xcG2BslNNY1ZH5hyKzwW7IyJQ0zatuZHeJJTCunv7Y
   7ohetUFbwfBkE7EB/QQTC13BH8ZY3vLF/ZogowGgAR6WKpSfNZqgAkNjR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="287267347"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="287267347"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 20:46:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="650348676"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Sep 2022 20:45:59 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obD9y-0004Fo-2G;
        Thu, 22 Sep 2022 03:45:58 +0000
Date:   Thu, 22 Sep 2022 11:45:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Wei Yongjun <weiyongjun@huaweicloud.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: Introduce spi_get_device_match_data() helper
Message-ID: <202209221154.aGU73pNV-lkp@intel.com>
References: <20220921204520.23984-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921204520.23984-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220922/202209221154.aGU73pNV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/4d7a10e29738f98137b08b2dcc0297535dd92a11
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/spi-Introduce-spi_get_device_match_data-helper/20220922-044658
        git checkout 4d7a10e29738f98137b08b2dcc0297535dd92a11
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/spi/spi.c: In function 'spi_get_device_match_data':
>> drivers/spi/spi.c:367:39: warning: passing argument 1 of 'device_get_match_data' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     367 |         match = device_get_match_data(&sdev->dev);
         |                                       ^~~~~~~~~~
   In file included from include/linux/of.h:22,
                    from include/linux/of_device.h:9,
                    from drivers/spi/spi.c:14:
   include/linux/property.h:390:50: note: expected 'struct device *' but argument is of type 'const struct device *'
     390 | const void *device_get_match_data(struct device *dev);
         |                                   ~~~~~~~~~~~~~~~^~~


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
