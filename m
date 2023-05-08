Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2DC6FB595
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjEHQxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbjEHQxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:53:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE99524D;
        Mon,  8 May 2023 09:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683564820; x=1715100820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q2FPM/ehx2oD4Wdgi1gDVni1vUmU7yPsYNS1QfCOiJ0=;
  b=EoJgtQ5IISjon7EP99x2cIbaytYPDPsuq3cZkWPdiLGYPbzB8TbPVfOc
   2GgDp8iMXCML0p9dz11YwGhdyr+SbSpSjmfXSYKgLLxcv8AikAbkv/25j
   gYEQxDo5JOCgWMSk5dO0hB6VHShLSlI2+mewZBw46hjNA2dcRKwz+DbHL
   KSRK2tuyUgc0tmaE2cJYsaYNNrAvxG/spufpdJqw3ZaMt2InrIghVkx6V
   UYXGezlNlObel96YmPBLFEfSVg9mO9HvFaOCRA+3YL95ZguUcl1XzQN36
   BjRgxb5jtciHrblOlFOqEwj//61ncbXaelq26lSizjhRoYr/xvh+HgC7q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="352759426"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="352759426"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 09:53:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="692667111"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="692667111"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 May 2023 09:53:38 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pw47E-0001KH-2k;
        Mon, 08 May 2023 16:53:36 +0000
Date:   Tue, 9 May 2023 00:52:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Astrid Rost <astrid.rost@axis.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, kernel@axis.com,
        Astrid Rost <astridr@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/7] iio: light: vcnl4000: Add als_it for vcnl4040/4200
Message-ID: <202305090056.mwp6jijk-lkp@intel.com>
References: <20230508070925.2123265-4-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508070925.2123265-4-astrid.rost@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Astrid,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.4-rc1 next-20230508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Astrid-Rost/iio-light-vcnl4000-Add-proximity-ps_it-for-vcnl4200/20230508-161005
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20230508070925.2123265-4-astrid.rost%40axis.com
patch subject: [PATCH v1 3/7] iio: light: vcnl4000: Add als_it for vcnl4040/4200
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20230509/202305090056.mwp6jijk-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6ff2e1cf084f5b3038f2d72110fb01f2a8353a34
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Astrid-Rost/iio-light-vcnl4000-Add-proximity-ps_it-for-vcnl4200/20230508-161005
        git checkout 6ff2e1cf084f5b3038f2d72110fb01f2a8353a34
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305090056.mwp6jijk-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__divdi3" [drivers/iio/light/vcnl4000.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
