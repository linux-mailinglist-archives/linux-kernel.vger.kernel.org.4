Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D6F6D5C86
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjDDJ7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjDDJ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:59:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E8319AE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680602354; x=1712138354;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f+D9g1sJGIOu1PYzQaGk2mKCjNZyVU3MRgwwfSUyE38=;
  b=aRpN7LCiVj1gII9gDtRbsb5zehdPJRSuItUYUyxuw2fGdkUkDs9gGOhC
   z4Npo2eJWq3gvJ5zzf4CmHn4oWriotsHL0moCZPE9dGwHAsc3TDKPtCQu
   TDSEwhX9AZ2SOLtEUoMiW2U7S/wITqWfc+Ph56Iv9a8GCD7SqrigTqrm/
   un/yMLhTuK9iOi5dOh3tUnnWgZFouZBnpsiDe7xZiCfAHI3KfwtVhJjIo
   SBRPz5prG+7qIAtlquNoLbe8Jjdu2iTd8DCdlHUx3d943XXPSSuMrd2uL
   9NMbD8eSifv8u/P9mFT0S6alJL2OVXrOVxcrAQ22Jwz1kWU5xb6DRonHc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="407199922"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="407199922"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 02:59:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="750861004"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="750861004"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Apr 2023 02:59:11 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjdRX-000PW6-0Q;
        Tue, 04 Apr 2023 09:59:11 +0000
Date:   Tue, 4 Apr 2023 17:58:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-s3c/gpio-samsung.c:50:16: sparse: sparse: restricted
 samsung_gpio_pull_t degrades to integer
Message-ID: <202304041709.uB1P0uVI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   148341f0a2f53b5e8808d093333d85170586a15d
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   1 year ago
config: arm-randconfig-s031-20230403 (https://download.01.org/0day-ci/archive/20230404/202304041709.uB1P0uVI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-s3c/ drivers/irqchip/ drivers/scsi/ drivers/video/fbdev/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304041709.uB1P0uVI-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arm/mach-s3c/gpio-samsung.c:50:16: sparse: sparse: restricted samsung_gpio_pull_t degrades to integer
   arch/arm/mach-s3c/gpio-samsung.c:74:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted samsung_gpio_pull_t [usertype] pull @@     got int @@
   arch/arm/mach-s3c/gpio-samsung.c:74:22: sparse:     expected restricted samsung_gpio_pull_t [usertype] pull
   arch/arm/mach-s3c/gpio-samsung.c:74:22: sparse:     got int
   arch/arm/mach-s3c/gpio-samsung.c:80:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted samsung_gpio_pull_t [assigned] [usertype] pull @@     got int @@
   arch/arm/mach-s3c/gpio-samsung.c:80:22: sparse:     expected restricted samsung_gpio_pull_t [assigned] [usertype] pull
   arch/arm/mach-s3c/gpio-samsung.c:80:22: sparse:     got int
   arch/arm/mach-s3c/gpio-samsung.c:93:17: sparse: sparse: restricted samsung_gpio_pull_t degrades to integer
   arch/arm/mach-s3c/gpio-samsung.c:93:17: sparse: sparse: restricted samsung_gpio_pull_t degrades to integer
   arch/arm/mach-s3c/gpio-samsung.c:93:17: sparse: sparse: restricted samsung_gpio_pull_t degrades to integer
   arch/arm/mach-s3c/gpio-samsung.c:1301:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] pup @@     got restricted samsung_gpio_pull_t @@
   arch/arm/mach-s3c/gpio-samsung.c:1301:21: sparse:     expected unsigned int [usertype] pup
   arch/arm/mach-s3c/gpio-samsung.c:1301:21: sparse:     got restricted samsung_gpio_pull_t
--
   drivers/irqchip/irq-gic.c:1177:44: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __percpu *[noderef] __iomem *percpu_base @@     got void [noderef] __iomem *[noderef] __percpu * @@
   drivers/irqchip/irq-gic.c:1177:44: sparse:     expected void [noderef] __percpu *[noderef] __iomem *percpu_base
   drivers/irqchip/irq-gic.c:1177:44: sparse:     got void [noderef] __iomem *[noderef] __percpu *
   drivers/irqchip/irq-gic.c:1178:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __percpu *[noderef] __iomem *percpu_base @@     got void [noderef] __iomem *[noderef] __percpu * @@
   drivers/irqchip/irq-gic.c:1178:43: sparse:     expected void [noderef] __percpu *[noderef] __iomem *percpu_base
   drivers/irqchip/irq-gic.c:1178:43: sparse:     got void [noderef] __iomem *[noderef] __percpu *
   drivers/irqchip/irq-gic.c:1189:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:1189:26: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:1189:26: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:1189:71: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __percpu * @@     got void [noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:1189:71: sparse:     expected void [noderef] __percpu *
   drivers/irqchip/irq-gic.c:1189:71: sparse:     got void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:1191:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:1191:26: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:1191:26: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:1191:70: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __percpu * @@     got void [noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:1191:70: sparse:     expected void [noderef] __percpu *
   drivers/irqchip/irq-gic.c:1191:70: sparse:     got void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:1257:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got void [noderef] __percpu *[noderef] __iomem *percpu_base @@
   drivers/irqchip/irq-gic.c:1257:43: sparse:     expected void [noderef] __percpu *__pdata
   drivers/irqchip/irq-gic.c:1257:43: sparse:     got void [noderef] __percpu *[noderef] __iomem *percpu_base
   drivers/irqchip/irq-gic.c:1258:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got void [noderef] __percpu *[noderef] __iomem *percpu_base @@
   drivers/irqchip/irq-gic.c:1258:42: sparse:     expected void [noderef] __percpu *__pdata
   drivers/irqchip/irq-gic.c:1258:42: sparse:     got void [noderef] __percpu *[noderef] __iomem *percpu_base
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: too many warnings

vim +50 arch/arm/mach-s3c/gpio-samsung.c

1b39d5f2cc5c28 drivers/gpio/gpio-samsung.c Kukjin Kim 2011-08-30  40  
1b39d5f2cc5c28 drivers/gpio/gpio-samsung.c Kukjin Kim 2011-08-30  41  int samsung_gpio_setpull_updown(struct samsung_gpio_chip *chip,
1b39d5f2cc5c28 drivers/gpio/gpio-samsung.c Kukjin Kim 2011-08-30  42  				unsigned int off, samsung_gpio_pull_t pull)
1b39d5f2cc5c28 drivers/gpio/gpio-samsung.c Kukjin Kim 2011-08-30  43  {
1b39d5f2cc5c28 drivers/gpio/gpio-samsung.c Kukjin Kim 2011-08-30  44  	void __iomem *reg = chip->base + 0x08;
1b39d5f2cc5c28 drivers/gpio/gpio-samsung.c Kukjin Kim 2011-08-30  45  	int shift = off * 2;
1b39d5f2cc5c28 drivers/gpio/gpio-samsung.c Kukjin Kim 2011-08-30  46  	u32 pup;
1b39d5f2cc5c28 drivers/gpio/gpio-samsung.c Kukjin Kim 2011-08-30  47  
1b39d5f2cc5c28 drivers/gpio/gpio-samsung.c Kukjin Kim 2011-08-30  48  	pup = __raw_readl(reg);
1b39d5f2cc5c28 drivers/gpio/gpio-samsung.c Kukjin Kim 2011-08-30  49  	pup &= ~(3 << shift);
1b39d5f2cc5c28 drivers/gpio/gpio-samsung.c Kukjin Kim 2011-08-30 @50  	pup |= pull << shift;
1b39d5f2cc5c28 drivers/gpio/gpio-samsung.c Kukjin Kim 2011-08-30  51  	__raw_writel(pup, reg);
1b39d5f2cc5c28 drivers/gpio/gpio-samsung.c Kukjin Kim 2011-08-30  52  
1b39d5f2cc5c28 drivers/gpio/gpio-samsung.c Kukjin Kim 2011-08-30  53  	return 0;
1b39d5f2cc5c28 drivers/gpio/gpio-samsung.c Kukjin Kim 2011-08-30  54  }
1b39d5f2cc5c28 drivers/gpio/gpio-samsung.c Kukjin Kim 2011-08-30  55  

:::::: The code at line 50 was first introduced by commit
:::::: 1b39d5f2cc5c28085bbf48db80bf704ab4dedda9 gpio/samsung: gpio-samsung.c to support Samsung GPIOs

:::::: TO: Kukjin Kim <kgene.kim@samsung.com>
:::::: CC: Kukjin Kim <kgene.kim@samsung.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
