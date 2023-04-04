Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2A56D5944
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbjDDHOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjDDHOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:14:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA7A1FCB;
        Tue,  4 Apr 2023 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680592446; x=1712128446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fs9ICErJMuFJLYufHC7Tzkwk+zfF6AjFHSEBP32HYIQ=;
  b=FFcT8NS1HD8ffmZGmtHqmF8pzb6Madfc3uYZzdzNr/hfyIwhJjcK3Brc
   mp/8HCaYzuhwDJ0aeQSTrYAs2c4p+sQxZjlSdxOWWug6+7GeHwHYKefaP
   jFohYRkeMWoKwyKyPML0hoFlU6A8UVzg7cwNPOo0mxUNMr+0+xI1ZuaJ5
   N4IltE5Ldk0KU6GrzcjjcwVDOPM0oU9T6hrQsguaEQmq+54DFuycDI3ge
   3Ny/UtANj5DBxigp4ByIVXgAZGjakzkRULXtg0/1rya4krgNvOoFpO4Vy
   rqreiM7X+N7l8TscIyS0W7M8uUgNrIrxax/e74hd5yuuxcFOShbc4NDzH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="428396687"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="428396687"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 00:14:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="679784416"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="679784416"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 04 Apr 2023 00:13:59 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjare-000PJV-2r;
        Tue, 04 Apr 2023 07:13:58 +0000
Date:   Tue, 4 Apr 2023 15:13:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brian Masney <bmasney@redhat.com>, jic23@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        andriy.shevchenko@linux.intel.com, trix@redhat.com,
        lars@metafoo.de, nathan@kernel.org, ndesaulniers@google.com,
        u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hslester96@gmail.com
Subject: Re: [PATCH] iio: light: tsl2772: fix reading proximity-diodes from
 device tree
Message-ID: <202304041451.gj8oasQp-lkp@intel.com>
References: <20230404011455.339454-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404011455.339454-1-bmasney@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.3-rc5 next-20230403]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Brian-Masney/iio-light-tsl2772-fix-reading-proximity-diodes-from-device-tree/20230404-091630
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20230404011455.339454-1-bmasney%40redhat.com
patch subject: [PATCH] iio: light: tsl2772: fix reading proximity-diodes from device tree
config: x86_64-randconfig-a001-20230403 (https://download.01.org/0day-ci/archive/20230404/202304041451.gj8oasQp-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9701bd10d6409568197894b603f8a1e23280e82b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Brian-Masney/iio-light-tsl2772-fix-reading-proximity-diodes-from-device-tree/20230404-091630
        git checkout 9701bd10d6409568197894b603f8a1e23280e82b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iio/light/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304041451.gj8oasQp-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/light/tsl2772.c:599:30: error: use of undeclared identifier 'prox_diode_mask'; did you mean 'protnone_mask'?
           chip->settings.prox_diode = prox_diode_mask;
                                       ^~~~~~~~~~~~~~~
                                       protnone_mask
   arch/x86/include/asm/pgtable-invert.h:22:19: note: 'protnone_mask' declared here
   static inline u64 protnone_mask(u64 val)
                     ^
   1 error generated.


vim +599 drivers/iio/light/tsl2772.c

   572	
   573	static int tsl2772_read_prox_diodes(struct tsl2772_chip *chip)
   574	{
   575		struct device *dev = &chip->client->dev;
   576		int i, ret, num_leds;
   577		u32 leds[TSL2772_MAX_PROX_LEDS];
   578	
   579		ret = device_property_count_u32(dev, "amstaos,proximity-diodes");
   580		if (ret < 0)
   581			return ret;
   582	
   583		num_leds = ret;
   584		if (num_leds > TSL2772_MAX_PROX_LEDS)
   585			num_leds = TSL2772_MAX_PROX_LEDS;
   586	
   587		ret = device_property_read_u32_array(dev, "amstaos,proximity-diodes", leds, num_leds);
   588		if (ret < 0) {
   589			dev_err(dev, "Invalid value for amstaos,proximity-diodes: %d.\n", ret);
   590			return ret;
   591		}
   592	
   593		for (i = 0; i < num_leds; i++) {
   594			if (leds[i] > 1) {
   595				dev_err(dev, "Invalid value %d in amstaos,proximity-diodes.\n", leds[i]);
   596				return -EINVAL;
   597			}
   598		}
 > 599		chip->settings.prox_diode = prox_diode_mask;
   600	
   601		return 0;
   602	}
   603	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
