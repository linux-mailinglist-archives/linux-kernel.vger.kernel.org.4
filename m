Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520C76BF97C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 11:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCRKZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 06:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjCRKZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 06:25:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A1A7292;
        Sat, 18 Mar 2023 03:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679135148; x=1710671148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QeuqZ4d2XSEH7Pd96Bs2l+zOIKCKzXxApnquS6nmsNM=;
  b=dK0DnTBPWmTXivxjdgov33MHaJKGoaaTfuITaljUZKi4B7aeFvU9Fea1
   absWlrlMPidx2N6SNUqkf8tsVvZ0/B7mJMiNJtrXdFnYS2QzN9uOLCjta
   MATtytwya5KoUm7HJsbYdZ2Ov02LK18jiFIWl8EJwoTGbbJQNG25GzdT/
   mxJpLEXt0VgtHiuz4yNZeO3WgYzyzshZLGcogYVSQiOfBok9UooOECfgH
   Mq4iujxwQblwKs0d01tk3fb/r7uQrzoqkKyqvwkx6ncQ27otVwRj3S1Kr
   0CUdPfZvKIH1Haru+yBCCSjvinOd9bTMSNiWg+ObcFbPFPGuzKijsb0R8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="318823489"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="318823489"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 03:25:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="804384418"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="804384418"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Mar 2023 03:25:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdTkr-000A0M-11;
        Sat, 18 Mar 2023 10:25:41 +0000
Date:   Sat, 18 Mar 2023 18:24:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        scclevenger@os.amperecomputing.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] coresight: etm4x: Change etm4_platform_driver driver
 for MMIO devices
Message-ID: <202303181800.KxbuwjRT-lkp@intel.com>
References: <20230317030501.1811905-5-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317030501.1811905-5-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on soc/for-next rafael-pm/linux-next linus/master v6.3-rc2 next-20230317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/coresight-etm4x-Allocate-and-device-assign-struct-etmv4_drvdata-earlier/20230317-110755
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230317030501.1811905-5-anshuman.khandual%40arm.com
patch subject: [PATCH 4/7] coresight: etm4x: Change etm4_platform_driver driver for MMIO devices
config: arm64-buildonly-randconfig-r002-20230312 (https://download.01.org/0day-ci/archive/20230318/202303181800.KxbuwjRT-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/f02ad9e7f97ab4fc1f90c7e6399004e9ec89ef26
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anshuman-Khandual/coresight-etm4x-Allocate-and-device-assign-struct-etmv4_drvdata-earlier/20230317-110755
        git checkout f02ad9e7f97ab4fc1f90c7e6399004e9ec89ef26
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hwtracing/coresight/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303181800.KxbuwjRT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwtracing/coresight/coresight-etm4x-core.c:2336:32: warning: unused variable 'etm4_dev_pm_ops' [-Wunused-const-variable]
   static const struct dev_pm_ops etm4_dev_pm_ops = {
                                  ^
   1 warning generated.


vim +/etm4_dev_pm_ops +2336 drivers/hwtracing/coresight/coresight-etm4x-core.c

  2335	
> 2336	static const struct dev_pm_ops etm4_dev_pm_ops = {
  2337		SET_RUNTIME_PM_OPS(etm4_runtime_suspend, etm4_runtime_resume, NULL)
  2338	};
  2339	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
